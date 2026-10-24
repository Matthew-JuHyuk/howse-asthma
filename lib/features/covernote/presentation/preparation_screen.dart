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
import 'source_review_screen.dart';
import 'guided_record_screen.dart';
import 'record_navigation_bar.dart';
import 'covernote_nav.dart';

Future<void> startPreparation(BuildContext context) async {
  if (!await requireSignIn(context) || !context.mounted) return;
  await Navigator.push<void>(
    context,
    MaterialPageRoute(
      builder: (_) =>
          NewPreparationScreen(mainNavigation: mainTabNavigation(context)),
    ),
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
  const NewPreparationScreen({super.key, this.mainNavigation});
  final ValueChanged<int>? mainNavigation;
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
            builder: (_) => PreparationScreen(
              repository: repo,
              caseId: p.id,
              mainNavigation: widget.mainNavigation,
            ),
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
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        24 + MediaQuery.paddingOf(context).bottom,
      ),
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
    this.mainNavigation,
  });
  final PreparationRepository repository;
  final String caseId;
  final CaseStore? letterStore;
  final bool voiceOnOpen;
  final ValueChanged<int>? mainNavigation;
  @override
  State<PreparationScreen> createState() => _PreparationScreenState();
}

class _PreparationScreenState extends State<PreparationScreen>
    with WidgetsBindingObserver {
  Preparation? _p;
  List<TreatmentEvent> _events = [];
  String? _error;
  bool _busy = false, _includeOriginal = false, _pending = false;
  int _tab = 0;
  bool _refreshingSources = false;
  bool _linkOpen = false;
  bool _recordOpen = false;
  bool _loading = false;
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
    if (state == AppLifecycleState.resumed && !_busy && !_linkOpen) _load();
  }

  Future<void> _load() async {
    if (_loading) return;
    _loading = true;
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
    } finally {
      _loading = false;
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

  Future<void> _voice({bool typed = false}) async {
    if (_busy || _recordOpen || _p == null) return;
    _recordOpen = true;
    final p = _p!;
    try {
      await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) => GuidedRecordScreen(
            repository: repo,
            profiles: {p.patientKey: p.patientName},
            initialPatient: p.patientKey,
            caseId: p.id,
            initiallyTyped: typed,
          ),
        ),
      );
    } finally {
      _recordOpen = false;
    }
    if (mounted) await _load();
  }

  Future<void> _link(EvidenceNeed n) async {
    if (_busy || _linkOpen) return;
    _linkOpen = true;
    List<String>? chosen;
    try {
      final candidates = sourceCandidates(n, _p!, _events);
      chosen = await Navigator.push<List<String>>(
        context,
        MaterialPageRoute(
          builder: (_) => SourceReviewScreen(
            title: needLabel(context, n),
            patient: _p!.patientName,
            events: candidates,
            linked: n.links,
            suggestAll: ['treatment', 'burden', 'tests'].contains(n.id),
          ),
        ),
      );
    } finally {
      _linkOpen = false;
    }
    if (!mounted || chosen == null) return;
    await _run(
      () => _save(
        _p!.update({
          'needs': [
            for (final x in _p!.needs)
              (x.id == n.id ? x.link(chosen!) : x).toJson(),
          ],
        }),
      ),
    );
  }

  Future<void> _source(TreatmentEvent e) async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (c) => Scaffold(
          appBar: CoverNoteAppBar(title: Text(recordKindLabel(c, e.kind))),
          body: CoverNoteBody(
            scrollable: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.day, style: Theme.of(c).textTheme.titleMedium),
                const SizedBox(height: 20),
                SelectableText(e.text),
                if (e.values['quote'] != null &&
                    e.values['quote'] != e.text) ...[
                  const SizedBox(height: 20),
                  Text(s10(c, 'source')),
                  SelectableText(e.values['quote'].toString()),
                ],
                if (e.values['page'] != null)
                  Text('${s10(c, 'document')} · ${e.values['page']}'),
              ],
            ),
          ),
        ),
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
    if ((await file.length() ?? 0) > 12 * 1024 * 1024) {
      throw StateError('too_large');
    }
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
      final ok = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (c) => ReviewPage(
            title: s10(c, 'confirm'),
            body: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(p.patientName, style: Theme.of(c).textTheme.titleLarge),
                const SizedBox(height: 12),
                Text(
                  '${s10(c, 'patient')}: ${result['patient_name'] ?? s10(c, 'unknown')}',
                ),
                const SizedBox(height: 20),
                Text(result['summary'] ?? ''),
                const SizedBox(height: 20),
                for (final x in result['items'] as List)
                  Card(
                    child: ExpansionTile(
                      title: Text(x['english_summary'] ?? s10(c, 'document')),
                      subtitle: Text(x['date'] ?? s10(c, 'unknown')),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SelectableText(x['quote'] ?? ''),
                        ),
                      ],
                    ),
                  ),
              ],
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
          if (p != null)
            PopupMenuButton<String>(
              onSelected: (v) {
                if (v == 'edit') {
                  _editPreparation();
                } else {
                  _run(() => _save(p.update({'lifecycle': v})));
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text(AppLocalizations.of(context)!.cnEdit),
                ),
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
      bottomNavigationBar: widget.mainNavigation == null
          ? null
          : RecordNavigationBar(
              selectedIndex: 1,
              onDestination: widget.mainNavigation!,
              onRecord: _busy || p == null ? null : () => _voice(),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 8,
                          ),
                          child: ChoiceChip(
                            label: Text(
                              s10(
                                context,
                                [
                                  'overview',
                                  'evidence',
                                  'linkedHistory',
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
                    padding: EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      24 + MediaQuery.paddingOf(context).bottom,
                    ),
                    children:
                        (switch (_tab) {
                              0 => _overview(p),
                              1 => _evidence(p),
                              2 => _timeline(p),
                              _ => _share(p),
                            })
                            .map(
                              (child) => _tab == 0
                                  ? child
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 20,
                                      ),
                                      child: child,
                                    ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
    );
  }

  List<Widget> _overview(Preparation p) {
    final linked = p.needs
        .where(
          (n) => n.links.any(
            (id) => _events.any(
              (e) => e.id == id && !e.undone && e.patientKey == p.patientKey,
            ),
          ),
        )
        .length;
    final deadlines = p.history.where((h) => h['type'] == 'deadline').toList()
      ..sort((a, b) => (a['date'] ?? '9999').compareTo(b['date'] ?? '9999'));
    return [
      Text(
        p.path == PreparationPath.deniedRequest
            ? s10(context, 'denied')
            : s10(context, 'start'),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      const SizedBox(height: 8),
      Text(s10(context, 'purposeBody')),
      const SizedBox(height: 24),
      CnCard(
        color: CnColors.mint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.route_outlined, color: CnColors.teal),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    s10(context, 'nextStep'),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              s10(
                context,
                linked < p.needs.length ? 'gatherStep' : 'reviewStep',
              ),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('$linked / ${p.needs.length} · ${s10(context, 'progress')}'),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: p.needs.isEmpty ? 0 : linked / p.needs.length,
              minHeight: 6,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () =>
                  setState(() => _tab = linked < p.needs.length ? 1 : 3),
              icon: const Icon(Icons.arrow_forward),
              label: Text(
                s10(context, linked < p.needs.length ? 'evidence' : 'share'),
              ),
            ),
          ],
        ),
      ),
      for (final h in deadlines)
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: CnCard(
            color: CnColors.warnBg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.event_outlined, color: CnColors.warn),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s10(
                          context,
                          h['purpose'] == 'information_response'
                              ? 'information_response'
                              : 'review_request',
                        ),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(h['date'] ?? s10(context, 'unknown')),
                      ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: Text(s10(context, 'source')),
                        children: [SelectableText(h['text'] ?? '')],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      const SizedBox(height: 24),
      ExpansionTile(
        title: Text(s10(context, 'details')),
        children: [
          Padding(padding: const EdgeInsets.all(16), child: Text(p.concern)),
        ],
      ),
      if (!repo.demo)
        ExpansionTile(
          title: Text(s10(context, 'notification')),
          children: [
            TextButton(
              onPressed: _busy ? null : () => _notification(true),
              child: Text(s10(context, 'notification')),
            ),
            TextButton(
              onPressed: _busy ? null : () => _notification(false),
              child: Text(s10(context, 'pause')),
            ),
          ],
        ),
    ];
  }

  List<Widget> _evidence(Preparation p) => [
    Text(
      s10(context, 'gatherStep'),
      style: Theme.of(context).textTheme.titleLarge,
    ),
    Text(s10(context, 'linkedHelp')),
    const SizedBox(height: 8),
    for (final n in p.needs)
      CnCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(switch (n.id) {
                  'treatment' => Icons.medication_outlined,
                  'tests' => Icons.science_outlined,
                  _ => Icons.favorite_outline,
                }, color: CnColors.teal),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    needLabel(context, n),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  n.links.any(
                        (id) => _events.any((e) => e.id == id && !e.undone),
                      )
                      ? Icons.check_circle_outline
                      : Icons.add_circle_outline,
                  size: 20,
                  color: n.links.isEmpty ? CnColors.warn : CnColors.teal,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    s10(
                      context,
                      n.links.any(
                            (id) => _events.any((e) => e.id == id && !e.undone),
                          )
                          ? 'linked'
                          : 'missing',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _busy || _linkOpen ? null : () => _link(n),
              icon: const Icon(Icons.folder_open_outlined),
              label: Text(s10(context, 'candidate')),
            ),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(s10(context, 'details')),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(n.reason),
                ),
                if (n.quote != null) SelectableText('“${n.quote}”'),
              ],
            ),
          ],
        ),
      ),
    FilledButton.icon(
      onPressed: () => setState(() => _tab = 3),
      icon: const Icon(Icons.arrow_forward),
      label: Text(s10(context, 'reviewStep')),
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
        subtitle: Text(s10(context, 'document')),
        onTap: () => _run(() async {
          final bytes = await repo.download(d['path']);
          if (d['mime'] == 'application/pdf') {
            await Printing.layoutPdf(onLayout: (_) async => bytes);
          } else if (mounted) {
            await showDialog<void>(
              context: context,
              builder: (c) => Dialog(
                child: InteractiveViewer(
                  child: Image.memory(bytes, cacheWidth: 1200),
                ),
              ),
            );
          }
        }),
      ),
  ];
  List<Widget> _timeline(Preparation p) {
    final linkedIds = p.needs.expand((n) => n.links).toSet();
    final linkedEvents =
        _events
            .where(
              (e) =>
                  !e.undone &&
                  e.patientKey == p.patientKey &&
                  linkedIds.contains(e.id),
            )
            .toList()
          ..sort((a, b) => b.day.compareTo(a.day));
    return [
      Text(s10(context, 'linkedHistoryHelp')),
      if (linkedEvents.isEmpty) Text(s10(context, 'empty')),
      for (final e in linkedEvents)
        ListTile(
          isThreeLine: true,
          title: Text('${e.day} · ${recordKindLabel(context, e.kind)}'),
          subtitle: Text(e.values['english_summary'] ?? e.text),
          onTap: () => _source(e),
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
        title: Text(
          '${h['date']} · ${s10(context, h['type'] == 'deadline' ? 'review_request' : 'details')}',
        ),
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
