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
      title: 'Environmental Alert',
      backgroundColor: const Color(0xFFFFF7ED),
      child: ListView(
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
            'Active risk conditions in your area',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          MockFactorRow(
            icon: Icons.grass_outlined,
            title: l10n.mockPollenAxis,
            level: 'High',
            detail: 'Tree pollen is elevated in your area',
            filled: 4,
            levelColor: AppTheme.error500,
            barColor: AppTheme.error500,
            iconBg: const Color(0xFFFEE2E2),
            iconColor: AppTheme.error600,
            borderColor: const Color(0xFFFECACA),
          ),
          const SizedBox(height: 16),
          const Text('What to Do', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(avatar: Icon(Icons.home_outlined, size: 16), label: Text('Stay Indoors')),
              Chip(avatar: Icon(Icons.window, size: 16), label: Text('Close Windows')),
              Chip(avatar: Icon(Icons.medication_outlined, size: 16), label: Text('Rescue Inhaler')),
              Chip(avatar: Icon(Icons.self_improvement, size: 16), label: Text('Stay Calm')),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Other Conditions', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          MockFactorRow(
            icon: Icons.apartment_outlined,
            title: l10n.mockTrapAxis,
            level: 'Low',
            detail: 'Air-quality proxy — not truck counts',
            filled: 1,
          ),
          const SizedBox(height: 10),
          MockFactorRow(
            icon: Icons.flood_outlined,
            title: l10n.mockFloodAxis,
            level: 'None',
            detail: 'No flood advisory in your area',
            filled: 1,
          ),
          const SizedBox(height: 20),
          MockPrimaryCta(
            label: 'View Details',
            icon: Icons.layers_outlined,
            onPressed: () => MockNav.push(context, MockScreenId.patEnv),
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
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text(
                  'EMERGENCY',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1),
                ),
              ),
              const Spacer(),
              const Icon(Icons.air, size: 72, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                'Breathe & Use Inhaler',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.mockPanicStep1Body,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
              const SizedBox(height: 8),
              const Text(
                '4 seconds in — 4 seconds out',
                style: TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.error600,
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () {},
                child: const Text('Take Inhaler Now'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(56),
                ),
                onPressed: () => MockNav.push(context, MockScreenId.sysPanicStep2),
                child: Text(l10n.mockPanicStep2Title),
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
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                alignment: Alignment.center,
                child: const Text(
                  'EMERGENCY',
                  style: TextStyle(color: AppTheme.error500, fontWeight: FontWeight.w700, letterSpacing: 1),
                ),
              ),
              const Spacer(),
              Text(
                l10n.mockPanicStep2Title,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(l10n.mockPanicStep2Body, style: const TextStyle(color: AppTheme.neutral300)),
              const SizedBox(height: 12),
              const Text(
                'This app does not auto-dial',
                style: TextStyle(color: AppTheme.warning500, fontWeight: FontWeight.w600),
              ),
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
              const SizedBox(height: 8),
              const Text(
                'Phone call only · Emergency services',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.neutral400, fontSize: 12),
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
