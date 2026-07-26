import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-PAT-FORECAST — daily environmental risk outlook. Placeholder data.
class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  int _day = 0;
  int _period = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final days = [
      ('Fri', '25'),
      ('Sat', '26'),
      ('Sun', '27'),
      ('Mon', '28'),
      ('Tue', '29'),
    ];
    final periods = ['Morning', 'Afternoon', 'Evening'];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(l10n.mockForecast, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text('SCR-PAT-FORECAST', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Daily Forecast', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Text('Environmental risk outlook', style: TextStyle(color: AppTheme.subtext)),
          const SizedBox(height: 16),
          const Text('Select Day', style: TextStyle(fontSize: 12, color: AppTheme.neutral500)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var i = 0; i < days.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  ChoiceChip(
                    label: Text('${days[i].$1}\n${days[i].$2}'),
                    selected: _day == i,
                    onSelected: (_) => setState(() => _day = i),
                    selectedColor: AppTheme.brand600,
                    labelStyle: TextStyle(
                      color: _day == i ? Colors.white : AppTheme.neutral700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Time of Day', style: TextStyle(fontSize: 12, color: AppTheme.neutral500)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              for (var i = 0; i < periods.length; i++)
                ChoiceChip(
                  label: Text(periods[i]),
                  selected: _period == i,
                  onSelected: (_) => setState(() => _period = i),
                  selectedColor: AppTheme.brand600,
                  labelStyle: TextStyle(color: _period == i ? Colors.white : AppTheme.neutral600),
                ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Risk Forecast', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          _card('TRAP', 'Low', 'Proxy estimate — not truck counts', AppTheme.brand600),
          const SizedBox(height: 8),
          _card('Flood', 'None', 'No flood advisory in your area', AppTheme.brand600),
          const SizedBox(height: 8),
          _card('Pollen', 'Moderate', 'Tree pollen elevated this morning', AppTheme.warning600),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.description_outlined),
            label: const Text('View Full Report'),
          ),
        ],
      ),
    );
  }

  Widget _card(String title, String level, String detail, Color color) {
    return Container(
      width: double.infinity,
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
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
              Text(level, style: TextStyle(fontWeight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 4),
          Text(detail, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
        ],
      ),
    );
  }
}
