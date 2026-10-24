import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:howse_asthma/app.dart';
import 'package:howse_asthma/features/covernote/presentation/guided_record_screen.dart';
import 'package:howse_asthma/features/covernote/presentation/quick_treatment_actions.dart';
import 'package:howse_asthma/features/covernote/presentation/demo_screen.dart';
import 'package:howse_asthma/features/covernote/data/demo_case_store.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/core/theme/app_theme.dart';
import 'package:howse_asthma/features/covernote/data/preparation_repository.dart';
import 'package:howse_asthma/features/covernote/presentation/preparation_screen.dart';
import 'package:howse_asthma/features/covernote/presentation/source_review_screen.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    final loader = FontLoader('Ahem')
      ..addFont(rootBundle.load('assets/fonts/NotoSans-Regular.ttf'));
    await loader.load();
    final roboto = FontLoader('Roboto')
      ..addFont(rootBundle.load('assets/fonts/NotoSans-Regular.ttf'));
    await roboto.load();
    final icons = FontLoader('MaterialIcons')
      ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf'));
    await icons.load();
  });
  testWidgets(
    'phone previews show the task, next action, and protected footer',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({});
      final repo = PreparationRepository(demo: true);
      final preparation = await repo.seed(false);
      final boundary = GlobalKey();
      Future<void> capture(String name) async {
        expect(tester.takeException(), isNull);
        await tester.runAsync(() async {
          final rendered =
              await (boundary.currentContext!.findRenderObject()
                      as RenderRepaintBoundary)
                  .toImage();
          final data = await rendered.toByteData(
            format: ui.ImageByteFormat.png,
          );
          final output = File('build/sprint10/$name.png');
          await output.parent.create(recursive: true);
          await output.writeAsBytes(data!.buffer.asUint8List());
          rendered.dispose();
        });
      }

      Widget app(Widget screen) => MaterialApp(
        theme: AppTheme.light.copyWith(
          filledButtonTheme: FilledButtonThemeData(
            style: AppTheme.light.filledButtonTheme.style!.copyWith(
              textStyle: const WidgetStatePropertyAll(
                TextStyle(
                  fontFamily: 'Ahem',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          chipTheme: AppTheme.light.chipTheme.copyWith(
            labelStyle: const TextStyle(
              fontFamily: 'Ahem',
              fontSize: 13,
              color: Color(0xFF334155),
            ),
          ),
          textTheme: AppTheme.light.textTheme.apply(fontFamily: 'Ahem'),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (c, child) => MediaQuery(
          data: MediaQuery.of(c).copyWith(
            padding: const EdgeInsets.only(bottom: 24),
            viewPadding: const EdgeInsets.only(bottom: 24),
          ),
          child: RepaintBoundary(key: boundary, child: child!),
        ),
        home: screen,
      );
      await tester.pumpWidget(
        app(
          PreparationScreen(
            repository: repo,
            caseId: preparation.id,
            mainNavigation: (_) {},
          ),
        ),
      );
      await tester.pumpAndSettle();
      await capture('ux-quality-overview');
      await tester.tap(find.widgetWithText(ChoiceChip, 'Your documents'));
      await tester.pumpAndSettle();
      await capture('ux-quality-documents');
      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(
        app(
          SourceReviewScreen(
            title: 'Symptoms and visits',
            patient: 'Diego · SAMPLE',
            events: await repo.events(),
            linked: const [],
            suggestAll: true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await capture('ux-quality-connect');
      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(
        app(
          GuidedRecordScreen(
            repository: repo,
            profiles: {repo.uid: 'Diego · SAMPLE'},
          ),
        ),
      );
      await tester.pumpAndSettle();
      await capture('ux-journey-record');
      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(app(Scaffold(
        appBar: AppBar(title: const Text('Records')),
        body: SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(20),
          child: QuickTreatmentActions(repository: repo, patientKey: repo.uid, patientName: 'Diego'))),
      )));
      await tester.pumpAndSettle();
      await capture('ux-record-quick-actions');
      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(app(DemoScreen(store: DemoCaseStore())));
      await tester.pumpAndSettle();
      await capture('ux-demo-spacing');
      await tester.pumpWidget(const SizedBox());
      dotenv.loadFromString(isOptional: true);
      await tester.pumpWidget(RepaintBoundary(key: boundary, child: const CoverNoteApp()));
      await tester.pumpAndSettle();
      final labels = AppLocalizations.of(tester.element(find.byType(Scaffold).first))!;
      await tester.tap(find.text(labels.cnTabSettings));
      await tester.pumpAndSettle();
      await capture('ux-settings-spacing');
      await tester.ensureVisible(find.text('Privacy and AI permissions'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Privacy and AI permissions'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.byType(SwitchListTile).last, 180,
        scrollable: find.byType(Scrollable).first);
      await tester.pumpAndSettle();
      await capture('ux-settings-consent-spacing');
    },
  );
}
