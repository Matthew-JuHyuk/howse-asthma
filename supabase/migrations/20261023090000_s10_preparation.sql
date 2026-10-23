-- Sprint10 additive preparation state and source-preserving event batches.
ALTER TABLE public.appeal_cases ADD COLUMN case_start_reason text
 CHECK(case_start_reason IN ('new_request','denied_request'));
CREATE TABLE public.case_preparations (
 case_id uuid PRIMARY KEY REFERENCES public.appeal_cases(id) ON DELETE CASCADE,
 owner_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
 revision integer NOT NULL DEFAULT 1,
 payload jsonb NOT NULL CHECK(jsonb_typeof(payload)='object'),
 updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE TABLE public.treatment_events (
 id uuid PRIMARY KEY,
 owner_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
 patient_key text NOT NULL,
 source_id uuid NOT NULL,
 local_date date NOT NULL,
 kind text NOT NULL CHECK(kind IN ('symptom','medication_use','urgent_visit','clinical_document','environment')),
 payload jsonb NOT NULL,
 undone_at timestamptz,
 created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX ON public.treatment_events(owner_id,patient_key,local_date);
ALTER TABLE public.case_preparations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.treatment_events ENABLE ROW LEVEL SECURITY;
CREATE POLICY preparation_owner ON public.case_preparations FOR ALL TO authenticated
 USING(owner_id=auth.uid()) WITH CHECK(owner_id=auth.uid() AND EXISTS(
 SELECT 1 FROM public.appeal_cases c WHERE c.id=case_id AND c.owner_id=auth.uid()));
CREATE POLICY treatment_owner ON public.treatment_events FOR ALL TO authenticated
 USING(owner_id=auth.uid()) WITH CHECK(owner_id=auth.uid() AND (patient_key=auth.uid()::text OR patient_key LIKE auth.uid()::text || '/%'));
GRANT SELECT,INSERT,UPDATE,DELETE ON public.case_preparations,public.treatment_events TO authenticated;

CREATE FUNCTION public.save_preparation(p_case_id uuid,p_revision integer,p_payload jsonb)
RETURNS integer LANGUAGE plpgsql SECURITY INVOKER SET search_path=public AS $$
DECLARE next_rev integer;
BEGIN
 IF auth.uid() IS NULL OR NOT coalesce((p_payload->>'patient_key')=auth.uid()::text OR (p_payload->>'patient_key') LIKE auth.uid()::text || '/%',false) OR
    (p_payload->>'id') IS DISTINCT FROM p_case_id::text THEN RAISE EXCEPTION 'invalid_patient'; END IF;
 IF NOT EXISTS(SELECT 1 FROM appeal_cases WHERE id=p_case_id AND owner_id=auth.uid() AND status<>'deleting') THEN
   RAISE EXCEPTION 'case_not_found'; END IF;
 IF p_revision=0 THEN
  INSERT INTO case_preparations(case_id,owner_id,payload) VALUES(p_case_id,auth.uid(),p_payload)
   ON CONFLICT DO NOTHING RETURNING revision INTO next_rev;
 ELSE
  UPDATE case_preparations SET payload=p_payload,revision=revision+1,updated_at=now()
   WHERE case_id=p_case_id AND revision=p_revision RETURNING revision INTO next_rev;
 END IF;
 IF next_rev IS NULL THEN RAISE EXCEPTION 'stale_preparation'; END IF;
 UPDATE appeal_cases SET title=coalesce(nullif(p_payload->>'proposed_medication',''),nullif(p_payload->>'current_medication',''),'Treatment review'),
  case_start_reason=CASE WHEN p_payload->>'path'='deniedRequest' THEN 'denied_request' ELSE 'new_request' END,
  lifecycle=coalesce(p_payload->>'lifecycle','active'),
  updated_at=now() WHERE id=p_case_id;
 RETURN next_rev;
END $$;

CREATE FUNCTION public.create_preparation(p_payload jsonb)
RETURNS integer LANGUAGE plpgsql SECURITY INVOKER SET search_path=public AS $$
DECLARE cid uuid := (p_payload->>'id')::uuid;
BEGIN
 IF auth.uid() IS NULL OR NOT coalesce((p_payload->>'patient_key')=auth.uid()::text OR (p_payload->>'patient_key') LIKE auth.uid()::text || '/%',false) OR cid IS NULL THEN
  RAISE EXCEPTION 'invalid_patient'; END IF;
 INSERT INTO appeal_cases(id,owner_id,title,status,treatment_context,case_start_reason)
 VALUES(cid,auth.uid(),coalesce(nullif(p_payload->>'proposed_medication',''),'Treatment review'),'draft','asthma','new_request');
 INSERT INTO case_preparations(case_id,owner_id,payload) VALUES(cid,auth.uid(),p_payload);
 RETURN 1;
END $$;

CREATE FUNCTION public.save_treatment_batch(p_events jsonb)
RETURNS void LANGUAGE plpgsql SECURITY INVOKER SET search_path=public AS $$
DECLARE e jsonb; eid uuid; did_insert integer;
BEGIN
 IF auth.uid() IS NULL OR jsonb_typeof(p_events)<>'array' OR jsonb_array_length(p_events)>12 OR jsonb_array_length(p_events)<1 THEN
  RAISE EXCEPTION 'invalid_batch'; END IF;
 FOR e IN SELECT * FROM jsonb_array_elements(p_events) LOOP
  IF NOT coalesce((e->>'patient_key')=auth.uid()::text OR (e->>'patient_key') LIKE auth.uid()::text || '/%',false) OR coalesce((e->>'synthetic')::boolean,false) THEN RAISE EXCEPTION 'invalid_patient'; END IF;
  eid := (e->>'id')::uuid;
  INSERT INTO treatment_events(id,owner_id,patient_key,source_id,local_date,kind,payload)
   VALUES(eid,auth.uid(),e->>'patient_key',(e->>'source_id')::uuid,(e->>'day')::date,e->>'kind',e)
   ON CONFLICT(id) DO NOTHING;
  GET DIAGNOSTICS did_insert=ROW_COUNT;
  IF did_insert=0 THEN
   IF NOT EXISTS(SELECT 1 FROM treatment_events WHERE id=eid AND owner_id=auth.uid() AND payload=e) THEN
    RAISE EXCEPTION 'request_conflict'; END IF;
   CONTINUE;
  END IF;
  -- Mirror confirmed app events into Sprint9 tables in the SAME transaction.
  IF e->>'patient_key'=auth.uid()::text AND e->>'kind'='medication_use' AND coalesce(e#>>'{values,negated}','false')<>'true' THEN
   INSERT INTO medication_use_events(id,patient_id,use_kind,occurred_at,local_date,timezone,tz_offset_minutes,
    medication_name,quantity,unit,input_path,client_request_id,sync_status,env_status)
   VALUES(eid,auth.uid(),coalesce(e#>>'{values,use_kind}','unspecified'),
    coalesce(nullif(e#>>'{values,occurred_at}','')::timestamptz,(e->>'day')::date::timestamptz),
    (e->>'day')::date,'user_confirmed',0,nullif(e#>>'{values,medication}',''),
    nullif(e#>>'{values,quantity}','')::numeric,nullif(e#>>'{values,unit}',''),
    coalesce(e#>>'{values,input_path}','voice'),eid::text,'synced','pending');
  ELSIF e->>'patient_key'=auth.uid()::text AND e->>'kind'='symptom' AND coalesce(e#>>'{values,negated}','false')<>'true' THEN
   INSERT INTO symptom_entries(id,patient_id,recorded_at,occurred_at,tz_offset_minutes,symptoms,no_symptoms,other_text,note,source_language)
   VALUES(eid,auth.uid(),(e->>'day')::date::timestamptz,(e->>'day')::date::timestamptz,0,
    array_remove(ARRAY[
      CASE WHEN e#>>'{values,symptom}' IN ('cough','wheeze','short_breath','night_waking','activity_limited') THEN e#>>'{values,symptom}' ELSE null END,
      CASE WHEN coalesce(nullif(e#>>'{values,night_wakings}','')::numeric,0)>0 AND coalesce(e#>>'{values,symptom}','')<>'night_waking' THEN 'night_waking' ELSE null END
    ],null),
    false,CASE WHEN e#>>'{values,symptom}' IN ('cough','wheeze','short_breath','night_waking','activity_limited') THEN null ELSE 'Patient report — see source' END,
    left(e->>'text',1000),e#>>'{values,language}');
  END IF;
 END LOOP;
END $$;

CREATE FUNCTION public.undo_treatment_source(p_source uuid)
RETURNS void LANGUAGE plpgsql SECURITY INVOKER SET search_path=public AS $$
BEGIN
 UPDATE medication_use_events SET undone_at=now() WHERE patient_id=auth.uid() AND id IN
  (SELECT id FROM treatment_events WHERE source_id=p_source AND owner_id=auth.uid());
 DELETE FROM symptom_entries WHERE patient_id=auth.uid() AND id IN
  (SELECT id FROM treatment_events WHERE source_id=p_source AND owner_id=auth.uid());
 UPDATE treatment_events SET undone_at=now() WHERE owner_id=auth.uid() AND source_id=p_source;
END $$;
REVOKE ALL ON FUNCTION public.create_preparation(jsonb),public.save_preparation(uuid,integer,jsonb),public.save_treatment_batch(jsonb),public.undo_treatment_source(uuid) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.create_preparation(jsonb),public.save_preparation(uuid,integer,jsonb),public.save_treatment_batch(jsonb),public.undo_treatment_source(uuid) TO authenticated;
