/// Structured facts for one coverage-denial case.
///
/// Values are either copied from a document quote or entered by the user.
/// Medication and dose strings are never rewritten.
library;

enum DocumentKind {
  initialDrugDenial,
  finalAppealDenial,
  eobOrBill,
  other,
  uncertain,
}

enum FactStatus { extracted, missing, ambiguous, userEntered }

enum DenialReasonCode {
  missingInformation,
  stepTherapy,
  medicalNecessity,
  formulary,
  eligibilityOrBenefit,
  other,
  unknown,
}

enum CaseStatus {
  draft,
  uploaded,
  processing,
  needsReview,
  readyForDraft,
  draftReady,
  failed,
  deleting,
  deleted,
}

enum ExportMode { review, preparedDraft }

class SourceRef {
  const SourceRef({required this.pageId, required this.quote});

  final String pageId;
  final String quote;
}

class FactValue {
  const FactValue({
    required this.rawText,
    required this.normalizedValue,
    required this.status,
    required this.sourceRefs,
    required this.confirmedByUser,
  });

  final String? rawText;
  final String? normalizedValue;
  final FactStatus status;
  final List<SourceRef> sourceRefs;
  final bool confirmedByUser;

  bool get isPresent => rawText != null && rawText!.trim().isNotEmpty;

  FactValue copyWith({
    String? rawText,
    String? normalizedValue,
    FactStatus? status,
    List<SourceRef>? sourceRefs,
    bool? confirmedByUser,
    bool clearText = false,
  }) {
    return FactValue(
      rawText: clearText ? null : (rawText ?? this.rawText),
      normalizedValue: clearText
          ? null
          : (normalizedValue ?? this.normalizedValue),
      status: status ?? this.status,
      sourceRefs: sourceRefs ?? this.sourceRefs,
      confirmedByUser: confirmedByUser ?? this.confirmedByUser,
    );
  }
}

class DenialReason {
  const DenialReason({
    required this.rawText,
    required this.code,
    required this.sourceRefs,
    required this.confirmedByUser,
  });

  final String rawText;
  final DenialReasonCode code;
  final List<SourceRef> sourceRefs;
  final bool confirmedByUser;

  DenialReason copyWith({bool? confirmedByUser}) {
    return DenialReason(
      rawText: rawText,
      code: code,
      sourceRefs: sourceRefs,
      confirmedByUser: confirmedByUser ?? this.confirmedByUser,
    );
  }
}

enum DeadlineKind { explicitDate, relative, unknown, ambiguous }

/// Date-only deadline description. No universal 180/60-day rule is applied.
class DeadlineInput {
  const DeadlineInput({
    required this.rawText,
    required this.kind,
    required this.explicitDate,
    required this.durationValue,
    required this.durationUnit,
    required this.anchorType,
    required this.receivedDate,
    required this.multipleDeadlinesConflict,
    required this.sourceRefs,
  });

  final String? rawText;
  final DeadlineKind kind;
  final DateTime? explicitDate;
  final int? durationValue;

  /// `calendar_day`, `business_day`, or null.
  final String? durationUnit;

  /// `received_date`, `letter_date`, or null.
  final String? anchorType;
  final DateTime? receivedDate;
  final bool multipleDeadlinesConflict;
  final List<SourceRef> sourceRefs;

  DeadlineInput copyWith({
    DateTime? receivedDate,
    bool clearReceived = false,
  }) {
    return DeadlineInput(
      rawText: rawText,
      kind: kind,
      explicitDate: explicitDate,
      durationValue: durationValue,
      durationUnit: durationUnit,
      anchorType: anchorType,
      receivedDate: clearReceived ? null : (receivedDate ?? this.receivedDate),
      multipleDeadlinesConflict: multipleDeadlinesConflict,
      sourceRefs: sourceRefs,
    );
  }
}

enum DeadlineDisplay {
  documentDate,
  calculatedFromReceived,
  needsReceivedDate,
  notCalculable,
  notFound,
}

class DeadlineOutcome {
  const DeadlineOutcome({
    required this.display,
    required this.date,
    required this.mayShowCountdown,
  });

  final DeadlineDisplay display;
  final DateTime? date;

  /// True only after the user confirms a deterministic date.
  /// A countdown is a calendar difference, not a legal or approval judgment.
  final bool mayShowCountdown;
}

class AppealCase {
  const AppealCase({
    required this.id,
    required this.shortId,
    required this.demoMode,
    required this.fixtureId,
    required this.documentKind,
    required this.pageId,
    required this.pageText,
    required this.patientName,
    required this.medicationRaw,
    required this.doseRaw,
    required this.denialReason,
    required this.memberId,
    required this.caseReference,
    required this.deadline,
    required this.deadlineConfirmedByUser,
    required this.coreReviewed,
    required this.factRevision,
    required this.reviewVersion,
    required this.confirmedFactRevision,
    required this.status,
    required this.createdAt,
    required this.selfReport,
    required this.recordsLinked,
    required this.generatedFactRevision,
    required this.letterText,
    required this.letterMode,
    required this.sharedMarkedSubmitted,
  });

