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

/// App language. Default for new installs is English (product default).
/// Persists the user's choice; `null` is not used for the initial value.
class LocaleController extends ValueNotifier<Locale> {
  LocaleController() : super(const Locale('en'));

  bool _loaded = false;

  /// Load saved preference (falls back to English).
  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code != null &&
        supportedLocales.any((l) => l.languageCode == code)) {
      value = Locale(code);
    } else {
      value = const Locale('en');
    }
    _loaded = true;
  }

  Future<void> setLocale(Locale locale) async {
    value = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
  }
}
