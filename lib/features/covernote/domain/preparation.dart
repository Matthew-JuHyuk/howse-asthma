import 'dart:convert';
import 'package:crypto/crypto.dart';

enum PreparationPath { newRequest, deniedRequest }

String preparationFingerprint(
  Preparation p,
  List<TreatmentEvent> events, [
  DateTime? today,
]) {
  final fields = p.toJson()
    ..remove('exports')
    ..remove('revision');
  final ordered =
      events.where((e) => !e.undone && e.patientKey == p.patientKey).toList()
        ..sort((a, b) => a.id.compareTo(b.id));
  return sha256
      .convert(
        utf8.encode(
          jsonEncode({
            'window_end': dayKey(today ?? DateTime.now()),
            'preparation': fields,
            'events': ordered.map((e) => e.toJson()).toList(),
          }),
        ),
      )
      .toString();
}

String dayKey(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

/// All relationships reference durable source ids. A link is never eligibility.
class TreatmentEvent {
  TreatmentEvent({
    required this.id,
    required this.patientKey,
    required this.kind,
    required this.day,
    required this.sourceId,
    this.text = '',
    this.values = const {},
    this.synthetic = false,
    this.undone = false,
  });
  final String id, patientKey, kind, day, sourceId, text;
  final Map<String, dynamic> values;
  final bool synthetic, undone;
  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_key': patientKey,
    'kind': kind,
    'day': day,
    'source_id': sourceId,
    'text': text,
    'values': values,
    'synthetic': synthetic,
    'undone': undone,
  };
  factory TreatmentEvent.fromJson(Map j) => TreatmentEvent(
    id: j['id'],
    patientKey: j['patient_key'],
    kind: j['kind'],
    day: j['day'],
    sourceId: j['source_id'],
    text: j['text'] ?? '',
    values: Map<String, dynamic>.from(j['values'] ?? {}),
    synthetic: j['synthetic'] == true,
    undone: j['undone'] == true,
  );
}

class EvidenceNeed {
  EvidenceNeed({
    required this.id,
    required this.label,
    required this.reason,
    required this.origin,
    this.owner = 'care_team',
    this.links = const [],
    this.policyPage,
    this.quote,
    this.state = 'missing',
  });
  final String id, label, reason, origin, owner, state;
  final int? policyPage;
  final String? quote;
  final List<String> links;
  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'reason': reason,
    'origin': origin,
    'owner': owner,
    'links': links,
    'page': policyPage,
    'quote': quote,
    'state': state,
  };
  factory EvidenceNeed.fromJson(Map j) => EvidenceNeed(
    id: j['id'],
    label: j['label'],
    reason: j['reason'],
    origin: j['origin'],
    owner: j['owner'] ?? 'care_team',
    links: List<String>.from(j['links'] ?? []),
    policyPage: j['page'],
    quote: j['quote'],
    state: j['state'] ?? 'missing',
  );
  EvidenceNeed link(List<String> ids) => EvidenceNeed(
    id: id,
    label: label,
    reason: reason,
    origin: origin,
    owner: owner,
    links: ids,
    policyPage: policyPage,
    quote: quote,
    state: ids.isEmpty ? 'missing' : 'linked_unreviewed',
  );
}

class Preparation {
  Preparation({
    required this.id,
    required this.patientKey,
    required this.patientName,
    this.path = PreparationPath.newRequest,
    this.concern = '',
    this.currentMedication = '',
    this.proposedMedication = '',
    this.plan = '',
    this.policyConfirmed = false,
    this.revision = 0,
    this.lifecycle = 'active',
    this.needs = const [],
    this.history = const [],
    this.documents = const [],
    this.exports = const [],
    this.englishFields = const {},
    this.synthetic = false,
  });
  final String id,
      patientKey,
      patientName,
      concern,
      currentMedication,
      proposedMedication,
      plan,
      lifecycle;
  final PreparationPath path;
  final bool policyConfirmed, synthetic;
  final int revision;
  final List<EvidenceNeed> needs;
  final List<Map<String, dynamic>> history, documents, exports;
  final Map<String, String> englishFields;
  bool get applicablePolicy =>
      policyConfirmed &&
      plan.trim().toLowerCase() == 'aetna better health of new jersey' &&
      proposedMedication.trim().toLowerCase() == 'dupixent';
  String get englishTitle => path == PreparationPath.deniedRequest
      ? 'Denial response evidence brief'
      : applicablePolicy
      ? 'Treatment review & initial authorization preparation brief'
      : 'Treatment consultation brief';
  Map<String, dynamic> toJson() => {
    'id': id,
    'patient_key': patientKey,
    'patient_name': patientName,
    'path': path.name,
    'concern': concern,
    'current_medication': currentMedication,
    'proposed_medication': proposedMedication,
    'plan': plan,
    'policy_confirmed': policyConfirmed,
    'revision': revision,
    'lifecycle': lifecycle,
    'needs': needs.map((n) => n.toJson()).toList(),
    'history': history,
    'documents': documents,
    'exports': exports,
    'english_fields': englishFields,
    'synthetic': synthetic,
  };
  factory Preparation.fromJson(Map j) => Preparation(
    id: j['id'],
    patientKey: j['patient_key'],
    patientName: j['patient_name'],
    englishFields: Map<String, String>.from(j['english_fields'] ?? {}),
    path: j['path'] == 'deniedRequest'
        ? PreparationPath.deniedRequest
        : PreparationPath.newRequest,
    concern: j['concern'] ?? '',
    currentMedication: j['current_medication'] ?? '',
    proposedMedication: j['proposed_medication'] ?? '',
    plan: j['plan'] ?? '',
    policyConfirmed: j['policy_confirmed'] == true,
    revision: j['revision'] ?? 0,
    lifecycle: j['lifecycle'] ?? 'active',
    needs: [for (final n in j['needs'] ?? []) EvidenceNeed.fromJson(n)],
    history: [for (final x in j['history'] ?? []) Map<String, dynamic>.from(x)],
    documents: [
      for (final x in j['documents'] ?? []) Map<String, dynamic>.from(x),
    ],
    exports: [for (final x in j['exports'] ?? []) Map<String, dynamic>.from(x)],
    synthetic: j['synthetic'] == true,
  );
  Preparation update(Map<String, dynamic> fields) =>
      Preparation.fromJson({...toJson(), ...fields});
  Preparation clone() => Preparation.fromJson(jsonDecode(jsonEncode(toJson())));
}

