// Demo/test accounts A and B: create, seed, reset, and cross-account isolation check.
//
//   node tool/demo_accounts.mjs create          # sign up A and B if missing (idempotent)
//   node tool/demo_accounts.mjs seed A          # reset A's demo data, then seed 30 days + 3 cases
//   node tool/demo_accounts.mjs seed A --today=2026-10-20   # fix the window end
//   node tool/demo_accounts.mjs reset A         # remove A's demo data only
//   node tool/demo_accounts.mjs isolation       # B tries to read/change/download A's case
//   node tool/demo_accounts.mjs status A        # counts only
//
// Reads SUPABASE_URL / SUPABASE_ANON_KEY from .env and account credentials from
// .env.demo (git-ignored; created on first "create" with random passwords).
// Every request runs as the demo user itself, so row-level security limits it
// to that user's own rows. The script refuses to touch an account whose auth
// metadata is not demo_account=true or whose email is not the configured one.
// Output never includes passwords, tokens, or keys.

import { existsSync, readFileSync, writeFileSync } from 'node:fs';
import { randomBytes } from 'node:crypto';

import { validateExtraction } from '../supabase/functions/analyze-letter/validate.ts';

// The app summarizes the 30 full days before the phone's local today, so
// records are seeded relative to this computer's local date (run it in the
// phone's time zone) unless --today=YYYY-MM-DD is given.
function localToday() {
  const d = new Date();
  const p = (n) => String(n).padStart(2, '0');
  return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}`;
}
const todayArg = process.argv.find((a) => a.startsWith('--today='))?.slice('--today='.length);
if (todayArg && !/^\d{4}-\d{2}-\d{2}$/.test(todayArg)) {
  console.error('--today must be YYYY-MM-DD');
  process.exit(2);
}
const DEMO_TODAY = todayArg ?? localToday();
const RANGE_DAYS = 30;
const RANGE_START = addDays(DEMO_TODAY, -RANGE_DAYS);
const DEMO_TZ_OFFSET_MIN = -240; // America/New_York (EDT) for the whole demo window

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
const BASE = env.SUPABASE_URL;
const ANON = env.SUPABASE_ANON_KEY;
if (!BASE || !ANON) {
  console.error('SUPABASE_URL / SUPABASE_ANON_KEY missing in .env');
  process.exit(2);
}
const projectRef = new URL(BASE).hostname.split('.')[0];

function demoConfig() {
  let demo = loadEnv('.env.demo');
  if (!demo.DEMO_A_EMAIL || !demo.DEMO_B_EMAIL) {
    const recipient = env.TEST_EMAIL_RECIPIENT;
    if (!recipient || !recipient.includes('@')) {
      console.error('Set DEMO_A_EMAIL / DEMO_B_EMAIL in .env.demo or TEST_EMAIL_RECIPIENT in .env');
      process.exit(2);
    }
    const [local, domain] = recipient.split('@');
    demo = {
      DEMO_A_EMAIL: demo.DEMO_A_EMAIL || `${local}+covernote-a@${domain}`,
      DEMO_A_PASSWORD: demo.DEMO_A_PASSWORD || randomBytes(12).toString('base64url'),
      DEMO_B_EMAIL: demo.DEMO_B_EMAIL || `${local}+covernote-b@${domain}`,
      DEMO_B_PASSWORD: demo.DEMO_B_PASSWORD || randomBytes(12).toString('base64url'),
    };
    writeFileSync('.env.demo',
      '# Demo/test accounts for CoverNote. Never commit this file.\n' +
      Object.entries(demo).map(([k, v]) => `${k}=${v}`).join('\n') + '\n');
    console.log('wrote .env.demo (git-ignored)');
  }
  return {
    A: { email: demo.DEMO_A_EMAIL, password: demo.DEMO_A_PASSWORD, name: 'Alex Sample' },
    B: { email: demo.DEMO_B_EMAIL, password: demo.DEMO_B_PASSWORD, name: 'Bailey Example' },
  };
}

function mask(email) {
  const [l, d] = email.split('@');
  return `${l.slice(0, 2)}***${l.includes('+') ? l.slice(l.indexOf('+')) : ''}@${d}`;
}

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
  try { json = text ? JSON.parse(text) : null; } catch (_) { json = null; }
  return { status: res.status, json, text };
}

function fail(label, r) {
  const code = r.json?.error_code ?? r.json?.code ?? r.json?.error ?? r.json?.message ?? '';
  throw new Error(`${label} failed: HTTP ${r.status} ${String(code).slice(0, 120)}`);
}

async function signIn(acct) {
  const r = await http('POST', '/auth/v1/token?grant_type=password', {
    body: { email: acct.email, password: acct.password },
  });
  if (r.status !== 200) return null;
  return { token: r.json.access_token, user: r.json.user };
}

async function ensureAccount(label, acct) {
  let s = await signIn(acct);
  if (!s) {
    const r = await http('POST', '/auth/v1/signup', {
      body: {
        email: acct.email,
        password: acct.password,
        data: { full_name: acct.name, role: 'PATIENT', language_code: 'en', demo_account: true },
      },
    });
    if (r.status !== 200) fail(`signup ${label}`, r);
    s = await signIn(acct);
    if (!s) throw new Error(`sign-in after signup failed for ${label} (email confirmation may be required)`);
    console.log(`created account ${label}: ${mask(acct.email)}`);
  } else {
    console.log(`account ${label} exists: ${mask(acct.email)}`);
  }
  if (s.user?.user_metadata?.demo_account !== true) {
    const r = await http('PUT', '/auth/v1/user', { token: s.token, body: { data: { demo_account: true } } });
    if (r.status !== 200) fail('mark demo', r);
    s = await signIn(acct);
  }
  // Profile + patient detail rows, as the app does after sign-in.
  const p = await http('GET', `/rest/v1/profiles?id=eq.${s.user.id}&select=id,role`, { token: s.token });
  if (!Array.isArray(p.json) || p.json.length === 0) {
    const ins = await http('POST', '/rest/v1/profiles', {
      token: s.token,
      body: { id: s.user.id, role: 'PATIENT', full_name: acct.name, language_code: 'en' },
      headers: { Prefer: 'return=minimal' },
    });
    if (ins.status >= 300) fail(`profile insert ${label}`, ins);
    const det = await http('POST', '/rest/v1/patient_details', {
      token: s.token,
      body: { patient_id: s.user.id },
      headers: { Prefer: 'return=minimal' },
    });
    if (det.status >= 300 && det.status !== 409) fail(`patient_details insert ${label}`, det);
    console.log(`profile created for ${label}`);
  }
  return s;
}

async function guardedSession(label, acct) {
  const s = await signIn(acct);
  if (!s) throw new Error(`cannot sign in as ${label}; run "create" first`);
  if (s.user.email?.toLowerCase() !== acct.email.toLowerCase() || s.user.user_metadata?.demo_account !== true) {
    throw new Error(`refusing: ${label} is not a marked demo account`);
  }
  return s;
}

// ---------------------------------------------------------------------------
// Storage helpers (own folder only)
// ---------------------------------------------------------------------------
async function listOwn(token, prefix) {
  const out = [];
  const stack = [prefix];
  while (stack.length) {
    const dir = stack.pop();
    const r = await http('POST', '/storage/v1/object/list/appeal-documents', {
      token, body: { prefix: dir, limit: 1000, offset: 0 },
    });
    if (r.status !== 200) fail('storage list', r);
    for (const e of r.json) {
      const path = `${dir}/${e.name}`;
      if (e.id == null) stack.push(path); else out.push(path);
    }
  }
  return out;
}

async function removeOwn(token, uid) {
  const paths = await listOwn(token, uid);
  for (let i = 0; i < paths.length; i += 100) {
    const r = await http('DELETE', '/storage/v1/object/appeal-documents', {
      token, body: { prefixes: paths.slice(i, i + 100) },
    });
    if (r.status !== 200) fail('storage remove', r);
  }
  return paths.length;
}

// ---------------------------------------------------------------------------
// Reset
// ---------------------------------------------------------------------------
async function resetAccount(label, acct) {
  const { token, user } = await guardedSession(label, acct);
  const uid = user.id;
  const removedFiles = await removeOwn(token, uid);
  const del = async (table, col = 'patient_id') => {
    const r = await http('DELETE', `/rest/v1/${table}?${col}=eq.${uid}`, {
      token, headers: { Prefer: 'return=representation' },
    });
    if (r.status >= 300) fail(`delete ${table}`, r);
    return Array.isArray(r.json) ? r.json.length : 0;
  };
  const counts = {
    storage_files: removedFiles,
    appeal_cases: await del('appeal_cases', 'owner_id'),
    medication_occasion_checks: await del('medication_occasion_checks'),
    medication_regimens: await del('medication_regimens'),
    patient_medications: await del('patient_medications'),
    symptom_entries: await del('symptom_entries'),
    local_context_entries: await del('local_context_entries'),
    pdc_daily_checks: await del('pdc_daily_checks'),
  };
  // Inhaler events are voided through the server function (no client delete).
  const ev = await http('GET', `/rest/v1/inhaler_events?patient_id=eq.${uid}&voided_at=is.null&select=id`, { token });
  let voided = 0;
  for (const row of ev.json ?? []) {
    const r = await http('POST', '/functions/v1/log-inhaler-event', { token, body: { action: 'void', id: row.id } });
    if (r.status === 200) voided++;
  }
  counts.inhaler_events_voided = voided;
  console.log(JSON.stringify({ action: 'reset', account: label, project: projectRef, counts }));
  return { token, uid };
}

// ---------------------------------------------------------------------------
// Seed
// ---------------------------------------------------------------------------
function addDays(iso, n) {
  const d = new Date(`${iso}T00:00:00Z`);
  d.setUTCDate(d.getUTCDate() + n);
  return d.toISOString().slice(0, 10);
}

function localToUtcIso(dateIso, hh, mm = 0) {
  const d = new Date(`${dateIso}T${String(hh).padStart(2, '0')}:${String(mm).padStart(2, '0')}:00Z`);
  d.setUTCMinutes(d.getUTCMinutes() - DEMO_TZ_OFFSET_MIN);
  return d.toISOString();
}

const LETTERS = [
  {
    key: 'missing_info',
    text: `SAMPLE - SYNTHETIC DEMO LETTER - NOT A REAL INSURANCE NOTICE
