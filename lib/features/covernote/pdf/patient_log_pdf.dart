import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../domain/patient_log_report.dart';
import '../domain/preparation.dart';

Future<Uint8List> buildPatientLogPdf(PatientLogReport report) async {
  final regular = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
  );
  final bold = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
  );
  final doc = pw.Document(
    title: 'CoverNote - 30-Day Patient Log Summary',
    theme: pw.ThemeData.withFont(base: regular, bold: bold),
  );
  addPatientLogPages(doc, report);
  return doc.save();
}

/// The reviewed form is a patient log, separate from the coverage request brief.
void addPatientLogPages(pw.Document doc, PatientLogReport r) {
  pw.Widget section(String text) => pw.Padding(
    padding: const pw.EdgeInsets.only(top: 15, bottom: 7),
    child: pw.Text(
      text,
      style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
    ),
  );
  pw.Widget line(String label, String value) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 4),
    child: pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: '$label: ',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.TextSpan(text: value),
        ],
      ),
    ),
  );
  pw.Widget table(
    List<String> headers,
    List<List<String>> rows,
    List<double> widths,
  ) => pw.TableHelper.fromTextArray(
    headers: headers,
    data: rows,
    columnWidths: {
      for (var i = 0; i < widths.length; i++) i: pw.FlexColumnWidth(widths[i]),
    },
    headerStyle: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
    headerDecoration: const pw.BoxDecoration(
      color: PdfColor.fromInt(0xfff0f2f4),
    ),
    cellStyle: const pw.TextStyle(fontSize: 9),
    cellPadding: const pw.EdgeInsets.all(7),
    cellAlignment: pw.Alignment.topLeft,
    border: pw.TableBorder.all(color: PdfColors.grey400, width: .5),
  );
  final incidents = r.incidents;
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.letter,
      margin: const pw.EdgeInsets.fromLTRB(38, 36, 38, 36),
      theme: doc.theme!.copyWith(
        defaultTextStyle: doc.theme!.defaultTextStyle.copyWith(
          fontSize: 9.5,
          lineSpacing: 1.5,
        ),
      ),
      maxPages: 10,
      footer: (c) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 10),
        child: pw.Text(
          '${r.isSample ? 'SAMPLE - fictional data | ' : ''}CoverNote patient log | ${c.pageNumber}',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700),
        ),
      ),
      build: (_) => [
        if (r.isSample)
          pw.Text(
            '*** [ SAMPLE REPORT ] ***',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11),
          ),
        pw.SizedBox(height: 5),
        pw.Text(
          'CoverNote - 30-DAY PATIENT LOG SUMMARY',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        section('PATIENT INFORMATION (Self-Reported Data)'),
        line('Patient Name', r.patientName),
        line('DOB', r.dob ?? 'Not recorded'),
        line(
          'Monitoring Period',
          '${dayKey(r.range.from)} - ${dayKey(r.range.to)} (30 Days)',
        ),
        line(
          'Current Controller (Logged)',
          (r.controller?.trim().isNotEmpty ?? false)
              ? r.controller!
              : 'Not recorded',
        ),
        section('1. LOGGED ASTHMA METRICS (30-Day Totals)'),
        table(
          ['Metric', 'Patient Logged Value'],
          [
            ['ACT Score (Self-Assessed)', r.act],
            ['Daytime Symptom Frequency', r.frequency],
            ['Nighttime Awakenings', r.night],
            [
              'Rescue Inhaler (SABA) Usage',
              '${r.useText(r.rescue)}${r.sabaConfirmed ? '' : '\nAs-needed use; SABA type not confirmed'}',
            ],
            ['Controller Medication Adherence', r.adherence],
          ],
          [1.05, 1.25],
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          'Records on ${r.observedDays.length} of 30 days. Missing entries are unknown, not symptom-free days or missed doses.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        section('2. ENVIRONMENTAL EXPOSURE (Location-Matched)'),
        line(
          'Days with AQI > 100',
          r.aqi.isEmpty
              ? 'Not recorded'
              : '${r.aqi.values.where((v) => v > 100).length} days (${r.aqi.length} days with data)',
        ),
        line(
          'Days with High / Very High Pollen',
          r.pollen.isEmpty
              ? 'Not recorded'
              : '${r.pollen.values.where((v) => ['High', 'Very High'].contains(v)).length} days (${r.pollen.length} days with data)',
        ),
        line(
          '${r.sabaConfirmed ? 'SABA' : 'As-needed'} Usage on High AQI or High Pollen Days',
          r.exposureUses,
        ),
        section('3. RECENT LOGGED INCIDENTS (Past 14 Days)'),
        if (incidents.isEmpty)
          pw.Text('No incidents recorded in this period.')
        else
          table(
            [
              'Date',
              r.sabaConfirmed ? 'SABA Usage' : 'As-needed Usage',
              'AQI',
              'Pollen Level',
              'Patient Logged Symptoms',
            ],
            incidents,
            [.95, 1.3, .6, .8, 1.45],
          ),
        pw.SizedBox(height: 12),
        pw.Text(
          'Disclaimer: This document contains raw, patient-entered observational data and location-matched environmental statistics. It does not constitute a medical diagnosis or treatment recommendation.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Environmental values are regional context, not personal exposure or proof of cause. The 30-day window is a reporting period, not an insurance requirement.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
      ],
    ),
  );
}
