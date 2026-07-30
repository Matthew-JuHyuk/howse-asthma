import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';

/// Compact 7-day adherence strip from `inhaler_events` (W3-8 / S3-HOME-01).
class AdherenceWeekStrip extends StatelessWidget {
  const AdherenceWeekStrip({
    super.key,
    required this.events,
    this.days = 7,
  });

  final List<Map<String, dynamic>> events;
  final int days;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final counted = <DateTime, int>{};
    for (final e in events) {
      final raw = e['recorded_at'] as String?;
      final at = raw == null ? null : DateTime.tryParse(raw)?.toLocal();
      if (at == null) continue;
      final day = DateTime(at.year, at.month, at.day);
      counted[day] = (counted[day] ?? 0) + 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(days, (i) {
            final day = today.subtract(Duration(days: days - 1 - i));
            final n = counted[day] ?? 0;
            final filled = n > 0;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  children: [
                    Text(
                      _weekday(l10n, day.weekday),
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.neutral400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AspectRatio(
                      aspectRatio: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: filled
                              ? AppTheme.brand600
                              : AppTheme.neutral100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            filled ? '$n' : '',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: filled
                                  ? Colors.white
                                  : AppTheme.neutral400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.adherenceWeekHint,
          style: const TextStyle(fontSize: 12, color: AppTheme.subtext),
        ),
      ],
    );
  }

  String _weekday(AppLocalizations l10n, int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return l10n.weekdayMonShort;
      case DateTime.tuesday:
        return l10n.weekdayTueShort;
      case DateTime.wednesday:
        return l10n.weekdayWedShort;
      case DateTime.thursday:
        return l10n.weekdayThuShort;
      case DateTime.friday:
        return l10n.weekdayFriShort;
      case DateTime.saturday:
        return l10n.weekdaySatShort;
      default:
        return l10n.weekdaySunShort;
    }
  }
}
