import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../assessments/presentation/act_screen.dart';
import '../../assessments/presentation/pdc_screen.dart';
import '../data/inhaler_event_repository.dart';

/// SCR-PAT-LOG — inhaler timeline from `inhaler_events`.
class MedicationLogScreen extends StatefulWidget {
  const MedicationLogScreen({super.key});

  @override
  State<MedicationLogScreen> createState() => _MedicationLogScreenState();
}

class _MedicationLogScreenState extends State<MedicationLogScreen> {
  final _repo = InhalerEventRepository();
  List<Map<String, dynamic>> _events = const [];
  bool _loading = true;
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final rows = await _repo.listRecent();
      if (!mounted) return;
      setState(() {
        _events = rows;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  List<Map<String, dynamic>> get _filtered {
    switch (_filter) {
      case 'panic':
        return _events.where((e) => e['is_panic'] == true).toList();
      case 'rescue':
        return _events.where((e) => e['is_panic'] != true).toList();
      default:
        return _events;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final weekStart = DateTime(now.year, now.month, now.day)
        .subtract(const Duration(days: 6));
    final weekCount = _events.where((e) {
      final raw = e['recorded_at'] as String?;
      final at = raw == null ? null : DateTime.tryParse(raw)?.toLocal();
      if (at == null) return false;
      return !at.isBefore(weekStart);
    }).length;

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            children: [
              Text(
                l10n.medicationLogTitle,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const Text(
                'SCR-PAT-LOG',
                style: TextStyle(color: AppTheme.neutral400, fontSize: 12),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.logWeekSummary(weekCount),
                style: const TextStyle(color: AppTheme.subtext),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  FilterChip(
                    label: Text(l10n.logFilterAll),
                    selected: _filter == 'all',
                    onSelected: (_) => setState(() => _filter = 'all'),
                  ),
                  FilterChip(
                    label: Text(l10n.logFilterRescue),
                    selected: _filter == 'rescue',
                    onSelected: (_) => setState(() => _filter = 'rescue'),
                  ),
                  FilterChip(
                    label: Text(l10n.logFilterPanic),
                    selected: _filter == 'panic',
                    onSelected: (_) => setState(() => _filter = 'panic'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Material(
                color: AppTheme.neutral0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppTheme.neutral200),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.assignment_outlined,
                          color: AppTheme.brand600),
                      title: Text(l10n.mockActSurvey),
                      subtitle: Text(l10n.mockActHint),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ActScreen()),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.check_circle_outline,
                          color: AppTheme.brand600),
                      title: Text(l10n.mockPdcCheck),
                      subtitle: Text(l10n.mockPdcHint),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PdcScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else if (_filtered.isEmpty)
                Text(l10n.logEmpty)
              else
                ..._filtered.map((e) {
                  final raw = e['recorded_at'] as String?;
                  final at = raw == null
                      ? null
                      : DateTime.tryParse(raw)?.toLocal();
                  final label = at == null
                      ? '—'
                      : DateFormat.yMMMd().add_jm().format(at);
                  final panic = e['is_panic'] == true;
                  final risk = e['risk_level'];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(
                        panic
                            ? Icons.emergency_outlined
                            : Icons.medication_outlined,
                        color: panic ? AppTheme.error600 : AppTheme.brand600,
                      ),
                      title: Text(
                        panic ? l10n.logEventPanic : l10n.logEventRescue,
                      ),
                      subtitle: Text(
                        risk == null
                            ? label
                            : '$label · ${l10n.mockRiskScore} $risk',
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
