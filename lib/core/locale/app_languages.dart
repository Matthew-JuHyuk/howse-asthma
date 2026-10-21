import 'package:flutter/material.dart';

/// One language the app can be shown in.
///
/// The list follows the languages New Jersey asks for in public-facing
/// services (P.L. 2023, c.263) plus English. Names are written in their own
/// language so a person who cannot read the current screen can still find
/// theirs.
class AppLanguage {
  const AppLanguage({
    required this.locale,
    required this.nativeName,
    required this.englishName,
    this.rtl = false,
    this.intlLocale,
  });

  final Locale locale;

  /// Name in the language itself.
  final String nativeName;

  /// Name in English, shown small so helpers and caseworkers can read it.
  final String englishName;
  final bool rtl;

  /// Locale name used for date formatting when it differs from [tag].
  /// `null` means the BCP-47 tag is understood by `intl` as is.
  final String? intlLocale;

  /// Stable code used in prefs, user metadata and `profiles.language_code`,
  /// e.g. `en`, `zh-Hans`.
  String get tag => locale.toLanguageTag();
}

const List<AppLanguage> appLanguages = [
  AppLanguage(
    locale: Locale('en'),
    nativeName: 'English',
    englishName: 'English',
  ),
  AppLanguage(
    locale: Locale('es'),
    nativeName: 'Español',
    englishName: 'Spanish',
  ),
  AppLanguage(
    locale: Locale('pt'),
    nativeName: 'Português',
    englishName: 'Portuguese (Brazil)',
    intlLocale: 'pt_BR',
  ),
  AppLanguage(
    locale: Locale('ko'),
    nativeName: '한국어',
    englishName: 'Korean',
  ),
  AppLanguage(
    locale: Locale('gu'),
    nativeName: 'ગુજરાતી',
    englishName: 'Gujarati',
  ),
  AppLanguage(
    locale: Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    nativeName: '中文（简体）',
    englishName: 'Chinese (Simplified)',
    intlLocale: 'zh_CN',
  ),
  AppLanguage(
    locale: Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    nativeName: '中文（繁體）',
    englishName: 'Chinese (Traditional)',
    intlLocale: 'zh_TW',
  ),
  AppLanguage(
    locale: Locale('ht'),
    nativeName: 'Kreyòl ayisyen',
    englishName: 'Haitian Creole',
    // intl has no Haitian Creole date names; French is the closest.
    intlLocale: 'fr',
  ),
  AppLanguage(
    locale: Locale('ar'),
    nativeName: 'العربية',
    englishName: 'Arabic',
    rtl: true,
  ),
];

/// Locales handed to `MaterialApp.supportedLocales`.
final List<Locale> appSupportedLocales = [for (final l in appLanguages) l.locale];

AppLanguage get defaultAppLanguage => appLanguages.first;

/// Finds the language for a stored tag. Accepts `zh-Hans`, `zh_Hans`, the
/// legacy bare `zh` and region forms such as `zh-TW`. Returns `null` for
/// anything the app does not offer.
AppLanguage? appLanguageForTag(String? raw) {
  if (raw == null) return null;
  final code = raw.trim().replaceAll('_', '-');
  if (code.isEmpty) return null;
  final parts = code.split('-');
  return _match(
    languageCode: parts.first.toLowerCase(),
    scriptCode: parts.length > 1 && parts[1].length == 4 ? parts[1] : null,
    countryCode: parts.length > 1 && parts[1].length != 4
        ? parts[1]
        : (parts.length > 2 ? parts[2] : null),
  );
}

/// Maps any [Locale] (device, widget tree) to the closest offered language.
AppLanguage? appLanguageForLocale(Locale locale) => _match(
      languageCode: locale.languageCode.toLowerCase(),
      scriptCode: locale.scriptCode,
      countryCode: locale.countryCode,
    );

AppLanguage? _match({
  required String languageCode,
  String? scriptCode,
  String? countryCode,
}) {
  if (languageCode == 'zh') {
    final traditional = scriptCode?.toLowerCase() == 'hant' ||
        (scriptCode == null &&
            const {'TW', 'HK', 'MO'}.contains(countryCode?.toUpperCase()));
    final script = traditional ? 'Hant' : 'Hans';
    return appLanguages.firstWhere((l) => l.locale.scriptCode == script);
  }
  for (final l in appLanguages) {
    if (l.locale.languageCode == languageCode) return l;
  }
  return null;
}

/// Name of the language for [locale], in that language.
String nativeNameOf(Locale locale) =>
    appLanguageForLocale(locale)?.nativeName ?? locale.toLanguageTag();

/// Whether [tag] is one the app can store (used for `profiles.language_code`).
bool isOfferedLanguageTag(String? tag) => appLanguageForTag(tag) != null;

/// Locale name safe to pass to `DateFormat`/`NumberFormat`. `intl` throws for
/// locales it does not know (for example Haitian Creole).
String intlLocaleFor(Locale locale) {
  final language = appLanguageForLocale(locale);
  if (language == null) return 'en';
  return language.intlLocale ?? language.locale.toLanguageTag();
}
