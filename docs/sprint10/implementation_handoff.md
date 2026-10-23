# Sprint10 implementation handoff

Baseline: `main` at `cdb7a5e`. Scope: implementation and checks. No filming, publication, submission, commit, push or merge was performed here.

## Implemented

- Home has initial treatment preparation and denial-letter entry. No notice or minimum logging period is required for a new request. An unknown proposed drug produces a consultation brief. Policy references require explicit applicability confirmation; no eligibility score or prescription decision is generated.
- The workspace has overview, evidence, timeline and sharing. Requirements retain notice/policy/care-team provenance, source pages/quotes, responsible party and user-selected record IDs. A later denial changes the same case while retaining history/exports. Pending information, renewal and EOBs do not automatically become denials. Review and information-response deadlines remain distinct.
- Account records and care profiles use separate patient keys. Profiles can be reused across cases; IDs are not inferred from names. Account-profile events are mirrored atomically into Sprint9 tables; child-profile events stay separate. Treatment Records provides a subject-specific view.
- Manual buttons coexist with Android speech recognition, editable transcript, actual server model proposals, exact quote validation, field correction and confirmation. One utterance shares one source ID and one transaction. Negated use creates no medication-use event; unknown medicine/dose is preserved. New speech is not matched to canned demo answers.
- An opt-in Android notification action saves locally without opening an activity, requires unlock, rejects stale/repeated actions, supports undo, and syncs by account on resume. Sign-out disables the action. It is a direct action, not an automatic daily reminder scheduler.
- Clinical files are owner-private originals, separate from app reports. Patient/date/page/quote are reviewed before evidence is recorded. Shared patient documents survive case deletion; nested case exports/cache are removed. Account deletion removes owner storage and local Sprint10 data.
- Both English briefs use the same source events and summary calculations. Non-English preparation fields use a confirmed translation. Source-content hashes identify stale exports. Actual originals can be included as rendered pages. Every synthetic page is labeled. Sharing never implies receipt or insurance submission.

## Backend prerequisites — deployment update

2026-10-22: applied `20261023090000_s10_preparation.sql` and deployed `analyze-letter` to linked Supabase project `jnzdovjjahvtxbhacjuv`. The historical prerequisites below are now deployed. Dedicated live-login synthetic demo data and recording instructions are in `demo_recording_scenario.md`; credentials are only in git-ignored `.env.demo`.

1. Apply `supabase/migrations/20261023090000_s10_preparation.sql` after both Sprint9 migrations.
2. Redeploy `analyze-letter` including `preparation.ts` and `preparation_validate.ts`.
3. Existing provider credentials remain Edge secrets; no new secret name is required.
4. Verify RLS, rollback, idempotency and old-schema adapters on the target backend.

The additive migration uses caller permissions and RLS, atomic creation, optimistic metadata revision checks, atomic source-event batches and undo. Offline batches/undo are persisted per account before sync. Sprint9 lists retain their old-schema fallback; Sprint10 actions require the new migration.

## Evidence and limits

See [verification.md](verification.md). Test logs/QA PDFs: `build/sprint10/`. The latest source release APK is now built at `build/app/outputs/flutter-apk/app-release.apk` and copied to `build/sprint10/covernote-sprint10-demo.apk`. See [APK build details](apk_build_ko.md). The separate analysis/test rerun request was declined; the APK build was authorized and succeeded.

`adb devices` found no connected phone. Actual ASR/model accuracy, notification/lock/background behavior, real file analysis, live environment provenance, share-sheet behavior and backend transactions/RLS remain runtime gates. New workspace strings have EN/KO/ES drafts; other supported locales fall back to English for these strings and need native review. No clinical or usability outcome is inferred from unit tests.

The policy binary is a sync gap documented in [SYNC_STATUS.md](SYNC_STATUS.md). Research conclusions were imported, not independently re-certified here.
