// Live analysis check against the deployed analyze-letter function.
//
//   node tool/analyze_probe.mjs health
//   node tool/analyze_probe.mjs run <file> [<file> ...] [--expect <expected.json>]
//
// "run" signs in as demo account A, creates a new (non-demo) case, uploads the
// given files (PDF/JPEG/PNG), starts analysis and polls the job. It prints the
// timing, token use and the extracted fields. With --expect, the result is
// compared to an answer file kept outside the app; the server never sees it.
// Never prints tokens, keys or passwords.

import { existsSync, readFileSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { basename, extname } from 'node:path';

function loadEnv(path) {
  const out = {};
  if (!existsSync(path)) return out;
  for (const line of readFileSync(path, 'utf8').split(/\r?\n/)) {
    const m = line.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/);
    if (m) out[m[1]] = m[2].trim();
  }
  return out;
}

const env = loadEnv('.env');
const demo = loadEnv('.env.demo');
const BASE = env.SUPABASE_URL;
const ANON = env.SUPABASE_ANON_KEY;

async function http(method, path, { token, body, headers = {}, raw = false } = {}) {
  const res = await fetch(`${BASE}${path}`, {
    method,
    headers: {
      apikey: ANON,
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      ...(body !== undefined && !raw ? { 'Content-Type': 'application/json' } : {}),
      ...headers,
    },
    body: body === undefined ? undefined : raw ? body : JSON.stringify(body),
  });
  const text = await res.text();
  let json = null;
  try { json = text ? JSON.parse(text) : null; } catch (_) { /* not JSON */ }
  return { status: res.status, json };
}

async function signIn() {
  const r = await http('POST', '/auth/v1/token?grant_type=password', {
    body: { email: demo.DEMO_A_EMAIL, password: demo.DEMO_A_PASSWORD },
  });
  if (r.status !== 200) throw new Error(`sign-in failed: HTTP ${r.status}`);
  return { token: r.json.access_token, uid: r.json.user.id };
}

