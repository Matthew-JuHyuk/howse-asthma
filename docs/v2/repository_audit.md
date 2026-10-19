# Repository audit — v2.0 coverage-letter pivot

Date: 2026-10-18. This audit records what is in the repository. It does not
treat an unbuilt feature as finished.

## Stack

| Item | Found |
| --- | --- |
| App | Flutter (`pubspec.yaml` name `howse_asthma`, version `1.0.0+1`) |
| SDK | Dart `^3.12.2` |
| State | `StatefulWidget`, `ChangeNotifier`, inherited locale scope. No new state-management package. |
| Routing | `MaterialApp` home is `AuthGate` (or design preview). Feature screens use `MaterialPageRoute`. |
| Platforms | Android, iOS, Windows project folders are present. iOS is not built from Windows. |
| Backend | Supabase (`supabase_flutter`). Migrations live in `supabase/migrations/`. |
| PDF | `pdf` and `printing` packages, already used by visit-prep export. |
| Languages | ARB files for en, es, fr, ko, ja, zh. v2 copy is written for en, es, and ko. fr, ja, and zh currently reuse the English v2 strings. |

Build and test commands used in this repo: `flutter analyze`, `flutter test`.
Android device runs use the command line, not an emulator requirement.

## Sprint numbering

Repository documents show:

- Sprint 5 (records, visit prep, English PDF, four tabs): implementation
  checklist marked done, with device QA still open.
- A later environmental-evidence sprint is already numbered 6 and has core
  code plus a migration (`20261011180000_s6_regimen_and_evidence.sql`).
  Remote apply and device checks were still open in that checklist.

The v2.0 pivot is therefore tracked as **Sprint 7** so that Sprint 6 files
stay intact. The product version is 2.0. The attached requirements used
“Sprint 6” as a provisional label and asked for the number to follow the
repository.

## What already exists and is reused

| Area | Path | v2 use |
| --- | --- | --- |
| Auth | `lib/features/auth/` | Unchanged. Cases are not a new login. |
| Records | `lib/features/records/` | Still available from the v2 home via My records. |
| Visit PDF | `lib/features/visit_prep/data/visit_pdf.dart` | Font and share pattern reused by `appeal_pdf.dart`. |
| Settings / locale | `lib/features/settings/`, `lib/core/locale/` | Language switch stays. A local preview toggle was added. |
| Environment | `lib/features/environment/` | Left in place. Not required for the sample denial flow. |

## What this change adds

- Feature flags `V2_NAVIGATION_ENABLED`, `LIVE_DOCUMENT_PROCESSING_ENABLED`,
  `VERIFIED_EVIDENCE_ENABLED` (all default off).
- A settings switch that turns on the coverage-letter home without removing
  the previous home.
- An in-memory **sample** case: review facts, three-part explanation, English
  review draft, clinician one-page plan, share sheet.
- Deterministic rules for deadlines, quotes, upload signatures, and draft gates.
- Additive SQL in `supabase/migrations/20261018120000_v2_appeal_cases.sql`.
  It has not been applied to a remote database in this change.

## What is not done

- Live OCR or a model call. Live reading stays off and is not presented as an analysis.
- Upload of a real photo or PDF into Storage. The add-letter action explains that.
- Server jobs, retry, and deletion workers.
- Reviewed evidence-catalog content.
- Remote RLS proof against a second user.
- Device layout checks and a recorded demo.
- Renaming the app. The visible title stays as it is.

## Display name

The v2 requirements used a temporary product label. That label is not applied
in code, stores, or the window title. A later release is expected to drop
wording that suggests a diagnosis from the exposed app name. This change does
not perform that rename.
