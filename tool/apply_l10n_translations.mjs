/**
 * Merge locale overlays onto app_en.arb metadata and write app_*.arb.
 * Run: node tool/apply_l10n_translations.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const l10n = path.join(root, "lib", "l10n");
const overlaysDir = path.join(__dirname, "l10n_overlays");

const en = JSON.parse(fs.readFileSync(path.join(l10n, "app_en.arb"), "utf8"));

for (const lang of ["es", "fr", "ko", "ja", "zh"]) {
  const overlayPath = path.join(overlaysDir, `${lang}.json`);
  const overlay = JSON.parse(fs.readFileSync(overlayPath, "utf8"));
  const out = {};
  // Always set locale from the overlay language; do not require @@locale in app_en.arb
  out["@@locale"] = lang;
  for (const [k, v] of Object.entries(en)) {
    // Skip @@locale / @@@* from en so we never overwrite out["@@locale"] with "en"
    if (k === "@@locale" || k.startsWith("@@@")) continue;
    if (k.startsWith("@")) {
      out[k] = v;
      continue;
    }
    out[k] = overlay[k] ?? v;
  }
  const dest = path.join(l10n, `app_${lang}.arb`);
  fs.writeFileSync(dest, JSON.stringify(out, null, 2) + "\n", "utf8");
  const missing = Object.keys(en).filter(
    (k) => !k.startsWith("@") && overlay[k] == null,
  );
  const stillEn = Object.keys(en).filter(
    (k) =>
      !k.startsWith("@") &&
      overlay[k] != null &&
      overlay[k] === en[k] &&
      typeof en[k] === "string" &&
      /[A-Za-z]{3,}/.test(en[k]),
  );
  console.log(
    `${lang}: wrote ${dest} missing=${missing.length} identicalToEn=${stillEn.length}`,
  );
  if (missing.length) console.log("  missing sample", missing.slice(0, 15));
}
