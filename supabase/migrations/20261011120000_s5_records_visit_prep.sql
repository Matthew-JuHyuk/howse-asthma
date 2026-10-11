-- Sprint 5 — patient-reported records + visit prep
-- 1) inhaler_events: optional patient-reported details, idempotency key, soft void.
--    Client writes stay Edge-only (log-inhaler-event). Legacy rows keep NULLs
--    (= "not recorded"); nothing is back-filled by guess.
-- 2) pdc_daily_checks: explicit status (used / not_used / not_sure / not_applicable)
--    and optional reason. Legacy taken=true/false maps 1:1 to used/not_used.
-- 3) New: symptom_entries, patient_medications, visit_prep_drafts (+ RLS).

-- ---------------------------------------------------------------------------
-- 1) inhaler_events
-- ---------------------------------------------------------------------------
ALTER TABLE public.inhaler_events
    ADD COLUMN IF NOT EXISTS medication_label TEXT,
    ADD COLUMN IF NOT EXISTS medication_status VARCHAR(20),
    ADD COLUMN IF NOT EXISTS puff_count SMALLINT,
    ADD COLUMN IF NOT EXISTS use_reason VARCHAR(30),
    ADD COLUMN IF NOT EXISTS note TEXT,
    ADD COLUMN IF NOT EXISTS source_language VARCHAR(10),
    ADD COLUMN IF NOT EXISTS tz_offset_minutes SMALLINT,
    ADD COLUMN IF NOT EXISTS client_request_id UUID,
    ADD COLUMN IF NOT EXISTS voided_at TIMESTAMPTZ,
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ;

ALTER TABLE public.inhaler_events
    DROP CONSTRAINT IF EXISTS inhaler_events_medication_status_chk,
    DROP CONSTRAINT IF EXISTS inhaler_events_medication_label_len_chk,
    DROP CONSTRAINT IF EXISTS inhaler_events_puff_count_chk,
    DROP CONSTRAINT IF EXISTS inhaler_events_use_reason_chk,
    DROP CONSTRAINT IF EXISTS inhaler_events_note_len_chk,
    DROP CONSTRAINT IF EXISTS inhaler_events_tz_offset_chk;

ALTER TABLE public.inhaler_events
    ADD CONSTRAINT inhaler_events_medication_status_chk
        CHECK (medication_status IS NULL
               OR medication_status IN ('identified', 'not_identified')),
    ADD CONSTRAINT inhaler_events_medication_label_len_chk
        CHECK (medication_label IS NULL OR char_length(medication_label) <= 120),
    ADD CONSTRAINT inhaler_events_puff_count_chk
        CHECK (puff_count IS NULL OR puff_count BETWEEN 1 AND 20),
    ADD CONSTRAINT inhaler_events_use_reason_chk
        CHECK (use_reason IS NULL
               OR use_reason IN ('symptoms', 'before_activity', 'other')),
    ADD CONSTRAINT inhaler_events_note_len_chk
        CHECK (note IS NULL OR char_length(note) <= 1000),
    ADD CONSTRAINT inhaler_events_tz_offset_chk
        CHECK (tz_offset_minutes IS NULL OR tz_offset_minutes BETWEEN -840 AND 840);

CREATE UNIQUE INDEX IF NOT EXISTS uq_inhaler_events_client_request
    ON public.inhaler_events (patient_id, client_request_id)
    WHERE client_request_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_inhaler_events_patient_recorded_live
    ON public.inhaler_events (patient_id, recorded_at DESC)
    WHERE voided_at IS NULL;

-- ---------------------------------------------------------------------------
-- 2) pdc_daily_checks
-- ---------------------------------------------------------------------------
ALTER TABLE public.pdc_daily_checks
    ADD COLUMN IF NOT EXISTS status VARCHAR(20),
    ADD COLUMN IF NOT EXISTS reason VARCHAR(30);

ALTER TABLE public.pdc_daily_checks
    ALTER COLUMN taken DROP NOT NULL;

UPDATE public.pdc_daily_checks
SET status = CASE WHEN taken THEN 'used' ELSE 'not_used' END
WHERE status IS NULL AND taken IS NOT NULL;

ALTER TABLE public.pdc_daily_checks
    DROP CONSTRAINT IF EXISTS pdc_daily_checks_status_chk,
    DROP CONSTRAINT IF EXISTS pdc_daily_checks_reason_chk;

ALTER TABLE public.pdc_daily_checks
    ADD CONSTRAINT pdc_daily_checks_status_chk
        CHECK (status IS NULL
               OR status IN ('used', 'not_used', 'not_sure', 'not_applicable')),
    ADD CONSTRAINT pdc_daily_checks_reason_chk
        CHECK (reason IS NULL
               OR (status = 'not_used'
                   AND reason IN ('no_medicine', 'cost', 'forgot', 'other', 'no_answer')));

