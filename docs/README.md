<a href="../README.md"><img src="../assets/branding/covernote_icon_1024.png" alt="CoverNote app logo" width="64" height="64"></a>

# CoverNote source map

- `lib/features/covernote/`: current CoverNote workflows, UI, records, and PDF generation.
- `lib/core/`: shared configuration, authentication, and services.
- `android/`: Android host and Kotlin speech integration.
- `supabase/migrations/`: versioned database schema and access policies.
- `supabase/functions/`: TypeScript backend functions and provider integrations.
- `test/`: automated tests and synthetic fixtures.
- `tool/make_client_env.mjs`: generates the client configuration allowlist.
- `scripts/build_release.ps1`: Android release build helper.

[Setup and build](setup.md) · [Project overview](../README.md)

Public documentation is limited to usage and development essentials. Planning notes, presentation scripts, research working files, generated reports, and local configuration are excluded. The local `doc/` archive is not part of the public repository.
