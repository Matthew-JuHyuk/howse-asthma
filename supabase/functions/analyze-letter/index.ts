// analyze-letter — reads an uploaded insurance letter with the configured model.
//
// Actions (POST JSON, user JWT required):
//   { action: "health" }                       -> { ai_configured, provider, model, prompt_version, missing }
//   { action: "start", case_id, set_revision }  -> 202 { job }
//
// The job row is the durable record. Work runs in EdgeRuntime.waitUntil under a
// lease. If the worker dies, the lease expires and a later "start" call with
// the same case/set reclaims the job (bounded attempts). A finished job is
// returned as-is, so repeated taps never start a second paid call.
// Results are written only if the case still exists, is not being deleted,
// and still points at the same upload set.

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { requireUser } from "../_shared/user_client.ts";
import { encodeBase64 } from "jsr:@std/encoding@1/base64";
import type { SupabaseClient } from "npm:@supabase/supabase-js@2";

import {
  EXTRACT_SCHEMA,
  EXTRACT_SYSTEM,
  extractUserText,
  PROMPT_VERSION,
  TRANSCRIBE_SCHEMA,
  TRANSCRIBE_SYSTEM,
} from "./prompts.ts";
import { callModel, ProviderError, readProviderConfig, type InputFile, type ProviderConfig } from "./providers.ts";
import { handleReadLabel, handleTranslate, handleTranslateFields } from "./extra.ts";
import { handlePreparation } from "./preparation.ts";
import {
  FACTS_SCHEMA_VERSION,
  responsibleFor,
  validateExtraction,
  type PageText,
  type RawExtraction,
} from "./validate.ts";

declare const EdgeRuntime: { waitUntil(p: Promise<unknown>): void } | undefined;

const BUCKET = "appeal-documents";
const LEASE_MS = 170_000;
const MAX_ATTEMPTS = 5;
const MAX_SET_BYTES = 40 * 1024 * 1024;
const MAX_PAGES = 10;
const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

type Job = {
  id: string;
  case_id: string;
  owner_id: string;
  status: string;
  attempt_count: number;
  lease_until: string | null;
  error_code: string | null;
};

const JOB_COLUMNS =
  "id, case_id, owner_id, kind, status, step, attempt_count, lease_until, error_code, " +
  "provider, model, prompt_version, provider_request_ids, duration_ms, input_tokens, " +
  "output_tokens, result_fact_revision, created_at, started_at, finished_at, updated_at";

