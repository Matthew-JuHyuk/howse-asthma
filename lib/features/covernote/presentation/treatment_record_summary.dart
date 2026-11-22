import 'package:flutter/widgets.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/preparation.dart';
import '../domain/environment_summary.dart';
import 'preparation_strings.dart';

String treatmentRecordSummary(BuildContext context, TreatmentEvent e) {
  final v = e.values;
  String? text(Object? value) =>
      value is String && value.trim().isNotEmpty ? value.trim() : null;
  String original() =>
      text(v['quote']) ??
      text(v['english_summary']) ??
      text(e.text) ??
      s10(context, 'recordSaved');
  if (e.kind == 'medication_use') {
    final name = text(v['medication']);
    final label =
        name ??
        s10(context, switch (v['use_kind']) {
          'scheduled' => 'scheduled',
          'as_needed' => 'rescue',
          _ => 'medicinePrompt',
        });
    final number = v['quantity'];
    final unit = text(v['unit']);
    final amount = number is num && number > 0
        ? '${number == number.roundToDouble() ? number.toInt() : number}${unit == null ? '' : ' ${['puff', 'puffs'].contains(unit) ? s10(context, 'puffUnit') : unit}'}'
        : null;
    return '${v['negated'] == true ? '${s10(context, 'notUsed')} · ' : ''}$label${amount == null ? '' : ' · $amount'}';
  }
  if (e.kind == 'symptom') {
    final l = AppLocalizations.of(context)!;
    final label = switch (v['symptom']) {
      'cough' => l.s5SymCough,
      'wheeze' => l.s5SymWheeze,
      'short_breath' => l.s5SymShortBreath,
      'night_waking' => l.s5SymNightWaking,
      'activity_limited' => l.s5SymActivityLimited,
      _ => original(),
    };
    final night = v['night_wakings'];
    return '${v['negated'] == true ? '− ' : ''}$label${night is num && night > 0 ? ' · ${s10(context, 'night')}: $night' : ''}';
  }
  if (e.kind == 'environment') {
    if (v.containsKey('metric') || v.containsKey('value')) {
      final summary = s10(context, environmentSummaryKey(v));
      return v['source_kind'] == 'forecast'
          ? '${s10(context, 'envForecast')} · $summary'
          : summary;
    }
    if ([
      'traffic_air',
      'humid_after_rain',
      'pollen',
      'calm',
    ].contains(v['category'])) {
      return s10(context, v['category']);
    }
  }
  return original();
}
