# UI design references (Subframe)

Patient-path layout references exported from Subframe, plus theme tokens used by the Flutter app.

## Layout

```text
design/subframe/
├── README.md / INDEX.md / PROJECT.json
├── docs/PAGE_IDS.json     # Screen ID → Subframe page id
├── theme/                 # Color / breakpoint tokens
└── react-reference/       # Patient, auth, and system screens only
```

Provider screens are designed in Subframe but not stored in this repo.

## Device preview

```powershell
# In .env: DESIGN_PREVIEW=true
flutter run
```

Opens the patient mock UI under `lib/features/design_preview/` (navigation only). Use the screen catalog from Home or Settings to open all Screen IDs.

## Updating a screen

1. Edit the page in Subframe (links in `INDEX.md`).
2. Refresh the matching folder under `react-reference/`.
3. Mirror layout changes in the Flutter design-preview (or production) widgets.
