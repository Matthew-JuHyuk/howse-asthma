// Merges tool/l10n_overlays/covernote.{en,ko}.json into lib/l10n/app_{en,ko}.arb.
// Placeholder metadata for the English template is generated from the
// message text: names listed in INT_NAMES are ints, everything else a String.
// Usage: node tool/merge_covernote_l10n.mjs
import { readFileSync, writeFileSync } from "fs";
import path from "path";
import { fileURLToPath } from "url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
const INT_NAMES = new Set([
  "count", "done", "total", "mb", "max", "pages", "n", "days", "taken", "notTaken",
  "unknown", "scheduled", "uses", "puffs", "night", "entries", "high",
]);

function placeholders(message) {
  const names = new Set();
  // Top-level {name} or {name, plural, ...}; nested plural bodies reuse names.
  for (const m of message.matchAll(/\{([A-Za-z_]\w*)\s*[},]/g)) names.add(m[1]);
  const out = {};
  for (const n of names) out[n] = { type: INT_NAMES.has(n) ? "int" : "String" };
  return out;
}

function merge(lang) {
  const arbPath = path.join(root, "lib", "l10n", `app_${lang}.arb`);
  const overlay = JSON.parse(readFileSync(path.join(root, "tool", "l10n_overlays", `covernote.${lang}.json`), "utf8"));
  const arb = JSON.parse(readFileSync(arbPath, "utf8"));
  for (const [key, value] of Object.entries(overlay)) {
    arb[key] = value;
    if (lang === "en") {
      const ph = placeholders(value);
      if (Object.keys(ph).length) arb[`@${key}`] = { placeholders: ph };
      else delete arb[`@${key}`];
    }
  }
  writeFileSync(arbPath, JSON.stringify(arb, null, 2) + "\n", "utf8");
  console.log(`${lang}: ${Object.keys(overlay).length} keys merged`);
}

merge("en");
merge("ko");
