# Environment provider contract (R08)

## Sources

Existing Edge function `calculate-environment-risk` is the **current** path
(AirNow → Open-Meteo `us_aqi` → PurpleAir). Outdoor humidity comes from
Open-Meteo weather (`mold_rh_pct` in the function response). The Flutter
dashboard that used to call it was removed in Sprint 8; this sprint calls the
same function again and writes snapshots.

| Need | Source | Key | History |
| --- | --- | --- | --- |
| Current AQI | `calculate-environment-risk` (AirNow first) | `AIRNOW_API_KEY` (optional fallback: Open-Meteo, no key) | Not used as “now” for past days |
| Current outdoor RH | same function / Open-Meteo weather | none | — |
| Past day AQI / RH | Open-Meteo air-quality + archive APIs (no key) | none | Used only when the event local date is before today |
| Pollen / NO2 / PM2.5 extra | shown only when the live payload includes them | `GOOGLE_MAPS_API_KEY` for pollen | never invented |

Open-Meteo pollen Europe fields are not requested.

## Matching rule

- **Today, event within 2 hours of fetch:** current observation may attach.
  UI: “Closest observation to the record time.”
- **Past local date:** history/archive only. If none, status `unavailable`.
  Current weather is never written onto a past event.
- **Future:** not attached as a fact.
- AQI index and PM2.5 concentration are stored as separate metrics.
- Outdoor RH is not indoor humidity or mold.

## Write path

1. Health record save returns immediately (`env_status = pending`).
2. A background job fetches and inserts `environment_snapshots` +
   `environment_event_links` (and a `local_context_entries` row so older
   packet code still sees the day).
3. Failure: record stays; UI shows “No air or weather data” + retry.
4. Same place + 20-minute cache is reused (existing env cache + client TTL).

## Location

- Environmental factors (air quality, traffic-related air, pollen, flood
  alerts, and outdoor humidity) use the phone's current location. There is
  no ZIP or city form. A denied or disabled location is explained, with
  retry or a link to settings. It is not replaced with a typed address.
- The factors screen shows the last result first. A result less than one
  hour old is not fetched again.
- A fresh result skips another location request. Logging a medication use
  still asks once for that event. Always-on location is not required.
  Coordinates are not stored as a home address.
- “Place of this record” is shown only when an event coordinate exists.

## Warnings

Banners use the official AQI category from the payload and the observation
time. Stale cache is not shown as a current warning. Push stays opt-in and
uses the existing `notify-environment-risk` path only when already configured.
