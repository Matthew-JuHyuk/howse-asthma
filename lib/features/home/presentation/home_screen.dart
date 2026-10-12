import 'package:flutter/material.dart';

import '../../../core/location/location_service.dart';
import '../../../core/push/medication_reminder.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../environment/data/environment_controller.dart';
import '../../environment/presentation/env_labels.dart';
import '../../locations/presentation/locations_screen.dart';
import '../../records/data/medication_repository.dart';
import '../../records/data/records_loader.dart';
import '../../records/data/regimen_repository.dart';
import '../../records/data/snapshot_repository.dart';
import '../../records/presentation/evidence_prep_screen.dart';
import '../../records/data/records_revision.dart';
import '../../records/domain/record_models.dart';
import '../../records/domain/record_summary.dart';
import '../../records/presentation/record_inputs.dart';
import '../../visit_prep/data/visit_prep_repository.dart';

/// Home — quick logging, what to share at the visit, recent summary,
/// and one condensed environment card. Internal screen id: SCR-PAT-HOME.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onOpenTab});

  /// 1 = My log, 2 = Visit prep, 3 = Environment.
  final ValueChanged<int> onOpenTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _env = EnvironmentController.instance;
  final _loader = RecordsLoader();

  RecordSummary? _summary;
  int _questionCount = 0;
  PatientMedication? _defaultMed;
  bool _dailyCheckEnabled = false;
  MedCheckRecord? _todayCheck;
  List<MedicationRegimen> _regimens = const [];
  List<OccasionCheck> _checks = const [];
  RecordBundle? _bundle;
  List<EnvSnapshot> _snaps = const [];
  bool _recordsFailed = false;

  @override
  void initState() {
    super.initState();
    RecordsRevision.instance.addListener(_loadRecords);
    _env.addListener(_onEnv);
    _loadRecords();
    WidgetsBinding.instance.addPostFrameCallback((_) => _env.ensureLoaded());
  }

  @override
  void dispose() {
    RecordsRevision.instance.removeListener(_loadRecords);
    _env.removeListener(_onEnv);
    super.dispose();
  }

  void _onEnv() {
    if (mounted) setState(() {});
  }

  Future<void> _loadRecords() async {
    final range = RecordRange.lastDays(7);
    try {
      final results = await Future.wait([
        _loader.load(range),
        VisitPrepRepository().load(),
        MedicationRepository().list(),
      ]);
      final bundle = results[0] as RecordBundle;
      final draft = results[1] as VisitPrepDraft;
      final meds = results[2] as List<PatientMedication>;
      final today = dateOnly(DateTime.now());
      List<MedicationRegimen> regimens = const [];
      List<OccasionCheck> checks = const [];
      List<EnvSnapshot> snaps = const [];
      try {
        regimens = await RegimenRepository().listAll();
        checks = await RegimenRepository().listBetween(range.start, range.end);
        snaps = await SnapshotRepository().listRecent();
      } catch (_) {}
      if (!mounted) return;
      setState(() {
        _summary = RecordSummary.compute(range, bundle);
        _questionCount = draft.questions.length;
        _defaultMed = meds.where((m) => m.isDefault).firstOrNull;
        _dailyCheckEnabled = meds.any((m) => m.dailyCheckEnabled);
        _todayCheck = bundle.medChecks
            .where((c) => c.date == today)
            .firstOrNull;
        _regimens = regimens;
        _checks = checks;
        _bundle = bundle;
        _snaps = snaps;
        _recordsFailed = false;
      });
      if (mounted) {
        await MedicationReminder.instance.reschedule(
          AppLocalizations.of(context)!,
          regimens,
          checks,
        );
      }
    } catch (_) {
      if (mounted) setState(() => _recordsFailed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return RefreshIndicator(
      onRefresh: () => _env.refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(
            l10n.s5HomeTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.s5HomeSubtitle,
            style: const TextStyle(fontSize: 16, color: AppTheme.neutral700),
          ),
          const SizedBox(height: 16),
          _QuickLogButtons(defaultMed: _defaultMed),
          const SizedBox(height: 16),
          _todayDoses(l10n),
          const SizedBox(height: 12),
          _visitCard(l10n),
          const SizedBox(height: 12),
          _recentCard(l10n),
          const SizedBox(height: 12),
          _timeline(l10n),
          if (_dailyCheckEnabled) ...[
            const SizedBox(height: 12),
            _medCheckLink(l10n),
          ],
          const SizedBox(height: 12),
          _HomeEnvCard(
            controller: _env,
            onOpenDetails: () => widget.onOpenTab(3),
          ),
        ],
      ),
    );
  }

  Widget _todayDoses(AppLocalizations l10n) {
    final today = dateOnly(DateTime.now());
    final open = _regimens.where((r) => r.effectiveUntil == null && r.covers(today));
    final slots = <({MedicationRegimen regimen, int index})>[];
    for (final regimen in open.where((r) => r.schedulesReminders)) {
      for (var i = 0; i < regimen.timesMinutes.length; i++) {
        slots.add((regimen: regimen, index: i));
      }
    }
    return _HomeCard(
      title: l10n.s6TodayDoses,
      children: [
        if (slots.isEmpty)
          Text(l10n.s6NoSchedule)
        else
          for (final slot in slots) _doseRow(l10n, slot.regimen, slot.index, today),
      ],
    );
  }

  Widget _doseRow(
    AppLocalizations l10n,
    MedicationRegimen regimen,
    int index,
    DateTime today,
  ) {
    final check = _checks
        .where(
          (c) =>
              c.regimenId == regimen.id &&
              c.localDate == today &&
              c.occasionIndex == index,
        )
        .firstOrNull;
    final minutes = regimen.timesMinutes[index];
    final hh = (minutes ~/ 60).toString().padLeft(2, '0');
    final mm = (minutes % 60).toString().padLeft(2, '0');
    final name = regimen.medicationName ?? '';
    final state = switch (check?.status) {
      'used' => l10n.s6DoseUsed,
      'not_used' => l10n.s6DoseNotUsed,
      'deferred' => l10n.s6DoseLater,
      _ => l10n.s6DoseUnconfirmed,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$name · $hh:$mm · $state'),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: [
              _doseButton(l10n.s6DoseUsed, () => _respond(regimen, index, today, 'used')),
              _doseButton(l10n.s6DoseLater, () => _respond(regimen, index, today, 'deferred')),
              _doseButton(
                l10n.s6DoseNotUsed,
                () => _respond(regimen, index, today, 'not_used'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _doseButton(String label, VoidCallback onPressed) => OutlinedButton(
    onPressed: onPressed,
    child: Text(label),
  );

  Future<void> _respond(
    MedicationRegimen regimen,
    int index,
    DateTime today,
    String status,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      await RegimenRepository().respond(
        regimenId: regimen.id,
        localDate: today,
        occasionIndex: index,
        status: status,
        requestId: newRequestId(),
        source: 'in_app',
      );
      RecordsRevision.instance.bump();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.s5SaveFailed)),
        );
      }
    }
  }

  Widget _visitCard(AppLocalizations l10n) {
    final s = _summary;
    String state;
    if (s == null) {
      state = '';
    } else if (!s.isEmpty) {
      state = l10n.s5HomeStateRecords(s.recordedDays);
    } else if (_questionCount > 0) {
      state = l10n.s5HomeStateQuestions(_questionCount);
    } else {
      state = l10n.s5HomeStateEmpty;
    }
    return _HomeCard(
      title: l10n.s5VisitCardTitle,
      children: [
        if (state.isNotEmpty)
          Text(state, style: const TextStyle(fontSize: 16)),
        if (s != null && (!s.isEmpty || _questionCount > 0)) ...[
          const SizedBox(height: 4),
          Text(
            l10n.s5VisitCardDetail(s.range.days, s.recordedDays, _questionCount),
            style: const TextStyle(color: AppTheme.neutral700),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          onPressed: () => widget.onOpenTab(2),
          child: Text(l10n.s5PrepareVisit),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EvidencePrepScreen()),
          ),
          child: Text(l10n.s6EvidenceTitle),
        ),
      ],
    );
  }

  Widget _timeline(AppLocalizations l10n) {
    final range = RecordRange.lastDays(7);
    return _HomeCard(
      title: l10n.s6TimelineTitle,
      children: [
        for (final day in range.dates.toList().reversed)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(_dayText(l10n, day)),
          ),
      ],
    );
  }

  String _dayText(AppLocalizations l10n, DateTime day) {
    final d = dateOnly(day);
    var scheduled = 0;
    for (final regimen in _regimens) {
      if (regimen.covers(d) && regimen.schedulesReminders) {
        scheduled += regimen.occasionsPerDay;
      }
    }
    final dayChecks = _checks.where((c) => c.localDate == d);
    final used = dayChecks.where((c) => c.status == 'used').length;
    final open = scheduled > dayChecks.length ? scheduled - dayChecks.length : 0;
    final symptoms =
        _bundle?.symptoms.where((s) => s.eventDate == d).length ?? 0;
    final linked = _snaps.any((s) {
      final t = s.eventTime?.toLocal();
      return s.linked && t != null && dateOnly(t) == d;
    });
    return l10n.s6DaySummary(
      '${d.month}/${d.day}',
      used,
      scheduled,
      open,
      symptoms,
      linked ? l10n.s6EnvLinked : l10n.s6EnvNoData,
    );
  }

  Widget _recentCard(AppLocalizations l10n) {
    final s = _summary;
    final lines = <String>[];
    if (s != null && !s.isEmpty) {
      lines.add(l10n.s5RecentInhaler(s.inhalerUses));
      lines.add(l10n.s5RecentSymptomDays(s.symptomDays));
      if (_dailyCheckEnabled || s.medAnsweredDays > 0) {
        lines.add(
          l10n.s5MedCheckCounts(
            s.medUsedDays,
            s.medNotUsedDays,
            s.medNotSureDays,
            s.medNotRecordedDays,
          ),
        );
      }
    }
    return _HomeCard(
      title: l10n.s5RecentTitle,
      children: [
        if (_recordsFailed)
          Text(l10n.s5RecordsLoadFailed)
        else if (s == null)
          const LinearProgressIndicator()
        else if (s.isEmpty)
          Text(l10n.s5NoRecordsYet)
        else
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line, style: const TextStyle(fontSize: 16)),
            ),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: _recordsFailed
                ? _loadRecords
                : () => widget.onOpenTab(1),
            child: Text(_recordsFailed ? l10n.authRetry : l10n.s5ViewMyLog),
          ),
        ),
      ],
    );
  }

  Widget _medCheckLink(AppLocalizations l10n) {
    final today = _todayCheck;
    return Material(
      color: AppTheme.neutral0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.neutral200),
      ),
      child: ListTile(
        minVerticalPadding: 12,
        leading: const Icon(Icons.fact_check_outlined, color: AppTheme.brand600),
        title: Text(l10n.s5MedCheckTitle),
        subtitle: Text(
          today == null
              ? l10n.s5NotRecordedToday
              : s5MedStatusLabel(l10n, today.status),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => RecordInputs.editMedCheck(context, existing: today),
      ),
    );
  }
}

