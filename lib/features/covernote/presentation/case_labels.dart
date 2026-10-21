import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';

String formatDay(BuildContext context, DateTime d) =>
    DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag()).format(d);

String formatIsoDay(BuildContext context, String? iso) {
  final d = parseIsoDate(iso);
  return d == null ? (iso ?? '') : formatDay(context, d);
}

String caseTitle(AppLocalizations l, CaseRow row) {
  final t = row.title?.trim();
  return t == null || t.isEmpty ? l.cnCaseUntitled : t;
}

(String, ChipTone) caseStatus(AppLocalizations l, CaseRow row, {CaseJob? job}) {
  if (job != null && job.failed) {
    return (l.cnStatusNeedsAttention, ChipTone.bad);
  }
  return switch (row.status) {
    'uploaded' || 'processing' => (l.cnStatusReading, ChipTone.neutral),
    'needs_review' => (l.cnStatusNeedsReview, ChipTone.warn),
    'ready_for_draft' => (l.cnStatusGatherRecords, ChipTone.neutral),
    'draft_ready' => (l.cnStatusPacketReady, ChipTone.good),
    'failed' => (l.cnStatusNeedsAttention, ChipTone.bad),
    _ => (l.cnStatusNotStarted, ChipTone.neutral),
  };
}

/// One concrete next action for a case card. Counts only; never a score.
String caseNextAction(AppLocalizations l, CaseSummary s) {
  final status = s.row.status;
  if (status == 'uploaded' || status == 'processing') {
    return l.cnNextWaitReading;
  }
  if (status == 'failed') return l.cnNextTryAgain;
  if (s.factsToConfirm > 0) return l.cnNextFactsToConfirm(s.factsToConfirm);
  if (s.requirementsTotal > 0 && s.requirementsSettled < s.requirementsTotal) {
    return l.cnNextItemsAttached(s.requirementsSettled, s.requirementsTotal);
  }
  if (status == 'draft_ready') return l.cnNextSharePacket;
  return l.cnNextCreatePacket;
}

String documentKindLabel(AppLocalizations l, String? kind) => switch (kind) {
  'initial_drug_denial' => l.cnKindInitialDenial,
  'additional_information_request' => l.cnKindInfoRequest,
  'reauthorization_notice' => l.cnKindReauth,
  'final_appeal_denial' => l.cnKindFinalDenial,
  'eob_or_bill' => l.cnKindEob,
  'other' => l.cnKindOther,
  _ => l.cnKindUncertain,
};

String fieldLabel(AppLocalizations l, String key) => switch (key) {
  'patient_name' => l.cnFieldPatientName,
  'plan_name' => l.cnFieldPlanName,
  'member_id' => l.cnFieldMemberId,
  'case_reference' => l.cnFieldCaseReference,
  'medication' => l.cnFieldMedication,
  'dose' => l.cnFieldDose,
  'notice_date' => l.cnFieldNoticeDate,
  'contact' => l.cnFieldContact,
  'submission_route' => l.cnFieldSubmissionRoute,
  _ => key,
};

(String, ChipTone) factStatus(AppLocalizations l, Fact f) {
  if (f.status == FactStatus.userEntered) {
    return (l.cnFactEdited, ChipTone.good);
  }
  if (f.confirmed && f.hasValue) return (l.cnFactChecked, ChipTone.good);
  if (!f.hasValue) return (l.cnFactNotInLetter, ChipTone.neutral);
  if (f.status == FactStatus.ambiguous) {
    return (l.cnFactNeedsCheck, ChipTone.warn);
  }
  return (l.cnFactFromLetter, ChipTone.neutral);
}

String responsibleLabel(AppLocalizations l, String r) => switch (r) {
  'patient' => l.cnWhoYou,
  'care_team' => l.cnWhoCareTeam,
  'insurer' => l.cnWhoPlan,
  _ => l.cnWhoUnknown,
};

String requirementStatusLabel(AppLocalizations l, String s) => switch (s) {
  RequirementStatus.linked => l.cnReqLinked,
  RequirementStatus.askedCareTeam => l.cnReqAskedCareTeam,
  RequirementStatus.notAvailable => l.cnReqNotAvailable,
  RequirementStatus.notApplicable => l.cnReqNotNeeded,
  _ => l.cnReqNeeded,
};

String recordTypeLabel(AppLocalizations l, String type) => switch (type) {
  'medication_summary' => l.cnRecMedication,
  'symptom_summary' => l.cnRecSymptoms,
  'local_context' => l.cnRecLocalContext,
  _ => type,
};
