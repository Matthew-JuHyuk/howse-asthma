import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/core/locale/fallback_localizations.dart';
import 'package:howse_asthma/core/locale/language_picker.dart';
import 'package:howse_asthma/core/locale/locale_controller.dart';
import 'package:howse_asthma/features/covernote/presentation/case_labels.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:shared_preferences/shared_preferences.dart';

Widget _app({
  required LocaleController controller,
  required Widget Function(BuildContext) body,
}) {
  return AppLocaleScope(
    controller: controller,
    child: ValueListenableBuilder<Locale>(
      valueListenable: controller,
      builder: (context, locale, _) => MaterialApp(
        locale: locale,
        supportedLocales: appSupportedLocales,
        localizationsDelegates: [
          AppLocalizations.delegate,
          ...frameworkLocalizationDelegates,
        ],
        home: Scaffold(body: Builder(builder: body)),
      ),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  final english = lookupAppLocalizations(const Locale('en'));

  for (final language in appLanguages) {
    group('language ${language.tag}', () {
      testWidgets('loads strings, plurals and dates without errors', (
        tester,
      ) async {
        final controller = LocaleController();
        await controller.setLocale(language.locale);
        late AppLocalizations l;
        late String day;
        late TextDirection direction;
        await tester.pumpWidget(
          _app(
            controller: controller,
            body: (context) {
              l = AppLocalizations.of(context)!;
              day = formatDay(context, DateTime(2026, 11, 14));
              direction = Directionality.of(context);
              return Text(l.cnLanguageChoose);
            },
          ),
        );
        expect(tester.takeException(), isNull);
        expect(direction, language.rtl ? TextDirection.rtl : TextDirection.ltr);
        expect(day, contains('14'));
        expect(day, contains('2026'));

        if (language.tag != 'en') {
          expect(l.cnLanguageChoose, isNot(english.cnLanguageChoose));
          expect(l.cnReasonStepTherapy, isNot(english.cnReasonStepTherapy));
          expect(l.cnShareDocuments, isNot(english.cnShareDocuments));
          expect(l.cnTabSettings, isNot(english.cnTabSettings));
          expect(l.cnAirWeather, isNot(english.cnAirWeather));
          expect(l.cnKeyDetails, isNot(english.cnKeyDetails));
          expect(l.cnMyMedications, isNot(english.cnMyMedications));
        }
        expect(l.appTitle, 'CoverNote');

        for (final n in [0, 1, 2, 3, 11, 100]) {
          final lines = [
            l.cnNextFactsToConfirm(n),
            l.cnItemsLeftToCheck(n),
            l.cnNextDenial(n),
            l.cnNextInfoRequest(n),
            l.cnPacketEvidenceCount(n),
            l.cnLetterPagesRead(n),
            l.cnReportsLine(n),
          ];
          for (final s in lines) {
            expect(s.trim(), isNotEmpty, reason: '${language.tag} n=$n');
          }
          if (n >= 11) {
            // Large counts always print the number.
            expect(l.cnNextFactsToConfirm(n), contains('$n'));
          }
        }
      });

      testWidgets('reason codes have their own explanation', (tester) async {
        final controller = LocaleController();
        await controller.setLocale(language.locale);
        late AppLocalizations l;
        await tester.pumpWidget(
          _app(
            controller: controller,
            body: (context) {
              l = AppLocalizations.of(context)!;
              return const SizedBox();
            },
          ),
        );
        final texts = <String>{};
        for (final code in const [
          'missing_information',
          'step_therapy',
          'medical_necessity',
          'formulary',
          'quantity_limit',
          'eligibility_or_benefit',
          'other',
        ]) {
          texts.add(reasonExplanation(l, code));
        }
        expect(texts.length, 7, reason: 'each code must read differently');
      });
    });
  }

  test('dates format for every offered language', () {
    for (final language in appLanguages) {
      final name = intlLocaleFor(language.locale);
      // initializeDateFormatting is done by Material in the app; here the
      // check is that the mapped name is one intl accepts.
      expect(
        () => DateFormat.yMMMd(name),
        returnsNormally,
        reason: language.tag,
      );
    }
  });

  test('framework fallbacks cover Haitian Creole with French', () {
    expect(frameworkFallbackFor(const Locale('ht')).languageCode, 'fr');
    expect(frameworkFallbackFor(const Locale('gu')).languageCode, 'en');
  });

  group('language picker', () {
    testWidgets('lists every language in its own script and switches', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(360 * 3, 740 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final controller = LocaleController();
      await tester.pumpWidget(
        _app(controller: controller, body: (_) => const LanguageButton()),
      );
      await tester.tap(find.byType(LanguageButton));
      await tester.pumpAndSettle();
      for (final language in appLanguages) {
        expect(find.text(language.nativeName), findsWidgets);
      }
      await tester.tap(find.text('العربية'));
      await tester.pumpAndSettle();
      expect(controller.value.languageCode, 'ar');
      expect(tester.takeException(), isNull);
      // The button now shows the new language, in that language.
      expect(find.text('العربية'), findsOneWidget);
      final context = tester.element(find.byType(LanguageButton));
      expect(Directionality.of(context), TextDirection.rtl);
    });

    testWidgets('stays usable at 200% text size', (tester) async {
      tester.view.physicalSize = const Size(360 * 3, 640 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final controller = LocaleController();
      await controller.setLocale(
        const Locale.fromSubtags(languageCode: 'gu'),
      );
      await tester.pumpWidget(
        _app(
          controller: controller,
          body: (context) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: const Center(child: LanguageButton()),
          ),
        ),
      );
      await tester.tap(find.byType(LanguageButton));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Kreyòl ayisyen'), findsWidgets);
    });
  });

  group('requirement hints', () {
    test('map common labels, leave unknown ones alone', () {
      final l = lookupAppLocalizations(const Locale('es'));
      expect(requirementHint(l, 'Medication history'), l.cnReqHintMedHistory);
      expect(requirementHint(l, 'Recent visit notes'), l.cnReqHintVisitNotes);
      expect(requirementHint(l, 'Lab results'), l.cnReqHintTestResults);
      expect(
        requirementHint(l, 'Letter of medical necessity'),
        l.cnReqHintDoctorStatement,
      );
      expect(requirementHint(l, 'Signed consent form'), isNull);
      expect(requirementHint(l, 'Label on the box'), isNull);
    });
  });
}
