import 'package:flutter/material.dart';
import '../../assessments/data/act_repository.dart';
import '../domain/patient_label.dart';
import '../domain/patient_log_report.dart';
import '../pdf/patient_log_pdf.dart';
import '../../../core/session/session_controller.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
import '../ui/app_chrome.dart';
import '../ui/brand.dart';
import '../ui/start_at_top.dart';
import 'preparation_strings.dart';
import '../../records/presentation/my_medications_screen.dart';
import 'treatment_record_summary.dart';
import 'environment_record_details.dart';
import 'air_weather_screen.dart';
import 'record_translation.dart';
import 'report_preview.dart';
import 'treatment_calendar.dart';
import 'quick_treatment_actions.dart';
import '../../records/data/records_revision.dart';

/// One account is one patient. Caregiver and patient entries are one log.
class CareProfileRecords extends StatefulWidget {
  const CareProfileRecords({super.key});
  @override
  State<CareProfileRecords> createState() => _CareProfileRecordsState();
}

class _CareProfileRecordsState extends State<CareProfileRecords> {
  final _repo = PreparationRepository();
  Map<String, String>? _profiles;
  List<TreatmentEvent> _events = [];
  String? _error, _owner;
  DateTime _day = DateTime.now();
  bool _exporting = false;
  String get _accountId => _owner ?? _repo.uid;

  String _displayName() => patientLabel(
    _profiles?[_accountId] ?? SessionScope.of(context).profile?.fullName,
  );

  List<TreatmentEvent> _asOnePatient(List<TreatmentEvent> events) => [
    for (final e in events)
      if (sameAccount(e.patientKey, _accountId))
        e.patientKey == _accountId
            ? e
            : TreatmentEvent.fromJson({
                ...e.toJson(),
                'patient_key': _accountId,
              }),
  ];

