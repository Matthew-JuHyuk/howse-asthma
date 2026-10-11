import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../assessments/presentation/act_screen.dart';
import '../data/records_loader.dart';
import '../data/records_revision.dart';
import '../domain/record_models.dart';
import '../domain/record_summary.dart';
import 'record_inputs.dart';

enum _Filter { all, symptoms, inhaler, medCheck }

/// My log — dated timeline of every patient-reported record with edit/delete.
/// Internal screen id: SCR-PAT-LOG.
class MyLogScreen extends StatefulWidget {
  const MyLogScreen({super.key});

  @override
  State<MyLogScreen> createState() => _MyLogScreenState();
}

class _MyLogScreenState extends State<MyLogScreen> {
  final _loader = RecordsLoader();
  int _days = 7;
  _Filter _filter = _Filter.all;
  RecordBundle? _bundle;
  RecordSummary? _summary;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    RecordsRevision.instance.addListener(_load);
    _load();
  }

  @override
  void dispose() {
    RecordsRevision.instance.removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    final range = RecordRange.lastDays(_days);
    try {
      final bundle = await _loader.load(range);
      if (!mounted) return;
      setState(() {
        _bundle = bundle;
        _summary = RecordSummary.compute(range, bundle);
        _failed = false;
      });
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  Future<void> _addRecord() async {
    final l10n = AppLocalizations.of(context)!;
    final choice = await showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.medication_outlined),
              title: Text(l10n.s5LogInhaler),
              onTap: () => Navigator.pop(ctx, 'inhaler'),
            ),
            ListTile(
              leading: const Icon(Icons.edit_note),
              title: Text(l10n.s5LogSymptoms),
              onTap: () => Navigator.pop(ctx, 'symptoms'),
            ),
            ListTile(
              leading: const Icon(Icons.fact_check_outlined),
              title: Text(l10n.s5MedCheckTitle),
              onTap: () => Navigator.pop(ctx, 'med'),
            ),
          ],
        ),
      ),
    );
    if (!mounted || choice == null) return;
    switch (choice) {
      case 'inhaler':
        await RecordInputs.editInhaler(context);
      case 'symptoms':
        await RecordInputs.editSymptoms(context);
      case 'med':
        await RecordInputs.editMedCheck(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            l10n.s5MyLogTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SegmentedButton<int>(
                segments: [
                  ButtonSegment(value: 7, label: Text(l10n.s5Last7Days)),
                  ButtonSegment(value: 30, label: Text(l10n.s5Last30Days)),
                ],
                selected: {_days},
                onSelectionChanged: (s) {
                  setState(() {
                    _days = s.first;
                    _summary = null;
                  });
                  _load();
                },
              ),
              FilledButton.icon(
                style: FilledButton.styleFrom(minimumSize: const Size(48, 48)),
                onPressed: _addRecord,
                icon: const Icon(Icons.add),
                label: Text(l10n.s5AddRecord),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final f in _Filter.values)
                ChoiceChip(
                  label: Text(_filterLabel(l10n, f)),
                  selected: _filter == f,
                  onSelected: (_) => setState(() => _filter = f),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (_failed)
            _FailedBox(onRetry: _load)
          else if (_summary == null)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()),
            )
          else ...[
            RecordSummaryCard(summary: _summary!),
            const SizedBox(height: 16),
            ..._timeline(context, l10n),
          ],
          const SizedBox(height: 24),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.quiz_outlined, color: AppTheme.brand600),
            title: Text(l10n.s5ActTitle),
            subtitle: Text(l10n.s5ActSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ActScreen())),
          ),
        ],
      ),
    );
  }

  String _filterLabel(AppLocalizations l10n, _Filter f) => switch (f) {
    _Filter.all => l10n.s5FilterAll,
    _Filter.symptoms => l10n.s5FilterSymptoms,
    _Filter.inhaler => l10n.s5FilterInhaler,
    _Filter.medCheck => l10n.s5FilterMedCheck,
  };

  List<Widget> _timeline(BuildContext context, AppLocalizations l10n) {
    final b = _bundle!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final items = <_Item>[];
    if (_filter == _Filter.all || _filter == _Filter.inhaler) {
      for (final e in b.inhaler) {
        items.add(_Item(e.localDate, e.localTime, inhaler: e));
      }
    }
    if (_filter == _Filter.all || _filter == _Filter.symptoms) {
      for (final e in b.symptoms) {
        items.add(_Item(e.localDate, e.localTime, symptom: e));
      }
    }
    if (_filter == _Filter.all || _filter == _Filter.medCheck) {
      for (final e in b.medChecks) {
        items.add(_Item(e.date, null, med: e));
      }
    }
    if (items.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(l10n.s5NoRecordsYet, style: const TextStyle(fontSize: 16)),
        ),
      ];
    }
    items.sort((a, z) {
      final d = z.date.compareTo(a.date);
      if (d != 0) return d;
      final at = a.time ?? a.date;
      final zt = z.time ?? z.date;
      return zt.compareTo(at);
    });

    final out = <Widget>[];
    DateTime? current;
    for (final it in items) {
      if (current != it.date) {
        current = it.date;
        out.add(
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              DateFormat.yMMMEd(locale).format(it.date),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        );
      }
      out.add(_tile(context, l10n, locale, it));
    }
    return out;
  }

  Widget _tile(
    BuildContext context,
    AppLocalizations l10n,
    String locale,
    _Item it,
  ) {
    final time = it.time == null ? null : DateFormat.jm(locale).format(it.time!);
    if (it.inhaler != null) {
      final e = it.inhaler!;
      final med = e.medicationUnknown
          ? l10n.s5MedUnknownShort
          : (e.medicationLabel ?? l10n.s5MedNotRecorded);
      final parts = <String>[
        med,
        if (e.puffCount != null) l10n.s5PuffsValue(e.puffCount!),
        if (e.useReason != null) s5UseReasonLabel(l10n, e.useReason!),
        if (e.isPanic) l10n.s5FromUrgentHelp,
      ];
      return _EntryTile(
        icon: Icons.medication_outlined,
        title: [?time, l10n.s5InhalerEntry].join(' · '),
        subtitle: parts.join(' · '),
        note: e.note,
        onTap: () => RecordInputs.editInhaler(context, existing: e),
      );
    }
    if (it.symptom != null) {
      final e = it.symptom!;
      final parts = e.noSymptoms
          ? [l10n.s5SymNone]
          : [
              for (final c in e.symptoms) s5SymptomLabel(l10n, c),
              if (e.otherText != null) e.otherText!,
            ];
      return _EntryTile(
        icon: Icons.edit_note,
        title: [?time, l10n.s5SymptomEntry].join(' · '),
        subtitle: parts.join(', '),
        note: e.note,
        onTap: () => RecordInputs.editSymptoms(context, existing: e),
      );
    }
    final m = it.med!;
    return _EntryTile(
      icon: Icons.fact_check_outlined,
      title: l10n.s5MedCheckTitle,
      subtitle: [
        s5MedStatusLabel(l10n, m.status),
        if (m.reason != null) s5MedReasonLabel(l10n, m.reason!),
      ].join(' · '),
      onTap: () => RecordInputs.editMedCheck(context, existing: m),
    );
  }
}

