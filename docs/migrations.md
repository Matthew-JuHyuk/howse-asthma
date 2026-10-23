# Supabase migrations

| Migration | Purpose | Status |
| --- | --- | --- |
| [`20260725200000_init_schema.sql`](../supabase/migrations/20260725200000_init_schema.sql) | Initial tables, indexes, `v_point_balances`, RLS enabled | Applied remotely (2026-07-25) |
| [`20260725210000_rls_policies.sql`](../supabase/migrations/20260725210000_rls_policies.sql) | RLS policies + `is_active_provider_of` | Applied remotely (2026-07-25) |
| [`20260725230000_auth_security_hardening.sql`](../supabase/migrations/20260725230000_auth_security_hardening.sql) | Auth hardening: immutable role, SELECT-only care links/invites, atomic pairing RPCs | Applied remotely (2026-07-25) |
| [`20261011180000_s6_regimen_and_evidence.sql`](../supabase/migrations/20261011180000_s6_regimen_and_evidence.sql) | Prescription versions, occasion checks, event snapshots, empty policy slots | In the repo. Apply with `supabase db push` before the app build that queries these tables |
| [`20261018120000_v2_appeal_cases.sql`](../supabase/migrations/20261018120000_v2_appeal_cases.sql) | Appeal-prep cases, facts, jobs, private `appeal-documents` bucket | Applied remotely |
| [`20261021120000_s8_covernote_mvp1.sql`](../supabase/migrations/20261021120000_s8_covernote_mvp1.sql) | CoverNote: document kind, upload sets, job metadata, `case_requirements`, `local_context_entries`, tighter evidence/artifact policies. Additive | Applied remotely (2026-10-21). See [`db-schema.md`](./db-schema.md) §2.z2 |
| [`20261021200000_s8_profile_languages.sql`](../supabase/migrations/20261021200000_s8_profile_languages.sql) | Widens the `profiles.language_code` CHECK to `en es pt ko gu zh-Hans zh-Hant ht ar` (keeps `fr ja zh`). Additive | Applied remotely (2026-10-21). See [`sprint8/languages.md`](./sprint8/languages.md) |
| [`20261022090000_s9_covernote.sql`](../supabase/migrations/20261022090000_s9_covernote.sql) | Sprint 9: ordinals, lifecycle, delivery, translations, medication_use_events, environment snapshots. Additive | Applied remotely (2026-10-21). See [`sprint9/setup_runbook.md`](./sprint9/setup_runbook.md) |
| [`20261022233000_s9_ordinal_counter_rls.sql`](../supabase/migrations/20261022233000_s9_ordinal_counter_rls.sql) | `next_case_ordinal` runs as definer so letter upload can assign a case number. Counter table stays closed to clients | Applied remotely (2026-10-21) |
| [`20261023090000_s10_preparation.sql`](../supabase/migrations/20261023090000_s10_preparation.sql) | Sprint 10: `case_start_reason`, `case_preparations`, `treatment_events`, subject/owner RLS, and atomic create/save/batch/undo RPCs. Additive | Applied remotely (verified 2026-10-23; local = remote) |

Schema: [`db-schema.md`](./db-schema.md).

RLS detail: [`rls-policies.md`](./rls-policies.md).

## Apply (linked project)

```powershell
cd "C:\work\Howse Asthma"
supabase db push
```

Enter the database password at the CLI prompt when asked.
