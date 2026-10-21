import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:howse_asthma/app.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets(
    'Home shows the brand, Scan a letter and the demo before sign-in',
    (tester) async {
      dotenv.loadFromString(isOptional: true);
      SharedPreferences.setMockInitialValues({});
      await tester.pumpWidget(const CoverNoteApp());
      await tester.pump();

      final l = AppLocalizations.of(
        tester.element(find.byType(Scaffold).first),
      )!;
      expect(find.text(l.appTitle), findsWidgets);
      expect(find.text(l.cnScanLetter), findsOneWidget);
      expect(find.text(l.cnUploadFile), findsOneWidget);
      expect(find.text(l.cnTryDemo), findsOneWidget);
      expect(find.text(l.cnTabCases), findsOneWidget);
      expect(find.text(l.cnTabRecords), findsOneWidget);
    },
  );

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
    expect(find.text(l.cnScanLetter), findsOneWidget);
    expect(tester.getRect(find.text(l.cnScanLetter)).bottom, lessThan(560));
    for (final tab in [l.cnTabCases, l.cnTabRecords, l.cnTabAccount]) {
      await tester.tap(find.text(tab));
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }
    expect(tester.takeException(), isNull);
  });

  for (final code in ['en', 'ko']) {
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
        find.text(l.cnScanLetter),
        200,
        scrollable: list,
      );
      expect(tester.takeException(), isNull);

      await tester.scrollUntilVisible(
        find.text(l.cnTryDemo),
        200,
        scrollable: list,
      );
      await tester.tap(find.text(l.cnTryDemo));
      await settle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('DemoController A 100 mcg'));
      await settle();
      expect(find.text(l.cnCardWhyDenied), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
