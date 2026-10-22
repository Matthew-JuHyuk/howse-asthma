import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../l10n/app_localizations.dart';
import '../data/ai_extra_client.dart';
import '../data/case_store.dart';
import '../data/consent_repository.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../domain/s9_models.dart';
import '../ui/brand.dart';
import 'case_labels.dart';

/// The text read from each page, with the quote the user tapped highlighted.
class LetterView extends StatefulWidget {
  const LetterView({
    super.key,
    required this.store,
    required this.detail,
    required this.facts,
    required this.onContinue,
    this.focusPage,
    this.focusQuote,
    this.onReplace,
  });

  final CaseStore store;
  final CaseDetail detail;
  final CaseFacts facts;
  final int? focusPage;
  final String? focusQuote;
  final VoidCallback? onReplace;
  final VoidCallback onContinue;

  @override
  State<LetterView> createState() => _LetterViewState();
}

class _LetterViewState extends State<LetterView> {
  final _keys = <int, GlobalKey>{};
  var _tab = 0;
  List<PageTranslation> _tr = const [];
  var _translating = false;

  @override
  void initState() {
    super.initState();
    _scrollToFocus();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeAutoTranslate());
  }

  Future<void> _maybeAutoTranslate() async {
    if (!mounted || _tab == 1 || _translating) return;
    final lang = Localizations.localeOf(context).toLanguageTag();
    if (lang.toLowerCase().startsWith('en')) return;
    final consent = ConsentRepository();
    final allowed = await consent.hasActive(ConsentPurpose.translate) ||
        await consent.hasActive(ConsentPurpose.letter);
    if (!allowed || !mounted) return;
    setState(() => _tab = 1);
    await _translate();
  }

  @override
  void didUpdateWidget(LetterView old) {
    super.didUpdateWidget(old);
    if (old.focusPage != widget.focusPage ||
        old.focusQuote != widget.focusQuote) {
      _scrollToFocus();
    }
    if (old.detail.row.status != widget.detail.row.status ||
        old.detail.pages.length != widget.detail.pages.length) {
      _maybeAutoTranslate();
    }
  }

  Future<void> _translate() async {
    final l = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).toLanguageTag();
    if (lang.toLowerCase().startsWith('en')) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l.cnSameLanguage)));
      }
      return;
    }
    final consent = ConsentRepository();
    if (!await consent.hasActive(ConsentPurpose.translate) &&
        !await consent.hasActive(ConsentPurpose.letter)) {
      if (!mounted) return;
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l.cnConsentTranslatePurpose),
          content: Text(l.cnConsentAiBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l.cnConsentLater),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l.cnConsentAndAnalyze),
            ),
          ],
        ),
      );
      if (ok != true) return;
      await consent.accept(ConsentPurpose.translate);
    }
    setState(() => _translating = true);
    try {
      final cached = await AiExtraClient().loadCachedTranslation(
        caseId: widget.detail.row.id,
        language: lang,
        documentRevision: widget.detail.row.documentRevision,
      );
      final ready = cached.where((p) => p.status == 'ready' && (p.text ?? '').isNotEmpty);
      final pages = ready.length == cached.length && cached.isNotEmpty
          ? cached
          : await AiExtraClient().ensureFullTranslation(
              caseId: widget.detail.row.id,
              language: lang,
              documentRevision: widget.detail.row.documentRevision,
            );
      if (mounted) setState(() => _tr = pages);
    } on StateError catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(caseErrorText(l, e.message))),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.cnTranslationFailed)),
        );
      }
    } finally {
      if (mounted) setState(() => _translating = false);
    }
  }

  void _scrollToFocus() {
    final p = widget.focusPage;
    if (p == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _keys[p]?.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 300),
          alignment: 0.05,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final d = widget.detail;
    final f = widget.facts;
    final unclear = f.pages
        .where((p) => p.legibility != 'clear')
        .map((p) => p.pageNumber)
        .toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
      children: [
        CnCard(
          color: CnColors.mint.withValues(alpha: 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                documentKindLabel(l, f.kind),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CnColors.navy,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l.cnLetterPagesRead(d.pages.length),
                style: const TextStyle(color: CnColors.muted),
              ),
            ],
          ),
        ),
        if (unclear.isNotEmpty) ...[
          const SizedBox(height: 12),
          CnCard(
            color: CnColors.warnBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.cnPagesHardToRead(unclear.join(', ')),
                  style: const TextStyle(
                    color: CnColors.warn,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.onReplace != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: widget.onReplace,
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: Text(l.cnRetakePages),
                    ),
                  ),
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        SegmentedButton<int>(
          segments: [
            ButtonSegment(value: 0, label: Text(l.cnOriginalFile)),
            ButtonSegment(value: 1, label: Text(l.cnFullTranslation)),
          ],
          selected: {_tab},
          onSelectionChanged: (s) async {
            setState(() => _tab = s.first);
            if (s.first == 1) await _translate();
          },
        ),
        if (_tab == 0)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => openOriginalPages(context, widget.store, d),
              icon: const Icon(Icons.image_outlined),
              label: Text(l.cnOriginalFile),
            ),
          ),
        if (_tab == 1) ...[
          if (_translating) const LinearProgressIndicator(),
          if (!_translating && _tr.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(l.cnTranslationPartial),
            ),
          for (final p in _tr)
            CnCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.cnPageN(p.pageNumber)),
                  Text(p.text ?? (p.status == 'failed' ? l.cnTranslationFailed : l.cnHardToRead)),
                ],
              ),
            ),
          TextButton(
            onPressed: _translate,
            child: Text(l.cnTranslateRetry),
          ),
        ],
        ExpansionTile(
          title: Text(l.cnRecognizedText),
          children: [
        for (final p in d.pages)
          Padding(
            key: _keys.putIfAbsent(p.pageNumber, GlobalKey.new),
            padding: const EdgeInsets.only(top: 8),
            child: CnCard(
              color: p.pageNumber == widget.focusPage
                  ? const Color(0xFFF2FBF8)
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: SectionLabel(l.cnPageN(p.pageNumber))),
                      if (p.legibility != null && p.legibility != 'clear')
                        StatusChip(l.cnHardToRead, tone: ChipTone.warn),
                    ],
                  ),
                  _HighlightedText(
                    text: p.text ?? '',
                    quote: p.pageNumber == widget.focusPage
                        ? widget.focusQuote
                        : null,
                  ),
                ],
              ),
            ),
          ),
          ],
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: widget.onContinue,
          child: Text(l.cnContinueToReview),
        ),
      ],
    );
  }
}

