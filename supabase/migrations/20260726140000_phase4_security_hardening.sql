-- Phase 4 security hardening (2026-07-26)
-- 1) Clients cannot write environmental snapshot columns on inhaler_events
--    (server/Edge copies from environment_forecasts).
-- 2) Emergency contact phones must be E.164.

-- ---------------------------------------------------------------------------
-- inhaler_events: column-level INSERT for authenticated
-- ---------------------------------------------------------------------------
REVOKE INSERT ON TABLE public.inhaler_events FROM authenticated;
REVOKE UPDATE ON TABLE public.inhaler_events FROM authenticated;
REVOKE DELETE ON TABLE public.inhaler_events FROM authenticated;

GRANT INSERT (
    id,
    patient_id,
    recorded_at,
    latitude,
    longitude,
    is_panic,
    input_means
) ON TABLE public.inhaler_events TO authenticated;

-- No client UPDATE on inhaler_events (append-only clinical evidence).
-- Existing UPDATE policies (if any) become no-ops without column privileges.

-- ---------------------------------------------------------------------------
-- emergency_contacts: E.164 phone format
-- ---------------------------------------------------------------------------
UPDATE public.emergency_contacts
SET phone_e164 = regexp_replace(phone_e164, '[^0-9+]', '', 'g')
WHERE phone_e164 !~ '^\+[1-9][0-9]{7,14}$';

-- Drop rows that still cannot be normalized (dev/test junk).
DELETE FROM public.emergency_contacts
WHERE phone_e164 !~ '^\+[1-9][0-9]{7,14}$';

ALTER TABLE public.emergency_contacts
    DROP CONSTRAINT IF EXISTS emergency_contacts_phone_e164_chk;

ALTER TABLE public.emergency_contacts
    ADD CONSTRAINT emergency_contacts_phone_e164_chk
    CHECK (phone_e164 ~ '^\+[1-9][0-9]{7,14}$');
