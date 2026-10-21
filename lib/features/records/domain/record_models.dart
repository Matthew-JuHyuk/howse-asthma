import 'dart:math';

/// Local calendar date (time stripped) for a UTC instant.
///
/// Uses the offset captured at record time so a trip across time zones does
/// not move past records to another day; falls back to the device offset.
DateTime recordLocalDate(DateTime utc, int? tzOffsetMinutes) {
  final local = tzOffsetMinutes == null
      ? utc.toLocal()
      : utc.toUtc().add(Duration(minutes: tzOffsetMinutes));
  return DateTime(local.year, local.month, local.day);
}

/// Wall-clock time for a record in the offset captured at record time.
DateTime recordLocalTime(DateTime utc, int? tzOffsetMinutes) {
  if (tzOffsetMinutes == null) return utc.toLocal();
  final shifted = utc.toUtc().add(Duration(minutes: tzOffsetMinutes));
  return DateTime(
    shifted.year,
    shifted.month,
    shifted.day,
    shifted.hour,
    shifted.minute,
  );
}

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

String isoDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

/// RFC 4122 v4 UUID for idempotent create requests.
String newRequestId([Random? random]) {
  final r = random ?? Random.secure();
  final b = List<int>.generate(16, (_) => r.nextInt(256));
  b[6] = (b[6] & 0x0f) | 0x40;
  b[8] = (b[8] & 0x3f) | 0x80;
  final h = b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
  return '${h.substring(0, 8)}-${h.substring(8, 12)}-${h.substring(12, 16)}-'
      '${h.substring(16, 20)}-${h.substring(20)}';
}

DateTime? _ts(Object? raw) =>
    raw is String ? DateTime.tryParse(raw)?.toUtc() : null;

class InhalerRecord {
  const InhalerRecord({
    required this.id,
    required this.recordedAtUtc,
    this.tzOffsetMinutes,
    this.isPanic = false,
    this.medicationLabel,
    this.medicationStatus,
    this.puffCount,
    this.useReason,
    this.note,
    this.sourceLanguage,
    this.updatedAt,
  });

  static const statusIdentified = 'identified';
  static const statusNotIdentified = 'not_identified';
  static const reasons = ['symptoms', 'before_activity', 'other'];

  final String id;
  final DateTime recordedAtUtc;
  final int? tzOffsetMinutes;
  final bool isPanic;
  final String? medicationLabel;

  /// `identified`, `not_identified`, or null (not asked — e.g. 1-tap).
  final String? medicationStatus;
  final int? puffCount;
  final String? useReason;
  final String? note;
  final String? sourceLanguage;
  final DateTime? updatedAt;

  DateTime get localDate => recordLocalDate(recordedAtUtc, tzOffsetMinutes);
  DateTime get localTime => recordLocalTime(recordedAtUtc, tzOffsetMinutes);
  bool get medicationUnknown => medicationStatus == statusNotIdentified;
  DateTime get changedAt => updatedAt ?? recordedAtUtc;

  factory InhalerRecord.fromRow(Map<String, dynamic> row) {
    return InhalerRecord(
      id: row['id'] as String,
      recordedAtUtc: _ts(row['recorded_at']) ?? DateTime.now().toUtc(),
      tzOffsetMinutes: (row['tz_offset_minutes'] as num?)?.toInt(),
      isPanic: row['is_panic'] == true,
      medicationLabel: row['medication_label'] as String?,
      medicationStatus: row['medication_status'] as String?,
      puffCount: (row['puff_count'] as num?)?.toInt(),
      useReason: row['use_reason'] as String?,
      note: row['note'] as String?,
      sourceLanguage: row['source_language'] as String?,
      updatedAt: _ts(row['updated_at']),
    );
  }
}

class SymptomRecord {
  const SymptomRecord({
    required this.id,
    required this.recordedAtUtc,
    this.occurredAtUtc,
    this.tzOffsetMinutes,
    this.symptoms = const [],
    this.noSymptoms = false,
    this.otherText,
    this.note,
    this.homeWater,
    this.sourceLanguage,
    this.updatedAt,
  });

  static const codes = [
    'cough',
    'wheeze',
    'short_breath',
    'night_waking',
    'activity_limited',
  ];

  final String id;
  final DateTime recordedAtUtc;

  /// When the symptom happened. Null on older rows — not guessed for environment.
  final DateTime? occurredAtUtc;
  final int? tzOffsetMinutes;
  final List<String> symptoms;
  final bool noSymptoms;
  final String? otherText;
  final String? note;

