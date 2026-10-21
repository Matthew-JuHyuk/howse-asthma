// Unit tests for supabase/functions/analyze-letter/validate.ts (pure module).
// Run: node tool/test_validate.mjs
import assert from 'node:assert/strict';
import { test } from 'node:test';

import {
  datesInText,
  findQuotePage,
  responsibleFor,
  validateExtraction,
} from '../supabase/functions/analyze-letter/validate.ts';

const page1 = `SYNTHETIC TEST DOCUMENT
Notice of coverage denial
Notice date: October 15, 2026
Member: Alex Sample
Member ID: DEMO-TEST-1001
Reference: TEST-1001
Requested medication: DemoController A 100 mcg
Dose as submitted: 2 puffs twice daily
The request did not include the medication history and recent visit notes requested by this fictional plan.
Your written request for review must reach this fictional plan by November 14, 2026.`;

function f(value, quote, page = 1) {
  return { value, quote, page };
}

function baseRaw(over = {}) {
  return {
    document_kind: 'initial_drug_denial',
    document_kind_quote: 'Notice of coverage denial',
    document_kind_page: 1,
    fields: {
      patient_name: f('Alex Sample', 'Member: Alex Sample'),
      plan_name: f(null, null, null),
      member_id: f('DEMO-TEST-1001', 'Member ID: DEMO-TEST-1001'),
      case_reference: f('TEST-1001', 'Reference: TEST-1001'),
      medication: f('DemoController A 100 mcg', 'Requested medication: DemoController A 100 mcg'),
      dose: f('2 puffs twice daily', 'Dose as submitted: 2 puffs twice daily'),
      notice_date: f('2026-10-15', 'Notice date: October 15, 2026'),
      contact: f(null, null, null),
      submission_route: f(null, null, null),
    },
    reasons: [{
      text: 'Medication history and recent visit notes were not included.',
      code: 'missing_information',
      quote: 'The request did not include the medication history and recent visit notes',
      page: 1,
    }],
    requested_items: [
      { label: 'Medication history', quote: 'medication history', page: 1 },
      { label: 'Recent visit notes', quote: 'recent visit notes', page: 1 },
    ],
    deadlines: [{
      purpose: 'review_request', kind: 'explicit_date', date: '2026-11-14',
      duration_value: null, duration_unit: null, anchor: null,
      quote: 'must reach this fictional plan by November 14, 2026', page: 1,
    }],
    received_date_stated: null,
    ...over,
  };
}

const pages = [{ page_number: 1, text: page1, legibility: 'clear' }];

test('dates in several printed formats', () => {
  assert.deepEqual(datesInText('by November 14, 2026.'), ['2026-11-14']);
  assert.deepEqual(datesInText('on 11/02/2026'), ['2026-11-02']);
  assert.deepEqual(datesInText('2026-12-01'), ['2026-12-01']);
  assert.deepEqual(datesInText('Feb 30, 2026'), []);
});

test('quote search ignores case, spacing and curly quotes', () => {
  assert.equal(findQuotePage('member:   alex sample', pages, null), 1);
  assert.equal(findQuotePage('Not on the page', pages, 1), null);
});

test('clean letter: grounded values are extracted', () => {
  const facts = validateExtraction(baseRaw(), pages);
  assert.equal(facts.fields.medication.status, 'extracted');
  assert.equal(facts.fields.medication.value, 'DemoController A 100 mcg');
  assert.equal(facts.fields.notice_date.status, 'extracted');
  assert.equal(facts.fields.plan_name.status, 'missing');
  assert.equal(facts.deadlines[0].status, 'extracted');
  assert.equal(facts.deadline_state.conflict, false);
  assert.equal(facts.requested_items.length, 2);
  assert.equal(facts.document_kind.status, 'extracted');
});

test('a "corrected" medication name that is not printed is not accepted', () => {
  const raw = baseRaw();
  raw.fields.medication = f('DemoController-A 100mcg', 'Requested medication: DemoController A 100 mcg');
  const facts = validateExtraction(raw, pages);
  assert.equal(facts.fields.medication.status, 'ambiguous');
  assert.equal(facts.fields.medication.validation, 'value_not_verbatim');
});

