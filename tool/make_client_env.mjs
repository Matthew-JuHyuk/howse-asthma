// Writes .env.client with the only keys the app bundle may contain.
// Server keys (AI, email, environment APIs) stay in .env / Edge secrets.
//
//   node tool/make_client_env.mjs            # from .env
//   node tool/make_client_env.mjs --release  # also forces debug flags off
import { existsSync, readFileSync, writeFileSync } from 'node:fs';

const ALLOW = ['SUPABASE_URL', 'SUPABASE_ANON_KEY', 'DESIGN_PREVIEW', 'DEBUG_API_CONSOLE'];
const release = process.argv.includes('--release');

if (!existsSync('.env')) {
  console.error('.env not found');
  process.exit(2);
}
const values = {};
for (const line of readFileSync('.env', 'utf8').split(/\r?\n/)) {
  const m = line.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/);
  if (m && ALLOW.includes(m[1])) values[m[1]] = m[2].trim();
}
if (release) {
  values.DESIGN_PREVIEW = 'false';
  values.DEBUG_API_CONSOLE = 'false';
}
for (const k of ['SUPABASE_URL', 'SUPABASE_ANON_KEY']) {
  if (!values[k]) {
    console.error(`${k} missing in .env`);
    process.exit(2);
  }
}
if (values.SUPABASE_ANON_KEY.startsWith('sb_secret_') || /service_role/.test(values.SUPABASE_ANON_KEY)) {
  console.error('SUPABASE_ANON_KEY looks like a server key; refusing to bundle it');
  process.exit(2);
}
writeFileSync('.env.client', ALLOW.filter((k) => k in values).map((k) => `${k}=${values[k]}`).join('\n') + '\n');
console.log(`wrote .env.client with keys: ${Object.keys(values).join(', ')}`);
