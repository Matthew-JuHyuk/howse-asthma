# Row Level Security (RLS)

| Migration | Purpose |
| --- | --- |
| [`20260725210000_rls_policies.sql`](../supabase/migrations/20260725210000_rls_policies.sql) | Policies + `is_active_provider_of()` helper |

Aligned with [`db-schema.md`](./db-schema.md) §3.

## Rules (summary)

| Area | Authenticated client |
| --- | --- |
| Own profile / patient clinical rows | Patient R/W |
| Linked patient rows | Provider **SELECT** via `patient_care_links.status = 'active'` |
| `invite_codes` | Issuing provider only (redeem via Edge/RPC) |
| `environment_forecasts`, `food_bank_vouchers` | **SELECT** for any authenticated user |
| Points / donations / alert dispatch writes | **No client INSERT** — Edge / `service_role` |
| `outbound_transmissions` | Provider may INSERT `QUEUED` only; status updates via Edge |

`service_role` bypasses RLS (Edge Functions).

## Apply

```powershell
cd "C:\work\Howse Asthma"
supabase db push
```
