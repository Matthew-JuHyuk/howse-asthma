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
  may have mistakes. Medicine names and doses stay as printed. The rest of
  the letter is translated for the reader.

## What is translated

* Every string the screens read (786 keys): sign-in, Home, cases, review,
  records, packet, Settings, medications, air and weather, errors.
* **Reasons from a letter.** When the letter has a reason sentence, that
  sentence is translated for display. If the sentence is empty, the review
  screen uses the fixed explanation for the reason code
  (`missing_information`, `step_therapy`, `medical_necessity`, `formulary`,
  `quantity_limit`, `eligibility_or_benefit`, `other`).
* **Requested items.** The wording on each item is translated for display.
  Medicine names inside that wording stay as printed.
* **Full pages.** After a letter is photographed or uploaded, a non-English
  UI starts a full-page translation. The stored quote and the original page
  text stay in the letter's language and can still be opened.
* Medicine names and doses stay as printed. Dates, amounts, phone numbers,
  member IDs and plan names stay as printed. A translation is not saved back
  as the corrected fact.
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

### Settled from a second pass against the screens (2026-10-21)

* **Evidence step** is the patient's own records (home copy: "Gather records"), not court proof. The English step label is now **Records**, matching the other languages (Korean 자료).
* **Dose reminders** (`s6ReminderChannel`) are the times on the saved prescription. They are not the 30-minute air/weather push (`medication_reminder.dart`).
* **Appeal vs review request** stays two words: Chinese 申诉/申訴 vs 复核申请/覆核申請; Arabic استئناف vs طلب مراجعة; Portuguese recurso vs pedido de revisão.
* **`cnKindEob`** now keeps the full English "Explanation of Benefits", not only "EOB".
* **Arabic case/packet** is ملف / حزمة المستندات (not حالة / a parcel حزمة).
* **`cnTypeDelete`** still uses the English word DELETE, because the app compares the typed text to that word.

### Open questions for a native reader

* **Inhaler "puffs".** Spanish "inhalaciones", Portuguese "jatos", Haitian Creole "puff", Gujarati "પફ". Portuguese "bombinha" for the inhaler.
* **Insurance terms with the English in brackets** on kind labels and reason explainers. Check length on a small phone.
* **Haitian Creole clinic words** (`asm`, `ponp`, `puff`, `pèmisyon ankò`) still need a community ear.
* **"Howse Asthma"** stays in English in the biometric prompt and one preview string.

### Location and letter-translation pass (2026-10-21)

Air and weather no longer ask for a ZIP or city. New strings
(`cnLocationNeed`, `cnLocationOff`, `cnLocationBlocked`, `cnOpenSettings`)
and the updated language note and air note are in all nine languages.
Korean `cnDeliveryUserReport` and `cnReasonOther` were tightened so they
read as ordinary speech. This pass was checked by script only. It is not a
native-speaker review.

### Sprint 9 copy pass (2026-10-21)

New Home/Cases/Records/Settings strings (share vs delivery, my medications,
label scan, local air and weather, AI consent, key details, case outcome) are
in all nine languages. Overlay check: placeholders, `CoverNote`/`PDF`/`911`,
and script match English. They have **not** been marked reviewed.

UX paraphrases (not word-for-word):

* Share CTAs say *send documents*, not only “share”, so they are not confused
  with social posting. Recording a send is not the same as finishing a case.
* The packet step is documents for the care team: Spanish/Portuguese/Haitian
  Creole *Documentos/Dokiman*, Korean 제출 자료, Arabic حزمة المستندات.
* Settings, not Account, on the fourth tab. Gujarati home tab is મુખ્ય, not
  the English loan હોમ. Traditional Chinese uses 氣喘 and 封存; Simplified
  uses 哮喘 and 归档.

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
