# Sprint 9 handoff

**State: SPRINT9 NOT YET VERIFIED.**

Implementation for R01–R18 is in the branch. Automated tests that can run on
this PC should be executed after `flutter gen-l10n`. Live AI, environment keys,
OS share, camera label photos, and a connected Android phone were not completed
in this session.

## Action required (owner)

Do not paste secrets into chat.

| # | Needed | Why | Where | Check | Unblocks |
| --- | --- | --- | --- | --- | --- |
| 1 | Apply `20261022090000_s9_covernote.sql` | Ordinals, delivery, translations, use events, env snapshots | `npx supabase db push` | New columns on `appeal_cases` | R04 R05 R06 R08 R13 R17 R18 |
| 2 | Redeploy `analyze-letter` | Translate + label actions | functions deploy | `action=health` still 200 | R07 R13 |
| 3 | AI secrets if still missing | Real letter / label / translate | same as Sprint 8 | `analyze_probe.mjs health` → `ai_configured:true` | R07 R13 live |
| 4 | Optional `AIRNOW_API_KEY` | Preferred current AQI | Edge secrets | Current AQI source name AirNow | R08 live |
| 5 | Android phone USB | E2E-A through E2E-E | `adb devices` then install APK | Checklist 18 + E2E-A | VERIFIED |

## Limits

- iOS cannot be built on this Windows machine.
- New l10n keys are English in the template. Other languages fall back until
  overlays are filled. Do not mark them reviewed.
- Open-Meteo history is used for past days; AirNow history is not called.
- `share_plus` cannot prove the other party received a file.
