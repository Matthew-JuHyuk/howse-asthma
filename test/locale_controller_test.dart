import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/core/locale/locale_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocaleController.resolveInitialLocale', () {
    test('picks first supported device language', () {
      final locale = LocaleController.resolveInitialLocale(
        platformLocales: const [Locale('es', 'US'), Locale('en', 'US')],
      );
      expect(locale.languageCode, 'es');
    });

    test('falls back to en when unsupported', () {
      final locale = LocaleController.resolveInitialLocale(
        platformLocales: const [Locale('de'), Locale('it')],
      );
      expect(locale.languageCode, 'en');
    });
  });

  group('LocaleController.load', () {
    test('prefs win over device', () async {
      SharedPreferences.setMockInitialValues({'app_locale_code': 'ko'});
      final c = LocaleController();
      await c.load();
      expect(c.value.languageCode, 'ko');
    });

    test('no prefs uses resolveInitialLocale path to a supported code',
        () async {
      SharedPreferences.setMockInitialValues({});
      final c = LocaleController();
      await c.load();
      expect(
        supportedLocales.any((l) => l.languageCode == c.value.languageCode),
        isTrue,
      );
    });

    test('savedLanguageCode reads prefs', () async {
      SharedPreferences.setMockInitialValues({'app_locale_code': 'es'});
      expect(await LocaleController.savedLanguageCode(), 'es');
    });
  });
}
