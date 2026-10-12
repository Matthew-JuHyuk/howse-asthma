/// Occasion counts versus puff counts. A missing row is unconfirmed,
/// never "not used".
class OccasionTally {
  const OccasionTally({
    required this.scheduledOccasions,
    required this.puffsPerOccasion,
    required this.used,
    required this.notUsed,
    required this.deferred,
    required this.unconfirmed,
  });

  final int scheduledOccasions;
  final int puffsPerOccasion;
  final int used;
  final int notUsed;
  final int deferred;
  final int unconfirmed;

  int get scheduledPuffs => scheduledOccasions * puffsPerOccasion;
  int get usedPuffs => used * puffsPerOccasion;
  int get notUsedPuffs => notUsed * puffsPerOccasion;

  /// Confirmed occasion rate, as a percent with one decimal.
  /// Unconfirmed occasions stay in the denominator and are not counted as used.
  double? get occasionPercent {
    if (scheduledOccasions <= 0) return null;
    return used * 1000 ~/ scheduledOccasions / 10;
  }
}

class RegimenMath {
  const RegimenMath._();

  static const envWindow = Duration(minutes: 20);

  static OccasionTally tally({
    required int scheduledOccasions,
    required int puffsPerOccasion,
    required int used,
    required int notUsed,
    required int deferred,
  }) {
    final answered = used + notUsed + deferred;
    final unconfirmed = scheduledOccasions > answered
        ? scheduledOccasions - answered
        : 0;
    return OccasionTally(
      scheduledOccasions: scheduledOccasions,
      puffsPerOccasion: puffsPerOccasion,
      used: used,
      notUsed: notUsed,
      deferred: deferred,
      unconfirmed: unconfirmed,
    );
  }

  /// How many scheduled occasions a regimen version contributes inside
  /// [start, end] inclusive. Days outside the version are not in the denominator.
  static int scheduledOccasions({
    required DateTime start,
    required DateTime end,
    required DateTime effectiveFrom,
    required DateTime? effectiveUntil,
    required int occasionsPerDay,
  }) {
    if (occasionsPerDay <= 0) return 0;
    final from = _date(effectiveFrom);
    final until = effectiveUntil == null ? _date(end) : _date(effectiveUntil);
    final rangeStart = _date(start);
    final rangeEnd = _date(end);
    final first = from.isAfter(rangeStart) ? from : rangeStart;
    final last = until.isBefore(rangeEnd) ? until : rangeEnd;
    if (last.isBefore(first)) return 0;
    final days = last.difference(first).inDays + 1;
    return days * occasionsPerDay;
  }

  /// Current cache may be linked only when the event time is known and close
  /// to "now". Otherwise the result is "no data for that time".
  static bool canLinkCurrentEnvironment({
    required DateTime? occurredAt,
    required DateTime now,
  }) {
    if (occurredAt == null) return false;
    final gap = occurredAt.toUtc().difference(now.toUtc()).abs();
    return gap <= envWindow;
  }

  static DateTime _date(DateTime d) => DateTime(d.year, d.month, d.day);
}

/// US EPA AQI category from a single index. Does not name a pollutant.
enum AqiBand { good, moderate, usg, unhealthy, veryUnhealthy, hazardous }

AqiBand? aqiBand(int? aqi) {
  if (aqi == null || aqi < 0) return null;
  if (aqi <= 50) return AqiBand.good;
  if (aqi <= 100) return AqiBand.moderate;
  if (aqi <= 150) return AqiBand.usg;
  if (aqi <= 200) return AqiBand.unhealthy;
  if (aqi <= 300) return AqiBand.veryUnhealthy;
  return AqiBand.hazardous;
}

/// English source line for one linked snapshot. Mentions a pollutant only
/// when that pollutant's name was stored. Never adds pollen or ozone by itself.
String environmentSourceLine({
  required String? pollutant,
  required int? aqi,
  required String category,
  required String? provider,
  required String? observedAt,
  required String? dataKind,
}) {
  final kind = dataKind ?? 'unspecified';
  final who = provider ?? 'unspecified source';
  final when = observedAt ?? 'time not recorded';
  final index = aqi == null ? 'AQI not recorded' : 'AQI $aqi ($category)';
  final what = (pollutant == null || pollutant.trim().isEmpty)
      ? index
      : '${pollutant.trim()} $index';
  return '$what. Source: $who. Data time: $when. Kind: $kind. '
      'Regional reference only. This does not show personal exposure '
      'or the cause of symptoms.';
}
