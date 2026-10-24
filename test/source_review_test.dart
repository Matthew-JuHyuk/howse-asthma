import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/core/theme/app_theme.dart';
import 'package:howse_asthma/features/covernote/domain/preparation.dart';
import 'package:howse_asthma/features/covernote/presentation/source_review_screen.dart';
import 'package:howse_asthma/features/covernote/ui/app_chrome.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';

void main() {
  final events = List.generate(
    2000,
    (i) => TreatmentEvent(
      id: 'internal-key-$i',
      patientKey: 'child',
      kind: 'symptom',
      day: '2026-10-22',
      sourceId: 'source-key-$i',
      text:
          'SAMPLE: Night cough noted by the caregiver. No medicine dose reported.',
    ),
  );
  for (final language in ['en', 'ko', 'es']) {
    testWidgets(
      '2000 records stay lazy, selectable in a batch, and above OS buttons ($language)',
      (tester) async {
        tester.view.physicalSize = const Size(360, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        List<String>? selected;
        final boundary = GlobalKey();
        await tester.pumpWidget(
          MaterialApp(
            theme: AppTheme.light,
            locale: Locale(language),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (c, child) => MediaQuery(
              data: MediaQuery.of(c).copyWith(
                padding: const EdgeInsets.only(bottom: 48),
                viewPadding: const EdgeInsets.only(bottom: 48),
                textScaler: const TextScaler.linear(2),
              ),
              child: RepaintBoundary(key: boundary, child: child!),
            ),
            home: Builder(
              builder: (c) => Scaffold(
                body: Center(
                  child: FilledButton(
                    onPressed: () async {
                      selected = await Navigator.push<List<String>>(
                        c,
                        MaterialPageRoute(
                          builder: (_) => SourceReviewScreen(
                            title: 'Symptoms',
                            patient: 'Diego · SAMPLE',
                            events: events,
                            linked: const [],
                            suggestAll: true,
                          ),
                        ),
                      );
                    },
                    child: const Text('Open'),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('Open'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byType(Card).evaluate().length, lessThan(20));
        expect(find.byType(Checkbox), findsNothing);
        expect(find.textContaining('internal-key-'), findsNothing);
        final confirm = find.widgetWithIcon(FilledButton, Icons.check);
        expect(tester.getBottomRight(confirm).dy, lessThanOrEqualTo(752));
        if (language == 'ko') {
          await tester.runAsync(() async {
            final image =
                await (boundary.currentContext!.findRenderObject()
                        as RenderRepaintBoundary)
                    .toImage(pixelRatio: 1);
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            final file = File('build/sprint10/ux-source-review-ko.png');
            await file.parent.create(recursive: true);
            await file.writeAsBytes(bytes!.buffer.asUint8List());
            image.dispose();
          });
        }
        await tester.tap(confirm);
        await tester.pumpAndSettle();
        expect(selected, hasLength(2000));
        expect(tester.takeException(), isNull);
      },
    );
  }
  testWidgets('shared body keeps final action above system navigation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        builder: (c, child) => MediaQuery(
          data: MediaQuery.of(
            c,
          ).copyWith(padding: const EdgeInsets.only(bottom: 48)),
          child: child!,
        ),
        home: Scaffold(
          body: CoverNoteBody(
            child: Column(
              children: [
                const Spacer(),
                FilledButton(onPressed: () {}, child: const Text('Continue')),
              ],
            ),
          ),
        ),
      ),
    );
    expect(
      tester.getBottomRight(find.byType(FilledButton)).dy,
      lessThanOrEqualTo(592),
    );
    expect(tester.takeException(), isNull);
  });
}
