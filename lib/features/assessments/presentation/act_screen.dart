import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-PAT-ACT — Asthma Control Test (pictogram / 5 questions). Stub UI.
class ActScreen extends StatefulWidget {
  const ActScreen({super.key});

  @override
  State<ActScreen> createState() => _ActScreenState();
}

class _ActScreenState extends State<ActScreen> {
  int? _selected;

  static const _options = [
    ('All the time', '1 point'),
    ('Most of the time', '2 points'),
    ('Some of the time', '3 points'),
    ('A little of the time', '4 points'),
    ('Not at all', '5 points'),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: const Column(
          children: [
            Text('Asthma Check', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('SCR-PAT-ACT', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            '${l10n.mockQuestion} 1 of 5',
            style: const TextStyle(fontSize: 12, color: AppTheme.brand600),
          ),
          const SizedBox(height: 16),
          const Text(
            'How much did asthma limit your activities?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          const Text(
            'In the past 4 weeks',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppTheme.subtext),
          ),
          const SizedBox(height: 20),
          for (var i = 0; i < _options.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: _selected == i ? AppTheme.brand50 : AppTheme.neutral0,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() => _selected = i),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selected == i ? AppTheme.brand600 : AppTheme.neutral200,
                        width: _selected == i ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_options[i].$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                              Text(_options[i].$2, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
                            ],
                          ),
                        ),
                        Icon(
                          _selected == i ? Icons.check_circle : Icons.circle_outlined,
                          color: _selected == i ? AppTheme.brand600 : AppTheme.neutral300,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: _selected == null ? null : () => Navigator.pop(context),
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
