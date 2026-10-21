# Handoff — CoverNote MVP1 (Sprint 8)

**State: MVP1 NOT YET VERIFIED.** The code for every P0 item is in place and the parts that can be checked on this PC
and against the development server pass. Live AI analysis, password reset and every on-phone check are blocked on
outside settings or a connected phone. Details: [verification.md](./verification.md), [requirements_traceability.md](./requirements_traceability.md).

## What is delivered

| Item | Value |
| --- | --- |
| Branch | `sprint8-covernote-mvp1` (base `8bbef92`) |
| Release APK | `build/app/outputs/flutter-apk/app-release.apk` — version `1.0.0+1`, id `com.howseasthma.app`, debug-key signed |
| APK SHA-256 | see [verification.md](./verification.md) § Release build |
| Migration | `supabase/migrations/20261021120000_s8_covernote_mvp1.sql` and `20261021200000_s8_profile_languages.sql` — applied to `jnzdovjjahvtxbhacjuv` |
| Languages | Nine, see [`languages.md`](./languages.md). Translations are not yet reviewed by native speakers |
| Edge Functions | `analyze-letter` v2, `delete-account` v1 (deployed) |
| Build command | `powershell -ExecutionPolicy Bypass -File scripts/build_release.ps1` |
| Test accounts | `node tool/demo_accounts.mjs create` / `seed A` / `reset A` (credentials in git-ignored `.env.demo`) |
| Fixtures | `test/fixtures/letters/` — six synthetic letters, expected answers, reference summary |
| Config example | `.env.example`, `scripts/set-edge-secrets.example.ps1` (no secrets) |

## Action required (owner)

Only these items block MVP1. Nothing here needs a secret pasted into chat or the repository.

| # | Needed | Why | Where / minimal action | Check without exposing secrets | Unblocks |
| --- | --- | --- | --- | --- | --- |
| 1 | AI provider, key, model, budget | Real letter analysis runs only on the server | Provider console: enable billing, set a spending cap. Then `npx supabase secrets set AI_PROVIDER=gemini\|openai GEMINI_API_KEY=… (or OPENAI_API_KEY=…) AI_MODEL=<model id> --project-ref jnzdovjjahvtxbhacjuv` (runbook §2 reads the key from a prompt) | `node tool/analyze_probe.mjs health` → `"ai_configured":true` | W8-08, W8-24, AT04–AT08, AT12, AT14, AT17 |
| 2 | Redirect allow list | Reset and confirmation links must open the app | Dashboard → Authentication → URL Configuration → add `io.supabase.howseasthma://login-callback/` | Reset link on the phone opens "Set a new password" | W8-03, AT03 |
| 3 | Auth mail delivery | Reset mail must reach a test inbox | Dashboard → Authentication → Emails: custom SMTP (e.g. the project's Resend sender) or confirm the built-in sender delivers to your test address | Reset mail arrives | AT03 |
| 4 | Android phone over USB | Camera, share sheet, restart, launcher icon, release run | USB debugging on; `adb devices` lists it; then `adb install -r …app-release.apk` | `adb logcat -s flutter` while running the demo script | W8-23, AT01, AT02, AT15, AT16, AT19, AT20 |
| 5 | Printed letters | Fresh photos for live tests | Print `test/fixtures/letters/printable_test_letters.pdf`; make one edited variant (name, medicine, dates) | Probe `--fixture` comparison shows 0 mismatches or explains each | AT04–AT07 |

After 1–5: run [demo_script.md](./demo_script.md) Run B on the phone, the 10 timed probe runs, then update verification.md.

## Known limits

- iOS: project name and icon are set, but iOS cannot be built on Windows (needs a Mac or a cloud macOS build).
- Local context is manual entry with source and date. Automatic collection from the existing environment functions is P1.
- Release signing uses the debug key; a store release needs an upload key.
- Package id and auth callback scheme still use the original `howseasthma` names on purpose.
- The provider (clinician) role screens remain in the code but are not on the CoverNote path.
- Usability target (5 new users) has not been measured.
