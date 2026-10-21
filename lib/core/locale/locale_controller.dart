import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_languages.dart';

export 'app_languages.dart';

/// Languages the user can pick (see [appLanguages]).
List<Locale> get supportedLocales => appSupportedLocales;

const _prefsKey = 'app_locale_code';

/// App language. First launch follows the OS when supported; a manual choice
/// in prefs always wins.
class LocaleController extends ValueNotifier<Locale> {
  LocaleController() : super(defaultAppLanguage.locale);

  bool _loaded = false;

  /// Load saved preference, else device locale, else English.
  Future<void> load() async {
    if (_loaded) return;
    final prefs = await SharedPreferences.getInstance();
    final saved = appLanguageForTag(prefs.getString(_prefsKey));
    if (saved != null) {
      value = saved.locale;
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
      final match = appLanguageForLocale(device);
      if (match != null) return match.locale;
    }
    return defaultAppLanguage.locale;
  }

  Future<void> setLocale(Locale locale) async {
    final language = appLanguageForLocale(locale);
    if (language == null) return;
    value = language.locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, language.tag);
  }

  /// Language chosen on Welcome/Settings (prefs), if any. Returns the stored
  /// tag, for example `ko` or `zh-Hans`.
  static Future<String?> savedLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();
    return appLanguageForTag(prefs.getString(_prefsKey))?.tag;
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
