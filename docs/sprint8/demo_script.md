# Demo script

Two runs. **Run A** works today with no account and no AI. **Run B** is the real product path and needs the AI secrets,
a test account and a phone (see [setup_runbook.md](./setup_runbook.md)). Do not present Run A as live analysis.

## Run A — public sample (about 2 minutes)

The sample uses synthetic data stored in the app. Every sample screen and PDF is marked **Sample**.

1. Open the app. Home shows **CoverNote**, "Make sense of your insurance letter.", **Scan a letter**, **Upload PDF / photo** and **Try demo**.
2. Tap **Try demo** → choose **DemoController A 100 mcg** (missing-information denial).
3. **Review** step: three cards — **Why it was denied**, **Next step**, **Date to check**. Tap a quote to open the letter at that page.
4. On each fact tap **Looks right** (or edit the value inline). The bar shows **Saved**. **Continue to evidence** unlocks.
5. **Evidence**: under **What the letter asks for**, tap **Link my records** → medication summary. The item shows Linked.
6. **Continue to packet** → **Generate review packet**. Two tabs: **Doctor summary** and **Review request draft**.
7. Point out on the summary: one page, the record line `51 taken / 3 not taken / 6 unknown of 60` with "Unknown = no answer recorded;
   not counted as missed", as-needed use counted separately, the deadline with its check status, and the footer
   "Patient-reported records and location-matched context; clinician review required."
8. Point out on the draft: **DRAFT - FOR REVIEW** on every page, blank clinician fields.
9. **Share** opens the phone's share sheet. Afterwards the case says "Shared on …", not "submitted".
   Only **I sent it** with a date and method records a user-reported submission.

Other samples: **DemoController B 200 mcg** (step therapy; deadline counts from a received date you enter),
**DemoController C 80 mcg** (two dates in the letter → the app asks you to check instead of picking one).

## Run B — live letter (after setup)

1. Sign in with test account A (password from `.env.demo`; never shown on screen or in a recording).
2. **Scan a letter** → photograph a printed synthetic letter (two pages if available). Rotate or retake as needed.
3. Progress shows the real steps (uploading, reading, checking). Show the elapsed time; cut long waits in editing but keep the number.
4. Repeat Run A steps 3–9 on the live result. Show one field the app left as unknown or "needs review" rather than guessing.
5. Close the app fully, reopen: the same case and packet are there.
6. Optional variant: a letter with a changed name, medicine and dates — the result follows the paper, not the sample.

## Do not say

- That the app files an appeal, contacts the insurer or predicts approval.
- That PM2.5 or NO2 values measure truck exhaust, or that outdoor humidity shows mold in the home.
- That self-reported records are verified clinical facts.
- That any live result was produced if the AI secrets were not set at recording time.
