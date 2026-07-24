import 'package:flutter/material.dart';

import '../../../core/locale/locale_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../../medication_log/presentation/medication_log_screen.dart';
import '../../reports/presentation/report_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import 'home_screen.dart';

/// Root screen shown after sign-in: a bottom-navigation shell that hosts
/// the four main sections of the app.
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
      SettingsScreen(localeController: localeController),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: const Icon(Icons.medication_outlined),
            label: l10n.medicationLogTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.description_outlined),
            label: l10n.reportTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            label: l10n.settingsTitle,
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
