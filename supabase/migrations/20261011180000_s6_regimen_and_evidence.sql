-- Sprint 6 — prescription versions, occasion checks, event-time environment.
-- Does not invent insurer requirements. Unanswered occasions are the absence
-- of a row, never a guessed "not used".
-- Clients cannot write measured environment values; only pending / no_data.

-- ---------------------------------------------------------------------------
-- 1) Prescription versions. A change inserts a new row and closes the old one.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.medication_regimens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    medication_id UUID NOT NULL REFERENCES public.patient_medications (id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL CHECK (role IN ('controller', 'rescue', 'both')),
    occasions_per_day SMALLINT NOT NULL DEFAULT 0 CHECK (occasions_per_day BETWEEN 0 AND 6),
    puffs_per_occasion SMALLINT NOT NULL DEFAULT 1 CHECK (puffs_per_occasion BETWEEN 1 AND 20),
    times_minutes SMALLINT[] NOT NULL DEFAULT '{}',
    effective_from DATE NOT NULL,
    effective_until DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT medication_regimens_until_chk CHECK (
        effective_until IS NULL OR effective_until >= effective_from
    ),
    -- Each entry is minutes from local midnight (0–1439). Bounds are checked
    -- in the app; cardinality must match the scheduled occasion count.
    CONSTRAINT medication_regimens_times_len_chk CHECK (
        cardinality(times_minutes) = occasions_per_day
    )
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_medication_regimens_open
    ON public.medication_regimens (medication_id)
    WHERE effective_until IS NULL;

CREATE INDEX IF NOT EXISTS idx_medication_regimens_patient
    ON public.medication_regimens (patient_id, effective_from DESC);

ALTER TABLE public.medication_regimens ENABLE ROW LEVEL SECURITY;

CREATE POLICY medication_regimens_select_own
  ON public.medication_regimens FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY medication_regimens_select_linked_provider
  ON public.medication_regimens FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY medication_regimens_insert_own
  ON public.medication_regimens FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY medication_regimens_update_own
  ON public.medication_regimens FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY medication_regimens_delete_own
  ON public.medication_regimens FOR DELETE TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 2) One response per scheduled occasion. No row = unconfirmed, not missed.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.medication_occasion_checks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    regimen_id UUID NOT NULL REFERENCES public.medication_regimens (id) ON DELETE CASCADE,
    local_date DATE NOT NULL,
    occasion_index SMALLINT NOT NULL CHECK (occasion_index BETWEEN 0 AND 5),
    status VARCHAR(20) NOT NULL CHECK (status IN ('used', 'not_used', 'deferred')),
    client_request_id UUID,
    responded_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    source VARCHAR(20) NOT NULL DEFAULT 'in_app'
        CHECK (source IN ('in_app', 'notification')),
    UNIQUE (regimen_id, local_date, occasion_index)
);

CREATE UNIQUE INDEX IF NOT EXISTS uq_occasion_checks_request
    ON public.medication_occasion_checks (patient_id, client_request_id)
    WHERE client_request_id IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_occasion_checks_patient_date
    ON public.medication_occasion_checks (patient_id, local_date DESC);

ALTER TABLE public.medication_occasion_checks ENABLE ROW LEVEL SECURITY;

CREATE POLICY occasion_checks_select_own
  ON public.medication_occasion_checks FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY occasion_checks_select_linked_provider
  ON public.medication_occasion_checks FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

CREATE POLICY occasion_checks_insert_own
  ON public.medication_occasion_checks FOR INSERT TO authenticated
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY occasion_checks_update_own
  ON public.medication_occasion_checks FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE POLICY occasion_checks_delete_own
  ON public.medication_occasion_checks FOR DELETE TO authenticated
  USING (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 3) Symptom occurrence time, separate from when the row was saved.
-- ---------------------------------------------------------------------------
ALTER TABLE public.symptom_entries
    ADD COLUMN IF NOT EXISTS occurred_at TIMESTAMPTZ,
    ADD COLUMN IF NOT EXISTS home_water VARCHAR(20);

ALTER TABLE public.symptom_entries
    DROP CONSTRAINT IF EXISTS symptom_entries_home_water_chk;

ALTER TABLE public.symptom_entries
    ADD CONSTRAINT symptom_entries_home_water_chk CHECK (
        home_water IS NULL OR home_water IN ('yes', 'no', 'no_answer')
    );

-- ---------------------------------------------------------------------------
-- 4) Patient-reported care visits. Attachment is not clinician confirmation.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.patient_care_reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    occurred_at TIMESTAMPTZ NOT NULL,
    kind VARCHAR(20) NOT NULL CHECK (kind IN ('er', 'urgent_care', 'office', 'other')),
    note TEXT CHECK (note IS NULL OR char_length(note) <= 1000),
    has_attachment BOOLEAN NOT NULL DEFAULT FALSE,
    clinician_confirmed BOOLEAN NOT NULL DEFAULT FALSE,
    source VARCHAR(20) NOT NULL DEFAULT 'self_report'
        CHECK (source = 'self_report'),
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE INDEX IF NOT EXISTS idx_patient_care_reports_patient
    ON public.patient_care_reports (patient_id, occurred_at DESC);