Notice of coverage denial
North Valley Demonstration Plan
Notice date: October 15, 2026
Member: Alex Sample
Member ID: DEMO-SEED-2001
Reference: SEED-2001
Requested medication: DemoController A 100 mcg
Dose as submitted: 2 puffs twice daily
What this notice says
The request did not include the medication history and recent visit notes requested by this fictional plan.
Dates and next steps
Your written request for review must reach this fictional plan by November 14, 2026.
This sample has no real mailing address, website, fax number or phone number.`,
    raw: {
      document_kind: 'initial_drug_denial',
      document_kind_quote: 'Notice of coverage denial',
      reasons: [{ text: 'Medication history and recent visit notes were not included.', code: 'missing_information', quote: 'The request did not include the medication history and recent visit notes requested by this fictional plan.' }],
      requested_items: [
        { label: 'Medication history', quote: 'medication history' },
        { label: 'Recent visit notes', quote: 'recent visit notes' },
      ],
      deadlines: [{ purpose: 'review_request', kind: 'explicit_date', date: '2026-11-14', quote: 'Your written request for review must reach this fictional plan by November 14, 2026.' }],
      fields: {
        patient_name: ['Alex Sample', 'Member: Alex Sample'],
        plan_name: ['North Valley Demonstration Plan', 'North Valley Demonstration Plan'],
        member_id: ['DEMO-SEED-2001', 'Member ID: DEMO-SEED-2001'],
        case_reference: ['SEED-2001', 'Reference: SEED-2001'],
        medication: ['DemoController A 100 mcg', 'Requested medication: DemoController A 100 mcg'],
        dose: ['2 puffs twice daily', 'Dose as submitted: 2 puffs twice daily'],
        notice_date: ['2026-10-15', 'Notice date: October 15, 2026'],
      },
    },
  },
  {
    key: 'step_therapy',
    text: `SAMPLE - SYNTHETIC DEMO LETTER - NOT A REAL INSURANCE NOTICE
