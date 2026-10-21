import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/data/demo_case_store.dart';
import 'package:howse_asthma/features/covernote/domain/case_facts.dart';
import 'package:howse_asthma/features/covernote/domain/case_models.dart';
import 'package:howse_asthma/features/covernote/domain/record_snapshot.dart';
import 'package:howse_asthma/features/covernote/pdf/packet_pdf.dart';

PacketFonts loadFonts() {
  ByteData read(String name) =>
      ByteData.sublistView(File('assets/fonts/$name').readAsBytesSync());
  return PacketFonts.fromBytes(
    read('NotoSans-Regular.ttf'),
    read('NotoSans-Bold.ttf'),
  );
}

/// Font sizes from every `Tf` operator in the page content streams.
List<double> fontSizes(Uint8List pdf) {
  final text = latin1.decode(pdf);
  final sizes = <double>[];
  final start = RegExp(r'stream\r?\n');
  for (final m in start.allMatches(text)) {
    final end = text.indexOf('endstream', m.end);
    if (end < 0) continue;
    List<int> data = pdf.sublist(m.end, end);
    try {
      data = zlib.decode(data);
    } catch (_) {
      // Not compressed.
    }
    final body = latin1.decode(data, allowInvalid: true);
    for (final t in RegExp(r'/\S+\s+([\d.]+)\s+Tf').allMatches(body)) {
      sizes.add(double.parse(t[1]!));
    }
  }
  return sizes;
}

Future<PacketInput> demoInput(
  DemoCaseStore store,
  String id, {
  bool linkEvidence = true,
}) async {
  var d = await store.load(id);
  if (linkEvidence) {
    final range = DayRange.lastDays(store.today, 30);
    final snap = await store.loadSnapshots(range);
    final med = await store.attachEvidence(
      id,
      recordType: 'medication_summary',
      snapshot: snap.medication.toJson(),
      range: range,
      sourceType: 'synthetic',
    );
    await store.attachEvidence(
      id,
      recordType: 'local_context',
      snapshot: snap.localContext.toJson(),
      range: range,
      sourceType: 'synthetic',
    );
    await store.updateRequirement(
      id,
      d.requirements.first.copyWith(
        status: RequirementStatus.linked,
        linkedEvidenceId: med.id,
      ),
    );
    d = await store.load(id);
  }
  return PacketInput(
    caseRow: d.row,
    facts: d.facts!,
    requirements: d.requirements,
    evidence: d.evidence,
    generatedAt: DemoCaseStore.demoToday,
    letterPages: d.pages,
  );
}