class _Item {
  _Item(this.date, this.time, {this.inhaler, this.symptom, this.med});
  final DateTime date;
  final DateTime? time;
  final InhalerRecord? inhaler;
  final SymptomRecord? symptom;
  final MedCheckRecord? med;
}

class _EntryTile extends StatelessWidget {
  const _EntryTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.note,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String? note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.neutral200),
      ),
      child: ListTile(
        minVerticalPadding: 12,
        leading: Icon(icon, color: AppTheme.brand600),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (subtitle.isNotEmpty) Text(subtitle),
            if (note != null && note!.isNotEmpty)
              Text(
                note!,
                style: const TextStyle(color: AppTheme.neutral700),
              ),
          ],
        ),
        trailing: Semantics(
          label: l10n.s5Edit,
          child: const Icon(Icons.edit_outlined),
        ),
        onTap: onTap,
      ),
    );
  }
}

class _FailedBox extends StatelessWidget {
  const _FailedBox({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.s5RecordsLoadFailed),
        const SizedBox(height: 8),
        OutlinedButton(onPressed: onRetry, child: Text(l10n.authRetry)),
      ],
    );
  }
}

/// Same numbers as Home and the visit summary (one aggregation function).
class RecordSummaryCard extends StatelessWidget {
  const RecordSummaryCard({super.key, required this.summary});
  final RecordSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final s = summary;
    Widget line(String t) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(t, style: const TextStyle(fontSize: 16)),
    );
    return Material(
      color: AppTheme.brand50,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            line(l10n.s5PeriodAndRecordedDays(s.range.days, s.recordedDays)),
            if (s.isEmpty)
              line(l10n.s5NoRecordsYet)
            else ...[
              line(l10n.s5RecentInhaler(s.inhalerUses)),
              if (s.inhalerUnknownMedication > 0)
                line(l10n.s5InhalerUnknownCount(s.inhalerUnknownMedication)),
              line(l10n.s5RecentSymptomDays(s.symptomDays)),
              if (s.noSymptomDays > 0)
                line(l10n.s5NoSymptomDays(s.noSymptomDays)),
              line(
                l10n.s5MedCheckCounts(
                  s.medUsedDays,
                  s.medNotUsedDays,
                  s.medNotSureDays,
                  s.medNotRecordedDays,
                ),
              ),
              if (s.medNotApplicableDays > 0)
                line(l10n.s5MedNotApplicableDays(s.medNotApplicableDays)),
            ],
            const SizedBox(height: 4),
            Text(
              l10n.s5LogLegend,
              style: const TextStyle(fontSize: 14, color: AppTheme.neutral700),
            ),
          ],
        ),
      ),
    );
  }
}
