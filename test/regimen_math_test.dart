import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/records/domain/regimen_math.dart';

void main() {
  test('one missed occasion is 59/60, not the puff percent', () {
    final tally = RegimenMath.tally(
      scheduledOccasions: 60,
      puffsPerOccasion: 2,
      used: 59,
      notUsed: 1,
      deferred: 0,
    );
    expect(tally.unconfirmed, 0);
    expect(tally.occasionPercent, 98.3);
    expect(tally.scheduledPuffs, 120);
    expect(tally.usedPuffs, 118);
    expect(tally.notUsedPuffs, 2);
  });

  test('no answer is unconfirmed and is not counted as not used', () {
    final tally = RegimenMath.tally(
      scheduledOccasions: 60,
      puffsPerOccasion: 2,
      used: 59,
      notUsed: 0,
      deferred: 0,
    );
    expect(tally.notUsed, 0);
    expect(tally.unconfirmed, 1);
    expect(tally.notUsedPuffs, 0);
  });

  test('a regimen change keeps the old denominator', () {
    final before = RegimenMath.scheduledOccasions(
      start: DateTime(2026, 8, 3),
      end: DateTime(2026, 9, 2),
      effectiveFrom: DateTime(2026, 8, 3),
      effectiveUntil: DateTime(2026, 8, 16),
      occasionsPerDay: 2,
    );
    final after = RegimenMath.scheduledOccasions(
      start: DateTime(2026, 8, 3),
      end: DateTime(2026, 9, 2),
      effectiveFrom: DateTime(2026, 8, 17),
      effectiveUntil: null,
      occasionsPerDay: 1,
    );
    expect(before, 28);
    expect(after, 17);
    expect(before + after, 45);
  });

  test('Aug 3 through Sep 2 inclusive is 31 days', () {
    final start = DateTime(2026, 8, 3);
    final end = DateTime(2026, 9, 2);
    expect(end.difference(start).inDays + 1, 31);
  });

  test('yesterday symptom does not take today environment', () {
    final now = DateTime.utc(2026, 10, 11, 15);
    expect(
      RegimenMath.canLinkCurrentEnvironment(
        occurredAt: now.subtract(const Duration(days: 1)),
        now: now,
      ),
      isFalse,
    );
    expect(
      RegimenMath.canLinkCurrentEnvironment(
        occurredAt: now.subtract(const Duration(minutes: 10)),
        now: now,
      ),
      isTrue,
    );
    expect(
      RegimenMath.canLinkCurrentEnvironment(occurredAt: null, now: now),
      isFalse,
    );
  });
}
