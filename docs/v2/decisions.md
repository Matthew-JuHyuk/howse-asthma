# v2.0 decisions

Date: 2026-10-18.

| ID | Decision |
| --- | --- |
| D1 | Manage this pivot as Sprint 7. Sprint 6 is already the environmental-evidence work. Product version remains 2.0. |
| D2 | Keep the current app title. Do not introduce the temporary name from the requirements file. A future release should remove diagnosis wording from the exposed name; that edit is not in this change. |
| D3 | Default `V2_NAVIGATION_ENABLED`, `LIVE_DOCUMENT_PROCESSING_ENABLED`, and `VERIFIED_EVIDENCE_ENABLED` to off. The settings switch only toggles the local home preview. |
| D4 | The first walkthrough uses a labeled synthetic notice stored in memory. It is not written as a real patient row and is not described as a live reading. |
| D5 | Do not apply one appeal deadline to every plan. An explicit date is shown as the date on the document. A day count is calculated only from a received date when the unit is calendar days. Business days, conflicts, and missing received dates stay uncalculated. |
| D6 | Medication and dose strings are copied. They are not corrected, translated, or swapped for another drug. |
| D7 | The evidence catalog ships empty. Drafts do not invent guideline quotes or approval odds. |
| D8 | Sharing opens the system share sheet. That action does not create a “submitted” case state. |
| D9 | Appeal-prep tables are additive. Existing record tables are not dropped. Rollback of the UI is the feature flag, not a destructive down migration. |
| D10 | French, Japanese, and Chinese v2 strings currently repeat English until those translations are written. English, Spanish, and Korean have their own copy. |
| D11 | No appeal Edge Function is deployed. Service-role jobs are not implemented, so server-side flag enforcement is still outstanding. RLS in the new migration is the database boundary once it is applied. |

## Unresolved

| Item | Who confirms it |
| --- | --- |
| Remote migration apply | Operator with database access |
| Document-reading provider and secrets | Operator. Do not turn live mode on before that. |
| Retention for real notices | Operator, before live mode |
| Clinician-approved excerpts | A reviewer. Do not seed a fictional reviewer. |
| Final exposed product name | Product owner. Not this sprint. |
