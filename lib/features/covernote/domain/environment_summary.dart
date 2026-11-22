/// Deterministic, single-reading labels. No AI, trend, exposure or causal inference.
/// AQI: US EPA bands. Pollen: Google UPI (0–5).
/// Humidity bands are descriptive UI buckets, not clinical risk thresholds.
String environmentSummaryKey(Map<String, dynamic> values) {
  final metric = values['metric'];
  final value = values['value'];
  if (value is! num || !value.isFinite) return 'envUnavailable';
  final unit = '${values['unit'] ?? ''}'.toLowerCase();
  if (metric == 'aqi' ||
      metric == 'us_aqi' ||
      (metric == null && unit.contains('aqi'))) {
    if (value < 0 || value > 500) return 'envUnavailable';
    final aqi = value.round();
    if (aqi <= 50) return 'envAirGood';
    if (aqi <= 100) return 'envAirModerate';
    if (aqi <= 150) return 'envAirSensitive';
    if (aqi <= 200) return 'envAirUnhealthy';
    if (aqi <= 300) return 'envAirVeryUnhealthy';
    return 'envAirHazardous';
  }
  if (metric == 'outdoor_humidity' && unit == '%') {
    if (value < 0 || value > 100) return 'envUnavailable';
    return value < 40
        ? 'envDry'
        : value < 70
        ? 'envHumidityMid'
        : 'envHumid';
  }
  if (metric == 'pollen' && unit == 'upi') {
    if (value < 0 || value > 5 || value != value.round()) {
      return 'envUnavailable';
    }
    return [
      'envPollenNone',
      'envPollenVeryLow',
      'envPollenLow',
      'envPollenModerate',
      'envPollenHigh',
      'envPollenVeryHigh',
    ][value.toInt()];
  }
  if (metric == 'flood' && (value == 0 || value == 1)) {
    return value == 1 ? 'envFloodWarning' : 'envNoFloodWarning';
  }
  return 'envUnavailable';
}
