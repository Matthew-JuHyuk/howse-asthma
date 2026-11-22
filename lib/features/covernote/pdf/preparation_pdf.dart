import 'package:flutter/foundation.dart';

import '../domain/patient_label.dart';
import '../domain/patient_log_report.dart';
import '../domain/preparation.dart';
import 'patient_log_pdf.dart';

/// Kept so callers can pass uploaded files. They stay in the app.
/// The clinician file is the summary only.
class OriginalAttachment {
  const OriginalAttachment(this.name, this.mime, this.bytes);
  final String name, mime;
  final Uint8List bytes;
}

String _english(Preparation p, String key, String fallback) {
  final translated = p.englishFields[key]?.trim();
  if (translated != null && translated.isNotEmpty) return translated;
  return fallback.trim();
}

/// One clinician summary. Counts come from [events] in the 30-day window.
Future<Uint8List> buildPreparationPdf(
  Preparation p,
  List<TreatmentEvent> events,
  DateTime today, {
  List<OriginalAttachment> originals = const [],
  int? actScore,
  String? actDay,
}) {
  return buildPatientLogPdf(
    PatientLogReport(
      patientKey: p.patientKey,
      patientName: patientLabel(p.patientName),
      end: today,
      events: events,
      controller: patientText(
        _english(p, 'current_medication', p.currentMedication),
      ),
      sample: p.synthetic,
      visitTitle: p.englishTitle,
      concern: patientText(_english(p, 'concern', p.concern)),
      plan: p.plan.trim(),
      proposed: _english(p, 'proposed_medication', p.proposedMedication),
      stillNeeded: [
        for (final n in p.needs)
          if (n.links.isEmpty) n.label,
      ],
      actScore: actScore,
      actDay: actDay,
    ),
  );
}
