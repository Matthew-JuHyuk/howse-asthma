-- Sprint 8 (CoverNote MVP1): server-side letter analysis, requested-item
-- checklist, local context entries, packet artifacts.
-- Additive only. No existing table is dropped or renamed.

-- ---------------------------------------------------------------------------
-- 1) Case columns
-- ---------------------------------------------------------------------------
ALTER TABLE public.appeal_cases
    ADD COLUMN IF NOT EXISTS document_kind TEXT,
    ADD COLUMN IF NOT EXISTS current_evidence_revision INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS reviewed_fact_revision INTEGER,
    ADD COLUMN IF NOT EXISTS user_reported_submitted_on DATE,
    ADD COLUMN IF NOT EXISTS user_reported_submit_method TEXT,
    ADD COLUMN IF NOT EXISTS last_exported_at TIMESTAMPTZ;

ALTER TABLE public.appeal_cases
    DROP CONSTRAINT IF EXISTS appeal_cases_document_kind_chk;
ALTER TABLE public.appeal_cases
    ADD CONSTRAINT appeal_cases_document_kind_chk CHECK (
        document_kind IS NULL OR document_kind IN (
            'initial_drug_denial', 'additional_information_request',
            'reauthorization_notice', 'final_appeal_denial', 'eob_or_bill',
            'other', 'uncertain'
        )
    );

ALTER TABLE public.appeal_cases
    DROP CONSTRAINT IF EXISTS appeal_cases_submit_method_len_chk;
ALTER TABLE public.appeal_cases
    ADD CONSTRAINT appeal_cases_submit_method_len_chk CHECK (
        user_reported_submit_method IS NULL
        OR char_length(user_reported_submit_method) <= 80
    );

-- ---------------------------------------------------------------------------
-- 2) Uploaded files: a case keeps every upload; one "set" is analyzed.
-- ---------------------------------------------------------------------------
ALTER TABLE public.case_documents
    ADD COLUMN IF NOT EXISTS set_revision INTEGER NOT NULL DEFAULT 1,
    ADD COLUMN IF NOT EXISTS file_index SMALLINT NOT NULL DEFAULT 0;

CREATE INDEX IF NOT EXISTS idx_case_documents_case_set
    ON public.case_documents (case_id, set_revision, file_index);

ALTER TABLE public.case_documents
    DROP CONSTRAINT IF EXISTS case_documents_mime_chk;
ALTER TABLE public.case_documents
    ADD CONSTRAINT case_documents_mime_chk CHECK (
        mime IN ('image/jpeg', 'image/png', 'application/pdf', 'text/plain')
    );

ALTER TABLE public.document_pages
    ADD COLUMN IF NOT EXISTS case_id UUID REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    ADD COLUMN IF NOT EXISTS set_revision INTEGER,
    ADD COLUMN IF NOT EXISTS page_number INTEGER,
    ADD COLUMN IF NOT EXISTS legibility VARCHAR(20);

ALTER TABLE public.document_pages
    DROP CONSTRAINT IF EXISTS document_pages_legibility_chk;
ALTER TABLE public.document_pages
    ADD CONSTRAINT document_pages_legibility_chk CHECK (
        legibility IS NULL OR legibility IN ('clear', 'partly_unreadable', 'unreadable')
    );

CREATE INDEX IF NOT EXISTS idx_document_pages_case_set
    ON public.document_pages (case_id, set_revision, page_number);

-- ---------------------------------------------------------------------------
-- 3) Jobs: written by the server only. Clients read their own rows.
-- ---------------------------------------------------------------------------
ALTER TABLE public.processing_jobs
    ADD COLUMN IF NOT EXISTS provider TEXT,
    ADD COLUMN IF NOT EXISTS model TEXT,
    ADD COLUMN IF NOT EXISTS prompt_version TEXT,
    ADD COLUMN IF NOT EXISTS provider_request_ids TEXT[] NOT NULL DEFAULT '{}',
    ADD COLUMN IF NOT EXISTS duration_ms INTEGER,
    ADD COLUMN IF NOT EXISTS input_tokens INTEGER,
    ADD COLUMN IF NOT EXISTS output_tokens INTEGER,
    ADD COLUMN IF NOT EXISTS result_fact_revision INTEGER,
    ADD COLUMN IF NOT EXISTS started_at TIMESTAMPTZ,
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW());

DROP POLICY IF EXISTS processing_jobs_own ON public.processing_jobs;
DROP POLICY IF EXISTS processing_jobs_select_own ON public.processing_jobs;
CREATE POLICY processing_jobs_select_own
    ON public.processing_jobs FOR SELECT TO authenticated
    USING (
        owner_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM public.appeal_cases c
            WHERE c.id = case_id
              AND c.owner_id = auth.uid()
              AND c.deleted_at IS NULL
        )
    );

