import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../environment/presentation/env_screen.dart';
import '../../panic/presentation/panic_screen.dart';

/// SCR-PAT-HOME calm layout: brand header, risk card, Environmental Factors
/// (3 rows), last inhaler. 1-Tap FAB lives on [HomeShell].
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
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
                      Text(
                        l10n.appTitle,
                        style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700),
                      ),
                      const Text(
                        'SCR-PAT-HOME',
                        style: TextStyle(fontSize: 11, color: AppTheme.neutral400),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: AppTheme.neutral100,
                  child: IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: AppTheme.neutral500),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              l10n.homeGreeting,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            const Text(
              'Here is your daily summary',
              style: TextStyle(color: AppTheme.subtext),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EnvScreen()),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppTheme.brand50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.brand200),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppTheme.brand100,
                      child: Icon(Icons.show_chart, color: AppTheme.brand600),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                l10n.mockStateCalm,
                                style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.brand600,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                                child: const Text(
                                  'Score 1',
                                  style: TextStyle(color: Colors.white, fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            l10n.asthmaRiskLow,
                            style: const TextStyle(fontSize: 12, color: AppTheme.brand700),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppTheme.brand400),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Environmental Factors',
              style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.neutral700),
            ),
            const SizedBox(height: 12),
            _factor(
              context,
              icon: Icons.apartment_outlined,
              title: 'TRAP',
              level: 'Low',
              detail: 'Air-quality proxy — not truck counts',
              filled: 1,
              color: AppTheme.brand600,
            ),
            const SizedBox(height: 10),
            _factor(
              context,
              icon: Icons.flood_outlined,
              title: 'Flood',
              level: 'None',
              detail: 'No flood advisory in your area',
              filled: 1,
              color: AppTheme.brand600,
            ),
            const SizedBox(height: 10),
            _factor(
              context,
              icon: Icons.grass_outlined,
              title: 'Pollen',
              level: 'Moderate',
              detail: 'Tree pollen is elevated today',
              filled: 3,
              color: AppTheme.warning600,
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.schedule, size: 16, color: AppTheme.neutral400),
                SizedBox(width: 6),
                Text(
                  'Last inhaler use: 2 days ago',
                  style: TextStyle(fontSize: 12, color: AppTheme.neutral400),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PanicScreen()),
                );
              },
              icon: const Icon(Icons.emergency_outlined, color: AppTheme.error500),
              label: Text(l10n.mockPanicCta, style: const TextStyle(color: AppTheme.error600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _factor(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String level,
    required String detail,
    required int filled,
    required Color color,
  }) {
    return Material(
      color: AppTheme.neutral0,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const EnvScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.neutral200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Text(level, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(detail, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(5, (i) {
                        return Expanded(
                          child: Container(
                            height: 6,
                            margin: EdgeInsets.only(right: i == 4 ? 0 : 4),
                            decoration: BoxDecoration(
                              color: i < filled ? color : AppTheme.neutral200,
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
