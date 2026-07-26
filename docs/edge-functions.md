# Edge Functions

| Function | Path | Status |
| --- | --- | --- |
| `calculate-environment-risk` | [`supabase/functions/calculate-environment-risk/`](../supabase/functions/calculate-environment-risk/) | Live sources + Geohash cache |
| `issue-invite-code` | [`supabase/functions/issue-invite-code/`](../supabase/functions/issue-invite-code/) | Deployed — provider invite (TTL 24h) |
| `redeem-invite-code` | [`supabase/functions/redeem-invite-code/`](../supabase/functions/redeem-invite-code/) | Deployed — atomic redeem RPC |
| `confirm-care-link` | [`supabase/functions/confirm-care-link/`](../supabase/functions/confirm-care-link/) | Deployed — dual confirm RPC |

Project: `jnzdovjjahvtxbhacjuv`  
Dashboard: https://supabase.com/dashboard/project/jnzdovjjahvtxbhacjuv/functions

Shared helpers: [`supabase/functions/_shared/`](../supabase/functions/_shared/).

Auth pairing: [`auth.md`](./auth.md).

## calculate-environment-risk

`POST https://jnzdovjjahvtxbhacjuv.supabase.co/functions/v1/calculate-environment-risk`

Headers: `Authorization: Bearer <user JWT>` (anon key alone → `401`), `apikey: <anon key>`, `Content-Type: application/json`

```json
{ "latitude": 40.7357, "longitude": -74.1724 }
```

Coordinates must be inside the US service area (contiguous 48 + AK/HI + major US territories). Outside → `400 out_of_service_area`. Client `patient_id` is ignored.

### Abuse / resilience controls

| Control | Behavior |
| --- | --- |
| Auth | `requireUser()` — signed-in user required |
| Service area | US (CONUS + AK/HI + PR/VI/GU/MP/AS) — US App Store scope |
| Rate limit (cold path) | 30 calls / 15 min / user; max 20 unique geohashes / window |
| Circuit breaker | On `429` / `403` / policy block → skip source 15 min (`env_api_circuits`) |
| Soft stale cache | Expired rows up to 6h when rate-limited or paid APIs blocked |
| Error codes | Stable codes only (`http_429`, `circuit_open`, …) — no URLs / env names / raw `e.message` |
| Cache RLS | `environment_forecasts` not client-readable; Edge/`service_role` only |

Rate-limit responses: `429` with `rate_limited` or `geohash_budget` (or soft-stale snapshot when available). Degraded live responses set `"degraded": true`.

### Sources (parallel via `Promise.allSettled`)

| Source | Role |
| --- | --- |
| NWS Active Alerts | Flash flood → risk 4 |
| EPA AirNow | Primary AQI |
| Open-Meteo AQ | NJ pollutants / `us_aqi` only (**no pollen**) — AQI fallback |
| PurpleAir | TRAP PM2.5 proxy + AQI fallback |
| Google Pollen | PAT-08 UPI (skipped if pollen cached &lt; 6h) |
| USGS IV | Nearby stage rise ft/hr (bbox only; no statewide fallback) |
| NJDOT AADT | Static freight weight (`si_lat`/`si_lon` bbox) — **NJ coverage only**; clients must show an NJ-only notice when not applied |

AQI fallback chain: **AirNow → Open-Meteo `us_aqi` → PurpleAir approx**.

### Cache (`environment_forecasts`)

| Key | Geohash precision 5 |
| --- | --- |
| Default TTL | 60 minutes |
| Flash-flood TTL | 5 minutes |
| Pollen reuse | 360 minutes (skip Google call when recent `pollen_upi` exists) |
| Soft stale | 360 minutes after expiry (blocked / rate-limited paths) |

Warm (cache hit) responses include `"from_cache": true`. Soft-stale adds `"from_stale_cache": true`.

### Latency smoke (2026-07-26, Newark NJ sample)

| Call | Wall time | Notes |
| --- | --- | --- |
| Cold miss | ~5–7s | Parallel live APIs (all sources `ok` on NJ sample) |
| Warm hit | ~0.45s | Within 1.2s target |

```powershell
supabase db push
supabase functions deploy calculate-environment-risk
```

## Secrets

Required for environment risk: `AIRNOW_API_KEY`, `PURPLEAIR_READ_KEY`, `GOOGLE_MAPS_API_KEY`, `NWS_USER_AGENT_CONTACT`  
(plus platform `SUPABASE_URL` / `SUPABASE_SERVICE_ROLE_KEY`).

Example template: [`scripts/set-edge-secrets.example.ps1`](../scripts/set-edge-secrets.example.ps1).

## Related

- [`db-schema.md`](./db-schema.md) §4 (server-only writes)
- [`auth.md`](./auth.md)