test('invented quote is downgraded, not trusted', () => {
  const raw = baseRaw();
  raw.fields.patient_name = f('Jamie Other', 'Member: Jamie Other');
  const facts = validateExtraction(raw, pages);
  assert.equal(facts.fields.patient_name.status, 'ambiguous');
  assert.equal(facts.fields.patient_name.quote, null);
});

test('date value that does not match its quote is ambiguous', () => {
  const raw = baseRaw();
  raw.deadlines[0].date = '2026-11-15';
  const facts = validateExtraction(raw, pages);
  assert.equal(facts.deadlines[0].status, 'ambiguous');
  assert.equal(facts.deadlines[0].validation, 'date_not_in_quote');
});

test('two different review deadlines are a conflict and neither is chosen', () => {
  const p2 = { page_number: 2, text: 'The deadline printed on this continuation page is December 1, 2026.', legibility: 'clear' };
  const p1 = { page_number: 1, text: 'The deadline printed in this section is November 16, 2026. Recent visit notes were not included with the request.', legibility: 'clear' };
  const raw = baseRaw({
    fields: { ...baseRaw().fields, medication: f(null, null, null), dose: f(null, null, null), patient_name: f(null, null, null), member_id: f(null, null, null), case_reference: f(null, null, null), notice_date: f(null, null, null) },
    reasons: [{ text: 'Recent visit notes were not included', code: 'missing_information', quote: 'Recent visit notes were not included with the request.', page: 1 }],
    requested_items: [],
    deadlines: [
      { purpose: 'review_request', kind: 'explicit_date', date: '2026-11-16', duration_value: null, duration_unit: null, anchor: null, quote: 'The deadline printed in this section is November 16, 2026.', page: 1 },
      { purpose: 'review_request', kind: 'explicit_date', date: '2026-12-01', duration_value: null, duration_unit: null, anchor: null, quote: 'The deadline printed on this continuation page is December 1, 2026.', page: 2 },
    ],
  });
  const facts = validateExtraction(raw, [p1, p2]);
  assert.equal(facts.deadline_state.conflict, true);
  assert.ok(facts.deadlines.every((d) => d.status === 'ambiguous'));
  assert.ok(facts.warnings.includes('deadline_conflict'));
});

test('relative deadline keeps terms and no computed date', () => {
  const text = 'You may request review within 30 calendar days after you receive this notice. The date you received this notice is not recorded here.';
  const raw = baseRaw({
    deadlines: [{ purpose: 'review_request', kind: 'relative', date: '2026-11-15', duration_value: 30, duration_unit: 'calendar_day', anchor: 'received_date', quote: 'within 30 calendar days after you receive this notice', page: 1 }],
  });
  const facts = validateExtraction(raw, [{ page_number: 1, text, legibility: 'clear' }]);
  assert.equal(facts.deadlines[0].date, null);
  assert.equal(facts.deadlines[0].status, 'extracted');
  assert.equal(facts.deadline_state.received_date, null);
});

test('information-response date is not a review deadline', () => {
  const text = 'Please provide the requested information by November 2, 2026. This is an information-response date, not an appeal deadline.';
  const raw = baseRaw({
    document_kind: 'additional_information_request',
    document_kind_quote: 'Please provide the requested information',
    deadlines: [{ purpose: 'information_response', kind: 'explicit_date', date: '2026-11-02', duration_value: null, duration_unit: null, anchor: null, quote: 'Please provide the requested information by November 2, 2026.', page: 1 }],
  });
  const facts = validateExtraction(raw, [{ page_number: 1, text, legibility: 'clear' }]);
  assert.equal(facts.deadline_state.conflict, false);
  assert.equal(facts.deadlines[0].purpose, 'information_response');
});

test('unknown enum values fall back safely', () => {
  const raw = baseRaw({ document_kind: 'approved_by_ai' });
  const facts = validateExtraction(raw, pages);
  assert.equal(facts.document_kind.value, 'uncertain');
  assert.equal(facts.document_kind.status, 'ambiguous');
});

test('unreadable page is reported', () => {
  const facts = validateExtraction(baseRaw(), [{ page_number: 1, text: page1, legibility: 'partly_unreadable' }]);
  assert.ok(facts.warnings.includes('page_partly_unreadable:1'));
});

test('checklist owner hints', () => {
  assert.equal(responsibleFor('Recent visit notes'), 'care_team');
  assert.equal(responsibleFor('Medication history'), 'patient');
  assert.equal(responsibleFor('Something else'), 'unknown');
});
