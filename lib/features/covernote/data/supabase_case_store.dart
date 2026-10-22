import 'dart:async';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase/supabase_service.dart';
import '../../assessments/data/pdc_repository.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../../records/data/regimen_repository.dart';
import '../../records/data/symptom_repository.dart';
import '../../records/domain/record_models.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../domain/record_snapshot.dart';
import '../domain/s9_models.dart';
import 'case_store.dart';

const _bucket = 'appeal-documents';
const _legacyCaseColumns =
    'id, title, status, demo_mode, current_document_revision, current_fact_revision, '
    'current_evidence_revision, document_kind, reviewed_fact_revision, '
    'user_reported_submitted_on, user_reported_submit_method, last_exported_at, created_at, updated_at';

class SupabaseCaseStore implements CaseStore {
  SupabaseCaseStore();

  SupabaseClient get _db => SupabaseService.client;

  String get _uid {
    final id = SupabaseService.currentUser?.id;
    if (id == null) throw const CaseStoreException('not_signed_in');
    return id;
  }

  @override
  bool get isDemo => false;

  @override
  DateTime get today {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on CaseStoreException {
      rethrow;
    } on PostgrestException catch (e) {
      throw CaseStoreException(
        e.code == '42501' ? 'forbidden' : 'db_${e.code ?? 'error'}',
      );
    } on StorageException catch (e) {
      throw CaseStoreException('storage_${e.statusCode ?? 'error'}');
    } on AuthException catch (_) {
      throw const CaseStoreException('session_expired');
    } on TimeoutException {
      throw const CaseStoreException('network');
    } catch (e) {
      final s = e.toString();
      if (s.contains('SocketException') ||
          s.contains('ClientException') ||
          s.contains('Failed host lookup')) {
        throw const CaseStoreException('network');
      }
      rethrow;
    }
  }

  @override
  Future<List<CaseSummary>> listCases() => _guard(() async {
    List rows;
    try {
      rows = await _db
          .from('appeal_cases')
          .select(CaseRow.columns)
          .eq('owner_id', _uid)
          .neq('status', 'deleting')
          .order('updated_at', ascending: false)
          .limit(80) as List;
    } catch (_) {
      rows = await _db
          .from('appeal_cases')
          .select(_legacyCaseColumns)
          .eq('owner_id', _uid)
          .neq('status', 'deleting')
          .order('updated_at', ascending: false)
          .limit(80) as List;
    }
    final cases = [for (final r in rows) CaseRow.fromRow(r as Map)];
    if (cases.isEmpty) return const <CaseSummary>[];
    final ids = cases.map((c) => c.id).toList();
    final facts = await _db
        .from('case_facts')
        .select('case_id, revision, structured_json')
        .inFilter('case_id', ids);
    final reqs = await _db
        .from('case_requirements')
        .select('case_id, status')
        .inFilter('case_id', ids);
    return [
      for (final c in cases)
        () {
          final f = (facts as List)
              .cast<Map>()
              .where(
                (x) => x['case_id'] == c.id && x['revision'] == c.factRevision,
              )
              .map((x) => CaseFacts.fromJson(x['structured_json'] as Map))
              .firstOrNull;
          final rs = (reqs as List)
              .cast<Map>()
              .where((x) => x['case_id'] == c.id)
              .toList();
          final plan = c.planName ?? f?.field('plan_name').value;
          return CaseSummary(
            row: plan == null || plan.isEmpty
                ? c
                : c.copyWith(planName: plan),
            factsToConfirm: f?.factsToConfirm ?? 0,
            requirementsTotal: rs.length,
            requirementsSettled: rs
                .where(
                  (x) => RequirementStatus.isSettled(x['status'] as String),
                )
                .length,
            deadline: f == null || !f.deadlineState.confirmed
                ? null
                : resolveDeadline(f),
          );
        }(),
    ];
  });

