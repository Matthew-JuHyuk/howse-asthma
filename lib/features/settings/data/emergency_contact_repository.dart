import '../../../core/supabase/supabase_service.dart';

class EmergencyContactRepository {
  EmergencyContactRepository();

  Future<Map<String, dynamic>?> get() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return null;
    final row = await SupabaseService.client
        .from('emergency_contacts')
        .select('patient_id, display_name, phone_e164, updated_at')
        .eq('patient_id', userId)
        .maybeSingle();
    if (row == null) return null;
    return Map<String, dynamic>.from(row as Map);
  }

  Future<void> upsert({
    required String displayName,
    required String phoneE164,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    await SupabaseService.client.from('emergency_contacts').upsert({
      'patient_id': userId,
      'display_name': displayName.trim(),
      'phone_e164': phoneE164.trim(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }
}