Notice of coverage denial
North Valley Demonstration Plan
Notice date: October 16, 2026
Member: Alex Sample
Member ID: DEMO-SEED-2001
Reference: SEED-2002
Requested medication: DemoController B 200 mcg
Dose as submitted: 1 puff twice daily
What this notice says
The submitted record does not document prior use of the preferred medication or the reason it could not be used. This is a fictional step-therapy requirement.
Please send the prior medication history and the reason the preferred medication could not be used.
Dates and next steps
Your request for review must be received by November 20, 2026.`,
    raw: {
      document_kind: 'initial_drug_denial',
      document_kind_quote: 'Notice of coverage denial',
      reasons: [{ text: 'Prior use of the preferred medication, or why it could not be used, is not documented.', code: 'step_therapy', quote: 'The submitted record does not document prior use of the preferred medication or the reason it could not be used.' }],
      requested_items: [
        { label: 'Prior medication history', quote: 'Please send the prior medication history' },
        { label: 'Reason the preferred medication could not be used', quote: 'the reason the preferred medication could not be used' },
      ],
      deadlines: [{ purpose: 'review_request', kind: 'explicit_date', date: '2026-11-20', quote: 'Your request for review must be received by November 20, 2026.' }],
      fields: {
        patient_name: ['Alex Sample', 'Member: Alex Sample'],
        plan_name: ['North Valley Demonstration Plan', 'North Valley Demonstration Plan'],
        member_id: ['DEMO-SEED-2001', 'Member ID: DEMO-SEED-2001'],
        case_reference: ['SEED-2002', 'Reference: SEED-2002'],
        medication: ['DemoController B 200 mcg', 'Requested medication: DemoController B 200 mcg'],
        dose: ['1 puff twice daily', 'Dose as submitted: 1 puff twice daily'],
        notice_date: ['2026-10-16', 'Notice date: October 16, 2026'],
      },
    },
  },
  {
    key: 'received_date_needed',
    text: `SAMPLE - SYNTHETIC DEMO LETTER - NOT A REAL INSURANCE NOTICE
