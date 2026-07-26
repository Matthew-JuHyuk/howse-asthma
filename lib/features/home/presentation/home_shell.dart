import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/locale/locale_controller.dart';
import '../../../core/location/location_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../../medication_log/presentation/medication_log_screen.dart';
import '../../panic/presentation/panic_screen.dart';
import '../../reports/presentation/report_screen.dart';
import '../../rewards/presentation/reward_hub_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import 'home_screen.dart';

/// Root screen after sign-in: 5-tab shell + 1-Tap FAB (tap log / 1.5s panic).
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  int _logEpoch = 0;
  bool _logging = false;
  bool _panicOpen = false;
  final _location = const LocationService();
  final _inhalerRepo = InhalerEventRepository();
  Timer? _panicTimer;
  bool _panicTriggered = false;

  @override
  void dispose() {
    _panicTimer?.cancel();
    super.dispose();
  }

  Future<void> _logOneTap() async {
    if (_logging || _panicOpen) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() => _logging = true);
    try {
      final loc = await _location.getCurrentPosition();
      await _inhalerRepo.logUse(
        latitude: loc.position?.latitude,
        longitude: loc.position?.longitude,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.oneTapLoggedOk)),
      );
      setState(() {
        _index = 1;
        _logEpoch++;
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.oneTapLoggedFailed)),
      );
    } finally {
      if (mounted) setState(() => _logging = false);
    }
  }

  Future<void> _openPanic() async {
    if (_panicOpen || !mounted) return;
    setState(() => _panicOpen = true);
    try {
      await Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const PanicScreen()),
      );
    } finally {
      if (mounted) {
        setState(() {
          _panicOpen = false;
          _logEpoch++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeController = AppLocaleScope.of(context);

    final pages = [
      const HomeScreen(),
      MedicationLogScreen(key: ValueKey('log_$_logEpoch')),
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
        child: Listener(
          onPointerDown: (_) {
            _panicTriggered = false;
            _panicTimer?.cancel();
            _panicTimer = Timer(const Duration(milliseconds: 1500), () {
              _panicTriggered = true;
              _openPanic();
            });
          },
          onPointerUp: (_) {
            _panicTimer?.cancel();
            _panicTimer = null;
          },
          onPointerCancel: (_) {
            _panicTimer?.cancel();
            _panicTimer = null;
          },
          child: FloatingActionButton.large(
            heroTag: 'prod_one_tap',
            // Short tap / a11y activate. Long-press (≥1.5s) sets _panicTriggered first.
            onPressed: _logging || _panicOpen
                ? null
                : () {
                    if (_panicTriggered) return;
                    _logOneTap();
                  },
            backgroundColor: AppTheme.brand600,
            foregroundColor: Colors.white,
            child: _logging
                ? const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.medication_outlined, size: 28),
                      Text(
                        l10n.oneTapFab,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
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
  bool updateShouldNotify(AppLocaleScope oldWidget) =>
      controller != oldWidget.controller;
}
