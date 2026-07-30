# Sprint 2 device test review backlog

Issues and product improvements found during on-device testing after the Sprint 2
signup / onboarding release. This is a **review backlog**, not the Sprint 2
implementation task list.

---

## 1. Mold risk from open environmental signals

Prefer a **mold risk / mold outlook** index over flood-only framing. If no dedicated
source exists, estimate conditions from combinations such as humidity, dew point, and
how long damp conditions persist. After rain, outdoor air can feel fresher while indoor
mold risk may still rise. Combine open APIs into a transparent estimate of
mold-favorable home conditions.

## 2. UI: mold index and contributing factors

Lead the UI with a mold risk (or mold forecast) index. Under it, list drivers with
**current values and short-range forecasts** (e.g. humidity, flood/inundation as one
input, dew point / dampness, temperature, duration of mold-favorable conditions).
Define the forecast method in a separate research pass before locking formulas or
endpoints.

## 3. Freight / air (TRAP proxy): locality and radius

- Show a **place name** for the resolved location, and/or a simple map.
- Show the **radius (miles)** used for the reading or inference.
- Do not present distant regional peaks as local conditions.

Field tests showed “very high” readings that did not match the immediate area.
Treat road-adjacent air as a **TRAP-style proxy** (sensor / official AQI plus static
traffic weighting where available)—not a live truck count. Do not overclaim in copy.

## 4. Current values plus forecasts

Every core index should show **now and next** (hourly and/or next day). Prefer
asthma-, indoor-, and action-oriented insights over generic weather already available
elsewhere. Notify on material changes.

## 5. Positive pushes (e.g. ventilation windows)

Send helpful notifications as well as risk alerts—for example, a window that is good
for ventilating when outdoor pollution and humidity are relatively lower. Prompt other
asthma-helpful actions in time for prevention.

## 6. Medication adherence calendar

Use a **calendar view** of daily medication / logging adherence on the main experience.
Balance adherence and environment portions; use secondary patterns (e.g. a lightweight
ticker) for less critical tips if the viewport is full.

## 7. Action-oriented UX

Users should leave with a clear **next action**, not only charts.

## 8. Plain language

Reduce jargon and opaque numbers. Answer: **“What should I do right now to avoid an
attack today?”**—in the UI and in pushes when attention is elsewhere.

## 9. Background updates and consent

Explain and obtain consent for location collection and any background refresh. Confirm
first-run location consent; add it if missing. Allow changes in Settings.

**Field note:** No push notifications were received during the review period—diagnose
permissions, token registration, and the server notify path.

## 10. Push content and categories

Pair short text with simple visual cues. Require opt-in early. Let users toggle
notification categories in onboarding and Settings (e.g. risk vs. positive / ventilation).

## 11. Settings scroll defect

Settings often scrolls only from outer margins, unlike other screens, and leaves a large
empty region at the bottom. Fix as a UX bug.

## 12. Slow location / env load

While location resolves, show the **last successful snapshot** first, then refresh in
place. Avoid infinite loading or a hard location-failure message as the first paint.
