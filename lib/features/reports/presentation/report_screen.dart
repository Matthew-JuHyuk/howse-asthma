import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../assessments/data/act_repository.dart';
import '../../assessments/data/pdc_repository.dart';
import '../../medication_log/data/inhaler_event_repository.dart';

/// SCR-PAT-REPORT — evidence summary from inhaler / ACT / PDC.
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _inhaler = InhalerEventRepository();
  final _act = ActRepository();
  final _pdc = PdcRepository();

  bool _loading = true;
  int _inhaler30 = 0;
  int? _actScore;
  String _pdcRate = '—';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final events = await _inhaler.listRecent(days: 30);
      final act = await _act.latest();
      final pdc = await _pdc.listRecent(days: 30);
      final taken = pdc.where((r) => r['taken'] == true).length;
      if (!mounted) return;
      setState(() {
        _inhaler30 = events.length;
        _actScore = (act?['total_score'] as num?)?.toInt();
        _pdcRate = pdc.isEmpty
            ? '—'
            : '${((taken / pdc.length) * 100).round()}%';
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                l10n.reportTitle,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const Text(
                'SCR-PAT-REPORT',
                style: TextStyle(color: AppTheme.neutral400, fontSize: 12),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.mockEvidenceSummary,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.reportEvidenceBody,
                style: const TextStyle(color: AppTheme.subtext),
              ),
              const SizedBox(height: 16),
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else ...[
                _StatCard(
                  label: l10n.mockInhalerEvents30d,
                  value: '$_inhaler30',
                ),
                _StatCard(
                  label: l10n.mockActScore,
                  value: _actScore?.toString() ?? '—',
                ),
                _StatCard(
                  label: l10n.mockPdcRate,
                  value: _pdcRate,
                ),
              ],
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.reportShareTodo)),
                  );
                },
                child: Text(l10n.reportGenerateButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(label),
        trailing: Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
