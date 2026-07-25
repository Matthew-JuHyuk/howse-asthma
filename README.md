# Howse Asthma

Flutter app for asthma patients: predicts attack risk from local weather/air-quality data and sends early warnings, while logging inhaler/medication use as evidence for insurance step-therapy approval. Multilingual (EN/ES/FR/KO/JA/ZH) to lower barriers for underserved, non-native-English patients & families. Android/iOS, Supabase backend.

## Tech stack

- [Flutter](https://flutter.dev/) (stable channel) — Android, iOS, and Windows (for early PC-based development)
- [Supabase](https://supabase.com/) — authentication and database
- `flutter_localizations` + ARB files for multilingual support (English, Spanish, French, Korean, Japanese, Chinese)

## Getting started

```powershell
git clone https://github.com/Matthew-JuHyuk/howse-asthma.git
cd howse-asthma
flutter pub get
Copy-Item .env.example .env   # then fill in your Supabase project URL/anon key
flutter run -d windows        # or connect an Android device and run `flutter run`
```

## Docs (committed)

Shared English documentation lives under [`docs/`](docs/) (tracked in Git).  
- Schema / RLS: [`docs/db-schema.md`](docs/db-schema.md), [`docs/rls-policies.md`](docs/rls-policies.md)  
- Migrations: [`docs/migrations.md`](docs/migrations.md)  
- Edge Functions: [`docs/edge-functions.md`](docs/edge-functions.md)  

When changing `supabase/migrations` or `supabase/functions`, update the matching `docs/` notes in the same change set — see [`docs/README.md`](docs/README.md).

## Backend (Supabase)

- Migrations applied: init schema + RLS (`supabase/migrations/`).  
- Edge Function **deployed** (skeleton): `calculate-environment-risk` — see [`docs/edge-functions.md`](docs/edge-functions.md).  
- Live environmental API wiring is still Phase 3; secrets are registered on the linked project.  
- Local secret helper (gitignored): `scripts/set-edge-secrets.ps1` — do not commit.

## Design preview (patient mockups)

Set `DESIGN_PREVIEW=true` in `.env` (see `.env.example`), then:

```powershell
flutter run
```

Opens a **low-fidelity** nav-only patient UI (`lib/features/design_preview/`) for flow checks — **not** store-ready.  
Subframe patient React references: [`design/subframe/`](design/subframe/). For normal auth path use `DESIGN_PREVIEW=false`.

## License

Apache License 2.0 — see [LICENSE](LICENSE).
