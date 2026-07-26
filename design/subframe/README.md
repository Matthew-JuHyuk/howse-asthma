# UI design references (Subframe)

Patient-path layout references exported from Subframe, plus theme tokens.

## Layout

```text
design/subframe/
├── README.md / INDEX.md / PROJECT.json
├── docs/PAGE_IDS.json     # Screen ID → Subframe page id
├── theme/                 # Color / breakpoint tokens
└── react-reference/       # Patient, auth, and system screens
```

## Device preview (optional)

```powershell
# In .env: DESIGN_PREVIEW=true
flutter run
```

Opens `lib/features/design_preview/` for navigation flow checks. Set `DESIGN_PREVIEW=false` for the normal auth entry path.
