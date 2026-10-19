import 'appeal_models.dart';
import 'appeal_letter.dart';

class ClinicianLine {
  const ClinicianLine(this.text, this.priority);

  final String text;

  /// 0 stays. Higher numbers are removed first when the page is full.
  final int priority;
}

class ClinicianPlan {
  const ClinicianPlan({
    required this.fontSize,
    required this.lines,
    required this.truncated,
  });

  final double fontSize;
  final List<String> lines;
  final bool truncated;
}

const clinicianFontSize = 10.0;
const clinicianLineBudget = 42;

ClinicianPlan fitClinicianPage(
  AppealCase item, {
  required DeadlineOutcome deadline,
  List<String> symptomLines = const [],
  int maxLines = clinicianLineBudget,
}) {
  final lines = <ClinicianLine>[
    const ClinicianLine(draftBanner, 0),
    ClinicianLine(
      'Purpose of this visit: review a coverage denial and questions to ask. Not an approval decision.',
      0,
    ),
    ClinicianLine('Patient: ${_blank(item.patientName.rawText)}', 0),
    ClinicianLine('Case reference: ${_blank(item.caseReference.rawText)}', 0),
    ClinicianLine(
      'Medication as written: ${_blank(item.medicationRaw.rawText)}',
      0,
    ),
    ClinicianLine('Dose as written: ${_blank(item.doseRaw.rawText)}', 0),
    ClinicianLine(
      item.denialReason == null
          ? 'Denial reason: [not entered]'
          : 'Denial reason from the notice: ${item.denialReason!.rawText}',
      0,
    ),
    ClinicianLine('Deadline: ${_deadlineLine(item, deadline)}', 0),
    ClinicianLine(
      item.recordsLinked
          ? 'Records: selected by the patient. See the app for detail.'
          : 'Records: none linked. No adherence figure is shown.',
      0,
    ),
    const ClinicianLine(
      'Questions for the clinician: what is missing, and what should the plan review?',
      0,
    ),
    if (item.selfReport != null && item.selfReport!.trim().isNotEmpty)
      ClinicianLine(
        'Patient self-report (not a medical record): ${item.selfReport}',
        2,
      ),
    for (final symptom in symptomLines) ClinicianLine(symptom, 3),
  ];

  final working = [...lines];
  var truncated = false;
  while (working.length > maxLines) {
    var dropAt = -1;
    var best = 0;
    for (var i = 0; i < working.length; i++) {
      final priority = working[i].priority;
      if (priority > best) {
        best = priority;
        dropAt = i;
      } else if (priority == best && priority > 0) {
        dropAt = i;
      }
    }
    if (dropAt < 0 || best == 0) break;
    working.removeAt(dropAt);
    truncated = true;
  }
  final kept = [...working];
  if (kept.length > maxLines) {
    truncated = true;
    kept.removeRange(maxLines - 1, kept.length);
  }
  final rendered = kept.map((line) => line.text).toList();
  if (truncated) {
    rendered.add('See the app for the full record.');
  }
  return ClinicianPlan(
    fontSize: clinicianFontSize,
    lines: rendered,
    truncated: truncated,
  );
}

String _deadlineLine(AppealCase item, DeadlineOutcome deadline) {
  return switch (deadline.display) {
    DeadlineDisplay.documentDate =>
      'written on the notice as ${item.deadline.rawText ?? _ymd(deadline.date)}. Not a judgment that a filing is still open.',
    DeadlineDisplay.calculatedFromReceived =>
      'calculated from the received date you entered (${_ymd(deadline.date)}).',
    DeadlineDisplay.needsReceivedDate =>
      'relative wording, received date missing, no date calculated.',
    DeadlineDisplay.notCalculable =>
      'unclear (${item.deadline.rawText ?? 'no text'}). No date calculated.',
    DeadlineDisplay.notFound =>
      'not found in the document. Ask the plan.',
  };
}

String _blank(String? value) =>
    (value == null || value.trim().isEmpty) ? '[not entered]' : value;

String _ymd(DateTime? date) {
  if (date == null) return '[not entered]';
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '${date.year}-$m-$d';
}
