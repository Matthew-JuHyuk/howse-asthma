# R06 — why today's record did not appear on a case

Status: cause confirmed in code on 2026-10-21. Fix is in this sprint.
This file is the required root-cause report. It is not itself a test pass.

## What the user saw

A record saved today (Daily log or a one-tap use) did not show on the case
“records” step, so it could not be attached and did not appear in the packet.

## Reproduction from code (no phone required)

1. Daily log uses `RecordRange.lastDays`, whose end is **today**
   (`lib/features/records/domain/record_summary.dart`).
2. Evidence and the Records tab use `DayRange.lastDays`, whose end is
   **yesterday**:

```8:11:lib/features/covernote/domain/record_snapshot.dart
  factory DayRange.lastDays(DateTime today, int days) {
    final end = DateTime(today.year, today.month, today.day - 1);
    return DayRange(DateTime(end.year, end.month, end.day - (days - 1)), end);
  }
```

3. The unit test locked that in (`test/covernote_snapshot_test.dart`:
   “30 full days before today”). Demo seed (`tool/demo_accounts.mjs`) also
   ends yesterday.
4. Even if the window included today, a Daily-log **med check** writes
   `pdc_daily_checks`. `SupabaseCaseStore.loadSnapshots` never reads that
   table. It only counts `medication_occasion_checks` (notification answers)
   and `inhaler_events`.
5. Attach writes a period **summary** into `case_evidence.snapshot_json`.
   `original_record_id` exists in SQL and is never set, so “this one event”
   cannot be pointed at.

## Ranked causes

| Id | Cause | Enough to hide today's row? | Fix |
| --- | --- | --- | --- |
| R06-A | Window ends yesterday | Yes | `DayRange.lastDays` includes today; presets today / 7 / 30 / custom |
| R06-B | PDC daily check ≠ occasion check | Yes, for med-check logging | Adapter: snapshots and the unified list also read `pdc_daily_checks` and new `medication_use_events` |
| R06-C | Attach is a summary, not an event id | Yes, for “this 1 row” | `case_evidence.source_event_ids` + per-event selection |
| R06-D | Demo store `today` is fixed and synthetic | Only on Try demo | Demo stays synthetic; live path uses device-local today |
| R06-E | Evidence loads once in `initState` | Can hide a just-saved row | Reload on range change and `RecordsRevision` |
| R06-F | Symptom `listBetween` filters `recorded_at` not `occurred_at` | Edge case near midnight | Pad query then filter `local_date` / `eventDate` |
| R06-G | RLS / user id mismatch | Unlikely (`patient_id` = `auth.uid()`) | Keep owner checks; surface `permission_error` instead of empty |

UTC vs local is **not** the primary bug. Inhaler/symptom queries already pad
UTC and then filter the local calendar date. The caller range simply did not
contain today.

Query failures were shown as a generic empty or a single `_failed` flag.
Sprint 9 splits: `loading` / `available` / `genuinely_empty` / `filtered_out`
/ `sync_pending` / `fetch_error` / `permission_error`.

## What was not done

No existing dose or symptom row was deleted because it “looked like a
duplicate.” Old PDC, occasion, and inhaler rows remain and are adapted.
