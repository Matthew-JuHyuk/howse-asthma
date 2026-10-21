# Sprint 8 WBS — CoverNote MVP1

Status values: `todo` · `doing` · `blocked` (waits on an outside setting or a physical device) · `verified` (run, with evidence).
Owner: **Cursor** = implementation and automated checks. **User** = secrets, console access, physical device steps.
Commits are on `sprint8-covernote-mvp1`.

| ID | Req | Owner | Depends | Main files | Scope | Acceptance check | Effort | Status | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| W8-01 | AUTH-01 | Cursor | — | `tool/auth_probe.mjs`, `docs/sprint8/auth_diagnosis.md` | Find why sign-in failed | Cause shown with server codes | S | verified | auth_probe output; `18f2e19` |
| W8-02 | AUTH-01 | Cursor | W8-01 | `lib/core/session/session_controller.dart`, `lib/features/covernote/auth/*` | Email sign-up, sign-in, reset request, set new password, sign-out, coded errors, profile create | Server flow with real accounts | M | verified (server) | `demo_accounts.mjs create`, `delete_account_probe.mjs` |
| W8-03 | AUTH-01 | User | W8-02 | Dashboard | Redirect allow list + mail delivery for reset | Reset link opens the app | S | blocked | needs dashboard access |
| W8-04 | UX-01 | Cursor | — | `AndroidManifest.xml`, `Info.plist`, `assets/branding/*`, `tool/make_brand_assets.dart`, `ui/brand.dart` | Name, tagline, adaptive + monochrome icon, iOS 1024 | Label/header/PDF say CoverNote | S | verified (files, tests) | `18f2e19`; widget test finds title |
| W8-05 | UX-02 | Cursor | W8-02 | `presentation/home_tab.dart`, `covernote_root.dart` | Home order, 4 tabs, no SOS header, sign-in on demand | Widget tests | M | verified | `widget_test.dart` (4 tests) |
| W8-06 | DOC-01 | Cursor | W8-05 | `presentation/capture_screen.dart`, `domain/upload_guard.dart` | Camera, gallery, PDF; rotate, retake, reorder, delete; type/size/page/encryption checks | Unit tests; device run | M | verified (unit) / blocked (device) | `upload_guard_test.dart` |
| W8-07 | AI-01 | Cursor | W8-06 | `supabase/functions/analyze-letter/*` | Server job with lease, idempotency key, retries, safe codes, request ids, tokens | Deployed; health probe | L | verified (deploy) | analyze-letter v2; health `ai_configured:false` |
| W8-08 | AI-01 | User | W8-07 | Edge secrets | `AI_PROVIDER`, key, `AI_MODEL`, budget | `analyze_probe.mjs health` → `ai_configured:true` | S | blocked | — |
| W8-09 | DOC-02 | Cursor | W8-07 | `analyze-letter/validate.ts` | Quote must exist in page text; verbatim medicine/dose; null/ambiguous; 7 document kinds | Node tests | M | verified | `node tool/test_validate.mjs` 12/12 |
| W8-10 | DOC-02 | Cursor | W8-09 | `domain/case_facts.dart` | Deadline: explicit vs relative; calendar days only; conflict/business days → review | Unit tests | M | verified | `covernote_deadline_test.dart` 12 tests |
| W8-11 | UX-03 | Cursor | W8-10 | `case_screen.dart`, `review_step.dart`, `letter_view.dart` | Letter/Review/Evidence/Packet; 3 cards with page + quote; autosave + Saved | Demo journey test | L | verified | `demo_journey_test.dart` |
| W8-12 | CASE-01 | Cursor | W8-11 | `evidence_step.dart`, `case_requirements` table | Requested item → linked record; user-added items; no "met" verdict | Demo journey test | M | verified | requirement `linked`, evidence `synthetic` |
| W8-13 | PDF-01 | Cursor | W8-12 | `pdf/packet_pdf.dart` | One-page US Letter summary, ≥ 10 pt, tables, appendix overflow | PDF tests | L | verified | `covernote_packet_pdf_test.dart` 9 tests |
| W8-14 | PDF-02 | Cursor | W8-13 | `pdf/packet_pdf.dart` | Review request draft, DRAFT - FOR REVIEW, blanks for clinician | PDF tests | M | verified | includes `review_request_draft`; none for final denial |
| W8-15 | PDF-02 | Cursor | W8-13 | `packet_step.dart`, `supabase_case_store.dart` | Preview, share, save; Shared ≠ submitted; "I sent it" with date + method | Device run | M | blocked (device) | code: `packet_step.dart:198-235` |
| W8-16 | ENV-01 | Cursor | — | `local_context_screen.dart`, `domain/record_snapshot.dart` | Manual values with source/date/kind; self-reports apart; no forecast/current weather on past days | Snapshot tests | M | verified (unit) | `covernote_snapshot_test.dart` 8 tests |
| W8-17 | DEMO-01 | Cursor | W8-12 | `data/demo_case_store.dart`, `tool/demo_accounts.mjs` | Public demo; A/B accounts; idempotent seed/reset (51/3/6 of 60, PRN 8/16, 22 of 30 days) | Status + tests | M | verified | `status A`; snapshot tests |
| W8-18 | DATA-01 | Cursor | W8-07 | `supabase/migrations/20261021120000_s8_covernote_mvp1.sql` | Additive schema, RLS, private storage | Isolation run | M | verified | migration applied; isolation 19/19 blocked |
| W8-19 | AUTH-01 | Cursor | W8-18 | `supabase/functions/delete-account`, `account_tab.dart` | Delete account + files | Probe | S | verified | `delete_account_probe.mjs` 7/7 |
| W8-20 | UX-02 | Cursor | — | `lib/l10n/app_en.arb`, `app_ko.arb`, `l10n.yaml` | English and Korean first; then the New Jersey language set (see `languages.md`) | gen-l10n + per-language widget tests | S | verified (widget) | `widget_test.dart`, `languages_render_test.dart` |
| W8-21 | UX-04 | Cursor | W8-05 | presentation files | 360 dp, 200 % text, 48 dp targets, labels | Widget tests at 200 % | M | verified (widget) / blocked (device) | `widget_test.dart` 200 % en + ko |
| W8-22 | AT19 | Cursor | W8-04…W8-21 | `scripts/build_release.ps1` | Release APK | Build succeeds | S | verified (build) | `app-release.apk` 66.8 MB |
| W8-23 | AT19 | User | W8-22, W8-08 | phone | Install, camera, live AI, PDF share, restart | Device log + screenshots | M | blocked | no device connected |
| W8-24 | §8 timing | Cursor | W8-08 | `tool/analyze_probe.mjs` | 10 runs of 1–3 page letters, time and failures | Recorded times | S | blocked | needs W8-08 |
| W8-25 | EXEC-04 | Cursor | all | `docs/sprint8/*` | Audit, traceability, verification, defects, handoff | Docs match evidence | S | verified | this folder |
