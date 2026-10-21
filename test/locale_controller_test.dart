import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/core/locale/locale_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Locale _resolve(List<Locale> device) =>
    LocaleController.resolveInitialLocale(platformLocales: device);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('offered languages', () {
    test('cover the New Jersey language set plus English', () {
      expect(
        appLanguages.map((l) => l.tag).toList(),
        ['en', 'es', 'pt', 'ko', 'gu', 'zh-Hans', 'zh-Hant', 'ht', 'ar'],
      );
    });

    test('every language has a name in its own script', () {
      for (final l in appLanguages) {
        expect(l.nativeName.trim(), isNotEmpty);
        expect(l.englishName.trim(), isNotEmpty);
      }
      expect(nativeNameOf(const Locale('ar')), 'العربية');
      expect(nativeNameOf(const Locale('gu')), 'ગુજરાતી');
    });

    test('only Arabic is right-to-left', () {
      expect(
        appLanguages.where((l) => l.rtl).map((l) => l.tag).toList(),
        ['ar'],
      );
    });
  });

  group('appLanguageForTag', () {
    test('reads stored tags in either separator', () {
      expect(appLanguageForTag('zh-Hans')?.tag, 'zh-Hans');
      expect(appLanguageForTag('zh_Hant')?.tag, 'zh-Hant');
      expect(appLanguageForTag('ht')?.tag, 'ht');
    });

    test('maps bare and regional Chinese to the right script', () {
      expect(appLanguageForTag('zh')?.tag, 'zh-Hans');
      expect(appLanguageForTag('zh-CN')?.tag, 'zh-Hans');
      expect(appLanguageForTag('zh-TW')?.tag, 'zh-Hant');
      expect(appLanguageForTag('zh-HK')?.tag, 'zh-Hant');
    });

    test('rejects languages that are not offered', () {
      expect(appLanguageForTag('ja'), isNull);
      expect(appLanguageForTag(''), isNull);
      expect(appLanguageForTag(null), isNull);
    });
  });

  group('LocaleController.resolveInitialLocale', () {
    test('picks first supported device language', () {
      expect(
        _resolve(const [Locale('ko', 'KR'), Locale('en', 'US')]).languageCode,
        'ko',
      );
    });

    test('follows the phone for the other offered languages', () {
      expect(_resolve(const [Locale('es', 'MX')]).languageCode, 'es');
      expect(_resolve(const [Locale('pt', 'BR')]).languageCode, 'pt');
      expect(_resolve(const [Locale('gu', 'IN')]).languageCode, 'gu');
      expect(_resolve(const [Locale('ht', 'HT')]).languageCode, 'ht');
      expect(_resolve(const [Locale('ar', 'EG')]).languageCode, 'ar');
    });

    test('Chinese follows script, then region', () {
      expect(
        _resolve([
          const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        ]).scriptCode,
        'Hant',
      );
      expect(_resolve(const [Locale('zh', 'TW')]).scriptCode, 'Hant');
      expect(_resolve(const [Locale('zh', 'CN')]).scriptCode, 'Hans');
      expect(_resolve(const [Locale('zh')]).scriptCode, 'Hans');
    });

    test('falls back to en when nothing matches', () {
      expect(
        _resolve(const [Locale('ja'), Locale('fr')]).languageCode,
        'en',
      );
    });
  });

  group('LocaleController.load', () {
    test('prefs win over device', () async {
      SharedPreferences.setMockInitialValues({'app_locale_code': 'ko'});
      final c = LocaleController();
      await c.load();
      expect(c.value.languageCode, 'ko');
    });

    test('a saved script language is restored', () async {
      SharedPreferences.setMockInitialValues({'app_locale_code': 'zh-Hant'});
      final c = LocaleController();
      await c.load();
      expect(c.value.languageCode, 'zh');
      expect(c.value.scriptCode, 'Hant');
    });

    test('setLocale stores the tag and survives a restart', () async {
      SharedPreferences.setMockInitialValues({});
      final first = LocaleController();
      await first.setLocale(
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      );
      final second = LocaleController();
      await second.load();
      expect(second.value.scriptCode, 'Hans');
      expect(await LocaleController.savedLanguageCode(), 'zh-Hans');
    });

    test('setLocale ignores a language that is not offered', () async {
      SharedPreferences.setMockInitialValues({});
      final c = LocaleController();
      await c.setLocale(const Locale('ja'));
      expect(c.value.languageCode, 'en');
      expect(await LocaleController.savedLanguageCode(), isNull);
    });

    test(
      'no prefs uses resolveInitialLocale path to a supported code',
      () async {
        SharedPreferences.setMockInitialValues({});
        final c = LocaleController();
        await c.load();
        expect(appLanguageForLocale(c.value), isNotNull);
      },
    );

    test('savedLanguageCode reads prefs', () async {
      SharedPreferences.setMockInitialValues({'app_locale_code': 'ko'});
      expect(await LocaleController.savedLanguageCode(), 'ko');
    });

    test('a saved language that is no longer offered is ignored', () async {
      SharedPreferences.setMockInitialValues({'app_locale_code': 'ja'});
      expect(await LocaleController.savedLanguageCode(), isNull);
    });
  });
}
