# Sprint 9 audit

Audit date: 2026-10-21 (America/New_York).
Branch: `sprint8-covernote-mvp1` at `039d5c6` plus uncommitted language-overlay
edits (preserved). There is no `AGENTS.md` in this repository; agent rules live
under `.cursor/rules/` (Sprint 8 CoverNote contract wins over earlier sprints
until it conflicts with this sprint).

Sprint 9 requirements came from the owner's package
(`CoverNote_Sprint9_Requirements.md`, `Sprint9_Acceptance_Checklist.md`).
They were not in the repo at audit time. This sprint's product behaviour
overrides conflicting Sprint 8 copy and flows.

## What the app does today (Sprint 8)

| Area | Finding | Path |
| --- | --- | --- |
| Shell | Home / Cases / Records / Account. Case detail is a pushed route that hides the tab bar | `lib/features/covernote/covernote_root.dart`, `routes.dart` |
| Locale | `LocaleController` + prefs `app_locale_code`. No `MaterialApp` key (state should survive). Language chrome only on Home and sign-in | `lib/core/locale/`, `lib/app.dart` |
| Case steps | One `CaseScreen` with `_step` 0–3. Steps do not stack. System back walks steps | `case_screen.dart` |
| Case title | Medication name only. No fixed number, created time, or insurer on cards | `case_labels.dart`, `case_card.dart` |
| Share | `Printing.sharePdf`. Android treats opening the sheet as success → `last_exported_at`. No delivery log table | `packet_step.dart` |
| Records window | `DayRange.lastDays` **ends yesterday** | `record_snapshot.dart:8-11` |
| Daily log vs case | Daily log writes `pdc_daily_checks`; case snapshots read `medication_occasion_checks` + `inhaler_events` only | `record_inputs.dart`, `supabase_case_store.dart:624-674` |
| Environment | Manual `local_context_entries`. Flutter `features/environment` deleted. Edge `calculate-environment-risk` still deployed | `local_context_screen.dart`, `docs/sprint8/audit.md` |
| Consent | Silent `consent_events` insert on create. No toggle. Service health is a separate check | `supabase_case_store.dart:257-261`, `account_tab.dart` |
| Letter | OCR text is the main Letter view. Original is a second screen. No full translation | `letter_view.dart` |
| Review | Confirmation form + required field checks before Evidence | `review_step.dart`, `case_facts.dart` |
| Lifecycle | No `active` / `completed` / `archived`. Share does not complete a case | `appeal_cases.status` |
| Label OCR | None | — |

Uncommitted user work at audit: NJ language overlays and `docs/sprint8/languages.md`.
Those files are left intact; Sprint 9 adds new keys rather than reverting them.

## Keep / add

No existing table is dropped or renamed. New columns and tables are additive.
Old record rows stay. Duplicate-looking dose rows are not deleted.

| Keep | Add |
| --- | --- |
| Auth, RLS, `analyze-letter`, `delete-account` | Explicit AI consent + label/translate purposes |
| `patient_medications` / regimens / inhaler / symptoms / PDC | `medication_use_events` + adapters that still read old tables |
| `local_context_entries` + env Edge functions | Auto fetch, event-time snapshots, ZIP/city area |
| Case / facts / artifacts / jobs | Ordinal, alias, treatment context, lifecycle, delivery events, translations |
| Nine NJ languages | Language chrome on every app-owned screen |

## Conflicts with Sprint 8 (Sprint 9 wins)

- Local context is no longer a manual-entry primary path.
- Review is no longer a confirm-every-field form.
- Letter primary view is the original file, not OCR.
- Account tab becomes Settings (account features stay inside it).
- Record window includes today.
- Share cancel must not write a delivery or “shared” completion.