  Future<Map<String, dynamic>> _caseRow(String caseId) async {
    try {
      final row = await _db
          .from('appeal_cases')
          .select(CaseRow.columns)
          .eq('id', caseId)
          .maybeSingle();
      if (row == null) throw const CaseStoreException('case_not_found');
      return Map<String, dynamic>.from(row);
    } catch (e) {
      if (e is CaseStoreException) rethrow;
      final row = await _db
          .from('appeal_cases')
          .select(_legacyCaseColumns)
          .eq('id', caseId)
          .maybeSingle();
      if (row == null) throw const CaseStoreException('case_not_found');
      return Map<String, dynamic>.from(row);
    }
  }

  @override
  Future<CaseDetail> load(String caseId) => _guard(() async {
    final row = await _caseRow(caseId);
    final c = CaseRow.fromRow(row);
    final results = await Future.wait([
      c.factRevision > 0
          ? _db
                .from('case_facts')
                .select('structured_json')
                .eq('case_id', caseId)
                .eq('revision', c.factRevision)
                .maybeSingle()
          : Future.value(null),
      _db
          .from('case_requirements')
          .select(CaseRequirement.columns)
          .eq('case_id', caseId)
          .order('sort_order')
          .order('created_at'),
      _db
          .from('case_evidence')
          .select(
            'id, original_record_type, snapshot_json, source_type, date_range',
          )
          .eq('case_id', caseId)
          .order('created_at'),
      _db
          .from('generated_artifacts')
          .select(CaseArtifact.columns)
          .eq('case_id', caseId)
          .order('created_at', ascending: false),
      _db
          .from('document_pages')
          .select('page_number, extracted_text, legibility')
          .eq('case_id', caseId)
          .eq('set_revision', c.documentRevision)
          .order('page_number'),
      _db
          .from('case_documents')
          .select('object_path, mime, file_index')
          .eq('case_id', caseId)
          .eq('set_revision', c.documentRevision)
          .order('file_index'),
      c.documentRevision > 0
          ? _db
                .from('processing_jobs')
                .select(CaseJob.columns)
                .eq('case_id', caseId)
                .eq('kind', 'extract')
                .eq('idempotency_key', 'extract:set${c.documentRevision}')
                .maybeSingle()
          : Future.value(null),
    ]);
    final factsRow = results[0] as Map?;
    return CaseDetail(
      row: c,
      facts: factsRow == null
          ? null
          : CaseFacts.fromJson(factsRow['structured_json'] as Map),
      requirements: [
        for (final r in results[1] as List) CaseRequirement.fromRow(r as Map),
      ],
      evidence: [
        for (final r in results[2] as List) EvidenceItem.fromRow(r as Map),
      ],
      artifacts: [
        for (final r in results[3] as List) CaseArtifact.fromRow(r as Map),
      ],
      pages: [
        for (final r in results[4] as List)
          LetterPage(
            pageNumber: ((r as Map)['page_number'] as num?)?.toInt() ?? 0,
            text: r['extracted_text'] as String?,
            legibility: r['legibility'] as String?,
          ),
      ],
      files: [
        for (final r in results[5] as List)
          LetterFile(
            objectPath: (r as Map)['object_path'] as String,
            mime: r['mime'] as String,
            fileIndex: (r['file_index'] as num).toInt(),
          ),
      ],
      job: results[6] == null ? null : CaseJob.fromRow(results[6] as Map),
    );
  });

  Future<void> _uploadSet(
    String caseId,
    int setRevision,
    List<PreparedPage> pages,
  ) async {
    final uid = _uid;
    final maxRev = await _db
        .from('case_documents')
        .select('revision')
        .eq('case_id', caseId)
        .order('revision', ascending: false)
        .limit(1)
        .maybeSingle();
    var revision = ((maxRev?['revision'] as num?)?.toInt() ?? 0) + 1;
    for (var i = 0; i < pages.length; i++) {
      final p = pages[i];
      final ext = switch (p.mime) {
        'application/pdf' => 'pdf',
        'image/png' => 'png',
        _ => 'jpg',
      };
      final path = '$uid/$caseId/s$setRevision-$i.$ext';
      await _db.storage
          .from(_bucket)
          .uploadBinary(
            path,
            p.bytes,
            fileOptions: FileOptions(contentType: p.mime, upsert: true),
          );
      await _db.from('case_documents').insert({
        'case_id': caseId,
        'owner_id': uid,
        'revision': revision++,
        'set_revision': setRevision,
        'file_index': i,
        'object_path': path,
        'mime': p.mime,
        'bytes': p.bytes.length,
        'sha256': sha256.convert(p.bytes).toString(),
        'upload_status': 'uploaded',
      });
    }
  }

