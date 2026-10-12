import '../../../core/supabase/supabase_service.dart';
import '../domain/record_models.dart';

/// Patient-entered medication names ("My medications").
class MedicationRepository {
  MedicationRepository();

  static const _columns = 'id, display_name, is_default, daily_check_enabled';

  Future<List<PatientMedication>> list() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];
    final rows = await SupabaseService.client
        .from('patient_medications')
        .select(_columns)
        .eq('patient_id', userId)
        .order('is_default', ascending: false)
        .order('created_at');
    return (rows as List)
        .map(
          (r) => PatientMedication.fromRow(Map<String, dynamic>.from(r as Map)),
        )
        .toList();
  }

  Future<PatientMedication?> defaultMedication() async {
    final all = await list();
    for (final m in all) {
      if (m.isDefault) return m;
    }
    return null;
  }

  Future<bool> dailyCheckEnabled() async {
    final all = await list();
    return all.any((m) => m.dailyCheckEnabled);
  }

  Future<PatientMedication> save({
    String? id,
    required String displayName,
    required bool isDefault,
    required bool dailyCheckEnabled,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');
    final table = SupabaseService.client.from('patient_medications');
    if (isDefault) {
      // Only one default per patient (partial unique index).
      var clear = table
          .update({'is_default': false})
          .eq('patient_id', userId)
          .eq('is_default', true);
      if (id != null) clear = clear.neq('id', id);
      await clear;
    }
    final values = {
      'display_name': displayName.trim(),
      'is_default': isDefault,
      'daily_check_enabled': dailyCheckEnabled,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
    final row = id == null
        ? await table
              .insert({...values, 'patient_id': userId})
              .select(_columns)
              .single()
        : await table.update(values).eq('id', id).select(_columns).single();
    return PatientMedication.fromRow(Map<String, dynamic>.from(row as Map));
  }

  Future<void> delete(String id) async {
    await SupabaseService.client
        .from('patient_medications')
        .delete()
        .eq('id', id);
  }
}
