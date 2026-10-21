# Sprint 8 audit — starting point for CoverNote MVP1

Audit base: commit `8bbef92` (Sprint 7 sample walkthrough). Work branch: `sprint8-covernote-mvp1`.
Backend confirmed from code and live settings: Supabase project `jnzdovjjahvtxbhacjuv`
(auth, Postgres with RLS, private storage, Edge Functions). No new backend was introduced.

## What the app did at the base commit

| Area | Finding at `8bbef92` | Evidence |
| --- | --- | --- |
| Name | "Howse Asthma" in the launcher label, app bar and 12 strings in `app_en.arb` | `git grep -c "Howse Asthma" 8bbef92 -- lib/l10n/app_en.arb` |
| Home | Environment dashboard with a large SOS action in the header (`Icons.sos_outlined`) | `lib/features/home/presentation/home_shell.dart:158` at base |
| Letter feature | Hidden behind a Settings switch (`v2_navigation_enabled`) | `lib/core/config/v2_nav_flag.dart` at base |
| Live reading | `LIVE_DOCUMENT_PROCESSING_ENABLED` defaulted off; letters were never read by a real service | `lib/core/config/app_config.dart` at base |
| Sample IDs | Internal ids such as `sample1001` were visible | `lib/features/appeal/domain/synthetic_case.dart` at base |
| Case screen | One long scroll; two draft buttons with unclear meaning; several "Save correction" buttons | `lib/features/appeal/presentation/*` at base |
| Sign-in | Social-first welcome (Google, Apple on iOS). Google and Apple are not enabled on the server, so the main sign-in path always failed | See [auth_diagnosis.md](./auth_diagnosis.md) |
| Languages | Six languages selectable; fr/ja/zh were not reviewed | `lib/l10n/app_{es,fr,ja,zh}.arb` at base |
| PDF | Visit-prep PDF with prose before and after tables | `lib/features/visit_prep/*` at base |

## Keep / remove decisions (spec KEEP-01)

Removal means the product path and dead code. No table was dropped or renamed and no user rows were deleted.
All removed code is recoverable from `8bbef92`.

| Feature | Action | Where it lives now |
| --- | --- | --- |
| Medication schedule, dose checks, past medications | Kept, simplified | Records tab → `lib/features/records/presentation/my_medications_screen.dart`, linked to cases as a snapshot |
| Symptoms, night waking, as-needed use | Kept | Records tab → `my_log_screen.dart`; counted in `record_snapshot.dart` |
| Environment readings | Moved under Records as **Local context** (manual values with source, plus quick self-reports) | `lib/features/covernote/presentation/local_context_screen.dart` |
| PDF / share engine (`pdf`, `printing`) | Reused; new one-page summary + draft | `lib/features/covernote/pdf/packet_pdf.dart` |
| Air-quality forecast, rankings, dashboard | Removed from the app | `features/environment`, `features/home` deleted. Server functions stay deployed and unused by the app |
| Visit-prep screens | Removed (replaced by the case packet) | `features/visit_prep` deleted |
| Rewards, streaks | Removed from the product path | `features/rewards` deleted |
| Demo/live switch in Settings | Removed | `v2_nav_flag.dart` deleted; flags removed from `.env.example` |
| SOS header button | Moved to Records → urgent help | `records_tab.dart:130` opens the existing `PanicScreen` (`tel:` 911) |
| Unreviewed languages | Removed; English and Korean only | `app_es/fr/ja/zh.arb` deleted |
| Provider (clinician) role screens | Kept in code, not on the patient path | `lib/features/provider` |

## Decisions recorded during the sprint

- **Display name** is CoverNote (Android label, iOS `CFBundleDisplayName`, app header, sign-in, PDF header and file name).
  Package id `com.howseasthma.app` and the auth callback scheme `io.supabase.howseasthma://login-callback/` are unchanged.
- **Launcher icon** colours are sampled from the supplied concept artwork. The adaptive background is `#0F2E55`
  (the concept's tile colour), close to but not exactly the palette navy `#142D4E` used in the UI.
- **AI model** is server configuration only. No default model id is shipped; `AI_MODEL` must be set as a secret.
- **Release signing** uses the debug keystore so the APK installs on a test device. A store release needs its own upload key.
- **Local context** is manual entry with source and date in MVP1. Automatic collection from the existing environment
  functions is P1 and not wired into the app.
- **iOS** project files carry the new name and icon, but iOS cannot be built on this Windows machine.
