import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:howse_asthma/app.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';

void main() {
  testWidgets('App boots and renders the sign-in flow', (WidgetTester tester) async {
    dotenv.loadFromString(isOptional: true);
    await tester.pumpWidget(const HowseAsthmaApp());
    await tester.pumpAndSettle();

    final appLocalizations = AppLocalizations.of(
      tester.element(find.byType(Scaffold).first),
    )!;

    // Regardless of whether Supabase has been configured yet, the app
    // title should be visible somewhere on the initial screen.
    expect(find.text(appLocalizations.appTitle), findsWidgets);
  });
}
