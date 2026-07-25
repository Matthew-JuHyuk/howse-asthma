# Edge Functions

| Function | Path | Status |
| --- | --- | --- |
| `calculate-environment-risk` | [`supabase/functions/calculate-environment-risk/`](../supabase/functions/calculate-environment-risk/) | **Deployed** (WBS 1.6–1.7) — skeleton stubs + aggregation; live APIs in Phase 3 |

Project: `jnzdovjjahvtxbhacjuv`  
Dashboard: https://supabase.com/dashboard/project/jnzdovjjahvtxbhacjuv/functions

Shared helpers: [`supabase/functions/_shared/`](../supabase/functions/_shared/).

## Request / response (skeleton)

`POST https://jnzdovjjahvtxbhacjuv.supabase.co/functions/v1/calculate-environment-risk`

Headers: `Authorization: Bearer <anon or user JWT>`, `apikey: <anon key>`, `Content-Type: application/json`

```json
{ "latitude": 40.7357, "longitude": -74.1724 }
```

Returns `EnvironmentSnapshot` fields (`risk_score`, `ui_state`, `triggers`, …) plus
`"skeleton": true` until Phase 3 wires real sources and `environment_forecasts` cache.

## Secrets (WBS 1.7 — done)

Registered via gitignored `scripts/set-edge-secrets.ps1` (8 secrets listed with digests).  
Template without secrets: `scripts/set-edge-secrets.example.ps1`.

Re-deploy after code changes:

```powershell
supabase functions deploy calculate-environment-risk
```

## Spec references

- `doc/env-api-integration.md` §4.2
- `.cursor/rules/env-api-config.json`
- [`db-schema.md`](./db-schema.md) §4 (server-only writes)
