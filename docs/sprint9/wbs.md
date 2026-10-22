# Sprint 9 WBS

States: `todo` / `doing` / `blocked` / `verified`. Evidence is a test name,
command, or device note. Planning-only rows are not `verified`.

| task_id | req | Change | Depends | DB/API/UI | Verify | State | Evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| W9-00 | — | Audit + this WBS + R06 report | — | docs | Review | verified | `docs/sprint9/audit.md` |
| W9-01 | R01 | Shared chrome + language on every app-owned screen; no MaterialApp key | W9-00 | UI | Locale round-trip keeps tab/case/draft | doing | |
| W9-02 | R02 | SafeArea + viewInsets on shell, sheets, forms | W9-01 | UI | Last CTA reachable; no magic nav heights | doing | |
| W9-03 | R03 | Case opens in Cases tab; one-tap list/home; steps stay on one screen | W9-01 | UI | Back stack does not accumulate steps | doing | |
| W9-04 | R04 | Fixed ordinal, title `drug · kind`, added-at, insurer, alias | W9-00 | DB+UI | Numbers stable after delete/sort | doing | |
| W9-05 | R06 R09 R10 R12 R16 | Unified records + include today + query states + calendar | W9-00 | DB+UI | Today 1 event on case + PDF | doing | |
| W9-06 | R07 | My medications vs daily log; label OCR via server | W9-05 | API+UI | Empty directions stay empty | doing | |
| W9-07 | R08 | Restore env fetch; async attach; air/weather screen | W9-05 | API+UI | Save works when env fails; past ≠ now | doing | |
| W9-08 | R11 | Consent ≠ service flag; first-analyze gate; Settings toggle | W9-00 | DB+UI | Existing consent kept; no silent send | doing | |
| W9-09 | R13 | Original file tab + full translation cache | W9-08 | API+UI | OCR not shown as the original | doing | |
| W9-10 | R14 | Key details 3 cards; correction overflow | W9-03 | UI | Progress without confirming every field | doing | |
| W9-11 | R05 R15 R17 R18 | share_plus; delivery log; done screen; lifecycle lists | W9-04 | DB+UI | Cancel ≠ sent; sent ≠ complete | doing | |
| W9-12 | — | Tests, migration apply, release APK, device run | all | — | Checklist | todo | |
