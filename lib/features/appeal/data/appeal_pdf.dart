import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../domain/appeal_letter.dart';
import '../domain/appeal_models.dart';
import '../domain/clinician_page.dart';

class AppealPdfException implements Exception {
  AppealPdfException(this.code);
  final String code;
}

class AppealPdf {
  AppealPdf._();

  static String fileName(AppealCase item, String documentType) {
    return 'case_${item.shortId}_${documentType}_r${item.factRevision}.pdf';
  }

  static Future<Uint8List> buildLetter(String text) async {
    final fonts = await _fonts();
    final pdf = pw.Document(title: 'Review draft', theme: fonts.theme);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.fromLTRB(40, 56, 40, 40),
        header: (context) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Text(
            draftBanner,
            style: pw.TextStyle(font: fonts.bold, fontSize: 10),
          ),
        ),
        build: (context) => [
          pw.Text(text, style: const pw.TextStyle(fontSize: 11)),
        ],
      ),
    );
    return pdf.save();
  }

  static Future<Uint8List> buildClinician(ClinicianPlan plan) async {
    final fonts = await _fonts();
    final pdf = pw.Document(title: 'Clinician summary', theme: fonts.theme);
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.fromLTRB(40, 40, 40, 40),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            for (final line in plan.lines)
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  line,
                  style: pw.TextStyle(fontSize: plan.fontSize),
                ),
              ),
          ],
        ),
      ),
    );
    return pdf.save();
  }

  static Future<_Fonts> _fonts() async {
    try {
      final base = await PdfGoogleFonts.notoSansRegular();
      final bold = await PdfGoogleFonts.notoSansBold();
      final kr = await PdfGoogleFonts.notoSansKRRegular();
      return _Fonts(
        bold: bold,
        theme: pw.ThemeData.withFont(
          base: base,
          bold: bold,
          fontFallback: [kr],
        ),
      );
    } catch (_) {
      throw AppealPdfException('font_unavailable');
    }
  }
}

class _Fonts {
  _Fonts({required this.bold, required this.theme});
  final pw.Font bold;
  final pw.ThemeData theme;
}
