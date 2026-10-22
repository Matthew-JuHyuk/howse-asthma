// Any overlay key that is not yet referenced in Dart still needs a
// translation (Sprint 9 strings, leftover step labels). Count them as used
// via new_keys.json so check/build stay exact.
import { execSync } from 'node:child_process';
import { readFileSync, writeFileSync } from 'node:fs';

const en = JSON.parse(readFileSync('lib/l10n/app_en.arb', 'utf8'));
const overlay = JSON.parse(
  readFileSync('tool/l10n_overlays/locales/es.json', 'utf8'),
);
const pendingPath = 'tool/l10n_overlays/new_keys.json';
const pending = JSON.parse(readFileSync(pendingPath, 'utf8'));
const used = new Set(
  execSync('node tool/l10n_audit.mjs --used-keys', { encoding: 'utf8' })
    .split(/\r?\n/)
    .map((s) => s.trim())
    .filter(Boolean),
);

let added = 0;
for (const k of Object.keys(overlay)) {
  if (k.startsWith('@')) continue;
  if (!(k in en)) continue;
  if (k in pending.en) continue;
  if (used.has(k)) continue;
  pending.en[k] = en[k];
  added++;
}
pending.ko.cnPacketEnglishNote =
  '의료진이 읽을 수 있도록 제출 자료는 영어로 작성됩니다.';
pending.ko.cnReqHintDoctorStatement = '의사 소견서';
writeFileSync(pendingPath, JSON.stringify(pending, null, 2) + '\n', 'utf8');
console.log(`pending en keys: ${Object.keys(pending.en).length} (added ${added})`);
