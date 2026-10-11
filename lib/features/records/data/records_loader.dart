import '../../assessments/data/pdc_repository.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../domain/record_models.dart';
import '../domain/record_summary.dart';
import 'symptom_repository.dart';

/// Loads every record type for a range so all screens share one summary.
class RecordsLoader {
  RecordsLoader({
    InhalerEventRepository? inhaler,
    SymptomRepository? symptoms,
    PdcRepository? medChecks,
  }) : _inhaler = inhaler ?? InhalerEventRepository(),
       _symptoms = symptoms ?? SymptomRepository(),
       _medChecks = medChecks ?? PdcRepository();

  final InhalerEventRepository _inhaler;
  final SymptomRepository _symptoms;
  final PdcRepository _medChecks;

  Future<RecordBundle> load(RecordRange range) async {
    final results = await Future.wait([
      _inhaler.listBetween(range.start, range.end),
      _symptoms.listBetween(range.start, range.end),
      _medChecks.listBetween(range.start, range.end),
    ]);
    final inhaler = (results[0] as List<InhalerRecord>)
        .where((e) => range.contains(e.localDate))
        .toList();
    final symptoms = (results[1] as List<SymptomRecord>)
        .where((e) => range.contains(e.localDate))
        .toList();
    final checks = (results[2] as List<MedCheckRecord>)
        .where((e) => range.contains(e.date))
        .toList();
    return RecordBundle(
      inhaler: inhaler,
      symptoms: symptoms,
      medChecks: checks,
    );
  }
}
