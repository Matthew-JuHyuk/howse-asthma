import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../core/locale/app_languages.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';

String formatDay(BuildContext context, DateTime d) =>
    DateFormat.yMMMd(intlLocaleFor(Localizations.localeOf(context))).format(d);

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

/// Plain-language explanation for a reason code from the letter. The model's
/// own wording is English, so other languages show this fixed text and keep a
/// link to the letter's quote.
String reasonExplanation(AppLocalizations l, String code) => switch (code) {
  'missing_information' => l.cnReasonMissingInformation,
  'step_therapy' => l.cnReasonStepTherapy,
  'medical_necessity' => l.cnReasonMedicalNecessity,
  'formulary' => l.cnReasonFormulary,
  'quantity_limit' => l.cnReasonQuantityLimit,
  'eligibility_or_benefit' => l.cnReasonEligibility,
  _ => l.cnReasonOther,
};

/// Whether text from the letter's analysis (English) needs a translated aid.
bool needsTranslatedAid(BuildContext context) =>
    Localizations.localeOf(context).languageCode != 'en';

/// A short translated hint under an English requirement label such as
/// "Medication history". The label itself stays as the letter words it.
/// Returns `null` when the label is not one of the common kinds.
String? requirementHint(AppLocalizations l, String label) {
  final s = label.toLowerCase();
  if (RegExp(r'letter of medical|doctor.s statement|prescriber statement|statement (from|by) (the )?(doctor|physician|prescriber)').hasMatch(s)) {
    return l.cnReqHintDoctorStatement;
  }
  if (RegExp(r'medication history|pharmacy|prior medication|medicines? (tried|history)|drug history').hasMatch(s)) {
    return l.cnReqHintMedHistory;
  }
  if (RegExp(r'visit note|chart note|office note|clinical note|progress note|medical record|chart').hasMatch(s)) {
    return l.cnReqHintVisitNotes;
  }
  if (RegExp(r'test result|\blab(s|oratory)?\b|spirometr|pulmonary function|x-ray|imaging').hasMatch(s)) {
    return l.cnReqHintTestResults;
  }
  return null;
}

String recordTypeLabel(AppLocalizations l, String type) => switch (type) {
  'medication_summary' => l.cnRecMedication,
  'symptom_summary' => l.cnRecSymptoms,
  'local_context' => l.cnRecLocalContext,
  _ => type,
};
