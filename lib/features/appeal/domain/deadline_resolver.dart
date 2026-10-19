import 'appeal_models.dart';

DateTime dateOnlyUtc(DateTime value) =>
    DateTime.utc(value.year, value.month, value.day);

/// Calendar-day difference. Negative means the date is already past.
/// This is not a statement about whether a filing would be accepted.
int calendarDaysUntil(DateTime today, DateTime deadline) {
  final start = dateOnlyUtc(today);
  final end = dateOnlyUtc(deadline);
  return end.difference(start).inDays;
}

DeadlineOutcome resolveDeadline(
  DeadlineInput input, {
  required bool userConfirmedDate,
}) {
  if (input.kind == DeadlineKind.ambiguous ||
      input.multipleDeadlinesConflict ||
      input.durationUnit == 'business_day') {
    return const DeadlineOutcome(
      display: DeadlineDisplay.notCalculable,
      date: null,
      mayShowCountdown: false,
    );
  }

  if (input.kind == DeadlineKind.explicitDate && input.explicitDate != null) {
    final date = dateOnlyUtc(input.explicitDate!);
    return DeadlineOutcome(
      display: DeadlineDisplay.documentDate,
      date: date,
      mayShowCountdown: userConfirmedDate,
    );
  }

  if (input.kind == DeadlineKind.relative) {
    if (input.receivedDate == null) {
      return const DeadlineOutcome(
        display: DeadlineDisplay.needsReceivedDate,
        date: null,
        mayShowCountdown: false,
      );
    }
    final calendar = input.durationUnit == 'calendar_day' &&
        input.durationValue != null &&
        input.anchorType == 'received_date';
    if (!calendar) {
      return const DeadlineOutcome(
        display: DeadlineDisplay.notCalculable,
        date: null,
        mayShowCountdown: false,
      );
    }
    final date = dateOnlyUtc(
      input.receivedDate!,
    ).add(Duration(days: input.durationValue!));
    return DeadlineOutcome(
      display: DeadlineDisplay.calculatedFromReceived,
      date: date,
      mayShowCountdown: userConfirmedDate,
    );
  }

  return const DeadlineOutcome(
    display: DeadlineDisplay.notFound,
    date: null,
    mayShowCountdown: false,
  );
}
