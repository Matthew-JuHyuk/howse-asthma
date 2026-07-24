import 'package:flutter/material.dart';

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

/// Holds the user-selected app language. `null` means "follow system locale".
///
/// This is intentionally a plain [ValueNotifier] (no external state
/// management package) to keep the initial project dependencies minimal.
class LocaleController extends ValueNotifier<Locale?> {
  LocaleController() : super(null);

  void setLocale(Locale? locale) => value = locale;
}
