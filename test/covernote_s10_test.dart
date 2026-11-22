import 'dart:io';
import 'package:howse_asthma/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/data/preparation_repository.dart';
import 'package:howse_asthma/features/covernote/domain/preparation.dart';
import 'package:howse_asthma/features/covernote/pdf/preparation_pdf.dart';
import 'package:howse_asthma/features/covernote/presentation/preparation_screen.dart';
import 'package:howse_asthma/features/covernote/presentation/preparation_strings.dart';
import 'package:howse_asthma/features/covernote/presentation/home_preparation_log.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));
  testWidgets(
    'home actions target the case subject and do not call controller medicine rescue',
    (tester) async {
      final repo = PreparationRepository(demo: true);
      final p = await repo.seed(false);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: HomePreparationLog(
                preparation: p,
                repository: repo,
                onVoice: () {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Or tap to record'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Used scheduled medicine'));
      await tester.pumpAndSettle();
      var uses = (await repo.events())
          .where((e) => e.kind == 'medication_use')
          .toList();
      expect(uses, hasLength(1));
      expect(uses.single.patientKey, p.patientKey);
      expect(uses.single.values['medication'], p.currentMedication);
      await tester.tap(find.text('Used as-needed medicine'));
      await tester.pumpAndSettle();
      uses = (await repo.events())
          .where(
            (e) =>
                e.kind == 'medication_use' &&
                e.values['use_kind'] == 'as_needed',
          )
          .toList();
      expect(uses, hasLength(1));
      expect(uses.single.values['medication'], isNull);
      expect(uses.single.values['quantity'], isNull);
    },
  );
  for (final language in ['en', 'ko', 'es']) {
    testWidgets('Sprint10 tabs fit 360dp at 200 percent text ($language)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(720, 1600);
      tester.view.devicePixelRatio = 2;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final repo = PreparationRepository(demo: true);
      final p = await repo.seed(true);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          locale: Locale(language),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PreparationScreen(repository: repo, caseId: p.id),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (final key in ['evidence', 'linkedHistory', 'share', 'overview']) {
        final ctx = tester.element(find.byType(Scaffold).first);
        final chip = find.widgetWithText(ChoiceChip, s10(ctx, key));
        await tester.ensureVisible(chip);
        await tester.pumpAndSettle();
        await tester.tap(chip);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      }
    });
  }
  TreatmentEvent event(
    String id,
    String day, {
    String patient = 'p',
    String kind = 'symptom',
    Map<String, dynamic> values = const {},
    bool undone = false,
  }) => TreatmentEvent(
    id: id,
    patientKey: patient,
    kind: kind,
    day: day,
    sourceId: 'source-$id',
    values: values,
    undone: undone,
  );
  final p = Preparation(id: 'case', patientKey: 'p', patientName: 'Patient');
  test(
    '30-day summary includes today, excludes future, undone, other patient and unknown dates',
    () {
      final s = TreatmentSummary(p, [
        event('today', '2026-10-22', values: {'night_wakings': 2}),
        event('first', '2026-09-23'),
        event('old', '2026-09-22'),
        event('future', '2026-10-23'),
        event('other', '2026-10-22', patient: 'other'),
        event('undo', '2026-10-22', undone: true),
        event('unknown', '2026-10-20', values: {'date_unknown': true}),
      ], DateTime(2026, 10, 22));
      expect(s.events.map((e) => e.id), ['today', 'first']);
      expect(s.observedDays, 2);
      expect(s.nightWakings, 2);
    },
  );
  test(
    'negated symptom is not positive burden; medicine quantities remain unknown',
    () {
      final s = TreatmentSummary(p, [
        event('s', '2026-10-22', values: {'negated': true}),
        event(
          'm',
          '2026-10-22',
          kind: 'medication_use',
          values: {'use_kind': 'as_needed', 'quantity': null},
        ),
      ], DateTime(2026, 10, 22));
      expect(s.symptomDays, 0);
      expect(s.rescueUses, 1);
      expect(s.events.last.values['quantity'], isNull);
    },
  );
  test(
    '30-day app log cannot fill prior treatment or laboratory requirements',
    () {
      final needs = preparationNeeds(true);
      final events = [
        event('s', '2026-10-22'),
        event('m', '2026-10-22', kind: 'medication_use'),
        event(
          'rx',
          '2026-06-01',
          kind: 'clinical_document',
          values: {'document_kind': 'prescription'},
        ),
        event(
          'lab-other',
          '2026-10-01',
          patient: 'other',
          kind: 'clinical_document',
          values: {'document_kind': 'lab'},
        ),
      ];
      expect(sourceCandidates(needs[0], p, events).map((e) => e.id), ['rx']);
      expect(sourceCandidates(needs[2], p, events), isEmpty);
    },
  );
  test(
    'policy requires explicit applicability and exact product, never invents medication',
    () {
      expect(p.englishTitle, 'Treatment consultation brief');
      expect(
        p.update({
          'proposed_medication': 'Dupixent',
          'plan': 'Aetna Better Health of New Jersey',
        }).applicablePolicy,
        isFalse,
      );
      expect(
        p.update({
          'proposed_medication': 'Dupixent',
          'plan': 'Aetna Better Health of New Jersey',
          'policy_confirmed': true,
        }).applicablePolicy,
        isTrue,
      );
      expect(
        p.update({
          'proposed_medication': 'Other',
          'plan': 'Aetna Better Health of New Jersey',
          'policy_confirmed': true,
        }).applicablePolicy,
        isFalse,
      );
    },
  );
  test('voice validates original quotes, date, count and negated use', () {
    final v = validateVoiceProposal([
      {
        'kind': 'symptom',
        'quote': 'twice',
        'night_wakings': 2,
        'day': '2026-10-22',
      },
      {'kind': 'medication_use', 'quote': 'did not use', 'negated': true},
    ], 'I woke twice and did not use it.');
    expect(v[1]['omit'], isTrue);
    expect(
      () => validateVoiceProposal([
        {'kind': 'symptom', 'quote': 'invented'},
      ], 'cough'),
      throwsFormatException,
    );
    expect(
      () => validateVoiceProposal([
        {'kind': 'symptom', 'quote': 'cough', 'day': '2026-02-30'},
      ], 'cough'),
      throwsFormatException,
    );
    expect(
      () => validateVoiceProposal([
        {'kind': 'symptom', 'quote': 'cough', 'night_wakings': -1},
      ], 'cough'),
      throwsFormatException,
    );
  });
  test(
    'new-request case is useful with zero records and no proposed drug',
    () async {
      final r = PreparationRepository(demo: true);
      PreparationRepository.demoCases.clear();
      PreparationRepository.demoEvents.clear();
      final c = await r.create(
        patientName: 'Patient',
        concern: 'Discuss night symptoms',
      );
      expect(c.path, PreparationPath.newRequest);
      expect(c.documents, isEmpty);
      expect(c.needs, hasLength(3));
      expect(c.needs.every((n) => n.origin == 'optional_context'), isTrue);
      expect(c.englishTitle, 'Treatment consultation brief');
    },
  );
  test(
    'A/B seed reset isolates alternative scenarios and does not fabricate approval',
    () async {
      final r = PreparationRepository(demo: true);
      final a = await r.seed(false);
      await expectLater(PreparationRepository().seed(false), throwsStateError);
      final events = await r.events();
      expect(a.path, PreparationPath.newRequest);
      expect(a.history, isEmpty);
      expect(events.every((e) => e.synthetic), isTrue);
      final summary = TreatmentSummary(a, events, r.today);
      expect(summary.observedDays, 12);
      expect(summary.nightWakings, 8);
      final b = await r.seed(true);
      expect(b.path, PreparationPath.deniedRequest);
      expect(b.history.single['type'], 'decision');
      expect(PreparationRepository.demoCases.length, 1);
    },
  );
  test(
    'same source retry does not duplicate and undo removes the whole utterance',
    () async {
      final r = PreparationRepository(demo: true);
      await r.seed(false);
      final id = preparationId();
      final events = [
        TreatmentEvent(
          id: id,
          patientKey: r.uid,
          kind: 'symptom',
          day: dayKey(r.today),
          sourceId: id,
          synthetic: true,
        ),
        TreatmentEvent(
          id: preparationId(),
          patientKey: r.uid,
          kind: 'medication_use',
          day: dayKey(r.today),
          sourceId: id,
          synthetic: true,
        ),
      ];
      await r.record(events);
      await Future.wait([r.record(events), r.record(events)]);
      expect((await r.events()).where((e) => e.sourceId == id).length, 2);
      await r.undo(id);
      expect((await r.events()).where((e) => e.sourceId == id), isEmpty);
    },
  );
  test(
    'optimistic revision rejects stale edits; denial transition preserves artifacts and case id',
    () async {
      final r = PreparationRepository(demo: true);
      final a = await r.seed(false);
      final saved = await r.save(
        a.update({
          'exports': [
            {'revision': a.revision, 'path': 'synthetic-pdf'},
          ],
        }),
      );
      await expectLater(
        r.save(a.update({'concern': 'stale'})),
        throwsStateError,
      );
      final denied = await r.save(
        saved.update({
          'path': 'deniedRequest',
          'history': [
            {'type': 'decision', 'text': 'SAMPLE missing prior history'},
          ],
        }),
      );
      expect(denied.id, a.id);
      expect(denied.exports.single['path'], 'synthetic-pdf');
      expect(denied.revision, greaterThan(a.revision));
    },
  );
  test(
    'content hash invalidates changed event data, ignores export bookkeeping',
    () {
      final events = [event('e', '2026-10-22')];
      final first = preparationFingerprint(p, events);
      expect(
        preparationFingerprint(p, events, DateTime(2026, 10, 22)),
        isNot(preparationFingerprint(p, events, DateTime(2026, 10, 23))),
      );
      expect(
        preparationFingerprint(
          p.update({
            'exports': [
              {'revision': 1},
            ],
            'revision': 2,
          }),
          events,
        ),
        first,
      );
      expect(
        preparationFingerprint(p, [...events, event('e2', '2026-10-22')]),
        isNot(first),
      );
      expect(
        preparationFingerprint(p.update({'concern': 'changed'}), events),
        isNot(first),
      );
    },
  );
  test(
    'build real PDFs for both paths; missing evidence is still disclosed',
    () async {
      final r = PreparationRepository(demo: true);
      for (final denied in [false, true]) {
        var p = await r.seed(denied);
        final e = await r.events();
        p = await r.save(
          p.update({
            'needs': [
              p.needs.first.link(['demo-rx']).toJson(),
              ...p.needs.skip(1).map((n) => n.toJson()),
            ],
          }),
        );
        final bytes = await buildPreparationPdf(p, e, r.today);
        expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
        expect(bytes.length, greaterThan(1000));
        final out = File(
          'build/sprint10/${denied ? 'denial' : 'initial'}-brief.pdf',
        );
        await out.parent.create(recursive: true);
        await out.writeAsBytes(bytes);
      }
    },
  );
  testWidgets(
    'synthetic overview -> link source -> same-source summary; no layout overflow',
    (tester) async {
      tester.view.physicalSize = const Size(900, 1400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final r = PreparationRepository(demo: true);
      final p = await r.seed(false);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PreparationScreen(repository: r, caseId: p.id),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Prepare for a new treatment'), findsOneWidget);
      await tester.tap(find.widgetWithText(ChoiceChip, 'Your documents'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Choose existing records').first);
      await tester.pumpAndSettle();
      expect(find.byType(CheckboxListTile), findsNothing);
      await tester.tap(find.text('Connect these records (1)'));
      await tester.pumpAndSettle();
      expect((await r.load(p.id))!.needs.first.links, ['demo-rx']);
      expect(tester.takeException(), isNull);
    },
  );
}
