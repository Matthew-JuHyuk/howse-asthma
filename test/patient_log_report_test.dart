import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/features/covernote/domain/preparation.dart';
import 'package:howse_asthma/features/covernote/domain/patient_log_report.dart';
import 'package:howse_asthma/features/covernote/pdf/patient_log_pdf.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  TreatmentEvent e(
    String id,
    String day, {
    String patient = 'p',
    String kind = 'medication_use',
    bool undone = false,
    Map<String, dynamic> values = const {'use_kind': 'as_needed'},
  }) => TreatmentEvent(
    id: id,
    patientKey: patient,
    kind: kind,
    day: day,
    sourceId: id,
    undone: undone,
    values: values,
  );
  test(
    '30 inclusive calendar days, owner isolation, undone and duplicate records',
    () {
      final r = PatientLogReport(
        patientKey: 'p',
        patientName: 'Patient',
        end: DateTime(2026, 9, 2),
        events: [
          e('before', '2026-08-03'),
          e('unknown', 'unknown'),
          e('start', '2026-08-04'),
          e('end', '2026-09-02'),
          e('future', '2026-09-03'),
          e('child', '2026-09-02', patient: 'p/child'),
          e('undone', '2026-09-02', undone: true),
          e('start', '2026-08-04'),
        ],
      );
      expect(r.range.dayCount, 30);
      expect(r.rescue.map((e) => e.id).toSet(), {'start', 'end'});
      expect(r.incidents.map((e) => e.first), ['2026-09-02']);
      expect(r.adherence, contains('Not calculable'));
      expect(r.useText(r.rescue), contains('Puff count unknown'));
      expect(r.act, contains('Not recorded'));
    },
  );
  test(
    'forecasts and qualitative scenario text do not turn into measured exposure',
    () {
      final r = PatientLogReport(
        patientKey: 'p',
        patientName: 'Patient',
        end: DateTime(2026, 9, 2),
        events: [
          e('use', '2026-09-02'),
          e(
            'forecast',
            '2026-09-02',
            kind: 'environment',
            values: {'metric': 'aqi', 'value': 180, 'source_kind': 'forecast'},
          ),
          e(
            'story',
            '2026-09-02',
            kind: 'environment',
            values: {'category': 'pollen'},
          ),
        ],
      );
      expect(r.aqi, isEmpty);
      expect(r.pollen, isEmpty);
      expect(r.exposureUses, contains('1 with incomplete'));
      expect(r.sabaConfirmed, isFalse);
    },
  );
  test(
    'sample template renders real PDF with calculated summary and recent rows',
    () async {
      final j = jsonDecode(
        File('test/fixtures/patient_log_sample.json').readAsStringSync(),
      );
      final r = PatientLogReport(
        patientKey: j['patient_key'],
        patientName: j['patient_name'],
        end: DateTime.parse(j['period_end']),
        events: [for (final x in j['events']) TreatmentEvent.fromJson(x)],
        dob: j['dob'],
        controller: j['controller'],
        actScore: j['act_score'],
        actDay: j['act_day'],
        scheduledDoses: j['scheduled_doses'],
        loggedDoses: j['logged_doses'],
        sample: true,
      );
      expect(r.adherence, '85% (51 / 60 doses logged)');
      expect(r.useText(r.rescue), '16 puffs logged (8 instances)');
      expect(r.aqi.values.where((v) => v > 100), hasLength(7));
      expect(r.pollen.values.where((v) => v == 'High'), hasLength(9));
      expect(r.exposureUses, '6 out of 8 instances (75%)');
      expect(r.night, '6 reported awakenings');
      final bytes = await buildPatientLogPdf(r);
      final file = File('output/pdf/covernote-patient-log-sample.pdf');
      file.parent.createSync(recursive: true);
      file.writeAsBytesSync(bytes);
      expect(ascii.decode(bytes.take(5).toList()), '%PDF-');
    },
  );
}
