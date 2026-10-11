import '../../../core/supabase/supabase_service.dart';

class VisitQuestion {
  const VisitQuestion({required this.text, this.language});

  final String text;

  /// Locale code the patient typed in (free text is never auto-translated).
  final String? language;

  Map<String, dynamic> toJson() => {'text': text, 'lang': ?language};

  static VisitQuestion? fromJson(Object? raw) {
    if (raw is! Map) return null;
    final text = raw['text'];
    if (text is! String || text.trim().isEmpty) return null;
    return VisitQuestion(text: text, language: raw['lang'] as String?);
  }
}

class VisitPrepDraft {
  const VisitPrepDraft({
    this.periodDays = 7,
    this.questions = const [],
    this.barriers = const {},
    this.barrierOther,
    this.includeSymptoms = true,
    this.includeInhaler = true,
    this.includeMedChecks = true,
    this.includeEnvironment = false,
    this.insuranceNotes = const {},
    this.sourceLanguage,
    this.lastGeneratedAt,
    this.lastGeneratedFingerprint,
  });

  static const maxQuestions = 10;
  static const barrierCodes = [
    'cost',
    'hard_to_get',
    'hard_to_understand',
    'how_to_use',
    'other',
    'none',
    'no_answer',
  ];
  static const insuranceKeys = ['medication_history', 'cost', 'denial_reason'];

  final int periodDays;
  final List<VisitQuestion> questions;
  final Set<String> barriers;
  final String? barrierOther;
  final bool includeSymptoms;
  final bool includeInhaler;
  final bool includeMedChecks;
  final bool includeEnvironment;
  final Map<String, String> insuranceNotes;
  final String? sourceLanguage;
  final DateTime? lastGeneratedAt;
  final String? lastGeneratedFingerprint;

  VisitPrepDraft copyWith({
    int? periodDays,
    List<VisitQuestion>? questions,
    Set<String>? barriers,
    String? barrierOther,
    bool clearBarrierOther = false,
    bool? includeSymptoms,
    bool? includeInhaler,
    bool? includeMedChecks,
    bool? includeEnvironment,
    Map<String, String>? insuranceNotes,
    String? sourceLanguage,
    DateTime? lastGeneratedAt,
    String? lastGeneratedFingerprint,
  }) {
    return VisitPrepDraft(
      periodDays: periodDays ?? this.periodDays,
      questions: questions ?? this.questions,
      barriers: barriers ?? this.barriers,
      barrierOther: clearBarrierOther
          ? null
          : (barrierOther ?? this.barrierOther),
      includeSymptoms: includeSymptoms ?? this.includeSymptoms,
      includeInhaler: includeInhaler ?? this.includeInhaler,
      includeMedChecks: includeMedChecks ?? this.includeMedChecks,
      includeEnvironment: includeEnvironment ?? this.includeEnvironment,
      insuranceNotes: insuranceNotes ?? this.insuranceNotes,
      sourceLanguage: sourceLanguage ?? this.sourceLanguage,
      lastGeneratedAt: lastGeneratedAt ?? this.lastGeneratedAt,
      lastGeneratedFingerprint:
          lastGeneratedFingerprint ?? this.lastGeneratedFingerprint,
    );
  }

  factory VisitPrepDraft.fromRow(Map<String, dynamic> row) {
    final qs = row['questions'];
    final notes = row['insurance_notes'];
    final barriers = row['barriers'];
    final generated = row['last_generated_at'] as String?;
    return VisitPrepDraft(
      periodDays: (row['period_days'] as num?)?.toInt() == 30 ? 30 : 7,
      questions: qs is List
          ? qs.map(VisitQuestion.fromJson).whereType<VisitQuestion>().toList()
          : const [],
      barriers: barriers is List
          ? barriers.whereType<String>().toSet()
          : const <String>{},
      barrierOther: row['barrier_other'] as String?,
      includeSymptoms: row['include_symptoms'] != false,
      includeInhaler: row['include_inhaler'] != false,
      includeMedChecks: row['include_med_checks'] != false,
      includeEnvironment: row['include_environment'] == true,
      insuranceNotes: notes is Map
          ? {
              for (final e in notes.entries)
                if (e.value is String && (e.value as String).trim().isNotEmpty)
                  e.key.toString(): e.value as String,
            }
          : const {},
      sourceLanguage: row['source_language'] as String?,
      lastGeneratedAt: generated == null ? null : DateTime.tryParse(generated),
      lastGeneratedFingerprint: row['last_generated_fingerprint'] as String?,
    );
  }

  Map<String, dynamic> toRow() => {
    'period_days': periodDays,
    'questions': questions.map((q) => q.toJson()).toList(),
    'barriers': barriers.toList(),
    'barrier_other': (barrierOther?.trim().isEmpty ?? true)
        ? null
        : barrierOther!.trim(),
    'include_symptoms': includeSymptoms,
    'include_inhaler': includeInhaler,
    'include_med_checks': includeMedChecks,
    'include_environment': includeEnvironment,
    'insurance_notes': {
      for (final e in insuranceNotes.entries)
        if (e.value.trim().isNotEmpty) e.key: e.value.trim(),
    },
    'source_language': sourceLanguage,
    'last_generated_at': lastGeneratedAt?.toUtc().toIso8601String(),
    'last_generated_fingerprint': lastGeneratedFingerprint,
  };
}

class VisitPrepRepository {
  VisitPrepRepository();

  Future<VisitPrepDraft> load() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const VisitPrepDraft();
    final row = await SupabaseService.client
        .from('visit_prep_drafts')
        .select()
        .eq('patient_id', userId)
        .maybeSingle();
    if (row == null) return const VisitPrepDraft();
    return VisitPrepDraft.fromRow(Map<String, dynamic>.from(row));
  }

  Future<void> save(VisitPrepDraft draft) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');
    await SupabaseService.client.from('visit_prep_drafts').upsert({
      ...draft.toRow(),
      'patient_id': userId,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    }, onConflict: 'patient_id');
  }
}
