import '../../../l10n/app_localizations.dart';
import 'case_facts.dart';
import 'case_models.dart';
import 's9_models.dart';

/// Title: "[drug or service] · [document kind]". Never invents a denial.
String caseDisplayTitle(AppLocalizations l, CaseRow row, {CaseFacts? facts}) {
  final alias = row.displayAlias?.trim();
  if (alias != null && alias.isNotEmpty) return alias;
  final drug = (facts?.field('medication').value ?? row.title)?.trim();
  final kind = row.documentKind ?? facts?.kind;
  if(row.startReason!=null&&kind==null)return drug?.isNotEmpty==true?drug!:l.cnCaseUntitled;
  final kindLabel = _kindShort(l, kind);
  if (drug == null || drug.isEmpty) {
    if (row.status == 'uploaded' || row.status == 'processing') {
      return l.cnAnalyzingTitle;
    }
    return '${l.cnCaseUntitled} · $kindLabel';
  }
  return '$drug · $kindLabel';
}

String _kindShort(AppLocalizations l, String? kind) => switch (kind) {
  'initial_drug_denial' => l.cnKindInitialDenial,
  'additional_information_request' => l.cnKindInfoRequest,
  'reauthorization_notice' => l.cnKindReauth,
  'final_appeal_denial' => l.cnKindFinalDenial,
  'eob_or_bill' => l.cnKindEob,
  'other' => l.cnKindOther,
  _ => l.cnKindUncertain,
};

String caseNumberLabel(AppLocalizations l, CaseRow row) {
  final n = row.displayOrdinal;
  if (n == null) return '';
  return l.cnCaseNumber(n.toString().padLeft(3, '0'));
}

/// Follow-up line from delivery + lifecycle. Share-sheet-only is ignored.
String caseFollowUp(
  AppLocalizations l,
  CaseRow row,
  List<DeliveryEvent> deliveries,
) {
  if (row.lifecycle == CaseLifecycle.completed) {
    return l.cnOutcomeRecorded;
  }
  if (row.lifecycle == CaseLifecycle.archived) {
    return l.cnArchivedCase;
  }
  final live = deliveries.where((d) => d.active).toList();
  final clinic = live.where((d) => d.recipient == DeliveryRecipient.clinic);
  final insurer = live.where((d) => d.recipient == DeliveryRecipient.insurer);
  if (clinic.isNotEmpty) return l.cnStatusWaitingClinic;
  if (insurer.isNotEmpty) return l.cnStatusWaitingInsurer;
  if (row.status == 'draft_ready') return l.cnStatusPacketReady;
  return '';
}
