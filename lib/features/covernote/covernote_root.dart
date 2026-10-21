import 'package:flutter/material.dart';

import '../../core/session/session_controller.dart';
import '../../l10n/app_localizations.dart';
import '../auth/domain/user_profile.dart';
import '../provider/presentation/provider_home_shell.dart';
import 'auth/auth_screen.dart';
import 'data/case_store.dart';
import 'data/demo_case_store.dart';
import 'presentation/account_tab.dart';
import 'presentation/cases_tab.dart';
import 'presentation/home_tab.dart';
import 'presentation/records_tab.dart';

/// Stores shared by every screen. The demo store lives for the app session.
class CoverNoteServices extends InheritedWidget {
  const CoverNoteServices({
    super.key,
    required super.child,
    required this.live,
    required this.demo,
  });

  final CaseStore live;
  final DemoCaseStore demo;

  static CoverNoteServices of(BuildContext context) {
    final s = context.getInheritedWidgetOfExactType<CoverNoteServices>();
    assert(s != null, 'CoverNoteServices missing');
    return s!;
  }

  @override
  bool updateShouldNotify(CoverNoteServices oldWidget) => false;
}

class CoverNoteRoot extends StatelessWidget {
  const CoverNoteRoot({super.key});

  @override
  Widget build(BuildContext context) {
    final session = SessionScope.of(context);
    if (session.passwordRecovery) return const SetNewPasswordScreen();
    if (session.isReady && session.profile!.role == UserRole.provider) {
      return const ProviderHomeShell();
    }
    return const CoverNoteShell();
  }
}

class CoverNoteShell extends StatefulWidget {
  const CoverNoteShell({super.key});

  @override
  State<CoverNoteShell> createState() => _CoverNoteShellState();
}

class _CoverNoteShellState extends State<CoverNoteShell> {
  int _tab = 0;
  final _casesKey = GlobalKey<CasesTabState>();
  final _homeKey = GlobalKey<HomeTabState>();

  void _go(int i) {
    setState(() => _tab = i);
    if (i == 0) _homeKey.currentState?.refresh();
    if (i == 1) _casesKey.currentState?.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return PopScope(
      canPop: _tab == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _go(0);
      },
      child: Scaffold(
        body: IndexedStack(
          index: _tab,
          children: [
            HomeTab(
              key: _homeKey,
              onOpenCases: () => _go(1),
              onOpenAccount: () => _go(3),
            ),
            CasesTab(key: _casesKey),
            const RecordsTab(),
            const AccountTab(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: _go,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: l.cnTabHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.folder_outlined),
              selectedIcon: const Icon(Icons.folder),
              label: l.cnTabCases,
            ),
            NavigationDestination(
              icon: const Icon(Icons.fact_check_outlined),
              selectedIcon: const Icon(Icons.fact_check),
              label: l.cnTabRecords,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              label: l.cnTabAccount,
            ),
          ],
        ),
      ),
    );
  }
}

/// Opens sign-in if needed, then runs [action].
Future<void> withSignIn(
  BuildContext context,
  Future<void> Function() action,
) async {
  if (await requireSignIn(context)) await action();
}
