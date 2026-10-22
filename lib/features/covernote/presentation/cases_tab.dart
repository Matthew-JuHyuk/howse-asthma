import 'package:flutter/material.dart';

import '../../../core/session/session_controller.dart';
import '../../../l10n/app_localizations.dart';
import '../auth/auth_screen.dart';
import '../covernote_root.dart';
import '../data/delivery_repository.dart';
import '../domain/case_models.dart';
import '../domain/s9_models.dart';
import '../ui/app_chrome.dart';
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
  Map<String, List<DeliveryEvent>> _deliveries = const {};
  String? _error;
  String? _loadedFor;
  var _showActive = true;
  String _query = '';

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
      final del = await DeliveryRepository().listForCases(
        list.map((c) => c.row.id).toList(),
      );
      if (!mounted) return;
      setState(() {
        _cases = list;
        _deliveries = del;
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

  List<CaseSummary> _filtered() {
    final all = _cases ?? const <CaseSummary>[];
    final q = _query.trim().toLowerCase();
    return [
      for (final c in all)
        if ((_showActive
                ? c.row.lifecycle == CaseLifecycle.active
                : c.row.lifecycle != CaseLifecycle.active) &&
            (q.isEmpty ||
                (c.row.title ?? '').toLowerCase().contains(q) ||
                (c.row.planName ?? '').toLowerCase().contains(q) ||
                (c.row.displayAlias ?? '').toLowerCase().contains(q) ||
                '${c.row.displayOrdinal}'.contains(q)))
          c,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final session = SessionScope.of(context);
    return Scaffold(
      appBar: CoverNoteAppBar(title: Text(l.cnTabCases)),
      body: SafeArea(
        child: Builder(
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
            final visible = _filtered();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(
                        value: true,
                        label: Text(l.cnActiveCases),
                      ),
                      ButtonSegment(
                        value: false,
                        label: Text(l.cnCompletedArchived),
                      ),
                    ],
                    selected: {_showActive},
                    onSelectionChanged: (s) =>
                        setState(() => _showActive = s.first),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: l.cnTabCases,
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                Expanded(
                  child: visible.isEmpty
                      ? Center(
                          child: ActionMessage(
                            icon: Icons.folder_open,
                            title: l.cnNoCasesYet,
                            body: l.cnNoCasesBody,
                            actionLabel: l.cnScanLetter,
                            onAction: () async {
                              await startNewCase(
                                context,
                                CaptureSource.camera,
                              );
                              if (mounted) await refresh();
                            },
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: refresh,
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                            itemCount: visible.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 8),
                            itemBuilder: (_, i) => CaseCard(
                              summary: visible[i],
                              deliveries:
                                  _deliveries[visible[i].row.id] ?? const [],
                              onTap: () => _open(visible[i]),
                              onDelete: () => _delete(visible[i]),
                            ),
                          ),
                        ),
                ),
              ],
            );
          },
        ),
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
