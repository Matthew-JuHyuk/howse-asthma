# Firebase / FCM setup (WBS 4.6a)

## Client (Android)

1. Firebase Console project (e.g. Howse Asthma / `howse-asthma`)
2. Android app package: `com.howseasthma.app`
3. Place `google-services.json` at `android/app/google-services.json` (**gitignored**)
4. Patient login → app requests notification permission → upserts `device_push_tokens`

## Edge secret (required for OS push)

Download a **Firebase service account** JSON (Project settings → Service accounts → Generate new private key).

Set as a single secret (do **not** commit the file):

```powershell
# From repo root — path to your downloaded JSON (keep outside git)
$json = Get-Content -Raw "C:\path\to\howse-asthma-firebase-adminsdk.json"
# Escape for CLI: write to a temp env file or pass carefully
supabase secrets set FIREBASE_SERVICE_ACCOUNT_JSON="$json"
supabase functions deploy notify-environment-risk
```

If the JSON contains newlines in `private_key`, storing the raw file content as the secret value is fine; Edge code normalizes `\\n` → newlines.

## Verify

1. Sign in as PATIENT on a real Android device; allow notifications
2. Confirm a row in `device_push_tokens`
3. Trigger risk ≥ 3 notify (Home / monitor)
4. Response / `environment_alerts_sent.payload` should show `fcm_sent: true` when secret is set and token valid
5. Background the app and trigger again (after cooldown window or different geohash) → OS notification

Without the Edge secret, notify still records the alert (`fcm_error: fcm_unconfigured`).

## Notes

- Keys / service account JSON: never in Dart, never in git
- Always-location permission is **not** enabled by 4.6a; see `docs/store-location-justification.md`
- iOS FCM app registration is deferred until Mac/CI builds
