import 'package:flutter/material.dart';

import '../../../core/onboarding/first_check_in_prefs.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// S2-SCR-02 — one-tap breathing check-in (prefs only; no AeroPoint ledger).
class FirstCheckInScreen extends StatefulWidget {
  const FirstCheckInScreen({
    super.key,
    required this.userId,
    required this.onFinished,
  });

  final String userId;
  final VoidCallback onFinished;

  @override
  State<FirstCheckInScreen> createState() => _FirstCheckInScreenState();
}

class _FirstCheckInScreenState extends State<FirstCheckInScreen> {
  bool _busy = false;

  Future<void> _select(String breathId) async {
    if (_busy) return;
    setState(() => _busy = true);
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await FirstCheckInPrefs.setBreathing(widget.userId, breathId);
    } catch (_) {
      // Still proceed to Home (W2-5.3).
    }
    if (!mounted) return;
    widget.onFinished();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          '${l10n.checkInWelcomeHome} ${l10n.checkInAeroPoints}',
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.neutral0,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.checkInQuestion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.neutral900,
                ),
              ),
              const SizedBox(height: 28),
              _BreathCard(
                label: l10n.checkInBreathUsual,
                enabled: !_busy,
                onTap: () => _select(FirstCheckInPrefs.breathUsual),
              ),
              const SizedBox(height: 12),
              _BreathCard(
                label: l10n.checkInBreathTight,
                enabled: !_busy,
                onTap: () => _select(FirstCheckInPrefs.breathSlightlyTight),
              ),
              const SizedBox(height: 12),
              _BreathCard(
                label: l10n.checkInBreathSymptoms,
                enabled: !_busy,
                onTap: () => _select(FirstCheckInPrefs.breathSymptoms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BreathCard extends StatelessWidget {
  const _BreathCard({
    required this.label,
    required this.onTap,
    required this.enabled,
  });

  final String label;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.brand50,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppTheme.neutral900,
            ),
          ),
        ),
      ),
    );
  }
}
