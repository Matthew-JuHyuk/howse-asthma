-- Sprint 9: case identity, lifecycle, delivery, translations, unified use
-- events, environment snapshots, consent locale. Additive only.

-- ---------------------------------------------------------------------------
-- 1) Profile area (ZIP / city). Always-on location is not required.
-- ---------------------------------------------------------------------------
ALTER TABLE public.profiles
    ADD COLUMN IF NOT EXISTS home_zip TEXT,
    ADD COLUMN IF NOT EXISTS home_city TEXT,
    ADD COLUMN IF NOT EXISTS home_lat DOUBLE PRECISION,
    ADD COLUMN IF NOT EXISTS home_lon DOUBLE PRECISION;

ALTER TABLE public.profiles
    DROP CONSTRAINT IF EXISTS profiles_home_zip_len_chk;
ALTER TABLE public.profiles
    ADD CONSTRAINT profiles_home_zip_len_chk CHECK (
        home_zip IS NULL OR char_length(home_zip) BETWEEN 3 AND 16
    );

-- ---------------------------------------------------------------------------
-- 2) Case identity and lifecycle (separate from document/job/artifact status)
-- ---------------------------------------------------------------------------
ALTER TABLE public.appeal_cases
    ADD COLUMN IF NOT EXISTS display_ordinal INTEGER,
    ADD COLUMN IF NOT EXISTS display_alias TEXT,
    ADD COLUMN IF NOT EXISTS treatment_context TEXT,
    ADD COLUMN IF NOT EXISTS lifecycle TEXT NOT NULL DEFAULT 'active',
    ADD COLUMN IF NOT EXISTS completed_at TIMESTAMPTZ,
    ADD COLUMN IF NOT EXISTS completed_outcome TEXT,
    ADD COLUMN IF NOT EXISTS archived_at TIMESTAMPTZ,
    ADD COLUMN IF NOT EXISTS plan_name_cache TEXT;

ALTER TABLE public.appeal_cases
    DROP CONSTRAINT IF EXISTS appeal_cases_lifecycle_chk;
ALTER TABLE public.appeal_cases
    ADD CONSTRAINT appeal_cases_lifecycle_chk CHECK (
        lifecycle IN ('active', 'completed', 'archived')
    );

ALTER TABLE public.appeal_cases
    DROP CONSTRAINT IF EXISTS appeal_cases_treatment_chk;
ALTER TABLE public.appeal_cases
    ADD CONSTRAINT appeal_cases_treatment_chk CHECK (
        treatment_context IS NULL OR treatment_context IN (
            'asthma', 'other', 'unknown'
        )
    );

ALTER TABLE public.appeal_cases
    DROP CONSTRAINT IF EXISTS appeal_cases_outcome_chk;
ALTER TABLE public.appeal_cases
    ADD CONSTRAINT appeal_cases_outcome_chk CHECK (
        completed_outcome IS NULL OR completed_outcome IN (
            'approved', 'denied', 'stopped', 'other'
        )
    );

ALTER TABLE public.appeal_cases
    DROP CONSTRAINT IF EXISTS appeal_cases_alias_len_chk;
ALTER TABLE public.appeal_cases
    ADD CONSTRAINT appeal_cases_alias_len_chk CHECK (
        display_alias IS NULL OR char_length(display_alias) <= 80
    );

CREATE UNIQUE INDEX IF NOT EXISTS idx_appeal_cases_owner_ordinal
    ON public.appeal_cases (owner_id, display_ordinal)
    WHERE display_ordinal IS NOT NULL;

CREATE TABLE IF NOT EXISTS public.case_ordinal_counters (
    owner_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    next_ordinal INTEGER NOT NULL DEFAULT 1
);

CREATE OR REPLACE FUNCTION public.next_case_ordinal(p_owner UUID)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    n INTEGER;
BEGIN
    INSERT INTO public.case_ordinal_counters (owner_id, next_ordinal)
    VALUES (p_owner, 1)
    ON CONFLICT (owner_id) DO UPDATE
        SET next_ordinal = public.case_ordinal_counters.next_ordinal + 1
    RETURNING next_ordinal INTO n;
    RETURN n;
END;
$$;

