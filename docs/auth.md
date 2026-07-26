# Authentication

Howse Asthma uses Supabase Auth in a single OSMU app. After sign-in, the client loads
`profiles.role` (`PATIENT` | `PROVIDER`) and opens the matching shell.

## Email / password

1. Sign in: email + password (`signInWithPassword`).
2. Sign up: role, full name, language, password; providers also enter NPI (10 digits + checksum).
3. On success with a session, the app inserts `profiles` and either `patient_details` or
   `provider_credentials`.
4. If email confirmation is enabled in the Supabase project, the session may be null after
   signup — the app shows a “check your email” screen. Metadata from signup is retained so
   profile completion can prefill after the first confirmed login.

Set `DESIGN_PREVIEW=false` (or remove it) in `.env` to use this AuthGate path.

## OAuth (Google / Apple)

Client calls `signInWithOAuth` with redirect scheme:

`io.supabase.howseasthma://login-callback/`

### Dashboard setup (required before OAuth works)

1. Supabase Dashboard → Authentication → Providers → enable **Google** and/or **Apple**.
2. Paste client IDs/secrets from Google Cloud / Apple Developer (do not commit them).
3. Authentication → URL configuration → add redirect URL:
   `io.supabase.howseasthma://login-callback/`
4. Android intent-filter is declared in `android/app/src/main/AndroidManifest.xml`.

Apple Sign In is offered on iOS only. Windows desktop OAuth depends on the system browser
callback; prefer Android device testing for Google.

If OAuth succeeds but no `profiles` row exists, the complete-profile screen collects role / NPI.

## Biometric unlock

`local_auth` gates an existing Supabase session. Preference is stored on-device only
(`shared_preferences`). Toggle lives in patient and provider Settings.

## Patient–provider pairing

Clients have **SELECT-only** RLS on `invite_codes` and `patient_care_links`.
All writes go through Edge Functions using `service_role` + atomic SQL RPCs.

| Edge Function | Who | Effect |
| --- | --- | --- |
| `issue-invite-code` | Provider | Inserts 6-digit code, TTL 24h (max 5 active per provider) |
| `redeem-invite-code` | Patient | Atomic consume + pending link (`redeem_invite_code_as`); rate-limited |
| `confirm-care-link` | Either side | Atomic confirm/reject while `pending` (`confirm_care_link_as`) |

Security notes:

- `profiles.role` cannot be changed after create (DB trigger).
- Redeem errors are uniform (`invite_invalid`) to reduce code enumeration.
- Biometric unlock is a local UX gate on an existing session (not a second auth factor). Preferences are keyed by user id.

Demo SQL (manual): [`supabase/seed/demo_care_link.sql`](../supabase/seed/demo_care_link.sql).

Deploy:

```powershell
supabase functions deploy issue-invite-code
supabase functions deploy redeem-invite-code
supabase functions deploy confirm-care-link
```
