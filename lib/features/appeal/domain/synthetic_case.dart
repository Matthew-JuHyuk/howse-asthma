import 'appeal_models.dart';
import 'fact_validator.dart';

const sampleExplicitPageId = 'sample-page-1';

const sampleExplicitLetter = '''
SAMPLE — NOT A REAL INSURANCE NOTICE

Notice date: 2026-03-03
This sample is for demonstration only. It is not a real patient or a real plan.

Patient name: Alex Sample
Member ID: SMP-0000
Case reference: CASE-SAMPLE-1001
Plan name: Sample Commercial PPO

Requested medication: SampleMed
Dose: 10 mg daily

Decision: coverage for this request is denied.

Denial reason: The request did not include the clinical information we asked for.

Appeal instructions: You may ask this sample plan to review the decision. This sample has no real address.

Document deadline: 2026-04-02

Contact phone: 555-0100
''';

const sampleEobPageId = 'sample-eob-1';

const sampleEobText = '''
SAMPLE — NOT A REAL BILL
This is an explanation of benefits, not a coverage decision letter.
Amount billed: 0
This sample does not start an appeal.
''';

FactValue _extracted(String pageId, String quote) {
  return FactValue(
    rawText: quote,
    normalizedValue: quote,
    status: FactStatus.extracted,
    sourceRefs: [SourceRef(pageId: pageId, quote: quote)],
    confirmedByUser: false,
  );
}

FactValue _missing() {
  return const FactValue(
    rawText: null,
    normalizedValue: null,
    status: FactStatus.missing,
    sourceRefs: [],
    confirmedByUser: false,
  );
}

AppealCase explicitDateSample({DateTime? createdAt}) {
  final item = AppealCase(
    id: 'case-sample-explicit',
    shortId: 'sample1001',
    demoMode: true,
    fixtureId: 'explicit-date',
    documentKind: DocumentKind.initialDrugDenial,
    pageId: sampleExplicitPageId,
    pageText: sampleExplicitLetter,
    patientName: _extracted(sampleExplicitPageId, 'Alex Sample'),
    medicationRaw: _extracted(sampleExplicitPageId, 'SampleMed'),
    doseRaw: _extracted(sampleExplicitPageId, '10 mg daily'),
    denialReason: DenialReason(
      rawText:
          'The request did not include the clinical information we asked for.',
      code: DenialReasonCode.missingInformation,
      sourceRefs: [
        SourceRef(
          pageId: sampleExplicitPageId,
          quote:
              'The request did not include the clinical information we asked for.',
        ),
      ],
      confirmedByUser: false,
    ),
    memberId: _extracted(sampleExplicitPageId, 'SMP-0000'),
    caseReference: _extracted(sampleExplicitPageId, 'CASE-SAMPLE-1001'),
    deadline: DeadlineInput(
      rawText: '2026-04-02',
      kind: DeadlineKind.explicitDate,
      explicitDate: DateTime.utc(2026, 4, 2),
      durationValue: null,
      durationUnit: null,
      anchorType: null,
      receivedDate: null,
      multipleDeadlinesConflict: false,
      sourceRefs: [
        SourceRef(pageId: sampleExplicitPageId, quote: '2026-04-02'),
      ],
    ),
    deadlineConfirmedByUser: false,
    coreReviewed: false,
    factRevision: 1,
    reviewVersion: 0,
    confirmedFactRevision: null,
    status: CaseStatus.needsReview,
    createdAt: createdAt ?? DateTime.utc(2026, 10, 18),
    selfReport: null,
    recordsLinked: false,
    generatedFactRevision: null,
    letterText: null,
    letterMode: null,
    sharedMarkedSubmitted: false,
  );
  validateCaseFacts(item);
  return item;
}

AppealCase eobSample() {
  return AppealCase(
    id: 'case-sample-eob',
    shortId: 'sampleeob',
    demoMode: true,
    fixtureId: 'eob',
    documentKind: DocumentKind.eobOrBill,
    pageId: sampleEobPageId,
    pageText: sampleEobText,
    patientName: _missing(),
    medicationRaw: _missing(),
    doseRaw: _missing(),
    denialReason: null,
    memberId: _missing(),
    caseReference: _missing(),
    deadline: const DeadlineInput(
      rawText: null,
      kind: DeadlineKind.unknown,
      explicitDate: null,
      durationValue: null,
      durationUnit: null,
      anchorType: null,
      receivedDate: null,
      multipleDeadlinesConflict: false,
      sourceRefs: [],
    ),
    deadlineConfirmedByUser: false,
    coreReviewed: false,
    factRevision: 1,
    reviewVersion: 0,
    confirmedFactRevision: null,
    status: CaseStatus.needsReview,
    createdAt: DateTime.utc(2026, 10, 18),
    selfReport: null,
    recordsLinked: false,
    generatedFactRevision: null,
    letterText: null,
    letterMode: null,
    sharedMarkedSubmitted: false,
  );
}

AppealCase relativeDeadlineSample({DateTime? receivedDate}) {
  const pageId = 'sample-relative-1';
  const page = '''
SAMPLE — NOT A REAL INSURANCE NOTICE
Patient name: Alex Sample
Requested medication: SampleMed
Dose: 10 mg daily
Denial reason: The request did not include the clinical information we asked for.
You have 30 calendar days after you receive this notice to ask for a review.
''';
  final item = AppealCase(
    id: 'case-sample-relative',
    shortId: 'samplerel',
    demoMode: true,
    fixtureId: 'relative',
    documentKind: DocumentKind.initialDrugDenial,
    pageId: pageId,
    pageText: page,
    patientName: _extracted(pageId, 'Alex Sample'),
    medicationRaw: _extracted(pageId, 'SampleMed'),
    doseRaw: _extracted(pageId, '10 mg daily'),
    denialReason: DenialReason(
      rawText:
          'The request did not include the clinical information we asked for.',
      code: DenialReasonCode.missingInformation,
      sourceRefs: [
        SourceRef(
          pageId: pageId,
          quote:
              'The request did not include the clinical information we asked for.',
        ),
      ],
      confirmedByUser: false,
    ),
    memberId: _missing(),
    caseReference: _missing(),
    deadline: DeadlineInput(
      rawText: '30 calendar days after you receive this notice',
      kind: DeadlineKind.relative,
      explicitDate: null,
      durationValue: 30,
      durationUnit: 'calendar_day',
      anchorType: 'received_date',
      receivedDate: receivedDate,
      multipleDeadlinesConflict: false,
      sourceRefs: [
        SourceRef(
          pageId: pageId,
          quote: '30 calendar days after you receive this notice',
        ),
      ],
    ),
    deadlineConfirmedByUser: false,
    coreReviewed: false,
    factRevision: 1,
    reviewVersion: 0,
    confirmedFactRevision: null,
    status: CaseStatus.needsReview,
    createdAt: DateTime.utc(2026, 10, 18),
    selfReport: null,
    recordsLinked: false,
    generatedFactRevision: null,
    letterText: null,
    letterMode: null,
    sharedMarkedSubmitted: false,
  );
  validateCaseFacts(item);
  return item;
}