CREATE OR REPLACE FUNCTION public.assign_case_ordinal()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.display_ordinal IS NULL THEN
        NEW.display_ordinal := public.next_case_ordinal(NEW.owner_id);
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS appeal_cases_assign_ordinal ON public.appeal_cases;
CREATE TRIGGER appeal_cases_assign_ordinal
    BEFORE INSERT ON public.appeal_cases
    FOR EACH ROW
    EXECUTE FUNCTION public.assign_case_ordinal();

-- One-time backfill: stable order by created_at, then id. Existing ids stay.
WITH ranked AS (
    SELECT id,
           ROW_NUMBER() OVER (PARTITION BY owner_id ORDER BY created_at, id) AS n
    FROM public.appeal_cases
    WHERE display_ordinal IS NULL
)
UPDATE public.appeal_cases c
SET display_ordinal = ranked.n
FROM ranked
WHERE c.id = ranked.id;

INSERT INTO public.case_ordinal_counters (owner_id, next_ordinal)
SELECT owner_id, COALESCE(MAX(display_ordinal), 0) + 1
FROM public.appeal_cases
GROUP BY owner_id
ON CONFLICT (owner_id) DO UPDATE
    SET next_ordinal = GREATEST(
        public.case_ordinal_counters.next_ordinal,
        EXCLUDED.next_ordinal
    );

-- ---------------------------------------------------------------------------
-- 3) Delivery events (user-reported; share-sheet open is not a row)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.delivery_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    recipient_type TEXT NOT NULL,
    method TEXT NOT NULL,
    sent_at TIMESTAMPTZ NOT NULL,
    artifact_id UUID REFERENCES public.generated_artifacts (id) ON DELETE SET NULL,
    artifact_revision INTEGER,
    note TEXT,
    reported_by_user BOOLEAN NOT NULL DEFAULT TRUE,
    revoked_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT delivery_recipient_chk CHECK (
        recipient_type IN ('clinic', 'insurer', 'self', 'other')
    ),
    CONSTRAINT delivery_method_chk CHECK (
        method IN (
            'email', 'message', 'portal', 'fax', 'mail',
            'in_person', 'other', 'unknown'
        )
    ),
    CONSTRAINT delivery_note_len_chk CHECK (
        note IS NULL OR char_length(note) <= 500
    )
);

CREATE INDEX IF NOT EXISTS idx_delivery_events_case
    ON public.delivery_events (case_id, sent_at DESC);

ALTER TABLE public.delivery_events ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS delivery_events_own ON public.delivery_events;
CREATE POLICY delivery_events_own
    ON public.delivery_events FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (owner_id = auth.uid());

DROP TRIGGER IF EXISTS delivery_events_owner_match ON public.delivery_events;
CREATE TRIGGER delivery_events_owner_match
    BEFORE INSERT OR UPDATE ON public.delivery_events
    FOR EACH ROW
    EXECUTE FUNCTION public.appeal_child_owner_matches();

-- ---------------------------------------------------------------------------
-- 4) Full-document translations (per page, cached)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.document_translations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    document_revision INTEGER NOT NULL,
    language TEXT NOT NULL,
    page_number INTEGER NOT NULL,
    status TEXT NOT NULL,
    translated_text TEXT,
    model TEXT,
    prompt_version TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT document_translations_status_chk CHECK (
        status IN ('pending', 'ready', 'failed', 'hard_to_read')
    ),
    CONSTRAINT document_translations_lang_chk CHECK (char_length(language) <= 12),
    UNIQUE (case_id, document_revision, language, page_number)
);

CREATE INDEX IF NOT EXISTS idx_document_translations_case
    ON public.document_translations (case_id, language, document_revision);

ALTER TABLE public.document_translations ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS document_translations_own ON public.document_translations;
CREATE POLICY document_translations_own
    ON public.document_translations FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (owner_id = auth.uid());

DROP TRIGGER IF EXISTS document_translations_owner_match
    ON public.document_translations;
CREATE TRIGGER document_translations_owner_match
    BEFORE INSERT OR UPDATE ON public.document_translations
    FOR EACH ROW
    EXECUTE FUNCTION public.appeal_child_owner_matches();