class _HighlightedText extends StatelessWidget {
  const _HighlightedText({required this.text, this.quote});

  final String text;
  final String? quote;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 15, height: 1.45, color: CnColors.ink);
    final q = quote?.trim();
    if (q == null || q.isEmpty) return SelectableText(text, style: style);
    final at = text.indexOf(q);
    if (at < 0) {
      final norm = text.toLowerCase().indexOf(q.toLowerCase());
      if (norm < 0) return SelectableText(text, style: style);
      return _spans(norm, q.length, style);
    }
    return _spans(at, q.length, style);
  }

  Widget _spans(int at, int len, TextStyle style) => SelectableText.rich(
    TextSpan(
      style: style,
      children: [
        TextSpan(text: text.substring(0, at)),
        TextSpan(
          text: text.substring(at, at + len),
          style: const TextStyle(
            backgroundColor: Color(0xFFFFE8A3),
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(text: text.substring(at + len)),
      ],
    ),
  );
}

/// Shows the stored pages as uploaded (photo, PDF, or the demo's text).
Future<void> openOriginalPages(
  BuildContext context,
  CaseStore store,
  CaseDetail d,
) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => _OriginalPages(store: store, detail: d),
    ),
  );
}

class _OriginalPages extends StatefulWidget {
  const _OriginalPages({required this.store, required this.detail});

  final CaseStore store;
  final CaseDetail detail;

  @override
  State<_OriginalPages> createState() => _OriginalPagesState();
}

class _OriginalPagesState extends State<_OriginalPages> {
  final _bytes = <int, Uint8List?>{};
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    setState(() => _failed = false);
    for (final f in widget.detail.files) {
      try {
        final b = f.bytes ?? await widget.store.loadFile(f);
        if (mounted) setState(() => _bytes[f.fileIndex] = b);
      } catch (_) {
        if (mounted) setState(() => _failed = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final files = widget.detail.files;
    return Scaffold(
      appBar: AppBar(title: Text(l.cnOriginalPages)),
      body: files.isEmpty
          ? Center(child: Text(l.cnNoOriginal))
          : _failed && _bytes.isEmpty
          ? Center(
              child: ActionMessage(
                icon: Icons.cloud_off,
                title: l.cnErrNetwork,
                actionLabel: l.cnRetry,
                onAction: _loadAll,
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                for (final f in files)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _file(l, f),
                  ),
              ],
            ),
    );
  }

  Widget _file(AppLocalizations l, LetterFile f) {
    final b = _bytes[f.fileIndex];
    if (b == null) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (f.mime.startsWith('image/')) {
      return InteractiveViewer(maxScale: 5, child: Image.memory(b));
    }
    if (f.mime == 'application/pdf') {
      return SizedBox(
        height: 560,
        child: PdfPreview(
          build: (_) async => b,
          useActions: false,
          canChangeOrientation: false,
          canChangePageFormat: false,
          canDebug: false,
        ),
      );
    }
    return CnCard(
      child: SelectableText(
        utf8.decode(b, allowMalformed: true),
        style: const TextStyle(fontSize: 15, height: 1.45),
      ),
    );
  }
}
