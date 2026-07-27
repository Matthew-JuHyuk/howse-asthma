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
