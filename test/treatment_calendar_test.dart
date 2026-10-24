import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/domain/preparation.dart';
import 'package:howse_asthma/features/covernote/presentation/treatment_calendar.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';

void main() {
  for (final language in ['en', 'ko', 'es']) {
    testWidgets(
      'calendar distinguishes records and patients at 320dp / 200% ($language)',
      (tester) async {
        tester.view.physicalSize = const Size(320, 800);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final now = DateTime.now();
        final date = DateTime(now.year, now.month, 1);
        final events = [
          for (final kind in ['medication_use', 'symptom', 'environment'])
            TreatmentEvent(
              id: kind,
              patientKey: 'child',
              kind: kind,
              day: dayKey(date),
              sourceId: kind,
              text: '',
              values: {},
            ),
          TreatmentEvent(
            id: 'other',
            patientKey: 'other',
            kind: 'symptom',
            day: dayKey(date.add(const Duration(days: 1))),
            sourceId: 'other',
            text: '',
            values: {},
          ),
        ];
        DateTime? selected;
        await tester.pumpWidget(
          MaterialApp(
            locale: Locale(language),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(2)),
              child: child!,
            ),
            home: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TreatmentCalendar(
                    day: date,
                    events: events,
                    patientKey: 'child',
                    onSelected: (day) => selected = day,
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        expect(find.byIcon(Icons.medication), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.air), findsOneWidget);
        await tester.tap(find.text('1'));
        expect(selected, date);
      },
    );
  }
}
