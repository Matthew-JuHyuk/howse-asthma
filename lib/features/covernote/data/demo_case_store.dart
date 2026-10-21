import 'dart:convert';
import 'dart:typed_data';

import '../../records/domain/record_models.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../domain/record_snapshot.dart';
import 'case_store.dart';

/// Public demo: three synthetic letters with fixed, pre-checked results and
/// 30 days of synthetic records. Runs on the device only. It never reads a
/// user's file and is not a stand-in for live analysis.
class DemoCaseStore implements CaseStore {
  DemoCaseStore() {
    _reset();
  }

  static final demoToday = DateTime(2026, 10, 20);

  final _cases = <String, _DemoCase>{};
  var _seq = 0;

  @override
  bool get isDemo => true;

  @override
  DateTime get today => demoToday;

  /// Puts the three sample cases back to their starting state.
  void reset() => _reset();

  void _reset() {
    _cases.clear();
    for (final l in demoLetters) {
      final id = 'demo-${l.key}';
      _cases[id] = _DemoCase(
        row: CaseRow(
          id: id,
          title: l.facts.field('medication').value,
          status: 'needs_review',
          demo: true,
          documentRevision: 1,
          factRevision: 1,
          evidenceRevision: 0,
          documentKind: l.facts.kind,
          createdAt: demoToday,
          updatedAt: demoToday,
        ),
        facts: l.facts,
        requirements: [
          for (var i = 0; i < l.facts.requestedItems.length; i++)
            CaseRequirement(
              id: '$id-r$i',
              label: l.facts.requestedItems[i].label,
              origin: 'extracted',
              status: RequirementStatus.needed,
              responsible: _responsible(l.facts.requestedItems[i].label),
              sourcePage: l.facts.requestedItems[i].page,
              sourceQuote: l.facts.requestedItems[i].quote,
              sortOrder: i,
            ),
        ],
        text: l.text,
      );
    }
  }

  static String _responsible(String label) {
    final s = label.toLowerCase();
    if (s.contains('visit note') || s.contains('could not be used')) {
      return 'care_team';
    }
    if (s.contains('medication history')) return 'patient';
    return 'unknown';
  }

  CaseDetail _detail(_DemoCase c) => CaseDetail(
    row: c.row,
    facts: c.facts,
    requirements: List.unmodifiable(c.requirements),
    evidence: List.unmodifiable(c.evidence),
    artifacts: List.unmodifiable(c.artifacts),
    pages: [LetterPage(pageNumber: 1, text: c.text, legibility: 'clear')],
    files: [
      LetterFile(
        objectPath: 'demo',
        mime: 'text/plain',
        fileIndex: 0,
        bytes: Uint8List.fromList(utf8.encode(c.text)),
      ),
    ],
    job: null,
  );

  _DemoCase _get(String id) =>
      _cases[id] ?? (throw const CaseStoreException('case_not_found'));

  @override
  Future<List<CaseSummary>> listCases() async => [
    for (final c in _cases.values)
      CaseSummary(
        row: c.row,
        factsToConfirm: c.facts.factsToConfirm,
        requirementsTotal: c.requirements.length,
        requirementsSettled: c.requirements
            .where((r) => RequirementStatus.isSettled(r.status))
            .length,
        deadline: c.facts.deadlineState.confirmed
            ? resolveDeadline(c.facts)
            : null,
      ),
  ];

  @override
  Future<CaseDetail> load(String caseId) async => _detail(_get(caseId));

  @override
  Future<String> createFromPages(List<PreparedPage> pages) async =>
      throw const CaseStoreException('demo_no_upload');

  @override
  Future<int> replacePages(String caseId, List<PreparedPage> pages) async =>
      throw const CaseStoreException('demo_no_upload');

  @override
  Future<CaseJob?> startAnalysis(
    String caseId,
    int setRevision, {
    bool retry = false,
  }) async => null;

  @override
  Future<CaseJob?> currentJob(String caseId, int setRevision) async => null;

