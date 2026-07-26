import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/pdc_repository.dart';

/// SCR-PAT-PDC — daily controller adherence → `pdc_daily_checks`.
class PdcScreen extends StatefulWidget {
  const PdcScreen({super.key});

  @override
  State<PdcScreen> createState() => _PdcScreenState();
}

class _PdcScreenState extends State<PdcScreen> {
  final _repo = PdcRepository();
  bool _loading = true;
  bool _saving = false;
  bool? _todayTaken;
  int _takenDays = 0;
  int _totalDays = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final today = await _repo.todayTaken();
      final recent = await _repo.listRecent(days: 30);
      if (!mounted) return;
      setState(() {
        _todayTaken = today;
        _takenDays = recent.where((r) => r['taken'] == true).length;
        _totalDays = recent.length;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _answer(bool taken) async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _saving = true);
    try {
      await _repo.upsertToday(taken: taken);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pdcSaved)),
      );
      await _load();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authErrorGeneric)),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rate = _totalDays == 0
        ? '—'
        : '${((_takenDays / _totalDays) * 100).round()}%';

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(l10n.pdcTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text(
              'SCR-PAT-PDC',
              style: TextStyle(fontSize: 11, color: AppTheme.neutral400),
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  l10n.mockPdcPrompt,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.pdcStreakHint(_takenDays, _totalDays, rate),
                  style: const TextStyle(color: AppTheme.subtext),
                ),
                if (_todayTaken != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _todayTaken!
                        ? l10n.pdcAlreadyYes
                        : l10n.pdcAlreadyNo,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _saving ? null : () => _answer(true),
                  child: Text(l10n.mockTakenYes),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: _saving ? null : () => _answer(false),
                  child: Text(l10n.mockTakenNo),
                ),
              ],
            ),
    );
  }
}
