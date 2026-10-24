import 'package:flutter/material.dart';
import '../domain/preparation.dart';

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
    return Column(
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
              ),
            ),
            IconButton(
              tooltip: l.nextMonthTooltip,
              onPressed:
                  DateTime(first.year, first.month + 1).isAfter(DateTime.now())
                  ? null
                  : () => onSelected(DateTime(first.year, first.month + 1)),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        Row(
          children: [
            for (final name in l.narrowWeekdays)
              Expanded(child: Text(name, textAlign: TextAlign.center)),
          ],
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: offset + count,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 72,
          ),
          itemBuilder: (context, index) {
            if (index < offset) return const SizedBox.shrink();
            final date = DateTime(first.year, first.month, index - offset + 1);
            final recorded = events.any(
              (e) =>
                  !e.undone &&
                  e.patientKey == patientKey &&
                  e.day == dayKey(date) &&
                  e.kind != 'environment' &&
                  e.kind != 'clinical_document',
            );
            final selected = dayKey(date) == dayKey(day);
            return Semantics(
              selected: selected,
              label: l.formatFullDate(date),
              child: InkWell(
                onTap: date.isAfter(DateTime.now())
                    ? null
                    : () => onSelected(date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : null,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('${date.day}', maxLines: 1, softWrap: false),
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
                              ('medication_use', Icons.medication, Colors.teal),
                              ('symptom', Icons.favorite, Colors.deepOrange),
                              ('environment', Icons.air, Colors.indigo),
                            ])
                              if (events.any(
                                (e) =>
                                    !e.undone &&
                                    e.patientKey == patientKey &&
                                    e.day == dayKey(date) &&
                                    e.kind == item.$1,
                              ))
                                Icon(item.$2, size: 12, color: item.$3),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
