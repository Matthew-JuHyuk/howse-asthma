import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../data/case_store.dart';
import '../domain/case_models.dart';
import '../domain/record_snapshot.dart';
import '../ui/brand.dart';
import 'case_labels.dart';
import 'review_step.dart' show ShowQuote;

/// Requested items from the letter, matched to the patient's own records.
class EvidenceStep extends StatefulWidget {
  const EvidenceStep({
    super.key,
    required this.store,
    required this.detail,
    required this.onChanged,
    required this.onShowQuote,
    required this.onContinue,
  });

  final CaseStore store;
  final CaseDetail detail;
  final Future<void> Function() onChanged;
  final ShowQuote onShowQuote;
  final VoidCallback onContinue;

  @override
  State<EvidenceStep> createState() => _EvidenceStepState();
}

class _EvidenceStepState extends State<EvidenceStep> {
  late final DayRange _range = DayRange.lastDays(widget.store.today, 30);
  RecordSnapshots? _snap;
  String? _snapError;
  bool _busy = false;
  final _newItem = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSnapshots();
  }

  @override
  void dispose() {
    _newItem.dispose();
    super.dispose();
  }

  Future<void> _loadSnapshots() async {
    setState(() => _snapError = null);
    try {
      final s = await widget.store.loadSnapshots(_range);
      if (mounted) setState(() => _snap = s);
    } on CaseStoreException catch (e) {
      if (mounted) setState(() => _snapError = e.code);
    } catch (_) {
      if (mounted) setState(() => _snapError = 'network');
    }
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await action();
      await widget.onChanged();
    } on CaseStoreException catch (e) {
      if (mounted) _toast(caseErrorText(AppLocalizations.of(context)!, e.code));
    } catch (_) {
      if (mounted) _toast(AppLocalizations.of(context)!.cnErrNetwork);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String s) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));

  Map<String, Object?>? _snapshotJson(String type) {
    final s = _snap;
    if (s == null) return null;
    return switch (type) {
      'medication_summary' =>
        s.medication.isEmpty ? null : s.medication.toJson(),
      'symptom_summary' => s.symptoms.isEmpty ? null : s.symptoms.toJson(),
      'local_context' =>
        s.localContext.isEmpty ? null : s.localContext.toJson(),
      _ => null,
    };
  }

  String _sourceType(String type) {
    if (widget.store.isDemo) return 'synthetic';
    if (type == 'local_context' && (_snap?.localContext.synthetic ?? false)) {
      return 'synthetic';
    }
    return 'patient_reported';
  }

  Future<EvidenceItem> _ensureEvidence(String type) async {
    final existing = widget.detail.evidence
        .where((e) => e.recordType == type)
        .firstOrNull;
    if (existing != null) return existing;
    return widget.store.attachEvidence(
      widget.detail.row.id,
      recordType: type,
      snapshot: _snapshotJson(type)!,
      range: _range,
      sourceType: _sourceType(type),
    );
  }

  Future<void> _link(CaseRequirement r) async {
    final l = AppLocalizations.of(context)!;
    final options = [
      'medication_summary',
      'symptom_summary',
    ].where((t) => _snapshotJson(t) != null).toList();
    if (options.isEmpty) {
      _toast(l.cnNoRecordsToLink);
      return;
    }
    final type = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            Text(
              l.cnLinkTitle(r.label),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(l.cnLinkNote, style: const TextStyle(color: CnColors.muted)),
            const SizedBox(height: 8),
            for (final t in options)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  t == 'medication_summary'
                      ? Icons.medication_outlined
                      : Icons.monitor_heart_outlined,
                ),
                title: Text(recordTypeLabel(l, t)),
                subtitle: Text(_summaryLine(l, t)),
                onTap: () => Navigator.pop(ctx, t),
              ),
          ],
        ),
      ),
    );
    if (type == null) return;
    await _run(() async {
      final ev = await _ensureEvidence(type);
      await widget.store.updateRequirement(
        widget.detail.row.id,
        r.copyWith(status: RequirementStatus.linked, linkedEvidenceId: ev.id),
      );
    });
  }

  Future<void> _setStatus(CaseRequirement r, String status) => _run(() async {
    await widget.store.updateRequirement(
      widget.detail.row.id,
      r.copyWith(status: status, clearLink: status != RequirementStatus.linked),
    );
  });

  String _summaryLine(AppLocalizations l, String type) {
    final s = _snap!;
    switch (type) {
      case 'medication_summary':
        final m = s.medication;
        final parts = <String>[
          if (m.hasSchedule)
            l.cnMedLine(m.taken, m.notTaken, m.unknown, m.scheduled),
          if (m.prnUses > 0) l.cnPrnLine(m.prnUses, m.prnPuffs),
        ];
        return parts.isEmpty ? l.cnNoEntries : parts.join(' · ');
      case 'symptom_summary':
        final y = s.symptoms;
        return y.isEmpty
            ? l.cnNoEntries
            : l.cnSymptomLine(
                y.daysWithSymptoms,
                y.nightWakingDays,
                y.daysWithEntries,
                _range.dayCount,
              );
      default:
        final c = s.localContext;
        if (c.isEmpty) return l.cnNoEntries;
        final reports = c.reportCounts.values.fold(0, (a, b) => a + b);
        return [
          if (c.pm25Days > 0)
            l.cnPmLine(c.pm25Days, _range.dayCount, c.pm25DaysAbove100),
          if (reports > 0) l.cnReportsLine(reports),
          if (c.synthetic) l.cnSyntheticData,
        ].join(' · ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final d = widget.detail;
    final reqs = d.requirements;
    return AbsorbPointer(
      absorbing: _busy,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          if (_busy) const LinearProgressIndicator(),
          SectionLabel(l.cnLetterAsksFor),
          if (reqs.isEmpty)
            Text(
              l.cnNoItemsListed,
              style: const TextStyle(color: CnColors.muted),
            ),
          for (final r in reqs)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _RequirementCard(
                requirement: r,
                linked: d.evidence
                    .where((e) => e.id == r.linkedEvidenceId)
                    .firstOrNull,
                onLink: () => _link(r),
                onStatus: (s) => _setStatus(r, s),
                onShowQuote: widget.onShowQuote,
              ),
            ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newItem,
                  maxLength: 300,
                  decoration: InputDecoration(
                    labelText: l.cnAddItemLabel,
                    counterText: '',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                tooltip: l.cnAdd,
                onPressed: () {
                  final t = _newItem.text.trim();
                  if (t.isEmpty) return;
                  _run(() async {
                    await widget.store.addRequirement(d.row.id, t);
                    _newItem.clear();
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          SectionLabel(
            l.cnYourRecords(
              formatDay(context, _range.from),
              formatDay(context, _range.to),
            ),
          ),
          if (_snapError != null)
            ActionMessage(
              icon: Icons.cloud_off,
              title: caseErrorText(l, _snapError!),
              actionLabel: l.cnRetry,
              onAction: _loadSnapshots,
            )
          else if (_snap == null)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            )
          else
            for (final t in const [
              'medication_summary',
              'symptom_summary',
              'local_context',
            ])
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _RecordCard(
                  title: recordTypeLabel(l, t),
                  line: _summaryLine(l, t),
                  optionalNote: t == 'local_context'
                      ? l.cnLocalContextNote
                      : null,
                  available: _snapshotJson(t) != null,
                  attached: d.evidence
                      .where((e) => e.recordType == t)
                      .firstOrNull,
                  onAdd: () => _run(() async => _ensureEvidence(t)),
                  onRemove: (ev) =>
                      _run(() => widget.store.removeEvidence(d.row.id, ev.id)),
                ),
              ),
          const SizedBox(height: 16),
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: widget.onContinue,
              icon: const Icon(Icons.arrow_forward),
              label: Text(l.cnContinueToPacket),
            ),
          ),
        ],
      ),
    );
  }
}

