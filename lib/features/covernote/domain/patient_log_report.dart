import 'preparation.dart';
import 'record_snapshot.dart';

bool _inRange(DayRange range, String day) {
  final date = DateTime.tryParse(day);
  return date != null && dayKey(date) == day && range.contains(date);
}

/// Patient-scoped facts for the clinician-reviewed log format. Missing data
/// stays unknown; quick-use counts never become doses or adherence.
class PatientLogReport {
  PatientLogReport({
    required this.patientKey,
    required this.patientName,
    required DateTime end,
    required List<TreatmentEvent> events,
    this.dob,
    this.controller,
    this.actScore,
    this.actDay,
    this.scheduledDoses,
    this.loggedDoses,
    this.sample = false,
  }) : range = DayRange.lastDays(end, 30),
       events = {
         for (final e in events)
           if (!e.undone &&
               e.patientKey == patientKey &&
               _inRange(DayRange.lastDays(end, 30), e.day))
             e.id: e,
       }.values.toList();
  final String patientKey, patientName;
  final String? dob, controller, actDay;
  final int? actScore, scheduledDoses, loggedDoses;
  final bool sample;
  final DayRange range;
  final List<TreatmentEvent> events;
  bool get isSample => sample || events.any((e) => e.synthetic);
  List<TreatmentEvent> get symptoms => events
      .where((e) => e.kind == 'symptom' && e.values['negated'] != true)
      .toList();
  List<TreatmentEvent> get rescue => events
      .where(
        (e) =>
            e.kind == 'medication_use' && e.values['use_kind'] == 'as_needed',
      )
      .toList();
  bool get sabaConfirmed =>
      rescue.isNotEmpty &&
      rescue.every((e) => e.values['medication_class'] == 'SABA');
  Set<String> get observedDays => events
      .where((e) => ['symptom', 'medication_use'].contains(e.kind))
      .map((e) => e.day)
      .toSet();
  String get act =>
      actScore != null &&
          actScore! >= 5 &&
          actScore! <= 25 &&
          actDay != null &&
          _inRange(range, actDay!)
      ? '$actScore / 25 (recorded $actDay)'
      : 'Not recorded in this period';
  String get frequency {
    final days = symptoms
        .where((e) => e.values['time_of_day'] == 'daytime')
        .map((e) => e.day)
        .toSet();
    if (days.isEmpty) {
      return 'Daytime not specified; ${symptoms.map((e) => e.day).toSet().length} symptom days logged';
    }
    return '${days.length} daytime symptom days / 30 days; ${(days.length * 7 / 30).toStringAsFixed(1)} days/week logged';
  }

  String get night {
    final known = symptoms.where((e) => e.values['night_wakings'] is num);
    final missing = symptoms
        .where(
          (e) =>
              e.values['symptom'] == 'night_waking' &&
              e.values['night_wakings'] is! num,
        )
        .length;
    if (known.isEmpty && missing == 0) return 'Not recorded';
    final count = known.fold<num>(
      0,
      (n, e) => n + (e.values['night_wakings'] as num),
    );
    return '$count reported awakenings${missing == 0 ? '' : '; $missing reports without a count'}';
  }

  String useText(List<TreatmentEvent> uses) {
    if (uses.isEmpty) return 'No use recorded';
    final counted = uses
        .where(
          (e) =>
              e.values['quantity'] is num &&
              ['puff', 'puffs'].contains(e.values['unit']) &&
              (e.values['quantity'] as num) > 0,
        )
        .toList();
    final total = counted.fold<num>(
      0,
      (n, e) => n + (e.values['quantity'] as num),
    );
    return '${counted.isEmpty ? 'Puff count unknown' : '$total puffs logged'} (${uses.length} instances)${counted.length == uses.length ? '' : '; ${uses.length - counted.length} without puff count'}';
  }

