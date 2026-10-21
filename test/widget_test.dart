import 'package:flutter/material.dart';
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
    for (final tab in [l.cnTabCases, l.cnTabRecords, l.cnTabAccount]) {
      await tester.tap(find.text(tab));
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }
    expect(tester.takeException(), isNull);
  });
}
