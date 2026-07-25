# Howse Asthma — Public / Shared Docs (Git-tracked)

This folder holds **English documentation that is committed to the repository**.

| Path | Role |
| --- | --- |
| [`doc/`](../doc/) (Korean, local) | Internal specs — **gitignored** (`/doc/` in `.gitignore`) |
| [`docs/`](./) (this folder) | Shared docs for collaborators & review — **committed** |
| [`supabase/`](../supabase/) | Applied migrations, config, Edge Functions |

## Convention

Whenever we create or change something under `supabase/` (migrations, RLS SQL, Edge Function contracts, seeds), **also add or update the matching English note here** and commit both.

| Supabase change | Document here |
| --- | --- |
| Tables / views / indexes | [`db-schema.md`](./db-schema.md) |
| RLS policies | `db-schema.md` §3 (and a dedicated RLS note when SQL lands) |
| Edge Function I/O & secrets boundary | `db-schema.md` §4 (expand as functions ship) |

Internal Korean source of truth for product decisions remains under `doc/` (Cursor rules).  
**Physical schema DDL for implementation** should stay aligned between:

1. `doc/db-schema.md` (Korean, local)
2. `docs/db-schema.md` (English, committed) ← keep in sync when schema changes

## Contents

| File | Description |
| --- | --- |
| [`db-schema.md`](./db-schema.md) | Supabase PostgreSQL physical schema (v1.0) |
