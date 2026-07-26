import 'package:flutter/material.dart';

import '../../../core/locale/locale_controller.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../medication_log/presentation/medication_log_screen.dart';
import '../../reports/presentation/report_screen.dart';
import '../../rewards/presentation/reward_hub_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import 'home_screen.dart';

/// Root screen after sign-in: 5-tab shell matching Subframe
/// (Home / Log / Report / Rewards / Settings) + floating 1-Tap stub.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeController = AppLocaleScope.of(context);

    final pages = [
      const HomeScreen(),
      const MedicationLogScreen(),
      const ReportScreen(),
      const RewardHubScreen(),
      SettingsScreen(localeController: localeController),
    ];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: IndexedStack(index: _index, children: pages),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: FloatingActionButton.large(
          heroTag: 'prod_one_tap',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.oneTapLoggedSnack)),
            );
          },
          backgroundColor: AppTheme.brand600,
          foregroundColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.medication_outlined, size: 28),
              Text(l10n.oneTapFab,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.medication_outlined),
            label: l10n.navLog,
          ),
          NavigationDestination(
            icon: const Icon(Icons.description_outlined),
            label: l10n.navReport,
          ),
          NavigationDestination(
            icon: const Icon(Icons.stars_outlined),
            label: l10n.navRewards,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            label: l10n.mockTabSettings,
          ),
        ],
      ),
    );
  }
}

/// Exposes the app-wide [LocaleController] to descendant widgets without
/// pulling in an external state-management dependency.
class AppLocaleScope extends InheritedWidget {
  const AppLocaleScope({
    super.key,
    required this.controller,
    required super.child,
  });

  final LocaleController controller;

  static LocaleController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppLocaleScope>();
    assert(scope != null, 'AppLocaleScope not found in widget tree');
    return scope!.controller;
  }

  @override
  bool updateShouldNotify(AppLocaleScope oldWidget) => controller != oldWidget.controller;
}
