// Translation workflow for the screens' strings.
//
//   node tool/l10n_validate.mjs source          # write tool/l10n_source/used_en.json
//   node tool/l10n_validate.mjs merge <tag>     # join tool/l10n_overlays/locales/<tag>.part*.json
//   node tool/l10n_validate.mjs check <tag>     # validate tool/l10n_overlays/locales/<tag>.json
//   node tool/l10n_validate.mjs build <tag>     # write lib/l10n/app_<tag>.arb from the overlay
//
// <tag> is the ARB locale suffix: es, pt, zh_Hans, zh_Hant, gu, ht, ar, ...
// Only keys the screens read are translated (see tool/l10n_audit.mjs).
import { execSync } from 'node:child_process';
import { existsSync, mkdirSync, readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

const OVERLAYS = 'tool/l10n_overlays/locales';
const SOURCE = 'tool/l10n_source/used_en.json';

// Expected writing system per language, used to catch untranslated leftovers.
const SCRIPT = {
  es: /\p{Script=Latin}/u,
  pt: /\p{Script=Latin}/u,
  ht: /\p{Script=Latin}/u,
  zh_Hans: /\p{Script=Han}/u,
  zh_Hant: /\p{Script=Han}/u,
  gu: /\p{Script=Gujarati}/u,
  ar: /\p{Script=Arabic}/u,
  ko: /\p{Script=Hangul}/u,
};
// Strings that must survive translation unchanged when the English has them.
const KEEP = ['CoverNote', '911', 'PDF'];

const readJson = (p) => JSON.parse(readFileSync(p, 'utf8').replace(/^\uFEFF/, ''));
const writeJson = (p, o) => writeFileSync(p, JSON.stringify(o, null, 2) + '\n', 'utf8');

function usedKeys() {
  return execSync('node tool/l10n_audit.mjs --used-keys', { encoding: 'utf8' })
    .split(/\r?\n/)
    .filter(Boolean);
}

// {name} placeholders, not ICU plural/select headers like "{count, plural,".
function placeholders(s) {
  const names = [...s.matchAll(/\{\s*([A-Za-z_]\w*)\s*(?=[},])/g)].map((m) => m[1]);
  return [...new Set(names)].sort();
}

function braceBalanced(s) {
  let d = 0;
  for (const c of s) {
    if (c === '{') d++;
    if (c === '}') d--;
    if (d < 0) return false;
  }
  return d === 0;
}

function source() {
  const en = readJson('lib/l10n/app_en.arb');
  const out = {};
  for (const k of usedKeys()) {
    const meta = en['@' + k] ?? {};
    out[k] = {
      en: en[k],
      ...(meta.description ? { note: meta.description } : {}),
      ...(Object.keys(meta.placeholders ?? {}).length ? { placeholders: Object.keys(meta.placeholders) } : {}),
    };
  }
  mkdirSync('tool/l10n_source', { recursive: true });
  writeJson(SOURCE, out);
  console.log(`${SOURCE}: ${Object.keys(out).length} keys`);
}

function merge(tag) {
  const parts = readdirSync(OVERLAYS)
    .filter((n) => n.startsWith(`${tag}.part`) && n.endsWith('.json'))
    .sort();
  if (!parts.length) throw new Error(`no ${tag}.part*.json in ${OVERLAYS}`);
  const out = {};
  for (const p of parts) Object.assign(out, readJson(join(OVERLAYS, p)));
  writeJson(join(OVERLAYS, `${tag}.json`), out);
  console.log(`${tag}.json: ${Object.keys(out).length} keys from ${parts.length} part(s)`);
}

function check(tag, { quiet = false } = {}) {
  const src = readJson(SOURCE);
  const path = join(OVERLAYS, `${tag}.json`);
  if (!existsSync(path)) throw new Error(`${path} not found`);
  const tr = readJson(path);
  const problems = [];
  const warnings = [];
  const expected = Object.keys(src);
  for (const k of expected) if (!(k in tr)) problems.push(`missing: ${k}`);
  for (const k of Object.keys(tr)) if (!(k in src)) problems.push(`unknown key: ${k}`);
  const script = SCRIPT[tag];
  let same = 0;
  for (const k of expected) {
    const en = src[k].en;
    const v = tr[k];
    if (typeof v !== 'string' || !v.trim()) {
      if (k in tr) problems.push(`empty: ${k}`);
      continue;
    }
    const a = placeholders(en).join(',');
    const b = placeholders(v).join(',');
    if (a !== b) problems.push(`placeholders differ: ${k} (en {${a}} vs {${b}})`);
    if (!braceBalanced(v)) problems.push(`unbalanced braces: ${k}`);
    if (/plural\s*,/.test(en)) {
      if (!/plural\s*,/.test(v)) problems.push(`plural lost: ${k}`);
      if (!/other\s*\{/.test(v)) problems.push(`plural has no "other{": ${k}`);
    }
    for (const lit of KEEP) {
      if (en.includes(lit) && !v.includes(lit)) problems.push(`"${lit}" must stay in: ${k}`);
    }
    // Typographic checks: stray ASCII quotes break nothing, but "\n" count should match.
    if ((en.match(/\n/g) ?? []).length !== (v.match(/\n/g) ?? []).length) {
      warnings.push(`line breaks differ: ${k}`);
    }
    const bare = en.replace(/\{[^}]*\}/g, '').replace(/[^A-Za-z]/g, '');
    if (v === en && bare.length > 12) same++;
    if (script && bare.length > 25) {
      // Ignore parenthesised English glosses: they are deliberate, so a user
      // can match the app's words to the English letter (e.g. EOB).
      const ownText = v
        .replace(/\{[^}]*\}/g, '')
        .replace(/\([^()]*\)/g, '')
        .replace(/（[^（）]*）/g, '');
      const letters = [...ownText].filter((c) => /\p{L}/u.test(c));
      const inScript = letters.filter((c) => script.test(c)).length;
      if (tag !== 'es' && tag !== 'pt' && tag !== 'ht' && letters.length && inScript / letters.length < 0.5) {
        problems.push(`mostly not in the expected script: ${k}`);
      }
    }
  }
  if (same > 15) warnings.push(`${same} long strings are identical to English`);
  if (!quiet) {
    for (const p of problems) console.log('PROBLEM ' + p);
    for (const w of warnings) console.log('warn    ' + w);
  }
  console.log(JSON.stringify({ tag, keys: expected.length, translated: Object.keys(tr).length, problems: problems.length, warnings: warnings.length }));
  return problems.length;
}

