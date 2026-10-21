// Adds the keys in tool/l10n_overlays/new_keys.json to lib/l10n/app_<lang>.arb.
// Existing keys are left alone. Run: node tool/l10n_add_keys.mjs
import { readFileSync, writeFileSync } from 'node:fs';

const add = JSON.parse(readFileSync('tool/l10n_overlays/new_keys.json', 'utf8'));
for (const [lang, entries] of Object.entries(add)) {
  const path = `lib/l10n/app_${lang}.arb`;
  const arb = JSON.parse(readFileSync(path, 'utf8').replace(/^\uFEFF/, ''));
  let added = 0;
  for (const [k, v] of Object.entries(entries)) {
    if (!(k in arb)) {
      arb[k] = v;
      added++;
    }
  }
  writeFileSync(path, JSON.stringify(arb, null, 2) + '\n', 'utf8');
  console.log(`${path}: +${added}`);
}
