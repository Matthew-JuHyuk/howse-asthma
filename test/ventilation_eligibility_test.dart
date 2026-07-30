import 'package:flutter_test/flutter_test.dart';

/// Mirrors Edge `canSuggestVentilation` / Home `_canSuggestVentilation` (security parity).
bool canSuggestVentilation({
  required int riskScore,
  int? aqiEpa,
  int? pollenUpi,
  String? trapLevel,
  bool hasFlashFlood = false,
  int? moldScore,
}) {
  if (hasFlashFlood) return false;
  if ((moldScore ?? 0) > 2) return false;
  if ((pollenUpi ?? 0) > 2) return false;
  if (trapLevel == 'HIGH' || trapLevel == 'CRITICAL') return false;
  if (aqiEpa != null && aqiEpa > 50) return false;
  if (riskScore >= 3) return false;
  return true;
}

void main() {
  test('blocks moderate AQI even when composite risk is 2', () {
    expect(
      canSuggestVentilation(riskScore: 2, aqiEpa: 75),
      isFalse,
    );
  });

  test('allows calm outdoor window', () {
    expect(
      canSuggestVentilation(
        riskScore: 1,
        aqiEpa: 40,
        pollenUpi: 1,
        trapLevel: 'LOW',
        moldScore: 1,
      ),
      isTrue,
    );
  });

  test('blocks flood and high mold', () {
    expect(
      canSuggestVentilation(riskScore: 1, hasFlashFlood: true),
      isFalse,
    );
    expect(
      canSuggestVentilation(riskScore: 1, moldScore: 3),
      isFalse,
    );
  });
}
