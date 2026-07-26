-- Inspection hardening (2026-07-26)
-- 1) Edge-only inhaler writes (revoke residual client INSERT grants)
-- 2) Explicit revoke on alerts / points / rate tables
-- 3) Unique NPI (providers)
-- 4) Stronger invite codes (8 alphanumeric)
-- 5) Atomic alert cooldown claim
-- 6) Cap saved_locations per patient

-- ---------------------------------------------------------------------------
-- 1) inhaler_events — no client INSERT/UPDATE/DELETE
-- ---------------------------------------------------------------------------
REVOKE INSERT ON TABLE public.inhaler_events FROM authenticated;
REVOKE UPDATE ON TABLE public.inhaler_events FROM authenticated;
REVOKE DELETE ON TABLE public.inhaler_events FROM authenticated;

DROP POLICY IF EXISTS inhaler_events_insert_own ON public.inhaler_events;
DROP POLICY IF EXISTS inhaler_events_update_own ON public.inhaler_events;
DROP POLICY IF EXISTS inhaler_events_delete_own ON public.inhaler_events;

-- ---------------------------------------------------------------------------
-- 2) Defense-in-depth: no client writes on server-authored tables
-- ---------------------------------------------------------------------------
REVOKE INSERT, UPDATE, DELETE ON TABLE public.environment_alerts_sent FROM authenticated;
REVOKE INSERT, UPDATE, DELETE ON TABLE public.point_transactions FROM authenticated;
REVOKE INSERT, UPDATE, DELETE ON TABLE public.env_risk_rate_events FROM authenticated;

-- ---------------------------------------------------------------------------
-- 3) Unique NPI
-- ---------------------------------------------------------------------------
CREATE UNIQUE INDEX IF NOT EXISTS uq_provider_credentials_npi
  ON public.provider_credentials (npi);

-- ---------------------------------------------------------------------------
-- 4) Invite codes: 8 alphanumeric (was 6 digits)
-- ---------------------------------------------------------------------------
ALTER TABLE public.invite_codes
  DROP CONSTRAINT IF EXISTS invite_codes_code_format;

-- Expire leftover 6-digit actives so format migration is clean.
UPDATE public.invite_codes
SET expires_at = TIMEZONE('utc', NOW())
WHERE consumed_at IS NULL
  AND expires_at > TIMEZONE('utc', NOW())
  AND code ~ '^[0-9]{6}$';

ALTER TABLE public.invite_codes
  ADD CONSTRAINT invite_codes_code_format
  CHECK (code ~ '^[A-Z0-9]{8}$');

-- Align redeem RPC format check with 8-char codes (body matches 20260725230000).
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
  v_normalized TEXT := upper(trim(p_code));
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

  IF v_normalized IS NULL OR v_normalized !~ '^[A-Z0-9]{8}$' THEN
    RAISE EXCEPTION 'invite_invalid';
  END IF;

  UPDATE public.invite_codes
  SET consumed_at = v_now
  WHERE code = v_normalized
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

-- ---------------------------------------------------------------------------
-- 5) Atomic cooldown claim (race-safe with concurrent notify)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.environment_alert_cooldowns (
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    cooldown_key TEXT NOT NULL,
    last_sent_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    PRIMARY KEY (patient_id, cooldown_key)
);

ALTER TABLE public.environment_alert_cooldowns ENABLE ROW LEVEL SECURITY;
-- No policies for authenticated → deny-by-default; Edge uses service_role.

CREATE OR REPLACE FUNCTION public.try_claim_alert_cooldown(
    p_patient_id UUID,
    p_cooldown_key TEXT,
    p_minutes INT DEFAULT 60
) RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
    INSERT INTO public.environment_alert_cooldowns (
        patient_id, cooldown_key, last_sent_at
    ) VALUES (
        p_patient_id, p_cooldown_key, TIMEZONE('utc', NOW())
    )
    ON CONFLICT DO NOTHING;

    IF FOUND THEN
        RETURN TRUE;
    END IF;

    UPDATE public.environment_alert_cooldowns
    SET last_sent_at = TIMEZONE('utc', NOW())
    WHERE patient_id = p_patient_id
      AND cooldown_key = p_cooldown_key
      AND last_sent_at < TIMEZONE('utc', NOW()) - make_interval(mins => p_minutes);

    RETURN FOUND;
END;
$$;

REVOKE ALL ON FUNCTION public.try_claim_alert_cooldown(UUID, TEXT, INT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.try_claim_alert_cooldown(UUID, TEXT, INT) TO service_role;

-- ---------------------------------------------------------------------------
-- 6) Cap saved locations (max 10 per patient)
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.enforce_saved_locations_cap()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM public.saved_locations
    WHERE patient_id = NEW.patient_id;

    IF TG_OP = 'INSERT' AND v_count >= 10 THEN
        RAISE EXCEPTION 'saved_locations_cap'
            USING ERRCODE = 'check_violation';
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_saved_locations_cap ON public.saved_locations;
CREATE TRIGGER trg_saved_locations_cap
    BEFORE INSERT ON public.saved_locations
    FOR EACH ROW
    EXECUTE FUNCTION public.enforce_saved_locations_cap();
