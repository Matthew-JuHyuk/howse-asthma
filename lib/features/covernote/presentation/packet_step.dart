import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

import '../../../l10n/app_localizations.dart';
import '../../records/domain/record_models.dart' show isoDate;
import '../data/case_store.dart';
import '../data/demo_case_store.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../pdf/packet_pdf.dart';
import '../ui/brand.dart';
import 'case_labels.dart';

Future<PacketResult> _buildInIsolate((PacketInput, ByteData, ByteData) args) =>
    buildPacketPdf(args.$1, PacketFonts.fromBytes(args.$2, args.$3));

/// One Generate button; results as Doctor summary / Review request draft.
class PacketStep extends StatefulWidget {
  const PacketStep({
    super.key,
    required this.store,
    required this.detail,
    required this.facts,
    required this.factRevision,
    required this.flush,
    required this.onReload,
    required this.onGoReview,
  });

  final CaseStore store;
  final CaseDetail detail;
  final CaseFacts facts;
  final int factRevision;
  final Future<bool> Function() flush;
  final Future<void> Function() onReload;
  final VoidCallback onGoReview;

  @override
  State<PacketStep> createState() => _PacketStepState();
}

class _PacketStepState extends State<PacketStep> {
  Uint8List? _bytes;
  int _pages = 0;
  String? _artifactId;
  bool _generating = false;
  bool _loadingSaved = false;
  bool _includeLetter = false;
  String? _error;

  CaseRow get _row => widget.detail.row;

  @override
  void initState() {
    super.initState();
    _openSaved();
  }

  @override
  void didUpdateWidget(PacketStep old) {
    super.didUpdateWidget(old);
    final latest = widget.detail.latestPacket;
    if (_bytes == null && latest != null && latest.id != _artifactId) {
      _openSaved();
    }
  }

  CaseArtifact? get _current {
    final a = widget.detail.latestPacket;
    if (a == null) return null;
    final row = _row.copyWith(factRevision: widget.factRevision);
    return a.isCurrentFor(row) ? a : null;
  }

  Future<void> _openSaved() async {
    final a = _current;
    if (a == null || _loadingSaved) return;
    setState(() => _loadingSaved = true);
    try {
      final b = await widget.store.loadPacketBytes(_row.id, a);
      if (b != null) {
        var n = 0;
        await for (final _ in Printing.raster(b, dpi: 4)) {
          n++;
        }
        if (mounted) {
          setState(() {
            _bytes = b;
            _pages = n;
            _artifactId = a.id;
          });
        }
      }
    } catch (_) {
      // The saved copy could not be opened; generating again is always possible.
    } finally {
      if (mounted) setState(() => _loadingSaved = false);
    }
  }

