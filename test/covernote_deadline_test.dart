import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/domain/case_facts.dart';

CaseFacts facts({
  List<Map<String, Object?>> deadlines = const [],
  Map<String, Object?> state = const {},
  String? noticeDate,
}) => CaseFacts.fromJson({
  'schema_version': factsSchemaVersion,
  'source': 'ai',
  'document_kind': {
    'value': 'initial_drug_denial',
    'status': 'extracted',
    'page': 1,
  },
  'fields': {
    if (noticeDate != null)
      'notice_date': {'value': noticeDate, 'status': 'extracted', 'page': 1},
  },
  'reasons': const [],
  'requested_items': const [],
  'deadlines': deadlines,
  'deadline_state': state,
  'pages': const [
    {'page_number': 1, 'legibility': 'clear'},
  ],
  'warnings': const [],
});

Map<String, Object?> relative(int days, String unit, String anchor) => {
  'purpose': 'review_request',
  'kind': 'relative',
  'duration_value': days,
  'duration_unit': unit,
  'anchor': anchor,
  'raw_text': 'within $days days',
  'status': 'extracted',
  'page': 1,
};

void main() {
  group('resolveDeadline', () {
    test('no review deadline in the letter', () {
      expect(resolveDeadline(facts()).state, DeadlineResolution.none);
    });

    test('an explicit date is used as written', () {
      final d = resolveDeadline(
        facts(
          deadlines: [
            {
              'purpose': 'review_request',
              'kind': 'explicit_date',
              'date': '2026-11-14',
              'status': 'extracted',
              'page': 1,
            },
          ],
        ),
      );
      expect(d.state, DeadlineResolution.date);
      expect(d.basis, 'letter');
      expect(d.date, DateTime(2026, 11, 14));
    });

    test('calendar days after receipt wait for the received date', () {
      final f = facts(
        deadlines: [relative(30, 'calendar_day', 'received_date')],
      );
      expect(resolveDeadline(f).state, DeadlineResolution.needsReceivedDate);

      final withDate = facts(
        deadlines: [relative(30, 'calendar_day', 'received_date')],
        state: {'received_date': '2026-10-20', 'received_date_source': 'user'},
      );
      final d = resolveDeadline(withDate);
      expect(d.state, DeadlineResolution.date);
      expect(d.basis, 'calculated');
      expect(d.date, DateTime(2026, 11, 19));
    });

    test('calendar days from the notice date cross a month boundary', () {
      final d = resolveDeadline(
        facts(
          deadlines: [relative(60, 'calendar_day', 'notice_date')],
          noticeDate: '2026-12-15',
        ),
      );
      expect(d.state, DeadlineResolution.date);
      expect(d.date, DateTime(2027, 2, 13));
    });

    test('business days are never estimated', () {
      final d = resolveDeadline(
        facts(
          deadlines: [relative(10, 'business_day', 'received_date')],
          state: {'received_date': '2026-10-20'},
        ),
      );
      expect(d.state, DeadlineResolution.needsReview);
      expect(d.date, isNull);
    });

    test('two different dates are a conflict, never a pick', () {
      final d = resolveDeadline(
        facts(
          deadlines: [
            {
              'purpose': 'review_request',
              'kind': 'explicit_date',
              'date': '2026-11-14',
              'status': 'extracted',
            },
            {
              'purpose': 'review_request',
              'kind': 'explicit_date',
              'date': '2026-11-20',
              'status': 'extracted',
            },
          ],
          state: {'conflict': true},
        ),
      );
      expect(d.state, DeadlineResolution.conflict);
      expect(d.date, isNull);
      expect(d.candidates, hasLength(2));
    });

    test('a date the user chose wins and is labeled as theirs', () {
      final d = resolveDeadline(
        facts(
          deadlines: [relative(10, 'business_day', 'received_date')],
          state: {'user_date': '2026-11-03', 'confirmed': true},
        ),
      );
      expect(d.state, DeadlineResolution.date);
      expect(d.basis, 'user');
      expect(d.date, DateTime(2026, 11, 3));
    });

    test('an information response date stays separate from review', () {
      final d = resolveDeadline(
        facts(
          deadlines: [
            {
              'purpose': 'information_response',
              'kind': 'explicit_date',
              'date': '2026-10-30',
              'status': 'extracted',
            },
          ],
        ),
      );
      expect(d.state, DeadlineResolution.none);
      expect(d.infoResponseDate, DateTime(2026, 10, 30));
    });

    test('an invalid calendar date is not accepted', () {
      expect(parseIsoDate('2026-02-30'), isNull);
      expect(parseIsoDate('11/14/2026'), isNull);
    });
  });

  group('facts', () {
    test('editing a value marks it as entered by the user', () {
      const f = Fact(
        value: 'DemoController A 100 mcg',
        page: 1,
        quote: 'Requested medication: DemoController A 100 mcg',
        status: FactStatus.extracted,
      );
      final same = f.edited('DemoController A 100 mcg');
      expect(same.status, FactStatus.extracted);
      expect(same.confirmed, isTrue);

      final changed = f.edited('DemoController A 200 mcg');
      expect(changed.status, FactStatus.userEntered);
      expect(changed.value, 'DemoController A 200 mcg');
      expect(changed.confirmed, isTrue);
    });

    test('evidence stays locked until key facts and the date are checked', () {
      var f = CaseFacts.fromJson({
        'document_kind': {
          'value': 'initial_drug_denial',
          'status': 'extracted',
        },
        'fields': {
          'medication': {'value': 'X 1 mg', 'status': 'extracted'},
        },
        'deadlines': [
          {
            'purpose': 'review_request',
            'kind': 'explicit_date',
            'date': '2026-11-14',
            'status': 'extracted',
          },
        ],
      });
      expect(f.readyForEvidence, isFalse);
      expect(f.factsToConfirm, 3);

      f = f
          .withField('medication', f.field('medication').confirm())
          .copyWith(
            documentKind: f.documentKind.confirm(),
            deadlineState: f.deadlineState.copyWith(confirmed: true),
          );
      expect(f.factsToConfirm, 0);
      expect(f.readyForEvidence, isTrue);
    });

    test('JSON round trip keeps the schema and user choices', () {
      final f = facts(
        deadlines: [relative(30, 'calendar_day', 'received_date')],
        state: {'received_date': '2026-10-20', 'confirmed': true},
      );
      final back = CaseFacts.fromJson(f.toJson());
      expect(back.toJson()['schema_version'], factsSchemaVersion);
      expect(back.deadlineState.receivedDate, '2026-10-20');
      expect(back.deadlineState.confirmed, isTrue);
      expect(back.deadlines.single.durationUnit, 'calendar_day');
    });
  });
}