function log(ev: string, extra: Record<string, unknown> = {}) {
  console.log(JSON.stringify({ fn: "analyze-letter", ev, ...extra }));
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return jsonResponse({ error: "method_not_allowed" }, 405);

  const auth = await requireUser(req);
  if (auth instanceof Response) return auth;
  const { user, userClient, admin } = auth;

  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch (_) {
    return jsonResponse({ error: "invalid_json" }, 400);
  }

  const cfg = readProviderConfig();
  if (body.action === "health") {
    return jsonResponse({
      ai_configured: !("missing" in cfg),
      provider: "missing" in cfg ? null : cfg.provider,
      model: "missing" in cfg ? null : cfg.model,
      missing: "missing" in cfg ? cfg.missing : null,
      prompt_version: PROMPT_VERSION,
    });
  }
  if (body.action === "translate") {
    if ("missing" in cfg) return jsonResponse({ error: "ai_not_configured" }, 503);
    const out = await handleTranslate(userClient, user.id, cfg, body);
    if (out.error) return jsonResponse({ error: out.error }, out.error === "consent_required" ? 403 : 400);
    return jsonResponse({ pages: out.pages });
  }
  if (body.action === "translate_fields") {
    if ("missing" in cfg) return jsonResponse({ error: "ai_not_configured" }, 503);
    const out = await handleTranslateFields(userClient, user.id, cfg, body);
    if (out.error) return jsonResponse({ error: out.error }, out.error === "consent_required" ? 403 : 400);
    return jsonResponse({ items: out.items });
  }
  if (body.action === "read_label") {
    if ("missing" in cfg) return jsonResponse({ error: "ai_not_configured" }, 503);
    const out = await handleReadLabel(userClient, user.id, cfg, body);
    if (out.error) return jsonResponse({ error: out.error }, out.error === "consent_required" ? 403 : 400);
    return jsonResponse(out);
  }
  if (body.action === 'structure_record' || body.action === 'read_clinical_document' || body.action === 'translate_preparation') {
    if ('missing' in cfg) return jsonResponse({ error: 'ai_not_configured' }, 503);
    const out = await handlePreparation(userClient, user.id, cfg, body);
    return jsonResponse(out, 'error' in out ? (out.error === 'consent_required' ? 403 : 400) : 200);
  }
  if (body.action !== "start") return jsonResponse({ error: "unknown_action" }, 400);

  const caseId = typeof body.case_id === "string" ? body.case_id : "";
  const setRevision = Number(body.set_revision);
  if (!UUID_RE.test(caseId) || !Number.isInteger(setRevision) || setRevision < 1) {
    return jsonResponse({ error: "invalid_input" }, 400);
  }

  // Ownership check through RLS with the caller's own token.
  const { data: caseRow, error: caseErr } = await userClient
    .from("appeal_cases")
    .select("id, owner_id, status, current_document_revision, deleted_at")
    .eq("id", caseId)
    .maybeSingle();
  if (caseErr) return jsonResponse({ error: "case_lookup_failed" }, 500);
  if (!caseRow || caseRow.owner_id !== user.id || caseRow.deleted_at) {
    return jsonResponse({ error: "case_not_found" }, 404);
  }
  if (caseRow.status === "deleting" || caseRow.status === "deleted") {
    return jsonResponse({ error: "case_not_found" }, 404);
  }
  if (caseRow.current_document_revision !== setRevision) {
    return jsonResponse({ error: "stale_upload_set" }, 409);
  }

  if ("missing" in cfg) {
    log("ai_not_configured", { missing: cfg.missing });
    return jsonResponse({ error: "ai_not_configured" }, 503);
  }

  const idempotencyKey = `extract:set${setRevision}`;
  let job = await findJob(admin, caseId, idempotencyKey);
  if (!job) {
    const { data, error } = await admin
      .from("processing_jobs")
      .insert({
        case_id: caseId,
        owner_id: user.id,
        kind: "extract",
        idempotency_key: idempotencyKey,
        input_revision: String(setRevision),
        status: "queued",
        step: "queued",
        provider: cfg.provider,
        model: cfg.model,
        prompt_version: PROMPT_VERSION,
      })
      .select(JOB_COLUMNS)
      .maybeSingle();
    if (error || !data) {
      job = await findJob(admin, caseId, idempotencyKey); // lost an insert race
      if (!job) return jsonResponse({ error: "job_create_failed" }, 500);
    } else {
      job = data as Job;
    }
  }

  const now = Date.now();
  const leaseLive = job.lease_until != null && Date.parse(job.lease_until) > now;
  if (job.status === "succeeded" || (job.status === "running" && leaseLive)) {
    return jsonResponse({ job }, 202);
  }
  if (job.attempt_count >= MAX_ATTEMPTS) {
    return jsonResponse({ job, error: "attempts_exhausted" }, 202);
  }
  if (job.status === "failed" && body.retry !== true) {
    return jsonResponse({ job }, 202);
  }

  // Claim: only one caller can move attempt_count from N to N+1.
  const { data: claimed } = await admin
    .from("processing_jobs")
    .update({
      status: "running",
      step: "reading",
      attempt_count: job.attempt_count + 1,
      lease_until: new Date(now + LEASE_MS).toISOString(),
      started_at: new Date(now).toISOString(),
      error_code: null,
      finished_at: null,
      provider: cfg.provider,
      model: cfg.model,
      prompt_version: PROMPT_VERSION,
      updated_at: new Date(now).toISOString(),
    })
    .eq("id", job.id)
    .eq("attempt_count", job.attempt_count)
    .select(JOB_COLUMNS)
    .maybeSingle();
  if (!claimed) {
    const current = await findJob(admin, caseId, idempotencyKey);
    return jsonResponse({ job: current ?? job }, 202);
  }

  await admin
    .from("appeal_cases")
    .update({ status: "processing", updated_at: new Date().toISOString() })
    .eq("id", caseId)
    .eq("owner_id", user.id)
    .is("deleted_at", null);

  const work = runJob(admin, cfg, claimed as Job, setRevision).catch((e) => {
    log("unhandled", { job: (claimed as Job).id, err: String((e as Error)?.name ?? "error") });
  });
  if (typeof EdgeRuntime !== "undefined" && EdgeRuntime?.waitUntil) {
    EdgeRuntime.waitUntil(work);
  } else {
    await work;
  }
  return jsonResponse({ job: claimed }, 202);
});