class _QuickLogButtons extends StatelessWidget {
  const _QuickLogButtons({required this.defaultMed});
  final PatientMedication? defaultMed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scale = MediaQuery.textScalerOf(context).scale(1);
    final inhaler = FilledButton.icon(
      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(56)),
      onPressed: () => RecordInputs.logInhaler(context),
      icon: const Icon(Icons.medication_outlined),
      label: Text(l10n.s5LogInhaler, textAlign: TextAlign.center),
    );
    final symptoms = OutlinedButton.icon(
      style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
      onPressed: () => RecordInputs.editSymptoms(context),
      icon: const Icon(Icons.edit_note),
      label: Text(l10n.s5LogSymptoms, textAlign: TextAlign.center),
    );
    final medHint = defaultMed == null
        ? null
        : Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l10n.s5UsingMedication(defaultMed!.displayName),
              style: const TextStyle(color: AppTheme.neutral700),
            ),
          );

    return LayoutBuilder(
      builder: (context, c) {
        final stack = c.maxWidth < 340 || scale > 1.3;
        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              inhaler,
              ?medHint,
              const SizedBox(height: 12),
              symptoms,
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: inhaler),
                  const SizedBox(width: 12),
                  Expanded(child: symptoms),
                ],
              ),
            ),
            ?medHint,
          ],
        );
      },
    );
  }
}

