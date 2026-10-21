import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/records/domain/record_models.dart';
import 'package:howse_asthma/features/records/domain/record_summary.dart';

const _est = -300;

InhalerRecord _inhaler(
  String id,
  DateTime utc, {
  int? tz = _est,
  String? label,
  String? status,
  String? reason,
}) => InhalerRecord(
  id: id,
  recordedAtUtc: utc,
  tzOffsetMinutes: tz,
  medicationLabel: label,
  medicationStatus: status,
  useReason: reason,
);

SymptomRecord _symptom(
  String id,
  DateTime utc, {
  List<String> codes = const [],
  bool none = false,
  String? other,
}) => SymptomRecord(
  id: id,
  recordedAtUtc: utc,
  tzOffsetMinutes: _est,
  symptoms: codes,
  noSymptoms: none,
  otherText: other,
);

void main() {
  final today = DateTime(2026, 10, 11);
  final week = RecordRange.lastDays(7, today: today);

  group('local dates', () {
    test('record offset decides the calendar day, not UTC', () {
      final utc = DateTime.utc(2026, 10, 11, 3, 30);
      expect(recordLocalDate(utc, _est), DateTime(2026, 10, 10));
      expect(recordLocalDate(utc, 0), DateTime(2026, 10, 11));
      expect(recordLocalTime(utc, _est), DateTime(2026, 10, 10, 22, 30));
    });

    test('positive offsets roll forward', () {
      final utc = DateTime.utc(2026, 10, 10, 20);
      expect(recordLocalDate(utc, 540), DateTime(2026, 10, 11));
    });

    test('range is inclusive and counts calendar days', () {
      expect(week.days, 7);
      expect(week.start, DateTime(2026, 10, 5));
      expect(week.contains(DateTime(2026, 10, 5, 23, 59)), isTrue);
      expect(week.contains(DateTime(2026, 10, 4)), isFalse);
      expect(week.contains(DateTime(2026, 10, 12)), isFalse);
      expect(week.dates.length, 7);
      expect(RecordRange.lastDays(1, today: today).days, 1);
      expect(RecordRange.lastDays(30, today: today).days, 30);
    });

    test('isoDate pads', () {
      expect(isoDate(DateTime(2026, 3, 4)), '2026-03-04');
    });
  });

  group('RecordSummary', () {
    test('empty bundle is not recorded everywhere, never zero symptoms', () {
      final s = RecordSummary.compute(week, const RecordBundle());
      expect(s.isEmpty, isTrue);
      expect(s.symptomDays, 0);
      expect(s.noSymptomDays, 0);
      expect(s.medNotRecordedDays, 7);
      expect(s.medAnsweredDays, 0);
    });

    test('inhaler uses vs days, unknown medication, by label', () {
      final s = RecordSummary.compute(
        week,
        RecordBundle(
          inhaler: [
            _inhaler('a', DateTime.utc(2026, 10, 10, 14), label: 'Blue'),
            _inhaler('b', DateTime.utc(2026, 10, 10, 18), label: 'Blue'),
            _inhaler(
              'c',
              DateTime.utc(2026, 10, 9, 14),
              status: InhalerRecord.statusNotIdentified,
            ),
            _inhaler('d', DateTime.utc(2026, 10, 8, 14)),
            _inhaler('old', DateTime.utc(2026, 10, 1, 14), label: 'Blue'),
          ],
        ),
      );
      expect(s.inhalerUses, 4);
      expect(s.inhalerDays, 3);
      expect(s.inhalerByMedication, {'Blue': 2});
      expect(s.inhalerUnknownMedication, 1);
      expect(s.recordedDays, 3);
    });

    test('late-evening use stays on the local day at the range edge', () {
      final s = RecordSummary.compute(
        week,
        RecordBundle(inhaler: [_inhaler('a', DateTime.utc(2026, 10, 5, 3))]),
      );
      expect(s.inhalerUses, 0);
    });

    test('no-symptom days exclude days that also had symptoms', () {
      final s = RecordSummary.compute(
        week,
        RecordBundle(
          symptoms: [
            _symptom('1', DateTime.utc(2026, 10, 10, 13), none: true),
            _symptom('2', DateTime.utc(2026, 10, 10, 20), codes: ['cough']),
            _symptom('3', DateTime.utc(2026, 10, 9, 13), none: true),
            _symptom(
              '4',
              DateTime.utc(2026, 10, 8, 13),
              codes: ['cough', 'wheeze'],
              other: 'tight chest',
            ),
          ],
        ),
      );
      expect(s.symptomDays, 2);
      expect(s.noSymptomDays, 1);
      expect(s.symptomDaysByCode, {'cough': 2, 'wheeze': 1});
      expect(s.symptomOtherDays, 1);
    });

    test('medication checks: latest answer per day, reasons, not recorded', () {
      final s = RecordSummary.compute(
        week,
        RecordBundle(
          medChecks: [
            MedCheckRecord(
              id: '1',
              date: DateTime(2026, 10, 10),
              status: MedCheckRecord.notUsed,
              reason: 'cost',
              updatedAt: DateTime.utc(2026, 10, 10, 12),
            ),
            MedCheckRecord(
              id: '2',
              date: DateTime(2026, 10, 10),
              status: MedCheckRecord.used,
              updatedAt: DateTime.utc(2026, 10, 10, 18),
            ),
            MedCheckRecord(
              id: '3',
              date: DateTime(2026, 10, 9),
              status: MedCheckRecord.notUsed,
            ),
            MedCheckRecord(
              id: '4',
              date: DateTime(2026, 10, 8),
              status: MedCheckRecord.notSure,
            ),
            MedCheckRecord(
              id: '5',
              date: DateTime(2026, 10, 7),
              status: MedCheckRecord.notApplicable,
            ),
          ],
        ),
      );
      expect(s.medUsedDays, 1);
      expect(s.medNotUsedDays, 1);
      expect(s.medNotSureDays, 1);
      expect(s.medNotApplicableDays, 1);
      expect(s.medNotRecordedDays, 3);
      expect(s.medNotUsedReasons, {'no_answer': 1});
    });

    test('legacy taken flag maps to the new statuses', () {
      final used = MedCheckRecord.fromRow({
        'id': 'x',
        'check_date': '2026-10-10',
        'taken': true,
      });
      final notUsed = MedCheckRecord.fromRow({
        'id': 'y',
        'check_date': '2026-10-10',
        'taken': false,
      });
      expect(used?.status, MedCheckRecord.used);
      expect(notUsed?.status, MedCheckRecord.notUsed);
      expect(
        MedCheckRecord.fromRow({'id': 'z', 'check_date': '2026-10-10'}),
        isNull,
      );
    });
  });

  group('fingerprints and ids', () {
    test('request ids are v4 UUIDs and unique', () {
      final ids = {for (var i = 0; i < 50; i++) newRequestId()};
      expect(ids.length, 50);
      for (final id in ids) {
        expect(
          RegExp(
            r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          ).hasMatch(id),
          isTrue,
        );
      }
    });
  });
}
