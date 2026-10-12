import '../../../core/debug/debug_functions_client.dart';
import '../../../core/supabase/supabase_service.dart';
import '../domain/regimen_math.dart';

class EnvSnapshot {
  const EnvSnapshot({
    required this.id,
    required this.subjectType,
    required this.subjectId,
    required this.status,
    this.provider,
    this.pollutant,
    this.aqiValue,
    this.observedAt,
    this.dataKind,
    this.eventTime,
    this.pollenUpi,
    this.pollenType,
    this.outdoorHumidity,
    this.floodAlert,
  });

  final String id;
  final String subjectType;
  final String subjectId;
  final String status;
  final String? provider;
  final String? pollutant;
  final int? aqiValue;
  final DateTime? observedAt;
  final String? dataKind;
  final DateTime? eventTime;
  final int? pollenUpi;
  final String? pollenType;
  final int? outdoorHumidity;
  final bool? floodAlert;

  bool get linked => status == 'linked';

  factory EnvSnapshot.fromRow(Map<String, dynamic> row) => EnvSnapshot(
    id: row['id'] as String,
    subjectType: row['subject_type'] as String,
    subjectId: row['subject_id'] as String,
    status: row['status'] as String,
    provider: row['provider'] as String?,
    pollutant: row['pollutant'] as String?,
    aqiValue: (row['aqi_value'] as num?)?.toInt(),
    observedAt: row['observed_at'] is String
        ? DateTime.tryParse(row['observed_at'] as String)
        : null,
    dataKind: row['data_kind'] as String?,
    eventTime: row['event_time'] is String
        ? DateTime.tryParse(row['event_time'] as String)
        : null,
    pollenUpi: (row['pollen_upi'] as num?)?.toInt(),
    pollenType: row['pollen_type'] as String?,
    outdoorHumidity: (row['outdoor_humidity'] as num?)?.toInt(),
    floodAlert: row['flood_alert'] as bool?,
  );
}

class SnapshotRepository {
  static const _columns =
      'id, subject_type, subject_id, status, provider, pollutant, aqi_value, '
      'observed_at, data_kind, event_time, pollen_upi, pollen_type, '
      'outdoor_humidity, flood_alert';

  Future<List<EnvSnapshot>> listRecent() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];
    final rows = await SupabaseService.client
        .from('environment_event_snapshots')
        .select(_columns)
        .eq('patient_id', userId)
        .order('created_at', ascending: false)
        .limit(200);
    return (rows as List)
        .map((r) => EnvSnapshot.fromRow(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  /// Stores no_data immediately when the event is not "now".
  /// Otherwise stores pending and asks the server to copy the current cache.
  /// The server refuses when the event time is outside the same window.
  Future<void> linkSymptom({
    required String symptomId,
    required DateTime? occurredAt,
    double? latitude,
    double? longitude,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return;
    final now = DateTime.now();
    final can = RegimenMath.canLinkCurrentEnvironment(
      occurredAt: occurredAt,
      now: now,
    );
    final existing = await SupabaseService.client
        .from('environment_event_snapshots')
        .select('id, status')
        .eq('patient_id', userId)
        .eq('subject_type', 'symptom')
        .eq('subject_id', symptomId)
        .maybeSingle();

    if (!can) {
      await _writeEmpty(
        userId: userId,
        existingId: existing?['id'] as String?,
        symptomId: symptomId,
        status: 'no_data',
        eventTime: occurredAt,
      );
      return;
    }

    final id = await _writeEmpty(
      userId: userId,
      existingId: existing?['id'] as String?,
      symptomId: symptomId,
      status: 'pending',
      eventTime: occurredAt,
    );
    try {
      await DebugFunctionsClient.invoke(
        'link-event-environment',
        body: {
          'snapshot_id': id,
          'occurred_at': occurredAt!.toUtc().toIso8601String(),
          'latitude': ?latitude,
          'longitude': ?longitude,
        },
      );
    } catch (_) {
      // Stays pending. Not shown as a normal or good reading.
    }
  }

  Future<String> _writeEmpty({
    required String userId,
    required String? existingId,
    required String symptomId,
    required String status,
    required DateTime? eventTime,
  }) async {
    final values = {
      'status': status,
      'event_time': eventTime?.toUtc().toIso8601String(),
      'provider': null,
      'numeric_value': null,
      'aqi_value': null,
      'pollen_upi': null,
      'outdoor_humidity': null,
      'data_kind': status == 'no_data' ? 'unavailable' : null,
    };
    if (existingId != null) {
      await SupabaseService.client
          .from('environment_event_snapshots')
          .update(values)
          .eq('id', existingId);
      return existingId;
    }
    final row = await SupabaseService.client
        .from('environment_event_snapshots')
        .insert({
          ...values,
          'patient_id': userId,
          'subject_type': 'symptom',
          'subject_id': symptomId,
        })
        .select('id')
        .single();
    return row['id'] as String;
  }
}
