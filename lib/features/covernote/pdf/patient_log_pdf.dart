import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../domain/patient_log_report.dart';
import '../domain/preparation.dart';

const _navy = PdfColor.fromInt(0xFF142D4E);
const _teal = PdfColor.fromInt(0xFF167D8D);
const _mint = PdfColor.fromInt(0xFFD8F2EC);
const _grey = PdfColor.fromInt(0xFF5B6675);
const _line = PdfColor.fromInt(0xFFC9D2DC);

Future<Uint8List> buildPatientLogPdf(PatientLogReport report) async {
  final regular = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
  );
  final bold = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
  );
  final doc = pw.Document(
    title: report.visitTitle ?? 'CoverNote - 30-day patient log',
    author: 'Prepared by the patient with CoverNote',
    creator: 'CoverNote',
    theme: pw.ThemeData.withFont(base: regular, bold: bold),
  );
  addPatientLogPages(doc, report);
  return doc.save();
}

/// Clinician summary. Every number comes from [r]; missing stays unknown.
void addPatientLogPages(pw.Document doc, PatientLogReport r) {
  pw.Widget section(String text) => pw.Padding(
    padding: const pw.EdgeInsets.only(top: 12, bottom: 4),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 11,
        color: _navy,
      ),
    ),
  );
  pw.Widget line(String label, String value) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 3),
    child: pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: '$label  ',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
              color: _navy,
            ),
          ),
          pw.TextSpan(text: value, style: const pw.TextStyle(fontSize: 10)),
        ],
      ),
    ),
  );
  pw.Widget table(List<String> headers, List<List<String>> rows) =>
      pw.TableHelper.fromTextArray(
        headers: headers,
        data: rows,
        headerStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 9,
          color: _navy,
        ),
        headerDecoration: const pw.BoxDecoration(color: _mint),
        cellStyle: const pw.TextStyle(fontSize: 9),
        cellPadding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        cellAlignment: pw.Alignment.topLeft,
        border: const pw.TableBorder(
          horizontalInside: pw.BorderSide(color: _line, width: 0.4),
          top: pw.BorderSide(color: _line, width: 0.4),
          bottom: pw.BorderSide(color: _line, width: 0.4),
        ),
      );
  final incidents = r.incidents;
  final concern = r.concern?.trim() ?? '';
  final proposed = r.proposed?.trim() ?? '';
  final plan = r.plan?.trim() ?? '';
  final needed = r.stillNeeded.where((s) => s.trim().isNotEmpty).toList();
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.letter,
      margin: const pw.EdgeInsets.fromLTRB(40, 36, 40, 40),
      maxPages: 6,
      header: (c) => pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 8),
        padding: const pw.EdgeInsets.only(bottom: 4),
        decoration: const pw.BoxDecoration(
          border: pw.Border(bottom: pw.BorderSide(color: _navy, width: 1.2)),
        ),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Expanded(
              child: pw.Text(
                r.visitTitle ?? '30-day patient log',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 14,
                  color: _navy,
                ),
              ),
            ),
            pw.Text(
              'CoverNote',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 10,
                color: _teal,
              ),
            ),
          ],
        ),
      ),
      footer: (c) => pw.Container(
        margin: const pw.EdgeInsets.only(top: 8),
        padding: const pw.EdgeInsets.only(top: 4),
        decoration: const pw.BoxDecoration(
          border: pw.Border(top: pw.BorderSide(color: _line, width: 0.6)),
        ),
        child: pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                r.isSample
                    ? 'Sample — fictional data. Clinician review required.'
                    : 'Patient-reported log. Clinician review required.',
                style: const pw.TextStyle(fontSize: 8, color: _grey),
              ),
            ),
            pw.Text(
              '${c.pageNumber} / ${c.pagesCount}',
              style: const pw.TextStyle(fontSize: 8, color: _grey),
            ),
          ],
        ),
      ),
      build: (_) => [
        if (r.isSample)
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 6),
            child: pw.Text(
              'Sample — fictional patient. Not a real record.',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 10,
                color: _teal,
              ),
            ),
          ),
        line('Patient', r.patientName),
        if ((r.dob ?? '').isNotEmpty) line('Date of birth', r.dob!),
        line(
          'Period',
          '${dayKey(r.range.from)} – ${dayKey(r.range.to)} (30 days)',
        ),
        line(
          'Controller logged',
          (r.controller?.trim().isNotEmpty ?? false)
              ? r.controller!.trim()
              : 'Not recorded',
        ),
        if (plan.isNotEmpty) line('Plan', plan),
        if (concern.isNotEmpty || proposed.isNotEmpty) ...[
          section('Why this visit'),
          if (concern.isNotEmpty) line('Patient concern', concern),
          if (proposed.isNotEmpty) line('Asked about', proposed),
        ],
        section('Logged summary'),
        table(
          ['Item', 'From the patient’s log'],
          [
            ['Symptom check (ACT), if recorded', r.act],
            ['Symptom days', r.frequency],
            ['Night waking', r.night],
            [
              r.sabaConfirmed ? 'Rescue inhaler (SABA)' : 'As-needed medicine',
              r.useText(r.rescue),
            ],
            ['Scheduled doses', r.adherence],
          ],
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4),
          child: pw.Text(
            'Logged on ${r.observedDays.length} of 30 days. Days with no entry are unknown, not symptom-free days or missed doses.',
            style: const pw.TextStyle(fontSize: 8, color: _grey),
          ),
        ),
        section('Location-matched context'),
        line(
          'Days with AQI above 100',
          r.aqi.isEmpty
              ? 'Not recorded'
              : '${r.aqi.values.where((v) => v > 100).length} of ${r.aqi.length} days with an AQI reading',
        ),
        line(
          'Days with high or very high pollen',
          r.pollen.isEmpty
              ? 'Not recorded'
              : '${r.pollen.values.where((v) => v == "High" || v == "Very High").length} of ${r.pollen.length} days with a pollen reading',
        ),
        line(
          '${r.sabaConfirmed ? 'Rescue' : 'As-needed'} use on those days',
          r.exposureUses,
        ),
        pw.Text(
          'Regional context only. It is not a personal exposure measurement and does not show a cause. Forecasts are not counted.',
          style: const pw.TextStyle(fontSize: 8, color: _grey),
        ),
        section('Recent log (14 days)'),
        if (incidents.isEmpty)
          pw.Text(
            'No symptoms or as-needed use recorded in these 14 days.',
            style: const pw.TextStyle(fontSize: 10),
          )
        else
          table([
            'Date',
            r.sabaConfirmed ? 'Rescue use' : 'As-needed use',
            'AQI',
            'Pollen',
            'Symptoms logged',
          ], incidents),
        if (needed.isNotEmpty) ...[
          section('Still to confirm with the care team'),
          for (final item in needed.take(6))
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 2),
              child: pw.Text(
                '• $item',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ),
        ],
        pw.SizedBox(height: 10),
        pw.Text(
          'This summary does not diagnose, recommend treatment, or confirm that a request was submitted.',
          style: const pw.TextStyle(fontSize: 8, color: _grey),
        ),
      ],
    ),
  );
}
