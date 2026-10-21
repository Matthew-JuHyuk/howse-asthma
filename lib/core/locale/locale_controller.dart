import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Languages the user can pick. Only languages with a complete, checked
/// translation of the current screens are listed.
const List<Locale> supportedLocales = [Locale('en'), Locale('ko')];

const Map<String, String> localeDisplayNames = {'en': 'English', 'ko': '한국어'};

const _prefsKey = 'app_locale_code';

/// App language. First launch follows the OS when supported; a manual choice
/// in prefs always wins.
class LocaleController extends ValueNotifier<Locale> {
  LocaleController() : super(const Locale('en'));

  bool _loaded = false;

  /// Load saved preference, else device locale, else English.
  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code != null && supportedLocales.any((l) => l.languageCode == code)) {
      value = Locale(code);
    } else {
      value = resolveInitialLocale(
        platformLocales: PlatformDispatcher.instance.locales,
      );
    }
    _loaded = true;
  }

  /// Visible for tests — maps device locales to a supported [Locale].
  static Locale resolveInitialLocale({required List<Locale> platformLocales}) {
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
    if (!supportedLocales.any((l) => l.languageCode == locale.languageCode)) {
      return;
    }
    value = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, locale.languageCode);
  }

  /// Language chosen on Welcome/Settings (prefs), if any.
  static Future<String?> savedLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_prefsKey);
    if (code != null && supportedLocales.any((l) => l.languageCode == code)) {
      return code;
    }
    return null;
  }
}

class AppLocaleScope extends InheritedWidget {
  const AppLocaleScope({
    super.key,
    required this.controller,
    required super.child,
  });

  final LocaleController controller;

  static LocaleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppLocaleScope>();
    assert(scope != null, 'AppLocaleScope not found in widget tree');
    return scope!.controller;
  }

  @override
  bool updateShouldNotify(AppLocaleScope oldWidget) =>
      controller != oldWidget.controller;
}
