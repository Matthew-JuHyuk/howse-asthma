# Howse Asthma

Flutter app for asthma patients: predicts attack risk from local weather and air-quality data and sends early warnings, while logging inhaler and medication use as evidence for insurance step-therapy approval. Multilingual (EN/ES/FR/KO/JA/ZH) to lower barriers for underserved, non-native-English patients and families. Android, iOS, and Supabase backend.

## Tech stack

- [Flutter](https://flutter.dev/) (stable channel) — Android, iOS, and Windows (for early PC-based development)
- [Supabase](https://supabase.com/) — authentication, database, and Edge Functions
- `flutter_localizations` + ARB files for multilingual support (English, Spanish, French, Korean, Japanese, Chinese)

## Getting started

```powershell
git clone https://github.com/Matthew-JuHyuk/howse-asthma.git
cd howse-asthma
flutter pub get
Copy-Item .env.example .env   # then fill in your Supabase project URL/anon key
flutter run -d windows        # or connect an Android device and run `flutter run`
```

## Documentation

Project documentation is under [`docs/`](docs/):

- Schema and RLS: [`docs/db-schema.md`](docs/db-schema.md), [`docs/rls-policies.md`](docs/rls-policies.md)
- Migrations: [`docs/migrations.md`](docs/migrations.md)
- Auth / OAuth / pairing: [`docs/auth.md`](docs/auth.md)
- Edge Functions: [`docs/edge-functions.md`](docs/edge-functions.md)

When you change `supabase/migrations` or `supabase/functions`, update the matching notes under `docs/` in the same change set. See [`docs/README.md`](docs/README.md).

## Backend

- SQL migrations live in `supabase/migrations/` (schema and RLS).
- Edge Function `calculate-environment-risk` is deployed; environmental data source clients are still being completed.
- Use `.env` / Edge secrets for API keys — never commit secrets. Template: `scripts/set-edge-secrets.example.ps1`.

## Design references

Patient UI layout references from Subframe are under [`design/subframe/`](design/subframe/).  
Optional preview mode: set `DESIGN_PREVIEW=true` in `.env`, then `flutter run` to open the patient navigation mock under `lib/features/design_preview/`. Set `DESIGN_PREVIEW=false` for the normal auth entry path.

## License

Apache License 2.0 — see [LICENSE](LICENSE).
