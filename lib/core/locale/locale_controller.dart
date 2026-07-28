import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The languages the app ships with. Keep this in sync with the ARB
/// files under `lib/l10n/` and with `lib/l10n.yaml`.
const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('es'),
  Locale('fr'),
  Locale('ko'),
  Locale('ja'),
  Locale('zh'),
];

const Map<String, String> localeDisplayNames = {
  'en': 'English',
  'es': 'Español',
  'fr': 'Français',
  'ko': '한국어',
  'ja': '日本語',
  'zh': '中文',
};

const _prefsKey = 'app_locale_code';

/// App language. First launch follows OS when supported (Sprint 2 S2-I18N-03);
/// a manual choice in prefs always wins (S2-I18N-06).
class LocaleController extends ValueNotifier<Locale> {
  LocaleController() : super(const Locale('en'));

  bool _loaded = false;

  /// Load saved preference, else device locale, else English.
  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code != null &&
        supportedLocales.any((l) => l.languageCode == code)) {
      value = Locale(code);
    } else {
      value = resolveInitialLocale(
        platformLocales: PlatformDispatcher.instance.locales,
      );
    }
    _loaded = true;
  }

  /// Visible for tests — maps device locales to a supported [Locale].
  static Locale resolveInitialLocale({
    required List<Locale> platformLocales,
  }) {
    for (final device in platformLocales) {
      for (final supported in supportedLocales) {
        if (supported.languageCode == device.languageCode) {
          return supported;
        }
      }
    }
    return const Locale('en');
  }

  Future<void> setLocale(Locale locale) async {
    value = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
  }

  /// Language chosen on Welcome/Settings (prefs), if any.
  static Future<String?> savedLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code != null &&
        supportedLocales.any((l) => l.languageCode == code)) {
      return code;
    }
    return null;
  }
}
