import 'record_models.dart';

/// Inclusive local-date range ending today.
class RecordRange {
  RecordRange(DateTime start, DateTime end)
    : start = dateOnly(start),
      end = dateOnly(end);

  factory RecordRange.lastDays(int days, {DateTime? today}) {
    final end = dateOnly(today ?? DateTime.now());
    return RecordRange(end.subtract(Duration(days: days - 1)), end);
  }

  final DateTime start;
  final DateTime end;

  int get days => end.difference(start).inDays + 1;

  bool contains(DateTime localDate) {
    final d = dateOnly(localDate);
    return !d.isBefore(start) && !d.isAfter(end);
  }

  Iterable<DateTime> get dates sync* {
    for (var i = 0; i < days; i++) {
      yield DateTime(start.year, start.month, start.day + i);
    }
  }
}

/// One source of truth for Home, My log, visit-prep preview, and the PDF.
class RecordSummary {
  const RecordSummary({
    required this.range,
    required this.recordedDays,
    required this.inhalerUses,
    required this.inhalerDays,
    required this.inhalerUnknownMedication,
    required this.inhalerByMedication,
    required this.symptomDays,
    required this.noSymptomDays,
    required this.symptomDaysByCode,
    required this.symptomOtherDays,
    required this.medUsedDays,
    required this.medNotUsedDays,
    required this.medNotSureDays,
    required this.medNotApplicableDays,
    required this.medNotRecordedDays,
    required this.medNotUsedReasons,
  });

  final RecordRange range;

  /// Days with at least one record of any type.
  final int recordedDays;

  final int inhalerUses;
  final int inhalerDays;
  final int inhalerUnknownMedication;

  /// Uses per patient-entered medication label (unknown excluded).
  final Map<String, int> inhalerByMedication;

  /// Days with at least one reported symptom.
  final int symptomDays;

  /// Days marked "no symptoms" and without any symptom entry.
  final int noSymptomDays;
  final Map<String, int> symptomDaysByCode;
  final int symptomOtherDays;

  final int medUsedDays;
  final int medNotUsedDays;
  final int medNotSureDays;
  final int medNotApplicableDays;

  /// Range days with no daily medication answer at all.
  final int medNotRecordedDays;
  final Map<String, int> medNotUsedReasons;

  int get medAnsweredDays =>
      medUsedDays + medNotUsedDays + medNotSureDays + medNotApplicableDays;
  bool get isEmpty => recordedDays == 0;

  static RecordSummary compute(RecordRange range, RecordBundle bundle) {
    final inhaler = bundle.inhaler
        .where((e) => range.contains(e.localDate))
        .toList();
    final symptoms = bundle.symptoms
        .where((e) => range.contains(e.localDate))
        .toList();
    final checks = <DateTime, MedCheckRecord>{};
    for (final c in bundle.medChecks) {
      if (!range.contains(c.date)) continue;
      final prev = checks[c.date];
      final cAt = c.updatedAt;
      final pAt = prev?.updatedAt;
      if (prev == null || (cAt != null && (pAt == null || cAt.isAfter(pAt)))) {
        checks[c.date] = c;
      }
    }

    final recorded = <DateTime>{
      ...inhaler.map((e) => e.localDate),
      ...symptoms.map((e) => e.localDate),
      ...checks.keys,
    };

    final byMed = <String, int>{};
    var unknown = 0;
    for (final e in inhaler) {
      final label = e.medicationLabel?.trim();
      if (e.medicationUnknown || label == null || label.isEmpty) {
        if (e.medicationUnknown) unknown++;
        continue;
      }
      byMed[label] = (byMed[label] ?? 0) + 1;
    }

    final symptomDates = <DateTime>{};
    final noSymptomDates = <DateTime>{};
    final byCode = <String, Set<DateTime>>{};
    final otherDates = <DateTime>{};
    for (final s in symptoms) {
      if (s.hasSymptoms) {
        symptomDates.add(s.localDate);
        for (final code in s.symptoms) {
          (byCode[code] ??= <DateTime>{}).add(s.localDate);
        }
        if (s.otherText?.trim().isNotEmpty ?? false) {
          otherDates.add(s.localDate);
        }
      } else if (s.noSymptoms) {
        noSymptomDates.add(s.localDate);
      }
    }
    noSymptomDates.removeAll(symptomDates);

    var used = 0, notUsed = 0, notSure = 0, notApplicable = 0;
    final reasons = <String, int>{};
    for (final c in checks.values) {
      switch (c.status) {
        case MedCheckRecord.used:
          used++;
        case MedCheckRecord.notUsed:
          notUsed++;
          final r = c.reason ?? 'no_answer';
          reasons[r] = (reasons[r] ?? 0) + 1;
        case MedCheckRecord.notSure:
          notSure++;
        case MedCheckRecord.notApplicable:
          notApplicable++;
      }
    }

    return RecordSummary(
      range: range,
      recordedDays: recorded.length,
      inhalerUses: inhaler.length,
      inhalerDays: inhaler.map((e) => e.localDate).toSet().length,
      inhalerUnknownMedication: unknown,
      inhalerByMedication: byMed,
      symptomDays: symptomDates.length,
      noSymptomDays: noSymptomDates.length,
      symptomDaysByCode: {
        for (final code in SymptomRecord.codes)
          if (byCode[code] != null) code: byCode[code]!.length,
      },
      symptomOtherDays: otherDates.length,
      medUsedDays: used,
      medNotUsedDays: notUsed,
      medNotSureDays: notSure,
      medNotApplicableDays: notApplicable,
      medNotRecordedDays: range.days - checks.length,
      medNotUsedReasons: reasons,
    );
  }
}
