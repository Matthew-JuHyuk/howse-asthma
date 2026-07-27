# Phase 6 — Device Integration Test Plan

> Canonical Korean plan (detail + result sheet): [`doc/phase6-test-plan.md`](../doc/phase6-test-plan.md)  
> Debug console design: [`doc/debug-mode-design.md`](../doc/debug-mode-design.md) · English summary: [`debug-mode-design.md`](./debug-mode-design.md)

**Scope (WBS 6.1–6.5):** real Android USB device (no emulator). Auth → patient core → NJ env/alerts → performance notes → `flutter analyze` / `flutter test`.

## Prerequisites

- `DESIGN_PREVIEW=false`, real Supabase keys in `.env` (never commit)
- Edge functions + migrations current
- Optional QA: `DEBUG_API_CONSOLE=true` on a **debug/profile** build (never release). Entry: Settings → Developer → API Console, or 5-tap Home title. See [`debug-mode-design.md`](./debug-mode-design.md) and Korean plan §4.2.

```powershell
cd "C:\work\Howse Asthma"
flutter devices
flutter run
```

## Scenario map

| WBS | Scenario | Covers |
| --- | --- | --- |
| 6.1 | S-AUTH | Sign-up PATIENT/PROVIDER, 8-char invite, biometric, sign-out |
| 6.2 | S-PAT-CORE | Location Home risk, 1-Tap, Panic (`tel:` only), ACT/PDC, E.164 contact, alert prefs |
| 6.3 | S-ENV | ENV/FORECAST, NJ badge, saved locations (max 10), LOCATION_ENTRY, cooldown, cache warm/cold |
| 6.4 | S-PERF | APK size, UI responsiveness, qualitative battery |
| 6.5 | S-CI | `flutter analyze` / `flutter test` on PC |

## How to verify results

| Layer | What to check |
| --- | --- |
| App UI | SCR screens, snackbars, NJ badge copy |
| Debug API Console | Edge name, ms, metrics (risk/AQI/UPI/USGS), `from_cache`, notify `status` — never JWT/secrets |
| Supabase | Auth users; tables `inhaler_events`, `environment_forecasts`, `environment_alerts_sent`, `saved_locations`, invites/links; Function logs |
| adb | `adb logcat -s flutter` |

## Explicit N/A (not failures)

- OS background FCM (WBS **4.6a**)
- iOS Always location (no iOS build on Windows)
- e-Fax / donation live APIs (undecided)

## Exit criteria

See Korean doc §5. Fill the result sheet in §7 of that file and sync WBS Phase 6 checkboxes when done.

Full case IDs: `TC-AUTH-*`, `TC-PAT-*`, `TC-ENV-*`, `TC-PERF-*`, `TC-CI-01` in [`doc/phase6-test-plan.md`](../doc/phase6-test-plan.md).
