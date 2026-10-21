import '../../../core/supabase/supabase_service.dart';
import '../../records/domain/record_models.dart';

/// Daily self-reported medication check (not a pharmacy-claims PDC).
class PdcRepository {
  PdcRepository();

  /// Local calendar date YYYY-MM-DD (not UTC — US evenings must not roll day).
  static String localDateString([DateTime? now]) =>
      isoDate((now ?? DateTime.now()).toLocal());

  Future<MedCheckRecord?> upsert({
    required DateTime date,
    required String status,
    String? reason,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    final row = await SupabaseService.client
        .from('pdc_daily_checks')
        .upsert({
          'patient_id': userId,
          'check_date': isoDate(date),
          'status': status,
          'reason': status == MedCheckRecord.notUsed ? reason : null,
          'taken': switch (status) {
            MedCheckRecord.used => true,
            MedCheckRecord.notUsed => false,
            _ => null,
          },
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        }, onConflict: 'patient_id,check_date')
        .select()
        .single();
    return MedCheckRecord.fromRow(Map<String, dynamic>.from(row as Map));
  }

  Future<void> delete(String id) async {
    await SupabaseService.client.from('pdc_daily_checks').delete().eq('id', id);
  }

  Future<List<MedCheckRecord>> listBetween(DateTime start, DateTime end) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];
    final rows = await SupabaseService.client
        .from('pdc_daily_checks')
        .select('id, check_date, taken, status, reason, updated_at')
        .eq('patient_id', userId)
        .gte('check_date', isoDate(start))
        .lte('check_date', isoDate(end))
        .order('check_date', ascending: false);
    return (rows as List)
        .map((r) => MedCheckRecord.fromRow(Map<String, dynamic>.from(r as Map)))
        .whereType<MedCheckRecord>()
        .toList();
  }

  Future<MedCheckRecord?> today() async {
    final now = DateTime.now();
    final list = await listBetween(now, now);
    return list.isEmpty ? null : list.first;
  }
}
