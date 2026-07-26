-- Auth security hardening (Phase 2 inspection)
-- - Immutable profiles.role
-- - Care links / invite codes: authenticated SELECT only (writes via Edge + service_role)
-- - primary_provider_id server-managed
-- - Atomic redeem / confirm RPCs (service_role)
-- - Redeem attempt throttling

-- ---------------------------------------------------------------------------
-- 1) profiles.role immutable after insert
-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.profiles_role_immutable()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  IF NEW.role IS DISTINCT FROM OLD.role THEN
    RAISE EXCEPTION 'profiles.role is immutable after create';
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_profiles_role_immutable ON public.profiles;
CREATE TRIGGER trg_profiles_role_immutable
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.profiles_role_immutable();

-- ---------------------------------------------------------------------------
-- 2) patient_details.primary_provider_id — server-managed only
-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.patient_details_protect_primary_provider()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
  -- service_role / backend: auth.uid() is null; allow cache updates from Edge.
  IF auth.uid() IS NOT NULL
     AND NEW.primary_provider_id IS DISTINCT FROM OLD.primary_provider_id THEN
    RAISE EXCEPTION 'primary_provider_id is server-managed';
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_patient_details_protect_primary ON public.patient_details;
CREATE TRIGGER trg_patient_details_protect_primary
  BEFORE UPDATE ON public.patient_details
  FOR EACH ROW
  EXECUTE FUNCTION public.patient_details_protect_primary_provider();

-- ---------------------------------------------------------------------------
-- 3) Lock down invite_codes + patient_care_links client writes
-- ---------------------------------------------------------------------------

DROP POLICY IF EXISTS invite_codes_insert_own ON public.invite_codes;
DROP POLICY IF EXISTS invite_codes_update_own ON public.invite_codes;
DROP POLICY IF EXISTS invite_codes_delete_own ON public.invite_codes;

DROP POLICY IF EXISTS care_links_insert_as_provider ON public.patient_care_links;
DROP POLICY IF EXISTS care_links_insert_as_patient ON public.patient_care_links;
DROP POLICY IF EXISTS care_links_update_as_patient ON public.patient_care_links;
DROP POLICY IF EXISTS care_links_update_as_provider ON public.patient_care_links;

-- SELECT policies remain (issuer / participants).

-- ---------------------------------------------------------------------------
-- 4) Optional uniqueness: one invite_code_id per care link
-- ---------------------------------------------------------------------------

CREATE UNIQUE INDEX IF NOT EXISTS uq_care_links_invite_code_id
  ON public.patient_care_links (invite_code_id)
  WHERE invite_code_id IS NOT NULL;

-- ---------------------------------------------------------------------------
-- 5) Redeem attempt throttle table
-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.invite_redeem_attempts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    attempted_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE INDEX IF NOT EXISTS idx_invite_redeem_attempts_patient_time
  ON public.invite_redeem_attempts (patient_id, attempted_at DESC);

ALTER TABLE public.invite_redeem_attempts ENABLE ROW LEVEL SECURITY;
-- No authenticated policies → deny-by-default for clients. service_role bypasses.

