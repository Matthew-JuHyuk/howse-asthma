// Which translation keys do the screens use, and how complete is each language?
//
//   node tool/l10n_audit.mjs                 # summary for every lib/l10n/app_*.arb
//   node tool/l10n_audit.mjs --used-keys     # print the used key list (one per line)
//
// A key is "used" when its name appears as `.name` or `.name(` in lib/**/*.dart
// outside lib/l10n. Keys that no screen reads are not worth translating.
import { readdirSync, readFileSync, statSync } from 'node:fs';
import { join } from 'node:path';

function walk(dir, out = []) {
  for (const n of readdirSync(dir)) {
    const p = join(dir, n);
    if (statSync(p).isDirectory()) {
      if (p.replaceAll('\\', '/').endsWith('lib/l10n')) continue;
      walk(p, out);
    } else if (p.endsWith('.dart')) out.push(p);
  }
  return out;
}

const src = walk('lib').map((f) => readFileSync(f, 'utf8')).join('\n');
const en = JSON.parse(readFileSync('lib/l10n/app_en.arb', 'utf8'));
const keys = Object.keys(en).filter((k) => !k.startsWith('@'));
// Keys listed in new_keys.json count as used until the screens reference them.
const pending = new Set(Object.keys(JSON.parse(readFileSync('tool/l10n_overlays/new_keys.json', 'utf8')).en));
const used = keys.filter((k) => pending.has(k) || new RegExp(`\\.${k}\\b`).test(src));

if (process.argv.includes('--used-keys')) {
  console.log(used.join('\n'));
  process.exit(0);
}

console.log(JSON.stringify({ keys: keys.length, used: used.length, used_cn: used.filter((k) => k.startsWith('cn')).length }));
for (const f of readdirSync('lib/l10n').filter((n) => /^app_.*\.arb$/.test(n))) {
  const j = JSON.parse(readFileSync(join('lib/l10n', f), 'utf8'));
  const have = new Set(Object.keys(j).filter((k) => !k.startsWith('@')));
  const missingUsed = used.filter((k) => !have.has(k));
  console.log(JSON.stringify({ file: f, keys: have.size, used_missing: missingUsed.length }));
}
