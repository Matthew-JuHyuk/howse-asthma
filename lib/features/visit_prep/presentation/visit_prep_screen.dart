import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../records/data/records_loader.dart';
import '../../records/data/records_revision.dart';
import '../../records/domain/record_models.dart';
import '../../records/domain/record_summary.dart';
import '../data/visit_prep_repository.dart';
import '../domain/visit_summary.dart';
import 'visit_preview_screen.dart';

/// Visit prep — what to share at the visit, then preview → English PDF.
/// Internal screen id: SCR-PAT-REPORT.
class VisitPrepScreen extends StatefulWidget {
  const VisitPrepScreen({super.key});

  @override
  State<VisitPrepScreen> createState() => _VisitPrepScreenState();
}

class _VisitPrepScreenState extends State<VisitPrepScreen> {
  static const _questionFields = 3;

  final _repo = VisitPrepRepository();
  final _loader = RecordsLoader();
  final _questionCtrls = List.generate(
    _questionFields,
    (_) => TextEditingController(),
  );
  final _barrierOtherCtrl = TextEditingController();
  final _insuranceCtrls = {
    for (final k in VisitPrepDraft.insuranceKeys) k: TextEditingController(),
  };

  VisitPrepDraft _draft = const VisitPrepDraft();
  RecordBundle? _bundle;
  RecordSummary? _summary;
  bool _loading = true;
  bool _loadFailed = false;
  Timer? _saveTimer;
  bool _saveFailed = false;

  @override
  void initState() {
    super.initState();
    RecordsRevision.instance.addListener(_loadRecords);
    _load();
  }

