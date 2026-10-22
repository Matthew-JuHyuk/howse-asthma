# Sprint 9 setup

## Migration

```powershell
cd "C:\work\Howse Asthma"
npx supabase db push --project-ref jnzdovjjahvtxbhacjuv
```

File: `supabase/migrations/20261022090000_s9_covernote.sql`. Additive.

## Edge function

Redeploy `analyze-letter` (now also handles `translate` and `read_label`):

```powershell
npx supabase functions deploy analyze-letter --project-ref jnzdovjjahvtxbhacjuv
```

Same AI secrets as Sprint 8 (`AI_PROVIDER`, `GEMINI_API_KEY` or `OPENAI_API_KEY`, `AI_MODEL`).

Environment: existing `calculate-environment-risk`. Optional `AIRNOW_API_KEY`.
Open-Meteo (current + archive) needs no key and is the history path.

## Client

```powershell
flutter pub get
flutter gen-l10n
powershell -ExecutionPolicy Bypass -File scripts/build_release.ps1
```

## Seed

`node tool/demo_accounts.mjs seed A` still works. New tables start empty and
are filled as the user records uses / deliveries.
