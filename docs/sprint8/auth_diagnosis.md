# Auth diagnosis (AUTH-01)

Provider: Supabase Auth (`supabase_flutter` 2.16, PKCE). No other provider is in the code.
Probe: `node tool/auth_probe.mjs` prints status and error codes only.

## Server settings (read 2026-10-20 from `/auth/v1/settings`)

| Setting | Value |
| --- | --- |
| Email provider | enabled |
| Google | **disabled** |
| Apple | **disabled** |
| Sign-up disabled | false |
| Email auto-confirm (`mailer_autoconfirm`) | true |

## Cause table

| # | Check | Result | Code path at base `8bbef92` | Fix |
| --- | --- | --- | --- | --- |
| 1 | Provider enablement | **Root cause.** The welcome and login screens led with "Continue with Google" (and Apple on iOS). `/auth/v1/authorize?provider=google` returns `400 validation_failed: provider is not enabled`. The OAuth call opens the browser, so this error appeared on a browser page and the user never returned to the app | `login_screen.dart` `_oauth(OAuthProvider.google)` | Social buttons removed. Email sign-up / sign-in only (spec: keep OAuth only if it already works) |
| 2 | Error mapping | Errors were matched on English message substrings; anything else (network, provider disabled, server error, profile failure) showed one generic message | `auth_error_mapper.dart` | `lib/features/covernote/auth/auth_errors.dart` maps `AuthException.code` / HTTP status to 13 kinds; unknown errors show the safe code |
| 3 | Wrong password vs. unknown user | Server returns `400 invalid_credentials` for both (by design) | — | Shown as "email or password is wrong" |
| 4 | Email confirmation | Auto-confirm is on, so new accounts can sign in at once. `email_not_confirmed` is still mapped, with a resend action | `auth_screen.dart` `_resend()` | — |
| 5 | Callback / redirect | Android intent filter for `io.supabase.howseasthma://login-callback/` exists; `AppConfig.authRedirect` uses the same value for sign-up and reset | `AndroidManifest.xml:42`, `app_config.dart:15` | The server-side redirect allow list must contain this URL — **not readable with the public key; needs the dashboard** |
| 6 | Password reset return | Recovery deep link raises `AuthChangeEvent.passwordRecovery`; the app shows the set-new-password screen | `session_controller.dart:55`, `covernote_root.dart:43` | **Blocked**: needs the allow-list entry and a mailbox that receives auth mail (see setup_runbook) |
| 7 | Auth state subscription and route guard | Base used a `StreamBuilder` gate that replaced the whole app while signed out. New shell stays visible while signed out; actions that store data call `requireSignIn` and continue after sign-in | `session_controller.dart`, `covernote_root.dart` | No redirect loop: the gate only reacts to session changes |
| 8 | Profile creation after sign-in | If no `profiles` row exists, one is created as PATIENT; a duplicate insert (`23505`) re-reads. Failures show `profileError` with the code and a retry, not "wrong password" | `session_controller.dart:79-127` | Verified against RLS by the account scripts below |
| 9 | Token expiry | `session_expired`, `refresh_token_not_found`, `refresh_token_already_used` map to "session expired, sign in again" | `auth_errors.dart:64-68` | Device check not run |
| 10 | Anonymous accounts | The code never calls `signInAnonymously`; no conflict path | — | — |
| 11 | Device clock / network | Network errors are detected separately (`SocketException`, `ClientException`, lookup failure) | `auth_errors.dart:16-34` | Device check not run |

## Evidence

```
node tool/auth_probe.mjs
{"label":"settings_summary","email_enabled":true,"google_enabled":false,"apple_enabled":false,"signup_disabled":false,"mailer_autoconfirm":true}
{"label":"password_login_unknown_user","status":400,"code":"invalid_credentials"}
{"label":"oauth_google_authorize","status":400,"code":"validation_failed","msg":"Unsupported provider: provider is not enabled"}
```

Server-side sign-up, sign-in, profile creation under RLS, case storage and account deletion were exercised with real
accounts by `tool/demo_accounts.mjs` and `tool/delete_account_probe.mjs` (results in [verification.md](./verification.md)).
The in-app flows on a phone (sign-up → restart → session restored; reset link → app) have **not** been run.
