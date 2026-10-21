import 'package:flutter/material.dart';

import '../../../core/session/session_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../auth/auth_screen.dart';
import '../covernote_root.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';
import 'capture_screen.dart';
import 'case_card.dart';
import 'routes.dart';

class CasesTab extends StatefulWidget {
  const CasesTab({super.key});

  @override
  State<CasesTab> createState() => CasesTabState();
}

class CasesTabState extends State<CasesTab> {
  List<CaseSummary>? _cases;
  String? _error;
  String? _loadedFor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = SessionScope.of(context);
    final uid = s.isReady ? s.user?.id : null;
    if (uid != _loadedFor) {
      _loadedFor = uid;
      _cases = null;
      if (uid != null) refresh();
    }
  }

  Future<void> refresh() async {
    if (_loadedFor == null) return;
    try {
      final list = await CoverNoteServices.of(context).live.listCases();
      if (!mounted) return;
      setState(() {
        _cases = list;
        _error = null;
      });
    } on Object catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    }
  }

  Future<void> _open(CaseSummary c) async {
    await openCase(context, CoverNoteServices.of(context).live, c.row.id);
    if (mounted) await refresh();
  }

  Future<void> _delete(CaseSummary c) async {
    final store = CoverNoteServices.of(context).live;
    final deleted = await confirmDeleteCase(
      context,
      () => store.deleteCase(c.row.id),
    );
    if (deleted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.cnCaseDeleted)),
      );
      await refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final session = SessionScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.cnTabCases)),
      body: Builder(
        builder: (context) {
          if (!session.isReady) {
            return Center(
              child: ActionMessage(
                icon: Icons.lock_outline,
                title: l.cnCasesSignInTitle,
                body: l.cnCasesSignInBody,
                actionLabel: l.cnAuthSignIn,
                onAction: () => requireSignIn(context),
                secondaryLabel: l.cnTryDemo,
                onSecondary: () => openDemo(context),
              ),
            );
          }
          if (_error != null && _cases == null) {
            return Center(
              child: ActionMessage(
                icon: Icons.cloud_off,
                title: l.cnErrNetwork,
                actionLabel: l.cnRetry,
                onAction: refresh,
              ),
            );
          }
          final cases = _cases;
          if (cases == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (cases.isEmpty) {
            return Center(
              child: ActionMessage(
                icon: Icons.folder_open,
                title: l.cnNoCasesYet,
                body: l.cnNoCasesBody,
                actionLabel: l.cnScanLetter,
                onAction: () async {
                  await startNewCase(context, CaptureSource.camera);
                  if (mounted) await refresh();
                },
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cases.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (_, i) => CaseCard(
                summary: cases[i],
                onTap: () => _open(cases[i]),
                onDelete: () => _delete(cases[i]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: session.isReady
          ? FloatingActionButton.extended(
              onPressed: () async {
                await startNewCase(context, CaptureSource.camera);
                if (mounted) await refresh();
              },
              icon: const Icon(Icons.document_scanner_outlined),
              label: Text(l.cnScanLetter),
            )
          : null,
    );
  }
}
