# Sprint 9 requirements → code → tests

| Req | Implementation | Test / evidence |
| --- | --- | --- |
| R01 | `CoverNoteAppBar` + `LanguageButton` on tabs, case, capture, settings | `languages_render_test` still runs. Device locale round-trip NOT RUN |
| R02 | `CoverNoteBody` / SafeArea / viewInsets; no device nav constants | Widget overflow tests exist. Device matrix NOT RUN |
| R03 | `CoverNoteNav` opens case in Cases tab; list/home one tap; steps stay on `CaseScreen` | Code review. Device NOT RUN |
| R04 | `display_ordinal` trigger + `caseDisplayTitle` / `CaseCard` | `covernote_s9_test` ordinals after delete |
| R05 | `share_plus` + `delivery_events`; cancel does not write delivery | Unit: self-keep ≠ delivery. OS sheet NOT RUN |
| R06 | `DayRange` includes today; PDC adapter; query states; `RecordsRevision` on evidence | `covernote_s9_test`, `covernote_snapshot_test`. Live 1-row E2E NOT RUN |
| R07 | `LabelScanScreen` + `read_label` action; `My medications` link | Live OCR NOT RUN |
| R08 | `EnvironmentCollector` + snapshots/links; Open-Meteo history for past days | Live API NOT RUN |
| R09 | `QuickLogPanel` + `medication_use_events` + undo | Unit log model. Device NOT RUN |
| R10 | Unified `RecordsTab` | Widget compile. Device NOT RUN |
| R11 | `ConsentRepository`; first-analyze / label / translate gates; Settings toggles | Existing Sprint 8 rows still count. Device NOT RUN |
| R12 | Week/month chips; today/7/30 presets | `DayRange` tests |
| R13 | Letter original / translation / OCR expansion; `document_translations` | Live translate NOT RUN |
| R14 | Key-details 3 cards; correction in `ExpansionTile`; `readyForEvidence` always true | Deadline test updated |
| R15 | Packet share + delivery + home/list buttons | Code. Device NOT RUN |
| R16 | Why-records copy + treatment chips | Code |
| R17 | Delivery vs artifact vs lifecycle | `caseFollowUp` test |
| R18 | Active / completed-archived lists; complete/archive/reopen | Demo ordinals + list filter |

See `record_link_root_cause.md` for R06.
