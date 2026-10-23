import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/session/session_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../records/data/records_revision.dart';
import '../../records/data/symptom_repository.dart';
import '../auth/auth_screen.dart';
import '../data/case_store.dart';
import '../data/medication_use_repository.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
import '../domain/record_snapshot.dart';
import '../domain/s9_models.dart';
import '../domain/upload_guard.dart';
import '../pdf/preparation_pdf.dart';
import '../ui/app_chrome.dart';
import '../ui/brand.dart';
import 'preparation_strings.dart';

Future<void> startPreparation(BuildContext context) async {
  if (!await requireSignIn(context) || !context.mounted) return;
  await Navigator.push<void>(
    context,
    MaterialPageRoute(builder: (_) => const NewPreparationScreen()),
  );
}

Future<void> openPreparationDemo(BuildContext context, bool denied) async {
  final r = PreparationRepository(demo: true);
  final p = await r.seed(denied);
  if (context.mounted) {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => PreparationScreen(repository: r, caseId: p.id),
      ),
    );
  }
}

class NewPreparationScreen extends StatefulWidget {
  const NewPreparationScreen({super.key});
  @override
  State<NewPreparationScreen> createState() => _NewPreparationScreenState();
}

class _NewPreparationScreenState extends State<NewPreparationScreen> {
  String? _patientKey;
  Map<String, String> _profiles = {};
  bool _newSubject = false, _profilesLoaded = false;
  final _name = TextEditingController(),
      _concern = TextEditingController(),
      _current = TextEditingController(),
      _proposed = TextEditingController(),
      _plan = TextEditingController();
  bool _checked = false, _busy = false;
  String? _error;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_profilesLoaded) {
      _profilesLoaded = true;
      PreparationRepository()
          .careProfiles()
          .then((v) {
            if (mounted) setState(() => _profiles = v);
          })
          .catchError((Object _) {});
    }
    if (_name.text.isEmpty) {
      _name.text = SessionScope.of(context).profile?.fullName ?? '';
    }
  }

  @override
  void dispose() {
    for (final c in [_name, _concern, _current, _proposed, _plan]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _create() async {
    if (_name.text.trim().isEmpty || _concern.text.trim().isEmpty) return;
    setState(() => _busy = true);
    try {
      final repo = PreparationRepository();
      final p = await repo.create(
        patientKey: _patientKey,
        patientName: _name.text.trim(),
        concern: _concern.text.trim(),
        currentMedication: _current.text.trim(),
        proposedMedication: _proposed.text.trim(),
        plan: _plan.text.trim(),
        policyConfirmed: _checked,
      );
      if (mounted) {
        await Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (_) => PreparationScreen(repository: repo, caseId: p.id),
          ),
        );
      }
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'error'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CoverNoteAppBar(title: Text(s10(context, 'start'))),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (SessionScope.of(context).user?.id case final owner?)
          DropdownButtonFormField<String>(
            initialValue: _patientKey ?? owner,
            isExpanded: true,
            items: [
              DropdownMenuItem(
                value: owner,
                child: Text(
                  SessionScope.of(context).profile?.fullName ??
                      s10(context, 'patient'),
                ),
              ),
              for (final entry in _profiles.entries)
                if (entry.key != owner)
                  DropdownMenuItem(value: entry.key, child: Text(entry.value)),
            ],
            onChanged: (v) => setState(() {
              _patientKey = v;
              _newSubject = false;
              _name.text = v == owner
                  ? SessionScope.of(context).profile?.fullName ?? ''
                  : _profiles[v] ?? '';
            }),
          ),
        TextButton(
          onPressed: () {
            final owner = SessionScope.of(context).user?.id;
            if (owner == null) return;
            setState(() {
              _patientKey = '$owner/${preparationId()}';
              _profiles[_patientKey!] = s10(context, 'newProfile');
              _newSubject = true;
              _name.clear();
            });
          },
          child: Text(s10(context, 'newProfile')),
        ),
        Text(
          s10(context, 'intro'),
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        for (final pair in [
          ('patient', _name),
          ('concern', _concern),
          ('current', _current),
          ('proposed', _proposed),
          ('plan', _plan),
        ])
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              controller: pair.$2,
              readOnly:
                  pair.$1 == 'patient' && !_newSubject && _name.text.isNotEmpty,
              maxLength: pair.$1 == 'concern' ? 500 : 160,
              decoration: InputDecoration(
                labelText: s10(context, pair.$1),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        CheckboxListTile(
          value: _checked,
          onChanged: (v) => setState(() => _checked = v ?? false),
          title: Text(s10(context, 'policy')),
        ),
        Text(s10(context, 'review')),
        if (_error != null)
          Text(_error!, style: const TextStyle(color: Colors.red)),
        FilledButton(
          onPressed: _busy ? null : _create,
          child: Text(s10(context, 'create')),
        ),
      ],
    ),
  );
}

class PreparationScreen extends StatefulWidget {
  const PreparationScreen({
    super.key,
    required this.repository,
    required this.caseId,
    this.letterStore,
    this.voiceOnOpen = false,
  });
  final PreparationRepository repository;
  final String caseId;
  final CaseStore? letterStore;
  final bool voiceOnOpen;
  @override
  State<PreparationScreen> createState() => _PreparationScreenState();
}

