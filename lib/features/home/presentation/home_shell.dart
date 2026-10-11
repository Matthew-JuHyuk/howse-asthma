import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/debug/debug_gates.dart';
import '../../../core/locale/locale_controller.dart';
import '../../../core/location/environment_monitor.dart';
import '../../../core/push/fcm_service.dart';
import '../../../core/push/notification_consent_prefs.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../debug/presentation/api_console_screen.dart';
import '../../environment/presentation/env_screen.dart';
import '../../panic/presentation/panic_screen.dart';
import '../../records/presentation/my_log_screen.dart';
import '../../settings/presentation/settings_screen.dart';
import '../../visit_prep/presentation/visit_prep_screen.dart';
import 'home_screen.dart';

/// Root screen after sign-in: Home · My log · Visit prep · Environment.
/// Settings and Urgent help live in the shared top bar.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  static const tabHome = 0;
  static const tabLog = 1;
  static const tabVisit = 2;

  int _index = tabHome;
  final _built = <int>{tabHome};
  EnvironmentMonitor? _envMonitor;
  final _fcm = FcmService.instance;
  int _debugTaps = 0;
  DateTime? _debugTapAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final userId = SupabaseService.currentUser?.id ?? '';
      final fgRefresh = await NotificationConsentPrefs.isBgRefreshEnabled(
        userId,
      );
      if (!mounted) return;
      if (fgRefresh) {
        _envMonitor = EnvironmentMonitor.maybeOf(context);
        _envMonitor?.start();
      }
      if (await NotificationConsentPrefs.isMasterEnabled(userId)) {
        unawaited(_fcm.registerCurrentDevice());
      }
    });
  }

  @override
  void dispose() {
    _envMonitor?.stop();
    unawaited(_fcm.dispose());
    super.dispose();
  }

  void _select(int i) => setState(() {
    _index = i;
    _built.add(i);
  });

  void _openUrgentHelp() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const PanicScreen()));
  }

  void _openSettings() {
    final localeController = AppLocaleScope.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsScreen(localeController: localeController),
      ),
    );
  }

  void _onTitleTap() {
    if (!DebugGates.enabled) return;
    final now = DateTime.now();
    if (_debugTapAt == null ||
        now.difference(_debugTapAt!) > const Duration(seconds: 2)) {
      _debugTaps = 0;
    }
    _debugTapAt = now;
    if (++_debugTaps >= 5) {
      _debugTaps = 0;
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => const ApiConsoleScreen()));
    }
  }

  Widget _page(int i) {
    if (!_built.contains(i)) return const SizedBox.shrink();
    return switch (i) {
      tabHome => HomeScreen(onOpenTab: _select),
      tabLog => const MyLogScreen(),
      tabVisit => const VisitPrepScreen(),
      _ => const EnvScreen(embedded: true),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.defaultBackground,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 16,
        title: GestureDetector(
          onTap: _onTitleTap,
          child: Text(
            l10n.appTitle,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppTheme.brand700,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          Semantics(
            button: true,
            label: l10n.s5UrgentHelp,
            child: TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.error600,
                minimumSize: const Size(48, 48),
              ),
              onPressed: _openUrgentHelp,
              icon: const Icon(Icons.sos_outlined),
              label: Text(l10n.s5UrgentHelp),
            ),
          ),
          IconButton(
            tooltip: l10n.settingsTitle,
            onPressed: _openSettings,
            icon: const Icon(Icons.settings_outlined),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [for (var i = 0; i < 4; i++) _page(i)],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _select,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.event_note_outlined),
            selectedIcon: const Icon(Icons.event_note),
            label: l10n.s5NavLog,
          ),
          NavigationDestination(
            icon: const Icon(Icons.assignment_outlined),
            selectedIcon: const Icon(Icons.assignment),
            label: l10n.s5NavVisitPrep,
          ),
          NavigationDestination(
            icon: const Icon(Icons.air_outlined),
            selectedIcon: const Icon(Icons.air),
            label: l10n.s5NavEnvironment,
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
