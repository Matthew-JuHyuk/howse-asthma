# Verification log

Run date: 2026-10-20 (America/New_York). Machine: Windows 10, Flutter 3.44.7, Dart 3.12.2.
Server: Supabase `jnzdovjjahvtxbhacjuv`; `analyze-letter` v2, `delete-account` v1; migrations through `20261021200000`.
Status words: `pass` (run and met), `fail`, `blocked` (outside setting or device missing), `not_run`.
"Widget" means a Flutter widget test on this PC. **Nothing in this file was run on a phone.**

## Acceptance tests (spec §8)

| ID | Test | Status | What was run / what is missing |
| --- | --- | --- | --- |
| AT01 | New install / home | pass (widget) · blocked (device) | Home shows Scan, Upload, Try demo and the sign-in line with no setup. Device install not run |
| AT02 | Sign-up → sign-in → save → restart | pass (server) · blocked (device) | Real sign-up, profile insert, case insert and file upload through RLS by the account scripts. App restart and session restore not run |
| AT03 | Password reset → app; sign-out | blocked | Redirect allow list unconfirmed; reset mail delivery not set up |
| AT04 | Paper letter photographed | blocked | `analyze-letter` returns `503 ai_not_configured` |
| AT05 | Photo, text PDF, scanned PDF; page order | blocked | same |
| AT06 | Changed name / medicine / dates | blocked | same. The server never sees file names or fixture ids; answers stay in the PC-side probe |
| AT07 | No received date / conflict / blur | pass (rules) · blocked (live) | Deadline unit tests: relative date waits for the received date, conflicts and business days are never picked. Live extraction blocked |
| AT08 | EOB / final denial / info request | pass (packet) · blocked (live) | Final denial produces no review draft (PDF test). Live classification blocked |
| AT09 | Case with no records | pass | PDF test: no record rows, no local context, summary still one page |
| AT10 | Scheduled, PRN and missing mixed | pass | `51 taken / 3 not taken / 6 unknown of 60`; PRN `8 uses / 16 puffs`; unknown not counted as missed |
| AT11 | Edit after PDF | pass (demo store) · not_run (server) | Packet goes stale after a fact edit; a build started before the edit is saved as stale; new build is ready |
| AT12 | Airplane mode / permission denied / AI 429 | blocked | 429 maps to retryable `ai_rate_limited` in code; not exercised |
| AT13 | A reads B's case/file/job | pass | 19 of 19 cross-account attempts blocked (below) |
| AT14 | Prompt injection in a letter | pass (code) · blocked (live) | No tools are declared; letter text is wrapped as data; quotes must exist in page text. Live run blocked |
| AT15 | Long text, 200 % font | pass (widget, PDF) · blocked (device) | 360 dp at 200 %: Home → demo → Review in all nine languages (English, Spanish, Portuguese, Korean, Gujarati, Chinese Simplified and Traditional, Haitian Creole, Arabic), no overflow. Long reasons + 10 extra items → summary stays one page, appendix added, min font 10 pt |
| AT16 | Save / share / cancel | blocked | OS share sheet needs a device. Share writes `last_exported_at` only |
| AT17 | Delete during analysis / double tap | blocked | Lease + idempotency key in code; needs a live job |
| AT18 | Demo seed / reset | pass | `status A` after seed; reset touches demo-tagged rows of the demo account only |
| AT19 | Release build on a real Android phone | blocked | APK built (below); no device connected |
| AT20 | Brand / leftovers | pass (files) · blocked (launcher) | Label, header, PDF title and file name say CoverNote; dead flags removed. Launcher look not checked on a phone |
| — | Account deletion | pass | 7 of 7 checks |
| — | AI timing, 10 runs | blocked | needs AI secrets |

## Command output

### Automated tests

```
flutter analyze                       -> No issues found!
flutter test (at 06f4110)             -> 82 passed, 0 failed
node tool/test_validate.mjs           -> tests 12, pass 12, fail 0
```

