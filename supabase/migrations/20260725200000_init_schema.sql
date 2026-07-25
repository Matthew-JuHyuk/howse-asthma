-- Howse Asthma — initial public schema (WBS 1.3)
-- Source of truth: docs/db-schema.md (and local doc/db-schema.md)
-- RLS policies: deferred to WBS 1.4 (RLS enabled here = deny-by-default)

-- Extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ---------------------------------------------------------------------------
-- 2.1 Accounts · roles · profiles
-- ---------------------------------------------------------------------------

CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users (id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL CHECK (role IN ('PATIENT', 'PROVIDER')),
    full_name TEXT NOT NULL,
    language_code VARCHAR(10) NOT NULL DEFAULT 'en'
        CHECK (language_code IN ('en', 'es', 'fr', 'ko', 'ja', 'zh')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.provider_credentials (
    provider_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    npi VARCHAR(10) NOT NULL,
    license_display_name TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT provider_credentials_npi_digits CHECK (npi ~ '^[0-9]{10}$')
);

CREATE TABLE public.patient_details (
    patient_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    primary_provider_id UUID REFERENCES public.profiles (id),
    primary_diagnosis_icd10 VARCHAR(20) NOT NULL DEFAULT 'J45.909',
    adrb2_variant_flag BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.invite_codes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    code CHAR(6) NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    consumed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT invite_codes_code_format CHECK (code ~ '^[0-9]{6}$')
);

CREATE UNIQUE INDEX uq_invite_codes_active_code
    ON public.invite_codes (code)
    WHERE consumed_at IS NULL;

CREATE TABLE public.patient_care_links (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    invite_code_id UUID REFERENCES public.invite_codes (id),
    status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'active', 'rejected')),
    patient_confirmed_at TIMESTAMPTZ,
    provider_confirmed_at TIMESTAMPTZ,
    activated_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    UNIQUE (patient_id, provider_id)
);

-- ---------------------------------------------------------------------------
-- 2.2 Locations · notification preferences
-- ---------------------------------------------------------------------------

CREATE TABLE public.saved_locations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    label VARCHAR(50) NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    monitoring_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.notification_preferences (
    patient_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    push_risk_ge3 BOOLEAN NOT NULL DEFAULT TRUE,
    push_location_entry BOOLEAN NOT NULL DEFAULT TRUE,
    push_saved_location_change BOOLEAN NOT NULL DEFAULT TRUE,
    last_alert_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.device_push_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    fcm_token TEXT NOT NULL,
    platform VARCHAR(20) CHECK (platform IN ('android', 'ios', 'web')),
    last_seen_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    UNIQUE (profile_id, fcm_token)
);

CREATE TABLE public.emergency_contacts (
    patient_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    display_name TEXT NOT NULL,
    phone_e164 TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- ---------------------------------------------------------------------------
-- 2.3 Environment cache · alert history
-- ---------------------------------------------------------------------------

CREATE TABLE public.environment_forecasts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    geohash TEXT NOT NULL,
    latitude NUMERIC(8, 5) NOT NULL,
    longitude NUMERIC(8, 5) NOT NULL,
    risk_score SMALLINT NOT NULL CHECK (risk_score BETWEEN 1 AND 4),
    ui_state VARCHAR(20) NOT NULL
        CHECK (ui_state IN ('CALM', 'CAUTION', 'WARNING', 'EMERGENCY')),
    aqi_epa INT,
    pm25 NUMERIC(6, 2),
    no2_ppb NUMERIC(6, 2),
    aqi_source VARCHAR(40),
    local_pm25 NUMERIC(6, 2),
    trap_level VARCHAR(20)
        CHECK (trap_level IN ('LOW', 'MODERATE', 'HIGH', 'CRITICAL')),
    trap_near_freight_weight BOOLEAN DEFAULT FALSE,
    has_flash_flood_warning BOOLEAN NOT NULL DEFAULT FALSE,
    flood_alert_headline TEXT,
    flood_severity TEXT,
    usgs_stream_rate_ft_hr NUMERIC(5, 2),
    pollen_upi SMALLINT CHECK (pollen_upi BETWEEN 0 AND 5),
    dominant_pollen_type TEXT,
    pollen_forecast_days SMALLINT,
    baseline_comparison_pct NUMERIC(6, 2),
    forecast_points JSONB,
    raw_response JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    expires_at TIMESTAMPTZ NOT NULL
);

CREATE INDEX idx_env_forecasts_geohash
    ON public.environment_forecasts (geohash, expires_at);

CREATE TABLE public.environment_alerts_sent (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    alert_type VARCHAR(20) NOT NULL
        CHECK (alert_type IN ('TRAP_SOOT', 'FLASH_FLOOD', 'POLLEN', 'COMPOSITE')),
    trigger_reason VARCHAR(40) NOT NULL
        CHECK (trigger_reason IN (
            'LOCATION_ENTRY', 'SAVED_LOCATION_CHANGE', 'RISK_THRESHOLD', 'MANUAL'
        )),
    cooldown_key TEXT NOT NULL,
    risk_level SMALLINT CHECK (risk_level BETWEEN 1 AND 4),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    payload JSONB,
    sent_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE INDEX idx_alerts_sent_cooldown
    ON public.environment_alerts_sent (patient_id, cooldown_key, sent_at DESC);

-- ---------------------------------------------------------------------------
-- 2.4 Clinical · adherence · panic
-- ---------------------------------------------------------------------------

CREATE TABLE public.inhaler_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    is_panic BOOLEAN NOT NULL DEFAULT FALSE,
    input_means VARCHAR(20) NOT NULL DEFAULT 'tap'
        CHECK (input_means IN ('tap', 'panic', 'voice')),
    risk_level SMALLINT CHECK (risk_level BETWEEN 1 AND 4),
    ui_state VARCHAR(20)
        CHECK (ui_state IN ('CALM', 'CAUTION', 'WARNING', 'EMERGENCY')),
    pm25_level NUMERIC(6, 2),
    no2_level NUMERIC(6, 2),
    local_pm25_snapshot NUMERIC(6, 2),
    flash_flood_alert_active BOOLEAN NOT NULL DEFAULT FALSE,
    pollen_upi_snapshot SMALLINT CHECK (pollen_upi_snapshot BETWEEN 0 AND 5),
    environment_forecast_id UUID REFERENCES public.environment_forecasts (id),
    data_source_summary JSONB
);