-- ---------------------------------------------------------------------------
-- 5) Unified medication-use events (old tables stay; this is the new write)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.medication_use_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    medication_id UUID,
    medication_name TEXT,
    use_kind TEXT NOT NULL,
    occurred_at TIMESTAMPTZ NOT NULL,
    local_date DATE NOT NULL,
    timezone TEXT,
    tz_offset_minutes INTEGER,
    quantity DOUBLE PRECISION,
    unit TEXT,
    scheduled_instance_id TEXT,
    input_path TEXT,
    sync_status TEXT NOT NULL DEFAULT 'synced',
    client_request_id TEXT,
    source_table TEXT,
    source_id UUID,
    env_status TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    undone_at TIMESTAMPTZ,
    CONSTRAINT medication_use_kind_chk CHECK (
        use_kind IN ('scheduled', 'as_needed', 'unspecified')
    ),
    CONSTRAINT medication_use_sync_chk CHECK (
        sync_status IN ('local_pending', 'syncing', 'synced')
    ),
    CONSTRAINT medication_use_env_chk CHECK (
        env_status IS NULL OR env_status IN (
            'pending', 'ready', 'unavailable', 'failed'
        )
    )
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_medication_use_client_request
    ON public.medication_use_events (patient_id, client_request_id)
    WHERE client_request_id IS NOT NULL AND undone_at IS NULL;

CREATE INDEX IF NOT EXISTS idx_medication_use_patient_date
    ON public.medication_use_events (patient_id, local_date, occurred_at);

ALTER TABLE public.medication_use_events ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS medication_use_events_own ON public.medication_use_events;
CREATE POLICY medication_use_events_own
    ON public.medication_use_events FOR ALL TO authenticated
    USING (patient_id = auth.uid())
    WITH CHECK (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 6) Environment snapshots at event time (current cache is a different row)
-- ---------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.environment_snapshots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    provider TEXT,
    metric TEXT NOT NULL,
    value DOUBLE PRECISION,
    unit TEXT,
    observed_at TIMESTAMPTZ,
    fetched_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    location_label TEXT,
    location_precision TEXT,
    source_kind TEXT,
    quality TEXT,
    event_local_date DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT environment_snapshots_metric_chk CHECK (
        metric IN ('aqi', 'outdoor_humidity', 'pm25', 'no2', 'pollen')
    ),
    CONSTRAINT environment_snapshots_kind_chk CHECK (
        source_kind IS NULL OR source_kind IN (
            'observation', 'forecast', 'model'
        )
    )
);

CREATE INDEX IF NOT EXISTS idx_environment_snapshots_patient
    ON public.environment_snapshots (patient_id, event_local_date, fetched_at DESC);

ALTER TABLE public.environment_snapshots ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS environment_snapshots_own ON public.environment_snapshots;
CREATE POLICY environment_snapshots_own
    ON public.environment_snapshots FOR ALL TO authenticated
    USING (patient_id = auth.uid())
    WITH CHECK (patient_id = auth.uid());

CREATE TABLE IF NOT EXISTS public.environment_event_links (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    snapshot_id UUID NOT NULL REFERENCES public.environment_snapshots (id)
        ON DELETE CASCADE,
    event_kind TEXT NOT NULL,
    event_id UUID NOT NULL,
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    UNIQUE (event_kind, event_id, snapshot_id)
);

ALTER TABLE public.environment_event_links ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS environment_event_links_own ON public.environment_event_links;
CREATE POLICY environment_event_links_own
    ON public.environment_event_links FOR ALL TO authenticated
    USING (patient_id = auth.uid())
    WITH CHECK (patient_id = auth.uid());

-- ---------------------------------------------------------------------------
-- 7) Consent: keep existing rows. Add locale + purpose notes only.
-- ---------------------------------------------------------------------------
ALTER TABLE public.consent_events
    ADD COLUMN IF NOT EXISTS locale TEXT,
    ADD COLUMN IF NOT EXISTS purpose_detail TEXT;

-- Existing letter_processing rows remain the valid letter-analysis consent.
-- Medication-label and translation are separate purposes.

-- ---------------------------------------------------------------------------
-- 8) Evidence: per-event ids on the existing snapshot row
-- ---------------------------------------------------------------------------
ALTER TABLE public.case_evidence
    ADD COLUMN IF NOT EXISTS source_event_ids JSONB NOT NULL DEFAULT '[]'::JSONB,
    ADD COLUMN IF NOT EXISTS linked_range_label TEXT;
