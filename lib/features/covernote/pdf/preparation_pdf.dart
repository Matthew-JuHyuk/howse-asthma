import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../domain/preparation.dart';

class OriginalAttachment {
  const OriginalAttachment(this.name, this.mime, this.bytes);
  final String name, mime;
  final Uint8List bytes;
}

Future<Uint8List> buildPreparationPdf(
  Preparation p,
  List<TreatmentEvent> events,
  DateTime today, {
  List<OriginalAttachment> originals = const [],
}) async {
  final regular = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Regular.ttf'),
  );
  final bold = pw.Font.ttf(
    await rootBundle.load('assets/fonts/NotoSans-Bold.ttf'),
  );
  final doc = pw.Document(
    theme: pw.ThemeData.withFont(base: regular, bold: bold),
  );
  final summary = TreatmentSummary(p, events, today);
  final fingerprint = preparationFingerprint(p, events, today);
  final byId = {
    for (final e in events)
      if (!e.undone && e.patientKey == p.patientKey) e.id: e,
  };
  pw.Widget footer(pw.Context c) => pw.Text(
    '${p.synthetic ? 'SAMPLE / SYNTHETIC PATIENT | ' : ''}Clinician review required | case ${p.id} | revision ${p.revision} | ${c.pageNumber}',
    style: const pw.TextStyle(fontSize: 9),
  );
  pw.Widget heading(String s) => pw.Padding(
    padding: const pw.EdgeInsets.only(top: 12, bottom: 5),
    child: pw.Text(
      s,
      style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
    ),
  );
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: footer,
      build: (_) => [
        pw.Text(
          'CoverNote',
          style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(p.englishTitle, style: const pw.TextStyle(fontSize: 16)),
        pw.Text(
          'Patient: ${p.patientName}\nGenerated: ${dayKey(today)} | Preparation revision: ${p.revision}\nSource snapshot: $fingerprint',
        ),
        heading('Purpose / patient concern'),
        pw.Text(
          (p.englishFields['concern'] ?? p.concern).isEmpty
              ? 'Not provided'
              : (p.englishFields['concern'] ?? p.concern),
        ),
        pw.Text(
          'Current prescribed treatment (patient provided): ${p.currentMedication.isEmpty ? 'Not provided' : p.englishFields['current_medication'] ?? p.currentMedication}\nProposed by clinician: ${p.proposedMedication.isEmpty ? 'Not yet discussed' : p.englishFields['proposed_medication'] ?? p.proposedMedication}',
        ),
        heading('Recorded burden - last 30 calendar days'),
        pw.Text(
          '${summary.observedDays}/30 days with reports; ${summary.symptomDays} symptom days; ${summary.nightWakings} reported night wakings; ${summary.rescueUses} as-needed use events.\nUnrecorded days are unknown. Reports do not verify adherence or establish treatment failure.',
        ),
        heading('Evidence and next action'),
        pw.TableHelper.fromTextArray(
          headerStyle: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
          ),
          cellStyle: const pw.TextStyle(fontSize: 10),
          headers: [
            'Needed / source',
            'Linked records',
            'Remaining action / owner',
          ],
          data: [
            for (final n in p.needs.take(3))
              [
                '${n.label}\n${n.origin}${n.policyPage == null ? '' : ' p${n.policyPage}'}',
                n.links
                        .where(byId.containsKey)
                        .map((id) => '${byId[id]!.day} / $id')
                        .join('\n')
                        .isEmpty
                    ? 'No linked records'
                    : n.links
                          .where(byId.containsKey)
                          .map((id) => '${byId[id]!.day} / $id')
                          .join('\n'),
                'Clinical review pending\n${n.owner}',
              ],
          ],
        ),
        if (p.applicablePolicy) ...[
          heading('Policy reference'),
          pw.Text(
            'NJ Aetna Dupixent asthma protocol; checked 2026-10-22. Age 12+ example. Product applicability must be verified. Three months of treatment history and prior 12-month events are distinct from the recent 30-day app log.\n$policyUrl\nSHA256 $policyHash',
            style: const pw.TextStyle(fontSize: 10),
          ),
        ],
        heading('Next step'),
        pw.Text(
          'Please review the linked evidence, confirm clinical details, and advise which records are still needed. This brief is not a signed clinical opinion, completed PA form, eligibility decision, or proof of submission.',
        ),
      ],
    ),
  );
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      footer: footer,
      build: (_) => [
        heading(
          p.path == PreparationPath.deniedRequest
              ? 'Care-team request for denial review'
              : 'Care-team consultation request',
        ),
        pw.Text(
          'Dear care team,\nPlease review this patient-provided summary and the evidence listed below. Please confirm the appropriate treatment and, if relevant, the applicable authorization or response process.\nFor missing evidence, please advise how to obtain it. No clinician signature or medical opinion has been generated.',
        ),
        heading('Source appendix'),
        for (final n in p.needs) ...[
          pw.Text(
            '${n.label} | ${n.origin} | ${n.owner}',
            style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold),
          ),
          pw.Text(
            '${n.reason}\n${n.quote ?? ''}\nLinked: ${n.links.where(byId.containsKey).join(', ')}',
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 8),
        ],
        for (final e in events.where(
          (e) => !e.undone && e.patientKey == p.patientKey,
        ))
          pw.Inseparable(
            child: pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    '${e.day} | ${e.kind} | ${e.id}',
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    '${e.values['english_summary'] ?? e.text}\nSource ${e.sourceId}${e.values['page'] == null ? '' : ' / page ${e.values['page']}'}${e.values['quote'] == null ? '' : '\nOriginal quote: ${e.values['quote']}'}',
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                  if (e.values['night_wakings'] != null)
                    pw.Text(
                      'Patient-reported night wakings: ${e.values['night_wakings']}',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  if (e.kind == 'medication_use')
                    pw.Text(
                      'Reported medicine: ${e.values['medication'] ?? 'unknown'}; quantity: ${e.values['quantity'] ?? 'unknown'} ${e.values['unit'] ?? ''}; use: ${e.values['use_kind'] ?? 'unspecified'}',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  if (e.kind == 'environment')
                    pw.Text(
                      'Regional context only. Not personal exposure measurement or proof of cause.',
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                ],
              ),
            ),
          ),
        if (p.history.isNotEmpty) heading('Process history (patient reports)'),
        for (final h in p.history)
          pw.Text(
            '${h['date']} | ${h['type']} | ${h['text']}',
            style: const pw.TextStyle(fontSize: 10),
          ),
        heading('Original files'),
        pw.Text(
          originals.isEmpty
              ? 'Original files are not attached. Extracted text is not an original document.'
              : 'The original files follow as rendered pages. Source files remain separately available.',
        ),
      ],
    ),
  );
  for (final a in originals) {
    if (a.mime == 'application/pdf') {
      await for (final page in Printing.raster(a.bytes, dpi: 100)) {
        final bytes = await page.toPng();
        doc.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (c) => pw.Column(
              children: [
                pw.Text(
                  'Original: ${a.name}',
                  style: const pw.TextStyle(fontSize: 10),
                ),
                pw.Expanded(
                  child: pw.Image(
                    pw.MemoryImage(bytes),
                    fit: pw.BoxFit.contain,
                  ),
                ),
                footer(c),
              ],
            ),
          ),
        );
      }
    } else {
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (c) => pw.Column(
            children: [
              pw.Text('Original: ${a.name}'),
              pw.Expanded(
                child: pw.Image(
                  pw.MemoryImage(a.bytes),
                  fit: pw.BoxFit.contain,
                ),
              ),
              footer(c),
            ],
          ),
        ),
      );
    }
  }
  return doc.save();
}
