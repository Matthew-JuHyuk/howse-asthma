# UI design references (Subframe)

Patient-path layout references exported from Subframe, plus theme tokens.

**Draft only — not store / production quality.** Windows feedback (2026-07-25): Subframe
originals need a stronger visual redesign later; Flutter `design_preview` is a low-fidelity
nav skeleton and must not be shipped. Per-screen visual work is deferred (WBS **1.0c**)
until real feature UI (Phase 2/4/7/9).

## Layout

```text
design/subframe/
├── README.md / INDEX.md / PROJECT.json
├── docs/PAGE_IDS.json     # Screen ID → Subframe page id
├── theme/                 # Color / breakpoint tokens
└── react-reference/       # Patient, auth, and system screens only
```

Provider screens exist in Subframe but are not stored in this repo.

## Device preview (optional)

```powershell
# In .env: DESIGN_PREVIEW=true
flutter run
```

Opens `lib/features/design_preview/` (navigation only). Use for flow checks, not design sign-off.