function build(tag) {
  if (check(tag, { quiet: true }) > 0) {
    check(tag);
    throw new Error(`${tag}: fix the problems above before building`);
  }
  const tr = readJson(join(OVERLAYS, `${tag}.json`));
  const out = { '@@locale': tag.replace('_', '-').replace('-', '_') };
  Object.assign(out, tr);
  const path = `lib/l10n/app_${tag}.arb`;
  writeJson(path, out);
  console.log(`${path}: ${Object.keys(tr).length} keys`);
  // gen-l10n needs a base locale next to script-coded ones. A plain "zh"
  // reader gets Simplified, matching appLanguageForTag('zh').
  if (tag === 'zh_Hans') {
    writeJson('lib/l10n/app_zh.arb', { ...out, '@@locale': 'zh' });
    console.log('lib/l10n/app_zh.arb: base fallback (Simplified)');
  }
}

const [cmd, tag] = process.argv.slice(2);
try {
  if (cmd === 'source') source();
  else if (cmd === 'merge' && tag) merge(tag);
  else if (cmd === 'check' && tag) process.exitCode = check(tag) > 0 ? 1 : 0;
  else if (cmd === 'build' && tag) build(tag);
  else console.log('usage: node tool/l10n_validate.mjs source | merge <tag> | check <tag> | build <tag>');
} catch (e) {
  console.error(String(e.message ?? e));
  process.exitCode = 1;
}