class _PreparationScreenState extends State<PreparationScreen>
    with WidgetsBindingObserver {
  Preparation? _p;
  List<TreatmentEvent> _events = [];
  String? _error;
  bool _busy = false,
      _includeOriginal = false,
      _pending = false,
      _listening = false;
  int _tab = 0;
  bool _refreshingSources = false;
  bool _voiceOpened = false;
  Future<void> _refreshSources() async {
    if (_busy || _refreshingSources || _p == null) return;
    _refreshingSources = true;
    try {
      final events = await repo.events();
      if (mounted) {
        setState(
          () => _events = [
            ...events,
            ..._events.where(
              (e) =>
                  e.values['legacy'] == true &&
                  !events.any((n) => n.id == e.id),
            ),
          ],
        );
      }
    } catch (_) {
      /* Keep the visible snapshot and error state. */
    } finally {
      _refreshingSources = false;
    }
  }

  String _period = '30';
  PreparationRepository get repo => widget.repository;
  bool get _ownerMatches {
    final owner = SupabaseService.currentUser?.id;
    final key = _p?.patientKey;
    return repo.demo ||
        (owner != null &&
            key != null &&
            (key == owner || key.startsWith('$owner/')));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    RecordsRevision.instance.addListener(_refreshSources);
    _load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    RecordsRevision.instance.removeListener(_refreshSources);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_busy) _load();
  }

  Future<void> _load() async {
    try {
      var p = await repo.load(widget.caseId);
      if (p == null && widget.letterStore != null) {
        final d = await widget.letterStore!.load(widget.caseId);
        final f = d.facts;
        p = Preparation(
          id: widget.caseId,
          patientKey: repo.uid,
          patientName: f?.field('patient_name').value ?? 'Patient',
          path: ['initial_drug_denial', 'final_appeal_denial'].contains(f?.kind)
              ? PreparationPath.deniedRequest
              : PreparationPath.newRequest,
          currentMedication: f?.field('medication').value ?? '',
          plan: f?.field('plan_name').value ?? '',
          synthetic: repo.demo,
          concern: 'Review the notice with my care team.',
          needs: [
            for (final n in d.requirements)
              EvidenceNeed(
                id: n.id,
                label: n.label,
                reason:
                    n.sourceQuote ??
                    'Notice item; verify with the original letter.',
                origin: 'notice',
                owner: n.responsible,
                policyPage: n.sourcePage,
                quote: n.sourceQuote,
              ),
          ],
          history: [
            for (final dl in f?.deadlines ?? [])
              {
                'type': 'deadline',
                'purpose': dl.purpose,
                'date': dl.kind == 'explicit_date' ? dl.date : null,
                'text': dl.rawText ?? dl.quote ?? 'Date needs confirmation',
                'page': dl.page,
                'source': 'notice',
              },
            {
              'type': 'decision',
              'date': f?.field('notice_date').value ?? 'unknown',
              'text': f?.kind ?? 'Notice not yet reviewed',
              'source': 'notice',
            },
          ],
          documents: [
            for (final file in d.files)
              if (file.mime != 'text/plain')
                {
                  'path': file.objectPath,
                  'mime': file.mime,
                  'name': 'notice-${file.fileIndex}',
                  'kind': 'notice',
                },
          ],
        );
        p = await repo.save(p);
      }
      if (p == null) throw StateError('not_found');
      if (!repo.demo) {
        await _importNative();
        _pending = !await repo.flush();
      }
      final events = await repo.events();
      if (!repo.demo && !repo.offline && p.patientKey == repo.uid) {
        final range = DayRange.lastDays(repo.today, 365);
        final meds = await MedicationUseRepository().listBetween(range);
        final symptoms = await SymptomRepository().listBetween(
          range.from,
          range.to,
        );
        for (final m in meds) {
          if (events.any((e) => e.id == m.id) ||
              m.medicationName == null ||
              p.currentMedication.isEmpty ||
              !p.currentMedication.toLowerCase().contains(
                m.medicationName!.toLowerCase(),
              )) {
            continue;
          }
          events.add(
            TreatmentEvent(
              id: m.id,
              patientKey: repo.uid,
              kind: 'medication_use',
              day: dayKey(m.localDate),
              sourceId: m.id,
              text: m.medicationName ?? '',
              values: {
                'medication': m.medicationName,
                'quantity': m.quantity,
                'unit': m.unit,
                'use_kind': useKindSql(m.useKind),
                'legacy': true,
              },
            ),
          );
        }
        for (final s in symptoms) {
          if (events.any((e) => e.id == s.id)) continue;
          events.add(
            TreatmentEvent(
              id: s.id,
              patientKey: repo.uid,
              kind: 'symptom',
              day: dayKey(s.eventDate),
              sourceId: s.id,
              text: s.note ?? s.symptoms.join(', '),
              values: {
                'symptom': s.symptoms.join(', '),
                'negated': s.noSymptoms,
                'legacy': true,
              },
            ),
          );
        }
      }
      if (mounted) {
        setState(() {
          _p = p;
          _events = events;
          _error = null;
        });
        if (widget.voiceOnOpen && !_voiceOpened) {
          _voiceOpened = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _voice();
          });
        }
      }
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'error'));
    }
  }

  Future<void> _importNative() => repo.importDirectRecords();

  Future<void> _run(Future<void> Function() action) async {
    if (_busy) return;
    if (!repo.demo && _p != null && !_ownerMatches) {
      setState(() => _error = s10(context, 'error'));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'error'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _save(Preparation p) async {
    final saved = await repo.save(p);
    if (mounted) setState(() => _p = saved);
  }

  Future<void> _record(List<TreatmentEvent> events) async {
    final synced = await repo.record(events);
    if (mounted) {
      setState(() => _pending = !synced);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(s10(context, synced ? 'saved' : 'pending')),
          action: SnackBarAction(
            label: s10(context, 'undo'),
            onPressed: () => _run(() async {
              await repo.undo(events.first.sourceId);
              await _load();
            }),
          ),
        ),
      );
    }
    await _load();
  }

  Future<bool> _consent() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(s10(context, 'voice')),
        content: Text(s10(context, 'consent')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: Text(s10(c, 'cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, true),
            child: Text(s10(c, 'allow')),
          ),
        ],
      ),
    );
    if (ok != true) return false;
    if (!repo.demo) {
      try {
        await SupabaseService.client.from('consent_events').insert({
          'owner_id': repo.uid,
          'purpose': 'treatment_processing',
          'version': 's10-treatment-v1',
          'locale': mounted
              ? Localizations.localeOf(context).toLanguageTag()
              : 'en',
        });
      } catch (_) {
        if (mounted) setState(() => _error = s10(context, 'error'));
        return false;
      }
    }
    return true;
  }

  Future<void> _quick(String kind) async {
    final p = _p!;
    if (kind == 'scheduled' &&
        _events.any(
          (e) =>
              !e.undone &&
              e.kind == 'medication_use' &&
              e.day == dayKey(repo.today) &&
              e.values['use_kind'] == 'scheduled' &&
              e.values['medication'] == p.currentMedication,
        )) {
      final additional = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          content: Text(s10(c, 'additional')),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(s10(c, 'cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: Text(s10(c, 'confirm')),
            ),
          ],
        ),
      );
      if (additional != true) return;
    }
    if (!mounted) return;
    String? symptom;
    if (kind == 'symptom') {
      symptom = await showModalBottomSheet<String>(
        context: context,
        builder: (c) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final item in ['cough', 'night'])
                ListTile(
                  title: Text(s10(c, item)),
                  onTap: () => Navigator.pop(c, item),
                ),
            ],
          ),
        ),
      );
      if (symptom == null) return;
    }
    final source = preparationId();
    await _run(
      () => _record([
        TreatmentEvent(
          id: preparationId(),
          patientKey: p.patientKey,
          kind: kind == 'symptom' ? kind : 'medication_use',
          day: dayKey(repo.today),
          sourceId: source,
          synthetic: repo.demo,
          text: kind == 'symptom'
              ? (symptom == 'night'
                    ? 'Patient reported waking at night; count unknown.'
                    : 'Patient reported cough.')
              : 'Patient reported medicine use; quantity unknown.',
          values: {
            'input_path': 'quick',
            'occurred_at': repo.today.toUtc().toIso8601String(),
            'symptom': symptom == 'night' ? 'night_waking' : 'cough',
            'medication': kind != 'scheduled' || p.currentMedication.isEmpty
                ? null
                : p.currentMedication,
            'use_kind': kind == 'scheduled' ? 'scheduled' : 'as_needed',
            'quantity': null,
            'unit': null,
          },
        ),
      ]),
    );
  }

  Future<void> _voice({bool typed = false}) async {
    if (!await _consent() || !mounted) return;
    var transcript = '';
    if (!typed) {
      try {
        setState(() => _listening = true);
        transcript =
            await PreparationRepository.native.invokeMethod<String>('listen', {
              'language': Localizations.localeOf(context).toLanguageTag(),
            }) ??
            '';
      } catch (_) {
        if (mounted) setState(() => _error = s10(context, 'unknown'));
      } finally {
        if (mounted) setState(() => _listening = false);
      }
    }
    if (!mounted) return;
    final controller = TextEditingController(text: transcript);
    final text = await showDialog<String>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(s10(c, 'text')),
        content: TextField(
          controller: controller,
          maxLength: 1000,
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: Text(s10(c, 'cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(c, controller.text.trim()),
            child: Text(s10(c, 'confirm')),
          ),
        ],
      ),
    );
    if (text == null || text.isEmpty || !mounted) return;
    await _run(() async {
      final p = _p!;
      final result = await repo.analyze(
        action: 'structure_record',
        input: {
          'case_id': p.id,
          'transcript': text,
          'patient_name': p.patientName,
          'today': dayKey(repo.today),
          'timezone': repo.today.timeZoneOffset.inMinutes,
          'language': Localizations.localeOf(context).toLanguageTag(),
        },
      );
      final proposals = validateVoiceProposal(result['events'], text);
      if (!mounted) return;
      final chosen = await _confirmProposals(proposals, text);
      if (chosen == null || chosen.isEmpty) return;
      final source = preparationId();
      await _record([
        for (final v in chosen)
          TreatmentEvent(
            id: preparationId(),
            patientKey: p.patientKey,
            kind: v['kind'],
            day: v['day'],
            sourceId: source,
            text: text,
            values: {
              ...v,
              'language': mounted
                  ? Localizations.localeOf(context).toLanguageTag()
                  : 'unknown',
              'model': result['model'],
              'prompt_version': result['prompt_version'],
              'input_path': typed ? 'text' : 'voice',
            },
          ),
      ]);
    });
  }

  Future<Map<String, dynamic>?> _editProposal(Map<String, dynamic> v) async {
    final day = TextEditingController(text: v['day'] ?? dayKey(repo.today));
    final medication = TextEditingController(text: v['medication'] ?? '');
    final quantity = TextEditingController(
      text: v['quantity']?.toString() ?? '',
    );
    final night = TextEditingController(
      text: v['night_wakings']?.toString() ?? '',
    );
    final summary = TextEditingController(text: v['english_summary'] ?? '');
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(s10(c, 'confirm')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(v['quote'] ?? ''),
              TextField(
                controller: day,
                decoration: InputDecoration(labelText: s10(c, 'date')),
              ),
              TextField(
                controller: medication,
                decoration: InputDecoration(labelText: s10(c, 'current')),
              ),
              TextField(
                controller: quantity,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: s10(c, 'quantity')),
              ),
              TextField(
                controller: night,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: s10(c, 'nightCount')),
              ),
              TextField(
                controller: summary,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: s10(c, 'englishSummary'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: Text(s10(c, 'cancel')),
          ),
          FilledButton(
            onPressed: () {
              final d = DateTime.tryParse(day.text);
              final q = quantity.text.isEmpty
                  ? null
                  : double.tryParse(quantity.text);
              final n = night.text.isEmpty ? null : int.tryParse(night.text);
              if (d == null ||
                  dayKey(d) != day.text ||
                  d.isAfter(repo.today) ||
                  (quantity.text.isNotEmpty &&
                      (q == null || !q.isFinite || q <= 0)) ||
                  (night.text.isNotEmpty && (n == null || n < 0 || n > 100))) {
                return;
              }
              Navigator.pop(c, {
                ...v,
                'model_proposal':
                    v['model_proposal'] ?? Map<String, dynamic>.from(v),
                'day': day.text,
                'medication': medication.text.trim().isEmpty
                    ? null
                    : medication.text.trim(),
                'quantity': q,
                'night_wakings': n,
                'english_summary': summary.text,
                'user_edited': true,
              });
            },
            child: Text(s10(c, 'save')),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>?> _confirmProposals(
    List<Map<String, dynamic>> proposals,
    String text,
  ) async {
    final chosen = <int>{};
    final date = TextEditingController(text: dayKey(repo.today));
    var subject = false;
    return showDialog<List<Map<String, dynamic>>>(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, change) => AlertDialog(
          title: Text(s10(c, 'confirm')),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${_p!.patientName}\n$text'),
                  TextField(
                    controller: date,
                    decoration: InputDecoration(labelText: s10(c, 'date')),
                  ),
                  CheckboxListTile(
                    value: subject,
                    onChanged: (v) => change(() => subject = v ?? false),
                    title: Text(s10(c, 'patient')),
                  ),
                  for (var i = 0; i < proposals.length; i++)
                    CheckboxListTile(
                      secondary: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        tooltip: AppLocalizations.of(c)!.cnEdit,
                        onPressed: () async {
                          final edited = await _editProposal(proposals[i]);
                          if (edited != null && c.mounted) {
                            change(() => proposals[i] = edited);
                          }
                        },
                      ),
                      value: chosen.contains(i),
                      onChanged: proposals[i]['omit'] == true
                          ? null
                          : (v) => change(
                              () =>
                                  v == true ? chosen.add(i) : chosen.remove(i),
                            ),
                      title: Text('${proposals[i]['english_summary']}'),
                      subtitle: Text(
                        '${proposals[i]['quote']}\n${proposals[i]['day'] ?? s10(c, 'unknown')} | ${proposals[i]['uncertainty'] ?? ''}\n${proposals[i]['subject']} | ${proposals[i]['medication'] ?? s10(c, 'unknown')} | ${proposals[i]['quantity'] ?? s10(c, 'unknown')}',
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: Text(s10(c, 'cancel')),
            ),
            FilledButton(
              onPressed: !subject || chosen.isEmpty
                  ? null
                  : () {
                      final d = DateTime.tryParse(date.text);
                      if (d == null ||
                          dayKey(d) != date.text ||
                          d.isAfter(repo.today)) {
                        return;
                      }
                      if (chosen.any((i) {
                        final day = DateTime.tryParse(
                          proposals[i]['day'] ?? date.text,
                        );
                        return day == null || day.isAfter(repo.today);
                      })) {
                        return;
                      }
                      Navigator.pop(c, [
                        for (final i in chosen)
                          {
                            ...proposals[i],
                            'day': proposals[i]['day'] ?? date.text,
                            'subject_confirmed': true,
                          },
                      ]);
                    },
              child: Text(s10(c, 'confirm')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _link(EvidenceNeed n) async {
    final candidates = sourceCandidates(n, _p!, _events);
    final ids = n.links.toSet();
    final chosen = await showDialog<List<String>>(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, change) => AlertDialog(
          title: Text(n.label),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(n.reason),
                  if (candidates.isEmpty) Text(s10(c, 'missing')),
                  for (final e in candidates)
                    CheckboxListTile(
                      value: ids.contains(e.id),
                      onChanged: (v) => change(
                        () => v == true ? ids.add(e.id) : ids.remove(e.id),
                      ),
                      title: Text('${e.day} · ${e.text}'),
                      subtitle: Text('${e.kind} | ${e.id}'),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: Text(s10(c, 'cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, ids.toList()),
              child: Text(s10(c, 'save')),
            ),
          ],
        ),
      ),
    );
    if (chosen == null) return;
    await _run(
      () => _save(
        _p!.update({
          'needs': [
            for (final x in _p!.needs)
              (x.id == n.id ? x.link(chosen) : x).toJson(),
          ],
        }),
      ),
    );
  }

  Future<void> _source(TreatmentEvent e) async {
    await showDialog<void>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('${e.day} · ${e.kind}'),
        content: SingleChildScrollView(
          child: SelectableText(
            [
              e.text,
              if (e.values['english_summary'] != null)
                e.values['english_summary'] as String,
              if (e.values['quote'] != null)
                '${s10(c, 'source')}: ${e.values['quote']}',
              if (e.values['page'] != null) 'Page ${e.values['page']}',
              if (e.values['night_wakings'] != null)
                '${s10(c, 'nightCount')}: ${e.values['night_wakings']}',
              if (e.kind == 'medication_use')
                '${e.values['medication'] ?? s10(c, 'unknown')} · ${e.values['quantity'] ?? s10(c, 'unknown')} ${e.values['unit'] ?? ''}',
              if (e.values['uncertainty'] != null) '${e.values['uncertainty']}',
              if (e.values['provider'] != null)
                '${e.values['provider']} · ${e.values['observed_at'] ?? s10(c, 'unknown')}\n${e.values['location_label'] ?? ''} · ${e.values['source_kind'] ?? ''}',
              '${s10(c, 'source')}: ${e.sourceId}\nEvent: ${e.id}',
            ].join('\n\n'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: Text(AppLocalizations.of(c)!.cnDone),
          ),
        ],
      ),
    );
  }

  Future<void> _upload() async {
    try {
      await _uploadImpl();
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'error'));
    }
  }

  Future<void> _uploadImpl() async {
    if (!await _consent()) return;
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (files.isEmpty) return;
    final file = files.first;
    final bytes = await file.readAsBytes();
    if (bytes.length > 12 * 1024 * 1024) {
      throw StateError('too_large');
    }
    final mime = file.name.toLowerCase().endsWith('.pdf')
        ? 'application/pdf'
        : file.name.toLowerCase().endsWith('.png')
        ? 'image/png'
        : 'image/jpeg';
    if (!inspectUpload(
      bytes: bytes,
      mime: mime,
      existingCaseBytes: 0,
      existingPages: 0,
      limits: const UploadLimits(maxFileBytes: 12 * 1024 * 1024),
    ).accepted) {
      if (mounted) setState(() => _error = s10(context, 'error'));
      return;
    }
    await _run(() async {
      final p = _p!;
      final path = await repo.upload(
        p.id,
        file.name,
        mime,
        bytes,
        patientDocument: true,
      );
      // Keep the original accessible even when processing fails.
      await _save(
        p.update({
          'documents': [
            ...p.documents,
            {
              'path': path,
              'name': file.name,
              'mime': mime,
              'status': 'uploaded',
            },
          ],
        }),
      );
      final result = await repo.analyze(
        action: 'read_clinical_document',
        input: {'case_id': p.id, 'object_path': path, 'mime': mime},
      );
      if (!mounted) return;
      final ok = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text(s10(c, 'confirm')),
          content: SingleChildScrollView(
            child: SelectableText(
              '${s10(c, 'patient')}: ${p.patientName}\nDocument patient: ${result['patient_name'] ?? s10(c, 'unknown')}\n\n${result['summary']}\n\n${(result['items'] as List).map((x) => 'Page ${x['page']}: ${x['quote']}\n${x['date'] ?? 'Date unknown'} | ${x['value'] ?? ''} ${x['unit'] ?? ''}').join('\n\n')}',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: Text(s10(c, 'cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: Text(s10(c, 'confirm')),
            ),
          ],
        ),
      );
      if (ok != true) return;
      final source = preparationId();
      final items = result['items'] as List;
      final kind = result['document_kind'];
      final events = [
        for (final x in items.take(12))
          TreatmentEvent(
            id: preparationId(),
            patientKey: p.patientKey,
            kind: kind == 'urgent_visit' ? 'urgent_visit' : 'clinical_document',
            day: DateTime.tryParse(x['date'] ?? '') == null
                ? dayKey(repo.today)
                : x['date'],
            sourceId: source,
            text: x['english_summary'] ?? result['summary'],
            values: {
              ...Map<String, dynamic>.from(x),
              'document_kind': kind,
              'object_path': path,
              'mime': mime,
              'name': file.name,
              'patient_name': result['patient_name'],
              'date_unknown': x['date'] == null,
              'model': result['model'],
              'quote': x['quote'],
            },
          ),
      ];
      if (events.isNotEmpty) await _record(events);
      var next = _p!.update({
        'documents': [
          for (final d in _p!.documents)
            if (d['path'] == path)
              {...d, 'kind': kind, 'status': 'confirmed'}
            else
              d,
        ],
      });
      if (kind == 'notice') {
        next = next.update({
          'path':
              [
                'initial_drug_denial',
                'final_appeal_denial',
              ].contains(result['notice_kind'])
              ? 'deniedRequest'
              : next.path.name,
          'history': [
            ...next.history,
            for (final dl in result['deadlines'] ?? [])
              {
                'type': 'deadline',
                'purpose': dl['purpose'],
                'date': dl['date'],
                'text': dl['quote'],
                'page': dl['page'],
                'source': path,
              },
            {
              'type': result['notice_kind'] ?? 'notice',
              'date': dayKey(repo.today),
              'text': result['summary'],
              'source': path,
            },
          ],
          'needs': [
            ...next.needs.map((n) => n.toJson()),
            for (var i = 0; i < items.length; i++)
              EvidenceNeed(
                id: 'notice-$source-$i',
                label: items[i]['english_summary'],
                reason:
                    'Verify the notice and response process with the care team.',
                origin: 'notice',
                quote: items[i]['quote'],
                policyPage: items[i]['page'],
              ).toJson(),
          ],
        });
      }
      await _save(next);
    });
  }

  Future<void> _editPreparation() async {
    final p = _p!;
    final concern = TextEditingController(text: p.concern),
        current = TextEditingController(text: p.currentMedication),
        proposed = TextEditingController(text: p.proposedMedication),
        plan = TextEditingController(text: p.plan);
    var policy = p.policyConfirmed;
    final fields = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, change) => AlertDialog(
          title: Text(AppLocalizations.of(c)!.cnEdit),
          content: SizedBox(
            width: 520,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(p.patientName),
                  for (final pair in [
                    ('concern', concern),
                    ('current', current),
                    ('proposed', proposed),
                    ('plan', plan),
                  ])
                    TextField(
                      controller: pair.$2,
                      maxLength: pair.$1 == 'concern' ? 500 : 160,
                      decoration: InputDecoration(labelText: s10(c, pair.$1)),
                    ),
                  CheckboxListTile(
                    value: policy,
                    onChanged: (v) => change(() => policy = v ?? false),
                    title: Text(s10(c, 'policy')),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: Text(s10(c, 'cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, {
                'concern': concern.text.trim(),
                'current_medication': current.text.trim(),
                'proposed_medication': proposed.text.trim(),
                'plan': plan.text.trim(),
                'policy_confirmed': policy,
                'english_fields': <String, String>{},
              }),
              child: Text(s10(c, 'save')),
            ),
          ],
        ),
      ),
    );
    if (fields == null) return;
    await _run(() async {
      var next = p.update(fields);
      final defaults = preparationNeeds(next.applicablePolicy);
      next = next.update({
        'needs': [
          for (final n in defaults)
            n
                .link(
                  p.needs.where((x) => x.id == n.id).firstOrNull?.links ?? [],
                )
                .toJson(),
          ...p.needs.where((n) => n.origin == 'notice').map((n) => n.toJson()),
        ],
      });
      await _save(next);
    });
  }

  Future<void> _generate() async {
    await _run(() async {
      var p = _p!;
      if (!repo.demo &&
          Localizations.localeOf(context).languageCode != 'en' &&
          p.englishFields.isEmpty) {
        if (!await _consent() || !mounted) return;
        final translated = await repo.analyze(
          action: 'translate_preparation',
          input: {
            'case_id': p.id,
            'fields': {
              'concern': p.concern,
              'current_medication': p.currentMedication,
              'proposed_medication': p.proposedMedication,
            },
          },
        );
        if (!mounted) return;
        final fields = Map<String, String>.from(translated['fields']);
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            title: Text(s10(c, 'confirm')),
            content: SingleChildScrollView(
              child: SelectableText(
                '${p.concern}\n\n${fields['concern']}\n${fields['current_medication']}\n${fields['proposed_medication']}',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: Text(s10(c, 'cancel')),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(c, true),
                child: Text(s10(c, 'confirm')),
              ),
            ],
          ),
        );
        if (confirmed != true) return;
        await _save(p.update({'english_fields': fields}));
        p = _p!;
      }
      final originals = <OriginalAttachment>[];
      final originalFiles = {for (final d in p.documents) d['path']: d};
      final linkedIds = p.needs.expand((n) => n.links).toSet();
      for (final e in _events.where(
        (e) =>
            !e.undone &&
            e.patientKey == p.patientKey &&
            linkedIds.contains(e.id) &&
            e.values['object_path'] != null,
      )) {
        originalFiles[e.values['object_path']] = {
          'path': e.values['object_path'],
          'name': e.values['name'] ?? 'Source document',
          'mime': e.values['mime'] ?? 'application/pdf',
        };
      }
      if (_includeOriginal && !repo.demo) {
        for (final d in originalFiles.values) {
          originals.add(
            OriginalAttachment(
              d['name'],
              d['mime'],
              await repo.download(d['path']),
            ),
          );
        }
      }
      final bytes = await buildPreparationPdf(
        p,
        _events,
        repo.today,
        originals: originals,
      );
      String? path;
      if (!repo.demo) {
        path = await repo.upload(
          p.id,
          'brief-r${p.revision}.pdf',
          'application/pdf',
          bytes,
        );
      }
      await _save(
        p.update({
          'exports': [
            ...p.exports,
            {
              'revision': p.revision,
              'content_hash': preparationFingerprint(p, _events, repo.today),
              'generated_at': DateTime.now().toUtc().toIso8601String(),
              'path': path,
              'originals': originals.map((a) => a.name).toList(),
            },
          ],
        }),
      );
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'covernote-${p.path.name}-r${p.revision}.pdf',
      );
    });
  }

  Future<void> _handoff() async {
    var method = 'portal', recipient = 'clinic', type = 'delivery';
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => StatefulBuilder(
        builder: (c, change) => AlertDialog(
          title: Text(s10(c, 'delivery')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(s10(c, 'receipt')),
              DropdownButton<String>(
                value: type,
                isExpanded: true,
                items: [
                  for (final x in [
                    'delivery',
                    'submission_report',
                    'response_report',
                  ])
                    DropdownMenuItem(value: x, child: Text(x)),
                ],
                onChanged: (v) => change(() => type = v!),
              ),
              DropdownButton<String>(
                value: recipient,
                isExpanded: true,
                items: [
                  for (final x in ['clinic', 'insurer', 'other'])
                    DropdownMenuItem(value: x, child: Text(x)),
                ],
                onChanged: (v) => change(() => recipient = v!),
              ),
              DropdownButton<String>(
                value: method,
                isExpanded: true,
                items: [
                  for (final x in [
                    'email',
                    'message',
                    'portal',
                    'fax',
                    'mail',
                    'in_person',
                    'other',
                  ])
                    DropdownMenuItem(value: x, child: Text(x)),
                ],
                onChanged: (v) => change(() => method = v!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(c),
              child: Text(s10(c, 'cancel')),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(c, true),
              child: Text(s10(c, 'save')),
            ),
          ],
        ),
      ),
    );
    if (ok == true) {
      await _run(
        () => _save(
          _p!.update({
            'history': [
              ..._p!.history,
              {
                'type': type,
                'date': dayKey(repo.today),
                'text':
                    'User reported $type to $recipient by $method. Receipt not verified.',
                'destination_type': _p!.path == PreparationPath.deniedRequest
                    ? 'member_appeal_unconfirmed'
                    : 'initial_pharmacy_pa',
                'artifact_revision': _p!.exports.lastOrNull?['revision'],
              },
            ],
          }),
        ),
      );
    }
  }

  Future<void> _notification(bool enabled) async {
    await _run(() async {
      if (enabled) {
        final ok = await showDialog<bool>(
          context: context,
          builder: (c) => AlertDialog(
            content: Text(
              '${_p!.patientName}\n${_p!.currentMedication}\n\n${s10(c, 'notificationHint')}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: Text(s10(c, 'cancel')),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(c, true),
                child: Text(s10(c, 'confirm')),
              ),
            ],
          ),
        );
        if (ok != true) return;
      }
      if (!mounted) return;
      await PreparationRepository.native.invokeMethod('configure', {
        'owner': repo.uid,
        'patient_key': _p!.patientKey,
        'medication': _p!.currentMedication,
        'enabled': enabled,
        'title': s10(context, 'scheduled'),
        'action': s10(context, 'confirm'),
        'saved': s10(context, 'pending'),
        'undo': s10(context, 'undo'),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!repo.demo) SessionScope.of(context);
    final p = _p;
    if (!repo.demo && p != null && !_ownerMatches) {
      return Scaffold(
        appBar: CoverNoteAppBar(title: Text(s10(context, 'start'))),
        body: Center(child: Text(AppLocalizations.of(context)!.cnAuthSignIn)),
      );
    }
    return Scaffold(
      appBar: CoverNoteAppBar(
        title: Text(
          p?.patientName ?? s10(context, 'start'),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            icon: const Icon(Icons.home_outlined),
            tooltip: AppLocalizations.of(context)!.cnGoHome,
          ),
          if (p != null)
            IconButton(
              onPressed: _busy ? null : _editPreparation,
              icon: const Icon(Icons.edit_outlined),
              tooltip: AppLocalizations.of(context)!.cnEdit,
            ),
          if (p != null)
            PopupMenuButton<String>(
              onSelected: (v) => _run(() => _save(p.update({'lifecycle': v}))),
              itemBuilder: (_) => [
                for (final entry in [
                  ('active', AppLocalizations.of(context)!.cnReopenCase),
                  ('completed', AppLocalizations.of(context)!.cnCompleteCase),
                  ('archived', AppLocalizations.of(context)!.cnArchiveCase),
                ])
                  PopupMenuItem(value: entry.$1, child: Text(entry.$2)),
              ],
            ),
        ],
      ),
      body: p == null
          ? Center(
              child: _error != null
                  ? TextButton(onPressed: _load, child: Text(_error!))
                  : const CircularProgressIndicator(),
            )
          : Column(
              children: [
                if (p.synthetic)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      s10(context, 'demo'),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: CnColors.teal,
                      ),
                    ),
                  ),
                if (_busy) const LinearProgressIndicator(),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (_pending)
                  TextButton(
                    onPressed: () => _run(_load),
                    child: Text(
                      '${s10(context, 'pending')} · ${s10(context, 'retry')}',
                    ),
                  ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (var i = 0; i < 4; i++)
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ChoiceChip(
                            label: Text(
                              s10(
                                context,
                                [
                                  'overview',
                                  'evidence',
                                  'timeline',
                                  'share',
                                ][i],
                              ),
                            ),
                            selected: _tab == i,
                            onSelected: (_) => setState(() => _tab = i),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: switch (_tab) {
                      0 => _overview(p),
                      1 => _evidence(p),
                      2 => _timeline(p),
                      _ => _share(p),
                    },
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _overview(Preparation p) {
    final s = TreatmentSummary(p, _events, repo.today);
    final deadlines = p.history.where((h) => h['type'] == 'deadline').toList()
      ..sort((a, b) => (a['date'] ?? '9999').compareTo(b['date'] ?? '9999'));
    return [
      for (final h in deadlines)
        CnCard(
          child: Text(
            '${h['purpose']} · ${h['date'] ?? s10(context, 'unknown')}\n${h['text']}',
          ),
        ),
      Text(
        p.path == PreparationPath.deniedRequest
            ? s10(context, 'denied')
            : s10(context, 'start'),
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      Text(p.concern),
      const SizedBox(height: 12),
      CnCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(s10(context, 'review')),
            Text(
              '${s.observedDays}/30 recorded days · ${s.symptomDays} symptom days · ${s.nightWakings} reported night wakings',
            ),
            Text(
              '${p.needs.where((n) => n.links.any((id) => _events.any((e) => e.id == id && !e.undone))).length}/${p.needs.length} evidence items linked',
            ),
            Text(s10(context, 'missing')),
            TextButton(
              onPressed: () => setState(() => _tab = 1),
              child: Text(s10(context, 'evidence')),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      if (_listening)
        FilledButton(
          onPressed: () => PreparationRepository.native.invokeMethod('stop'),
          child: Text(s10(context, 'stop')),
        )
      else
        FilledButton.icon(
          onPressed: _busy ? null : () => _voice(),
          icon: const Icon(Icons.mic),
          label: Text(s10(context, 'voice')),
        ),
      TextButton(
        onPressed: _busy ? null : () => _voice(typed: true),
        child: Text(s10(context, 'text')),
      ),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final pair in [
            ('symptom', 'symptom'),
            ('rescue', 'as_needed'),
            ('scheduled', 'scheduled'),
          ])
            OutlinedButton(
              onPressed: _busy ? null : () => _quick(pair.$2),
              child: Text(s10(context, pair.$1)),
            ),
        ],
      ),
      if (!repo.demo) ...[
        TextButton(
          onPressed: _busy ? null : () => _notification(true),
          child: Text(s10(context, 'notification')),
        ),
        TextButton(
          onPressed: _busy ? null : () => _notification(false),
          child: Text(s10(context, 'pause')),
        ),
      ],
    ];
  }

  List<Widget> _evidence(Preparation p) => [
    for (final n in p.needs)
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: CnCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                n.label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(n.reason),
              Text(
                '${s10(context, 'source')}: ${n.origin}${n.policyPage == null ? '' : ' · p${n.policyPage}'} · ${n.owner}',
              ),
              if (n.quote != null) SelectableText('“${n.quote}”'),
              Text(
                s10(
                  context,
                  n.links.any(
                        (id) => _events.any((e) => e.id == id && !e.undone),
                      )
                      ? 'linked'
                      : 'missing',
                ),
              ),
              for (final id in n.links)
                if (_events.any((e) => e.id == id && !e.undone))
                  TextButton(
                    onPressed: () =>
                        _source(_events.firstWhere((e) => e.id == id)),
                    child: Text('${s10(context, 'source')} · $id'),
                  ),
              OutlinedButton(
                onPressed: _busy ? null : () => _link(n),
                child: Text(s10(context, 'candidate')),
              ),
            ],
          ),
        ),
      ),
    if (p.applicablePolicy)
      TextButton(
        onPressed: () => launchUrl(
          Uri.parse(policyUrl),
          mode: LaunchMode.externalApplication,
        ),
        child: const Text(
          'NJ Aetna Dupixent · checked 2026-10-22 · original policy',
        ),
      ),
    if (!repo.demo)
      FilledButton.icon(
        onPressed: _busy ? null : _upload,
        icon: const Icon(Icons.upload_file),
        label: Text(s10(context, 'upload')),
      ),
    for (final d in p.documents)
      ListTile(
        title: Text(d['name'] ?? 'Document'),
        subtitle: Text(d['status'] ?? d['kind'] ?? 'uploaded'),
        onTap: () => _run(() async {
          final bytes = await repo.download(d['path']);
          if (d['mime'] == 'application/pdf') {
            await Printing.layoutPdf(onLayout: (_) async => bytes);
          } else if (mounted) {
            await showDialog<void>(
              context: context,
              builder: (c) =>
                  Dialog(child: InteractiveViewer(child: Image.memory(bytes))),
            );
          }
        }),
      ),
  ];
  List<Widget> _timeline(Preparation p) {
    final s = TreatmentSummary(
      p,
      _events,
      repo.today,
      days: _period == '365' ? 365 : 30,
    );
    return [
      SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: '30', label: Text('30 days')),
          ButtonSegment(value: '365', label: Text('12 months')),
        ],
        selected: {_period},
        onSelectionChanged: (v) => setState(() => _period = v.first),
      ),
      if (s.events.isEmpty) Text(s10(context, 'empty')),
      for (final e in s.events)
        ListTile(
          isThreeLine: true,
          title: Text('${e.day} · ${e.kind}'),
          subtitle: Text(e.values['english_summary'] ?? e.text),
          onTap: () => _source(e),
          trailing: e.values['legacy'] == true || e.kind == 'environment'
              ? null
              : IconButton(
                  tooltip: s10(context, 'undo'),
                  onPressed: _busy
                      ? null
                      : () => _run(() async {
                          await repo.undo(e.sourceId);
                          await _load();
                        }),
                  icon: const Icon(Icons.undo),
                ),
        ),
    ];
  }

  List<Widget> _share(Preparation p) => [
    Text(
      p.englishTitle,
      style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
    ),
    Text(s10(context, 'review')),
    if (!repo.demo)
      CheckboxListTile(
        value: _includeOriginal,
        onChanged: (v) => setState(() => _includeOriginal = v ?? false),
        title: Text(s10(context, 'original')),
      ),
    FilledButton.icon(
      onPressed: _busy ? null : _generate,
      icon: const Icon(Icons.picture_as_pdf),
      label: Text(s10(context, 'pdf')),
    ),
    OutlinedButton(
      onPressed: _busy ? null : _handoff,
      child: Text(s10(context, 'delivery')),
    ),
    Text(s10(context, 'receipt')),
    for (final h in p.history)
      ListTile(
        title: Text('${h['date']} · ${h['type']}'),
        subtitle: Text(h['text'] ?? ''),
      ),
    for (final e in p.exports)
      ListTile(
        title: Text('PDF · revision ${e['revision']}'),
        subtitle: Text(
          '${e['generated_at'] ?? ''}\n${e['content_hash'] == preparationFingerprint(p, _events, repo.today) ? s10(context, 'currentBrief') : s10(context, 'staleBrief')}',
        ),
      ),
  ];
}
