# Documentation

English documentation for the Howse Asthma repository.

| Path | Contents |
| --- | --- |
| [`docs/`](./) | Schema, migrations, RLS, Edge Functions |
| [`supabase/`](../supabase/) | Migrations, config, Edge Functions |

## Convention

When you add or change something under `supabase/` (migrations, RLS SQL, Edge Function contracts), update the matching document here in the same change set.

| Change | Document |
| --- | --- |
| Tables / views / indexes | [`db-schema.md`](./db-schema.md) |
| RLS policies | [`db-schema.md`](./db-schema.md) §3, [`rls-policies.md`](./rls-policies.md) |
| Edge Function I/O and secrets boundary | [`db-schema.md`](./db-schema.md) §4, [`edge-functions.md`](./edge-functions.md) |

## Contents

| File | Description |
| --- | --- |
| [`db-schema.md`](./db-schema.md) | Supabase PostgreSQL physical schema |
| [`migrations.md`](./migrations.md) | Migration index and apply notes |
| [`rls-policies.md`](./rls-policies.md) | RLS policy summary |
| [`edge-functions.md`](./edge-functions.md) | Edge Function overview |
| [`auth.md`](./auth.md) | Auth, OAuth setup, biometric unlock, care-link pairing |
| [`phase6-test-plan.md`](./phase6-test-plan.md) | Phase 6 device test plan (summary; full Korean in `doc/`) |
| [`debug-mode-design.md`](./debug-mode-design.md) | Debug API Console design (summary; full Korean in `doc/`) |
| [`fcm-setup.md`](./fcm-setup.md) | Firebase / FCM client + Edge secret setup (WBS 4.6a) |
| [`sprint2-test-review-backlog.md`](./sprint2-test-review-backlog.md) | Sprint 2 on-device test review backlog |
| [`sprint8/handoff.md`](./sprint8/handoff.md) | **CoverNote MVP1** — current state, deliverables and owner actions |
| [`sprint10/implementation_handoff.md`](./sprint10/implementation_handoff.md) | Sprint10 implementation and backend/runtime prerequisites |
| [`sprint10/SYNC_STATUS.md`](./sprint10/SYNC_STATUS.md) | ChatGPT v1.5 planning artifact provenance and missing binary |
| [`sprint8/audit.md`](./sprint8/audit.md) | Starting point and keep/remove decisions |
| [`sprint8/wbs.md`](./sprint8/wbs.md) | Work breakdown with status and evidence |
| [`sprint8/requirements_traceability.md`](./sprint8/requirements_traceability.md) | P0 requirement → code → result |
| [`sprint8/verification.md`](./sprint8/verification.md) | Acceptance tests and command output |
| [`sprint8/defects.md`](./sprint8/defects.md) | Defects with cause, fix commit and re-check |
| [`sprint8/auth_diagnosis.md`](./sprint8/auth_diagnosis.md) | Sign-in failure diagnosis |
| [`sprint8/setup_runbook.md`](./sprint8/setup_runbook.md) | Secrets, auth settings, accounts, build and install |
| [`sprint8/demo_script.md`](./sprint8/demo_script.md) | Sample and live demo steps |
| [`sprint8/ai_usage.md`](./sprint8/ai_usage.md) | AI use in building and inside the app |
| [`v2/repository_audit.md`](./v2/repository_audit.md) | v2.0 pivot audit (superseded by `sprint8/`) |
| [`v2/wbs.md`](./v2/wbs.md) | v2.0 work breakdown and checkpoint (superseded) |
| [`v2/decisions.md`](./v2/decisions.md) | v2.0 decisions; the preview flags and Settings switch were removed in Sprint 8 |
| [`v2/traceability.md`](./v2/traceability.md) | v2.0 requirement and test map (superseded) |
| [`v2/demo.md`](./v2/demo.md) | v2.0 sample walkthrough and flags (superseded by `sprint8/demo_script.md`) |
