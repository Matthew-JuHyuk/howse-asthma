import '../../../core/supabase/supabase_service.dart';
import '../domain/record_models.dart';

class MedicationRegimen {
  const MedicationRegimen({
    required this.id,
    required this.medicationId,
    required this.role,
    required this.occasionsPerDay,
    required this.puffsPerOccasion,
    required this.timesMinutes,
    required this.effectiveFrom,
    this.effectiveUntil,
    this.medicationName,
  });

  final String id;
  final String medicationId;
  final String role;
  final int occasionsPerDay;
  final int puffsPerOccasion;
  final List<int> timesMinutes;
  final DateTime effectiveFrom;
  final DateTime? effectiveUntil;
  final String? medicationName;

  bool get schedulesReminders => role != 'rescue' && occasionsPerDay > 0;

  bool covers(DateTime day) {
    final d = dateOnly(day);
    if (d.isBefore(dateOnly(effectiveFrom))) return false;
    final until = effectiveUntil;
    if (until != null && d.isAfter(dateOnly(until))) return false;
    return true;
  }

  factory MedicationRegimen.fromRow(Map<String, dynamic> row) {
    final times = row['times_minutes'];
    final from = DateTime.parse(row['effective_from'] as String);
    final untilRaw = row['effective_until'] as String?;
    final med = row['patient_medications'];
    return MedicationRegimen(
      id: row['id'] as String,
      medicationId: row['medication_id'] as String,
      role: row['role'] as String,
      occasionsPerDay: (row['occasions_per_day'] as num).toInt(),
      puffsPerOccasion: (row['puffs_per_occasion'] as num).toInt(),
      timesMinutes: times is List
          ? times.map((e) => (e as num).toInt()).toList()
          : const [],
      effectiveFrom: dateOnly(from),
      effectiveUntil: untilRaw == null
          ? null
          : dateOnly(DateTime.parse(untilRaw)),
      medicationName: med is Map ? med['display_name'] as String? : null,
    );
  }
}

class OccasionCheck {
  const OccasionCheck({
    required this.id,
    required this.regimenId,
    required this.localDate,
    required this.occasionIndex,
    required this.status,
  });

  final String id;
  final String regimenId;
  final DateTime localDate;
  final int occasionIndex;
  final String status;

  factory OccasionCheck.fromRow(Map<String, dynamic> row) => OccasionCheck(
    id: row['id'] as String,
    regimenId: row['regimen_id'] as String,
    localDate: dateOnly(DateTime.parse(row['local_date'] as String)),
    occasionIndex: (row['occasion_index'] as num).toInt(),
    status: row['status'] as String,
  );
}

class RegimenRepository {
  static const roles = ['controller', 'rescue', 'both'];

  Future<List<MedicationRegimen>> listAll() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];
    final rows = await SupabaseService.client
        .from('medication_regimens')
        .select(
          'id, medication_id, role, occasions_per_day, puffs_per_occasion, '
          'times_minutes, effective_from, effective_until, '
          'patient_medications(display_name)',
        )
        .eq('patient_id', userId)
        .order('effective_from', ascending: false);
    return (rows as List)
        .map(
          (r) => MedicationRegimen.fromRow(Map<String, dynamic>.from(r as Map)),
        )
        .toList();
  }

  /// Closes the open version and inserts a new one. Past rows are not overwritten.
  Future<void> replaceOpen({
    required String medicationId,
    required String role,
    required int occasionsPerDay,
    required int puffsPerOccasion,
    required List<int> timesMinutes,
    required DateTime effectiveFrom,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');
    if (!roles.contains(role)) throw ArgumentError('role');
    if (timesMinutes.length != occasionsPerDay) {
      throw ArgumentError('times');
    }
    if (timesMinutes.any((m) => m < 0 || m > 1439)) {
      throw ArgumentError('time');
    }
    final from = dateOnly(effectiveFrom);
    final open = await SupabaseService.client
        .from('medication_regimens')
        .select('id, effective_from')
        .eq('patient_id', userId)
        .eq('medication_id', medicationId)
        .isFilter('effective_until', null)
        .maybeSingle();
    if (open != null) {
      final previousFrom = dateOnly(
        DateTime.parse(open['effective_from'] as String),
      );
      final until = from.isAfter(previousFrom)
          ? from.subtract(const Duration(days: 1))
          : previousFrom;
      await SupabaseService.client
          .from('medication_regimens')
          .update({'effective_until': isoDate(until)})
          .eq('id', open['id'] as String);
    }
    await SupabaseService.client.from('medication_regimens').insert({
      'patient_id': userId,
      'medication_id': medicationId,
      'role': role,
      'occasions_per_day': role == 'rescue' ? 0 : occasionsPerDay,
      'puffs_per_occasion': puffsPerOccasion,
      'times_minutes': role == 'rescue' ? <int>[] : timesMinutes,
      'effective_from': isoDate(from),
    });
  }

  Future<List<OccasionCheck>> listBetween(DateTime start, DateTime end) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];
    final rows = await SupabaseService.client
        .from('medication_occasion_checks')
        .select('id, regimen_id, local_date, occasion_index, status')
        .eq('patient_id', userId)
        .gte('local_date', isoDate(start))
        .lte('local_date', isoDate(end));
    return (rows as List)
        .map((r) => OccasionCheck.fromRow(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  /// Writes only an explicit answer. Does not create a "missed" row for silence.
  Future<void> respond({
    required String regimenId,
    required DateTime localDate,
    required int occasionIndex,
    required String status,
    required String requestId,
    required String source,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');
    if (status != 'used' && status != 'not_used' && status != 'deferred') {
      throw ArgumentError('status');
    }
    final existing = await SupabaseService.client
        .from('medication_occasion_checks')
        .select('id')
        .eq('patient_id', userId)
        .eq('regimen_id', regimenId)
        .eq('local_date', isoDate(localDate))
        .eq('occasion_index', occasionIndex)
        .maybeSingle();
    final values = {
      'status': status,
      'client_request_id': requestId,
      'responded_at': DateTime.now().toUtc().toIso8601String(),
      'source': source,
    };
    if (existing == null) {
      await SupabaseService.client.from('medication_occasion_checks').insert({
        ...values,
        'patient_id': userId,
        'regimen_id': regimenId,
        'local_date': isoDate(localDate),
        'occasion_index': occasionIndex,
      });
    } else {
      await SupabaseService.client
          .from('medication_occasion_checks')
          .update(values)
          .eq('id', existing['id'] as String);
    }
  }
}
