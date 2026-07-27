import '../../core/supabase/supabase_service.dart';

/// Persists FCM device tokens in `device_push_tokens` (RLS: own rows only).
class PushTokenRepository {
  PushTokenRepository();

  Future<void> upsert({
    required String fcmToken,
    required String platform,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    await SupabaseService.client.from('device_push_tokens').upsert(
      {
        'profile_id': userId,
        'fcm_token': fcmToken,
        'platform': platform,
        'last_seen_at': DateTime.now().toUtc().toIso8601String(),
      },
      onConflict: 'profile_id,fcm_token',
    );
  }

  Future<void> deleteToken(String fcmToken) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return;
    await SupabaseService.client
        .from('device_push_tokens')
        .delete()
        .eq('profile_id', userId)
        .eq('fcm_token', fcmToken);
  }

  Future<void> deleteAllForCurrentUser() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return;
    await SupabaseService.client
        .from('device_push_tokens')
        .delete()
        .eq('profile_id', userId);
  }
}
