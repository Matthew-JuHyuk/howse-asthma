import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-PAT-PDC — daily PDC adherence check-in. Stub UI.
class PdcScreen extends StatelessWidget {
  const PdcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Daily Check-in', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('SCR-PAT-PDC', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Daily Check-in', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Text('Track your medication adherence', style: TextStyle(color: AppTheme.subtext)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.brand50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.brand200),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppTheme.brand100,
                  child: Icon(Icons.local_fire_department, color: AppTheme.brand600),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('5-Day Streak', style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                      Text(l10n.mockPdcRate, style: const TextStyle(fontSize: 12, color: AppTheme.brand600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.mockPdcPrompt,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.check_circle_outline),
            label: Text(l10n.mockTakenYes),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.mockTakenNo),
          ),
          const SizedBox(height: 24),
          const Text('Monthly Progress', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.neutral0,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.neutral200),
            ),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(child: Text('Days Covered')),
                    Text('22 / 25', style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: const LinearProgressIndicator(
                    value: 0.88,
                    minHeight: 10,
                    backgroundColor: AppTheme.neutral200,
                    color: AppTheme.brand500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
