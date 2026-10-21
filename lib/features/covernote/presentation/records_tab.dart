import 'package:flutter/material.dart';

import '../../../core/session/session_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../panic/presentation/panic_screen.dart';
import '../../records/presentation/my_log_screen.dart';
import '../../records/presentation/my_medications_screen.dart';
import '../auth/auth_screen.dart';
import '../covernote_root.dart';
import '../domain/record_snapshot.dart';
import '../ui/brand.dart';
import 'case_labels.dart';
import 'local_context_screen.dart';

/// The patient's own records that a case can link to, plus urgent help.
class RecordsTab extends StatefulWidget {
  const RecordsTab({super.key});

  @override
  State<RecordsTab> createState() => _RecordsTabState();
}

class _RecordsTabState extends State<RecordsTab> {
  RecordSnapshots? _snap;
  DayRange? _range;
  bool _failed = false;
  String? _loadedFor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = SessionScope.of(context);
    final uid = s.isReady ? s.user?.id : null;
    if (uid != _loadedFor) {
      _loadedFor = uid;
      _snap = null;
      if (uid != null) _load();
    }
  }

  Future<void> _load() async {
    final store = CoverNoteServices.of(context).live;
    final range = DayRange.lastDays(store.today, 30);
    setState(() {
      _failed = false;
      _range = range;
    });
    try {
      final s = await store.loadSnapshots(range);
      if (mounted) setState(() => _snap = s);
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  Future<void> _open(Widget screen, {String? title}) async {
    if (!await requireSignIn(context) || !mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => title == null
            ? screen
            : Scaffold(
                appBar: AppBar(title: Text(title)),
                body: screen,
              ),
      ),
    );
    if (mounted && _loadedFor != null) await _load();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final session = SessionScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.cnTabRecords)),
      body: RefreshIndicator(
        onRefresh: () async {
          if (_loadedFor != null) await _load();
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            if (session.isReady)
              _summary(l)
            else
              CnCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.cnRecordsSignInBody,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => requireSignIn(context),
                      child: Text(l.cnAuthSignIn),
                    ),
                  ],
                ),
              ),
            SectionLabel(l.cnRecordsYourRecords),
            _Tile(
              icon: Icons.medication_outlined,
              title: l.cnRecMedication,
              subtitle: l.cnRecMedicationSub,
              onTap: () => _open(const MyMedicationsScreen()),
            ),
            _Tile(
              icon: Icons.edit_note,
              title: l.cnRecDailyLog,
              subtitle: l.cnRecDailyLogSub,
              onTap: () => _open(const MyLogScreen(), title: l.cnRecDailyLog),
            ),
            _Tile(
              icon: Icons.place_outlined,
              title: l.cnRecLocalContext,
              subtitle: l.cnRecLocalContextSub,
              onTap: () => _open(const LocalContextScreen()),
            ),
            SectionLabel(l.cnHelp),
            _Tile(
              icon: Icons.emergency_outlined,
              title: l.cnUrgentHelp,
              subtitle: l.cnUrgentHelpSub,
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

  Widget _summary(AppLocalizations l) {
    final s = _snap;
    final r = _range;
    if (_failed) {
      return ActionMessage(
        icon: Icons.cloud_off,
        title: l.cnErrNetwork,
        actionLabel: l.cnRetry,
        onAction: _load,
      );
    }
    if (s == null || r == null) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    final m = s.medication;
    final y = s.symptoms;
    final c = s.localContext;
    return CnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.cnLast30Days(
              formatDay(context, r.from),
              formatDay(context, r.to),
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: CnColors.navy,
            ),
          ),
          const SizedBox(height: 8),
          _line(
            l.cnRecMedication,
            m.hasSchedule
                ? l.cnMedLine(m.taken, m.notTaken, m.unknown, m.scheduled)
                : l.cnNoSchedule,
          ),
          _line(
            l.cnRecPrn,
            m.prnUses == 0 ? l.cnNoEntries : l.cnPrnLine(m.prnUses, m.prnPuffs),
          ),
          _line(
            l.cnRecSymptoms,
            y.isEmpty
                ? l.cnNoEntries
                : l.cnSymptomLine(
                    y.daysWithSymptoms,
                    y.nightWakingDays,
                    y.daysWithEntries,
                    r.dayCount,
                  ),
          ),
          _line(
            l.cnRecLocalContext,
            c.pm25Days == 0
                ? l.cnNoEntries
                : l.cnPmLine(c.pm25Days, r.dayCount, c.pm25DaysAbove100),
          ),
          const SizedBox(height: 4),
          Text(
            l.cnRecordsUnknownNote,
            style: const TextStyle(color: CnColors.muted, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _line(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: CnColors.muted),
        ),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    ),
  );
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: CnCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: CnColors.teal),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: CnColors.muted, fontSize: 14),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: CnColors.muted),
        ],
      ),
    ),
  );
}
