# Supabase migrations

| Migration | Purpose | Status |
| --- | --- | --- |
| [`20260725200000_init_schema.sql`](../supabase/migrations/20260725200000_init_schema.sql) | Initial tables, indexes, `v_point_balances`, RLS enabled | Applied remotely (2026-07-25) |
| [`20260725210000_rls_policies.sql`](../supabase/migrations/20260725210000_rls_policies.sql) | RLS policies + `is_active_provider_of` | Applied remotely (2026-07-25) |
| [`20260725230000_auth_security_hardening.sql`](../supabase/migrations/20260725230000_auth_security_hardening.sql) | Auth hardening: immutable role, SELECT-only care links/invites, atomic pairing RPCs | Applied remotely (2026-07-25) |

Schema: [`db-schema.md`](./db-schema.md).  
RLS detail: [`rls-policies.md`](./rls-policies.md).

## Apply (linked project)

```powershell
cd "C:\work\Howse Asthma"
supabase db push
```

Enter the database password at the CLI prompt when asked.
