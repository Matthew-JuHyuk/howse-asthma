import '../../../core/supabase/supabase_service.dart';

class CareReport {
  const CareReport({
    required this.id,
    required this.occurredAt,
    required this.kind,
    this.note,
    this.hasAttachment = false,
    this.clinicianConfirmed = false,
  });

  final String id;
  final DateTime occurredAt;
  final String kind;
  final String? note;
  final bool hasAttachment;
  final bool clinicianConfirmed;

  factory CareReport.fromRow(Map<String, dynamic> row) => CareReport(
    id: row['id'] as String,
    occurredAt:
        DateTime.tryParse(row['occurred_at'] as String? ?? '') ??
        DateTime.now().toUtc(),
    kind: row['kind'] as String,
    note: row['note'] as String?,
    hasAttachment: row['has_attachment'] == true,
    clinicianConfirmed: row['clinician_confirmed'] == true,
  );
}

class CareReportRepository {
  static const kinds = ['er', 'urgent_care', 'office', 'other'];

  Future<List<CareReport>> listRecent() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];
    final rows = await SupabaseService.client
        .from('patient_care_reports')
        .select(
          'id, occurred_at, kind, note, has_attachment, clinician_confirmed',
        )
        .eq('patient_id', userId)
        .order('occurred_at', ascending: false)
        .limit(100);
    return (rows as List)
        .map((r) => CareReport.fromRow(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  Future<void> add({
    required DateTime occurredAt,
    required String kind,
    String? note,
    bool hasAttachment = false,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');
    await SupabaseService.client.from('patient_care_reports').insert({
      'patient_id': userId,
      'occurred_at': occurredAt.toUtc().toIso8601String(),
      'kind': kind,
      'note': (note == null || note.trim().isEmpty) ? null : note.trim(),
      'has_attachment': hasAttachment,
      'clinician_confirmed': false,
      'source': 'self_report',
    });
  }
}