-- ---------------------------------------------------------------------------
-- 6) Atomic RPCs (service_role only)
-- ---------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION public.redeem_invite_code_as(
  p_patient_id UUID,
  p_code TEXT
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_role TEXT;
  v_recent INT;
  v_invite public.invite_codes%ROWTYPE;
  v_link public.patient_care_links%ROWTYPE;
  v_now TIMESTAMPTZ := TIMEZONE('utc', NOW());
BEGIN
  SELECT role INTO v_role FROM public.profiles WHERE id = p_patient_id;
  IF v_role IS DISTINCT FROM 'PATIENT' THEN
    RAISE EXCEPTION 'forbidden';
  END IF;

  INSERT INTO public.invite_redeem_attempts (patient_id) VALUES (p_patient_id);

  SELECT COUNT(*)::INT INTO v_recent
  FROM public.invite_redeem_attempts
  WHERE patient_id = p_patient_id
    AND attempted_at > v_now - INTERVAL '15 minutes';

  IF v_recent > 20 THEN
    RAISE EXCEPTION 'rate_limited';
  END IF;

  IF p_code IS NULL OR p_code !~ '^[0-9]{6}$' THEN
    RAISE EXCEPTION 'invite_invalid';
  END IF;

  UPDATE public.invite_codes
  SET consumed_at = v_now
  WHERE code = p_code
    AND consumed_at IS NULL
    AND expires_at > v_now
  RETURNING * INTO v_invite;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'invite_invalid';
  END IF;

  INSERT INTO public.patient_care_links (
    patient_id,
    provider_id,
    invite_code_id,
    status,
    patient_confirmed_at
  ) VALUES (
    p_patient_id,
    v_invite.provider_id,
    v_invite.id,
    'pending',
    v_now
  )
  RETURNING * INTO v_link;

  RETURN jsonb_build_object(
    'id', v_link.id,
    'status', v_link.status,
    'patient_id', v_link.patient_id,
    'provider_id', v_link.provider_id
  );
EXCEPTION
  WHEN unique_violation THEN
    RAISE EXCEPTION 'care_link_exists';
END;
$$;

CREATE OR REPLACE FUNCTION public.confirm_care_link_as(
  p_actor_id UUID,
  p_link_id UUID,
  p_action TEXT
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_link public.patient_care_links%ROWTYPE;
  v_now TIMESTAMPTZ := TIMEZONE('utc', NOW());
  v_is_patient BOOLEAN;
  v_is_provider BOOLEAN;
  v_updated public.patient_care_links%ROWTYPE;
BEGIN
  IF p_action NOT IN ('confirm', 'reject') THEN
    RAISE EXCEPTION 'bad_action';
  END IF;

  SELECT * INTO v_link
  FROM public.patient_care_links
  WHERE id = p_link_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'not_found';
  END IF;

  v_is_patient := v_link.patient_id = p_actor_id;
  v_is_provider := v_link.provider_id = p_actor_id;
  IF NOT v_is_patient AND NOT v_is_provider THEN
    RAISE EXCEPTION 'forbidden';
  END IF;

  IF v_link.status IS DISTINCT FROM 'pending' THEN
    RAISE EXCEPTION 'not_pending';
  END IF;

  IF p_action = 'reject' THEN
    UPDATE public.patient_care_links
    SET status = 'rejected'
    WHERE id = p_link_id
      AND status = 'pending'
    RETURNING * INTO v_updated;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'not_pending';
    END IF;
  ELSE
    UPDATE public.patient_care_links
    SET
      patient_confirmed_at = CASE
        WHEN v_is_patient THEN v_now
        ELSE patient_confirmed_at
      END,
      provider_confirmed_at = CASE
        WHEN v_is_provider THEN v_now
        ELSE provider_confirmed_at
      END,
      status = CASE
        WHEN (
          (v_is_patient OR patient_confirmed_at IS NOT NULL)
          AND (v_is_provider OR provider_confirmed_at IS NOT NULL)
        ) THEN 'active'
        ELSE status
      END,
      activated_at = CASE
        WHEN (
          (v_is_patient OR patient_confirmed_at IS NOT NULL)
          AND (v_is_provider OR provider_confirmed_at IS NOT NULL)
        ) THEN v_now
        ELSE activated_at
      END
    WHERE id = p_link_id
      AND status = 'pending'
    RETURNING * INTO v_updated;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'not_pending';
    END IF;

    IF v_updated.status = 'active' THEN
      UPDATE public.patient_details
      SET primary_provider_id = v_updated.provider_id
      WHERE patient_id = v_updated.patient_id;
    END IF;
  END IF;

  RETURN jsonb_build_object(
    'id', v_updated.id,
    'status', v_updated.status,
    'patient_id', v_updated.patient_id,
    'provider_id', v_updated.provider_id,
    'patient_confirmed_at', v_updated.patient_confirmed_at,
    'provider_confirmed_at', v_updated.provider_confirmed_at,
    'activated_at', v_updated.activated_at
  );
END;
$$;

REVOKE ALL ON FUNCTION public.redeem_invite_code_as(UUID, TEXT) FROM PUBLIC;
REVOKE ALL ON FUNCTION public.confirm_care_link_as(UUID, UUID, TEXT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.redeem_invite_code_as(UUID, TEXT) TO service_role;
GRANT EXECUTE ON FUNCTION public.confirm_care_link_as(UUID, UUID, TEXT) TO service_role;
