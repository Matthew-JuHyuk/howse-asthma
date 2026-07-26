-- Demo care-link seed (manual). Not applied by `supabase db push`.
-- Prerequisites: two auth users already exist (patient + provider) with matching
-- rows in public.profiles (role PATIENT / PROVIDER).
--
-- Replace the UUIDs below, then run in the SQL Editor:
--
--   patient_id  = '<PATIENT_AUTH_USER_UUID>'
--   provider_id = '<PROVIDER_AUTH_USER_UUID>'

-- BEGIN demo seed (edit UUIDs first)
/*
WITH ids AS (
  SELECT
    '<PATIENT_AUTH_USER_UUID>'::uuid AS patient_id,
    '<PROVIDER_AUTH_USER_UUID>'::uuid AS provider_id
)
INSERT INTO public.patient_care_links (
  patient_id,
  provider_id,
  status,
  patient_confirmed_at,
  provider_confirmed_at,
  activated_at
)
SELECT
  patient_id,
  provider_id,
  'active',
  TIMEZONE('utc', NOW()),
  TIMEZONE('utc', NOW()),
  TIMEZONE('utc', NOW())
FROM ids
ON CONFLICT (patient_id, provider_id) DO UPDATE
SET
  status = 'active',
  patient_confirmed_at = EXCLUDED.patient_confirmed_at,
  provider_confirmed_at = EXCLUDED.provider_confirmed_at,
  activated_at = EXCLUDED.activated_at;

UPDATE public.patient_details pd
SET primary_provider_id = ids.provider_id
FROM (
  SELECT
    '<PATIENT_AUTH_USER_UUID>'::uuid AS patient_id,
    '<PROVIDER_AUTH_USER_UUID>'::uuid AS provider_id
) AS ids
WHERE pd.patient_id = ids.patient_id;
*/
-- END demo seed
