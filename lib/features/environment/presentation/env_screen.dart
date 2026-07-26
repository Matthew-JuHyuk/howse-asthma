import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import 'forecast_screen.dart';

/// SCR-PAT-ENV — environment detail (TRAP / Flood / Pollen). Placeholder data.
class EnvScreen extends StatelessWidget {
  const EnvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Environment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text(
              'SCR-PAT-ENV',
              style: const TextStyle(fontSize: 11, color: AppTheme.neutral400),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _banner(
            title: 'Overall: Low Risk',
            subtitle: 'Conditions are mostly favorable today',
          ),
          const SizedBox(height: 20),
          const Text('3-Axis Risk Detail', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          _axis(
            icon: Icons.apartment_outlined,
            title: 'TRAP Air Quality',
            level: 'Low',
            detail: 'Traffic-related air pollution proxy',
            tip: 'Nearby air quality is good. Modeled proxy — not vehicle counts.',
            filled: 1,
          ),
          const SizedBox(height: 10),
          _axis(
            icon: Icons.flood_outlined,
            title: 'Flash Flood',
            level: 'None',
            detail: 'Flood risk conditions near you',
            tip: 'No flash-flood advisories in your area.',
            filled: 1,
          ),
          const SizedBox(height: 10),
          _axis(
            icon: Icons.grass_outlined,
            title: 'Pollen',
            level: 'Moderate',
            detail: 'Tree and grass pollen levels',
            tip: 'Tree pollen elevated — limit outdoor time 10 AM–4 PM.',
            filled: 3,
            accent: AppTheme.warning600,
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ForecastScreen()),
              );
            },
            icon: const Icon(Icons.trending_up),
            label: Text(l10n.mockForecast),
          ),
        ],
      ),
    );
  }

  Widget _banner({required String title, required String subtitle}) {
    return Container(
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
            child: Icon(Icons.check_circle_outline, color: AppTheme.brand600),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppTheme.brand600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _axis({
    required IconData icon,
    required String title,
    required String level,
    required String detail,
    required String tip,
    required int filled,
    Color accent = AppTheme.brand600,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.neutral0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                    Text(detail, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
                  ],
                ),
              ),
              Text(level, style: TextStyle(fontWeight: FontWeight.w700, color: accent)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (i) {
              return Expanded(
                child: Container(
                  height: 6,
                  margin: EdgeInsets.only(right: i == 4 ? 0 : 4),
                  decoration: BoxDecoration(
                    color: i < filled ? accent : AppTheme.neutral200,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(tip, style: TextStyle(fontSize: 12, color: accent)),
        ],
      ),
    );
  }
}
