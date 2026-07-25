import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../mock_nav.dart';
import '../screen_ids.dart';
import '../widgets/mock_widgets.dart';

class SysAlertMock extends StatelessWidget {
  const SysAlertMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.sysAlert.id,
      title: l10n.notificationAttackWarningTitle,
      backgroundColor: const Color(0xFFFFF7ED),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MockRiskBanner(
              warning: true,
              stateLabel: l10n.mockStateWarning,
              message: l10n.mockAlertBody,
            ),
            const SizedBox(height: 20),
            MockPrimaryCta(
              label: l10n.mockEnvDetail,
              icon: Icons.layers_outlined,
              onPressed: () => MockNav.push(context, MockScreenId.patEnv),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.mockDismiss),
            ),
          ],
        ),
      ),
    );
  }
}

class SysPanicMock extends StatelessWidget {
  const SysPanicMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.error600,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  MockScreenId.sysPanic.id,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              const Spacer(),
              const Icon(Icons.emergency, size: 96, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                l10n.mockPanicTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.mockPanicStep1Body,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Spacer(),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.error600,
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () => MockNav.push(context, MockScreenId.sysPanicStep2),
                child: Text(l10n.mockContinue),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(l10n.mockDismiss, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SysPanicStep2Mock extends StatelessWidget {
  const SysPanicStep2Mock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.neutral900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(MockScreenId.sysPanicStep2.id, style: const TextStyle(color: AppTheme.neutral400, fontSize: 12)),
              const Spacer(),
              Text(
                l10n.mockPanicStep2Title,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(l10n.mockPanicStep2Body, style: const TextStyle(color: AppTheme.neutral300)),
              const SizedBox(height: 28),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.error500,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () {},
                icon: const Icon(Icons.call),
                label: Text(l10n.mockCall911),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: AppTheme.neutral500),
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () {},
                icon: const Icon(Icons.contact_phone_outlined),
                label: Text(l10n.mockCallGuardian),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: Text(l10n.mockFeelingBetter, style: const TextStyle(color: AppTheme.brand300)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
