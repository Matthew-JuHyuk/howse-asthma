# v2.0 traceability

Automated rows were run with `flutter test test/appeal_flow_test.dart`.
Rows marked not run were not executed on a device or against a remote database.

| ID | Requirement | Where | Result |
| --- | --- | --- | --- |
| UX-01 | en/es/ko explanation; other locales do not rewrite tokens | `explanation_builder.dart`, ARB | Unit: tokens kept. fr/ja/zh UI strings are still English. |
| UX-02 | Add letter, sample, records link, deadline only after confirm | `appeal_home_screen.dart` | Implemented for the sample. Not device-checked. |
| UX-03 | Explain, check, records, documents | `appeal_case_screen.dart` | Implemented for the sample. |
| UX-04 | Large targets, status in text | Case and home screens | Not device-checked at large text. |
| DOC-01 | Type, size, encrypted PDF | `upload_guard.dart` | Unit: bad signature, empty, oversize, `/Encrypt`. Real picker not built. |
| DOC-02 | Block appeal draft for EOB | `appeal_letter.dart` | Unit: `not_initial_denial`. |
| DOC-03 | Quotes must occur in the page | `fact_validator.dart` | Unit: rewritten page fails. |
| DOC-04 | Edit clears confirmation | `appeal_flow.dart` | Unit: revision increases and letter clears. |
| TIME-01 | No universal deadline | `deadline_resolver.dart` | Unit: conflict, business day, missing received date, past date kept. |
| AI-01 | No live model; document text is not a command | Flags, `upload_guard.dart` | Live flag default off. Unit: no external actions. Real model not called. |
| EXP-01 | Three items, tokens preserved | `explanation_builder.dart` | Unit for en/es/ko/fr. |
| EVD-01 | Draft without records; no invented adherence | `appeal_letter.dart` | Unit. Record picker not connected. |
| EVD-02 | No catalog quotes | Letter and clinician plan | Unit: letter has no guideline section. Catalog table is empty. |
| OUT-01 | English draft, banner, prepared gate | `appeal_letter.dart` | Unit. |
| OUT-02 | One-page plan at 10pt | `clinician_page.dart` | Unit for the line budget. Rendered PDF page count not measured on a device. |
| OUT-03 | Share is not submission; filename has no person name | `appeal_pdf.dart`, store | Filename unit. Share sheet not run here. `sharedMarkedSubmitted` stays false. |
| SEC-01 | Owner RLS and private bucket | Migration `20261018120000_v2_appeal_cases.sql` | Written, not applied, not tested with two users. |
| SEC-02 | Delete sample locally | `AppealDemoStore.deleteCase` | Unit: further draft throws. Remote object delete not built. |
| NFR-01 | Limits | Not measured | No timing sample. |
| AT-01 | Clear multi-page denial | — | Not run. Sample is one page. |
| AT-02 | Blurry page | — | Not run. |
| AT-03 | Conflicting deadlines | `appeal_flow_test.dart` | Passes in unit test. |
| AT-04 | Relative deadline, no received date | same | Passes. |
| AT-05 | Business days | same | Passes. |
| AT-06 | Drug text across languages | same | Passes. |
| AT-07 | No records | same | Passes. |
| AT-08 | PRN denominator | — | Not run. No record adapter yet. |
| AT-09 | No catalog citation | same | Passes for the template. |
| AT-10 | Prompt injection | same | Passes for the action list. No network client is wired. |
| AT-11 | Other user's ids | — | Not run. SQL not applied remotely. |
| AT-12 | Duplicate job | same | Passes for the in-memory ledger. |
| AT-13 | 401 / 429 / 5xx | — | Not run. No live provider. |
| AT-14 | Edit during generation | same | Passes for the local revision rule. |
| AT-15 | Delete after URL | — | Not run. |
| AT-16 | EOB | same | Passes. |
| AT-17 | One-page PDF | planner unit | Line budget passes. Render not measured. |
| AT-18 | Large text, three languages | — | Not run on a device. |
| AT-19 | Cancel share | UI catch | Not run. |
| AT-20 | Migration and rollback | SQL file | Not applied to an empty or populated database. |
| AT-21 | Bad upload | same | Passes. |
| AT-22 | Missing member id | same | Passes. |
| AT-23 | Bad quote | same | Passes. |
| AT-24 | Past date kept | same | Passes. |

Existing login, medication, and visit-PDF code was not rewritten. Those
regressions were not re-run on a device in this change.
