import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/app.dart';
import 'package:howse_asthma/features/covernote/data/demo_case_store.dart';
import 'package:howse_asthma/features/covernote/domain/case_models.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('demo: check facts, link a record, generate the packet', (
    tester,
  ) async {
    dotenv.loadFromString(isOptional: true);
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(1000, 6000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    Future<void> settle([int frames = 10]) async {
      for (var i = 0; i < frames; i++) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    final demo = DemoCaseStore();
    await tester.pumpWidget(CoverNoteApp(demo: demo));
    await settle();
    final l = AppLocalizations.of(tester.element(find.byType(Scaffold).first))!;

    // Home -> demo list -> first sample case.
    await tester.tap(find.text(l.cnTryDemo));
    await settle();
    expect(find.text(l.cnDemoTitle), findsOneWidget);
    await tester.tap(find.textContaining('DemoController A 100 mcg'));
    await settle();

    // Review remains the landing view; incomplete facts do not lock records.
    expect(find.text(l.cnWhatAbout), findsOneWidget);
    final cont = find.widgetWithText(FilledButton, l.cnPreparePacket);
    expect(tester.widget<FilledButton>(cont).onPressed, isNotNull);

    // Facts can be corrected separately; linking records is not gated on it.
    expect(tester.widget<FilledButton>(cont).onPressed, isNotNull);

    // Evidence: link the medication summary to the first requested item.
    await tester.tap(cont);
    await settle();
    expect(find.text(l.cnLetterAsksFor), findsOneWidget);
    await tester.tap(find.text(l.cnLinkRecords).first);
    await settle();
    await tester.tap(find.byIcon(Icons.medication_outlined).last);
    await settle();
    final detail = await demo.load('demo-missing-info');
    expect(detail.requirements.first.status, RequirementStatus.linked);
    expect(detail.evidence.single.recordType, 'medication_summary');
    expect(detail.evidence.single.sourceType, 'synthetic');

    // Packet: generate and keep the artifact for this fact version.
    await tester.tap(find.text(l.cnContinueToPacket));
    await settle();
    await tester.tap(find.text(l.cnGeneratePacket));
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(seconds: 6)),
    );
    await settle(20);

    final after = await demo.load('demo-missing-info');
    final packet = after.latestPacket;
    expect(packet, isNotNull);
    expect(packet!.status, 'ready');
    expect(packet.isSample, isTrue);
    expect(packet.includes, contains('review_request_draft'));
    expect(after.row.status, 'draft_ready');
    expect(find.text(l.cnShareDocuments), findsOneWidget);
  });
}
