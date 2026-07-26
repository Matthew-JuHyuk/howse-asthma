import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-PAT-VOUCHER — food-bank voucher waitlist exchange. Stub UI.
class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Redeem Voucher', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('SCR-PAT-VOUCHER', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.warning50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.warning200),
            ),
            child: Text(l10n.mockDraftBanner, style: const TextStyle(fontSize: 12, color: AppTheme.warning800)),
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
                const Text('Your Balance', style: TextStyle(color: AppTheme.subtext)),
                const Text('120 points available', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                const Text('Exchange Item', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                Text(l10n.mockDummyFoodBank, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(l10n.mockVoucherCost, style: const TextStyle(color: AppTheme.subtext)),
                const SizedBox(height: 12),
                const Text(
                  'Points are held until a partner is confirmed',
                  style: TextStyle(fontSize: 13, color: AppTheme.subtext),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.hourglass_empty),
                  label: Text(l10n.mockJoinWaitlist),
                ),
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
