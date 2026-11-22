import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:howse_asthma/core/theme/app_theme.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:howse_asthma/features/covernote/data/preparation_repository.dart';
import 'package:howse_asthma/features/covernote/presentation/quick_treatment_actions.dart';
import 'package:howse_asthma/features/covernote/domain/preparation.dart';
import 'package:howse_asthma/features/covernote/domain/quick_medication.dart';
import 'package:howse_asthma/features/covernote/presentation/treatment_record_summary.dart';

class RegisteredQuickRepository extends PreparationRepository {
  RegisteredQuickRepository() : super(demo: true);
  @override
  Future<List<QuickMedication>> quickMedications(String patient) async =>
      const [
        QuickMedication(
          id: 'controller',
          name: 'Budesonide/formoterol 160/4.5 mcg',
          role: 'controller',
          puffs: 2,
          regimenId: 'controller-regimen',
        ),
        QuickMedication(
          id: 'rescue',
          name: 'Albuterol 90 mcg',
          role: 'rescue',
          puffs: 2,
          regimenId: 'rescue-regimen',
        ),
      ];
}

class SlowQuickRepository extends RegisteredQuickRepository {
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
    'one tap records the visible registered medicine and amount, undo removes it',
    (tester) async {
      final repo = RegisteredQuickRepository();
      await tester.pumpWidget(app(repo, patient: '${repo.uid}/child'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Albuterol 90 mcg · 2 puffs'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('quick-rescue')));
      await tester.pumpAndSettle();
      final event = PreparationRepository.demoEvents.single;
      expect(event.patientKey, '${repo.uid}/child');
      expect(event.values['use_kind'], 'as_needed');
      expect(event.values['medication'], 'Albuterol 90 mcg');
      expect(event.values['medication_id'], 'rescue');
      expect(event.values['quantity'], 2);
      expect(event.values['regimen_id'], 'rescue-regimen');
      final ctx = tester.element(find.byType(QuickTreatmentActions));
      expect(treatmentRecordSummary(ctx, event), 'Albuterol 90 mcg · 2 puffs');
      final sample = TreatmentEvent.fromJson({
        ...event.toJson(),
        'synthetic': true,
        'values': {
          'medication': 'Albuterol 90 mcg',
          'quantity': 2,
          'unit': 'puffs',
          'use_kind': 'as_needed',
        },
      });
      expect(
        treatmentRecordSummary(ctx, sample),
        treatmentRecordSummary(ctx, event),
      );
      expect(event.day, '2026-10-22');
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(PreparationRepository.demoEvents, isEmpty);
    },
  );
  testWidgets('action snackbar auto-dismisses after four seconds', (
    tester,
  ) async {
    await tester.pumpWidget(app(RegisteredQuickRepository()));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('quick-rescue')));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.byType(SnackBar), findsNothing);
    expect(PreparationRepository.demoEvents, hasLength(1));
  });
  testWidgets(
    'no registered medicine asks to register instead of writing an unknown medicine',
    (tester) async {
      await tester.pumpWidget(app(PreparationRepository(demo: true)));
      await tester.pumpAndSettle();
      expect(find.text('Add my medicine'), findsOneWidget);
      expect(find.byKey(const ValueKey('quick-rescue')), findsNothing);
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
      await tester.pumpWidget(app(RegisteredQuickRepository(), language: lang));
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
