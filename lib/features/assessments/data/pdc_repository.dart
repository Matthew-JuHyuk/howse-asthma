import '../../../core/supabase/supabase_service.dart';

class PdcRepository {
  PdcRepository();

  /// Local calendar date YYYY-MM-DD (not UTC — US evenings must not roll day).
  static String localDateString([DateTime? now]) {
    final local = (now ?? DateTime.now()).toLocal();
    return '${local.year.toString().padLeft(4, '0')}-'
        '${local.month.toString().padLeft(2, '0')}-'
        '${local.day.toString().padLeft(2, '0')}';
  }

  Future<Map<String, dynamic>> upsertToday({required bool taken}) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    final date = localDateString();

    final upserted = await SupabaseService.client
        .from('pdc_daily_checks')
        .upsert(
          {
            'patient_id': userId,
            'check_date': date,
            'taken': taken,
            'updated_at': DateTime.now().toUtc().toIso8601String(),
          },
          onConflict: 'patient_id,check_date',
        )
        .select()
        .single();
    return Map<String, dynamic>.from(upserted as Map);
  }

  Future<List<Map<String, dynamic>>> listRecent({int days = 30}) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];

    final since = DateTime.now().toLocal().subtract(Duration(days: days));
    final date = localDateString(since);

    final rows = await SupabaseService.client
        .from('pdc_daily_checks')
        .select('id, check_date, taken, updated_at')
        .eq('patient_id', userId)
        .gte('check_date', date)
        .order('check_date', ascending: false);
    return List<Map<String, dynamic>>.from(rows as List);
  }

  Future<bool?> todayTaken() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return null;
    final date = localDateString();
    final row = await SupabaseService.client
        .from('pdc_daily_checks')
        .select('taken')
        .eq('patient_id', userId)
        .eq('check_date', date)
        .maybeSingle();
    if (row == null) return null;
    return row['taken'] as bool?;
  }
}
