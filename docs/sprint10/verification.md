# Sprint10 verification

Date: 2026-10-22 America/New_York. **Source implemented; final rebuild not run because the execution request was declined.**

| Check | Actual result |
| --- | --- |
| Full Flutter regression | **145 passed**; `build/sprint10/all-tests.log` |
| Node extraction / proposal validation | **17 passed**; `build/sprint10/node-tests.log` |
| TypeScript syntax | Node `--check` passed for both modified entrypoints |
| Static analysis | Last run: no errors, one Home-panel braces style info. Fixed manually; not rerun |
| Source whitespace | `git diff --check` passed |
| PDF visual QA | Both synthetic types rendered with Poppler; all three pages each inspected. One-page brief, source appendix, complete source groups and synthetic footer verified |
| Android build | Latest source release APK built successfully (70.5 MB), `build/sprint10/covernote-sprint10-demo.apk`; details in `apk_build_ko.md` |
| Final analysis / test rerun | Permission request declined; APK build separately authorized and completed |
| Device | `adb devices`: no connected phone |

The final paginated history query and manual style correction postdate the 145-test run. They compile in the latest APK but the regression rerun and installed-device checks remain. No `SPRINT10 DEMO VERIFIED` claim is made.

2026-10-22 follow-up: deployed the Sprint 10 migration and `analyze-letter` to linked project `jnzdovjjahvtxbhacjuv`. Server validation tests: 17 passed. Dedicated Rosa demo account password login, two preparation cases, 55 synthetic records and expected 30-day counts were verified. Three original source PDFs were uploaded; the fourth is reserved for live upload. AI consent gate returned HTTP 403 `consent_required`; no consent was fabricated. See `demo_recording_scenario.md` and `build/sprint10/demo-verification.json`.

Runtime gates remain: comprehensive owner/subject RLS mutation tests; transaction rollback/idempotency; ES/EN/KR live ASR/model phrases; permission denial/offline/account switch/lock/notification/undo; unrecognized test document and original appendix; live environment freshness/area/missing sources; installed APK journeys and OS sharing.

No real participant, clinical result, insurance approval or submission has been reported as verified.