-- ---------------------------------------------------------------------------
-- 4) Requested items from the notice, matched to the patient's own records.
--    Checking an item changes its status only; it is not a coverage decision.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.case_requirements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    label TEXT NOT NULL CHECK (char_length(label) BETWEEN 1 AND 300),
    origin VARCHAR(16) NOT NULL CHECK (origin IN ('extracted', 'user_added')),
    source_page INTEGER,
    source_quote TEXT CHECK (source_quote IS NULL OR char_length(source_quote) <= 600),
    status VARCHAR(20) NOT NULL DEFAULT 'needed' CHECK (status IN (
        'needed', 'linked', 'asked_care_team', 'not_available', 'not_applicable'
    )),
    responsible VARCHAR(16) NOT NULL DEFAULT 'unknown' CHECK (responsible IN (
        'patient', 'care_team', 'insurer', 'unknown'
    )),
    linked_evidence_id UUID REFERENCES public.case_evidence (id) ON DELETE SET NULL,
    note TEXT CHECK (note IS NULL OR char_length(note) <= 500),
    sort_order SMALLINT NOT NULL DEFAULT 0,
    fact_revision INTEGER,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE INDEX IF NOT EXISTS idx_case_requirements_case
    ON public.case_requirements (case_id, sort_order);

DROP TRIGGER IF EXISTS case_requirements_owner_match ON public.case_requirements;
CREATE TRIGGER case_requirements_owner_match
    BEFORE INSERT OR UPDATE ON public.case_requirements
    FOR EACH ROW EXECUTE FUNCTION public.appeal_child_owner_matches();

ALTER TABLE public.case_requirements ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS case_requirements_own ON public.case_requirements;
CREATE POLICY case_requirements_own
    ON public.case_requirements FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (
        owner_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM public.appeal_cases c
            WHERE c.id = case_id
              AND c.owner_id = auth.uid()
              AND c.deleted_at IS NULL
        )
    );

-- Evidence and artifacts must also belong to a live case owned by the caller.
DROP POLICY IF EXISTS case_evidence_own ON public.case_evidence;
CREATE POLICY case_evidence_own
    ON public.case_evidence FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (
        owner_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM public.appeal_cases c
            WHERE c.id = case_id
              AND c.owner_id = auth.uid()
              AND c.deleted_at IS NULL
        )
    );

ALTER TABLE public.generated_artifacts
    ADD COLUMN IF NOT EXISTS bytes INTEGER,
    ADD COLUMN IF NOT EXISTS sha256 TEXT,
    ADD COLUMN IF NOT EXISTS includes JSONB NOT NULL DEFAULT '{}'::JSONB,
    ADD COLUMN IF NOT EXISTS is_sample BOOLEAN NOT NULL DEFAULT FALSE;

DROP POLICY IF EXISTS generated_artifacts_own ON public.generated_artifacts;
CREATE POLICY generated_artifacts_own
    ON public.generated_artifacts FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (
        owner_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM public.appeal_cases c
            WHERE c.id = case_id
              AND c.owner_id = auth.uid()
              AND c.deleted_at IS NULL
        )
    );

-- ---------------------------------------------------------------------------
-- 5) Local context: values the patient entered with their source, plus quick
--    self-reports. Observed values and patient reports stay separate.
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.local_context_entries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    local_date DATE NOT NULL,
    kind VARCHAR(24) NOT NULL CHECK (kind IN (
        'pm25', 'no2', 'outdoor_humidity', 'user_report'
    )),
    report_code VARCHAR(32) CHECK (report_code IS NULL OR report_code IN (
        'strong_exhaust', 'water_intrusion', 'damp_musty'
    )),
    numeric_value NUMERIC,
    unit TEXT CHECK (unit IS NULL OR char_length(unit) <= 20),
    aqi_value SMALLINT CHECK (aqi_value IS NULL OR aqi_value BETWEEN 0 AND 999),
    value_kind VARCHAR(16) NOT NULL CHECK (value_kind IN (
        'observation', 'forecast', 'model', 'user_report'
    )),
    source_name TEXT CHECK (source_name IS NULL OR char_length(source_name) <= 120),
    place_label TEXT CHECK (place_label IS NULL OR char_length(place_label) <= 120),
    observed_at TIMESTAMPTZ,
    fetched_at TIMESTAMPTZ,
    is_synthetic BOOLEAN NOT NULL DEFAULT FALSE,
    note TEXT CHECK (note IS NULL OR char_length(note) <= 300),
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT local_context_report_shape_chk CHECK (
        (kind = 'user_report' AND report_code IS NOT NULL AND value_kind = 'user_report'
            AND numeric_value IS NULL AND aqi_value IS NULL)
        OR (kind <> 'user_report' AND report_code IS NULL AND value_kind <> 'user_report'
            AND (numeric_value IS NOT NULL OR aqi_value IS NOT NULL)
            AND source_name IS NOT NULL)
    )
);

CREATE INDEX IF NOT EXISTS idx_local_context_patient_date
    ON public.local_context_entries (patient_id, local_date DESC);

ALTER TABLE public.local_context_entries ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS local_context_entries_own ON public.local_context_entries;
CREATE POLICY local_context_entries_own
    ON public.local_context_entries FOR ALL TO authenticated
    USING (patient_id = auth.uid())
    WITH CHECK (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 6) Storage: allow the owner to read packet files they generated. Upload,
--    select and delete policies for this private bucket already exist.
-- ---------------------------------------------------------------------------
UPDATE storage.buckets
SET allowed_mime_types = ARRAY['image/jpeg', 'image/png', 'application/pdf', 'text/plain']
WHERE id = 'appeal-documents';
