// Account deletion check against the deployed delete-account function.
//
//   node tool/delete_account_probe.mjs
//
// Signs up a new throwaway account (never A or B), gives it one case and one
// stored file, deletes it through the function, then checks that sign-in
// fails and that account A cannot see the old file path. Only the throwaway
// account is deleted. Never prints tokens, keys or passwords.

import { existsSync, readFileSync } from 'node:fs';
import { randomBytes } from 'node:crypto';

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
const recipient = env.TEST_EMAIL_RECIPIENT;
if (!BASE || !ANON || !recipient?.includes('@')) {
  console.error('SUPABASE_URL, SUPABASE_ANON_KEY and TEST_EMAIL_RECIPIENT are needed in .env');
  process.exit(2);
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
  try { json = JSON.parse(text); } catch { /* not JSON */ }
  return { status: res.status, json };
}

const checks = [];
const check = (name, ok, detail = '') => {
  checks.push({ name, ok });
  console.log(`${ok ? 'PASS' : 'FAIL'} ${name}${detail ? ` (${detail})` : ''}`);
};

const [local, domain] = recipient.split('@');
const email = `${local}+covernote-del-${randomBytes(4).toString('hex')}@${domain}`;
const password = randomBytes(15).toString('base64url');

const signup = await http('POST', '/auth/v1/signup', {
  body: { email, password, data: { full_name: 'Delete Probe', role: 'PATIENT', language_code: 'en' } },
});
const signIn = () => http('POST', '/auth/v1/token?grant_type=password', { body: { email, password } });
let s = await signIn();
if (signup.status !== 200 || s.status !== 200) {
  console.error(`could not create the throwaway account (signup ${signup.status}, sign-in ${s.status})`);
  process.exit(1);
}
const token = s.json.access_token;
const uid = s.json.user.id;

await http('POST', '/rest/v1/profiles', {
  token, body: { id: uid, role: 'PATIENT', full_name: 'Delete Probe', language_code: 'en' },
  headers: { Prefer: 'return=minimal' },
});
const c = await http('POST', '/rest/v1/appeal_cases?select=id', {
  token,
  body: { owner_id: uid, title: 'Delete probe', status: 'uploaded', demo_mode: false, timezone: 'UTC', ui_language: 'en' },
  headers: { Prefer: 'return=representation' },
});
const caseId = c.json?.[0]?.id;
check('throwaway case created', c.status < 300 && !!caseId);
const path = `${uid}/${caseId}/probe.txt`;
const up = await http('POST', `/storage/v1/object/appeal-documents/${path}`, {
  token, body: Buffer.from('delete probe'), raw: true, headers: { 'Content-Type': 'text/plain' },
});
check('throwaway file stored', up.status < 300, `HTTP ${up.status}`);

const noConfirm = await http('POST', '/functions/v1/delete-account', { token, body: {} });
check('refuses without confirmation', noConfirm.status === 400 && noConfirm.json?.error === 'confirmation_required');

const del = await http('POST', '/functions/v1/delete-account', { token, body: { confirm: 'DELETE' } });
check('delete-account succeeded', del.status === 200 && del.json?.deleted === true,
  `HTTP ${del.status}, storage objects removed: ${del.json?.storage_objects_removed ?? '?'}`);
check('stored file removed', (del.json?.storage_objects_removed ?? 0) >= 1);

s = await signIn();
check('sign-in fails after deletion', s.status !== 200, `HTTP ${s.status}`);

const reuse = await http('GET', `/rest/v1/appeal_cases?id=eq.${caseId}&select=id`, { token });
check('old token reads no case rows', !Array.isArray(reuse.json) || reuse.json.length === 0, `HTTP ${reuse.status}`);

const failed = checks.filter((c) => !c.ok).length;
console.log(JSON.stringify({ checks: checks.length, failed }));
if (failed) process.exitCode = 1;
