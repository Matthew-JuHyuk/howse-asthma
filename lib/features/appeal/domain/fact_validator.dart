import 'appeal_models.dart';

class FactValidationException implements Exception {
  FactValidationException(this.code);
  final String code;
}

void validateCaseFacts(AppealCase item) {
  final extracted = <FactValue>[
    if (item.patientName.status == FactStatus.extracted) item.patientName,
    if (item.medicationRaw.status == FactStatus.extracted) item.medicationRaw,
    if (item.doseRaw.status == FactStatus.extracted) item.doseRaw,
    if (item.memberId.status == FactStatus.extracted) item.memberId,
    if (item.caseReference.status == FactStatus.extracted) item.caseReference,
  ];

  for (final field in extracted) {
    _requireQuotes(item, field.sourceRefs);
    if (field.rawText != field.normalizedValue) {
      throw FactValidationException('value_rewritten');
    }
  }

  final reason = item.denialReason;
  if (reason != null) {
    _requireQuotes(item, reason.sourceRefs);
  }
  if (item.deadline.sourceRefs.isNotEmpty &&
      item.deadline.kind != DeadlineKind.unknown) {
    _requireQuotes(item, item.deadline.sourceRefs);
  }

  _sameText(item.medicationRaw);
  _sameText(item.doseRaw);
}

void _sameText(FactValue field) {
  if (field.rawText != field.normalizedValue) {
    throw FactValidationException('medication_or_dose_changed');
  }
}

void _requireQuotes(AppealCase item, List<SourceRef> refs) {
  if (refs.isEmpty) {
    throw FactValidationException('missing_source');
  }
  for (final ref in refs) {
    if (ref.pageId != item.pageId) {
      throw FactValidationException('bad_page');
    }
    if (ref.quote.isEmpty || !item.pageText.contains(ref.quote)) {
      throw FactValidationException('quote_missing');
    }
  }
}