  @override
  void dispose() {
    RecordsRevision.instance.removeListener(_loadRecords);
    _saveTimer?.cancel();
    if (!_loading) unawaited(_saveNow());
    for (final c in [..._questionCtrls, _barrierOtherCtrl]) {
      c.dispose();
    }
    for (final c in _insuranceCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final draft = await _repo.load();
      if (!mounted) return;
      _draft = draft;
      for (var i = 0; i < _questionFields; i++) {
        _questionCtrls[i].text = i < draft.questions.length
            ? draft.questions[i].text
            : '';
      }
      _barrierOtherCtrl.text = draft.barrierOther ?? '';
      for (final e in _insuranceCtrls.entries) {
        e.value.text = draft.insuranceNotes[e.key] ?? '';
      }
      setState(() {
        _loading = false;
        _loadFailed = false;
      });
      await _loadRecords();
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          _loadFailed = true;
        });
      }
    }
  }

  Future<void> _loadRecords() async {
    final range = RecordRange.lastDays(_draft.periodDays);
    try {
      final bundle = await _loader.load(range);
      if (!mounted) return;
      setState(() {
        _bundle = bundle;
        _summary = RecordSummary.compute(range, bundle);
      });
    } catch (_) {}
  }

  VisitPrepDraft _collect() {
    final lang = Localizations.localeOf(context).languageCode;
    final previous = {for (final q in _draft.questions) q.text: q.language};
    return _draft.copyWith(
      questions: [
        for (final c in _questionCtrls)
          if (c.text.trim().isNotEmpty)
            VisitQuestion(
              text: c.text.trim(),
              language: previous[c.text.trim()] ?? lang,
            ),
      ],
      barrierOther: _barrierOtherCtrl.text,
      clearBarrierOther: !_draft.barriers.contains('other'),
      insuranceNotes: {
        for (final e in _insuranceCtrls.entries)
          if (e.value.text.trim().isNotEmpty) e.key: e.value.text.trim(),
      },
      sourceLanguage: lang,
    );
  }

  void _changed([VisitPrepDraft? next]) {
    setState(() => _draft = next ?? _collect());
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 800), _saveNow);
  }

  Future<void> _saveNow() async {
    try {
      await _repo.save(_draft);
      if (mounted && _saveFailed) setState(() => _saveFailed = false);
    } catch (_) {
      if (mounted) setState(() => _saveFailed = true);
    }
  }

  void _toggleBarrier(String code, bool on) {
    final next = {..._draft.barriers};
    if (on) {
      if (code == 'none' || code == 'no_answer') {
        next.clear();
      } else {
        next.removeAll(['none', 'no_answer']);
      }
      next.add(code);
    } else {
      next.remove(code);
    }
    _changed(_collect().copyWith(barriers: next));
  }

  Future<void> _openPreview() async {
    _saveTimer?.cancel();
    final draft = _collect();
    setState(() => _draft = draft);
    await _saveNow();
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => VisitPreviewScreen(draft: draft)),
    );
    if (!mounted) return;
    try {
      final reloaded = await _repo.load();
      if (mounted) setState(() => _draft = reloaded);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_loadFailed) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(l10n.s5RecordsLoadFailed, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              OutlinedButton(onPressed: _load, child: Text(l10n.authRetry)),
            ],
          ),
        ),
      );
    }

    final s = _summary;
    final bundle = _bundle;
    final stale =
        _draft.lastGeneratedAt != null &&
        bundle != null &&
        _draft.lastGeneratedFingerprint != visitFingerprint(_draft, bundle);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        Text(
          l10n.s5VisitPrepTitle,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.s5VisitIntro,
          style: const TextStyle(fontSize: 16, color: AppTheme.neutral700),
        ),
        if (stale) ...[
          const SizedBox(height: 12),
          _Notice(
            icon: Icons.update,
            text: l10n.s5PdfOutdated,
          ),
        ],
        if (_saveFailed) ...[
          const SizedBox(height: 12),
          _Notice(icon: Icons.cloud_off, text: l10n.s5SaveFailed),
        ],
        _Heading(l10n.s5VisitPeriod),
        SegmentedButton<int>(
          segments: [
            ButtonSegment(value: 7, label: Text(l10n.s5Last7Days)),
            ButtonSegment(value: 30, label: Text(l10n.s5Last30Days)),
          ],
          selected: {_draft.periodDays},
          onSelectionChanged: (v) {
            _changed(_collect().copyWith(periodDays: v.first));
            setState(() => _summary = null);
            _loadRecords();
          },
        ),
        if (s != null) ...[
          const SizedBox(height: 8),
          Text(
            l10n.s5PeriodAndRecordedDays(s.range.days, s.recordedDays),
            style: const TextStyle(color: AppTheme.neutral700),
          ),
        ],
        _Heading(l10n.s5VisitQuestions),
        Text(
          l10n.s5VisitQuestionsHint,
          style: const TextStyle(color: AppTheme.neutral700),
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < _questionFields; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: TextField(
              controller: _questionCtrls[i],
              minLines: 1,
              maxLines: 4,
              maxLength: 500,
              decoration: InputDecoration(
                labelText: l10n.s5QuestionN(i + 1),
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) => _changed(),
            ),
          ),
        _Heading(l10n.s5VisitBarriers),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final code in VisitPrepDraft.barrierCodes)
              FilterChip(
                label: Text(s5BarrierLabel(l10n, code)),
                selected: _draft.barriers.contains(code),
                onSelected: (on) => _toggleBarrier(code, on),
              ),
          ],
        ),
        if (_draft.barriers.contains('other')) ...[
          const SizedBox(height: 8),
          TextField(
            controller: _barrierOtherCtrl,
            maxLength: 300,
            decoration: InputDecoration(
              labelText: l10n.s5BarrierOtherHint,
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) => _changed(),
          ),
        ],
        _Heading(l10n.s5VisitInclude),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: _draft.includeSymptoms,
          title: Text(l10n.s5FilterSymptoms),
          onChanged: (v) =>
              _changed(_collect().copyWith(includeSymptoms: v ?? false)),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: _draft.includeInhaler,
          title: Text(l10n.s5FilterInhaler),
          onChanged: (v) =>
              _changed(_collect().copyWith(includeInhaler: v ?? false)),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: _draft.includeMedChecks,
          title: Text(l10n.s5FilterMedCheck),
          onChanged: (v) =>
              _changed(_collect().copyWith(includeMedChecks: v ?? false)),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: _draft.includeEnvironment,
          title: Text(l10n.s5IncludeEnvironment),
          subtitle: Text(l10n.s5IncludeEnvironmentHint),
          onChanged: (v) =>
              _changed(_collect().copyWith(includeEnvironment: v ?? false)),
        ),
        if (s != null && _fewRecords(s)) ...[
          const SizedBox(height: 8),
          _Notice(icon: Icons.info_outline, text: l10n.s5FewRecordsNotice),
        ],
        const SizedBox(height: 16),
        FilledButton.icon(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          onPressed: _openPreview,
          icon: const Icon(Icons.preview_outlined),
          label: Text(l10n.s5PreviewSummary),
        ),
        const SizedBox(height: 16),
        Material(
          color: AppTheme.neutral0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppTheme.neutral200),
          ),
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            title: Text(l10n.s5InsuranceTitle),
            subtitle: Text(l10n.s5InsuranceIntro),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              for (final key in VisitPrepDraft.insuranceKeys)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _insuranceCtrls[key],
                    minLines: 1,
                    maxLines: 4,
                    maxLength: 500,
                    decoration: InputDecoration(
                      labelText: s5InsuranceLabel(l10n, key),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (_) => _changed(),
                  ),
                ),
              Text(
                l10n.s5InsuranceLimits,
                style: const TextStyle(color: AppTheme.neutral700),
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool _fewRecords(RecordSummary s) {
    if (s.isEmpty) return true;
    if (_draft.includeSymptoms && (_bundle?.symptoms.isEmpty ?? true)) {
      return true;
    }
    if (_draft.includeInhaler && s.inhalerUses == 0) return true;
    if (_draft.includeMedChecks && s.medAnsweredDays == 0) return true;
    return false;
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 24, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    ),
  );
}

class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Material(
    color: const Color(0xFFFFF7ED),
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.warning600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(color: AppTheme.neutral800)),
          ),
        ],
      ),
    ),
  );
}
