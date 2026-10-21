import '../../records/domain/record_models.dart';
import '../../records/domain/regimen_math.dart';

/// Inclusive local-date range.
class DayRange {
  const DayRange(this.from, this.to);

  /// The [days] full days that end yesterday (today is still in progress).
  factory DayRange.lastDays(DateTime today, int days) {
    final end = DateTime(today.year, today.month, today.day - 1);
    return DayRange(DateTime(end.year, end.month, end.day - (days - 1)), end);
  }

  final DateTime from;
  final DateTime to;

  int get dayCount =>
      DateTime.utc(
        to.year,
        to.month,
        to.day,
      ).difference(DateTime.utc(from.year, from.month, from.day)).inDays +
      1;

  bool contains(DateTime d) {
    final x = DateTime(d.year, d.month, d.day);
    return !x.isBefore(from) && !x.isAfter(to);
  }

  Map<String, String> toJson() => {'from': isoDate(from), 'to': isoDate(to)};
}

class RegimenInput {
  const RegimenInput({
    required this.id,
    required this.medicationName,
    required this.occasionsPerDay,
    required this.puffsPerOccasion,
    required this.effectiveFrom,
    this.effectiveUntil,
  });

  final String id;
  final String medicationName;
  final int occasionsPerDay;
  final int puffsPerOccasion;
  final DateTime effectiveFrom;
  final DateTime? effectiveUntil;
}

class OccasionInput {
  const OccasionInput(this.regimenId, this.date, this.status);

  final String regimenId;
  final DateTime date;
  final String status;
}

class LocalContextInput {
  const LocalContextInput({
    required this.date,
    required this.kind,
    required this.valueKind,
    required this.isSynthetic,
    this.aqi,
    this.numericValue,
    this.unit,
    this.sourceName,
    this.placeLabel,
    this.reportCode,
    this.observedAt,
  });

  final DateTime date;

  /// pm25 / no2 / outdoor_humidity / user_report
  final String kind;

  /// observation / forecast / model / user_report
  final String valueKind;
  final bool isSynthetic;
  final int? aqi;
  final double? numericValue;
  final String? unit;
  final String? sourceName;
  final String? placeLabel;
  final String? reportCode;
  final DateTime? observedAt;
}

/// Scheduled doses vs. answers, plus as-needed use. Missing answers stay
/// "unknown" and are never counted as missed doses.
class MedicationSnapshot {
  const MedicationSnapshot({
    required this.range,
    required this.medications,
    required this.scheduled,
    required this.taken,
    required this.notTaken,
    required this.deferred,
    required this.unknown,
    required this.prnUses,
    required this.prnPuffs,
    required this.prnUsesWithoutCount,
  });

  final DayRange range;
  final List<String> medications;
  final int scheduled;
  final int taken;
  final int notTaken;
  final int deferred;
  final int unknown;
  final int prnUses;
  final int prnPuffs;
  final int prnUsesWithoutCount;

  bool get hasSchedule => scheduled > 0;
  bool get isEmpty => scheduled == 0 && prnUses == 0;

  Map<String, Object?> toJson() => {
    'kind': 'medication_summary',
    'range': range.toJson(),
    'medications': medications,
    'scheduled': scheduled,
    'taken': taken,
    'not_taken': notTaken,
    'deferred': deferred,
    'unknown': unknown,
    'prn_uses': prnUses,
    'prn_puffs': prnPuffs,
    'prn_uses_without_count': prnUsesWithoutCount,
    'source': 'patient_reported',
  };

  static MedicationSnapshot? fromJson(Map<String, Object?> j) {
    final r = j['range'];
    if (r is! Map) return null;
    final from = DateTime.tryParse(r['from'] as String? ?? '');
    final to = DateTime.tryParse(r['to'] as String? ?? '');
    if (from == null || to == null) return null;
    int n(String k) => (j[k] as num?)?.toInt() ?? 0;
    return MedicationSnapshot(
      range: DayRange(from, to),
      medications: [
        for (final m in (j['medications'] as List? ?? const []))
          if (m is String) m,
      ],
      scheduled: n('scheduled'),
      taken: n('taken'),
      notTaken: n('not_taken'),
      deferred: n('deferred'),
      unknown: n('unknown'),
      prnUses: n('prn_uses'),
      prnPuffs: n('prn_puffs'),
      prnUsesWithoutCount: n('prn_uses_without_count'),
    );
  }

