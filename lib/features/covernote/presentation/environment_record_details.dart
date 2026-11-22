import 'package:flutter/material.dart';
import '../domain/preparation.dart';
import 'preparation_strings.dart';

class EnvironmentRecordDetails extends StatelessWidget {
  const EnvironmentRecordDetails({super.key, required this.event});
  final TreatmentEvent event;

  @override
  Widget build(BuildContext context) {
    final v = event.values;
    String? time(Object? raw) {
      final parsed = DateTime.tryParse('$raw');
      if (parsed == null) return null;
      final local = parsed.toLocal();
      final l = MaterialLocalizations.of(context);
      return '${l.formatMediumDate(local)} ${l.formatTimeOfDay(TimeOfDay.fromDateTime(local))}';
    }

    final fields = <String, Object?>{
      'envReading': v['value'] == null
          ? null
          : '${v['value']} ${v['unit'] ?? ''}',
      'envSource': v['provider'],
      'envArea': v['location_label'] ?? v['spatial_scope'],
      'envTime': time(v['observed_at']),
      'envFetched': time(v['fetched_at']),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (event.synthetic) Text(s10(context, 'envSample')),
        if (v['source_kind'] == 'forecast') Text(s10(context, 'envForecast')),
        for (final entry in fields.entries)
          if (entry.value != null && '${entry.value}'.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text('${s10(context, entry.key)}: ${entry.value}'),
            ),
        Text(s10(context, 'envContext')),
        if (v['metric'] == 'outdoor_humidity') ...[
          const SizedBox(height: 12),
          Text(s10(context, 'envHumidityBands')),
        ],
      ],
    );
  }
}
