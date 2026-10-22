import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/data/demo_case_store.dart';
import 'package:howse_asthma/features/covernote/domain/case_identity.dart';
import 'package:howse_asthma/features/covernote/domain/record_snapshot.dart';
import 'package:howse_asthma/features/covernote/domain/s9_models.dart';
import 'package:howse_asthma/l10n/app_localizations_en.dart';

void main() {
  test('today is inside lastDays(30)', () {
    final today = DateTime(2026, 10, 21);
    final range = DayRange.lastDays(today, 30);
    expect(range.from, DateTime(2026, 9, 22));
    expect(range.to, today);
    expect(range.contains(today), isTrue);
    expect(range.contains(DateTime(2026, 9, 22)), isTrue);
    expect(range.contains(DateTime(2026, 9, 21)), isFalse);
  });

  test('today preset is one local day', () {
    final r = DayRange.today(DateTime(2026, 10, 21, 19, 30));
    expect(r.dayCount, 1);
    expect(r.from, DateTime(2026, 10, 21));
  });

  test('demo 30-day window still counts the seeded uses', () {
    final range = DayRange.lastDays(DemoCaseStore.demoToday, 30);
    final m = demoSnapshots(range).medication;
    expect(m.scheduled, 60);
    expect(m.taken, 51);
    expect(m.prnUses, 8);
  });

  test('self-keep is not a delivery to a clinic', () {
    final clinic = DeliveryEvent(
      id: '1',
      caseId: 'c',
      recipient: DeliveryRecipient.clinic,
      method: DeliveryMethod.email,
      sentAt: DateTime.utc(2026, 10, 21),
    );
    final self = DeliveryEvent(
      id: '2',
      caseId: 'c',
      recipient: DeliveryRecipient.self,
      method: DeliveryMethod.email,
      sentAt: DateTime.utc(2026, 10, 21),
    );
    expect(clinic.countsAsDelivery, isTrue);
    expect(self.countsAsDelivery, isFalse);
  });

  test('demo cases keep fixed ordinals after a delete', () async {
    final store = DemoCaseStore();
    final before = await store.listCases();
    expect(before.map((c) => c.row.displayOrdinal).toSet(), {1, 2, 3});
    await store.deleteCase(before.first.row.id);
    final after = await store.listCases();
    expect(after.length, 2);
    expect(after.every((c) => c.row.displayOrdinal != null), isTrue);
    expect(after.map((c) => c.row.displayOrdinal).toSet().length, 2);
  });

  test('follow-up after clinic delivery is waiting for review', () async {
    final l = AppLocalizationsEn();
    final store = DemoCaseStore();
    final row = (await store.listCases()).first.row;
    final text = caseFollowUp(l, row, [
      DeliveryEvent(
        id: 'd',
        caseId: row.id,
        recipient: DeliveryRecipient.clinic,
        method: DeliveryMethod.email,
        sentAt: DateTime.utc(2026, 10, 21),
      ),
    ]);
    expect(text, l.cnStatusWaitingClinic);
  });
}
