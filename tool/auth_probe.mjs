// Reproduces sign-in failure modes against the configured auth server.
// Reads SUPABASE_URL and SUPABASE_ANON_KEY from .env. Prints status codes and
// error codes only; never prints keys, tokens, or passwords.
//
// Usage: node tool/auth_probe.mjs
import { readFileSync } from 'node:fs';

function loadEnv(path) {
  const out = {};
  for (const line of readFileSync(path, 'utf8').split(/\r?\n/)) {
    const m = line.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/);
    if (m) out[m[1]] = m[2].trim();
  }
  return out;
}

const env = loadEnv('.env');
const base = env.SUPABASE_URL;
const key = env.SUPABASE_ANON_KEY;
if (!base || !key) {
  console.error('SUPABASE_URL / SUPABASE_ANON_KEY missing in .env');
  process.exit(2);
}
const headers = { apikey: key, 'Content-Type': 'application/json' };

async function probe(label, url, init = {}) {
  const started = Date.now();
  try {
    const res = await fetch(url, { redirect: 'manual', ...init, headers: { ...headers, ...(init.headers || {}) } });
    let body = '';
    try { body = await res.text(); } catch (_) {}
    let code = null;
    let msg = null;
    try {
      const j = JSON.parse(body);
      code = j.error_code ?? j.code ?? j.error ?? null;
      msg = j.msg ?? j.message ?? j.error_description ?? null;
    } catch (_) {
      msg = body.slice(0, 120).replace(/\s+/g, ' ');
    }
    console.log(JSON.stringify({ label, status: res.status, code, msg, location: res.headers.get('location') ? '[redirect]' : null, ms: Date.now() - started }));
    return { status: res.status, body };
  } catch (e) {
    console.log(JSON.stringify({ label, network_error: String(e.cause?.code ?? e.message) }));
    return { status: 0, body: '' };
  }
}

const settings = await probe('settings', `${base}/auth/v1/settings`);
try {
  const s = JSON.parse(settings.body);
  console.log(JSON.stringify({
    label: 'settings_summary',
    email_enabled: s.external?.email,
    google_enabled: s.external?.google,
    apple_enabled: s.external?.apple,
    signup_disabled: s.disable_signup,
    mailer_autoconfirm: s.mailer_autoconfirm,
  }));
} catch (_) {}

await probe('password_login_unknown_user', `${base}/auth/v1/token?grant_type=password`, {
  method: 'POST',
  body: JSON.stringify({ email: `probe-${Date.now()}@example.invalid`, password: 'not-a-real-password-1' }),
});

await probe('oauth_google_authorize', `${base}/auth/v1/authorize?provider=google&redirect_to=${encodeURIComponent('io.supabase.howseasthma://login-callback/')}`, {
  method: 'GET',
});
