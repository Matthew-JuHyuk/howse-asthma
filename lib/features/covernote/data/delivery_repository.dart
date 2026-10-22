import '../../../core/supabase/supabase_service.dart';
import '../domain/s9_models.dart';

class DeliveryRepository {
  Future<List<DeliveryEvent>> listForCase(String caseId) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return const [];
    try {
      final rows = await SupabaseService.client
          .from('delivery_events')
          .select()
          .eq('owner_id', uid)
          .eq('case_id', caseId)
          .order('sent_at', ascending: false);
      return [for (final r in rows as List) DeliveryEvent.fromRow(r as Map)];
    } catch (_) {
      return const [];
    }
  }

  Future<Map<String, List<DeliveryEvent>>> listForCases(
    List<String> caseIds,
  ) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null || caseIds.isEmpty) return const {};
    try {
      final rows = await SupabaseService.client
          .from('delivery_events')
          .select()
          .eq('owner_id', uid)
          .inFilter('case_id', caseIds)
          .order('sent_at', ascending: false);
      final map = <String, List<DeliveryEvent>>{};
      for (final r in rows as List) {
        final e = DeliveryEvent.fromRow(r as Map);
        map.putIfAbsent(e.caseId, () => []).add(e);
      }
      return map;
    } catch (_) {
      return const {};
    }
  }

  Future<DeliveryEvent> record({
    required String caseId,
    required DeliveryRecipient recipient,
    required DeliveryMethod method,
    required DateTime sentAt,
    String? artifactId,
    int? artifactRevision,
    String? note,
  }) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) throw StateError('not_signed_in');
    final row = await SupabaseService.client
        .from('delivery_events')
        .insert({
          'case_id': caseId,
          'owner_id': uid,
          'recipient_type': recipientSql(recipient),
          'method': methodSql(method),
          'sent_at': sentAt.toUtc().toIso8601String(),
          'artifact_id': artifactId,
          'artifact_revision': artifactRevision,
          'note': note,
          'reported_by_user': true,
        })
        .select()
        .single();
    return DeliveryEvent.fromRow(row);
  }

  Future<void> revoke(String id) async {
    await SupabaseService.client
        .from('delivery_events')
        .update({
          'revoked_at': DateTime.now().toUtc().toIso8601String(),
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', id);
  }
}
