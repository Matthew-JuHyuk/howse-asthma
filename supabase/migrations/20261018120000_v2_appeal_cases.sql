-- v2 appeal-prep tables. Additive only: no existing table is dropped or renamed.
-- Apply with `supabase db push` before any client writes to these tables.
-- This migration does not enable live document reading.

CREATE TABLE IF NOT EXISTS public.appeal_cases (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    title TEXT CHECK (title IS NULL OR char_length(title) <= 160),
    ui_language VARCHAR(10) NOT NULL DEFAULT 'en',
    status VARCHAR(32) NOT NULL DEFAULT 'draft',
    current_document_revision INTEGER NOT NULL DEFAULT 0,
    current_fact_revision INTEGER NOT NULL DEFAULT 0,
    timezone TEXT NOT NULL DEFAULT 'UTC',
    demo_mode BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT appeal_cases_status_chk CHECK (status IN (
        'draft', 'uploaded', 'processing', 'needs_review', 'ready_for_draft',
        'draft_ready', 'failed', 'deleting', 'deleted'
    ))
);

CREATE INDEX IF NOT EXISTS idx_appeal_cases_owner_updated
    ON public.appeal_cases (owner_id, updated_at DESC);

CREATE TABLE IF NOT EXISTS public.case_documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    revision INTEGER NOT NULL,
    object_path TEXT NOT NULL,
    mime TEXT NOT NULL,
    bytes INTEGER NOT NULL CHECK (bytes >= 0 AND bytes <= 20971520),
    sha256 TEXT NOT NULL,
    upload_status VARCHAR(20) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT case_documents_revision_unique UNIQUE (case_id, revision),
    CONSTRAINT case_documents_upload_status_chk CHECK (
        upload_status IN ('pending', 'uploaded', 'rejected')
    )
);

CREATE TABLE IF NOT EXISTS public.document_pages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    document_id UUID NOT NULL REFERENCES public.case_documents (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    page_index INTEGER NOT NULL CHECK (page_index >= 0),
    order_index INTEGER NOT NULL CHECK (order_index >= 0),
    extracted_text TEXT,
    quality_flags TEXT[] NOT NULL DEFAULT '{}',
    CONSTRAINT document_pages_order_unique UNIQUE (document_id, order_index)
);

CREATE TABLE IF NOT EXISTS public.case_facts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    revision INTEGER NOT NULL,
    schema_version TEXT NOT NULL,
    structured_json JSONB NOT NULL,
    reviewed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT case_facts_revision_unique UNIQUE (case_id, revision)
);

CREATE INDEX IF NOT EXISTS idx_case_facts_case_revision
    ON public.case_facts (case_id, revision);

