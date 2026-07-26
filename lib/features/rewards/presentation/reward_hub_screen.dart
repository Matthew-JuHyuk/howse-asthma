import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'donate_screen.dart';
import 'reward_hist_screen.dart';
import 'voucher_screen.dart';

/// SCR-PAT-REWARD — points hub (RWD draft). Stub UI.
class RewardHubScreen extends StatelessWidget {
  const RewardHubScreen({super.key});

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
                      const Text('SCR-PAT-REWARD', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.warning50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.warning200),
              ),
              child: Text(
                l10n.mockDraftBanner,
                style: const TextStyle(fontSize: 12, color: AppTheme.warning800, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),
            Text(l10n.mockRewardTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const Text('Earn points, redeem rewards', style: TextStyle(color: AppTheme.subtext)),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.brand50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.brand200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.mockPointsBalance, style: const TextStyle(color: AppTheme.subtext)),
                  const Text('320', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                  const Text('180 earned · 140 bonus', style: TextStyle(fontSize: 12, color: AppTheme.brand600)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('How You Earn', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            _tile(context, Icons.medication_outlined, 'Daily Inhaler Log', '+5 pts', null),
            _tile(context, Icons.quiz_outlined, l10n.mockActSurvey, '+10 pts', null),
            _tile(context, Icons.local_fire_department, '7-Day Streak', '+25 pts', null),
            const SizedBox(height: 8),
            _tile(
              context,
              Icons.card_giftcard_outlined,
              l10n.mockVoucherTitle,
              l10n.mockVoucherHint,
              () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VoucherScreen())),
            ),
            _tile(
              context,
              Icons.volunteer_activism_outlined,
              l10n.mockDonateTitle,
              l10n.mockDonateHint,
              () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DonateScreen())),
            ),
            _tile(
              context,
              Icons.history,
              l10n.mockRewardHistory,
              l10n.mockRewardHistoryHint,
              () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RewardHistScreen())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback? onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.brand100,
          child: Icon(icon, color: AppTheme.brand700, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
