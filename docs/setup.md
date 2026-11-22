# Build CoverNote with your own configuration

## Requirements

Use Flutter with Dart compatible with `pubspec.yaml` (currently Dart ^3.12.2), Android SDK / JDK 17, Node.js, and the Supabase CLI for backend deployment. The distributed demo targets Android.

## Client

```powershell
git clone https://github.com/Matthew-JuHyuk/CoverNote.git
cd CoverNote
flutter pub get
Copy-Item .env.example .env
# Set your own SUPABASE_URL and SUPABASE_ANON_KEY in .env.
node tool/make_client_env.mjs
flutter gen-l10n
flutter run
```

Configure a Firebase Android app using the `applicationId` defined in `android/app/build.gradle.kts`, then place its configuration at `android/app/google-services.json` (ignored by Git). The Android build currently applies the Google Services plugin. Do not use someone else’s backend or Firebase settings.

Only the Supabase URL, client anon/publishable key, and two UI flags enter `.env.client`. A client key is extractable from an APK and must be protected by backend row-level security. Never use a Supabase service-role key as the client key. AI/provider/service-account credentials belong only in backend secrets.

## Backend

Create your own Supabase project, link it using the CLI, and review/apply the SQL under `supabase/migrations/`. Configure authentication redirects and providers for your deployment. Deploy the functions needed by your chosen workflows under `supabase/functions/`; inspect their environment variables and authorization requirements before enabling them. `scripts/set-edge-secrets.example.ps1` provides placeholder examples. Use current provider documentation for credentials and available model identifiers.

Use synthetic data for development. Do not copy private demo account credentials or patient records into fixtures. Read migration and function code as the authoritative schema/API reference.

## Verify and build

```powershell
flutter analyze
flutter test
powershell -ExecutionPolicy Bypass -File scripts/build_release.ps1
```

Output: `build/app/outputs/flutter-apk/app-release.apk`. The helper generates a client-only configuration and disables debug flags. The existing Android release configuration uses the development signing key; configure your own secure release signing before distributing a production build. Keep keystores and signing passwords outside Git.

Voice recognition varies by device and language; typing remains available. Environmental data depends on provider coverage. iOS is not a released target yet.
