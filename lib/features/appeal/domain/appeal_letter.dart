import 'appeal_models.dart';

const draftBanner =
    'DRAFT — CLINICIAN REVIEW REQUIRED / 의사 검토 필수';

const _forbidden = [
  'as your treating physician',
  'as the treating clinician',
  'this appeal has been submitted',
  'approval is likely',
  'will be approved',
  'eosinophil',
  'ige',
];

class LetterBuild {
  const LetterBuild({
    required this.mode,
    required this.factRevision,
    required this.text,
    required this.missing,
  });

  final ExportMode mode;
  final int factRevision;
  final String text;
  final List<String> missing;
}

bool letterHasForbiddenClaims(String text) {
  final lower = text.toLowerCase();
  return _forbidden.any(lower.contains);
}

LetterBuild buildLetter(
  AppealCase item, {
  required ExportMode mode,
  required DeadlineOutcome deadline,
  DateTime? generatedAt,
}) {
  if (item.status == CaseStatus.deleted || item.status == CaseStatus.deleting) {
    throw AppealFlowException('deleted');
  }
  if (item.documentKind != DocumentKind.initialDrugDenial) {
    throw AppealFlowException('not_initial_denial');
  }
  if (mode == ExportMode.preparedDraft && !item.preparedMinimumMet) {
    throw AppealFlowException('prepared_requirements');
  }

  final missing = <String>[
    if (!item.patientName.isPresent) 'patient_name',
    if (!item.medicationRaw.isPresent) 'medication',
    if (item.denialReason == null) 'denial_reason',
    if (!item.memberId.isPresent) 'member_id',
    if (!item.caseReference.isPresent) 'case_reference',
    'mailing_address',
    'insurer_form',
    'representative_authorization',
  ];

  final when = generatedAt?.toUtc().toIso8601String() ?? '';
  final name = _show(item.patientName.rawText);
  final med = _show(item.medicationRaw.rawText);
  final dose = _show(item.doseRaw.rawText);
  final reason = item.denialReason == null
      ? '[not entered]'
      : item.denialReason!.rawText;
  final member = _show(item.memberId.rawText);
  final caseRef = _show(item.caseReference.rawText);
  final deadlineLine = switch (deadline.display) {
    DeadlineDisplay.documentDate =>
      'Document deadline (confirm on the notice): ${item.deadline.rawText ?? _ymd(deadline.date)}',
    DeadlineDisplay.calculatedFromReceived =>
      'Calculated from the received date you entered: ${_ymd(deadline.date)}',
    DeadlineDisplay.needsReceivedDate =>
      'The notice uses a relative deadline. Received date is not entered. No date was calculated.',
    DeadlineDisplay.notCalculable =>
      'Deadline text is unclear. Original: ${item.deadline.rawText ?? '[not entered]'}. No date was calculated.',
    DeadlineDisplay.notFound =>
      'A deadline was not found in the document. Ask the plan.',
  };

  final records = item.recordsLinked
      ? 'Selected records are attached by reference in the app.'
      : 'No medication, symptom, or environment records are linked. No adherence figure is included.';
  final statement = item.selfReport == null || item.selfReport!.trim().isEmpty
      ? 'No additional patient statement.'
      : 'Patient self-report (not a medical record): ${item.selfReport}';

  final modeLabel = mode == ExportMode.preparedDraft
      ? 'Prepared draft for clinician review. Not filed.'
      : 'Review draft. Missing items stay blank. Not filed.';

  final text = '''
$draftBanner

$modeLabel
English draft for review. Fact revision ${item.factRevision}. Generated $when.

Date: [not entered]
To: the plan named on the notice

Patient display name: $name
Member ID: $member
Case reference: $caseRef

Please review the coverage denial described in the attached notice.
Requested medication (as written): $med
Dose (as written): $dose

Reason stated in the notice:
$reason

$deadlineLine

Related records:
$records
$statement

For the clinician to complete. This draft does not state a clinical opinion:
- Whether more clinical information is needed
- What the clinician wants the plan to review

Attachments listed here are only files this draft actually includes:
- None attached by this draft

Signature: ______________________________
Name: [clinician name not generated]
License: [not generated]

This draft does not by itself meet every filing requirement.
Missing checklist: ${missing.join(', ')}.
$draftBanner
''';

  if (letterHasForbiddenClaims(text)) {
    throw AppealFlowException('forbidden_claim');
  }
  return LetterBuild(
    mode: mode,
    factRevision: item.factRevision,
    text: text.trim(),
    missing: missing,
  );
}

String _show(String? value) {
  if (value == null || value.trim().isEmpty) return '[not entered]';
  return value;
}

String _ymd(DateTime? date) {
  if (date == null) return '[not entered]';
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '${date.year}-$m-$d';
}
