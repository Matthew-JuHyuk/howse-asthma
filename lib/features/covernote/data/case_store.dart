import 'dart:typed_data';

import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../domain/record_snapshot.dart';

/// Safe error with a short code the UI maps to a message and a next action.
class CaseStoreException implements Exception {
  const CaseStoreException(this.code);

  final String code;

  @override
  String toString() => 'CaseStoreException($code)';
}

/// Everything the case screens need. Two implementations:
/// [SupabaseCaseStore] (signed-in, real server) and [DemoCaseStore]
/// (local synthetic sample, no account, no file processing).
abstract class CaseStore {
  bool get isDemo;

  /// Today's date for counting record windows. Fixed in the demo.
  DateTime get today;

  Future<List<CaseSummary>> listCases();

  Future<CaseDetail> load(String caseId);

  /// Creates a case, uploads the pages as one set, and asks the server to
  /// read them. Returns the case id even if analysis could not start.
  Future<String> createFromPages(List<PreparedPage> pages);

  /// Uploads a new page set for an existing case and starts analysis on it.
  Future<int> replacePages(String caseId, List<PreparedPage> pages);

  Future<CaseJob?> startAnalysis(
    String caseId,
    int setRevision, {
    bool retry = false,
  });

  Future<CaseJob?> currentJob(String caseId, int setRevision);

  /// Saves a new fact revision. Throws `stale_facts` if someone else saved first.
  Future<int> saveFacts(String caseId, CaseFacts facts, int baseRevision);

  Future<CaseRequirement> updateRequirement(
    String caseId,
    CaseRequirement requirement,
  );

  Future<CaseRequirement> addRequirement(String caseId, String label);

  Future<EvidenceItem> attachEvidence(
    String caseId, {
    required String recordType,
    required Map<String, Object?> snapshot,
    required DayRange range,
    required String sourceType,
  });

  Future<void> removeEvidence(String caseId, String evidenceId);

  Future<CaseArtifact> savePacket(
    String caseId,
    Uint8List bytes, {
    required int factRevision,
    required int evidenceRevision,
    required List<String> includes,
    required bool isSample,
  });

  Future<Uint8List?> loadPacketBytes(String caseId, CaseArtifact artifact);

  Future<void> markExported(String caseId);

  Future<void> markSubmitted(
    String caseId, {
    required String date,
    required String method,
  });

  Future<void> deleteCase(String caseId);

  Future<Uint8List?> loadFile(LetterFile file);

  Future<RecordSnapshots> loadSnapshots(DayRange range);

  /// True/false when the server answered; null when it could not be reached.
  Future<bool?> analysisAvailable();
}