  static MedicationSnapshot compute({
    required DayRange range,
    required List<RegimenInput> regimens,
    required List<OccasionInput> checks,
    required List<InhalerRecord> inhaler,
  }) {
    var scheduled = 0;
    final names = <String>{};
    final scheduledIds = <String>{};
    for (final r in regimens) {
      if (r.occasionsPerDay <= 0) continue;
      final n = RegimenMath.scheduledOccasions(
        start: range.from,
        end: range.to,
        effectiveFrom: r.effectiveFrom,
        effectiveUntil: r.effectiveUntil,
        occasionsPerDay: r.occasionsPerDay,
      );
      if (n > 0) {
        scheduled += n;
        names.add(r.medicationName);
        scheduledIds.add(r.id);
      }
    }
    var taken = 0, notTaken = 0, deferred = 0;
    for (final c in checks) {
      if (!scheduledIds.contains(c.regimenId) || !range.contains(c.date)) {
        continue;
      }
      final reg = regimens.firstWhere((r) => r.id == c.regimenId);
      final d = DateTime(c.date.year, c.date.month, c.date.day);
      if (d.isBefore(dateOnly(reg.effectiveFrom))) continue;
      if (reg.effectiveUntil != null &&
          d.isAfter(dateOnly(reg.effectiveUntil!))) {
        continue;
      }
      switch (c.status) {
        case 'used':
          taken++;
        case 'not_used':
          notTaken++;
        case 'deferred':
          deferred++;
      }
    }
    final answered = taken + notTaken + deferred;
    final prn = inhaler
        .where((e) => !e.isPanic && range.contains(e.localDate))
        .toList();
    final withCount = prn.where((e) => e.puffCount != null).toList();
    return MedicationSnapshot(
      range: range,
      medications: names.toList()..sort(),
      scheduled: scheduled,
      taken: taken,
      notTaken: notTaken,
      deferred: deferred,
      unknown: scheduled > answered ? scheduled - answered : 0,
      prnUses: prn.length,
      prnPuffs: withCount.fold(0, (s, e) => s + e.puffCount!),
      prnUsesWithoutCount: prn.length - withCount.length,
    );
  }
}

class SymptomSnapshot {
  const SymptomSnapshot({
    required this.range,
    required this.daysWithSymptoms,
    required this.nightWakingDays,
    required this.activityLimitedDays,
    required this.daysWithEntries,
  });

  final DayRange range;
  final int daysWithSymptoms;
  final int nightWakingDays;
  final int activityLimitedDays;

  /// Days with any entry (including "no symptoms"); other days are unknown.
  final int daysWithEntries;

  bool get isEmpty => daysWithEntries == 0;

  Map<String, Object?> toJson() => {
    'kind': 'symptom_summary',
    'range': range.toJson(),
    'days_with_symptoms': daysWithSymptoms,
    'night_waking_days': nightWakingDays,
    'activity_limited_days': activityLimitedDays,
    'days_with_entries': daysWithEntries,
    'source': 'patient_reported',
  };

  static SymptomSnapshot? fromJson(Map<String, Object?> j) {
    final r = j['range'];
    if (r is! Map) return null;
    final from = DateTime.tryParse(r['from'] as String? ?? '');
    final to = DateTime.tryParse(r['to'] as String? ?? '');
    if (from == null || to == null) return null;
    int n(String k) => (j[k] as num?)?.toInt() ?? 0;
    return SymptomSnapshot(
      range: DayRange(from, to),
      daysWithSymptoms: n('days_with_symptoms'),
      nightWakingDays: n('night_waking_days'),
      activityLimitedDays: n('activity_limited_days'),
      daysWithEntries: n('days_with_entries'),
    );
  }

  static SymptomSnapshot compute({
    required DayRange range,
    required List<SymptomRecord> entries,
  }) {
    final any = <DateTime>{},
        symptomatic = <DateTime>{},
        night = <DateTime>{},
        activity = <DateTime>{};
    for (final e in entries) {
      final d = e.eventDate;
      if (!range.contains(d)) continue;
      any.add(d);
      if (e.hasSymptoms) symptomatic.add(d);
      if (e.symptoms.contains('night_waking')) night.add(d);
      if (e.symptoms.contains('activity_limited')) activity.add(d);
    }
    return SymptomSnapshot(
      range: range,
      daysWithSymptoms: symptomatic.length,
      nightWakingDays: night.length,
      activityLimitedDays: activity.length,
      daysWithEntries: any.length,
    );
  }
}

