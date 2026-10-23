import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:howse_asthma/app.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:howse_asthma/features/covernote/presentation/preparation_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Home shows both preparation paths and the demo before sign-in', (
    tester,
  ) async {
    dotenv.loadFromString(isOptional: true);
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const CoverNoteApp());
    await tester.pump();

    final l = AppLocalizations.of(tester.element(find.byType(Scaffold).first))!;
    expect(find.text(l.appTitle), findsWidgets);
    final ctx = tester.element(find.byType(Scaffold).first);
    expect(find.text(s10(ctx, 'start')), findsOneWidget);
    expect(find.text(s10(ctx, 'denied')), findsOneWidget);
    expect(find.text(l.cnTryDemo), findsOneWidget);
    expect(find.text(l.cnTabCases), findsOneWidget);
    expect(find.text(l.cnTabRecords), findsOneWidget);
  });

  testWidgets('Korean home and tabs render on a small phone', (tester) async {
    dotenv.loadFromString(isOptional: true);
    SharedPreferences.setMockInitialValues({'app_locale_code': 'ko'});
    tester.view.physicalSize = const Size(720, 1280);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const CoverNoteApp());
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    final l = AppLocalizations.of(tester.element(find.byType(Scaffold).first))!;
    expect(l.localeName, 'ko');
    final ctx = tester.element(find.byType(Scaffold).first);
    expect(find.text(s10(ctx, 'start')), findsOneWidget);
    expect(tester.getRect(find.text(s10(ctx, 'start'))).bottom, lessThan(560));
    for (final tab in [l.cnTabCases, l.cnTabRecords, l.cnTabSettings]) {
      await tester.tap(find.text(tab));
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }
    expect(tester.takeException(), isNull);
  });

  for (final code in [
    'en',
    'ko',
    'es',
    'pt',
    'gu',
    'zh-Hans',
    'zh-Hant',
    'ht',
    'ar',
  ]) {
    testWidgets('360 dp wide at 200% text: home, demo list, review ($code)', (
      tester,
    ) async {
      dotenv.loadFromString(isOptional: true);
      SharedPreferences.setMockInitialValues({'app_locale_code': code});
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      // The test font draws every glyph as a full square, which doubles Latin
      // line widths. Use the bundled Noto Sans so wrapping is realistic.
      await tester.runAsync(() async {
        ByteData read(String f) =>
            ByteData.sublistView(File('assets/fonts/$f').readAsBytesSync());
        await (FontLoader('Roboto')
              ..addFont(Future.value(read('NotoSans-Regular.ttf')))
              ..addFont(Future.value(read('NotoSans-Bold.ttf'))))
            .load();
      });

      Future<void> settle([int frames = 8]) async {
        for (var i = 0; i < frames; i++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
      }

      await tester.pumpWidget(const CoverNoteApp());
      await settle();
      final l = AppLocalizations.of(
        tester.element(find.byType(Scaffold).first),
      )!;
      expect(tester.takeException(), isNull);
      final list = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text(s10(tester.element(find.byType(Scaffold).first), 'start')),
        200,
        scrollable: list,
      );
      expect(tester.takeException(), isNull);

      await tester.scrollUntilVisible(
        find.text(l.cnTryDemo),
        200,
        scrollable: list,
      );
      await tester.ensureVisible(find.text(l.cnTryDemo));
      await settle(3);
      await tester.tap(find.text(l.cnTryDemo));
      await settle();
      expect(tester.takeException(), isNull);

      await tester.ensureVisible(
        find.textContaining('DemoController A 100 mcg'),
      );
      await settle(3);
      await tester.tap(find.textContaining('DemoController A 100 mcg'));
      await settle();
      await tester.scrollUntilVisible(
        find.text(l.cnCorrectReading),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(find.text(l.cnCorrectReading));
      await settle(3);
      await tester.tap(find.text(l.cnCorrectReading));
      await settle();
      // Longer languages push the card below the first screenful.
      await tester.scrollUntilVisible(
        find.text(l.cnCardWhyDenied),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text(l.cnCardWhyDenied), findsOneWidget);
      expect(tester.takeException(), isNull);
      if (code != 'en') {
        // The model's English reason is replaced by the fixed translation.
        final explained = [
          l.cnReasonMissingInformation,
          l.cnReasonStepTherapy,
          l.cnReasonMedicalNecessity,
          l.cnReasonFormulary,
          l.cnReasonQuantityLimit,
          l.cnReasonEligibility,
          l.cnReasonOther,
        ];
        expect(
          explained.any((s) => find.text(s).evaluate().isNotEmpty),
          isTrue,
          reason: 'a translated reason should be on the review screen',
        );
      }
    });
  }
}
