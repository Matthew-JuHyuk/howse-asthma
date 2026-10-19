import 'package:flutter/foundation.dart';

import '../domain/appeal_flow.dart';
import '../domain/appeal_models.dart';
import '../domain/synthetic_case.dart';

/// In-memory sample cases. Labeled demo data only.
/// Live document reading is a separate flag and is not used here.
class AppealDemoStore extends ChangeNotifier {
  AppealDemoStore({JobLedger? jobs}) : _jobs = jobs ?? JobLedger();

  final JobLedger _jobs;
  final List<AppealCase> _cases = [];

  static final AppealDemoStore instance = AppealDemoStore();

  List<AppealCase> get cases =>
      _cases.where((item) => item.status != CaseStatus.deleted).toList();

  AppealCase? find(String id) {
    for (final item in _cases) {
      if (item.id == id && item.status != CaseStatus.deleted) return item;
    }
    return null;
  }

  AppealCase ensureExplicitSample() {
    _jobs.start(kind: 'sample-explicit', inputRevision: '1');
    for (final item in _cases) {
      if (item.fixtureId == 'explicit-date' &&
          item.status != CaseStatus.deleted) {
        return item;
      }
    }
    final created = explicitDateSample();
    _cases.add(created);
    notifyListeners();
    return created;
  }

  void confirm(String id) => _replace(confirmCoreFacts(_required(id)));

  void editMedication(String id, String raw) =>
      _replace(editMedicationRaw(_required(id), raw));

  void setDeadlineConfirmed(String id, bool value) {
    final current = _required(id);
    _replace(current.copyWith(deadlineConfirmedByUser: value));
  }

  void setSelfReport(String id, String? note) {
    final current = _required(id);
    final trimmed = note?.trim() ?? '';
    if (trimmed.isEmpty || trimmed == 'unknown') {
      _replace(
        current.copyWith(
          clearSelfReport: true,
          clearLetter: true,
          clearGenerated: true,
          factRevision: current.factRevision + 1,
          clearConfirmedRevision: true,
          coreReviewed: false,
          status: CaseStatus.needsReview,
        ),
      );
      return;
    }
    _replace(
      current.copyWith(
        selfReport: trimmed,
        clearLetter: true,
        clearGenerated: true,
        factRevision: current.factRevision + 1,
        clearConfirmedRevision: true,
        coreReviewed: false,
        status: CaseStatus.needsReview,
      ),
    );
  }

  AppealCase generate(String id, ExportMode mode) {
    final current = _required(id);
    final letter = generateLetter(current, mode);
    final stored = storeLetter(current, letter);
    _replace(stored);
    return stored;
  }

  void deleteCase(String id) {
    final current = _required(id);
    _replace(
      current.copyWith(
        status: CaseStatus.deleted,
        clearLetter: true,
        clearGenerated: true,
      ),
    );
  }

  AppealCase _required(String id) {
    final item = find(id);
    if (item == null) throw AppealFlowException('not_found');
    return item;
  }

  void _replace(AppealCase next) {
    final index = _cases.indexWhere((item) => item.id == next.id);
    if (index < 0) {
      _cases.add(next);
    } else {
      _cases[index] = next;
    }
    notifyListeners();
  }
}

/// Named wrapper so the store method does not clash with the domain function.
AppealCase editMedicationRaw(AppealCase item, String raw) =>
    editMedication(item, raw);
