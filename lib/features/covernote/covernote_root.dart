import 'package:flutter/material.dart';

import '../../core/session/session_controller.dart';
import '../auth/domain/user_profile.dart';
import '../provider/presentation/provider_home_shell.dart';
import 'auth/auth_screen.dart';
import 'data/case_store.dart';
import 'data/demo_case_store.dart';
import 'data/preparation_repository.dart';
import 'presentation/account_tab.dart';
import 'presentation/case_screen.dart';
import 'presentation/cases_tab.dart';
import 'presentation/covernote_nav.dart';
import 'presentation/home_tab.dart';
import 'presentation/records_tab.dart';
import 'presentation/guided_record_screen.dart';
import 'presentation/record_navigation_bar.dart';

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

class _CoverNoteShellState extends State<CoverNoteShell>
    with WidgetsBindingObserver {
  String? _syncOwner;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = SessionScope.of(context);
    if (s.isReady && s.user?.id != _syncOwner) {
      _syncOwner = s.user?.id;
      _syncDirect();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _syncDirect();
  }

  Future<void> _syncDirect() async {
    try {
      final r = PreparationRepository();
      await r.importDirectRecords();
      await r.flush();
    } catch (_) {
      /* Owner-scoped queue persists for retry. */
    }
  }

  bool _recordOpen = false;
  Future<void> _record() async {
    if (_recordOpen) return;
    _recordOpen = true;
    try {
      if (!await requireSignIn(context) || !mounted) return;
      await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) =>
              GuidedRecordScreen(repository: PreparationRepository()),
        ),
      );
      if (mounted) _homeKey.currentState?.refresh();
    } finally {
      _recordOpen = false;
    }
  }

  int _tab = 0;
  final _casesKey = GlobalKey<CasesTabState>();
  final _homeKey = GlobalKey<HomeTabState>();
  String? _caseId;
  CaseStore? _caseStore;

  void _go(int i) {
    setState(() {
      _tab = i;
      // Home and the cases tab both leave an open case. One tap shows
      // Home, or the case list, instead of staying on the same case.
      if (i == 0 || i == 1) {
        _caseId = null;
        _caseStore = null;
      }
    });
    if (i == 0) _homeKey.currentState?.refresh();
    if (i == 1) _casesKey.currentState?.refresh();
  }

  void _openCase(CaseStore store, String id) {
    setState(() {
      _tab = 1;
      _caseId = id;
      _caseStore = store;
    });
  }

  void _closeCase() {
    setState(() => _caseId = null);
    _casesKey.currentState?.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final caseOpen = _caseId != null && _caseStore != null;
    return CoverNoteNav(
      openCase: _openCase,
      closeCase: _closeCase,
      goHome: () => _go(0),
      goCases: () => _go(1),
      goRecords: () => _go(2),
      goSettings: () => _go(3),
      openCaseId: _caseId,
      child: PopScope(
        canPop: _tab == 0 && !caseOpen,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          if (caseOpen) {
            _closeCase();
            return;
          }
          _go(0);
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
              caseOpen
                  ? CaseScreen(
                      key: ValueKey(_caseId),
                      store: _caseStore!,
                      caseId: _caseId!,
                      embedded: true,
                    )
                  : CasesTab(key: _casesKey),
              const RecordsTab(),
              const AccountTab(),
            ],
          ),
          bottomNavigationBar: RecordNavigationBar(
            selectedIndex: _tab,
            onDestination: _go,
            onRecord: _record,
          ),
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