  @override
  Future<String> createFromPages(List<PreparedPage> pages) => _guard(() async {
    final uid = _uid;
    final row = await _db
        .from('appeal_cases')
        .insert({
          'owner_id': uid,
          'status': 'uploaded',
          'current_document_revision': 1,
          'demo_mode': false,
          'ui_language': 'en',
        })
        .select('id')
        .single();
    final caseId = row['id'] as String;
    try {
      await _uploadSet(caseId, 1, pages);
    } catch (_) {
      try {
        await _removeCase(uid, caseId);
      } catch (_) {
        // The case stays visible as "needs attention" and can be deleted later.
      }
      rethrow;
    }
    return caseId;
  });

  @override
  Future<int> replacePages(
    String caseId,
    List<PreparedPage> pages,
  ) => _guard(() async {
    final row = await _db
        .from('appeal_cases')
        .select('current_document_revision')
        .eq('id', caseId)
        .single();
    final next = ((row['current_document_revision'] as num?)?.toInt() ?? 0) + 1;
    await _uploadSet(caseId, next, pages);
    await _db
        .from('appeal_cases')
        .update({
          'current_document_revision': next,
          'status': 'uploaded',
          'updated_at': _now(),
        })
        .eq('id', caseId);
    return next;
  });

  @override
  Future<CaseJob?> startAnalysis(
    String caseId,
    int setRevision, {
    bool retry = false,
  }) => _guard(() async {
    try {
      final res = await _db.functions.invoke(
        'analyze-letter',
        body: {
          'action': 'start',
          'case_id': caseId,
          'set_revision': setRevision,
          if (retry) 'retry': true,
        },
      );
      final data = res.data;
      if (data is Map && data['job'] is Map) {
        return CaseJob.fromRow(data['job'] as Map);
      }
      return null;
    } on FunctionException catch (e) {
      final d = e.details;
      final code = d is Map && d['error'] is String
          ? d['error'] as String
          : 'http_${e.status}';
      throw CaseStoreException(code);
    }
  });

  @override
  Future<CaseJob?> currentJob(String caseId, int setRevision) =>
      _guard(() async {
        final row = await _db
            .from('processing_jobs')
            .select(CaseJob.columns)
            .eq('case_id', caseId)
            .eq('kind', 'extract')
            .eq('idempotency_key', 'extract:set$setRevision')
            .maybeSingle();
        return row == null ? null : CaseJob.fromRow(row);
      });

  Future<void> _staleArtifacts(String caseId) async {
    await _db
        .from('generated_artifacts')
        .update({'status': 'stale'})
        .eq('case_id', caseId)
        .eq('status', 'ready');
  }

  @override
  Future<int> saveFacts(String caseId, CaseFacts facts, int baseRevision) =>
      _guard(() async {
        final next = baseRevision + 1;
        try {
          await _db.from('case_facts').insert({
            'case_id': caseId,
            'owner_id': _uid,
            'revision': next,
            'schema_version': factsSchemaVersion,
            'structured_json': facts.toJson(),
          });
        } on PostgrestException catch (e) {
          if (e.code == '23505') throw const CaseStoreException('stale_facts');
          rethrow;
        }
        final med = facts.field('medication').value;
        final updated = await _db
            .from('appeal_cases')
            .update({
              'current_fact_revision': next,
              'document_kind': facts.documentKind.value,
              'title': med == null
                  ? null
                  : (med.length > 160 ? med.substring(0, 160) : med),
              'status': facts.readyForEvidence
                  ? 'ready_for_draft'
                  : 'needs_review',
              'reviewed_fact_revision': facts.readyForEvidence ? next : null,
              'updated_at': _now(),
            })
            .eq('id', caseId)
            .eq('current_fact_revision', baseRevision)
            .select('id');
        if ((updated as List).isEmpty) {
          throw const CaseStoreException('stale_facts');
        }
        await _staleArtifacts(caseId);
        return next;
      });

