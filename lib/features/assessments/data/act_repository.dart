import '../../../core/supabase/supabase_service.dart';

class ActRepository {
  ActRepository();

  Future<Map<String, dynamic>> submit({
    required List<int> answers,
    required String languageUsed,
  }) async {
    if (answers.length != 5) {
      throw ArgumentError('ACT requires 5 answers');
    }
    for (final a in answers) {
      if (a < 1 || a > 5) throw ArgumentError('ACT answer out of range');
    }
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    final total = answers.fold<int>(0, (s, v) => s + v);
    final inserted = await SupabaseService.client
        .from('act_assessments')
        .insert({
          'patient_id': userId,
          'q1': answers[0],
          'q2': answers[1],
          'q3': answers[2],
          'q4': answers[3],
          'q5': answers[4],
          'total_score': total,
          'language_used': languageUsed,
        })
        .select()
        .single();
    return Map<String, dynamic>.from(inserted as Map);
  }

  Future<Map<String, dynamic>?> latest() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return null;
    final row = await SupabaseService.client
        .from('act_assessments')
        .select('id, total_score, submitted_at, language_used')
        .eq('patient_id', userId)
        .order('submitted_at', ascending: false)
        .limit(1)
        .maybeSingle();
    if (row == null) return null;
    return Map<String, dynamic>.from(row as Map);
  }
}