  Future<void> _generate() async {
    final l = AppLocalizations.of(context)!;
    setState(() {
      _generating = true;
      _error = null;
    });
    try {
      if (!await widget.flush()) {
        setState(() => _error = l.cnErrNotSavedYet);
        return;
      }
      final regular = await rootBundle.load(
        'assets/fonts/NotoSans-Regular.ttf',
      );
      final bold = await rootBundle.load('assets/fonts/NotoSans-Bold.ttf');
      final input = PacketInput(
        caseRow: _row.copyWith(factRevision: widget.factRevision),
        facts: widget.facts,
        requirements: widget.detail.requirements,
        evidence: widget.detail.evidence,
        generatedAt: widget.store.isDemo
            ? DemoCaseStore.demoToday
            : DateTime.now(),
        includeLetterText: _includeLetter,
        letterPages: widget.detail.pages,
      );
      final res = await compute(_buildInIsolate, (input, regular, bold));
      final art = await widget.store.savePacket(
        _row.id,
        res.bytes,
        factRevision: widget.factRevision,
        evidenceRevision: _row.evidenceRevision,
        includes: res.includes,
        isSample: input.isSample,
      );
      if (!mounted) return;
      setState(() {
        _bytes = res.bytes;
        _pages = res.pageCount;
        _artifactId = art.id;
      });
      if (art.status != 'ready') {
        setState(() => _error = l.cnPacketChangedMeanwhile);
      }
      await widget.onReload();
    } on CaseStoreException catch (e) {
      if (mounted) setState(() => _error = caseErrorText(l, e.code));
    } catch (e) {
      if (mounted) setState(() => _error = l.cnPacketFailed);
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  String get _fileName => packetFileName(
    widget.store.isDemo ? DemoCaseStore.demoToday : DateTime.now(),
  );

  Future<void> _share() async {
    final l = AppLocalizations.of(context)!;
    final ok = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l.cnBeforeSharingTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(l.cnBeforeSharingBody, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => Navigator.pop(ctx, true),
                icon: const Icon(Icons.ios_share),
                label: Text(l.cnShare),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.cnCancel),
              ),
            ],
          ),
        ),
      ),
    );
    if (ok != true || _bytes == null) return;
    final shared = await Printing.sharePdf(bytes: _bytes!, filename: _fileName);
    if (shared) await _markExported();
  }

  Future<void> _savePrint() async {
    if (_bytes == null) return;
    final done = await Printing.layoutPdf(
      onLayout: (_) async => _bytes!,
      name: _fileName,
    );
    if (done) await _markExported();
  }

  Future<void> _markExported() async {
    try {
      await widget.store.markExported(_row.id);
      await widget.onReload();
    } catch (_) {
      // The file was shared; only the "shared on" note could not be saved.
    }
  }

  Future<void> _reportSent() async {
    final l = AppLocalizations.of(context)!;
    final result = await showDialog<(DateTime, String)>(
      context: context,
      builder: (ctx) => _SentDialog(today: widget.store.today),
    );
    if (result == null) return;
    try {
      await widget.store.markSubmitted(
        _row.id,
        date: isoDate(result.$1),
        method: result.$2,
      );
      await widget.onReload();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.cnErrNetwork)));
      }
    }
  }

  String _methodLabel(AppLocalizations l, String m) => switch (m) {
    'fax' => l.cnMethodFax,
    'mail' => l.cnMethodMail,
    'portal' => l.cnMethodPortal,
    'in_person' => l.cnMethodInPerson,
    'care_team' => l.cnMethodCareTeam,
    _ => l.cnMethodOther,
  };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final f = widget.facts;
    final draft = f.supportsReviewDraft;
    final latest = widget.detail.latestPacket;
    final stale = latest != null && _current == null;
    final bytes = stale ? null : _bytes;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        if (!draft)
          CnCard(
            color: CnColors.warnBg,
            child: Text(switch (f.kind) {
              'final_appeal_denial' => l.cnPacketNoDraftFinal,
              'eob_or_bill' => l.cnPacketNoDraftEob,
              'reauthorization_notice' => l.cnPacketNoDraftReauth,
              _ => l.cnPacketNoDraftOther,
            }, style: const TextStyle(fontSize: 15, color: CnColors.ink)),
          ),
        if (!draft) const SizedBox(height: 12),
        CnCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.cnPacketContains,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: CnColors.navy,
                ),
              ),
              const SizedBox(height: 6),
              if (needsTranslatedAid(context))
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    l.cnPacketEnglishNote,
                    style: const TextStyle(color: CnColors.muted),
                  ),
                ),
              Text('• ${l.cnPartSummary}'),
              if (draft) Text('• ${l.cnPartDraft}'),
              if (_includeLetter) Text('• ${l.cnPartLetterText}'),
              Text(
                l.cnPacketEvidenceCount(widget.detail.evidence.length),
                style: const TextStyle(color: CnColors.muted),
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: _includeLetter,
                onChanged: _generating
                    ? null
                    : (v) => setState(() => _includeLetter = v ?? false),
                title: Text(l.cnIncludeLetterText),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (stale)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CnCard(
              color: CnColors.warnBg,
              child: Text(
                l.cnPacketStale,
                style: const TextStyle(color: CnColors.warn),
              ),
            ),
          ),
        SizedBox(
          height: 52,
          child: FilledButton.icon(
            onPressed: _generating ? null : _generate,
            icon: _generating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.picture_as_pdf_outlined),
            label: Text(_generating ? l.cnGenerating : l.cnGeneratePacket),
          ),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_error!, style: const TextStyle(color: CnColors.warn)),
          ),
        if (_loadingSaved)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        if (bytes != null) ...[
          const SizedBox(height: 16),
          _Preview(bytes: bytes, pages: _pages, hasDraft: draft),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                onPressed: _share,
                icon: const Icon(Icons.ios_share),
                label: Text(l.cnShare),
              ),
              OutlinedButton.icon(
                onPressed: _savePrint,
                icon: const Icon(Icons.print_outlined),
                label: Text(l.cnSaveOrPrint),
              ),
              if (!widget.store.isDemo)
                OutlinedButton.icon(
                  onPressed: _reportSent,
                  icon: const Icon(Icons.outbox_outlined),
                  label: Text(l.cnISentIt),
                ),
            ],
          ),
        ],
        if (_row.lastExportedAt != null) ...[
          const SizedBox(height: 12),
          Text(
            l.cnSharedOn(formatDay(context, _row.lastExportedAt!.toLocal())),
            style: const TextStyle(color: CnColors.muted),
          ),
        ],
        if (_row.submittedOn != null) ...[
          const SizedBox(height: 4),
          Text(
            l.cnUserReportedSent(
              formatIsoDay(context, _row.submittedOn),
              _methodLabel(l, _row.submitMethod ?? 'other'),
            ),
            style: const TextStyle(
              color: CnColors.ink,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}

class _Preview extends StatelessWidget {
  const _Preview({
    required this.bytes,
    required this.pages,
    required this.hasDraft,
  });

  final Uint8List bytes;
  final int pages;
  final bool hasDraft;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    Widget preview(List<int> p) => SizedBox(
      height: 520,
      child: PdfPreview(
        key: ValueKey('${bytes.length}-${p.join(',')}'),
        build: (_) async => bytes,
        pages: p,
        useActions: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        maxPageWidth: 700,
      ),
    );
    final rest = [for (var i = 1; i < pages; i++) i];
    if (!hasDraft || rest.isEmpty) {
      return preview(pages > 1 ? [0, ...rest] : const [0]);
    }
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: l.cnTabDoctorSummary),
              Tab(text: l.cnTabReviewDraft),
            ],
          ),
          SizedBox(
            height: 520,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                preview(const [0]),
                preview(rest),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SentDialog extends StatefulWidget {
  const _SentDialog({required this.today});

  final DateTime today;

  @override
  State<_SentDialog> createState() => _SentDialogState();
}

class _SentDialogState extends State<_SentDialog> {
  late DateTime _date = widget.today;
  String _method = 'fax';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    const methods = [
      'fax',
      'mail',
      'portal',
      'in_person',
      'care_team',
      'other',
    ];
    String label(String m) => switch (m) {
      'fax' => l.cnMethodFax,
      'mail' => l.cnMethodMail,
      'portal' => l.cnMethodPortal,
      'in_person' => l.cnMethodInPerson,
      'care_team' => l.cnMethodCareTeam,
      _ => l.cnMethodOther,
    };
    return AlertDialog(
      title: Text(l.cnISentIt),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.cnSentExplain, style: const TextStyle(color: CnColors.muted)),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () async {
              final d = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(widget.today.year - 1),
                lastDate: widget.today,
              );
              if (d != null) setState(() => _date = d);
            },
            icon: const Icon(Icons.event),
            label: Text(formatDay(context, _date)),
          ),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: _method,
            isExpanded: true,
            items: [
              for (final m in methods)
                DropdownMenuItem(value: m, child: Text(label(m))),
            ],
            onChanged: (v) => setState(() => _method = v ?? _method),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l.cnCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, (_date, _method)),
          child: Text(l.cnSave),
        ),
      ],
    );
  }
}
