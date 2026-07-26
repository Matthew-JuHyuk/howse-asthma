import '../../../core/supabase/supabase_service.dart';

class PanicRepository {
  PanicRepository();

  Future<Map<String, dynamic>> startEpisode({String? inhalerEventId}) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    final inserted = await SupabaseService.client
        .from('panic_episodes')
        .insert({
          'patient_id': userId,
          if (inhalerEventId != null) 'inhaler_event_id': inhalerEventId,
        })
        .select()
        .single();
    return Map<String, dynamic>.from(inserted as Map);
  }

  Future<void> linkInhalerEvent({
    required String episodeId,
    required String inhalerEventId,
  }) async {
    await SupabaseService.client.from('panic_episodes').update({
      'inhaler_event_id': inhalerEventId,
    }).eq('id', episodeId);
  }

  Future<void> markHelpRequested(String episodeId) async {
    await SupabaseService.client.from('panic_episodes').update({
      'help_requested': true,
    }).eq('id', episodeId);
  }

  Future<void> complete({
    required String episodeId,
    required String outcomeChip,
  }) async {
    await SupabaseService.client.from('panic_episodes').update({
      'ended_at': DateTime.now().toUtc().toIso8601String(),
      'outcome_chip': outcomeChip,
    }).eq('id', episodeId);
  }
}
