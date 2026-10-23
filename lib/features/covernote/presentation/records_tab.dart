import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/locale/app_languages.dart';
import '../../../core/session/session_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../panic/presentation/panic_screen.dart';
import '../../records/data/records_revision.dart';
import '../../records/presentation/my_medications_screen.dart';
import '../auth/auth_screen.dart';
import '../../records/data/symptom_repository.dart';
import '../../records/domain/record_models.dart';
import '../../records/presentation/record_inputs.dart';
import '../data/medication_use_repository.dart';
import '../domain/record_snapshot.dart';
import '../domain/s9_models.dart';
import '../ui/app_chrome.dart';
import '../ui/brand.dart';
import 'air_weather_screen.dart';
import 'case_labels.dart';
import 'quick_log.dart';
import 'care_profile_records.dart';
import 'preparation_strings.dart';

String _symptomLine(AppLocalizations l, SymptomRecord s) {
  if (s.noSymptoms) return l.s5SymNone;
  final names = [
    for (final code in s.symptoms)
      switch (code) {
        'cough' => l.s5SymCough,
        'wheeze' => l.s5SymWheeze,
        'short_breath' => l.s5SymShortBreath,
        'night_waking' => l.s5SymNightWaking,
        'activity_limited' => l.s5SymActivityLimited,
        _ => code,
      },
  ];
  final extra = s.otherText?.trim();
  if (extra != null && extra.isNotEmpty) names.add(extra);
  if (names.isEmpty) return l.s5SymptomEntry;
  return names.join(', ');
}

String _useLabel(AppLocalizations l, UseKind kind) => switch (kind) {
  UseKind.asNeeded => l.cnAsNeededUse,
  UseKind.scheduled => l.cnScheduledUse,
  UseKind.unspecified => l.cnUsedShort,
};

/// One Records screen: today log + week/month calendar + day timeline.
class RecordsTab extends StatefulWidget {
  const RecordsTab({super.key});

  @override
  State<RecordsTab> createState() => _RecordsTabState();
}

class _RecordsTabState extends State<RecordsTab> {
  DateTime _selected = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  var _month = false;
  List<MedicationUseEvent> _events = const [];
  List<SymptomRecord> _symptoms = const [];
  RecordQueryState _state = RecordQueryState.loading;
  String? _loadedFor;

  @override
  void initState() {
    super.initState();
    RecordsRevision.instance.addListener(_reload);
  }

  @override
  void dispose() {
    RecordsRevision.instance.removeListener(_reload);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = SessionScope.of(context);
    final uid = s.isReady ? s.user?.id : null;
    if (uid != _loadedFor) {
      _loadedFor = uid;
      if (uid != null) _reload();
    }
  }

  Future<void> _reload() async {
    if (_loadedFor == null) return;
    setState(() => _state = RecordQueryState.loading);
    try {
      final range = _month
          ? DayRange(
              DateTime(_selected.year, _selected.month, 1),
              DateTime(_selected.year, _selected.month + 1, 0),
            )
          : DayRange.lastDays(_selected, 7);
      final list = await MedicationUseRepository().listBetween(range);
      final symptoms = await SymptomRepository().listBetween(
        range.from,
        range.to,
      );
      if (!mounted) return;
      setState(() {
        _events = list;
        _symptoms = symptoms;
        _state = list.isEmpty && symptoms.isEmpty
            ? RecordQueryState.genuinelyEmpty
            : RecordQueryState.available;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _state = e.toString().contains('42501')
            ? RecordQueryState.permissionError
            : RecordQueryState.fetchError;
      });
    }
  }

  List<MedicationUseEvent> get _dayEvents => [
    for (final e in _events)
      if (_sameDay(e.localDate, _selected)) e,
  ];

