import 'package:flutter/material.dart';
import '../data/case_store.dart';

ValueChanged<int>? mainTabNavigation(BuildContext context) {
  final nav = CoverNoteNav.maybeOf(context);
  if (nav == null) return null;
  final navigator = Navigator.of(context);
  return (index) {
    if (!navigator.mounted) return;
    navigator.popUntil((r) => r.isFirst);
    [nav.goHome, nav.goCases, nav.goRecords, nav.goSettings][index]();
  };
}

/// Lets any screen open a case inside the Cases tab (bottom nav stays).
class CoverNoteNav extends InheritedWidget {
  const CoverNoteNav({
    super.key,
    required super.child,
    required this.openCase,
    required this.closeCase,
    required this.goHome,
    required this.goCases,
    required this.goRecords,
    required this.goSettings,
    this.openCaseId,
  });

  final void Function(CaseStore store, String caseId) openCase;
  final VoidCallback closeCase;
  final VoidCallback goHome;
  final VoidCallback goCases;
  final VoidCallback goRecords;
  final VoidCallback goSettings;
  final String? openCaseId;

  static CoverNoteNav? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CoverNoteNav>();

  static CoverNoteNav of(BuildContext context) {
    final n = maybeOf(context);
    assert(n != null, 'CoverNoteNav missing');
    return n!;
  }

  @override
  bool updateShouldNotify(CoverNoteNav oldWidget) =>
      openCaseId != oldWidget.openCaseId;
}
