import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/environment/data/environment_snapshot.dart';

void main() {
  test('parses forecast_points and NJ coverage', () {
    final snap = EnvironmentSnapshot.fromJson({
      'risk_score': 3,
      'ui_state': 'WARNING',
      'triggers': {'flash_flood': true},
      'forecast_points': [
        {
          'date': '2026-07-26',
          'pollen_upi': 3,
          'dominant_pollen_type': 'Tree',
          'us_aqi_max': 120,
          'composite_score': 3,
          'periods': [
            {
              'period': 'morning',
              'us_aqi': 90,
              'pollen_upi': 3,
              'trap_level': 'MODERATE',
              'flood_active': true,
            },
          ],
        },
      ],
      'source_coverage': {
        'njdot': {
          'scope': 'NJ_ONLY',
          'applied': false,
          'reason': 'outside_nj',
        },
      },
    });

    expect(snap.forecastPoints, hasLength(1));
    expect(snap.forecastPoints.first.periods.first.floodActive, isTrue);
    expect(snap.showNjOnlyFreightNotice, isTrue);
  });

  test('showNjOnlyFreightNotice false when coverage missing', () {
    final snap = EnvironmentSnapshot.fromJson({
      'risk_score': 1,
      'ui_state': 'CALM',
      'triggers': <String, bool>{},
      'trap_near_freight_weight': false,
    });
    expect(snap.showNjOnlyFreightNotice, isFalse);
  });
}