  final String id;
  final String shortId;
  final bool demoMode;
  final String fixtureId;
  final DocumentKind documentKind;
  final String pageId;
  final String pageText;
  final FactValue patientName;
  final FactValue medicationRaw;
  final FactValue doseRaw;
  final DenialReason? denialReason;
  final FactValue memberId;
  final FactValue caseReference;
  final DeadlineInput deadline;
  final bool deadlineConfirmedByUser;
  final bool coreReviewed;
  final int factRevision;
  final int reviewVersion;

  /// Fact revision that the last confirm action applied to. A later edit
  /// invalidates it.
  final int? confirmedFactRevision;
  final CaseStatus status;
  final DateTime createdAt;

  /// Optional patient note. Null means not provided. Never treated as a record.
  final String? selfReport;
  final bool recordsLinked;
  final int? generatedFactRevision;
  final String? letterText;
  final ExportMode? letterMode;

  /// Sharing never sets this. It stays false so a share sheet cannot be
  /// recorded as an insurer submission.
  final bool sharedMarkedSubmitted;

  bool get draftIsCurrent =>
      letterText != null && generatedFactRevision == factRevision;

  bool get preparedMinimumMet =>
      coreReviewed &&
      confirmedFactRevision == factRevision &&
      patientName.confirmedByUser &&
      patientName.isPresent &&
      medicationRaw.confirmedByUser &&
      medicationRaw.isPresent &&
      denialReason != null &&
      denialReason!.confirmedByUser &&
      denialReason!.rawText.trim().isNotEmpty;

  AppealCase copyWith({
    String? pageText,
    FactValue? patientName,
    FactValue? medicationRaw,
    FactValue? doseRaw,
    DenialReason? denialReason,
    bool clearReason = false,
    FactValue? memberId,
    FactValue? caseReference,
    DeadlineInput? deadline,
    bool? deadlineConfirmedByUser,
    bool? coreReviewed,
    int? factRevision,
    int? reviewVersion,
    int? confirmedFactRevision,
    bool clearConfirmedRevision = false,
    CaseStatus? status,
    String? selfReport,
    bool clearSelfReport = false,
    bool? recordsLinked,
    int? generatedFactRevision,
    bool clearGenerated = false,
    String? letterText,
    bool clearLetter = false,
    ExportMode? letterMode,
    bool? sharedMarkedSubmitted,
  }) {
    return AppealCase(
      id: id,
      shortId: shortId,
      demoMode: demoMode,
      fixtureId: fixtureId,
      documentKind: documentKind,
      pageId: pageId,
      pageText: pageText ?? this.pageText,
      patientName: patientName ?? this.patientName,
      medicationRaw: medicationRaw ?? this.medicationRaw,
      doseRaw: doseRaw ?? this.doseRaw,
      denialReason: clearReason ? null : (denialReason ?? this.denialReason),
      memberId: memberId ?? this.memberId,
      caseReference: caseReference ?? this.caseReference,
      deadline: deadline ?? this.deadline,
      deadlineConfirmedByUser:
          deadlineConfirmedByUser ?? this.deadlineConfirmedByUser,
      coreReviewed: coreReviewed ?? this.coreReviewed,
      factRevision: factRevision ?? this.factRevision,
      reviewVersion: reviewVersion ?? this.reviewVersion,
      confirmedFactRevision: clearConfirmedRevision
          ? null
          : (confirmedFactRevision ?? this.confirmedFactRevision),
      status: status ?? this.status,
      createdAt: createdAt,
      selfReport: clearSelfReport ? null : (selfReport ?? this.selfReport),
      recordsLinked: recordsLinked ?? this.recordsLinked,
      generatedFactRevision: clearGenerated
          ? null
          : (generatedFactRevision ?? this.generatedFactRevision),
      letterText: clearLetter ? null : (letterText ?? this.letterText),
      letterMode: clearLetter ? null : (letterMode ?? this.letterMode),
      sharedMarkedSubmitted:
          sharedMarkedSubmitted ?? this.sharedMarkedSubmitted,
    );
  }
}

class AppealFlowException implements Exception {
  AppealFlowException(this.code);
  final String code;
}

class ProcessingJob {
  const ProcessingJob({
    required this.id,
    required this.idempotencyKey,
    required this.inputRevision,
    required this.status,
  });

  final String id;
  final String idempotencyKey;
  final String inputRevision;
  final String status;
}

/// Returns the existing job when the same kind and input revision is repeated.
class JobLedger {
  final Map<String, ProcessingJob> _jobs = {};
  int _seq = 0;

  ProcessingJob start({
    required String kind,
    required String inputRevision,
  }) {
    final key = '$kind:$inputRevision';
    final existing = _jobs[key];
    if (existing != null) return existing;
    final job = ProcessingJob(
      id: 'job-${++_seq}',
      idempotencyKey: key,
      inputRevision: inputRevision,
      status: 'succeeded',
    );
    _jobs[key] = job;
    return job;
  }
}