  Future<void> _bumpEvidence(String caseId) async {
    final row = await _db
        .from('appeal_cases')
        .select('current_evidence_revision')
        .eq('id', caseId)
        .single();
    final next = ((row['current_evidence_revision'] as num?)?.toInt() ?? 0) + 1;
    await _db
        .from('appeal_cases')
        .update({'current_evidence_revision': next, 'updated_at': _now()})
        .eq('id', caseId);
    await _staleArtifacts(caseId);
  }

  @override
  Future<CaseRequirement> updateRequirement(String caseId, CaseRequirement r) =>
      _guard(() async {
        final row = await _db
            .from('case_requirements')
            .update({
              'status': r.status,
              'linked_evidence_id': r.linkedEvidenceId,
              'note': r.note,
              'updated_at': _now(),
            })
            .eq('id', r.id)
            .select(CaseRequirement.columns)
            .single();
        await _bumpEvidence(caseId);
        return CaseRequirement.fromRow(row);
      });

  @override
  Future<CaseRequirement> addRequirement(String caseId, String label) =>
      _guard(() async {
        final row = await _db
            .from('case_requirements')
            .insert({
              'case_id': caseId,
              'owner_id': _uid,
              'label': label.trim(),
              'origin': 'user_added',
              'status': RequirementStatus.needed,
              'responsible': 'unknown',
              'sort_order': 100,
            })
            .select(CaseRequirement.columns)
            .single();
        await _bumpEvidence(caseId);
        return CaseRequirement.fromRow(row);
      });

  @override
  Future<EvidenceItem> attachEvidence(
    String caseId, {
    required String recordType,
    required Map<String, Object?> snapshot,
    required DayRange range,
    required String sourceType,
    List<String> eventIds = const [],
  }) => _guard(() async {
    final row = await _db
        .from('case_evidence')
        .insert({
          'case_id': caseId,
          'owner_id': _uid,
          'original_record_type': recordType,
          'date_range': range.toJson(),
          'snapshot_json': snapshot,
          'source_type': sourceType,
          'included': true,
          if (eventIds.isNotEmpty) 'source_event_ids': eventIds,
        })
        .select(
          'id, original_record_type, snapshot_json, source_type, date_range',
        )
        .single();
    await _bumpEvidence(caseId);
    return EvidenceItem.fromRow(row);
  });

  @override
  Future<void> removeEvidence(String caseId, String evidenceId) =>
      _guard(() async {
        await _db
            .from('case_requirements')
            .update({
              'linked_evidence_id': null,
              'status': RequirementStatus.needed,
              'updated_at': _now(),
            })
            .eq('case_id', caseId)
            .eq('linked_evidence_id', evidenceId);
        await _db.from('case_evidence').delete().eq('id', evidenceId);
        await _bumpEvidence(caseId);
      });