-- ---------------------------------------------------------------------------
-- 3a) symptom_entries
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.symptom_entries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    tz_offset_minutes SMALLINT
        CHECK (tz_offset_minutes IS NULL OR tz_offset_minutes BETWEEN -840 AND 840),
    symptoms TEXT[] NOT NULL DEFAULT '{}',
    no_symptoms BOOLEAN NOT NULL DEFAULT FALSE,
    other_text TEXT CHECK (other_text IS NULL OR char_length(other_text) <= 300),
    note TEXT CHECK (note IS NULL OR char_length(note) <= 1000),
    source_language VARCHAR(10),
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT symptom_entries_codes_chk CHECK (
        symptoms <@ ARRAY[
            'cough', 'wheeze', 'short_breath', 'night_waking', 'activity_limited'
        ]::TEXT[]
    ),
    CONSTRAINT symptom_entries_none_exclusive_chk CHECK (
        NOT (no_symptoms AND (cardinality(symptoms) > 0 OR other_text IS NOT NULL))
    ),
    CONSTRAINT symptom_entries_not_empty_chk CHECK (
        no_symptoms OR cardinality(symptoms) > 0 OR other_text IS NOT NULL
    )
);

CREATE INDEX IF NOT EXISTS idx_symptom_entries_patient_recorded
    ON public.symptom_entries (patient_id, recorded_at DESC);

ALTER TABLE public.symptom_entries ENABLE ROW LEVEL SECURITY;

CREATE POLICY symptom_entries_select_own
  ON public.symptom_entries FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY symptom_entries_select_linked_provider
  ON public.symptom_entries FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY symptom_entries_insert_own
  ON public.symptom_entries FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY symptom_entries_update_own
  ON public.symptom_entries FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY symptom_entries_delete_own
  ON public.symptom_entries FOR DELETE TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 3b) patient_medications — patient-confirmed names for input convenience only
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.patient_medications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    display_name TEXT NOT NULL
        CHECK (char_length(display_name) BETWEEN 1 AND 120),
    is_default BOOLEAN NOT NULL DEFAULT FALSE,
    daily_check_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_patient_medications_one_default
    ON public.patient_medications (patient_id)
    WHERE is_default;

ALTER TABLE public.patient_medications ENABLE ROW LEVEL SECURITY;

CREATE POLICY patient_medications_select_own
  ON public.patient_medications FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY patient_medications_select_linked_provider
  ON public.patient_medications FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY patient_medications_insert_own
  ON public.patient_medications FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY patient_medications_update_own
  ON public.patient_medications FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY patient_medications_delete_own
  ON public.patient_medications FOR DELETE TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 3c) visit_prep_drafts — one working draft per patient (patient-only)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.visit_prep_drafts (
    patient_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    period_days SMALLINT NOT NULL DEFAULT 7 CHECK (period_days IN (7, 30)),
    questions JSONB NOT NULL DEFAULT '[]'::JSONB
        CHECK (jsonb_typeof(questions) = 'array' AND jsonb_array_length(questions) <= 10),
    barriers TEXT[] NOT NULL DEFAULT '{}',
    barrier_other TEXT CHECK (barrier_other IS NULL OR char_length(barrier_other) <= 300),
    include_symptoms BOOLEAN NOT NULL DEFAULT TRUE,
    include_inhaler BOOLEAN NOT NULL DEFAULT TRUE,
    include_med_checks BOOLEAN NOT NULL DEFAULT TRUE,
    include_environment BOOLEAN NOT NULL DEFAULT FALSE,
    insurance_notes JSONB NOT NULL DEFAULT '{}'::JSONB
        CHECK (jsonb_typeof(insurance_notes) = 'object'),
    source_language VARCHAR(10),
    last_generated_at TIMESTAMPTZ,
    last_generated_fingerprint TEXT
        CHECK (last_generated_fingerprint IS NULL OR char_length(last_generated_fingerprint) <= 200),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT visit_prep_barriers_chk CHECK (
        barriers <@ ARRAY[
            'cost', 'hard_to_get', 'hard_to_understand', 'how_to_use',
            'other', 'none', 'no_answer'
        ]::TEXT[]
    )
);

ALTER TABLE public.visit_prep_drafts ENABLE ROW LEVEL SECURITY;

CREATE POLICY visit_prep_drafts_select_own
  ON public.visit_prep_drafts FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY visit_prep_drafts_insert_own
  ON public.visit_prep_drafts FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY visit_prep_drafts_update_own
  ON public.visit_prep_drafts FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY visit_prep_drafts_delete_own
  ON public.visit_prep_drafts FOR DELETE TO authenticated
  USING (patient_id = auth.uid());