ALTER TABLE public.patient_care_reports ENABLE ROW LEVEL SECURITY;

CREATE POLICY patient_care_reports_select_own
  ON public.patient_care_reports FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY patient_care_reports_select_linked_provider
  ON public.patient_care_reports FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

-- Patients cannot mark a visit as clinician-confirmed.
CREATE POLICY patient_care_reports_insert_own
  ON public.patient_care_reports FOR INSERT TO authenticated
  WITH CHECK (
      patient_id = auth.uid()
      AND clinician_confirmed = FALSE
      AND source = 'self_report'
  );

CREATE POLICY patient_care_reports_update_own
  ON public.patient_care_reports FOR UPDATE TO authenticated
  USING (patient_id = auth.uid() AND clinician_confirmed = FALSE)
  WITH CHECK (patient_id = auth.uid() AND clinician_confirmed = FALSE);

CREATE POLICY patient_care_reports_delete_own
  ON public.patient_care_reports FOR DELETE TO authenticated
  USING (patient_id = auth.uid() AND clinician_confirmed = FALSE);

-- ---------------------------------------------------------------------------
-- 5) Environment snapshot for one event. Measured values are service-role only.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.environment_event_snapshots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    subject_type VARCHAR(20) NOT NULL
        CHECK (subject_type IN ('symptom', 'inhaler', 'care_report')),
    subject_id UUID NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'no_data', 'linked')),
    provider TEXT,
    source_ref TEXT,
    pollutant TEXT,
    numeric_value NUMERIC,
    unit TEXT,
    aqi_value SMALLINT,
    aqi_framework TEXT,
    observed_at TIMESTAMPTZ,
    collected_at TIMESTAMPTZ,
    event_time TIMESTAMPTZ,
    delta_minutes INTEGER,
    data_kind VARCHAR(20)
        CHECK (data_kind IS NULL OR data_kind IN (
            'observation', 'model', 'forecast', 'provisional', 'unavailable'
        )),
    location_basis VARCHAR(20)
        CHECK (location_basis IS NULL OR location_basis IN (
            'current_fix', 'saved_place', 'chosen_place'
        )),
    pollen_upi SMALLINT,
    pollen_type TEXT,
    outdoor_humidity SMALLINT,
    flood_alert BOOLEAN,
    rule_version TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    UNIQUE (subject_type, subject_id)
);

CREATE INDEX IF NOT EXISTS idx_env_snapshots_patient
    ON public.environment_event_snapshots (patient_id, event_time DESC);

ALTER TABLE public.environment_event_snapshots ENABLE ROW LEVEL SECURITY;

CREATE POLICY env_snapshots_select_own
  ON public.environment_event_snapshots FOR SELECT TO authenticated
  USING (patient_id = auth.uid());

CREATE POLICY env_snapshots_select_linked_provider
  ON public.environment_event_snapshots FOR SELECT TO authenticated
  USING (public.is_active_provider_of(patient_id));

-- Patients may only create an empty pending/no_data row.
CREATE POLICY env_snapshots_insert_own
  ON public.environment_event_snapshots FOR INSERT TO authenticated
  WITH CHECK (
      patient_id = auth.uid()
      AND status IN ('pending', 'no_data')
      AND provider IS NULL
      AND numeric_value IS NULL
      AND aqi_value IS NULL
      AND pollen_upi IS NULL
      AND outdoor_humidity IS NULL
  );

CREATE POLICY env_snapshots_update_own
  ON public.environment_event_snapshots FOR UPDATE TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (
      patient_id = auth.uid()
      AND status IN ('pending', 'no_data')
      AND provider IS NULL
      AND numeric_value IS NULL
      AND aqi_value IS NULL
      AND pollen_upi IS NULL
  );

-- ---------------------------------------------------------------------------
-- 6) Empty slots for a future confirmed policy. No requirement rows are seeded.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.coverage_policy_slots (
    patient_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    policy_identifier TEXT,
    product_name TEXT,
    medication_id UUID REFERENCES public.patient_medications (id) ON DELETE SET NULL,
    source_label TEXT,
    effective_on DATE,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

ALTER TABLE public.coverage_policy_slots ENABLE ROW LEVEL SECURITY;

CREATE POLICY coverage_policy_slots_own
  ON public.coverage_policy_slots FOR ALL TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());

CREATE TABLE IF NOT EXISTS public.coverage_policy_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    item_label TEXT NOT NULL CHECK (char_length(item_label) BETWEEN 1 AND 300),
    evidence_ids UUID[] NOT NULL DEFAULT '{}',
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

ALTER TABLE public.coverage_policy_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY coverage_policy_items_own
  ON public.coverage_policy_items FOR ALL TO authenticated
  USING (patient_id = auth.uid())
  WITH CHECK (patient_id = auth.uid());
