import '../../../core/locale/locale_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../domain/s9_models.dart';

/// Reads and writes `consent_events`. Existing Sprint 8 letter rows stay valid.
/// Never inserts an accept row unless the user just agreed.
class ConsentRepository {
  Future<bool> hasActive(ConsentPurpose purpose) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return false;
    final purposeSql = consentPurposeSql(purpose);
    try {
      final rows = await SupabaseService.client
          .from('consent_events')
          .select('id, version, revoked_at, accepted_at')
          .eq('owner_id', uid)
          .eq('purpose', purposeSql)
          .order('accepted_at', ascending: false)
          .limit(5);
      for (final r in rows as List) {
        if (r['revoked_at'] != null) continue;
        if (purpose == ConsentPurpose.letter) {
          final v = r['version'] as String?;
          if (v == null || letterConsentVersions.contains(v)) return true;
        } else {
          return true;
        }
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Future<void> accept(ConsentPurpose purpose, {String? locale}) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) throw StateError('not_signed_in');
    final version = switch (purpose) {
      ConsentPurpose.letter => 'covernote-letter-2026-10-s9',
      ConsentPurpose.label => labelConsentVersion,
      ConsentPurpose.translate => translateConsentVersion,
    };
    await SupabaseService.client.from('consent_events').insert({
      'owner_id': uid,
      'purpose': consentPurposeSql(purpose),
      'version': version,
      'locale': locale ?? await LocaleController.savedLanguageCode(),
    });
  }

  Future<void> revoke(ConsentPurpose purpose) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return;
    await SupabaseService.client
        .from('consent_events')
        .update({'revoked_at': DateTime.now().toUtc().toIso8601String()})
        .eq('owner_id', uid)
        .eq('purpose', consentPurposeSql(purpose))
        .isFilter('revoked_at', null);
  }
}