  @override
  Future<int> saveFacts(
    String caseId,
    CaseFacts facts,
    int baseRevision,
  ) async {
    final c = _get(caseId);
    if (c.row.factRevision != baseRevision) {
      throw const CaseStoreException('stale_facts');
    }
    c.facts = facts;
    c.row = c.row.copyWith(
      factRevision: baseRevision + 1,
      title: facts.field('medication').value,
      documentKind: facts.kind,
      status: facts.readyForEvidence ? 'ready_for_draft' : 'needs_review',
    );
    _stale(c);
    return baseRevision + 1;
  }

  void _stale(_DemoCase c) {
    c.artifacts = [
      for (final a in c.artifacts)
        a.status == 'ready'
            ? CaseArtifact(
                id: a.id,
                type: a.type,
                factRevision: a.factRevision,
                evidenceRevision: a.evidenceRevision,
                status: 'stale',
                isSample: a.isSample,
                createdAt: a.createdAt,
                includes: a.includes,
              )
            : a,
    ];
  }

  void _bump(_DemoCase c) {
    c.row = c.row.copyWith(evidenceRevision: c.row.evidenceRevision + 1);
    _stale(c);
  }

  @override
  Future<CaseRequirement> updateRequirement(
    String caseId,
    CaseRequirement r,
  ) async {
    final c = _get(caseId);
    final i = c.requirements.indexWhere((x) => x.id == r.id);
    if (i < 0) throw const CaseStoreException('not_found');
    c.requirements[i] = r;
    _bump(c);
    return r;
  }

  @override
  Future<CaseRequirement> addRequirement(String caseId, String label) async {
    final c = _get(caseId);
    final r = CaseRequirement(
      id: '$caseId-u${_seq++}',
      label: label.trim(),
      origin: 'user_added',
      status: RequirementStatus.needed,
      responsible: 'unknown',
      sortOrder: 100,
    );
    c.requirements.add(r);
    _bump(c);
    return r;
  }

  @override
  Future<EvidenceItem> attachEvidence(
    String caseId, {
    required String recordType,
    required Map<String, Object?> snapshot,
    required DayRange range,
    required String sourceType,
  }) async {
    final c = _get(caseId);
    final e = EvidenceItem(
      id: '$caseId-e${_seq++}',
      recordType: recordType,
      snapshot: snapshot,
      sourceType: sourceType,
      from: isoDate(range.from),
      to: isoDate(range.to),
    );
    c.evidence.add(e);
    _bump(c);
    return e;
  }

  @override
  Future<void> removeEvidence(String caseId, String evidenceId) async {
    final c = _get(caseId);
    c.evidence.removeWhere((e) => e.id == evidenceId);
    for (var i = 0; i < c.requirements.length; i++) {
      if (c.requirements[i].linkedEvidenceId == evidenceId) {
        c.requirements[i] = c.requirements[i].copyWith(
          status: RequirementStatus.needed,
          clearLink: true,
        );
      }
    }
    _bump(c);
  }

  @override
  Future<CaseArtifact> savePacket(
    String caseId,
    Uint8List bytes, {
    required int factRevision,
    required int evidenceRevision,
    required List<String> includes,
    required bool isSample,
  }) async {
    final c = _get(caseId);
    final fresh =
        c.row.factRevision == factRevision &&
        c.row.evidenceRevision == evidenceRevision;
    if (fresh) _stale(c);
    final a = CaseArtifact(
      id: '$caseId-a${_seq++}',
      type: 'review_packet',
      factRevision: factRevision,
      evidenceRevision: evidenceRevision,
      status: fresh ? 'ready' : 'stale',
      isSample: true,
      createdAt: DateTime.now(),
      includes: includes,
    );
    c.artifacts.insert(0, a);
    c.packetBytes[a.id] = bytes;
    if (fresh) c.row = c.row.copyWith(status: 'draft_ready');
    return a;
  }

  @override
  Future<Uint8List?> loadPacketBytes(
    String caseId,
    CaseArtifact artifact,
  ) async => _get(caseId).packetBytes[artifact.id];

