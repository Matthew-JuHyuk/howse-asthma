import 'dart:typed_data';

import 'case_facts.dart';

DateTime? _ts(Object? v) => v is String ? DateTime.tryParse(v) : null;
int _int(Object? v, [int d = 0]) => v is num ? v.toInt() : d;

class CaseRow {
  const CaseRow({
    required this.id,
    required this.status,
    required this.demo,
    required this.documentRevision,
    required this.factRevision,
    required this.evidenceRevision,
    this.title,
    this.documentKind,
    this.reviewedFactRevision,
    this.submittedOn,
    this.submitMethod,
    this.lastExportedAt,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String? title;

  /// draft / uploaded / processing / needs_review / ready_for_draft /
  /// draft_ready / failed / deleting
  final String status;
  final bool demo;
  final int documentRevision;
  final int factRevision;
  final int evidenceRevision;
  final String? documentKind;
  final int? reviewedFactRevision;
  final String? submittedOn;
  final String? submitMethod;
  final DateTime? lastExportedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  static const columns =
      'id, title, status, demo_mode, current_document_revision, current_fact_revision, '
      'current_evidence_revision, document_kind, reviewed_fact_revision, '
      'user_reported_submitted_on, user_reported_submit_method, last_exported_at, created_at, updated_at';

  factory CaseRow.fromRow(Map row) => CaseRow(
    id: row['id'] as String,
    title: row['title'] as String?,
    status: row['status'] as String? ?? 'draft',
    demo: row['demo_mode'] == true,
    documentRevision: _int(row['current_document_revision']),
    factRevision: _int(row['current_fact_revision']),
    evidenceRevision: _int(row['current_evidence_revision']),
    documentKind: row['document_kind'] as String?,
    reviewedFactRevision: (row['reviewed_fact_revision'] as num?)?.toInt(),
    submittedOn: row['user_reported_submitted_on'] as String?,
    submitMethod: row['user_reported_submit_method'] as String?,
    lastExportedAt: _ts(row['last_exported_at']),
    createdAt: _ts(row['created_at']),
    updatedAt: _ts(row['updated_at']),
  );

  CaseRow copyWith({
    String? title,
    String? status,
    int? factRevision,
    int? evidenceRevision,
    int? documentRevision,
    String? documentKind,
    String? submittedOn,
    String? submitMethod,
    DateTime? lastExportedAt,
  }) => CaseRow(
    id: id,
    title: title ?? this.title,
    status: status ?? this.status,
    demo: demo,
    documentRevision: documentRevision ?? this.documentRevision,
    factRevision: factRevision ?? this.factRevision,
    evidenceRevision: evidenceRevision ?? this.evidenceRevision,
    documentKind: documentKind ?? this.documentKind,
    reviewedFactRevision: reviewedFactRevision,
    submittedOn: submittedOn ?? this.submittedOn,
    submitMethod: submitMethod ?? this.submitMethod,
    lastExportedAt: lastExportedAt ?? this.lastExportedAt,
    createdAt: createdAt,
    updatedAt: DateTime.now().toUtc(),
  );
}

class RequirementStatus {
  static const needed = 'needed';
  static const linked = 'linked';
  static const askedCareTeam = 'asked_care_team';
  static const notAvailable = 'not_available';
  static const notApplicable = 'not_applicable';

  /// Items that no longer need an action from the patient in the app.
  static bool isSettled(String s) => s != needed;
}

class CaseRequirement {
  const CaseRequirement({
    required this.id,
    required this.label,
    required this.origin,
    required this.status,
    required this.responsible,
    this.sourcePage,
    this.sourceQuote,
    this.linkedEvidenceId,
    this.note,
    this.sortOrder = 0,
  });

  final String id;
  final String label;

  /// extracted / user_added
  final String origin;
  final String status;

  /// patient / care_team / insurer / unknown
  final String responsible;
  final int? sourcePage;
  final String? sourceQuote;
  final String? linkedEvidenceId;
  final String? note;
  final int sortOrder;

  static const columns =
      'id, label, origin, status, responsible, source_page, source_quote, linked_evidence_id, note, sort_order';

  factory CaseRequirement.fromRow(Map row) => CaseRequirement(
    id: row['id'] as String,
    label: row['label'] as String,
    origin: row['origin'] as String? ?? 'extracted',
    status: row['status'] as String? ?? RequirementStatus.needed,
    responsible: row['responsible'] as String? ?? 'unknown',
    sourcePage: (row['source_page'] as num?)?.toInt(),
    sourceQuote: row['source_quote'] as String?,
    linkedEvidenceId: row['linked_evidence_id'] as String?,
    note: row['note'] as String?,
    sortOrder: _int(row['sort_order']),
  );

  CaseRequirement copyWith({
    String? status,
    String? linkedEvidenceId,
    bool clearLink = false,
    String? note,
  }) => CaseRequirement(
    id: id,
    label: label,
    origin: origin,
    status: status ?? this.status,
    responsible: responsible,
    sourcePage: sourcePage,
    sourceQuote: sourceQuote,
    linkedEvidenceId: clearLink
        ? null
        : (linkedEvidenceId ?? this.linkedEvidenceId),
    note: note ?? this.note,
    sortOrder: sortOrder,
  );
}

/// One record summary attached to a case. The snapshot is frozen at attach
/// time so later record edits do not silently change a generated packet.
class EvidenceItem {
  const EvidenceItem({
    required this.id,
    required this.recordType,
    required this.snapshot,
    required this.sourceType,
    this.from,
    this.to,
  });

  final String id;

  /// medication_summary / symptom_summary / local_context
  final String recordType;
  final Map<String, Object?> snapshot;

  /// patient_reported / provider_observation / synthetic
  final String sourceType;
  final String? from;
  final String? to;

  factory EvidenceItem.fromRow(Map row) {
    final range = row['date_range'];
    return EvidenceItem(
      id: row['id'] as String,
      recordType: row['original_record_type'] as String,
      snapshot: Map<String, Object?>.from(
        row['snapshot_json'] as Map? ?? const {},
      ),
      sourceType: row['source_type'] as String? ?? 'patient_reported',
      from: range is Map ? range['from'] as String? : null,
      to: range is Map ? range['to'] as String? : null,
    );
  }
}

class CaseJob {
  const CaseJob({
    required this.id,
    required this.status,
    required this.attempts,
    this.step,
    this.errorCode,
    this.leaseUntil,
    this.startedAt,
    this.finishedAt,
    this.durationMs,
    this.model,
  });

  final String id;

  /// queued / running / succeeded / failed / cancelled
  final String status;

  /// queued / reading / checking / ready / failed
  final String? step;
  final int attempts;
  final String? errorCode;
  final DateTime? leaseUntil;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final int? durationMs;
  final String? model;

  static const maxAttempts = 5;

  bool get active => status == 'queued' || status == 'running';
  bool get failed => status == 'failed' || status == 'cancelled';

  bool leaseExpired(DateTime now) =>
      status == 'running' &&
      leaseUntil != null &&
      leaseUntil!.isBefore(now.toUtc());

  /// Temporary provider/network trouble that a new attempt may fix.
  bool get retryable {
    if (attempts >= maxAttempts) return false;
    const temporary = {
      'ai_rate_limited',
      'ai_unavailable',
      'ai_timeout',
      'ai_network_error',
      'ai_bad_output',
      'ai_empty_output',
      'ai_incomplete',
      'save_failed',
      'document_download_failed',
      'documents_lookup_failed',
      'internal_error',
      'lease_expired',
    };
    return temporary.contains(errorCode);
  }

  /// The pages themselves need to be replaced.
  bool get needsNewPages =>
      errorCode == 'document_unreadable' ||
      errorCode == 'too_many_pages' ||
      errorCode == 'document_too_large' ||
      errorCode == 'ai_input_too_large';

  static const columns =
      'id, status, step, attempt_count, error_code, lease_until, started_at, finished_at, duration_ms, model, created_at';

  factory CaseJob.fromRow(Map row) => CaseJob(
    id: row['id'] as String,
    status: row['status'] as String,
    step: row['step'] as String?,
    attempts: _int(row['attempt_count']),
    errorCode: row['error_code'] as String?,
    leaseUntil: _ts(row['lease_until']),
    startedAt: _ts(row['started_at']),
    finishedAt: _ts(row['finished_at']),
    durationMs: (row['duration_ms'] as num?)?.toInt(),
    model: row['model'] as String?,
  );
}

class CaseArtifact {
  const CaseArtifact({
    required this.id,
    required this.type,
    required this.factRevision,
    required this.status,
    required this.isSample,
    this.evidenceRevision,
    this.objectPath,
    this.createdAt,
    this.includes = const [],
  });

  final String id;

  /// review_packet
  final String type;
  final int factRevision;
  final int? evidenceRevision;
  final String status;
  final bool isSample;
  final String? objectPath;
  final DateTime? createdAt;
  final List<String> includes;

  static const columns =
      'id, type, fact_revision, evidence_revision, status, is_sample, object_path, created_at, includes';

  factory CaseArtifact.fromRow(Map row) {
    final inc = row['includes'];
    return CaseArtifact(
      id: row['id'] as String,
      type: row['type'] as String,
      factRevision: _int(row['fact_revision']),
      evidenceRevision: (row['evidence_revision'] as num?)?.toInt(),
      status: row['status'] as String? ?? 'ready',
      isSample: row['is_sample'] == true,
      objectPath: row['object_path'] as String?,
      createdAt: _ts(row['created_at']),
      includes: inc is List ? inc.whereType<String>().toList() : const [],
    );
  }

  bool isCurrentFor(CaseRow c) =>
      status == 'ready' &&
      factRevision == c.factRevision &&
      (evidenceRevision ?? 0) == c.evidenceRevision;
}

class LetterPage {
  const LetterPage({required this.pageNumber, this.text, this.legibility});

  final int pageNumber;
  final String? text;
  final String? legibility;
}

class LetterFile {
  const LetterFile({
    required this.objectPath,
    required this.mime,
    required this.fileIndex,
    this.bytes,
  });

  final String objectPath;
  final String mime;
  final int fileIndex;

  /// Only set for demo cases (bundled text).
  final Uint8List? bytes;
}

class CaseDetail {
  const CaseDetail({
    required this.row,
    required this.requirements,
    required this.evidence,
    required this.artifacts,
    required this.pages,
    required this.files,
    this.facts,
    this.job,
  });

  final CaseRow row;
  final CaseFacts? facts;
  final List<CaseRequirement> requirements;
  final List<EvidenceItem> evidence;
  final List<CaseArtifact> artifacts;
  final List<LetterPage> pages;
  final List<LetterFile> files;
  final CaseJob? job;

  CaseArtifact? get latestPacket {
    final list = artifacts.where((a) => a.type == 'review_packet').toList()
      ..sort(
        (a, b) =>
            (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)),
      );
    return list.isEmpty ? null : list.first;
  }

  int get requirementsSettled =>
      requirements.where((r) => RequirementStatus.isSettled(r.status)).length;
}

/// A short line for lists: counts of real next actions, never a score.
class CaseSummary {
  const CaseSummary({
    required this.row,
    this.factsToConfirm = 0,
    this.requirementsTotal = 0,
    this.requirementsSettled = 0,
    this.deadline,
  });

  final CaseRow row;
  final int factsToConfirm;
  final int requirementsTotal;
  final int requirementsSettled;
  final DeadlineView? deadline;
}

/// A page the user captured or picked, ready to upload.
class PreparedPage {
  PreparedPage({
    required this.bytes,
    required this.mime,
    required this.name,
    this.pageCount,
  });

  Uint8List bytes;
  final String mime;
  final String name;

  /// Known for PDFs after inspection; images are one page.
  final int? pageCount;

  bool get isImage => mime.startsWith('image/');
}
