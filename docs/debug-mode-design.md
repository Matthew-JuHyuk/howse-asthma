# Debug API Console — Design (Phase 6)

> Full design (Korean): [`doc/qa/debug-mode-design.md`](../doc/qa/debug-mode-design.md)

## Purpose

On a physical device, inspect **every Supabase Edge invoke**: request/response JSON, numeric metrics, and latency — without shipping this to store builds.

**Status (2026-07-26):** Client v1 implemented (WBS **6.0d**). Optional Edge `debug_meta` is not in v1.

## Triple gate

1. **Not release** (`!kReleaseMode`)
2. **`.env`**: `DEBUG_API_CONSOLE=true` (default `false` in `.env.example`)
3. **UI entry**: Settings → Developer → API Console (or 5-tap Home title)

Release + flag → hard fail at startup (same pattern as `DESIGN_PREVIEW`).

## Architecture (summary)

- `DebugFunctionsClient.invoke` wraps all Edge calls used by env/risk, inhaler log, invite trio
- `ApiTraceStore` in-memory ring buffer (N≈100)
- `DebugRedactor` strips Authorization, API keys, long secrets; optional lat/lon rounding
- UI `SCR-SYS-DEBUG`: filterable list + detail with metric chips + Copy JSON
- Optional later: Edge `debug_meta` (per-source ms) only if secret `ALLOW_CLIENT_DEBUG` + allowlist

## QA build

```powershell
# .env
DEBUG_API_CONSOLE=true
# then debug/profile only:
flutter run
```

## Security

- No JWT / service_role / env secrets on screen or disk by default
- Memory-only traces unless user exports
- Separate from `DESIGN_PREVIEW`
