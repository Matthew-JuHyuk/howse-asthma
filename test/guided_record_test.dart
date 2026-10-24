import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:howse_asthma/core/theme/app_theme.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:howse_asthma/features/covernote/data/preparation_repository.dart';
import 'package:howse_asthma/features/covernote/presentation/guided_record_screen.dart';
import 'package:howse_asthma/features/covernote/presentation/record_navigation_bar.dart';

class RecordTestRepository extends PreparationRepository {
  RecordTestRepository() : super(demo: true);
  bool fail = false;
  Map<String, dynamic>? submitted;
  @override
  Future<Map> analyze({
    required String action,
    required Map<String, dynamic> input,
  }) async {
    submitted = input;
    if (fail) throw StateError('offline');
    return {
      'events': [
        {
          'kind': 'symptom',
          'quote': input['transcript'],
          'day': '2026-10-22',
          'subject': 'selected_patient',
          'symptom': 'cough',
        },
      ],
    };
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    PreparationRepository.demoEvents.clear();
  });
  Widget app(Widget screen, {String language = 'en'}) => MaterialApp(
    theme: AppTheme.light,
    locale: Locale(language),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: screen,
  );
  testWidgets('center action opens capture without changing tab', (
    tester,
  ) async {
    int? destination;
    var records = 0;
    await tester.pumpWidget(
      app(
        Scaffold(
          bottomNavigationBar: RecordNavigationBar(
            selectedIndex: 1,
            onDestination: (v) => destination = v,
            onRecord: () => records++,
          ),
        ),
      ),
    );
    await tester.tap(find.byIcon(Icons.mic_rounded));
    expect(records, 1);
    expect(destination, isNull);
    expect(
      tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
      1,
    );
  });
  testWidgets(
    'opening does not listen; typing works without a case and saves only after review',
    (tester) async {
      final repo = RecordTestRepository();
      var listens = 0;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        PreparationRepository.native,
        (call) async {
          if (call.method == 'listen') listens++;
          return '';
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          PreparationRepository.native,
          null,
        ),
      );
      await tester.pumpWidget(
        app(
          Builder(
            builder: (c) => Scaffold(
              body: TextButton(
                onPressed: () => Navigator.push<void>(
                  c,
                  MaterialPageRoute(
                    builder: (_) => GuidedRecordScreen(
                      repository: repo,
                      profiles: {repo.uid: 'Diego'},
                    ),
                  ),
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(listens, 0);
      expect(
        find.text('How are you feeling? What medicine did you use?'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.text('I prefer to type'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('I prefer to type'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'I coughed last night.');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Review before saving'));
      await tester.pumpAndSettle();
      expect(repo.submitted!['patient_key'], repo.uid);
      expect(repo.submitted!.containsKey('case_id'), isFalse);
      expect(PreparationRepository.demoEvents, isEmpty);
      await tester.tap(find.text('Confirm and save (1)'));
      await tester.pumpAndSettle();
      expect(PreparationRepository.demoEvents, hasLength(1));
      expect(PreparationRepository.demoEvents.single.patientKey, repo.uid);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('processing failure preserves typed text for retry', (
    tester,
  ) async {
    final repo = RecordTestRepository()..fail = true;
    await tester.pumpWidget(
      app(
        GuidedRecordScreen(
          repository: repo,
          profiles: {repo.uid: 'Diego'},
          initiallyTyped: true,
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byType(TextField),
      200,
      scrollable: find
          .descendant(
            of: find.byType(ListView),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.enterText(find.byType(TextField), 'I coughed last night.');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Review before saving'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'I coughed last night.',
    );
    expect(PreparationRepository.demoEvents, isEmpty);
    expect(tester.takeException(), isNull);
  });
  testWidgets(
    'speech uses a regional locale and fills editable text without topic selection',
    (tester) async {
      final repo = RecordTestRepository();
      String? language;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        PreparationRepository.native,
        (call) async {
          if (call.method == 'listen') {
            language = call.arguments['language'];
            return 'I used my inhaler and coughed.';
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          PreparationRepository.native,
          null,
        ),
      );
      await tester.pumpWidget(
        app(
          GuidedRecordScreen(repository: repo, profiles: {repo.uid: 'Diego'}),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ChoiceChip), findsNothing);
      await tester.ensureVisible(find.text('Start speaking'));
      await tester.tap(find.text('Start speaking'));
      await tester.pumpAndSettle();
      expect(language, 'en-US');
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'I used my inhaler and coughed.',
      );
      expect(PreparationRepository.demoEvents, isEmpty);
    },
  );
  for (final code in [
    'permission_denied',
    'recognition_2',
    'unsupported',
    'cancelled',
  ]) {
    testWidgets('speech $code preserves text and offers a usable alternative', (
      tester,
    ) async {
      final repo = RecordTestRepository();
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        PreparationRepository.native,
        (call) async {
          if (call.method == 'listen') throw PlatformException(code: code);
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          PreparationRepository.native,
          null,
        ),
      );
      await tester.pumpWidget(
        app(
          GuidedRecordScreen(
            repository: repo,
            profiles: {repo.uid: 'Diego'},
            initiallyTyped: true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Keep my words');
      await tester.ensureVisible(find.text('Start speaking'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Start speaking'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'Keep my words',
      );
      expect(tester.widget<TextField>(find.byType(TextField)).enabled, isTrue);
      if (code == 'permission_denied') {
        expect(find.text('Open app settings'), findsOneWidget);
      }
      if (code == 'recognition_2') {
        expect(find.textContaining('could not connect'), findsOneWidget);
      }
      if (code == 'unsupported') {
        expect(
          find.textContaining('unavailable on this device'),
          findsOneWidget,
        );
      }
      expect(PreparationRepository.demoEvents, isEmpty);
      expect(tester.takeException(), isNull);
    });
  }
  for (final language in ['en', 'ko', 'es']) {
    testWidgets(
      'guided capture fits small screen with enlarged text ($language)',
      (tester) async {
        tester.view.physicalSize = const Size(320, 740);
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 2;
        addTearDown(tester.view.reset);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        final repo = RecordTestRepository();
        await tester.pumpWidget(
          app(
            GuidedRecordScreen(
              repository: repo,
              profiles: {repo.uid: 'Diego'},
              initiallyTyped: true,
            ),
            language: language,
          ),
        );
        await tester.pumpAndSettle();
        await tester.scrollUntilVisible(
          find.byType(TextField),
          200,
          scrollable: find
              .descendant(
                of: find.byType(ListView),
                matching: find.byType(Scrollable),
              )
              .first,
        );
        await tester.enterText(find.byType(TextField), 'My record');
        await tester.pump();
        tester.view.viewInsets = const FakeViewPadding(bottom: 240);
        await tester.pumpAndSettle();
        expect(
          tester
              .getBottomRight(
                find.widgetWithIcon(FilledButton, Icons.check_circle_outline),
              )
              .dy,
          lessThanOrEqualTo(500),
        );
        expect(tester.takeException(), isNull);
      },
    );
  }
}
