# Row Level Security (RLS)

| Migration | Purpose |
| --- | --- |
| [`20260725210000_rls_policies.sql`](../supabase/migrations/20260725210000_rls_policies.sql) | Policies + `is_active_provider_of()` helper |
| [`20260725230000_auth_security_hardening.sql`](../supabase/migrations/20260725230000_auth_security_hardening.sql) | Immutable `profiles.role`; care-link/invite client writes removed; atomic pairing RPCs |
| [`20260726120000_env_risk_hardening.sql`](../supabase/migrations/20260726120000_env_risk_hardening.sql) | Drop broad `environment_forecasts` SELECT; add `env_api_circuits` / `env_risk_rate_events` (service_role) |

Aligned with [`db-schema.md`](./db-schema.md) §3.

## Rules (summary)

| Area | Authenticated client |
| --- | --- |
| Own profile | R/W except **`role` is immutable** after insert |
| Patient clinical rows | Patient R/W; `patient_details.primary_provider_id` server-managed |
| Linked patient rows | Provider **SELECT** via `patient_care_links.status = 'active'` |
| `invite_codes` | Issuer **SELECT** only — issue/consume via Edge + `service_role` |
| `patient_care_links` | Participant **SELECT** only — create/confirm via Edge RPCs |
| `environment_forecasts` | **No client access** — Edge / `service_role` cache only |
| `food_bank_vouchers` | **SELECT** for any authenticated user |
| `env_api_circuits`, `env_risk_rate_events` | **No client access** — Edge rate/circuit tables |
| Points / donations / alert dispatch writes | **No client INSERT** — Edge / `service_role` |
| `outbound_transmissions` | Provider may INSERT `QUEUED` only; status updates via Edge |

`service_role` bypasses RLS (Edge Functions). Pairing RPCs
(`redeem_invite_code_as`, `confirm_care_link_as`) are granted to `service_role` only.

## Apply

```powershell
cd "C:\work\Howse Asthma"
supabase db push
```
