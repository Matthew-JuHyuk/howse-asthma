import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/data/demo_case_store.dart';
import 'package:howse_asthma/features/covernote/domain/record_snapshot.dart';
import 'package:howse_asthma/features/records/domain/record_models.dart';

void main() {
  final range = DayRange.lastDays(DemoCaseStore.demoToday, 30);

  test('the window is the 30 full days before today', () {
    expect(range.from, DateTime(2026, 9, 20));
    expect(range.to, DateTime(2026, 10, 19));
    expect(range.dayCount, 30);
  });

  test('seed counts: 51 taken, 3 not taken, 6 unknown of 60', () {
    final m = demoSnapshots(range).medication;
    expect(m.scheduled, 60);
    expect(m.taken, 51);
    expect(m.notTaken, 3);
    expect(m.unknown, 6);
    expect(m.deferred, 0);
  });

  test('as-needed use: 8 uses, 16 puffs', () {
    final m = demoSnapshots(range).medication;
    expect(m.prnUses, 8);
    expect(m.prnPuffs, 16);
    expect(m.prnUsesWithoutCount, 0);
  });

  test('regional data on 22 of 30 days; missing days are not filled', () {
    final c = demoSnapshots(range).localContext;
    expect(c.pm25Days, 22);
    expect(c.pm25DaysAbove100, 4);
    expect(c.synthetic, isTrue);
    expect(c.reportCounts, {'damp_musty': 2});
  });

  test('an unanswered dose is unknown, not a missed dose', () {
    final day = DateTime(2026, 10, 1);
    final m = MedicationSnapshot.compute(
      range: DayRange(day, day),
      regimens: [
        RegimenInput(
          id: 'r',
          medicationName: 'X',
          occasionsPerDay: 2,
          puffsPerOccasion: 1,
          effectiveFrom: day,
        ),
      ],
      checks: [OccasionInput('r', day, 'used')],
      inhaler: const [],
    );
    expect(m.scheduled, 2);
    expect(m.taken, 1);
    expect(m.notTaken, 0);
    expect(m.unknown, 1);
  });

  test('use without a puff count is counted but adds no puffs', () {
    final day = DateTime(2026, 10, 1);
    final m = MedicationSnapshot.compute(
      range: DayRange(day, day),
      regimens: const [],
      checks: const [],
      inhaler: [
        InhalerRecord(
          id: 'a',
          recordedAtUtc: DateTime.utc(2026, 10, 1, 15),
          tzOffsetMinutes: -240,
          puffCount: 2,
        ),
        InhalerRecord(
          id: 'b',
          recordedAtUtc: DateTime.utc(2026, 10, 1, 16),
          tzOffsetMinutes: -240,
        ),
        InhalerRecord(
          id: 'panic',
          recordedAtUtc: DateTime.utc(2026, 10, 1, 17),
          tzOffsetMinutes: -240,
          isPanic: true,
          puffCount: 4,
        ),
      ],
    );
    expect(m.prnUses, 2);
    expect(m.prnPuffs, 2);
    expect(m.prnUsesWithoutCount, 1);
  });

  test('forecasts and days outside the window are not past observations', () {
    final day = DateTime(2026, 10, 1);
    final c = LocalContextSnapshot.compute(
      range: DayRange(day, day),
      entries: [
        LocalContextInput(
          date: day,
          kind: 'pm25',
          valueKind: 'forecast',
          isSynthetic: false,
          aqi: 150,
        ),
        LocalContextInput(
          date: DateTime(2026, 10, 2),
          kind: 'pm25',
          valueKind: 'observation',
          isSynthetic: false,
          aqi: 160,
        ),
        LocalContextInput(
          date: day,
          kind: 'outdoor_humidity',
          valueKind: 'observation',
          isSynthetic: false,
          numericValue: 95,
          unit: '%',
        ),
      ],
    );
    expect(c.pm25Days, 0);
    expect(c.pm25MaxAqi, isNull);
    expect(c.reportCounts, isEmpty);
    expect(c.isEmpty, isTrue);
  });

  test('snapshot JSON round trip', () {
    final s = demoSnapshots(range);
    final m = MedicationSnapshot.fromJson(s.medication.toJson())!;
    expect(m.taken, 51);
    expect(m.toJson()['source'], 'patient_reported');
    final c = LocalContextSnapshot.fromJson(s.localContext.toJson())!;
    expect(c.pm25Days, 22);
    expect(c.synthetic, isTrue);
  });
}