CREATE TABLE IF NOT EXISTS public.fact_edits (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    fact_revision INTEGER NOT NULL,
    field_path TEXT NOT NULL,
    old_value JSONB,
    new_value JSONB,
    actor_id UUID NOT NULL,
    edited_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE IF NOT EXISTS public.case_evidence (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    original_record_type TEXT NOT NULL,
    original_record_id UUID,
    date_range JSONB,
    snapshot_json JSONB NOT NULL,
    source_type TEXT NOT NULL,
    included BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE IF NOT EXISTS public.evidence_catalog (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    source_url TEXT NOT NULL,
    section TEXT,
    approved_excerpt TEXT NOT NULL,
    applicability_json JSONB NOT NULL DEFAULT '{}'::JSONB,
    reviewer TEXT,
    reviewed_at TIMESTAMPTZ,
    version TEXT NOT NULL,
    status VARCHAR(20) NOT NULL,
    expires_at TIMESTAMPTZ,
    CONSTRAINT evidence_catalog_status_chk CHECK (
        status IN ('draft', 'approved', 'expired', 'rejected')
    )
);

CREATE TABLE IF NOT EXISTS public.generated_artifacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    language VARCHAR(10) NOT NULL,
    fact_revision INTEGER NOT NULL,
    evidence_revision INTEGER,
    catalog_versions TEXT[] NOT NULL DEFAULT '{}',
    template_version TEXT NOT NULL,
    prompt_version TEXT,
    object_path TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'ready',
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE IF NOT EXISTS public.processing_jobs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    case_id UUID NOT NULL REFERENCES public.appeal_cases (id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    kind TEXT NOT NULL,
    idempotency_key TEXT NOT NULL,
    input_revision TEXT NOT NULL,
    status VARCHAR(20) NOT NULL,
    step TEXT,
    attempt_count INTEGER NOT NULL DEFAULT 0,
    error_code TEXT,
    lease_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    finished_at TIMESTAMPTZ,
    CONSTRAINT processing_jobs_idem_unique UNIQUE (case_id, kind, idempotency_key),
    CONSTRAINT processing_jobs_status_chk CHECK (
        status IN ('queued', 'running', 'succeeded', 'failed', 'cancelled')
    )
);

CREATE INDEX IF NOT EXISTS idx_processing_jobs_status_lease
    ON public.processing_jobs (status, lease_until);

CREATE TABLE IF NOT EXISTS public.consent_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    purpose TEXT NOT NULL,
    version TEXT NOT NULL,
    accepted_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    revoked_at TIMESTAMPTZ
);

CREATE TABLE IF NOT EXISTS public.audit_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    case_id UUID,
    event_type TEXT NOT NULL,
    actor_type TEXT NOT NULL,
    occurred_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    safe_metadata JSONB NOT NULL DEFAULT '{}'::JSONB
);

CREATE OR REPLACE FUNCTION public.appeal_child_owner_matches()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    parent_owner UUID;
BEGIN
    SELECT owner_id INTO parent_owner
    FROM public.appeal_cases
    WHERE id = NEW.case_id;
    IF parent_owner IS NULL OR parent_owner <> NEW.owner_id THEN
        RAISE EXCEPTION 'appeal owner mismatch' USING ERRCODE = '42501';
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS case_documents_owner_match ON public.case_documents;
CREATE TRIGGER case_documents_owner_match
    BEFORE INSERT OR UPDATE ON public.case_documents
    FOR EACH ROW EXECUTE FUNCTION public.appeal_child_owner_matches();

DROP TRIGGER IF EXISTS case_facts_owner_match ON public.case_facts;
CREATE TRIGGER case_facts_owner_match
    BEFORE INSERT OR UPDATE ON public.case_facts
    FOR EACH ROW EXECUTE FUNCTION public.appeal_child_owner_matches();

DROP TRIGGER IF EXISTS fact_edits_owner_match ON public.fact_edits;
CREATE TRIGGER fact_edits_owner_match
    BEFORE INSERT OR UPDATE ON public.fact_edits
    FOR EACH ROW EXECUTE FUNCTION public.appeal_child_owner_matches();

DROP TRIGGER IF EXISTS case_evidence_owner_match ON public.case_evidence;
CREATE TRIGGER case_evidence_owner_match
    BEFORE INSERT OR UPDATE ON public.case_evidence
    FOR EACH ROW EXECUTE FUNCTION public.appeal_child_owner_matches();

DROP TRIGGER IF EXISTS generated_artifacts_owner_match ON public.generated_artifacts;
CREATE TRIGGER generated_artifacts_owner_match
    BEFORE INSERT OR UPDATE ON public.generated_artifacts
    FOR EACH ROW EXECUTE FUNCTION public.appeal_child_owner_matches();

DROP TRIGGER IF EXISTS processing_jobs_owner_match ON public.processing_jobs;
CREATE TRIGGER processing_jobs_owner_match
    BEFORE INSERT OR UPDATE ON public.processing_jobs
    FOR EACH ROW EXECUTE FUNCTION public.appeal_child_owner_matches();

