import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/domain/environment_summary.dart';
import 'package:howse_asthma/features/covernote/domain/preparation.dart';
import 'package:howse_asthma/features/covernote/presentation/treatment_record_summary.dart';
import 'package:howse_asthma/l10n/app_localizations.dart';

void main() {
  test('US AQI boundaries, invalid data and unknown metrics', () {
    for (final pair in {
      0: 'Good',
      50: 'Good',
      51: 'Moderate',
      100: 'Moderate',
      101: 'Sensitive',
      150: 'Sensitive',
      151: 'Unhealthy',
      200: 'Unhealthy',
      201: 'VeryUnhealthy',
      300: 'VeryUnhealthy',
      301: 'Hazardous',
      500: 'Hazardous',
    }.entries) {
      expect(
        environmentSummaryKey({'metric': 'aqi', 'value': pair.key}),
        'envAir${pair.value}',
      );
    }
    for (final value in [-1, 501, double.nan, double.infinity, null, '70']) {
      expect(
        environmentSummaryKey({'metric': 'aqi', 'value': value}),
        'envUnavailable',
      );
    }
    expect(
      environmentSummaryKey({'metric': 'pm25', 'value': 35}),
      'envUnavailable',
    );
  });
  test(
    'pollen respects its scale, humidity never implies flooding or a trend',
    () {
      expect(
        environmentSummaryKey({'metric': 'pollen', 'value': 4, 'unit': 'UPI'}),
        'envPollenHigh',
      );
      expect(
        environmentSummaryKey({
          'metric': 'pollen',
          'value': 4,
          'unit': 'grains/m3',
        }),
        'envUnavailable',
      );
      expect(
        environmentSummaryKey({
          'metric': 'pollen',
          'value': 4.5,
          'unit': 'UPI',
        }),
        'envUnavailable',
      );
      for (final pair in {
        39: 'envDry',
        40: 'envHumidityMid',
        69: 'envHumidityMid',
        70: 'envHumid',
        100: 'envHumid',
        101: 'envUnavailable',
      }.entries) {
        expect(
          environmentSummaryKey({
            'metric': 'outdoor_humidity',
            'value': pair.key,
            'unit': '%',
          }),
          pair.value,
        );
      }
    },
  );
  for (final language in ['en', 'ko', 'es']) {
    testWidgets('saved reading and demo use short localized text ($language)', (
      tester,
    ) async {
      final results = <String>[];
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(language),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              results.clear();
              for (final values in [
                {'metric': 'aqi', 'value': 112, 'unit': 'AQI'},
                {'category': 'pollen'},
                {
                  'metric': 'pollen',
                  'value': 4,
                  'unit': 'UPI',
                  'source_kind': 'forecast',
                },
              ]) {
                results.add(
                  treatmentRecordSummary(
                    context,
                    TreatmentEvent(
                      id: 'a',
                      patientKey: 'patient',
                      kind: 'environment',
                      day: '2026-10-25',
                      sourceId: 'source',
                      values: values,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(results[0], isNot(contains('112')));
      expect(results[1], isNot(contains('Several days')));
      expect(
        results[2],
        contains({'en': 'Forecast', 'ko': '예보', 'es': 'Pronóstico'}[language]!),
      );
      expect(
        results.every((s) => s.isNotEmpty && !s.contains('See details')),
        isTrue,
      );
    });
  }
}