const policyUrl =
    'https://www.aetnabetterhealth.com/content/dam/aetna/medicaid/pdfs/formulary/guidelines/Dupixent-Protocol-NJ-ua.pdf';
const policyHash =
    '7f8cb604f95511aea4597fd2d82cb552da319238f0f1c3844ddeed0868141f21';
List<EvidenceNeed> preparationNeeds(bool policy) => [
  EvidenceNeed(
    id: 'treatment',
    label: 'Prior treatment history',
    reason: policy
        ? 'At least 3 months of prior treatment; clinical review required.'
        : 'Help your care team review treatment already tried.',
    origin: policy ? 'applicable_policy' : 'optional_context',
    policyPage: policy ? 1 : null,
  ),
  EvidenceNeed(
    id: 'burden',
    label: 'Symptoms and urgent visits',
    reason: policy
        ? 'Prior 12 months of exacerbations / control. App logs are patient reports.'
        : 'Show what has been difficult and when.',
    origin: policy ? 'applicable_policy' : 'optional_context',
    policyPage: policy ? 2 : null,
  ),
  EvidenceNeed(
    id: 'tests',
    label: 'Test results and clinician assessment',
    reason: 'Ask your care team which tests and clinical records are needed.',
    origin: policy ? 'applicable_policy' : 'optional_context',
    policyPage: policy ? 1 : null,
  ),
];

List<TreatmentEvent> sourceCandidates(
  EvidenceNeed n,
  Preparation p,
  List<TreatmentEvent> events,
) => events.where((e) {
  if (e.undone || e.patientKey != p.patientKey) return false;
  // Short app logs cannot substitute for prescriptions or clinical tests.
  return switch (n.id) {
    'treatment' =>
      e.kind == 'clinical_document' &&
          e.values['document_kind'] == 'prescription',
    'tests' =>
      e.kind == 'clinical_document' &&
          ['lab', 'visit'].contains(e.values['document_kind']),
    _ => [
      'symptom',
      'medication_use',
      'urgent_visit',
      'clinical_document',
    ].contains(e.kind),
  };
}).toList();

class TreatmentSummary {
  TreatmentSummary(
    Preparation p,
    List<TreatmentEvent> all,
    DateTime today, {
    int days = 30,
  }) {
    final start = dayKey(
      DateTime(today.year, today.month, today.day - days + 1),
    );
    final end = dayKey(today);
    events =
        all
            .where(
              (e) =>
                  !e.undone &&
                  e.patientKey == p.patientKey &&
                  e.values['date_unknown'] != true &&
                  e.day.compareTo(start) >= 0 &&
                  e.day.compareTo(end) <= 0,
            )
            .toList()
          ..sort((a, b) => b.day.compareTo(a.day));
    observedDays = events
        .where((e) => e.kind != 'environment' && e.kind != 'clinical_document')
        .map((e) => e.day)
        .toSet()
        .length;
    symptomDays = events
        .where((e) => e.kind == 'symptom' && e.values['negated'] != true)
        .map((e) => e.day)
        .toSet()
        .length;
    rescueUses = events
        .where(
          (e) =>
              e.kind == 'medication_use' && e.values['use_kind'] == 'as_needed',
        )
        .length;
    nightWakings = events
        .where((e) => e.kind == 'symptom')
        .fold<int>(
          0,
          (v, e) => v + ((e.values['night_wakings'] as num?)?.toInt() ?? 0),
        );
  }
  late final List<TreatmentEvent> events;
  late final int observedDays, symptomDays, rescueUses, nightWakings;
}

/// Strictly validates model proposals before they can enter the confirmation UI.
List<Map<String, dynamic>> validateVoiceProposal(
  dynamic raw,
  String transcript,
) {
  if (raw is! List || raw.length > 12) {
    throw const FormatException('invalid_proposal');
  }
  return raw.map((r) {
    if (r is! Map ||
        !['symptom', 'medication_use', 'urgent_visit'].contains(r['kind']) ||
        r['quote'] is! String ||
        (r['quote'] as String).trim().isEmpty ||
        !transcript.contains(r['quote'])) {
      throw const FormatException('unsupported_source');
    }
    final v = Map<String, dynamic>.from(r);
    if (v['night_wakings'] != null &&
        (v['night_wakings'] is! num ||
            v['night_wakings'] < 0 ||
            v['night_wakings'] > 100)) {
      throw const FormatException('invalid_count');
    }
    if (v['quantity'] != null &&
        (v['quantity'] is! num || v['quantity'] <= 0)) {
      throw const FormatException('invalid_quantity');
    }
    if (v['day'] != null) {
      final d = DateTime.tryParse(v['day']);
      if (d == null || dayKey(d) != v['day']) {
        throw const FormatException('invalid_date');
      }
    }
    if (v['negated'] == true && v['kind'] == 'medication_use') v['omit'] = true;
    return v;
  }).toList();
}
