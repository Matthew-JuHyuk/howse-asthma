import 'appeal_letter.dart';
import 'appeal_models.dart';
import 'deadline_resolver.dart';
import 'fact_validator.dart';

AppealCase confirmCoreFacts(AppealCase item) {
  if (item.status == CaseStatus.deleted) {
    throw AppealFlowException('deleted');
  }
  validateCaseFacts(item);
  final reason = item.denialReason;
  return item.copyWith(
    patientName: item.patientName.copyWith(confirmedByUser: item.patientName.isPresent),
    medicationRaw: item.medicationRaw.copyWith(
      confirmedByUser: item.medicationRaw.isPresent,
    ),
    doseRaw: item.doseRaw.copyWith(confirmedByUser: item.doseRaw.isPresent),
    denialReason: reason?.copyWith(confirmedByUser: true),
    coreReviewed: true,
    reviewVersion: item.reviewVersion + 1,
    confirmedFactRevision: item.factRevision,
    status: item.documentKind == DocumentKind.initialDrugDenial
        ? CaseStatus.readyForDraft
        : item.status,
  );
}

AppealCase editMedication(AppealCase item, String raw) {
  if (item.status == CaseStatus.deleted) {
    throw AppealFlowException('deleted');
  }
  final next = item.copyWith(
    medicationRaw: FactValue(
      rawText: raw,
      normalizedValue: raw,
      status: FactStatus.userEntered,
      sourceRefs: const [],
      confirmedByUser: false,
    ),
    coreReviewed: false,
    factRevision: item.factRevision + 1,
    clearConfirmedRevision: true,
    status: CaseStatus.needsReview,
    clearLetter: true,
    clearGenerated: true,
  );
  validateCaseFacts(next);
  return next;
}

LetterBuild generateLetter(AppealCase item, ExportMode mode) {
  validateCaseFacts(item);
  final deadline = resolveDeadline(
    item.deadline,
    userConfirmedDate: item.deadlineConfirmedByUser,
  );
  final letter = buildLetter(item, mode: mode, deadline: deadline);
  return letter;
}

AppealCase storeLetter(AppealCase item, LetterBuild letter) {
  return item.copyWith(
    letterText: letter.text,
    letterMode: letter.mode,
    generatedFactRevision: letter.factRevision,
    status: CaseStatus.draftReady,
    sharedMarkedSubmitted: false,
  );
}