  /// Self-report only: `yes` / `no` / `no_answer`. Not a flood measurement.
  final String? homeWater;
  final String? sourceLanguage;
  final DateTime? updatedAt;

  DateTime get localDate => recordLocalDate(recordedAtUtc, tzOffsetMinutes);

  /// Calendar day of the symptom. Falls back to entry time only for display
  /// of older rows that have no occurrence time.
  DateTime get eventDate => occurredAtUtc == null
      ? localDate
      : recordLocalDate(occurredAtUtc!, tzOffsetMinutes);
  DateTime get localTime =>
      recordLocalTime(occurredAtUtc ?? recordedAtUtc, tzOffsetMinutes);
  bool get hasSymptoms =>
      symptoms.isNotEmpty || (otherText?.trim().isNotEmpty ?? false);
  DateTime get changedAt => updatedAt ?? recordedAtUtc;

  factory SymptomRecord.fromRow(Map<String, dynamic> row) {
    final raw = row['symptoms'];
    return SymptomRecord(
      id: row['id'] as String,
      recordedAtUtc: _ts(row['recorded_at']) ?? DateTime.now().toUtc(),
      occurredAtUtc: _ts(row['occurred_at']),
      tzOffsetMinutes: (row['tz_offset_minutes'] as num?)?.toInt(),
      symptoms: raw is List ? raw.whereType<String>().toList() : const [],
      noSymptoms: row['no_symptoms'] == true,
      otherText: row['other_text'] as String?,
      note: row['note'] as String?,
      homeWater: row['home_water'] as String?,
      sourceLanguage: row['source_language'] as String?,
      updatedAt: _ts(row['updated_at']),
    );
  }
}

class MedCheckRecord {
  const MedCheckRecord({
    required this.id,
    required this.date,
    required this.status,
    this.reason,
    this.updatedAt,
  });

  static const used = 'used';
  static const notUsed = 'not_used';
  static const notSure = 'not_sure';
  static const notApplicable = 'not_applicable';
  static const statuses = [used, notUsed, notSure, notApplicable];
  static const reasons = [
    'no_medicine',
    'cost',
    'forgot',
    'other',
    'no_answer',
  ];

  final String id;

  /// Local calendar date (the row's `check_date`).
  final DateTime date;
  final String status;
  final String? reason;
  final DateTime? updatedAt;

  static MedCheckRecord? fromRow(Map<String, dynamic> row) {
    final rawDate = row['check_date'] as String?;
    final parsed = rawDate == null ? null : DateTime.tryParse(rawDate);
    if (parsed == null) return null;
    var status = row['status'] as String?;
    if (status == null) {
      final taken = row['taken'];
      if (taken == true) status = used;
      if (taken == false) status = notUsed;
    }
    if (status == null || !statuses.contains(status)) return null;
    return MedCheckRecord(
      id: row['id'] as String,
      date: dateOnly(parsed),
      status: status,
      reason: row['reason'] as String?,
      updatedAt: _ts(row['updated_at']),
    );
  }
}

class PatientMedication {
  const PatientMedication({
    required this.id,
    required this.displayName,
    this.isDefault = false,
    this.dailyCheckEnabled = false,
  });

  final String id;
  final String displayName;
  final bool isDefault;
  final bool dailyCheckEnabled;

  factory PatientMedication.fromRow(Map<String, dynamic> row) =>
      PatientMedication(
        id: row['id'] as String,
        displayName: row['display_name'] as String,
        isDefault: row['is_default'] == true,
        dailyCheckEnabled: row['daily_check_enabled'] == true,
      );
}

/// Every record type for one date range, already filtered to that range.
class RecordBundle {
  const RecordBundle({
    this.inhaler = const [],
    this.symptoms = const [],
    this.medChecks = const [],
  });

  final List<InhalerRecord> inhaler;
  final List<SymptomRecord> symptoms;
  final List<MedCheckRecord> medChecks;

  /// Changes whenever a record in range is added, edited, or removed.
  String get fingerprint {
    DateTime? latest;
    void see(DateTime? t) {
      if (t != null && (latest == null || t.isAfter(latest!))) latest = t;
    }

    for (final e in inhaler) {
      see(e.changedAt);
    }
    for (final e in symptoms) {
      see(e.changedAt);
    }
    for (final e in medChecks) {
      see(e.updatedAt);
    }
    return '${inhaler.length}.${symptoms.length}.${medChecks.length}@'
        '${latest?.toIso8601String() ?? '-'}';
  }
}
