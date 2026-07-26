import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-PAT-REPORT — evidence summary. Placeholder stats.
class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.brand600,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.air, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                      const Text('SCR-PAT-REPORT', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('My Report', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            Text(
              l10n.mockEvidenceSummary,
              style: const TextStyle(color: AppTheme.subtext),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.neutral0,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.neutral200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Inhaler Use', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text(
                    '12',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.brand600,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    '${l10n.mockInhalerEvents30d} · Past 7 days shown',
                    style: const TextStyle(color: AppTheme.subtext, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final h in [20.0, 32.0, 12.0, 48.0, 28.0, 20.0, 24.0])
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                              height: h,
                              decoration: BoxDecoration(
                                color: h > 40 ? AppTheme.warning500 : AppTheme.brand300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    l10n.mockActScore,
                    '18 / 25',
                    'Not well controlled',
                    AppTheme.warning600,
                    AppTheme.warning50,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    l10n.mockPdcRate,
                    '82%',
                    'Above 80% target',
                    AppTheme.brand600,
                    AppTheme.brand50,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Environment Risk', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _envMini('TRAP', 'Low')),
                const SizedBox(width: 8),
                Expanded(child: _envMini('Pollen', 'Moderate')),
                const SizedBox(width: 8),
                Expanded(child: _envMini('Flood', 'None')),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.brand50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.brand200),
              ),
              child: Text(
                l10n.mockEvidenceBody,
                style: const TextStyle(fontSize: 13, color: AppTheme.brand800),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.ios_share),
              label: Text(l10n.reportGenerateButton),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, String badge, Color accent, Color badgeBg) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.neutral0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: accent)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(99)),
            child: Text(badge, style: TextStyle(fontSize: 11, color: accent)),
          ),
        ],
      ),
    );
  }

  Widget _envMini(String title, String level) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.neutral0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral200),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(level, style: const TextStyle(fontSize: 12, color: AppTheme.brand600, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
