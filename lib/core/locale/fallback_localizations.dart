import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Wraps a framework localizations delegate so a language it does not ship
/// (for example Haitian Creole in Material) still loads, using the closest
/// language it does ship instead of throwing.
class _FallbackDelegate<T> extends LocalizationsDelegate<T> {
  const _FallbackDelegate(this._base);

  final LocalizationsDelegate<T> _base;

  /// Language used when [_base] has nothing for the requested one.
  static Locale fallbackFor(Locale locale) =>
      locale.languageCode == 'ht' ? const Locale('fr') : const Locale('en');

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<T> load(Locale locale) {
    final target = _base.isSupported(locale) ? locale : fallbackFor(locale);
    return _base.load(target);
  }

  @override
  bool shouldReload(covariant _FallbackDelegate<T> old) => false;
}

/// Material, Widgets and Cupertino delegates that never throw for the
/// languages the app offers.
final List<LocalizationsDelegate<dynamic>> frameworkLocalizationDelegates = [
  _FallbackDelegate<MaterialLocalizations>(GlobalMaterialLocalizations.delegate),
  _FallbackDelegate<WidgetsLocalizations>(GlobalWidgetsLocalizations.delegate),
  _FallbackDelegate<CupertinoLocalizations>(
    GlobalCupertinoLocalizations.delegate,
  ),
];

@visibleForTesting
Locale frameworkFallbackFor(Locale locale) =>
    _FallbackDelegate.fallbackFor(locale);
