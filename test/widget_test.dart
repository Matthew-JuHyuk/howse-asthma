import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:howse_asthma/app.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';

void main() {
  testWidgets(
    'Home shows the brand, Scan a letter and the demo before sign-in',
    (tester) async {
      dotenv.loadFromString(isOptional: true);
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
}
