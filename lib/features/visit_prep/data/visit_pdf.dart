import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../domain/visit_summary.dart';

class VisitPdfException implements Exception {
  VisitPdfException(this.code);
  final String code;
}

/// Renders the English visit summary. Fonts are fetched once (network) so
/// original-language text such as Korean or Chinese prints correctly.
class VisitPdf {
  VisitPdf._();

  static Future<Uint8List> build(
    VisitSummaryDoc doc, {
    required Set<String> scriptLanguages,
  }) async {
    final pw.Font base;
    final pw.Font bold;
    final fallback = <pw.Font>[];
    try {
      base = await PdfGoogleFonts.notoSansRegular();
      bold = await PdfGoogleFonts.notoSansBold();
      if (scriptLanguages.contains('ko')) {
        fallback.add(await PdfGoogleFonts.notoSansKRRegular());
      }
      if (scriptLanguages.contains('ja')) {
        fallback.add(await PdfGoogleFonts.notoSansJPRegular());
      }
      if (scriptLanguages.contains('zh')) {
        fallback.add(await PdfGoogleFonts.notoSansSCRegular());
      }
    } catch (_) {
      throw VisitPdfException('font_unavailable');
    }

    final theme = pw.ThemeData.withFont(
      base: base,
      bold: bold,
      fontFallback: fallback,
    );
    final pdf = pw.Document(title: doc.title, theme: theme);

    pw.Widget line(SummaryLine l) => pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 3),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('•  '),
          pw.Expanded(child: pw.Text(l.text)),
        ],
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        footer: (ctx) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 8),
          child: pw.Text(
            '${ctx.pageNumber} / ${ctx.pagesCount}',
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700),
          ),
        ),
        build: (ctx) => [
          pw.Text(
            doc.title,
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 6),
          for (final m in doc.meta)
            pw.Text(m, style: const pw.TextStyle(fontSize: 10)),
          pw.SizedBox(height: 8),
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey600),
            ),
            child: pw.Text(
              doc.disclaimer,
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
          for (final s in doc.sections) ...[
            pw.SizedBox(height: 12),
            pw.Text(
              s.title,
              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            for (final l in s.lines) line(l),
          ],
          if (doc.appendix.isNotEmpty) ...[
            pw.NewPage(),
            pw.Text(
              doc.appendixTitle,
              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            for (final l in doc.appendix) line(l),
          ],
        ],
      ),
    );
    return pdf.save();
  }
}