const MIME = { '.pdf': 'application/pdf', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg', '.png': 'image/png', '.txt': 'text/plain' };

async function run(files, expectPath) {
  const { token, uid } = await signIn();
  const t0 = Date.now();
  const cr = await http('POST', '/rest/v1/appeal_cases?select=id', {
    token, headers: { Prefer: 'return=representation' },
    body: { owner_id: uid, status: 'uploaded', demo_mode: false, current_document_revision: 1, timezone: 'America/New_York', ui_language: 'en' },
  });
  if (cr.status >= 300) throw new Error(`case create failed: HTTP ${cr.status}`);
  const caseId = cr.json[0].id;
  let i = 0;
  for (const f of files) {
    const mime = MIME[extname(f).toLowerCase()];
    if (!mime) throw new Error(`unsupported file type: ${basename(f)}`);
    const bytes = readFileSync(f);
    const sha = createHash('sha256').update(bytes).digest('hex');
    const path = `${uid}/${caseId}/set1-${i}${extname(f).toLowerCase()}`;
    const up = await http('POST', `/storage/v1/object/appeal-documents/${path}`, {
      token, body: bytes, raw: true, headers: { 'Content-Type': mime, 'x-upsert': 'true' },
    });
    if (up.status >= 300) throw new Error(`upload failed: HTTP ${up.status}`);
    const doc = await http('POST', '/rest/v1/case_documents', {
      token, headers: { Prefer: 'return=minimal' },
      body: { case_id: caseId, owner_id: uid, revision: i + 1, set_revision: 1, file_index: i, object_path: path, mime, bytes: bytes.length, sha256: sha, upload_status: 'uploaded' },
    });
    if (doc.status >= 300) throw new Error(`document row failed: HTTP ${doc.status}`);
    i++;
  }
  const tUp = Date.now();
  const st = await http('POST', '/functions/v1/analyze-letter', { token, body: { action: 'start', case_id: caseId, set_revision: 1 } });
  console.log(JSON.stringify({ start_status: st.status, start: st.json?.error ?? st.json?.job?.status ?? null }));
  if (st.status >= 300) return;
  let job = st.json.job;
  while (job.status === 'queued' || job.status === 'running') {
    await new Promise((r) => setTimeout(r, 2500));
    const j = await http('GET', `/rest/v1/processing_jobs?id=eq.${job.id}&select=*`, { token });
    job = j.json[0];
    if (Date.now() - tUp > 240000) break;
  }
  const facts = await http('GET', `/rest/v1/case_facts?case_id=eq.${caseId}&select=revision,structured_json&order=revision.desc&limit=1`, { token });
  const reqs = await http('GET', `/rest/v1/case_requirements?case_id=eq.${caseId}&select=label,responsible,source_page&order=sort_order`, { token });
  const f = facts.json?.[0]?.structured_json;
  const summary = {
    case_id: caseId,
    job_status: job.status,
    error_code: job.error_code ?? null,
    provider: job.provider, model: job.model, prompt_version: job.prompt_version,
    attempts: job.attempt_count,
    upload_ms: tUp - t0,
    analysis_ms: Date.now() - tUp,
    server_duration_ms: job.duration_ms,
    input_tokens: job.input_tokens, output_tokens: job.output_tokens,
    document_kind: f?.document_kind?.value ?? null,
    fields: f ? Object.fromEntries(Object.entries(f.fields).map(([k, v]) => [k, v.value === null ? null : `${v.value} [${v.status}, p${v.page}]`])) : null,
    reasons: f?.reasons?.map((r) => `${r.code}: ${r.text}`) ?? null,
    deadlines: f?.deadlines?.map((d) => `${d.purpose}/${d.kind} ${d.date ?? (d.duration_value ? `${d.duration_value} ${d.duration_unit} from ${d.anchor}` : '')} [${d.status}${d.validation ? ':' + d.validation : ''}]`) ?? null,
    deadline_state: f?.deadline_state ?? null,
    requested_items: reqs.json?.map((r) => `${r.label} (${r.responsible})`) ?? null,
    pages: f?.pages ?? null,
    warnings: f?.warnings ?? null,
  };
  console.log(JSON.stringify(summary, null, 2));
  if (expectPath && f) compare(f, JSON.parse(readFileSync(expectPath, 'utf8')));
}

function norm(s) { return String(s ?? '').toLowerCase().replace(/\s+/g, ' ').trim(); }

function compare(f, expect) {
  const rows = [];
  for (const [k, v] of Object.entries(expect.fields ?? {})) {
    const got = f.fields[k]?.value ?? null;
    rows.push({ item: k, expected: v, got, ok: v === null ? got === null : norm(got) === norm(v) });
  }
  if ('document_kind' in expect) rows.push({ item: 'document_kind', expected: expect.document_kind, got: f.document_kind.value, ok: f.document_kind.value === expect.document_kind });
  for (const d of expect.deadlines ?? []) {
    const hit = f.deadlines.find((x) => x.purpose === d.purpose && x.kind === d.kind && (d.date ? x.date === d.date : true) && (d.duration_value ? x.duration_value === d.duration_value : true));
    rows.push({ item: `deadline ${d.purpose}/${d.kind}`, expected: d.date ?? `${d.duration_value} ${d.duration_unit ?? ''}`, got: hit ? (hit.date ?? hit.duration_value) : null, ok: !!hit && hit.status === 'extracted' });
  }
  if ('conflict' in expect) rows.push({ item: 'deadline conflict', expected: expect.conflict, got: f.deadline_state.conflict, ok: f.deadline_state.conflict === expect.conflict });
  for (const code of expect.reason_codes ?? []) {
    rows.push({ item: `reason ${code}`, expected: true, got: f.reasons.some((r) => r.code === code), ok: f.reasons.some((r) => r.code === code) });
  }
  for (const label of expect.requested_contains ?? []) {
    const ok = f.requested_items.some((r) => norm(r.label).includes(norm(label)) || norm(r.quote).includes(norm(label)));
    rows.push({ item: `requested ~ ${label}`, expected: true, got: ok, ok });
  }
  for (const r of rows) console.log(JSON.stringify(r));
  console.log(JSON.stringify({ compared: rows.length, mismatches: rows.filter((r) => !r.ok).length }));
}

const args = process.argv.slice(2);
try {
  if (args[0] === 'health') {
    const { token } = await signIn();
    const r = await http('POST', '/functions/v1/analyze-letter', { token, body: { action: 'health' } });
    console.log(JSON.stringify({ status: r.status, ...r.json }));
  } else if (args[0] === 'run') {
    const ei = args.indexOf('--expect');
    const expectPath = ei >= 0 ? args[ei + 1] : null;
    const rest = args.slice(1);
    const files = rest.filter((a, idx) => a !== '--expect' && rest[idx - 1] !== '--expect');
    await run(files, expectPath);
  } else {
    console.log('usage: node tool/analyze_probe.mjs health | run <file>... [--expect expected.json]');
  }
} catch (e) {
  console.error(String(e.message ?? e));
  process.exitCode = 1;
}
