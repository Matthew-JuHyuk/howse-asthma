import 'package:flutter/material.dart';

import '../auth/auth_screen.dart';
import '../covernote_root.dart';
import '../data/case_store.dart';
import 'capture_screen.dart';
import 'case_screen.dart';
import 'demo_screen.dart';

/// Sign in if needed, capture or pick pages, upload, then open the new case.
/// Completes when the user leaves the case screen.
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

Future<void> openCase(BuildContext context, CaseStore store, String caseId) =>
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CaseScreen(store: store, caseId: caseId),
      ),
    );

Future<void> openDemo(BuildContext context) => Navigator.push<void>(
  context,
  MaterialPageRoute(
    builder: (_) => DemoScreen(store: CoverNoteServices.of(context).demo),
  ),
);