The 82 include 5 added in this pass: no-record packet, records-table counts, stale packet after an edit,
and 360 dp / 200 % text runs in English and Korean.

### Account and data checks (real server)

```
node tool/demo_accounts.mjs isolation
  select case / case_facts / document_pages / case_documents / case_requirements /
  processing_jobs / generated_artifacts / case_evidence   -> BLOCKED (0 rows)
  update case, delete case                                 -> BLOCKED (A's case unchanged)
  insert requirement (owner B / owner A), insert facts     -> BLOCKED (HTTP 403)
  download, signed URL, upload into A folder               -> BLOCKED (HTTP 400)
  delete A file                                            -> BLOCKED (A still reads it)
  start analysis on A case                                 -> BLOCKED (404 case_not_found)
  {"isolation_checks":19,"exposed":0}

node tool/demo_accounts.mjs status A
  {"appeal_cases":3,"occasion_checks":54,"symptom_entries":12,"local_context_entries":24,"inhaler_events_active":8}

node tool/delete_account_probe.mjs
  PASS throwaway case created / file stored / refuses without confirmation /
  delete-account succeeded (storage objects removed: 1) / stored file removed /
  sign-in fails after deletion (HTTP 400) / old token reads no case rows
  {"checks":7,"failed":0}
```

`occasion_checks` 54 = 51 taken + 3 not taken; the 6 unknown occasions have no row by design.
`local_context_entries` 24 = 22 days with a PM2.5 value + 2 "damp or musty" self-reports.

### Live analysis

```
node tool/analyze_probe.mjs health
  {"status":200,"ai_configured":false,"provider":null,"model":null,"missing":"AI_PROVIDER","prompt_version":"s8-letter-2026-10-21.1"}
node tool/analyze_probe.mjs run test/fixtures/letters/printable_test_letters.pdf
  {"start_status":503,"start":"ai_not_configured"}
  {"cleanup_case_status":204}
```

### Release build

```
powershell -ExecutionPolicy Bypass -File scripts/build_release.ps1
  wrote .env.client with keys: SUPABASE_URL, SUPABASE_ANON_KEY, DESIGN_PREVIEW, DEBUG_API_CONSOLE
  Built build\app\outputs\flutter-apk\app-release.apk (66.8MB)   [Gradle 173.8 s, cached]
  commit 06f4110
  SHA-256 A378E959B47E272C11F91895579141C54D0FCF29BCA7C0FEB82347D4D00DE902
```

Version `1.0.0+1`, application id `com.howseasthma.app`, signed with the debug key.
Built from `06f4110`, which contains all app code on the branch; later commits only change docs.

### Languages (2026-10-21)

See [`languages.md`](./languages.md).

```
flutter analyze                       -> No issues found!
flutter test                          -> 123 passed, 0 failed
node tool/l10n_validate.mjs check <tag> for es pt zh_Hans zh_Hant gu ht ar
                                      -> 657 keys each, problems 0
supabase db push                      -> 20261021200000_s8_profile_languages.sql applied
profiles.language_code on the server  -> en es pt ko gu zh-Hans zh-Hant ht ar accepted; "xx-bad" rejected (23514); original value restored
```

The tests cover: language resolution (device, saved, Chinese script/region), every language loading
strings, plurals (0, 1, 2, 3, 11, 100; Arabic's six forms) and dates, right-to-left for Arabic only,
the picker (all names in their own script, switching to Arabic flips direction, 200 % text),
translated reason explanations on the review screen, and requirement hints.
Release APK rebuilt from `6ed45bc`: 68.4 MB, SHA-256
`C03EFE45C7B3282ED03FED2AF46843702ABD7893B93EC734CD39A2AAB0B5CBC2`.

Status: widget-level `pass`; **on a phone: blocked** (not run). Translation review by native speakers:
**not_run**.

## Not measured

- First-time-user test (5 people, find Scan in 5 s, finish the sample in 3 min): not run.
- Extraction accuracy on fixtures and variants: not run (AI blocked).