/// Regional air data and the patient's own reports for the same days.
/// Days without data stay missing; nothing is filled with zero or "good".
class LocalContextSnapshot {
  const LocalContextSnapshot({
    required this.range,
    required this.pm25Days,
    required this.pm25DaysAbove100,
    required this.pm25MaxAqi,
    required this.sources,
    required this.places,
    required this.synthetic,
    required this.reportCounts,
    required this.valueKinds,
  });

  final DayRange range;
  final int pm25Days;
  final int pm25DaysAbove100;
  final int? pm25MaxAqi;
  final List<String> sources;
  final List<String> places;
  final bool synthetic;
  final Map<String, int> reportCounts;
  final List<String> valueKinds;

  bool get isEmpty => pm25Days == 0 && reportCounts.isEmpty;

  Map<String, Object?> toJson() => {
    'kind': 'local_context',
    'range': range.toJson(),
    'pm25_days': pm25Days,
    'pm25_days_above_100': pm25DaysAbove100,
    'pm25_max_aqi': pm25MaxAqi,
    'sources': sources,
    'places': places,
    'synthetic': synthetic,
    'reports': reportCounts,
    'value_kinds': valueKinds,
  };

  static LocalContextSnapshot? fromJson(Map<String, Object?> j) {
    final r = j['range'];
    if (r is! Map) return null;
    final from = DateTime.tryParse(r['from'] as String? ?? '');
    final to = DateTime.tryParse(r['to'] as String? ?? '');
    if (from == null || to == null) return null;
    final reports = j['reports'];
    return LocalContextSnapshot(
      range: DayRange(from, to),
      pm25Days: (j['pm25_days'] as num?)?.toInt() ?? 0,
      pm25DaysAbove100: (j['pm25_days_above_100'] as num?)?.toInt() ?? 0,
      pm25MaxAqi: (j['pm25_max_aqi'] as num?)?.toInt(),
      sources: [
        for (final s in (j['sources'] as List? ?? const []))
          if (s is String) s,
      ],
      places: [
        for (final s in (j['places'] as List? ?? const []))
          if (s is String) s,
      ],
      synthetic: j['synthetic'] == true,
      reportCounts: reports is Map
          ? {
              for (final e in reports.entries)
                e.key as String: (e.value as num).toInt(),
            }
          : const {},
      valueKinds: [
        for (final s in (j['value_kinds'] as List? ?? const []))
          if (s is String) s,
      ],
    );
  }

  static LocalContextSnapshot compute({
    required DayRange range,
    required List<LocalContextInput> entries,
  }) {
    final pmByDay = <DateTime, int>{};
    final sources = <String>{}, places = <String>{}, kinds = <String>{};
    final reports = <String, Set<DateTime>>{};
    var synthetic = false;
    for (final e in entries) {
      if (!range.contains(e.date)) continue;
      final d = DateTime(e.date.year, e.date.month, e.date.day);
      if (e.isSynthetic) synthetic = true;
      if (e.kind == 'user_report' && e.reportCode != null) {
        reports.putIfAbsent(e.reportCode!, () => {}).add(d);
        continue;
      }
      // Forecasts are not observations of a past day.
      if (e.kind == 'pm25' && e.aqi != null && e.valueKind != 'forecast') {
        final prev = pmByDay[d];
        pmByDay[d] = prev == null || e.aqi! > prev ? e.aqi! : prev;
        if (e.sourceName != null) sources.add(e.sourceName!);
        if (e.placeLabel != null) places.add(e.placeLabel!);
        kinds.add(e.valueKind);
      }
    }
    final values = pmByDay.values.toList();
    return LocalContextSnapshot(
      range: range,
      pm25Days: values.length,
      pm25DaysAbove100: values.where((v) => v > 100).length,
      pm25MaxAqi: values.isEmpty
          ? null
          : values.reduce((a, b) => a > b ? a : b),
      sources: sources.toList()..sort(),
      places: places.toList()..sort(),
      synthetic: synthetic,
      reportCounts: {for (final e in reports.entries) e.key: e.value.length},
      valueKinds: kinds.toList()..sort(),
    );
  }
}

class RecordSnapshots {
  const RecordSnapshots({
    required this.medication,
    required this.symptoms,
    required this.localContext,
  });

  final MedicationSnapshot medication;
  final SymptomSnapshot symptoms;
  final LocalContextSnapshot localContext;
}