Notice of coverage denial
North Valley Demonstration Plan
Notice date: October 17, 2026
Member: Alex Sample
Member ID: DEMO-SEED-2001
Reference: SEED-2003
Requested medication: DemoController C 80 mcg
Dose as submitted: 2 puffs daily
What this notice says
The request did not include recent visit notes.
Dates and next steps
You may request review within 30 calendar days after you receive this notice. The date you received this notice is not recorded here.`,
    raw: {
      document_kind: 'initial_drug_denial',
      document_kind_quote: 'Notice of coverage denial',
      reasons: [{ text: 'Recent visit notes were not included.', code: 'missing_information', quote: 'The request did not include recent visit notes.' }],
      requested_items: [{ label: 'Recent visit notes', quote: 'recent visit notes' }],
      deadlines: [{ purpose: 'review_request', kind: 'relative', date: null, duration_value: 30, duration_unit: 'calendar_day', anchor: 'received_date', quote: 'within 30 calendar days after you receive this notice' }],
      fields: {
        patient_name: ['Alex Sample', 'Member: Alex Sample'],
        plan_name: ['North Valley Demonstration Plan', 'North Valley Demonstration Plan'],
        member_id: ['DEMO-SEED-2001', 'Member ID: DEMO-SEED-2001'],
        case_reference: ['SEED-2003', 'Reference: SEED-2003'],
        medication: ['DemoController C 80 mcg', 'Requested medication: DemoController C 80 mcg'],
        dose: ['2 puffs daily', 'Dose as submitted: 2 puffs daily'],
        notice_date: ['2026-10-17', 'Notice date: October 17, 2026'],
      },
    },
  },
];

function buildFacts(letter) {
  const r = letter.raw;
  const fields = {};
  for (const k of ['patient_name', 'plan_name', 'member_id', 'case_reference', 'medication', 'dose', 'notice_date', 'contact', 'submission_route']) {
    const v = r.fields[k];
    fields[k] = v ? { value: v[0], quote: v[1], page: 1 } : { value: null, quote: null, page: null };
  }
  const raw = {
    document_kind: r.document_kind,
    document_kind_quote: r.document_kind_quote,
    document_kind_page: 1,
    fields,
    reasons: r.reasons.map((x) => ({ ...x, page: 1 })),
    requested_items: r.requested_items.map((x) => ({ ...x, page: 1 })),
    deadlines: r.deadlines.map((d) => ({ duration_value: null, duration_unit: null, anchor: null, ...d, page: 1 })),
    received_date_stated: null,
  };
  const facts = validateExtraction(raw, [{ page_number: 1, text: letter.text, legibility: 'clear' }]);
  facts.source = 'demo_seed';
  const bad = [...Object.values(facts.fields).filter((f) => f.status === 'ambiguous'), ...facts.deadlines.filter((d) => d.status !== 'extracted')];
  if (bad.length) throw new Error(`seed letter ${letter.key} does not validate: ${facts.warnings.join(',')}`);
  return facts;
}

function responsibleFor(label) {
  const l = label.toLowerCase();
  if (/(visit note|reason .* could not)/.test(l)) return 'care_team';
  if (/(medication history)/.test(l)) return 'patient';
  return 'unknown';
}

async function insert(token, table, rows, select = 'id') {
  const keys = [...new Set(rows.flatMap((r) => Object.keys(r)))];
  const uniform = rows.map((r) => Object.fromEntries(keys.map((k) => [k, r[k] ?? null])));
  const r = await http('POST', `/rest/v1/${table}?select=${select}`, {
    token, body: uniform, headers: { Prefer: 'return=representation' },
  });
  if (r.status >= 300) fail(`insert ${table}`, r);
  return r.json;
}

async function seedAccount(label, acct) {
  const { token, uid } = await resetAccount(label, acct);

  // Medications and one controller schedule (2 occasions/day, 2 puffs each).
  const meds = await insert(token, 'patient_medications', [
    { patient_id: uid, display_name: 'DemoController A 100 mcg', is_default: true, daily_check_enabled: true },
    { patient_id: uid, display_name: 'DemoRescue', is_default: false, daily_check_enabled: false },
  ], 'id,display_name');
  const controller = meds.find((m) => m.display_name.startsWith('DemoController'));
  const [regimen] = await insert(token, 'medication_regimens', [{
    patient_id: uid, medication_id: controller.id, role: 'controller', occasions_per_day: 2,
    puffs_per_occasion: 2, times_minutes: [480, 1200], effective_from: RANGE_START,
  }]);

  // 60 scheduled occasions: 51 used, 3 not used, 6 with no answer (no row).
  const notUsed = new Set([9, 30, 47]);
  const unanswered = new Set([14, 15, 38, 52, 53, 59]);
  const checks = [];
  for (let s = 0; s < RANGE_DAYS * 2; s++) {
    if (unanswered.has(s)) continue;
    const day = addDays(RANGE_START, Math.floor(s / 2));
    const occ = s % 2;
    checks.push({
      patient_id: uid, regimen_id: regimen.id, local_date: day, occasion_index: occ,
      status: notUsed.has(s) ? 'not_used' : 'used',
      responded_at: localToUtcIso(day, occ === 0 ? 8 : 20, 5), source: 'in_app',
    });
  }
  await insert(token, 'medication_occasion_checks', checks);

  // Symptoms on 12 days; night waking on 6 of them.
  const symptomDays = [1, 3, 4, 7, 9, 12, 14, 17, 19, 22, 25, 28];
  const nightDays = new Set([3, 7, 12, 17, 22, 28]);
  await insert(token, 'symptom_entries', symptomDays.map((i) => {
    const day = addDays(RANGE_START, i);
    const at = localToUtcIso(day, 21);
    return {
      patient_id: uid, recorded_at: at, occurred_at: at, tz_offset_minutes: DEMO_TZ_OFFSET_MIN,
      symptoms: nightDays.has(i) ? ['night_waking', 'cough'] : (i % 2 ? ['wheeze'] : ['cough']),
      no_symptoms: false, source_language: 'en', note: null,
    };
  }));

  // As-needed use: 8 events, 2 puffs each (16 puffs). Separate from scheduled doses.
  const prnDays = [6, 8, 12, 15, 17, 22, 25, 28];
  let prn = 0;
  for (const i of prnDays) {
    const day = addDays(RANGE_START, i);
    const r = await http('POST', '/functions/v1/log-inhaler-event', {
      token,
      body: {
        action: 'create', input_means: 'tap', is_panic: false, medication_label: 'DemoRescue',
        medication_status: 'identified', puff_count: 2, use_reason: 'symptoms', source_language: 'en',
        tz_offset_minutes: DEMO_TZ_OFFSET_MIN, recorded_at: localToUtcIso(day, 19),
      },
    });
    if (r.status === 200) prn++;
    else console.log(`prn event skipped: HTTP ${r.status} ${r.json?.error ?? ''}`);
  }

  // Local context: PM2.5 AQI on 22 of 30 days (synthetic), 8 days without data,
  // plus two patient reports of a damp indoor area.
  const missingDays = new Set([2, 5, 11, 13, 20, 23, 26, 29]);
  const highDays = new Set([4, 10, 18, 24]);
  const ctx = [];
  for (let i = 0; i < RANGE_DAYS; i++) {
    if (missingDays.has(i)) continue;
    const day = addDays(RANGE_START, i);
    ctx.push({
      patient_id: uid, local_date: day, kind: 'pm25', aqi_value: highDays.has(i) ? 104 + i : 38 + ((i * 7) % 45),
      unit: 'AQI', value_kind: 'observation', source_name: 'Synthetic fixture (no real station)',
      place_label: 'Sample town, NJ', observed_at: localToUtcIso(day, 12), fetched_at: localToUtcIso(day, 13),
      is_synthetic: true,
    });
  }
  for (const i of [9, 21]) {
    ctx.push({
      patient_id: uid, local_date: addDays(RANGE_START, i), kind: 'user_report', report_code: 'damp_musty',
      value_kind: 'user_report', is_synthetic: true, note: 'Synthetic report',
    });
  }
  await insert(token, 'local_context_entries', ctx);

  // Three labeled sample cases.
  const caseIds = [];
  for (const letter of LETTERS) {
    const facts = buildFacts(letter);
    const [c] = await insert(token, 'appeal_cases', [{
      owner_id: uid, title: facts.fields.medication.value, status: 'needs_review', demo_mode: true,
      document_kind: facts.document_kind.value, current_document_revision: 1, current_fact_revision: 1,
      timezone: 'America/New_York', ui_language: 'en',
    }]);
    const path = `${uid}/${c.id}/doc-1-0.txt`;
    const bytes = Buffer.from(letter.text, 'utf8');
    const up = await http('POST', `/storage/v1/object/appeal-documents/${path}`, {
      token, body: bytes, raw: true, headers: { 'Content-Type': 'text/plain', 'x-upsert': 'true' },
    });
    if (up.status >= 300) fail('upload sample letter', up);
    const { createHash } = await import('node:crypto');
    const [doc] = await insert(token, 'case_documents', [{
      case_id: c.id, owner_id: uid, revision: 1, set_revision: 1, file_index: 0, object_path: path,
      mime: 'text/plain', bytes: bytes.length, sha256: createHash('sha256').update(bytes).digest('hex'),
      upload_status: 'uploaded',
    }]);
    await insert(token, 'document_pages', [{
      document_id: doc.id, owner_id: uid, case_id: c.id, set_revision: 1, page_index: 0, order_index: 0,
      page_number: 1, extracted_text: letter.text, legibility: 'clear',
    }]);
    await insert(token, 'case_facts', [{
      case_id: c.id, owner_id: uid, revision: 1, schema_version: facts.schema_version, structured_json: facts,
    }]);
    if (facts.requested_items.length) {
      await insert(token, 'case_requirements', facts.requested_items.map((it, i) => ({
        case_id: c.id, owner_id: uid, label: it.label, origin: 'extracted', source_page: it.page,
        source_quote: it.quote, status: 'needed', responsible: responsibleFor(it.label), sort_order: i, fact_revision: 1,
      })));
    }
    caseIds.push(c.id);
  }

  console.log(JSON.stringify({
    action: 'seed', account: label, project: projectRef, demo_today: DEMO_TODAY,
    range: `${RANGE_START}..${addDays(RANGE_START, RANGE_DAYS - 1)}`,
    counts: {
      scheduled_occasions: RANGE_DAYS * 2, used: checks.filter((c) => c.status === 'used').length,
      not_used: checks.filter((c) => c.status === 'not_used').length, unanswered: unanswered.size,
      prn_events: prn, prn_puffs: prn * 2, symptom_days: symptomDays.length, night_waking_days: nightDays.size,
      local_context_days_with_data: RANGE_DAYS - missingDays.size, local_context_days_missing: missingDays.size,
      damp_reports: 2, cases: caseIds.length,
    },
  }));
}

async function status(label, acct) {
  const { token, user } = await guardedSession(label, acct);
  const count = async (table, col = 'patient_id', extra = '') => {
    const cr = (await fetch(`${BASE}/rest/v1/${table}?${col}=eq.${user.id}${extra}&select=id`, {
      method: 'HEAD', headers: { apikey: ANON, Authorization: `Bearer ${token}`, Prefer: 'count=exact' },
    })).headers.get('content-range');
    return cr ? Number(cr.split('/')[1]) : null;
  };
  console.log(JSON.stringify({
    account: label, project: projectRef,
    appeal_cases: await count('appeal_cases', 'owner_id'),
    occasion_checks: await count('medication_occasion_checks'),
    symptom_entries: await count('symptom_entries'),
    local_context_entries: await count('local_context_entries'),
    inhaler_events_active: await count('inhaler_events', 'patient_id', '&voided_at=is.null'),
  }));
}

// ---------------------------------------------------------------------------
// Isolation: B tries to reach A's case, rows, file and job.
// ---------------------------------------------------------------------------
async function isolation(cfg) {
  const a = await guardedSession('A', cfg.A);
  const b = await guardedSession('B', cfg.B);
  const cases = await http('GET', `/rest/v1/appeal_cases?owner_id=eq.${a.user.id}&select=id,title&limit=1`, { token: a.token });
  if (!Array.isArray(cases.json) || cases.json.length === 0) throw new Error('A has no case; run "seed A" first');
  const target = cases.json[0];
  const docs = await http('GET', `/rest/v1/case_documents?case_id=eq.${target.id}&select=object_path&limit=1`, { token: a.token });
  const path = docs.json?.[0]?.object_path;
  const results = [];
  const check = (name, ok, detail) => results.push({ check: name, result: ok ? 'BLOCKED' : 'EXPOSED', detail });

  let r = await http('GET', `/rest/v1/appeal_cases?id=eq.${target.id}&select=id`, { token: b.token });
  check('select case', Array.isArray(r.json) && r.json.length === 0, `HTTP ${r.status}, rows ${r.json?.length}`);
  r = await http('PATCH', `/rest/v1/appeal_cases?id=eq.${target.id}`, { token: b.token, body: { title: 'changed by B' }, headers: { Prefer: 'return=representation' } });
  check('update case', Array.isArray(r.json) ? r.json.length === 0 : r.status >= 400, `HTTP ${r.status}`);
  r = await http('DELETE', `/rest/v1/appeal_cases?id=eq.${target.id}`, { token: b.token, headers: { Prefer: 'return=representation' } });
  check('delete case', Array.isArray(r.json) ? r.json.length === 0 : r.status >= 400, `HTTP ${r.status}`);
  for (const t of ['case_facts', 'document_pages', 'case_documents', 'case_requirements', 'processing_jobs', 'generated_artifacts', 'case_evidence']) {
    r = await http('GET', `/rest/v1/${t}?case_id=eq.${target.id}&select=id`, { token: b.token });
    check(`select ${t}`, Array.isArray(r.json) && r.json.length === 0, `HTTP ${r.status}, rows ${r.json?.length}`);
  }
  r = await http('POST', '/rest/v1/case_requirements', { token: b.token, body: { case_id: target.id, owner_id: b.user.id, label: 'injected', origin: 'user_added' } });
  check('insert requirement into A case (owner B)', r.status >= 400, `HTTP ${r.status}`);
  r = await http('POST', '/rest/v1/case_requirements', { token: b.token, body: { case_id: target.id, owner_id: a.user.id, label: 'injected', origin: 'user_added' } });
  check('insert requirement into A case (owner A)', r.status >= 400, `HTTP ${r.status}`);
  r = await http('POST', '/rest/v1/case_facts', { token: b.token, body: { case_id: target.id, owner_id: b.user.id, revision: 99, schema_version: 'x', structured_json: {} } });
  check('insert facts into A case', r.status >= 400, `HTTP ${r.status}`);
  if (path) {
    r = await http('GET', `/storage/v1/object/authenticated/appeal-documents/${path}`, { token: b.token });
    check('download A file', r.status >= 400, `HTTP ${r.status}`);
    r = await http('POST', `/storage/v1/object/sign/appeal-documents/${path}`, { token: b.token, body: { expiresIn: 60 } });
    check('signed URL for A file', r.status >= 400, `HTTP ${r.status}`);
    r = await http('POST', `/storage/v1/object/appeal-documents/${a.user.id}/${target.id}/injected.txt`, { token: b.token, body: 'x', raw: true, headers: { 'Content-Type': 'text/plain' } });
    check('upload into A folder', r.status >= 400, `HTTP ${r.status}`);
    r = await http('DELETE', '/storage/v1/object/appeal-documents', { token: b.token, body: { prefixes: [path] } });
    const stillThere = await http('GET', `/storage/v1/object/authenticated/appeal-documents/${path}`, { token: a.token });
    check('delete A file', stillThere.status === 200, `B delete HTTP ${r.status}; A still reads HTTP ${stillThere.status}`);
  }
  r = await http('POST', '/functions/v1/analyze-letter', { token: b.token, body: { action: 'start', case_id: target.id, set_revision: 1 } });
  check('start analysis on A case', r.status === 404, `HTTP ${r.status} ${r.json?.error ?? ''}`);
  const after = await http('GET', `/rest/v1/appeal_cases?id=eq.${target.id}&select=id,title`, { token: a.token });
  check('A case unchanged', after.json?.[0]?.title === target.title, `title preserved: ${after.json?.[0]?.title === target.title}`);
  for (const x of results) console.log(JSON.stringify(x));
  const exposed = results.filter((x) => x.result !== 'BLOCKED');
  console.log(JSON.stringify({ isolation_checks: results.length, exposed: exposed.length }));
  if (exposed.length) process.exitCode = 1;
}

const [cmd, who] = process.argv.slice(2).filter((a) => !a.startsWith('--'));
const cfg = demoConfig();
const pick = (w) => {
  const k = (w || '').toUpperCase();
  if (!cfg[k]) { console.error('account must be A or B'); process.exit(2); }
  return [k, cfg[k]];
};
try {
  if (cmd === 'create') {
    await ensureAccount('A', cfg.A);
    await ensureAccount('B', cfg.B);
  } else if (cmd === 'seed') {
    await seedAccount(...pick(who));
  } else if (cmd === 'reset') {
    await resetAccount(...pick(who));
  } else if (cmd === 'status') {
    await status(...pick(who));
  } else if (cmd === 'isolation') {
    await isolation(cfg);
  } else {
    console.log('usage: node tool/demo_accounts.mjs create | seed A|B | reset A|B | status A|B | isolation');
  }
} catch (e) {
  console.error(String(e.message ?? e));
  process.exitCode = 1;
}
