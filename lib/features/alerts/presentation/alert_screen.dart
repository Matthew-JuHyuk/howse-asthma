import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../environment/data/environment_snapshot.dart';
import '../../environment/presentation/env_screen.dart';
import '../../environment/presentation/widgets/state_only_source_badge.dart';

/// SCR-SYS-ALERT — in-app landing when risk ≥ 3 (FCM deep-link later).
class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key, this.snapshot});

  final EnvironmentSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final snap = snapshot;
    final score = snap?.riskScore ?? 3;
    final state = snap?.uiState ?? 'WARNING';

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(l10n.alertTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text(
              'SCR-SYS-ALERT',
              style: TextStyle(fontSize: 11, color: AppTheme.neutral400),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.warning600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('${l10n.mockRiskScore} $score'),
                    const SizedBox(height: 8),
                    Text(l10n.mockAlertBody),
                    if (snap != null) ...[
                      const SizedBox(height: 8),
                      StateOnlySourceBadge.njdot(snap, compact: true),
                    ],
                  ],
                ),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const EnvScreen()),
                );
              },
              child: Text(l10n.homeViewDetails),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.mockDismiss),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.alertFcmPendingNote,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: AppTheme.neutral400),
            ),
          ],
        ),
      ),
    );
  }
}