async function findJob(admin: SupabaseClient, caseId: string, key: string): Promise<Job | null> {
  const { data } = await admin
    .from("processing_jobs")
    .select(JOB_COLUMNS)
    .eq("case_id", caseId)
    .eq("kind", "extract")
    .eq("idempotency_key", key)
    .maybeSingle();
  return (data as Job | null) ?? null;
}

async function setStep(admin: SupabaseClient, jobId: string, step: string) {
  await admin
    .from("processing_jobs")
    .update({ step, updated_at: new Date().toISOString() })
    .eq("id", jobId)
    .eq("status", "running");
}

async function caseStillCurrent(admin: SupabaseClient, caseId: string, setRevision: number) {
  const { data } = await admin
    .from("appeal_cases")
    .select("id, status, current_document_revision, current_fact_revision, deleted_at")
    .eq("id", caseId)
    .maybeSingle();
  if (!data || data.deleted_at) return null;
  if (data.status === "deleting" || data.status === "deleted") return null;
  if (data.current_document_revision !== setRevision) return null;
  return data as { current_fact_revision: number };
}

async function runJob(admin: SupabaseClient, cfg: ProviderConfig, job: Job, setRevision: number) {
  const started = Date.now();
  const requestIds: string[] = [];
  let inTok = 0;
  let outTok = 0;
  try {
    const { data: docs, error: docErr } = await admin
      .from("case_documents")
      .select("id, object_path, mime, bytes, file_index")
      .eq("case_id", job.case_id)
      .eq("owner_id", job.owner_id)
      .eq("set_revision", setRevision)
      .eq("upload_status", "uploaded")
      .order("file_index");
    if (docErr) throw new ProviderError("documents_lookup_failed", true);
    if (!docs || docs.length === 0) throw new ProviderError("no_documents", false);
    const total = docs.reduce((n, d) => n + (d.bytes as number), 0);
    if (total > MAX_SET_BYTES) throw new ProviderError("document_too_large", false);

    const files: InputFile[] = [];
    const textPages: string[] = [];
    for (const d of docs) {
      const path = d.object_path as string;
      if (!path.startsWith(`${job.owner_id}/`)) throw new ProviderError("document_owner_mismatch", false);
      const { data: blob, error } = await admin.storage.from(BUCKET).download(path);
      if (error || !blob) throw new ProviderError("document_download_failed", true);
      const bytes = new Uint8Array(await blob.arrayBuffer());
      if (d.mime === "text/plain") {
        textPages.push(new TextDecoder().decode(bytes));
      } else {
        files.push({ mime: d.mime as string, base64: encodeBase64(bytes), name: `file-${d.file_index}` });
      }
    }

    let pages: PageText[] = [];
    if (files.length > 0) {
      await setStep(admin, job.id, "reading");
      const t = await callModel(cfg, {
        system: TRANSCRIBE_SYSTEM,
        files,
        text: "Transcribe every page of these files in order. Output JSON only.",
        schema: TRANSCRIBE_SCHEMA,
        timeoutMs: 80_000,
      });
      if (t.requestId) requestIds.push(t.requestId);
      inTok += t.inputTokens ?? 0;
      outTok += t.outputTokens ?? 0;
      // deno-lint-ignore no-explicit-any
      const raw = (t.json as any)?.pages;
      if (!Array.isArray(raw)) throw new ProviderError("ai_bad_output", true);
      pages = raw
        .filter((p: unknown) => p && typeof (p as PageText).text === "string")
        .map((p: PageText, i: number) => ({
          page_number: i + 1,
          text: String(p.text).slice(0, 20000),
          legibility: String(p.legibility ?? "clear"),
        }));
    }
    for (const text of textPages) {
      pages.push({ page_number: pages.length + 1, text: text.slice(0, 20000), legibility: "clear" });
    }
    if (pages.length === 0) throw new ProviderError("document_unreadable", false);
    if (pages.length > MAX_PAGES) throw new ProviderError("too_many_pages", false);
    if (pages.every((p) => p.legibility === "unreadable" || p.text.replace(/\[unreadable\]/g, "").trim().length < 20)) {
      throw new ProviderError("document_unreadable", false);
    }

    await setStep(admin, job.id, "checking");
    const x = await callModel(cfg, {
      system: EXTRACT_SYSTEM,
      files: [],
      text: extractUserText(pages),
      schema: EXTRACT_SCHEMA,
      timeoutMs: 60_000,
    });
    if (x.requestId) requestIds.push(x.requestId);
    inTok += x.inputTokens ?? 0;
    outTok += x.outputTokens ?? 0;

    const facts = validateExtraction(x.json as RawExtraction, pages);

    const current = await caseStillCurrent(admin, job.case_id, setRevision);
    if (!current) {
      await finishJob(admin, job.id, "cancelled", "case_changed_or_deleted", started, requestIds, inTok, outTok, null);
      return;
    }
    const nextRevision = current.current_fact_revision + 1;

    await admin.from("document_pages").delete().eq("case_id", job.case_id).eq("set_revision", setRevision);
    const firstDocId = docs[0].id as string;
    const pageRows = pages.map((p) => ({
      document_id: firstDocId,
      owner_id: job.owner_id,
      case_id: job.case_id,
      set_revision: setRevision,
      page_index: p.page_number - 1,
      order_index: p.page_number - 1,
      page_number: p.page_number,
      extracted_text: p.text,
      legibility: facts.pages.find((m) => m.page_number === p.page_number)?.legibility ?? "clear",
      quality_flags: [],
    }));
    const { error: pageErr } = await admin.from("document_pages").insert(pageRows);
    if (pageErr) throw new ProviderError("save_failed", true);

    const { error: factErr } = await admin.from("case_facts").insert({
      case_id: job.case_id,
      owner_id: job.owner_id,
      revision: nextRevision,
      schema_version: FACTS_SCHEMA_VERSION,
      structured_json: facts,
    });
    if (factErr) throw new ProviderError("save_failed", true);

    // Replace untouched extracted checklist rows; keep anything the user linked or added.
    await admin
      .from("case_requirements")
      .delete()
      .eq("case_id", job.case_id)
      .eq("origin", "extracted")
      .eq("status", "needed")
      .is("linked_evidence_id", null);
    const items = facts.requested_items.map((it, i) => ({
      case_id: job.case_id,
      owner_id: job.owner_id,
      label: it.label,
      origin: "extracted",
      source_page: it.page,
      source_quote: it.quote,
      status: "needed",
      responsible: responsibleFor(it.label),
      sort_order: i,
      fact_revision: nextRevision,
    }));
    if (items.length > 0) await admin.from("case_requirements").insert(items);

    const med = facts.fields.medication?.value;
    const { data: updated } = await admin
      .from("appeal_cases")
      .update({
        current_fact_revision: nextRevision,
        status: "needs_review",
        document_kind: facts.document_kind.value,
        title: med ? med.slice(0, 160) : null,
        reviewed_fact_revision: null,
        updated_at: new Date().toISOString(),
      })
      .eq("id", job.case_id)
      .eq("current_document_revision", setRevision)
      .is("deleted_at", null)
      .select("id")
      .maybeSingle();
    if (!updated) {
      await finishJob(admin, job.id, "cancelled", "case_changed_or_deleted", started, requestIds, inTok, outTok, null);
      return;
    }
    await admin
      .from("generated_artifacts")
      .update({ status: "stale" })
      .eq("case_id", job.case_id)
      .eq("status", "ready");

    await finishJob(admin, job.id, "succeeded", null, started, requestIds, inTok, outTok, nextRevision);
    log("succeeded", { job: job.id, ms: Date.now() - started, pages: pages.length, warnings: facts.warnings.length });
  } catch (e) {
    const code = e instanceof ProviderError ? e.code : "internal_error";
    log("failed", { job: job.id, code, ms: Date.now() - started });
    await finishJob(admin, job.id, "failed", code, started, requestIds, inTok, outTok, null);
    await admin
      .from("appeal_cases")
      .update({ status: "failed", updated_at: new Date().toISOString() })
      .eq("id", job.case_id)
      .eq("current_document_revision", setRevision)
      .eq("status", "processing")
      .is("deleted_at", null);
  }
}

async function finishJob(
  admin: SupabaseClient,
  jobId: string,
  status: "succeeded" | "failed" | "cancelled",
  errorCode: string | null,
  started: number,
  requestIds: string[],
  inTok: number,
  outTok: number,
  factRevision: number | null,
) {
  const now = new Date().toISOString();
  await admin
    .from("processing_jobs")
    .update({
      status,
      step: status === "succeeded" ? "ready" : status,
      error_code: errorCode,
      finished_at: now,
      lease_until: null,
      duration_ms: Date.now() - started,
      provider_request_ids: requestIds,
      input_tokens: inTok || null,
      output_tokens: outTok || null,
      result_fact_revision: factRevision,
      updated_at: now,
    })
    .eq("id", jobId);
}
