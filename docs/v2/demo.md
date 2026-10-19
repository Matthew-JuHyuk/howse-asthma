# v2.0 sample walkthrough

The sample is fiction. The name on it is “Alex Sample”. It is not a patient
and not a plan.

## Turn the preview on

1. Sign in as usual.
2. Open Settings.
3. Turn on **Show coverage-letter home**.
4. Go back to Home.

Turning the switch off restores the previous home. Records, visit prep, and
environment tabs stay in the bar.

Live document reading stays off unless `LIVE_DOCUMENT_PROCESSING_ENABLED` is
set. This walkthrough does not need that flag. Do not turn it on until a
document provider, retention, and the private bucket are confirmed.

## Steps

1. Tap **Try a sample**. The screen says the notice is a sample.
2. Read the three numbered sentences and open the original text.
3. Tap **I reviewed these facts**.
4. Tap **Make a review draft**.
5. Tap **Share** or **Clinician one-page PDF**.

Sharing only opens the system sheet. The app does not record that a plan
received the file.

**Add a denial letter** explains that photos are not analyzed in this build,
then offers the same sample.

## Flags

| Name | Default | Effect |
| --- | --- | --- |
| `V2_NAVIGATION_ENABLED` | off | Initial value of the home switch when the device has no saved choice |
| `LIVE_DOCUMENT_PROCESSING_ENABLED` | off | Must stay off until an operator configures reading |
| `VERIFIED_EVIDENCE_ENABLED` | off | Must stay off while the excerpt catalog is empty |

## Rollback

Turn off the settings switch. Leave the new tables in place if they were
applied. Do not drop them to undo the screen.

## Database

`supabase/migrations/20261018120000_v2_appeal_cases.sql` adds appeal-prep
tables, owner policies, and a private `appeal-documents` bucket. Apply it
with `supabase db push` only when you intend to use those tables. The sample
walkthrough does not write to them.