class _RequirementCard extends StatelessWidget {
  const _RequirementCard({
    required this.requirement,
    required this.linked,
    required this.onLink,
    required this.onStatus,
    required this.onShowQuote,
  });

  final CaseRequirement requirement;
  final EvidenceItem? linked;
  final VoidCallback onLink;
  final ValueChanged<String> onStatus;
  final ShowQuote onShowQuote;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final r = requirement;
    final tone = switch (r.status) {
      RequirementStatus.linked => ChipTone.good,
      RequirementStatus.needed => ChipTone.warn,
      _ => ChipTone.neutral,
    };
    return CnCard(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            r.label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              StatusChip(requirementStatusLabel(l, r.status), tone: tone),
              StatusChip(
                r.origin == 'user_added' ? l.cnAddedByYou : l.cnFromLetter,
              ),
              StatusChip(l.cnWhoHasIt(responsibleLabel(l, r.responsible))),
            ],
          ),
          if (linked != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                l.cnLinkedTo(recordTypeLabel(l, linked!.recordType)),
                style: const TextStyle(color: CnColors.teal),
              ),
            ),
          if (r.sourceQuote != null || r.sourcePage != null)
            TextButton.icon(
              onPressed: () => onShowQuote(r.sourcePage, r.sourceQuote),
              icon: const Icon(Icons.format_quote, size: 18),
              label: Text(
                r.sourcePage == null
                    ? l.cnSeeInLetter
                    : l.cnSeePage(r.sourcePage!),
              ),
            ),
          Wrap(
            spacing: 4,
            children: [
              if (r.status != RequirementStatus.linked)
                FilledButton.tonalIcon(
                  onPressed: onLink,
                  icon: const Icon(Icons.link),
                  label: Text(l.cnLinkRecords),
                ),
              PopupMenuButton<String>(
                tooltip: l.cnMoreActions,
                onSelected: onStatus,
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: RequirementStatus.askedCareTeam,
                    child: Text(l.cnReqAskedCareTeam),
                  ),
                  PopupMenuItem(
                    value: RequirementStatus.notAvailable,
                    child: Text(l.cnReqNotAvailable),
                  ),
                  PopupMenuItem(
                    value: RequirementStatus.notApplicable,
                    child: Text(l.cnReqNotNeeded),
                  ),
                  if (r.status != RequirementStatus.needed)
                    PopupMenuItem(
                      value: RequirementStatus.needed,
                      child: Text(l.cnReqReset),
                    ),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  child: Text(
                    l.cnOtherStatus,
                    style: const TextStyle(
                      color: CnColors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecordCard extends StatelessWidget {
  const _RecordCard({
    required this.title,
    required this.line,
    required this.available,
    required this.attached,
    required this.onAdd,
    required this.onRemove,
    this.optionalNote,
  });

  final String title;
  final String line;
  final String? optionalNote;
  final bool available;
  final EvidenceItem? attached;
  final VoidCallback onAdd;
  final ValueChanged<EvidenceItem> onRemove;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return CnCard(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (attached != null)
                StatusChip(
                  l.cnInPacket,
                  tone: ChipTone.good,
                  icon: Icons.check,
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(line, style: const TextStyle(fontSize: 15)),
          if (optionalNote != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                optionalNote!,
                style: const TextStyle(fontSize: 13, color: CnColors.muted),
              ),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: attached != null
                ? TextButton(
                    onPressed: () => onRemove(attached!),
                    child: Text(l.cnRemoveFromPacket),
                  )
                : TextButton.icon(
                    onPressed: available ? onAdd : null,
                    icon: const Icon(Icons.add),
                    label: Text(l.cnAddToPacket),
                  ),
          ),
        ],
      ),
    );
  }
}
