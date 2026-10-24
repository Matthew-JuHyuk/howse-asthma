import 'package:flutter/material.dart';
import '../../../core/session/session_controller.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
import '../ui/app_chrome.dart';
import 'preparation_strings.dart';
import '../../records/presentation/my_medications_screen.dart';
import '../../../l10n/app_localizations.dart';
import 'air_weather_screen.dart';
import 'record_translation.dart';
import 'treatment_calendar.dart';
import '../../records/data/records_revision.dart';

/// One owner, explicitly selected care subject. Never merges sibling records.
class CareProfileRecords extends StatefulWidget {
  const CareProfileRecords({super.key});
  @override
  State<CareProfileRecords> createState() => _CareProfileRecordsState();
}

class _CareProfileRecordsState extends State<CareProfileRecords> {
  final _repo = PreparationRepository();
  Map<String, String>? _profiles;
  List<TreatmentEvent> _events = [];
  String? _selected, _error, _owner;
  DateTime _day = DateTime.now();
  String _summary(TreatmentEvent e) {
    final l = AppLocalizations.of(context)!;
    if (e.kind == 'symptom') {
      final label = switch (e.values['symptom']) {
        'cough' => l.s5SymCough,
        'wheeze' => l.s5SymWheeze,
        'short_breath' => l.s5SymShortBreath,
        'night_waking' => l.s5SymNightWaking,
        'activity_limited' => l.s5SymActivityLimited,
        _ => s10(context, 'symptom'),
      };
      return '${e.values['negated'] == true ? '− ' : ''}$label${e.values['night_wakings'] == null ? '' : ' · ${s10(context, 'night')}: ${e.values['night_wakings']}'}';
    }
    if (e.kind == 'medication_use') {
      return '${e.values['medication'] ?? s10(context, 'unknown')}${e.values['quantity'] == null ? '' : ' · ${e.values['quantity']} ${e.values['unit'] ?? ''}'}';
    }
    return e.kind == 'environment'
        ? s10(context, e.values['category'] ?? 'environmentDay')
        : s10(context, 'details');
  }

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
        profiles.putIfAbsent(
          owner,
          () =>
              SessionScope.of(context).profile?.fullName ??
              s10(context, 'patient'),
        );
      }
      setState(() {
        _profiles = profiles;
        _events = events;
        _selected ??=
            profiles.keys.where((key) => key != _owner).firstOrNull ??
            profiles.keys.firstOrNull;
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
      appBar: CoverNoteAppBar(title: Text(s10(context, 'timeline'))),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            20,
            16,
            20,
            24 + MediaQuery.paddingOf(context).bottom,
          ),
          children: [
            if (_error != null)
              TextButton(onPressed: _load, child: Text(_error!)),
            if (profiles == null && _error == null)
              const Center(child: CircularProgressIndicator()),
            if (profiles != null && profiles.isNotEmpty)
              DropdownButtonFormField<String>(
                initialValue: _selected,
                isExpanded: true,
                items: [
                  for (final p in profiles.entries)
                    DropdownMenuItem(value: p.key, child: Text(p.value)),
                ],
                onChanged: (v) => setState(() => _selected = v),
              ),
            if (profiles != null) ...[
              const SizedBox(height: 12),
              TreatmentCalendar(
                day: _day,
                events: _events,
                patientKey: _selected,
                onSelected: (v) => setState(() => _day = v),
              ),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.medication, color: Colors.teal),
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
              const SizedBox(height: 12),
              Text(
                MaterialLocalizations.of(context).formatFullDate(_day),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              for (final e in _events.where(
                (e) =>
                    !e.undone &&
                    e.patientKey == _selected &&
                    e.day == dayKey(_day),
              ))
                Card(
                  child: ListTile(
                    titleTextStyle: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                    subtitleTextStyle: Theme.of(context).textTheme.bodyMedium,
                    tileColor: e.kind == 'medication_use'
                        ? Colors.teal.withValues(alpha: .06)
                        : e.kind == 'symptom'
                        ? Colors.orange.withValues(alpha: .07)
                        : Colors.indigo.withValues(alpha: .05),
                    leading: Icon(switch (e.kind) {
                      'medication_use' => Icons.medication_outlined,
                      'symptom' => Icons.favorite_outline,
                      'environment' => Icons.air,
                      _ => Icons.description_outlined,
                    }),
                    title: Text(
                      e.kind == 'environment'
                          ? s10(context, 'environmentDay')
                          : e.kind == 'medication_use'
                          ? s10(
                              context,
                              e.values['use_kind'] == 'scheduled'
                                  ? 'scheduled'
                                  : 'rescue',
                            )
                          : e.kind == 'symptom'
                          ? s10(context, 'symptom')
                          : s10(context, 'evidence'),
                    ),
                    subtitle: Text(
                      e.kind == 'environment'
                          ? '${s10(context, e.values['category'] ?? 'details')}${e.synthetic ? ' · SAMPLE' : ''}'
                          : _summary(e),
                    ),
                    onTap: () => Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (c) => Scaffold(
                          appBar: CoverNoteAppBar(
                            title: Text(s10(c, 'details')),
                          ),
                          body: SafeArea(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _summary(e),
                                    style: Theme.of(c).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    s10(context, 'originalWords'),
                                    style: Theme.of(c).textTheme.labelLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  SelectableText(
                                    '${e.text}\n\n${e.values['quote'] ?? ''}',
                                  ),
                                  RecordTranslation(
                                    key: ValueKey(
                                      '${e.id}:${Localizations.localeOf(c)}',
                                    ),
                                    eventId: e.id,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if (!_events.any(
                (e) =>
                    !e.undone &&
                    e.patientKey == _selected &&
                    e.day == dayKey(_day),
              ))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(s10(context, 'empty')),
                ),
              const AirWeatherLink(),
              TextButton.icon(
                onPressed: () => Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MyMedicationsScreen(),
                  ),
                ),
                icon: const Icon(Icons.add_a_photo_outlined),
                label: Text(
                  '${s10(context, 'medPhoto')} · ${SessionScope.of(context).profile?.fullName ?? ''}',
                ),
              ),
            ],
            if (profiles != null &&
                !_events.any((e) => !e.undone && e.patientKey == _selected))
              Text(s10(context, 'empty')),
          ],
        ),
      ),
    );
  }
}