  @override
  Future<void> markExported(String caseId) async {
    final c = _get(caseId);
    c.row = c.row.copyWith(lastExportedAt: DateTime.now());
  }

  @override
  Future<void> markSubmitted(
    String caseId, {
    required String date,
    required String method,
  }) async {
    final c = _get(caseId);
    c.row = c.row.copyWith(submittedOn: date, submitMethod: method);
  }

  @override
  Future<void> deleteCase(String caseId) async {
    _cases.remove(caseId);
  }

  @override
  Future<Uint8List?> loadFile(LetterFile file) async => file.bytes;

  @override
  Future<RecordSnapshots> loadSnapshots(DayRange range) async =>
      demoSnapshots(range);

  @override
  Future<bool?> analysisAvailable() async => false;
}

class _DemoCase {
  _DemoCase({
    required this.row,
    required this.facts,
    required this.requirements,
    required this.text,
  });

  CaseRow row;
  CaseFacts facts;
  final List<CaseRequirement> requirements;
  final List<EvidenceItem> evidence = [];
  List<CaseArtifact> artifacts = [];
  final Map<String, Uint8List> packetBytes = {};
  final String text;
}

/// Synthetic records for the demo window, computed with the same code the
/// signed-in path uses. Pattern matches `tool/demo_accounts.mjs`.
RecordSnapshots demoSnapshots(DayRange range) {
  final start = DateTime(2026, 9, 20);
  DateTime day(int i) => DateTime(start.year, start.month, start.day + i);
  const notUsed = {9, 30, 47};
  const unanswered = {14, 15, 38, 52, 53, 59};
  final checks = <OccasionInput>[
    for (var s = 0; s < 60; s++)
      if (!unanswered.contains(s))
        OccasionInput(
          'demo-reg',
          day(s ~/ 2),
          notUsed.contains(s) ? 'not_used' : 'used',
        ),
  ];
  final inhaler = [
    for (final i in const [6, 8, 12, 15, 17, 22, 25, 28])
      InhalerRecord(
        id: 'demo-prn-$i',
        recordedAtUtc: DateTime.utc(day(i).year, day(i).month, day(i).day, 23),
        tzOffsetMinutes: -240,
        medicationLabel: 'DemoRescue',
        medicationStatus: 'identified',
        puffCount: 2,
        useReason: 'symptoms',
      ),
  ];
  const night = {3, 7, 12, 17, 22, 28};
  final symptoms = [
    for (final i in const [1, 3, 4, 7, 9, 12, 14, 17, 19, 22, 25, 28])
      SymptomRecord(
        id: 'demo-sym-$i',
        recordedAtUtc: DateTime.utc(
          day(i).year,
          day(i).month,
          day(i).day + 1,
          1,
        ),
        occurredAtUtc: DateTime.utc(
          day(i).year,
          day(i).month,
          day(i).day + 1,
          1,
        ),
        tzOffsetMinutes: -240,
        symptoms: night.contains(i)
            ? const ['night_waking', 'cough']
            : (i.isOdd ? const ['wheeze'] : const ['cough']),
      ),
  ];
  const missing = {2, 5, 11, 13, 20, 23, 26, 29};
  const high = {4, 10, 18, 24};
  final ctx = <LocalContextInput>[
    for (var i = 0; i < 30; i++)
      if (!missing.contains(i))
        LocalContextInput(
          date: day(i),
          kind: 'pm25',
          valueKind: 'observation',
          isSynthetic: true,
          aqi: high.contains(i) ? 104 + i : 38 + ((i * 7) % 45),
          unit: 'AQI',
          sourceName: 'Synthetic fixture (no real station)',
          placeLabel: 'Sample town, NJ',
        ),
    for (final i in const [9, 21])
      LocalContextInput(
        date: day(i),
        kind: 'user_report',
        valueKind: 'user_report',
        isSynthetic: true,
        reportCode: 'damp_musty',
      ),
  ];
  return RecordSnapshots(
    medication: MedicationSnapshot.compute(
      range: range,
      regimens: [
        RegimenInput(
          id: 'demo-reg',
          medicationName: 'DemoController A 100 mcg',
          occasionsPerDay: 2,
          puffsPerOccasion: 2,
          effectiveFrom: start,
        ),
      ],
      checks: checks,
      inhaler: inhaler,
    ),
    symptoms: SymptomSnapshot.compute(range: range, entries: symptoms),
    localContext: LocalContextSnapshot.compute(range: range, entries: ctx),
  );
}