  String get adherence {
    if (scheduledDoses == null ||
        scheduledDoses! <= 0 ||
        loggedDoses == null ||
        loggedDoses! < 0 ||
        loggedDoses! > scheduledDoses!) {
      final uses = events
          .where(
            (e) =>
                e.kind == 'medication_use' &&
                e.values['use_kind'] == 'scheduled',
          )
          .length;
      return 'Not calculable: no verified dose schedule; $uses scheduled-use entries';
    }
    return '${(100 * loggedDoses! / scheduledDoses!).toStringAsFixed(0)}% ($loggedDoses / $scheduledDoses doses logged)';
  }

  /// Excludes forecasts and narrative scenarios without numeric observations.
  Map<String, num> get aqi {
    final result = <String, num>{};
    for (final e in events.where((e) => e.kind == 'environment')) {
      final v = e.values;
      if (v['source_kind'] == 'forecast') continue;
      final value = v['metric'] == 'aqi' ? v['value'] : v['aqi'];
      if (value is num &&
          value >= 0 &&
          value <= 500 &&
          (result[e.day] == null || result[e.day]! < value)) {
        result[e.day] = value;
      }
    }
    return result;
  }

  Map<String, String> get pollen {
    const ranks = {'Low': 1, 'Moderate': 2, 'High': 3, 'Very High': 4};
    final result = <String, String>{};
    for (final e in events.where((e) => e.kind == 'environment')) {
      if (e.values['source_kind'] == 'forecast') continue;
      final value = e.values['pollen_level'];
      if (value is String &&
          ranks.containsKey(value) &&
          (ranks[value]! > (ranks[result[e.day]] ?? 0))) {
        result[e.day] = value;
      }
    }
    return result;
  }

  Set<String> get highDays => {
    ...aqi.entries.where((e) => e.value > 100).map((e) => e.key),
    ...pollen.entries
        .where((e) => ['High', 'Very High'].contains(e.value))
        .map((e) => e.key),
  };
  String get exposureUses {
    if (rescue.isEmpty) return 'No as-needed use recorded';
    final matched = rescue.where((e) => highDays.contains(e.day)).length;
    final unknown = rescue
        .where(
          (e) =>
              !highDays.contains(e.day) &&
              (!aqi.containsKey(e.day) || !pollen.containsKey(e.day)),
        )
        .length;
    return '$matched out of ${rescue.length} instances (${(matched * 100 / rescue.length).toStringAsFixed(0)}%)${unknown > 0 ? '; $unknown with incomplete environmental data' : ''}';
  }

  List<List<String>> get incidents {
    final last14 = DayRange.lastDays(range.to, 14);
    final days =
        {
            ...rescue.map((e) => e.day),
            ...symptoms.map((e) => e.day),
          }.where((d) => last14.contains(DateTime.parse(d))).toList()
          ..sort((a, b) => b.compareTo(a));
    return [
      for (final day in days)
        [
          day,
          useText(rescue.where((e) => e.day == day).toList()),
          '${aqi[day] ?? 'Not recorded'}',
          pollen[day] ?? 'Not recorded',
          symptoms
                  .where((e) => e.day == day)
                  .map(symptomLabel)
                  .toSet()
                  .join('; ')
                  .isEmpty
              ? 'None recorded'
              : symptoms
                    .where((e) => e.day == day)
                    .map(symptomLabel)
                    .toSet()
                    .join('; '),
        ],
    ];
  }

  static String symptomLabel(TreatmentEvent e) => switch (e.values['symptom']) {
    'cough' => 'Coughing',
    'wheeze' => 'Wheezing',
    'short_breath' => 'Shortness of breath',
    'chest_tightness' => 'Chest tightness',
    'night_waking' =>
      'Night awakening${e.values['night_wakings'] is num ? ' (${e.values['night_wakings']})' : ''}',
    'activity_limited' => 'Activity limited',
    _ => 'Other symptom (see original record)',
  };
}