  @override
  Future<CaseArtifact> savePacket(
    String caseId,
    Uint8List bytes, {
    required int factRevision,
    required int evidenceRevision,
    required List<String> includes,
    required bool isSample,
  }) => _guard(() async {
    final uid = _uid;
    final path =
        '$uid/$caseId/packet-f$factRevision-e$evidenceRevision-${DateTime.now().millisecondsSinceEpoch}.pdf';
    await _db.storage
        .from(_bucket)
        .uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(
            contentType: 'application/pdf',
            upsert: true,
          ),
        );
    // A packet built from facts that changed meanwhile is stored as stale.
    final current = await _db
        .from('appeal_cases')
        .select('current_fact_revision, current_evidence_revision')
        .eq('id', caseId)
        .maybeSingle();
    if (current == null) throw const CaseStoreException('case_not_found');
    final fresh =
        current['current_fact_revision'] == factRevision &&
        current['current_evidence_revision'] == evidenceRevision;
    if (fresh) await _staleArtifacts(caseId);
    final row = await _db
        .from('generated_artifacts')
        .insert({
          'case_id': caseId,
          'owner_id': uid,
          'type': 'review_packet',
          'language': 'en',
          'fact_revision': factRevision,
          'evidence_revision': evidenceRevision,
          'catalog_versions': <String>[],
          'template_version': 'covernote-packet-1',
          'object_path': path,
          'status': fresh ? 'ready' : 'stale',
          'bytes': bytes.length,
          'sha256': sha256.convert(bytes).toString(),
          'includes': includes,
          'is_sample': isSample,
        })
        .select(CaseArtifact.columns)
        .single();
    if (fresh) {
      await _db
          .from('appeal_cases')
          .update({'status': 'draft_ready', 'updated_at': _now()})
          .eq('id', caseId);
    }
    return CaseArtifact.fromRow(row);
  });

  @override
  Future<Uint8List?> loadPacketBytes(String caseId, CaseArtifact artifact) =>
      _guard(() async {
        final path = artifact.objectPath;
        if (path == null) return null;
        return _db.storage.from(_bucket).download(path);
      });

  @override
  Future<void> markExported(String caseId) => _guard(() async {
    await _db
        .from('appeal_cases')
        .update({'last_exported_at': _now()})
        .eq('id', caseId);
  });

  @override
  Future<void> markSubmitted(
    String caseId, {
    required String date,
    required String method,
  }) => _guard(() async {
    await _db
        .from('appeal_cases')
        .update({
          'user_reported_submitted_on': date,
          'user_reported_submit_method': method.length > 80
              ? method.substring(0, 80)
              : method,
          'updated_at': _now(),
        })
        .eq('id', caseId);
  });

  @override
  Future<void> deleteCase(String caseId) =>
      _guard(() => _removeCase(_uid, caseId));

  Future<void> _removeCase(String uid, String caseId) async {
    await _db
        .from('appeal_cases')
        .update({'status': 'deleting', 'updated_at': _now()})
        .eq('id', caseId);
    final folder = '$uid/$caseId';
    while (true) {
      final files = await _db.storage
          .from(_bucket)
          .list(path: folder, searchOptions: const SearchOptions(limit: 100));
      final paths = [
        for (final f in files)
          if (f.id != null) '$folder/${f.name}',
      ];
      if (paths.isEmpty) break;
      await _db.storage.from(_bucket).remove(paths);
      if (files.length < 100) break;
    }
    await _db.from('appeal_cases').delete().eq('id', caseId);
  }

  @override
  Future<Uint8List?> loadFile(LetterFile file) => _guard(() async {
    return _db.storage.from(_bucket).download(file.objectPath);
  });

  @override
  Future<RecordSnapshots> loadSnapshots(DayRange range) => _guard(() async {
    final uid = _uid;
    final results = await Future.wait([
      RegimenRepository().listAll(),
      RegimenRepository().listBetween(range.from, range.to),
      InhalerEventRepository().listBetween(range.from, range.to),
      SymptomRepository().listBetween(range.from, range.to),
      _db
          .from('local_context_entries')
          .select(
            'local_date, kind, value_kind, is_synthetic, aqi_value, numeric_value, unit, source_name, place_label, report_code, observed_at',
          )
          .eq('patient_id', uid)
          .gte('local_date', isoDate(range.from))
          .lte('local_date', isoDate(range.to)),
      PdcRepository().listBetween(range.from, range.to),
    ]);
    final regimens = results[0] as List<MedicationRegimen>;
    final checks = results[1] as List<OccasionCheck>;
    final pdc = results[5] as List<MedCheckRecord>;
    final extraChecks = <OccasionInput>[
      for (final p in pdc)
        if (p.status == MedCheckRecord.used)
          OccasionInput('pdc:${p.id}', p.date, 'used')
        else if (p.status == MedCheckRecord.notUsed)
          OccasionInput('pdc:${p.id}', p.date, 'not_used'),
    ];
    final pdcRegimens = [
      for (final p in pdc)
        if (p.status == MedCheckRecord.used ||
            p.status == MedCheckRecord.notUsed)
          RegimenInput(
            id: 'pdc:${p.id}',
            medicationName: 'Daily medication check',
            occasionsPerDay: 1,
            puffsPerOccasion: 0,
            effectiveFrom: p.date,
            effectiveUntil: p.date,
          ),
    ];
    return RecordSnapshots(
      medication: MedicationSnapshot.compute(
        range: range,
        regimens: [
          for (final r in regimens)
            if (r.role != 'rescue')
              RegimenInput(
                id: r.id,
                medicationName: r.medicationName ?? '',
                occasionsPerDay: r.occasionsPerDay,
                puffsPerOccasion: r.puffsPerOccasion,
                effectiveFrom: r.effectiveFrom,
                effectiveUntil: r.effectiveUntil,
              ),
          ...pdcRegimens,
        ],
        checks: [
          for (final c in checks)
            OccasionInput(c.regimenId, c.localDate, c.status),
          ...extraChecks,
        ],
        inhaler: results[2] as List<InhalerRecord>,
      ),
      symptoms: SymptomSnapshot.compute(
        range: range,
        entries: results[3] as List<SymptomRecord>,
      ),
      localContext: LocalContextSnapshot.compute(
        range: range,
        entries: [
          for (final r in results[4] as List) localContextFromRow(r as Map),
        ],
      ),
    );
  });

  @override
  Future<bool?> analysisAvailable() async {
    try {
      final res = await _db.functions.invoke(
        'analyze-letter',
        body: {'action': 'health'},
      );
      final d = res.data;
      return d is Map && d['ai_configured'] == true;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> setLifecycle(
    String caseId,
    CaseLifecycle lifecycle, {
    String? outcome,
  }) => _guard(() async {
    await _db
        .from('appeal_cases')
        .update({
          'lifecycle': lifecycleSql(lifecycle),
          'completed_at': lifecycle == CaseLifecycle.completed
              ? _now()
              : null,
          'completed_outcome': lifecycle == CaseLifecycle.completed
              ? outcome
              : null,
          'archived_at': lifecycle == CaseLifecycle.archived ? _now() : null,
          'updated_at': _now(),
        })
        .eq('id', caseId);
  });

  @override
  Future<void> setTreatmentContext(String caseId, TreatmentContext context) =>
      _guard(() async {
        await _db
            .from('appeal_cases')
            .update({
              'treatment_context': treatmentSql(context),
              'updated_at': _now(),
            })
            .eq('id', caseId);
      });

  @override
  Future<void> setAlias(String caseId, String? alias) => _guard(() async {
    await _db
        .from('appeal_cases')
        .update({
          'display_alias': alias,
          'updated_at': _now(),
        })
        .eq('id', caseId);
  });

  static String _now() => DateTime.now().toUtc().toIso8601String();
}

LocalContextInput localContextFromRow(Map r) => LocalContextInput(
  date: DateTime.parse(r['local_date'] as String),
  kind: r['kind'] as String,
  valueKind: r['value_kind'] as String,
  isSynthetic: r['is_synthetic'] == true,
  aqi: (r['aqi_value'] as num?)?.toInt(),
  numericValue: (r['numeric_value'] as num?)?.toDouble(),
  unit: r['unit'] as String?,
  sourceName: r['source_name'] as String?,
  placeLabel: r['place_label'] as String?,
  reportCode: r['report_code'] as String?,
  observedAt: r['observed_at'] is String
      ? DateTime.tryParse(r['observed_at'] as String)
      : null,
);
