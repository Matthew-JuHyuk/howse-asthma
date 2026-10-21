# AI usage record — Sprint 8

This file records how AI was used. It must not be edited to present AI-written work as hand-written.

## 1. AI used to build the app

| Item | Record |
| --- | --- |
| Tool | Cursor agent (Anthropic Claude model), working in this repository on Windows |
| Period | 2026-10-20 to 2026-10-21 (America/New_York), several agent sessions |
| Human input | The Sprint 8 requirements package from the project owner: requirements, an icon concept image, six printable synthetic test letters with an expected-answers file, and a sample clinician summary |
| AI output | All Sprint 8 code and docs in commits `18f2e19` … on `sprint8-covernote-mvp1`: Flutter screens, the PDF builder, the database migration, the `analyze-letter` and `delete-account` functions, the test-account and probe scripts, the icon generator, the unit/widget tests, and every file in `docs/sprint8/` |
| Student-written code in this sprint | None. Student contribution is a later, separate phase and is not represented here |
| Commit trailer | Agent commits carry `Co-authored-by: Cursor <cursoragent@cursor.com>` |

### What the agent ran itself

Analyzer, unit and widget tests, the release build, migrations and function deploys to the development project,
the account/isolation/deletion probes against the real server, and the auth settings probe. Results are in
[verification.md](./verification.md). The agent did not run anything on a phone and did not call any AI model API.

### Corrections made during the work

The agent's own mistakes and the fixes are in [defects.md](./defects.md) (D-01 to D-08). Notable ones:

- It had put a guessed default model id in the server code; removed so the model must be set explicitly (D-06).
- Its first PDF layout did not fit on one page with records attached; found by its own test and fixed (D-02).
- Its seed script used a fixed date that would not match the app's window on other days (D-03).
- A draft of `auth_diagnosis.md` said OAuth errors showed "invalid email" in the app. Reading the base code showed the
  error appears in the browser instead; the document was corrected before commit.
- A widget test at 200 % text first failed because the test font draws square glyphs. The test now loads the bundled
  Noto Sans so line widths are realistic; it was not loosened to pass.

## 2. AI used inside the app (runtime)

| Item | Record |
| --- | --- |
| Where | `supabase/functions/analyze-letter` only. The phone never calls an AI service |
| Provider / model | Chosen by the operator with `AI_PROVIDER` and `AI_MODEL` secrets. **Not configured yet** |
| What is sent | The uploaded letter pages and a fixed prompt (`prompts.ts`, version `s8-letter-2026-10-21.1`) |
| Not sent | Account password, other cases, health records, file names, fixture ids or expected answers |
| Settings | `store=false`; no tools, so the model cannot open links or run anything named in a letter |
| Logged | Provider request id, model, prompt version, duration and token counts in `processing_jobs`. No letter text and no keys |
| Checks on output | `validate.ts`: quotes must appear in the page text, medicine and dose kept verbatim, unknown → null, unclear → ambiguous; the user confirms facts before anything is generated |

No live model call has been made yet, so no runtime request ids, timings or token counts exist to report.