class DemoLetter {
  const DemoLetter(this.key, this.text, this.facts);

  final String key;
  final String text;
  final CaseFacts facts;
}

Fact _f(String value, String quote) =>
    Fact(value: value, page: 1, quote: quote, status: FactStatus.extracted);

CaseFacts _facts({
  required Map<String, Fact> fields,
  required List<ReasonFact> reasons,
  required List<RequestedItemFact> items,
  required List<DeadlineFact> deadlines,
}) => CaseFacts(
  source: 'demo_seed',
  documentKind: const Fact(
    value: 'initial_drug_denial',
    page: 1,
    quote: 'Notice of coverage denial',
    status: FactStatus.extracted,
  ),
  fields: {for (final k in fieldKeys) k: fields[k] ?? const Fact()},
  reasons: reasons,
  requestedItems: items,
  deadlines: deadlines,
  deadlineState: const DeadlineState(),
  pages: const [PageMeta(1, 'clear')],
  warnings: const [],
);

const _header =
    'SAMPLE - SYNTHETIC DEMO LETTER - NOT A REAL INSURANCE NOTICE\n'
    'Notice of coverage denial\n'
    'North Valley Demonstration Plan\n';

final demoLetters = <DemoLetter>[
  DemoLetter(
    'missing-info',
    '${_header}Notice date: October 15, 2026\nMember: Alex Sample\nMember ID: DEMO-SEED-2001\nReference: SEED-2001\n'
        'Requested medication: DemoController A 100 mcg\nDose as submitted: 2 puffs twice daily\nWhat this notice says\n'
        'The request did not include the medication history and recent visit notes requested by this fictional plan.\n'
        'Dates and next steps\nYour written request for review must reach this fictional plan by November 14, 2026.\n'
        'This sample has no real mailing address, website, fax number or phone number.',
    _facts(
      fields: {
        'patient_name': _f('Alex Sample', 'Member: Alex Sample'),
        'plan_name': _f(
          'North Valley Demonstration Plan',
          'North Valley Demonstration Plan',
        ),
        'member_id': _f('DEMO-SEED-2001', 'Member ID: DEMO-SEED-2001'),
        'case_reference': _f('SEED-2001', 'Reference: SEED-2001'),
        'medication': _f(
          'DemoController A 100 mcg',
          'Requested medication: DemoController A 100 mcg',
        ),
        'dose': _f(
          '2 puffs twice daily',
          'Dose as submitted: 2 puffs twice daily',
        ),
        'notice_date': _f('2026-10-15', 'Notice date: October 15, 2026'),
      },
      reasons: const [
        ReasonFact(
          text: 'Medication history and recent visit notes were not included.',
          code: 'missing_information',
          page: 1,
          quote:
              'The request did not include the medication history and recent visit notes requested by this fictional plan.',
        ),
      ],
      items: const [
        RequestedItemFact(
          label: 'Medication history',
          page: 1,
          quote: 'medication history',
        ),
        RequestedItemFact(
          label: 'Recent visit notes',
          page: 1,
          quote: 'recent visit notes',
        ),
      ],
      deadlines: const [
        DeadlineFact(
          purpose: 'review_request',
          kind: 'explicit_date',
          date: '2026-11-14',
          page: 1,
          quote:
              'Your written request for review must reach this fictional plan by November 14, 2026.',
          rawText:
              'Your written request for review must reach this fictional plan by November 14, 2026.',
        ),
      ],
    ),
  ),
  DemoLetter(
    'step-therapy',
    '${_header}Notice date: October 16, 2026\nMember: Alex Sample\nMember ID: DEMO-SEED-2001\nReference: SEED-2002\n'
        'Requested medication: DemoController B 200 mcg\nDose as submitted: 1 puff twice daily\nWhat this notice says\n'
        'The submitted record does not document prior use of the preferred medication or the reason it could not be used. '
        'This is a fictional step-therapy requirement.\n'
        'Please send the prior medication history and the reason the preferred medication could not be used.\n'
        'Dates and next steps\nYour request for review must be received by November 20, 2026.',
    _facts(
      fields: {
        'patient_name': _f('Alex Sample', 'Member: Alex Sample'),
        'plan_name': _f(
          'North Valley Demonstration Plan',
          'North Valley Demonstration Plan',
        ),
        'member_id': _f('DEMO-SEED-2001', 'Member ID: DEMO-SEED-2001'),
        'case_reference': _f('SEED-2002', 'Reference: SEED-2002'),
        'medication': _f(
          'DemoController B 200 mcg',
          'Requested medication: DemoController B 200 mcg',
        ),
        'dose': _f(
          '1 puff twice daily',
          'Dose as submitted: 1 puff twice daily',
        ),
        'notice_date': _f('2026-10-16', 'Notice date: October 16, 2026'),
      },
      reasons: const [
        ReasonFact(
          text:
              'Prior use of the preferred medication, or why it could not be used, is not documented.',
          code: 'step_therapy',
          page: 1,
          quote:
              'The submitted record does not document prior use of the preferred medication or the reason it could not be used.',
        ),
      ],
      items: const [
        RequestedItemFact(
          label: 'Prior medication history',
          page: 1,
          quote: 'Please send the prior medication history',
        ),
        RequestedItemFact(
          label: 'Reason the preferred medication could not be used',
          page: 1,
          quote: 'the reason the preferred medication could not be used',
        ),
      ],
      deadlines: const [
        DeadlineFact(
          purpose: 'review_request',
          kind: 'explicit_date',
          date: '2026-11-20',
          page: 1,
          quote:
              'Your request for review must be received by November 20, 2026.',
          rawText:
              'Your request for review must be received by November 20, 2026.',
        ),
      ],
    ),
  ),
  DemoLetter(
    'received-date',
    '${_header}Notice date: October 17, 2026\nMember: Alex Sample\nMember ID: DEMO-SEED-2001\nReference: SEED-2003\n'
        'Requested medication: DemoController C 80 mcg\nDose as submitted: 2 puffs daily\nWhat this notice says\n'
        'The request did not include recent visit notes.\nDates and next steps\n'
        'You may request review within 30 calendar days after you receive this notice. '
        'The date you received this notice is not recorded here.',
    _facts(
      fields: {
        'patient_name': _f('Alex Sample', 'Member: Alex Sample'),
        'plan_name': _f(
          'North Valley Demonstration Plan',
          'North Valley Demonstration Plan',
        ),
        'member_id': _f('DEMO-SEED-2001', 'Member ID: DEMO-SEED-2001'),
        'case_reference': _f('SEED-2003', 'Reference: SEED-2003'),
        'medication': _f(
          'DemoController C 80 mcg',
          'Requested medication: DemoController C 80 mcg',
        ),
        'dose': _f('2 puffs daily', 'Dose as submitted: 2 puffs daily'),
        'notice_date': _f('2026-10-17', 'Notice date: October 17, 2026'),
      },
      reasons: const [
        ReasonFact(
          text: 'Recent visit notes were not included.',
          code: 'missing_information',
          page: 1,
          quote: 'The request did not include recent visit notes.',
        ),
      ],
      items: const [
        RequestedItemFact(
          label: 'Recent visit notes',
          page: 1,
          quote: 'recent visit notes',
        ),
      ],
      deadlines: const [
        DeadlineFact(
          purpose: 'review_request',
          kind: 'relative',
          durationValue: 30,
          durationUnit: 'calendar_day',
          anchor: 'received_date',
          page: 1,
          quote: 'within 30 calendar days after you receive this notice',
          rawText: 'within 30 calendar days after you receive this notice',
        ),
      ],
    ),
  ),
];