ALTER TABLE public.appeal_cases ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.case_documents ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.document_pages ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.case_facts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.fact_edits ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.case_evidence ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.evidence_catalog ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.generated_artifacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.processing_jobs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.consent_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.audit_events ENABLE ROW LEVEL SECURITY;

CREATE POLICY appeal_cases_select_own
    ON public.appeal_cases FOR SELECT TO authenticated
    USING (owner_id = auth.uid() AND deleted_at IS NULL);

CREATE POLICY appeal_cases_insert_own
    ON public.appeal_cases FOR INSERT TO authenticated
    WITH CHECK (owner_id = auth.uid());

CREATE POLICY appeal_cases_update_own
    ON public.appeal_cases FOR UPDATE TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (owner_id = auth.uid());

CREATE POLICY appeal_cases_delete_own
    ON public.appeal_cases FOR DELETE TO authenticated
    USING (owner_id = auth.uid());

CREATE POLICY case_documents_own
    ON public.case_documents FOR ALL TO authenticated
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

CREATE POLICY document_pages_own
    ON public.document_pages FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (
        owner_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM public.case_documents d
            WHERE d.id = document_id AND d.owner_id = auth.uid()
        )
    );

CREATE POLICY case_facts_own
    ON public.case_facts FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (
        owner_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM public.appeal_cases c
            WHERE c.id = case_id AND c.owner_id = auth.uid()
        )
    );

CREATE POLICY fact_edits_own
    ON public.fact_edits FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (owner_id = auth.uid() AND actor_id = auth.uid());

CREATE POLICY case_evidence_own
    ON public.case_evidence FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (owner_id = auth.uid());

CREATE POLICY evidence_catalog_select_approved
    ON public.evidence_catalog FOR SELECT TO authenticated
    USING (
        status = 'approved'
        AND reviewed_at IS NOT NULL
        AND (expires_at IS NULL OR expires_at > TIMEZONE('utc', NOW()))
    );

CREATE POLICY generated_artifacts_own
    ON public.generated_artifacts FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (owner_id = auth.uid());

CREATE POLICY processing_jobs_own
    ON public.processing_jobs FOR ALL TO authenticated
    USING (
        owner_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM public.appeal_cases c
            WHERE c.id = case_id
              AND c.owner_id = auth.uid()
              AND c.deleted_at IS NULL
        )
    )
    WITH CHECK (
        owner_id = auth.uid()
        AND EXISTS (
            SELECT 1 FROM public.appeal_cases c
            WHERE c.id = case_id
              AND c.owner_id = auth.uid()
              AND c.deleted_at IS NULL
        )
    );

CREATE POLICY consent_events_own
    ON public.consent_events FOR ALL TO authenticated
    USING (owner_id = auth.uid())
    WITH CHECK (owner_id = auth.uid());

CREATE POLICY audit_events_select_own
    ON public.audit_events FOR SELECT TO authenticated
    USING (owner_id = auth.uid());

CREATE POLICY audit_events_insert_own
    ON public.audit_events FOR INSERT TO authenticated
    WITH CHECK (owner_id = auth.uid());

INSERT INTO storage.buckets (id, name, public, file_size_limit)
VALUES ('appeal-documents', 'appeal-documents', FALSE, 20971520)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY appeal_documents_select_own
    ON storage.objects FOR SELECT TO authenticated
    USING (
        bucket_id = 'appeal-documents'
        AND (storage.foldername(name))[1] = auth.uid()::TEXT
    );

CREATE POLICY appeal_documents_insert_own
    ON storage.objects FOR INSERT TO authenticated
    WITH CHECK (
        bucket_id = 'appeal-documents'
        AND (storage.foldername(name))[1] = auth.uid()::TEXT
    );

CREATE POLICY appeal_documents_delete_own
    ON storage.objects FOR DELETE TO authenticated
    USING (
        bucket_id = 'appeal-documents'
        AND (storage.foldername(name))[1] = auth.uid()::TEXT
    );
