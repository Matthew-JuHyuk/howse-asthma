import '../../../core/supabase/supabase_service.dart';
import '../domain/record_models.dart';

class SymptomRepository {
  SymptomRepository();

  static const _columns =
      'id, recorded_at, occurred_at, tz_offset_minutes, symptoms, no_symptoms, '
      'other_text, note, home_water, source_language, updated_at';

  Future<SymptomRecord> save({
    String? id,
    required DateTime recordedAt,
    DateTime? occurredAt,
    required List<String> symptoms,
    required bool noSymptoms,
    String? otherText,
    String? note,
    String? homeWater,
    String? sourceLanguage,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');
    final values = <String, dynamic>{
      'recorded_at': recordedAt.toUtc().toIso8601String(),
      'occurred_at': occurredAt?.toUtc().toIso8601String(),
      'tz_offset_minutes': (occurredAt ?? recordedAt)
          .toLocal()
          .timeZoneOffset
          .inMinutes,
      'home_water': homeWater,
      'symptoms': noSymptoms ? <String>[] : symptoms,
      'no_symptoms': noSymptoms,
      'other_text': noSymptoms ? null : _blankToNull(otherText),
      'note': _blankToNull(note),
      'source_language': sourceLanguage,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
    final query = SupabaseService.client.from('symptom_entries');
    final row = id == null
        ? await query
              .insert({...values, 'patient_id': userId})
              .select(_columns)
              .single()
        : await query.update(values).eq('id', id).select(_columns).single();
    return SymptomRecord.fromRow(Map<String, dynamic>.from(row as Map));
  }

  Future<void> delete(String id) async {
    await SupabaseService.client.from('symptom_entries').delete().eq('id', id);
  }

  Future<List<SymptomRecord>> listBetween(DateTime start, DateTime end) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];
    final from = start.subtract(const Duration(days: 1)).toUtc();
    final to = end.add(const Duration(days: 2)).toUtc();
    final rows = await SupabaseService.client
        .from('symptom_entries')
        .select(_columns)
        .eq('patient_id', userId)
        .gte('recorded_at', from.toIso8601String())
        .lt('recorded_at', to.toIso8601String())
        .order('recorded_at', ascending: false)
        .limit(1000);
    return (rows as List)
        .map((r) => SymptomRecord.fromRow(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  static String? _blankToNull(String? s) =>
      (s == null || s.trim().isEmpty) ? null : s.trim();
}
