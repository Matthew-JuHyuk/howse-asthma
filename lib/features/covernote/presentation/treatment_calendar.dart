import 'package:flutter/material.dart';
import '../domain/preparation.dart';
import '../ui/brand.dart';

class TreatmentCalendar extends StatelessWidget {
  const TreatmentCalendar({
    super.key,
    required this.day,
    required this.events,
    required this.patientKey,
    required this.onSelected,
  });
  final DateTime day;
  final List<TreatmentEvent> events;
  final String? patientKey;
  final ValueChanged<DateTime> onSelected;
  @override
  Widget build(BuildContext context) {
    final first = DateTime(day.year, day.month);
    final offset = first.weekday % 7;
    final count = DateTime(day.year, day.month + 1, 0).day;
    final l = MaterialLocalizations.of(context);
    final now = DateTime.now();
    return CnCard(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                tooltip: l.previousMonthTooltip,
                onPressed: () =>
                    onSelected(DateTime(first.year, first.month - 1)),
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  l.formatMonthYear(first),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              IconButton(
                tooltip: l.nextMonthTooltip,
                onPressed:
                    DateTime(
                      first.year,
                      first.month + 1,
                    ).isAfter(DateTime.now())
                    ? null
                    : () => onSelected(DateTime(first.year, first.month + 1)),
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          Row(
            children: [
              for (final name in l.narrowWeekdays)
                Expanded(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: CnColors.muted,
                    ),
                  ),
                ),
            ],
          ),
          // No nested ScrollPosition: tapping a day must not scroll a grid
          // inside the page. Six fixed rows also keep month changes stable.
          Column(
            children: [
              for (var week = 0; week < 6; week++)
                Row(
                  children: [
                    for (var weekday = 0; weekday < 7; weekday++)
                      Expanded(
                        child: SizedBox(
                          height: 72,
                          child: Builder(
                            builder: (context) {
                              final index = week * 7 + weekday;
                              if (index < offset || index >= offset + count) {
                                return const SizedBox.shrink();
                              }
                              final date = DateTime(
                                first.year,
                                first.month,
                                index - offset + 1,
                              );
                              final recorded = events.any(
                                (e) =>
                                    !e.undone &&
                                    e.patientKey == patientKey &&
                                    e.day == dayKey(date) &&
                                    e.kind != 'environment' &&
                                    e.kind != 'clinical_document',
                              );
                              final selected = dayKey(date) == dayKey(day);
                              final isToday = dayKey(date) == dayKey(now);
                              final future = date.isAfter(
                                DateTime(now.year, now.month, now.day),
                              );
                              return Semantics(
                                selected: selected,
                                label: l.formatFullDate(date),
                                child: InkWell(
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  onTap: future ? null : () => onSelected(date),
                                  child: Container(
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      color: selected ? CnColors.teal : null,
                                      borderRadius: BorderRadius.circular(14),
                                      border: !selected && isToday
                                          ? Border.all(
                                              color: CnColors.teal,
                                              width: 1.5,
                                            )
                                          : null,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            '${date.day}',
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontWeight: selected || isToday
                                                  ? FontWeight.w700
                                                  : FontWeight.w500,
                                              color: selected
                                                  ? Colors.white
                                                  : future
                                                  ? CnColors.muted.withValues(
                                                      alpha: 0.45,
                                                    )
                                                  : CnColors.ink,
                                            ),
                                          ),
                                        ),
                                        if (recorded ||
                                            events.any(
                                              (e) =>
                                                  !e.undone &&
                                                  e.patientKey == patientKey &&
                                                  e.day == dayKey(date) &&
                                                  e.kind == 'environment',
                                            ))
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            spacing: 2,
                                            children: [
                                              for (final item in [
                                                (
                                                  'medication_use',
                                                  Icons.medication,
                                                  selected
                                                      ? Colors.white
                                                      : CnColors.teal,
                                                ),
                                                (
                                                  'symptom',
                                                  Icons.favorite,
                                                  selected
                                                      ? const Color(0xFFFFE0CC)
                                                      : const Color(0xFFC2410C),
                                                ),
                                                (
                                                  'environment',
                                                  Icons.air,
                                                  selected
                                                      ? const Color(0xFFD6E4FF)
                                                      : const Color(0xFF3B5BDB),
                                                ),
                                              ])
                                                if (events.any(
                                                  (e) =>
                                                      !e.undone &&
                                                      e.patientKey ==
                                                          patientKey &&
                                                      e.day == dayKey(date) &&
                                                      e.kind == item.$1,
                                                ))
                                                  Icon(
                                                    item.$2,
                                                    size: 12,
                                                    color: item.$3,
                                                  ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
