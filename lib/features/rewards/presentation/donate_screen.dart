import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-PAT-DONATE — third-party donate (provider TBD). Stub UI; CTA disabled.
class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(l10n.mockDonateTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text('SCR-PAT-DONATE', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Support asthma research', style: TextStyle(color: AppTheme.subtext)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.neutral0,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.neutral200),
            ),
            child: Text(l10n.mockDonateTransparency),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.brand50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.brand200),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1,250 Points', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                Text('\$12.50 value · Available for donation', style: TextStyle(color: AppTheme.subtext)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Select Amount', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (final amount in ['\$5', '\$10', '\$25', '\$50'])
                ChoiceChip(
                  label: Text(amount),
                  selected: amount == '\$10',
                  onSelected: (_) {},
                ),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: null,
            icon: const Icon(Icons.open_in_new),
            label: Text(l10n.mockDonateCta),
          ),
          const SizedBox(height: 8),
          const Text(
            'Donation provider not yet finalized',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppTheme.neutral400),
          ),
        ],
      ),
    );
  }
}
