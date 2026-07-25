import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../l10n/app_localizations.dart';
import 'mock_nav.dart';
import 'screens/patient_mock_screens.dart';

/// Patient design-preview shell: 5-tab navigation (Home / Log / Report / Reward / Settings).
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
      floatingActionButton: _index == 0
          ? null
          : FloatingActionButton.small(
              onPressed: () => MockNav.openCatalog(context),
              backgroundColor: AppTheme.brand600,
              foregroundColor: Colors.white,
              tooltip: l10n.mockAllScreens,
              child: const Icon(Icons.grid_view_rounded),
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
