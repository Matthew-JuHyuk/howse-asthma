import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'mock_nav.dart';
import 'screens/patient_mock_screens.dart';

/// Patient design-preview shell: 5-tab navigation (Home / Log / Report / Rewards / Settings)
/// with a floating 1-Tap inhaler CTA (Subframe SCR-PAT-HOME).
class PatientMockShell extends StatefulWidget {
  const PatientMockShell({super.key});

  @override
  State<PatientMockShell> createState() => _PatientMockShellState();
}

class _PatientMockShellState extends State<PatientMockShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = const [
      PatHomeMock(warning: false),
      PatLogMock(),
      PatReportMock(),
      PatRewardMock(),
      PatSettingsMock(),
    ];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: SafeArea(
        child: IndexedStack(index: _index, children: pages),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.large(
              heroTag: 'mock_one_tap',
              onPressed: () {
                setState(() => _index = 1);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.medicationLogAddButton)),
                );
              },
              backgroundColor: AppTheme.brand600,
              foregroundColor: Colors.white,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.medication_outlined, size: 28),
                  Text('1-Tap', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            TextButton.icon(
              onPressed: () => MockNav.openCatalog(context),
              icon: const Icon(Icons.grid_view_rounded, size: 16),
              label: Text(l10n.mockAllScreens, style: const TextStyle(fontSize: 11)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: [
          NavigationDestination(icon: const Icon(Icons.home_outlined), label: l10n.mockTabHome),
          NavigationDestination(icon: const Icon(Icons.medication_outlined), label: l10n.mockTabLog),
          NavigationDestination(icon: const Icon(Icons.description_outlined), label: l10n.mockTabReport),
          NavigationDestination(icon: const Icon(Icons.stars_outlined), label: l10n.mockTabReward),
          NavigationDestination(icon: const Icon(Icons.settings_outlined), label: l10n.mockTabSettings),
        ],
      ),
    );
  }
}
