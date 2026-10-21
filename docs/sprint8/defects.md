# Defects

Each entry: how it showed up, the cause, the fix commit and the re-check. Commits are on `sprint8-covernote-mvp1`.

## Closed

### D-01 Sign-in did not work (product, blocking)
- **Seen**: the reported "login does not work" at the base commit `8bbef92`.
- **Cause**: the main sign-in path was Google OAuth (Apple on iOS). Neither provider is enabled on the server;
  `/auth/v1/authorize?provider=google` → `400 validation_failed: provider is not enabled`, shown on a browser page.
  Other failures collapsed into one generic message. Details: [auth_diagnosis.md](./auth_diagnosis.md).
- **Fix**: `18f2e19` — email sign-up/sign-in/reset only; code-based error mapping (`auth_errors.dart`); profile failures shown separately with retry.
- **Re-check**: server sign-up, sign-in and profile insert under RLS pass (account scripts). In-app check on a phone: **not run**.

### D-02 Doctor summary spilled to a second page when records were attached (product)
- **Seen**: PDF test "one-page summary" failed with `summary_does_not_fit` once the medication summary and local context were linked.
- **Cause**: the records section used prose plus a separate context table; with both attached the summary exceeded one US Letter page at ≥ 10 pt.
- **Fix**: `14dc0a8` — records as one Record / Count / Note table; a fifth compaction level moves local context to the appendix
  (the summary then says "Attached in the appendix"); shorter status words.
- **Re-check**: PDF tests pass, including long reasons + 10 extra items; minimum font 10 pt.

### D-03 Seeded records fell outside the app's 30-day window (test data)
- **Seen**: on any day other than 2026-10-20 the app's record window (30 full days before the phone's local today) would miss part of the seed.
- **Cause**: `tool/demo_accounts.mjs` fixed `DEMO_TODAY = '2026-10-20'` and `RANGE_START = '2026-09-20'`.
- **Fix**: `9c97caa` — window ends at the computer's local today, or `--today=YYYY-MM-DD` for a recorded demo.
- **Re-check**: `seed A` then `status A` → 54 answered checks, 8 inhaler events, 24 context rows.

### D-04 Translation merge broke code generation (tooling)
- **Seen**: `flutter gen-l10n` failed on placeholders named `String 1` / `String No`.
- **Cause**: the merge script's placeholder regex also matched words inside ICU plural bodies.
- **Fix**: `18f2e19` — regex limited to `{name}` / `{name,` at identifier positions (`tool/merge_covernote_l10n.mjs`).
- **Re-check**: gen-l10n and `flutter analyze` clean.

### D-05 Icon generator rewrote the iOS project file (tooling)
- **Seen**: `ios/Runner.xcodeproj/project.pbxproj` changed unexpectedly after `flutter_launcher_icons`.
- **Fix**: file restored with `git restore` before commit; only icon images are committed.
- **Re-check**: `project.pbxproj` unchanged from base in `git diff 8bbef92 HEAD`.

### D-06 A guessed default AI model id was in the server code (config)
- **Seen**: review of `providers.ts` found a hard-coded fallback model id for Gemini.
- **Cause**: convenience default not taken from any confirmed setting.
- **Fix**: `8f9a0fa` — `AI_MODEL` is required; health reports `missing: "AI_MODEL"` if unset. Redeployed as `analyze-letter` v2.
- **Re-check**: health probe answers with the missing setting name.

### D-07 Live probe left an empty case on test account A (tooling)
- **Seen**: after `analyze_probe.mjs run` returned `503 ai_not_configured`, a non-demo case with one uploaded file stayed in account A.
- **Fix**: `8f9a0fa` — the probe deletes its own case and files when the start call fails. The earlier orphan (account A only) was removed.
- **Re-check**: second run printed `cleanup_case_status: 204`; account A lists no non-demo cases.

### D-08 Fixture PDFs could be corrupted on checkout (repo)
- **Seen**: Git warned it would convert line endings in the new fixture PDFs (`core.autocrlf=true`).
- **Fix**: `06f4110` — `.gitattributes` marks PDFs, images and fonts as binary.
- **Re-check**: stored blobs equal the source files byte for byte (`git hash-object --no-filters`).

## Open

None found so far. This does not mean the untested paths are defect-free: live analysis, camera capture,
OS share, password reset and every on-device check are still blocked (see [verification.md](./verification.md)).
