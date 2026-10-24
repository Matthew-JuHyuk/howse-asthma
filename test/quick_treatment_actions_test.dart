import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:howse_asthma/core/theme/app_theme.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:howse_asthma/features/covernote/data/preparation_repository.dart';
import 'package:howse_asthma/features/covernote/presentation/quick_treatment_actions.dart';
import 'package:howse_asthma/features/covernote/domain/preparation.dart';

class SlowQuickRepository extends PreparationRepository {
  SlowQuickRepository() : super(demo: true);
  final gate = Completer<void>();
  @override
  Future<bool> record(List<TreatmentEvent> events) async {
    await gate.future;
    return super.record(events);
  }
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    PreparationRepository.demoEvents.clear();
  });
  Widget app(
    PreparationRepository repo, {
    String? patient,
    String language = 'en',
  }) => MaterialApp(
    theme: AppTheme.light,
    locale: Locale(language),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: QuickTreatmentActions(
            repository: repo,
            patientKey: patient ?? repo.uid,
            patientName: 'Diego',
          ),
        ),
      ),
    ),
  );
  testWidgets(
    'one tap records selected patient without a case or invented dose, undo removes it',
    (tester) async {
      final repo = PreparationRepository(demo: true);
      await tester.pumpWidget(app(repo, patient: '${repo.uid}/child'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('quick-rescue')));
      await tester.pumpAndSettle();
      final event = PreparationRepository.demoEvents.single;
      expect(event.patientKey, '${repo.uid}/child');
      expect(event.values['use_kind'], 'as_needed');
      expect(event.values['medication'], isNull);
      expect(event.values['quantity'], isNull);
      expect(event.day, '2026-10-22');
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(PreparationRepository.demoEvents, isEmpty);
    },
  );
  testWidgets(
    'double taps do not duplicate and a later scheduled use asks before adding',
    (tester) async {
      final repo = SlowQuickRepository();
      await tester.pumpWidget(app(repo));
      await tester.pumpAndSettle();
      final button = find.byKey(const ValueKey('quick-scheduled'));
      await tester.tap(button);
      await tester.tap(button);
      repo.gate.complete();
      await tester.pumpAndSettle();
      expect(PreparationRepository.demoEvents, hasLength(1));
      await tester.tap(button);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(PreparationRepository.demoEvents, hasLength(1));
    },
  );
  for (final lang in ['en', 'ko', 'es']) {
    testWidgets('quick buttons stay separate at 320dp and 200% text ($lang)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 740);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(
        app(PreparationRepository(demo: true), language: lang),
      );
      await tester.pumpAndSettle();
      final a = find.byKey(const ValueKey('quick-scheduled'));
      final b = find.byKey(const ValueKey('quick-rescue'));
      expect(
        tester.getTopLeft(b).dy - tester.getBottomLeft(a).dy,
        greaterThanOrEqualTo(16),
      );
      expect(tester.takeException(), isNull);
    });
  }
}
