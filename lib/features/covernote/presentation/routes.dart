import 'package:flutter/material.dart';

import '../auth/auth_screen.dart';
import '../covernote_root.dart';
import '../data/case_store.dart';
import 'capture_screen.dart';
import 'case_screen.dart';
import 'covernote_nav.dart';
import 'demo_screen.dart';
import '../data/preparation_repository.dart';
import 'preparation_screen.dart';

/// Sign in if needed, capture or pick pages, upload, then open the new case.
Future<void> startNewCase(BuildContext context, CaptureSource source) async {
  if (!await requireSignIn(context)) return;
  if (!context.mounted) return;
  final store = CoverNoteServices.of(context).live;
  final caseId = await Navigator.push<String>(
    context,
    MaterialPageRoute(
      builder: (_) => CaptureScreen(store: store, source: source),
    ),
  );
  if (caseId == null || !context.mounted) return;
  await openCase(context, store, caseId);
}

Future<void> openCase(
  BuildContext context,
  CaseStore store,
  String caseId,
) async {
  if (!store.isDemo) {
    final repo = PreparationRepository();
    try {
      final p = await repo.load(caseId);
      if (!context.mounted) return;
      if (p != null) {
        await Navigator.push<void>(
          context,
          MaterialPageRoute(
            builder: (_) => PreparationScreen(
              repository: repo,
              caseId: caseId,
              mainNavigation: mainTabNavigation(context),
            ),
          ),
        );
        return;
      }
    } catch (_) {
      /* Sprint9 backends can still open their original cases. */
    }
  }
  final nav = CoverNoteNav.maybeOf(context);
  if (nav != null) {
    nav.openCase(store, caseId);
    return Future<void>.value();
  }
  return Navigator.push<void>(
    context,
    MaterialPageRoute(
      builder: (_) => CaseScreen(store: store, caseId: caseId),
    ),
  );
}

Future<void> openDemo(BuildContext context) => Navigator.push<void>(
  context,
  MaterialPageRoute(
    builder: (_) => DemoScreen(store: CoverNoteServices.of(context).demo),
  ),
);