  List<SymptomRecord> get _daySymptoms => [
    for (final s in _symptoms)
      if (_sameDay((s.occurredAtUtc ?? s.recordedAtUtc).toLocal(), _selected))
        s,
  ];

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final session = SessionScope.of(context);
    return Scaffold(
      appBar: CoverNoteAppBar(title: Text(l.cnTabRecords)),
      body: RefreshIndicator(
        onRefresh: _reload,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 48),
          children: [
            if (!session.isReady)
              CnCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l.cnRecordsSignInBody),
                    FilledButton(
                      onPressed: () => requireSignIn(context),
                      child: Text(l.cnAuthSignIn),
                    ),
                  ],
                ),
              )
            else ...[
              OutlinedButton.icon(
                onPressed: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute(builder: (_) => const CareProfileRecords()),
                ),
                icon: const Icon(Icons.people_outline),
                label: Text(s10(context, 'careRecords')),
              ),
              QuickLogPanel(day: _selected),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () async {
                      if (await RecordInputs.editSymptoms(context)) {
                        RecordsRevision.instance.bump();
                      }
                    },
                    icon: const Icon(Icons.monitor_heart_outlined),
                    label: Text(l.s5LogSymptoms),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      if (await RecordInputs.editMedCheck(context)) {
                        RecordsRevision.instance.bump();
                      }
                    },
                    icon: const Icon(Icons.fact_check_outlined),
                    label: Text(l.s5MedCheckTitle),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment(value: false, label: Text(l.cnWeekCalendar)),
                  ButtonSegment(value: true, label: Text(l.cnMonthCalendar)),
                ],
                selected: {_month},
                onSelectionChanged: (s) {
                  setState(() => _month = s.first);
                  _reload();
                },
              ),
              const SizedBox(height: 8),
              _CalendarGrid(
                month: _month,
                selected: _selected,
                marked: {
                  for (final e in _events)
                    DateTime(
                      e.localDate.year,
                      e.localDate.month,
                      e.localDate.day,
                    ),
                  for (final s in _symptoms)
                    DateTime(
                      (s.occurredAtUtc ?? s.recordedAtUtc).toLocal().year,
                      (s.occurredAtUtc ?? s.recordedAtUtc).toLocal().month,
                      (s.occurredAtUtc ?? s.recordedAtUtc).toLocal().day,
                    ),
                },
                onSelect: (d) => setState(() => _selected = d),
              ),
              const SizedBox(height: 6),
              Text(
                l.cnCalendarLegend,
                style: const TextStyle(fontSize: 13, color: CnColors.muted),
              ),
              SectionLabel(formatDay(context, _selected)),
              if (_state == RecordQueryState.loading)
                const Center(child: CircularProgressIndicator()),
              if (_state == RecordQueryState.fetchError)
                ActionMessage(
                  icon: Icons.cloud_off,
                  title: l.cnRecordsError,
                  actionLabel: l.cnRetry,
                  onAction: _reload,
                ),
              if (_state == RecordQueryState.permissionError)
                Text(l.cnRecordsPermission),
              if (_state == RecordQueryState.genuinelyEmpty ||
                  (_state == RecordQueryState.available &&
                      _dayEvents.isEmpty &&
                      _daySymptoms.isEmpty))
                Text(l.cnNoRecordThatDay),
              for (final s in _daySymptoms)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CnCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.s5SymptomEntry,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(_symptomLine(l, s)),
                      ],
                    ),
                  ),
                ),
              for (final e in _dayEvents)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: CnCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.medicationName ?? _useLabel(l, e.useKind),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                [
                                  _useLabel(l, e.useKind),
                                  switch (e.syncStatus) {
                                    'pending' => l.cnLoggedPending,
                                    'synced' => l.cnLoggedSynced,
                                    _ => l.cnLoggedLocal,
                                  },
                                ].join(' · '),
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: CnColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: l.cnUndoUse,
                          onPressed: () async {
                            await MedicationUseRepository().undo(e);
                            await _reload();
                          },
                          icon: const Icon(Icons.undo),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 4),
              const AirWeatherLink(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.medication_outlined,
                  color: CnColors.teal,
                ),
                title: Text(l.cnManageMedsLink),
                subtitle: Text(l.cnMedManageHint),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyMedicationsScreen(),
                  ),
                ).then((_) => _reload()),
              ),
            ],
            SectionLabel(l.cnHelp),
            ListTile(
              leading: const Icon(Icons.emergency_outlined),
              title: Text(l.cnUrgentHelp),
              subtitle: Text(l.cnUrgentHelpSub),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PanicScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({
    required this.month,
    required this.selected,
    required this.marked,
    required this.onSelect,
  });

  final bool month;
  final DateTime selected;
  final Set<DateTime> marked;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final locale = intlLocaleFor(Localizations.localeOf(context));
    final sunday = DateTime(2026, 10, 18);
    final heads = [
      for (var i = 0; i < 7; i++)
        DateFormat.E(locale).format(sunday.add(Duration(days: i))),
    ];
    final days = <DateTime?>[];
    if (month) {
      final first = DateTime(selected.year, selected.month, 1);
      final lead = first.weekday % 7;
      for (var i = 0; i < lead; i++) {
        days.add(null);
      }
      final last = DateTime(selected.year, selected.month + 1, 0).day;
      for (var i = 1; i <= last; i++) {
        days.add(DateTime(selected.year, selected.month, i));
      }
    } else {
      final start = selected.subtract(Duration(days: selected.weekday % 7));
      for (var i = 0; i < 7; i++) {
        days.add(DateTime(start.year, start.month, start.day + i));
      }
    }
    final today = DateTime.now();
    return Column(
      children: [
        Row(
          children: [
            for (final h in heads)
              Expanded(
                child: Text(
                  h,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: CnColors.muted),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1,
          children: [
            for (final d in days)
              if (d == null)
                const SizedBox.shrink()
              else
                _DayCell(
                  day: d,
                  selected: d == selected,
                  marked: marked.contains(d),
                  today:
                      d.year == today.year &&
                      d.month == today.month &&
                      d.day == today.day,
                  onTap: () => onSelect(d),
                ),
          ],
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.selected,
    required this.marked,
    required this.today,
    required this.onTap,
  });

  final DateTime day;
  final bool selected;
  final bool marked;
  final bool today;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? Colors.white : CnColors.ink;
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? CnColors.teal : null,
            shape: BoxShape.circle,
            border: today && !selected
                ? Border.all(color: CnColors.teal, width: 1.5)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${day.day}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: marked
                      ? (selected ? Colors.white : CnColors.teal)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
