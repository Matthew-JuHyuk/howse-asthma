# Languages

CoverNote is for people who may not read English well and who often have
limited access to care. It offers the app in the languages New Jersey asks for
in public-facing services (see P.L. 2023, c.263), plus English.

| Tag | Language | Written in | Direction | Notes |
|---|---|---|---|---|
| `en` | English | English | LTR | Template |
| `es` | Spanish | Español | LTR | Neutral Latin-American, *usted* |
| `pt` | Portuguese | Português | LTR | Brazilian |
| `ko` | Korean | 한국어 | LTR | |
| `gu` | Gujarati | ગુજરાતી | LTR | Gujarati script |
| `zh-Hans` | Chinese, Simplified | 中文（简体） | LTR | A plain `zh` device or saved value maps here |
| `zh-Hant` | Chinese, Traditional | 中文（繁體） | LTR | Also chosen for `zh-TW`, `zh-HK`, `zh-MO` |
| `ht` | Haitian Creole | Kreyòl ayisyen | LTR | Material/Cupertino ship no Creole, so framework text falls back to French |
| `ar` | Arabic | العربية | RTL | Modern Standard Arabic; Western digits |

## How a person finds their language

* First launch follows the phone's language when it is one of the above.
* A language button (globe + the current language in its own script) is on the
  sign-in screen, on Home and on Account. Each language is listed in its own
  script with its English name underneath, so a helper can find it too.
* The choice is stored on the device (`app_locale_code`) and, for new accounts,
  in `profiles.language_code`.
* The note in the picker says that some text was translated by software and
  that medicine names, doses, dates and quotes from the letter are never
  translated.

## What is translated

* Every string the screens read (657 keys): sign-in, Home, cases, review,
  evidence, packet, records, account, errors.
* **Reasons from a letter.** The AI's own wording is English. In any other
  language the review screen shows a fixed explanation for
  each reason code (`missing_information`, `step_therapy`, `medical_necessity`,
  `formulary`, `quantity_limit`, `eligibility_or_benefit`, `other`) and keeps the
  link to the quote from the letter. The model text is not shown, so nothing
  the model invented is presented in another language.
* **Requested items.** The label stays in the letter's words. A short
  translated hint is added under common kinds (medication history, visit notes,
  test results, doctor's statement). Unknown labels get no hint.
* Medicine names, doses, dates and quotes are never translated.
* Dates use the matching `intl` locale (`zh-Hans`→`zh_CN`, `zh-Hant`→`zh_TW`,
  `pt`→`pt_BR`, `ht`→`fr`; Arabic keeps Western digits).

## What stays English

* The PDF packet is written in English for the care team. The packet screen says
  so in the user's language.
* Server error codes shown with an error message.
* About 500 older strings in the ARB template that no screen reads. They fall
  back to English and are not part of this release.
* The PDF font (Noto Sans) has no Gujarati, Arabic or Chinese glyphs, so a
  patient name in those scripts may not print in the packet. This was already
  true before this change.

## Review status

The translations were drafted by software and checked by script
(`tool/l10n_validate.mjs`: every key present, placeholders and plural syntax
identical to English, brand and `911`/`PDF` kept, text in the expected script).
They have **not** been read by native speakers. Before wide release, ask a
native reader of each language to check, in this order: the reason explanations
(`cnReason*`), the deadline and sharing wording, and the insurance terms.

### Open questions the translators flagged

These are word choices, not errors the checks can find. A native reader should settle them.

* **Inhaler "puffs".** Spanish uses "inhalaciones", Portuguese "jatos", Haitian Creole "pouf". Portuguese also uses "bombinha" for the inhaler.
* **Insurance terms with the English in brackets** (`cnKindInitialDenial`, `cnKindReauth`, `cnKindFinalDenial`, `cnReason*`). Check the local term and whether the extra English helps or clutters.
* **`cnKindEob`.** Chinese, Gujarati and Arabic show "EOB" rather than the full English name, because the full name failed the script check.
* **"Care team", "packet" and "case".** Spanish "equipo de atención", Gujarati "સારવાર ટીમ", Arabic "حزمة" and "حالة". Check they are clear to people with limited literacy.
* **Haitian Creole.** "Medical necessity" and the medical words for asthma and inhaler are the translator's best guess.
* **Arabic.** `s6ReminderChannel` is a literal rendering of "Not a 30-minute alert" and may be unclear.
* **Chinese.** "Appeal" appears as 申诉 or 申訴 in some strings and as 复核 or 覆核 (review) in others. Pick one.
* **`cnTypeDelete`.** "DELETE" stays in English in every language because the app compares the typed word.
* **"Howse Asthma"** stays in English in the biometric prompt and one preview string; confirm that is wanted.

## Database

`profiles.language_code` is `VARCHAR(10)` with a CHECK. Migration
`20261021200000_s8_profile_languages.sql` widens it to the tags above and keeps
`fr`, `ja`, `zh` so existing rows stay valid. Verified on the remote project:
all nine tags accepted, an unknown tag rejected (`23514`).

## Adding a language

1. Add an `AppLanguage` to `lib/core/locale/app_languages.dart` (and the tag to
   the migration's CHECK).
2. `node tool/l10n_validate.mjs source` writes `tool/l10n_source/used_en.json`.
3. Translate into `tool/l10n_overlays/locales/<tag>.part*.json`, then
   `node tool/l10n_validate.mjs merge <tag>`, `check <tag>`, `build <tag>`.
4. `flutter gen-l10n`, then `flutter test` (the render tests run every offered
   language at 360 dp and 200 % text).

Next candidates by size of community in New Jersey: Hindi, Tagalog, Polish,
Russian, Vietnamese.
