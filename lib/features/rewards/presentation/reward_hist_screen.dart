import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-PAT-REWARD-HIST — points / voucher / donate history. Stub UI.
class RewardHistScreen extends StatefulWidget {
  const RewardHistScreen({super.key});

  @override
  State<RewardHistScreen> createState() => _RewardHistScreenState();
}

class _RewardHistScreenState extends State<RewardHistScreen> {
  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filters = ['All', 'Earn', 'Voucher', 'Donate'];
    final rows = [
      ('+10 pts', 'Daily check-in', 'Today', null),
      ('Donate 50 pts', 'Provider TBD — donation queued', 'Today', 'Pending'),
      ('Voucher request', 'Placeholder pending partner', 'Yesterday', 'Waitlisted'),
      ('+5 pts', l10n.mockInhalerEvent, 'Yesterday', null),
      ('Donate 25 pts', 'No provider — points refunded', 'Jul 23', 'Failed'),
    ];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(l10n.mockRewardHistory, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text('SCR-PAT-REWARD-HIST', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
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
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (var i = 0; i < filters.length; i++)
                ChoiceChip(
                  label: Text(filters[i]),
                  selected: _filter == i,
                  onSelected: (_) => setState(() => _filter = i),
                  selectedColor: AppTheme.brand600,
                  labelStyle: TextStyle(color: _filter == i ? Colors.white : AppTheme.neutral600),
                ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Balance: 185 pts · Lifetime: 340 pts', style: TextStyle(fontSize: 12, color: AppTheme.subtext)),
          const SizedBox(height: 12),
          for (final row in rows)
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.neutral0,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.neutral200),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(row.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                        Text(row.$2, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
                        Text(row.$3, style: const TextStyle(fontSize: 11, color: AppTheme.neutral400)),
                      ],
                    ),
                  ),
                  if (row.$4 != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.warning50,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(row.$4!, style: const TextStyle(fontSize: 11, color: AppTheme.warning700)),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
