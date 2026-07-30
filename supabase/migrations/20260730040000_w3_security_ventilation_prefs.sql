-- Sprint 3 security hardening (2026-07-30)
-- 1) Allow VENTILATION_WINDOW trigger_reason (notify Edge)
-- 2) Server-enforce positive / fresh-air tip preference

ALTER TABLE public.environment_alerts_sent
  DROP CONSTRAINT IF EXISTS environment_alerts_sent_trigger_reason_check;

ALTER TABLE public.environment_alerts_sent
  ADD CONSTRAINT environment_alerts_sent_trigger_reason_check
  CHECK (trigger_reason IN (
    'LOCATION_ENTRY',
    'SAVED_LOCATION_CHANGE',
    'RISK_THRESHOLD',
    'MANUAL',
    'VENTILATION_WINDOW'
  ));

ALTER TABLE public.notification_preferences
  ADD COLUMN IF NOT EXISTS push_positive_ventilation BOOLEAN NOT NULL DEFAULT TRUE;

COMMENT ON COLUMN public.notification_preferences.push_positive_ventilation IS
  'When false, Edge must not send VENTILATION_WINDOW / fresh-air tip FCM.';