  Future<void> _exportLog() async {
    if (_exporting || _profiles == null) return;
    final patient = _accountId;
    final name = _displayName();
    final end = _repo.today;
    setState(() => _exporting = true);
    try {
      final events = _asOnePatient(await _repo.events());
      Map<String, dynamic>? act;
      try {
        act = await ActRepository().latest();
      } catch (_) {
        /* Unavailable stays unknown. */
      }
      if (!mounted || _repo.uid != _owner) return;
      final bytes = await buildPatientLogPdf(
        PatientLogReport(
          patientKey: patient,
          patientName: name,
          end: end,
          events: events,
          actScore: (act?['total_score'] as num?)?.toInt(),
          actDay: act?['submitted_at'] == null
              ? null
              : dayKey(DateTime.parse(act!['submitted_at']).toLocal()),
        ),
      );
      if (!mounted || _repo.uid != _owner) return;
      setState(() => _exporting = false);
      await Navigator.push<void>(
        context,
        MaterialPageRoute(
          builder: (c) => Scaffold(
            appBar: CoverNoteAppBar(title: Text(s10(c, 'patientLogPdf'))),
            body: StartAtTop(
              builder: (scroll) => ListView(
                controller: scroll,
                primary: false,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                children: [
                  ReportPreview(
                    bytes: bytes,
                    fileName: 'covernote-patient-log-${dayKey(end)}.pdf',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(s10(context, 'error'))));
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  String _summary(TreatmentEvent e) =>
      patientText(treatmentRecordSummary(context, e));

  @override
  void initState() {
    super.initState();
    _owner = _repo.uid;
    RecordsRevision.instance.addListener(_load);
    _load();
  }

  @override
  void dispose() {
    RecordsRevision.instance.removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final profiles = await _repo.careProfiles();
      final events = await _repo.events();
      if (!mounted) return;
      if (_repo.uid != _owner) return;
      final owner = SessionScope.of(context).user?.id;
      if (owner != null) {
        profiles[owner] = patientLabel(
          SessionScope.of(context).profile?.fullName,
          fallback: s10(context, 'patient'),
        );
      }
      setState(() {
        _profiles = profiles;
        _events = events;
        _error = null;
      });
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (SessionScope.of(context).user?.id != _owner) {
      return Scaffold(
        appBar: CoverNoteAppBar(title: Text(s10(context, 'careRecords'))),
      );
    }
    final profiles = _profiles;
    return Scaffold(
      appBar: CoverNoteAppBar(
        title: Text(s10(context, 'timeline')),
        actions: [
          IconButton(
            tooltip: s10(context, 'patientLogPdf'),
            onPressed: _exporting || profiles == null ? null : _exportLog,
            icon: _exporting
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.picture_as_pdf_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: StartAtTop(
          builder: (scroll) {
            final account = profiles == null
                ? const <TreatmentEvent>[]
                : _asOnePatient(_events);
            final name = _displayName();
            return SingleChildScrollView(
              controller: scroll,
              primary: false,
              padding: EdgeInsets.fromLTRB(
                20,
                16,
                20,
                24 + MediaQuery.paddingOf(context).bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_error != null)
                    TextButton(onPressed: _load, child: Text(_error!)),
                  if (profiles == null && _error == null)
                    const Center(child: CircularProgressIndicator()),
                  if (profiles != null) ...[
                    Text(name, style: const TextStyle(color: CnColors.muted)),
                    const SizedBox(height: 16),
                    QuickTreatmentActions(
                      key: ValueKey(_accountId),
                      repository: _repo,
                      patientKey: _accountId,
                      patientName: name,
                      onSaved: () {
                        setState(() => _day = _repo.today);
                        _load();
                      },
                    ),
                    const SizedBox(height: 28),
                    TreatmentCalendar(
                      day: _day,
                      events: account,
                      patientKey: _accountId,
                      onSelected: (v) => setState(() => _day = v),
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        Chip(
                          avatar: const Icon(
                            Icons.medication,
                            color: Colors.teal,
                          ),
                          label: Text(s10(context, 'medicinePrompt')),
                        ),
                        Chip(
                          avatar: const Icon(
                            Icons.favorite,
                            color: Colors.deepOrange,
                          ),
                          label: Text(s10(context, 'symptomRecord')),
                        ),
                        Chip(
                          avatar: const Icon(Icons.air, color: Colors.indigo),
                          label: Text(s10(context, 'environmentDay')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      MaterialLocalizations.of(context).formatFullDate(_day),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    for (final e in account.where(
                      (e) => !e.undone && e.day == dayKey(_day),
                    ))
                      _RecordCard(
                        event: e,
                        caption: _caption(e),
                        body: _summary(e),
                        onTap: () => Navigator.push<void>(
                          context,
                          MaterialPageRoute(
                            builder: (c) => Scaffold(
                              appBar: CoverNoteAppBar(
                                title: Text(s10(c, 'details')),
                              ),
                              body: SafeArea(
                                child: StartAtTop(
                                  builder: (detail) => SingleChildScrollView(
                                    controller: detail,
                                    primary: false,
                                    padding: const EdgeInsets.all(24),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _summary(e),
                                          style: Theme.of(
                                            c,
                                          ).textTheme.titleLarge,
                                        ),
                                        const SizedBox(height: 16),
                                        if (e.kind == 'environment')
                                          EnvironmentRecordDetails(event: e)
                                        else ...[
                                          Text(
                                            s10(context, 'originalWords'),
                                            style: Theme.of(
                                              c,
                                            ).textTheme.labelLarge,
                                          ),
                                          const SizedBox(height: 8),
                                          SelectableText(
                                            patientText(
                                              '${e.text}\n\n${e.values['quote'] ?? ''}',
                                            ),
                                          ),
                                          RecordTranslation(
                                            key: ValueKey(
                                              '${e.id}:${Localizations.localeOf(c)}',
                                            ),
                                            eventId: e.id,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (!account.any((e) => !e.undone && e.day == dayKey(_day)))
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(s10(context, 'empty')),
                      ),
                    const SizedBox(height: 24),
                    const AirWeatherLink(),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: () => Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyMedicationsScreen(),
                        ),
                      ),
                      icon: const Icon(Icons.add_a_photo_outlined),
                      label: Text('${s10(context, 'medPhoto')} · $name'),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _caption(TreatmentEvent e) => switch (e.kind) {
    'environment' =>
      '${s10(context, 'environmentDay')}${e.synthetic ? ' · ${s10(context, 'envSample')}' : ''}',
    'medication_use' => s10(
      context,
      e.values['use_kind'] == 'scheduled' ? 'scheduled' : 'rescue',
    ),
    'symptom' => s10(context, 'symptom'),
    _ => s10(context, 'evidence'),
  };
}

class _RecordCard extends StatelessWidget {
  const _RecordCard({
    required this.event,
    required this.caption,
    required this.body,
    required this.onTap,
  });

  final TreatmentEvent event;
  final String caption;
  final String body;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tint = switch (event.kind) {
      'medication_use' => CnColors.teal,
      'symptom' => const Color(0xFFC2410C),
      'environment' => const Color(0xFF3B5BDB),
      _ => CnColors.muted,
    };
    final icon = switch (event.kind) {
      'medication_use' => Icons.medication_outlined,
      'symptom' => Icons.favorite_outline,
      'environment' => Icons.air,
      _ => Icons.notes_outlined,
    };
    return Card(
      margin: const EdgeInsets.only(top: 10),
      color: tint.withValues(alpha: 0.06),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: tint),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      caption,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: tint,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: const TextStyle(
                  fontSize: 17,
                  height: 1.35,
                  fontWeight: FontWeight.w600,
                  color: CnColors.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