class _HomeCard extends StatelessWidget {
  const _HomeCard({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.neutral0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.neutral200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _HomeEnvCard extends StatelessWidget {
  const _HomeEnvCard({required this.controller, required this.onOpenDetails});
  final EnvironmentController controller;
  final VoidCallback onOpenDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final snap = controller.snapshot;
    final children = <Widget>[];

    if (snap == null) {
      switch (controller.status) {
        case EnvLoadStatus.idle:
        case EnvLoadStatus.loading:
          children.add(const LinearProgressIndicator());
        case EnvLoadStatus.noLocation:
          children.addAll(_noLocation(context, l10n));
        case EnvLoadStatus.failed:
        case EnvLoadStatus.ready:
          children.addAll([
            Text(l10n.s5EnvLoadFailed),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: OutlinedButton(
                onPressed: () => controller.refresh(userInitiated: true),
                child: Text(l10n.s5Reload),
              ),
            ),
          ]);
      }
    } else {
      if (snap.locationLabel != null) {
        children.add(
          Text(
            l10n.homeNearPlace(snap.locationLabel!),
            style: const TextStyle(color: AppTheme.neutral700),
          ),
        );
        children.add(const SizedBox(height: 8));
      }
      children.addAll([
        _line(l10n.s5EnvAirQuality, EnvLabels.airQualityValue(l10n, snap)),
        _line(l10n.s5EnvPollen, EnvLabels.pollenValue(l10n, snap)),
        _line(l10n.s5EnvFlood, EnvLabels.floodValue(l10n, snap)),
      ]);
      final when = snap.fetchedAt;
      if (when != null) {
        children.add(
          Text(
            l10n.s5UpdatedAt(EnvLabels.localDateTime(context, when)),
            style: const TextStyle(color: AppTheme.neutral700, fontSize: 14),
          ),
        );
      }
      if (controller.showingOlder ||
          snap.fromStaleCache ||
          controller.status == EnvLoadStatus.failed) {
        children.add(const SizedBox(height: 4));
        children.add(
          Text(
            controller.status == EnvLoadStatus.failed
                ? l10n.s5EnvLoadFailed
                : l10n.s5EnvOlderNotice,
            style: const TextStyle(color: AppTheme.warning600, fontSize: 14),
          ),
        );
      }
      children.add(
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: onOpenDetails,
            child: Text(l10n.s5EnvSeeDetails),
          ),
        ),
      );
    }

    return _HomeCard(title: l10n.s5EnvCardTitle, children: children);
  }

  List<Widget> _noLocation(BuildContext context, AppLocalizations l10n) {
    final code = controller.errorCode;
    final blocked =
        code == 'permissionDeniedForever' || code == 'serviceDisabled';
    return [
      Text(l10n.s5EnvNeedPlace),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          OutlinedButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const LocationsScreen()),
              );
              await controller.refresh();
            },
            child: Text(l10n.s5ChoosePlace),
          ),
          TextButton(
            onPressed: blocked
                ? () => const LocationService().openAppSettings()
                : () => controller.refresh(userInitiated: true),
            child: Text(
              blocked ? l10n.locationOpenSettings : l10n.mockUseCurrentLocation,
            ),
          ),
        ],
      ),
    ];
  }

  Widget _line(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: value),
        ],
      ),
      style: const TextStyle(fontSize: 16),
    ),
  );
}
