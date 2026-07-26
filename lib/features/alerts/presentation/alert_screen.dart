import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../environment/presentation/env_screen.dart';

/// SCR-SYS-ALERT — risk alert landing. Stub UI.
class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7ED),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF7ED),
        title: const Column(
          children: [
            Text('Environmental Alert', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('SCR-SYS-ALERT', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.error500,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'RISK ALERT',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.mockAlertBody,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const Text('What to Do', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(label: Text('Stay Indoors')),
              Chip(label: Text('Close Windows')),
              Chip(label: Text('Rescue Inhaler')),
              Chip(label: Text('Stay Calm')),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const EnvScreen()),
              );
            },
            icon: const Icon(Icons.layers_outlined),
            label: Text(l10n.mockEnvDetail),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.mockDismiss),
          ),
        ],
      ),
    );
  }
}
