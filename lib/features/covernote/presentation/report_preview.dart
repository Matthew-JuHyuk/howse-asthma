import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../l10n/app_localizations.dart';

/// Full pages in the parent scroll, so the last page and the buttons are reachable.
class ReportPreview extends StatefulWidget {
  const ReportPreview({super.key, required this.bytes, required this.fileName});

  final Uint8List bytes;
  final String fileName;

  @override
  State<ReportPreview> createState() => _ReportPreviewState();
}

class _ReportPreviewState extends State<ReportPreview> {
  List<Uint8List> _pages = [];
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final pages = <Uint8List>[];
      await for (final page in Printing.raster(widget.bytes, dpi: 120)) {
        pages.add(await page.toPng());
      }
      if (mounted) setState(() => _pages = pages);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_pages.isEmpty && !_failed)
          const SizedBox(
            height: 240,
            child: Center(child: CircularProgressIndicator()),
          ),
        if (_failed)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(l.cnPacketFailed),
          ),
        for (final page in _pages)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Image.memory(page, fit: BoxFit.fitWidth),
          ),
        const SizedBox(height: 4),
        SizedBox(
          height: 52,
          child: FilledButton.icon(
            onPressed: () =>
                shareReportFile(context, widget.bytes, widget.fileName),
            icon: const Icon(Icons.ios_share),
            label: Text(l.cnShareDocuments),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: OutlinedButton.icon(
            onPressed: () => Printing.layoutPdf(
              onLayout: (_) async => widget.bytes,
              name: widget.fileName,
            ),
            icon: const Icon(Icons.print_outlined),
            label: Text(l.cnSaveOrPrint),
          ),
        ),
      ],
    );
  }
}

Future<void> shareReportFile(
  BuildContext context,
  Uint8List bytes,
  String fileName,
) async {
  final l = AppLocalizations.of(context)!;
  try {
    final file = File('${Directory.systemTemp.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    final result = await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path, mimeType: 'application/pdf')]),
    );
    if (!context.mounted) return;
    if (result.status != ShareResultStatus.success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.cnShareCancelled)));
    }
  } catch (_) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l.cnErrNetwork)));
  }
}