CREATE TABLE public.act_assessments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    q1 SMALLINT NOT NULL CHECK (q1 BETWEEN 1 AND 5),
    q2 SMALLINT NOT NULL CHECK (q2 BETWEEN 1 AND 5),
    q3 SMALLINT NOT NULL CHECK (q3 BETWEEN 1 AND 5),
    q4 SMALLINT NOT NULL CHECK (q4 BETWEEN 1 AND 5),
    q5 SMALLINT NOT NULL CHECK (q5 BETWEEN 1 AND 5),
    total_score SMALLINT NOT NULL CHECK (total_score BETWEEN 5 AND 25),
    language_used VARCHAR(10) NOT NULL,
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.pdc_daily_checks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    check_date DATE NOT NULL,
    taken BOOLEAN NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    UNIQUE (patient_id, check_date)
);

CREATE TABLE public.panic_episodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    started_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    ended_at TIMESTAMPTZ,
    help_requested BOOLEAN NOT NULL DEFAULT FALSE,
    outcome_chip VARCHAR(40),
    inhaler_event_id UUID REFERENCES public.inhaler_events (id),
    notes TEXT
);

-- ---------------------------------------------------------------------------
-- 2.5 Provider documents · signature · outbound
-- ---------------------------------------------------------------------------

CREATE TABLE public.pa_documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    doc_type VARCHAR(10) NOT NULL CHECK (doc_type IN ('PA', 'LMN')),
    pdf_storage_path TEXT NOT NULL,
    review_checklist JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.signature_artifacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pa_document_id UUID NOT NULL REFERENCES public.pa_documents (id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    storage_path TEXT NOT NULL,
    signed_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.outbound_transmissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pa_document_id UUID NOT NULL REFERENCES public.pa_documents (id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    channel VARCHAR(10) NOT NULL CHECK (channel IN ('EMAIL', 'FAX')),
    recipient TEXT NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'QUEUED'
        CHECK (status IN (
            'QUEUED', 'SENDING', 'SENT', 'FAILED', 'FAILOVER_EMAIL', 'CANCELLED'
        )),
    external_message_id TEXT,
    error_detail TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- ---------------------------------------------------------------------------
-- 2.6 Rewards · vouchers · donations (fund separation)
-- ---------------------------------------------------------------------------

CREATE TABLE public.point_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    action_type VARCHAR(40) NOT NULL CHECK (action_type IN (
        'INHALER_LOG',
        'ACT_ASSESSMENT',
        'PDC_CHECKIN',
        'VOUCHER_REDEEMED',
        'VOUCHER_WAITLIST',
        'DONATION_CONVERTED',
        'ADJUSTMENT'
    )),
    points_delta INT NOT NULL,
    related_entity_id UUID,
    note TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.food_bank_vouchers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    food_bank_name TEXT NOT NULL,
    voucher_value_usd NUMERIC(8, 2),
    point_cost INT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    is_draft BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.voucher_redemptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    voucher_id UUID NOT NULL REFERENCES public.food_bank_vouchers (id),
    points_spent INT NOT NULL,
    redemption_code TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'WAITLIST'
        CHECK (status IN (
            'WAITLIST', 'PENDING', 'ISSUED', 'REDEEMED', 'EXPIRED', 'CANCELLED'
        )),
    redeemed_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.point_to_donation_conversions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    points_spent INT NOT NULL,
    cash_equivalent_usd NUMERIC(8, 2),
    target_org_label TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.donation_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    donor_profile_id UUID REFERENCES public.profiles (id),
    amount_usd NUMERIC(10, 2),
    external_provider TEXT,
    external_transaction_id TEXT,
    receipt_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- ---------------------------------------------------------------------------
-- 2.7 Views
-- ---------------------------------------------------------------------------

CREATE OR REPLACE VIEW public.v_point_balances
WITH (security_invoker = true)
AS
SELECT
    patient_id,
    COALESCE(SUM(points_delta), 0)::INT AS balance
FROM public.point_transactions
GROUP BY patient_id;

-- ---------------------------------------------------------------------------
-- RLS on (policies in WBS 1.4). Deny-by-default until policies exist.
-- service_role bypasses RLS for Edge Functions.
-- ---------------------------------------------------------------------------

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.provider_credentials ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.patient_details ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.invite_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.patient_care_links ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.saved_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notification_preferences ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.device_push_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.emergency_contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.environment_forecasts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.environment_alerts_sent ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inhaler_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.act_assessments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pdc_daily_checks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.panic_episodes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.pa_documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.signature_artifacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.outbound_transmissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.point_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.food_bank_vouchers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.voucher_redemptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.point_to_donation_conversions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.donation_transactions ENABLE ROW LEVEL SECURITY;
