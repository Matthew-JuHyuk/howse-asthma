# Setup and run book (Windows, no Android Studio, real device only)

Secrets never go in chat, source, the app bundle or logs. Server secrets are set with the Supabase CLI
on your own machine. Every check below prints status codes only.

## 1. Local files (git-ignored)

| File | Holds | How it is made |
| --- | --- | --- |
| `.env` | `SUPABASE_URL`, `SUPABASE_ANON_KEY`, optional dev keys | Copy `.env.example`, fill from Dashboard → Project Settings → API |
| `.env.client` | The only keys bundled into the app: `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `DESIGN_PREVIEW`, `DEBUG_API_CONSOLE` | `node tool/make_client_env.mjs` (`--release` forces both debug flags off) |
| `.env.demo` | Test account A/B emails and random passwords | Created by `node tool/demo_accounts.mjs create` |

## 2. Letter analysis (AI) — server secrets

The app never calls an AI service. `supabase/functions/analyze-letter` does, with these Edge secrets:

| Secret | Value |
| --- | --- |
| `AI_PROVIDER` | `gemini` or `openai` |
| `GEMINI_API_KEY` or `OPENAI_API_KEY` | Key for the chosen provider only |
| `AI_MODEL` | A model id your account can use that accepts PDF and image input and returns JSON matching a schema. Choose it from the provider's model list; no default is shipped |

Set them (PowerShell; the key is read from a prompt, not typed into history):

```powershell
$k = Read-Host -AsSecureString "API key"
$plain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($k))
npx supabase secrets set AI_PROVIDER=gemini "GEMINI_API_KEY=$plain" AI_MODEL=<model-id> --project-ref jnzdovjjahvtxbhacjuv
Remove-Variable plain
```

Set a monthly budget or spending cap in the provider console before testing.

Check (no secrets printed):

```powershell
node tool/analyze_probe.mjs health
# expected: {"status":200,"ai_configured":true,"provider":"gemini","model":"<model-id>",...}
# today:    {"status":200,"ai_configured":false,"missing":"AI_PROVIDER",...}
```

Request formats were checked against the provider documentation (Gemini Interactions API, OpenAI Responses API).
Neither has been called live from this project yet.

## 3. Auth settings (Dashboard → Authentication)

| Setting | Needed value | Why |
| --- | --- | --- |
| URL Configuration → Redirect URLs | `io.supabase.howseasthma://login-callback/` | Password-reset and confirmation links return to the app. Not readable with the public key, so it has not been confirmed |
| Emails → SMTP | A custom SMTP sender (Resend is the project's chosen email service), **or** test with an address the built-in sender will deliver to | The built-in sender is rate-limited and meant for testing. Check the Emails page for which recipients it currently allows |
| Providers | Email on. Google/Apple stay off | The app no longer shows social sign-in |

Check reset end to end on the phone: Account → sign out → Sign in → "Forgot password" → open the mail on the phone → the app opens
"Set a new password" → sign in with the new password.

## 4. Test accounts and demo data

```powershell
node tool/demo_accounts.mjs create            # A and B, idempotent; passwords stay in .env.demo
node tool/demo_accounts.mjs seed A            # resets A's demo rows, then seeds 30 days + 3 cases
node tool/demo_accounts.mjs seed A --today=2026-10-20   # fixed window end for a recorded demo
node tool/demo_accounts.mjs status A          # counts only
node tool/demo_accounts.mjs reset A           # removes A's demo-tagged rows only
node tool/demo_accounts.mjs isolation         # B tries to read/change/download A's case
node tool/delete_account_probe.mjs            # throwaway account: create, delete, confirm gone
```

The scripts run as the demo user (no service key), so row-level security limits them to that user's rows.
They refuse any account whose metadata is not `demo_account=true`.
Seed window = the 30 full days before `--today` (default: this computer's local date). Run it in the phone's time zone.

## 5. Live analysis of the synthetic letters

Print `test/fixtures/letters/printable_test_letters.pdf` (six synthetic letters, marked as synthetic on every page).
Photograph them with the app, or test the server directly:

```powershell
node tool/analyze_probe.mjs run test/fixtures/letters/printable_test_letters.pdf
node tool/analyze_probe.mjs run page1.jpg page2.jpg --expect test/fixtures/letters/expected.json --fixture S8-03
node tool/analyze_probe.mjs run covered.jpg --expect test/fixtures/letters/expected.json --fixture S8-06 --obscured
```

The answer file is read only by the probe on your PC. The server never receives it, a file name or a fixture id.
For the variant test (AT06), edit a copy of a letter (name, medicine, dates), print it and photograph it.

## 6. Build and install (release APK)

```powershell
powershell -ExecutionPolicy Bypass -File scripts/build_release.ps1
# -> build/app/outputs/flutter-apk/app-release.apk
adb devices                       # phone with USB debugging on
adb install -r build/app/outputs/flutter-apk/app-release.apk
adb logcat -s flutter             # app logs; no tokens or letter text are logged
```

The release build is signed with the debug key so it installs on a test phone. A store upload needs a separate upload key.
iOS cannot be built on Windows; it needs a Mac or a cloud macOS build.

## 7. Server deploys (already applied)

```powershell
npx supabase migration list                                  # local = remote through 20261021200000
npx supabase functions deploy analyze-letter --project-ref jnzdovjjahvtxbhacjuv
npx supabase functions deploy delete-account --project-ref jnzdovjjahvtxbhacjuv
```

Rollback: redeploy the previous function version from the dashboard. The migration is additive and needs no rollback for old app builds.
