import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../environment/data/environment_controller.dart';
import '../../records/data/records_loader.dart';
import '../../records/data/snapshot_repository.dart';
import '../../records/domain/regimen_math.dart';
import '../../records/domain/record_models.dart';
import '../../records/domain/record_summary.dart';
import '../data/visit_pdf.dart';
import '../data/visit_prep_repository.dart';
import '../domain/visit_summary.dart';

/// Visit summary preview: patient language ↔ English, then PDF save/share.
class VisitPreviewScreen extends StatefulWidget {
  const VisitPreviewScreen({super.key, required this.draft});
  final VisitPrepDraft draft;

  @override
  State<VisitPreviewScreen> createState() => _VisitPreviewScreenState();
}

class _VisitPreviewScreenState extends State<VisitPreviewScreen> {
  bool _english = false;
  bool _loading = true;
  bool _failed = false;
  bool _busy = false;
  String? _pdfError;
  RecordBundle? _bundle;
  RecordSummary? _summary;
  List<EnvSnapshot> _snaps = const [];
  late final DateTime _generatedAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _failed = false;
    });
    final range = RecordRange.lastDays(widget.draft.periodDays);
    try {
      final bundle = await RecordsLoader().load(range);
      List<EnvSnapshot> snaps = const [];
      try {
        snaps = await SnapshotRepository().listRecent();
      } catch (_) {}
      if (!mounted) return;
      setState(() {
        _bundle = bundle;
        _snaps = snaps;
        _summary = RecordSummary.compute(range, bundle);
        _loading = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _failed = true;
        });
      }
    }
  }

  String _aqiLabel(AppLocalizations t, int? aqi) => switch (aqiBand(aqi)) {
    AqiBand.good => t.s5AqiGood,
    AqiBand.moderate => t.s5AqiModerate,
    AqiBand.usg => t.s5AqiUsg,
    AqiBand.unhealthy => t.s5AqiUnhealthy,
    AqiBand.veryUnhealthy => t.s5AqiVeryUnhealthy,
    AqiBand.hazardous => t.s5AqiHazardous,
    null => t.s5EnvNotAvailable,
  };

  VisitSummaryDoc _doc(BuildContext context, {required bool english}) {
    final locale = Localizations.localeOf(context);
    final t = english
        ? lookupAppLocalizations(const Locale('en'))
        : AppLocalizations.of(context)!;
    return VisitSummaryBuilder(
      t: t,
      localeTag: english ? 'en_US' : locale.toLanguageTag(),
      patientLang: widget.draft.sourceLanguage ?? locale.languageCode,
    ).build(
      draft: widget.draft,
      summary: _summary!,
      bundle: _bundle!,
      generatedAt: _generatedAt,
      environment: EnvironmentController.instance.snapshot,
      environmentLines: [
        for (final snap in _snaps.where((s) => s.linked))
          environmentSourceLine(
            pollutant: snap.pollutant,
            aqi: snap.aqiValue,
            category: _aqiLabel(t, snap.aqiValue),
            provider: snap.provider,
            observedAt: snap.observedAt?.toLocal().toString(),
            dataKind: snap.dataKind,
          ),
      ],
    );
  }

  Set<String> _scripts(VisitSummaryDoc doc) => {
    for (final s in doc.sections)
      for (final l in s.lines)
        if (l.originalLang != null) l.originalLang!,
    for (final l in doc.appendix)
      if (l.originalLang != null) l.originalLang!,
  };

  Future<void> _export({required bool share}) async {
    final l10n = AppLocalizations.of(context)!;
    final doc = _doc(context, english: true);
    setState(() {
      _busy = true;
      _pdfError = null;
    });
    try {
      final bytes = await VisitPdf.build(doc, scriptLanguages: _scripts(doc));
      final name =
          'visit-summary-${_generatedAt.toIso8601String().substring(0, 10)}.pdf';
      if (share) {
        await Printing.sharePdf(bytes: bytes, filename: name);
      } else {
        await Printing.layoutPdf(onLayout: (_) async => bytes, name: name);
      }
      await VisitPrepRepository().save(
        widget.draft.copyWith(
          lastGeneratedAt: _generatedAt,
          lastGeneratedFingerprint: visitFingerprint(widget.draft, _bundle!),
        ),
      );
    } on VisitPdfException catch (_) {
      if (mounted) setState(() => _pdfError = l10n.s5PdfFontFailed);
    } catch (_) {
      if (mounted) setState(() => _pdfError = l10n.s5PdfFailed);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isEnglishUi = Localizations.localeOf(context).languageCode == 'en';

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(title: Text(l10n.s5PreviewTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _failed
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.s5RecordsLoadFailed),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: _load, child: Text(l10n.authRetry)),
                ],
              ),
            )
          : _body(context, l10n, isEnglishUi),
    );
  }

  Widget _body(BuildContext context, AppLocalizations l10n, bool isEnglishUi) {
    final showEnglish = _english || isEnglishUi;
    final doc = _doc(context, english: showEnglish);
    final englishDoc = showEnglish ? doc : _doc(context, english: true);
    final untranslated = englishDoc.untranslatedCount;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            children: [
              if (!isEnglishUi)
                SegmentedButton<bool>(
                  segments: [
                    ButtonSegment(value: false, label: Text(l10n.s5MyLanguage)),
                    ButtonSegment(value: true, label: Text(l10n.s5EnglishVersion)),
                  ],
                  selected: {_english},
                  onSelectionChanged: (v) => setState(() => _english = v.first),
                ),
              if (untranslated > 0) ...[
                const SizedBox(height: 12),
                Material(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(l10n.s5UntranslatedNotice(untranslated)),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Text(
                doc.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              for (final m in doc.meta)
                Text(m, style: const TextStyle(color: AppTheme.neutral700)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.neutral400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(doc.disclaimer),
              ),
              for (final s in doc.sections) ...[
                const SizedBox(height: 16),
                Text(
                  s.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                for (final line in s.lines) _LineView(line),
              ],
              if (doc.appendix.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  doc.appendixTitle,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                for (final line in doc.appendix) _LineView(line),
              ],
              const SizedBox(height: 16),
              Text(
                l10n.s5PreviewEditHint,
                style: const TextStyle(color: AppTheme.neutral700),
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_pdfError != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      _pdfError!,
                      style: const TextStyle(color: AppTheme.error600),
                    ),
                  ),
                Text(
                  l10n.s5PdfIsEnglish,
                  style: const TextStyle(color: AppTheme.neutral700),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  alignment: WrapAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(48, 52),
                      ),
                      onPressed: _busy ? null : () => _export(share: true),
                      icon: const Icon(Icons.ios_share),
                      label: Text(l10n.s5Share),
                    ),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(48, 52),
                      ),
                      onPressed: _busy ? null : () => _export(share: false),
                      icon: _busy
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.picture_as_pdf_outlined),
                      label: Text(l10n.s5SavePdf),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LineView extends StatelessWidget {
  const _LineView(this.line);
  final SummaryLine line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('•  ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              line.text,
              style: TextStyle(
                fontSize: 16,
                color: line.untranslated ? AppTheme.warning600 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
