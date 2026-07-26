# App Store / Play — Location Permission Justification (draft)

> **WBS 5.8** — Draft copy for iOS “Always” (and Android background) location
> disclosures. Finalize before Phase 8 store submission. Not legal advice.

## Product purpose

Howse Asthma helps people with asthma avoid outdoor triggers by combining
national air-quality / flood / pollen data with optional New Jersey freight
weighting. Alerts are strongest when the app knows **where the patient is**
and which **saved places** (home, school, work) to monitor.

## Permission tiers (recommended product policy)

| Tier | When requested | Used for |
| --- | --- | --- |
| **When In Use** | First ENV / Home risk load | Current AQI, flood, pollen risk; 1-Tap location stamp; foreground geofence |
| **Always** (iOS) / background location (Android) | Only if we ship OS-level background alerts | Entering a high-risk area or saved-place change while app is not open |

**Current MVP (Phase 5):** foreground monitoring only (`EnvironmentMonitor` while
the patient shell is open). OS push when backgrounded still depends on
**Firebase / FCM (WBS 4.6a)**. Do **not** request “Always” until background
delivery is implemented and this draft is reviewed.

## Suggested App Store “Purpose String” (NSLocation*)

### When In Use (`NSLocationWhenInUseUsageDescription`)

> Howse Asthma uses your location while you use the app to show nearby asthma
> risk (air quality, flood alerts, and pollen) and to check places you save
> (such as home or school). Location is sent securely to calculate risk and is
> not sold.

### Always (`NSLocationAlwaysAndWhenInUseUsageDescription`) — enable only with 4.6a

> Howse Asthma can use your location in the background to alert you when you
> enter a higher-risk area or when conditions worsen at a place you saved.
> Background location is optional; you can keep “While Using” only. We do not
> sell your location.

### Temporary Precise Location (if prompted)

> Precise location improves nearby sensor and flood matching. Approximate
> location may still show regional risk with lower accuracy.

## Suggested Play Console declaration notes

- **Purpose:** Asthma environmental risk alerts and adherence context.
- **Data type:** Approximate / precise location (as configured).
- **Processing:** Sent to backend (Supabase Edge) to compute risk; alert history
  stored under the signed-in patient with RLS.
- **Not collected for advertising.**
- Background location: declare only after FCM + background path ships.

## UX copy reminders (in-app)

- Explain **why** before the system dialog (Settings → Location).
- Offer saved-place monitoring as an alternative to continuous tracking.
- NJDOT freight weight is **New Jersey only** — never imply nationwide truck counts.

## Review checklist before enabling Always

- [ ] Firebase / FCM path live (4.6a)
- [ ] Background fetch / geofence battery impact tested on low-end Android
- [ ] Privacy policy URL updated with location retention
- [ ] Strings above localized (en/es/fr/ko/ja/zh) in Info.plist / Play form
