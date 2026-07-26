import '../../../core/supabase/supabase_service.dart';

class NotificationPrefsRepository {
  NotificationPrefsRepository();

  Future<Map<String, dynamic>> getOrCreate() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    final existing = await SupabaseService.client
        .from('notification_preferences')
        .select()
        .eq('patient_id', userId)
        .maybeSingle();
    if (existing != null) {
      return Map<String, dynamic>.from(existing as Map);
    }

    final inserted = await SupabaseService.client
        .from('notification_preferences')
        .insert({'patient_id': userId})
        .select()
        .single();
    return Map<String, dynamic>.from(inserted as Map);
  }

  Future<void> update({
    bool? pushRiskGe3,
    bool? pushLocationEntry,
    bool? pushSavedLocationChange,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    final patch = <String, dynamic>{
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'push_risk_ge3': ?pushRiskGe3,
      'push_location_entry': ?pushLocationEntry,
      'push_saved_location_change': ?pushSavedLocationChange,
    };

    await SupabaseService.client
        .from('notification_preferences')
        .upsert({'patient_id': userId, ...patch});
  }
}
