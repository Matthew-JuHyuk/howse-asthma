# v2.0 work breakdown

Status after the first checkpoint on 2026-10-18. Estimates are not commitments.
P0 items that are unfinished stay listed.

| ID | Requirements | Depends on | Done in this change | Still open |
| --- | --- | --- | --- | --- |
| W00 | Audit | — | `docs/v2/repository_audit.md` | Device build log was not re-run beyond unit tests |
| W01 | Contracts, flags | W00 | Domain types, flags, decisions | Server enforcement of the flags |
| W02 | Migration, RLS, private bucket | W01 | `20261018120000_v2_appeal_cases.sql` | `supabase db push` and a second-user check |
| W03 | Home, languages, case list | W01 | Sample home behind the settings switch. en/es/ko copy | fr/ja/zh translations; persisted server cases |
| W04 | Real upload and page viewer | W02, W03 | Signature, size, and encryption checks in unit tests | Camera, file picker, reorder, server finalize |
| W05 | Jobs and analysis adapter | W04 | In-memory idempotent sample job | Live adapter, retries, lease recovery |
| W06 | Review, deadline, 3-part explanation | W05 | Sample review screen and pure functions | Received-date editor on the sample screen |
| W07 | Link existing records | W02 | Empty-record path. Draft still builds | Snapshot adapter over medication and symptom rows |
| W08 | Draft template, no fake citations | W06, W07 | English review and prepared templates | Catalog content (P1) |
| W09 | PDF and share | W08 | Letter PDF and one-page clinician PDF via the existing share sheet | On-device page-count check; temp-file cleanup proof |
| W10 | Delete, limits, logs | W02, W05, W09 | Local sample delete. SQL ownership checks | Remote deletion job, rate limits, log redaction proof |
| W11 | AT-01–AT-24 and regression | W03–W10 | Unit tests listed in `traceability.md` | UI, RLS, and device cases not run |
| W12 | Release notes | W11 | Flag and rollback notes in `demo.md` | Operator runbook after remote apply |

## First checkpoint

Sample path that is implemented:

1. Settings → Show coverage-letter home.
2. Try a sample (or Add a denial letter, which explains that live reading is off).
3. Read the three explanation items and the original sample text.
4. Confirm the facts.
5. Make a review draft.
6. Share the English draft or the clinician one-page PDF.

The sample banner stays visible. The share result is not stored as a submission.