void main() {
  final fonts = loadFonts();

  test('demo packet: one-page summary, then the review draft', () async {
    final store = DemoCaseStore();
    final input = await demoInput(store, 'demo-missing-info');
    expect(input.isSample, isTrue);

    final res = await buildPacketPdf(input, fonts);
    expect(res.includes, ['clinician_summary', 'review_request_draft']);
    expect(res.draftPages, greaterThanOrEqualTo(1));
    expect(res.pageCount, 1 + res.draftPages);
    expect(latin1.decode(res.bytes.sublist(0, 5)), '%PDF-');
  });

  test('no text is smaller than 10 pt', () async {
    final store = DemoCaseStore();
    final res = await buildPacketPdf(
      await demoInput(store, 'demo-step-therapy'),
      fonts,
    );
    final sizes = fontSizes(res.bytes);
    expect(sizes, isNotEmpty);
    expect(sizes.reduce((a, b) => a < b ? a : b), greaterThanOrEqualTo(10));
  });

  test(
    'long letters stay on one summary page; the rest goes to the appendix',
    () async {
      final store = DemoCaseStore();
      const id = 'demo-received-date';
      for (var i = 0; i < 10; i++) {
        await store.addRequirement(
          id,
          'Additional supporting document number $i requested by the plan, '
          'including chart notes, prior medication trials and clinician rationale',
        );
      }
      final base = await demoInput(store, id);
      final longReason = List.filled(
        12,
        'The plan says the record is incomplete.',
      ).join(' ');
      final facts = base.facts.copyWith(
        reasons: [
          for (var i = 0; i < 6; i++)
            ReasonFact(
              text: '$longReason ($i)',
              code: 'missing_information',
              page: 1,
              quote: longReason,
            ),
        ],
        deadlineState: base.facts.deadlineState.copyWith(
          receivedDate: '2026-10-19',
          confirmed: true,
        ),
      );
      final input = PacketInput(
        caseRow: base.caseRow,
        facts: facts,
        requirements: base.requirements,
        evidence: base.evidence,
        generatedAt: base.generatedAt,
        includeLetterText: true,
        letterPages: base.letterPages,
      );

      final res = await buildPacketPdf(input, fonts);
      expect(res.includes, contains('appendix_letter_details'));
      expect(res.includes, contains('appendix_letter_text'));
      expect(res.pageCount, greaterThan(1 + res.draftPages));
      expect(
        fontSizes(res.bytes).reduce((a, b) => a < b ? a : b),
        greaterThanOrEqualTo(10),
      );
    },
  );

  test('a final decision gets the summary only, no review draft', () async {
    final store = DemoCaseStore();
    final base = await demoInput(
      store,
      'demo-missing-info',
      linkEvidence: false,
    );
    final facts = base.facts.copyWith(
      documentKind: const Fact(
        value: 'final_appeal_denial',
        status: FactStatus.userEntered,
        confirmed: true,
      ),
    );
    final res = await buildPacketPdf(
      PacketInput(
        caseRow: base.caseRow,
        facts: facts,
        requirements: base.requirements,
        evidence: base.evidence,
        generatedAt: base.generatedAt,
      ),
      fonts,
    );
    expect(res.includes, isNot(contains('review_request_draft')));
    expect(res.draftPages, 0);
  });

  test('deadline text never invents a business-day date', () {
    final f = CaseFacts.fromJson({
      'deadlines': [
        {
          'purpose': 'review_request',
          'kind': 'relative',
          'duration_value': 10,
          'duration_unit': 'business_day',
          'anchor': 'received_date',
          'raw_text': 'within 10 business days of receipt',
          'status': 'extracted',
        },
      ],
      'deadline_state': {'received_date': '2026-10-19'},
    });
    final text = deadlineText(resolveDeadline(f));
    expect(text, contains('Confirm with the plan'));
    expect(text, isNot(contains('2026')));
  });

  test('a case with no records prints no counts and no local context', () async {
    final store = DemoCaseStore();
    final input = await demoInput(
      store,
      'demo-missing-info',
      linkEvidence: false,
    );
    expect(input.evidence, isEmpty);
    expect(recordRows(input), isNull);

    final res = await buildPacketPdf(input, fonts);
    expect(res.includes, ['clinician_summary', 'review_request_draft']);
    expect(res.pageCount, 1 + res.draftPages);
  });

  test('records table shows the denominator, PRN apart, unknown not missed', () async {
    final store = DemoCaseStore();
    final rows = recordRows(await demoInput(store, 'demo-missing-info'))!;
    final byLabel = {for (final r in rows.rows.skip(1)) r[0]: r[1]};
    expect(
      byLabel['Scheduled doses'],
      '51 taken / 3 not taken / 6 unknown of 60',
    );
    expect(byLabel['As-needed use'], '8 uses / 16 puffs');
    expect(
      rows.notes,
      contains('Unknown = no answer recorded; not counted as missed.'),
    );
  });

  test('editing a fact makes the packet stale; a late build stays stale', () async {
    final store = DemoCaseStore();
    const id = 'demo-missing-info';
    final input = await demoInput(store, id);
    final before = await store.load(id);
    final built = await buildPacketPdf(input, fonts);
    final first = await store.savePacket(
      id,
      built.bytes,
      factRevision: before.row.factRevision,
      evidenceRevision: before.row.evidenceRevision,
      includes: built.includes,
      isSample: true,
    );
    expect(first.status, 'ready');

    final f = before.facts!;
    await store.saveFacts(
      id,
      f.withField('dose', f.field('dose').edited('2 puffs once daily')),
      before.row.factRevision,
    );
    final after = await store.load(id);
    expect(after.artifacts.single.status, 'stale');

    final late = await store.savePacket(
      id,
      built.bytes,
      factRevision: before.row.factRevision,
      evidenceRevision: before.row.evidenceRevision,
      includes: built.includes,
      isSample: true,
    );
    expect(late.status, 'stale');

    final fresh = await store.savePacket(
      id,
      built.bytes,
      factRevision: after.row.factRevision,
      evidenceRevision: after.row.evidenceRevision,
      includes: built.includes,
      isSample: true,
    );
    expect(fresh.status, 'ready');
    final now = await store.load(id);
    expect(now.artifacts.where((a) => a.status == 'ready'), hasLength(1));
  });

  test('file name carries the date only', () {
    expect(
      packetFileName(DateTime(2026, 10, 20)),
      'covernote-packet-2026-10-20.pdf',
    );
  });
}
