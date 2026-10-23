import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../records/data/records_revision.dart';
import '../domain/preparation.dart';
import 'environment_collector.dart';

String preparationId() {
  final r = Random.secure();
  final b = List.generate(16, (_) => r.nextInt(256));
  b[6] = (b[6] & 15) | 64;
  b[8] = (b[8] & 63) | 128;
  final s = b.map((x) => x.toRadixString(16).padLeft(2, '0')).join();
  return '${s.substring(0, 8)}-${s.substring(8, 12)}-${s.substring(12, 16)}-${s.substring(16, 20)}-${s.substring(20)}';
}

class PreparationRepository {
  PreparationRepository({this.demo = false});
  final bool demo;
  static final demoCases = <String, Preparation>{};
  static final demoEvents = <TreatmentEvent>[];
  static const native = MethodChannel('covernote/capture');
  static Future<void> clearLocal(String owner) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cn_env_factors_v2_$owner');
    for (final key
        in prefs
            .getKeys()
            .where((k) => k.startsWith('cn_s10_') && k.contains(owner))
            .toList()) {
      await prefs.remove(key);
    }
    try {
      await native.invokeMethod('clear', {'owner': owner});
    } on MissingPluginException {
      /* Not Android. */
    }
  }

  Future<void> importDirectRecords() async {
    if (demo) return;
    try {
      final owner = uid;
      final entries =
          await native.invokeListMethod<dynamic>('pending', {'owner': owner}) ??
          [];
      for (final entry in entries) {
        if (uid != owner) throw StateError('account_changed');
        final j = Map<String, dynamic>.from(entry as Map);
        if ((j['owner'] ?? j['patient_key']) != owner) continue;
        if (j['undone'] == true) {
          await undo(j['source_id']);
        } else {
          await record([TreatmentEvent.fromJson(j)]);
        }
        await native.invokeMethod('ack', {'owner': owner, 'id': j['id']});
      }
    } on MissingPluginException {
      /* Other platforms retain manual record entry. */
    }
  }

  static Future<void>? _tail;
  Future<T> _serial<T>(Future<T> Function() action) async {
    final previous = _tail;
    final gate = Completer<void>();
    _tail = gate.future;
    try {
      if (previous != null) await previous;
      return await action();
    } finally {
      if (identical(_tail, gate.future)) _tail = null;
      gate.complete();
    }
  }

  String get uid => demo
      ? 'synthetic-diego'
      : SupabaseService.currentUser?.id ?? (throw StateError('not_signed_in'));
  DateTime get today => demo ? DateTime(2026, 10, 22) : DateTime.now();
  String get queueKey => 'cn_s10_queue_$uid';
  Future<Map<String, String>> careProfiles() async {
    if (demo) return {'synthetic-diego': 'Diego Martinez'};
    final rows = await SupabaseService.client
        .from('case_preparations')
        .select('payload')
        .eq('owner_id', uid)
        .limit(200);
    return {
      for (final r in rows)
        if ((r['payload'] as Map)['patient_key'] != null)
          r['payload']['patient_key'] as String:
              r['payload']['patient_name'] as String,
    };
  }

  Future<Preparation> create({
    String? patientKey,
    required String patientName,
    required String concern,
    String currentMedication = '',
    String proposedMedication = '',
    String plan = '',
    bool policyConfirmed = false,
  }) async {
    final id = preparationId();
    final p = Preparation(
      id: id,
      patientKey: patientKey ?? uid,
      patientName: patientName,
      concern: concern,
      currentMedication: currentMedication,
      proposedMedication: proposedMedication,
      plan: plan,
      policyConfirmed: policyConfirmed,
      synthetic: demo,
    );
    final prepared = p.update({
      'needs': preparationNeeds(
        p.applicablePolicy,
      ).map((e) => e.toJson()).toList(),
    });
    if (demo) return save(prepared);
    final owner = uid;
    final rev = await SupabaseService.client.rpc(
      'create_preparation',
      params: {'p_payload': prepared.toJson()},
    );
    if (uid != owner) throw StateError('account_changed');
    final created = prepared.update({'revision': rev});
    await (await SharedPreferences.getInstance()).setString(
      'cn_s10_case_${owner}_$id',
      jsonEncode(created.toJson()),
    );
    return created;
  }

  Future<Preparation?> load(String id) async {
    if (demo) return demoCases[id]?.clone();
    final owner = uid;
    final prefs = await SharedPreferences.getInstance();
    try {
      final r = await SupabaseService.client
          .from('case_preparations')
          .select('payload,revision')
          .eq('case_id', id)
          .maybeSingle();
      final p = r == null
          ? null
          : Preparation.fromJson({
              ...r['payload'] as Map,
              'revision': r['revision'],
            });
      if (uid != owner) throw StateError('account_changed');
      if (p != null) {
        await prefs.setString(
          'cn_s10_case_${owner}_$id',
          jsonEncode(p.toJson()),
        );
      }
      return p;
    } catch (_) {
      if (uid != owner) rethrow;
      final cache = prefs.getString('cn_s10_case_${owner}_$id');
      if (cache == null) rethrow;
      offline = true;
      return Preparation.fromJson(jsonDecode(cache));
    }
  }

  Future<Preparation> save(Preparation p) async {
    if (demo) {
      final old = demoCases[p.id];
      if (old != null && old.revision != p.revision) {
        throw StateError('stale_preparation');
      }
      final n = p.update({'revision': p.revision + 1});
      demoCases[p.id] = n.clone();
      return n;
    }
    final owner = uid;
    if (p.patientKey != owner && !p.patientKey.startsWith('$owner/')) {
      throw StateError('wrong_patient');
    }
    final rev = await SupabaseService.client.rpc(
      'save_preparation',
      params: {
        'p_case_id': p.id,
        'p_revision': p.revision,
        'p_payload': p.toJson(),
      },
    );
    if (uid != owner) throw StateError('account_changed');
    final next = p.update({'revision': rev});
    await (await SharedPreferences.getInstance()).setString(
      'cn_s10_case_${owner}_${p.id}',
      jsonEncode(next.toJson()),
    );
    return next;
  }

  bool offline = false;
  Future<List<Map<String, dynamic>>> _readAll(
    String table, String ownerColumn, String orderColumn, String owner,
  ) async {
    final rows = <Map<String, dynamic>>[];
    for (var offset = 0; ; offset += 500) {
      if (uid != owner) throw StateError('account_changed');
      final page = await SupabaseService.client
          .from(table)
          .select()
          .eq(ownerColumn, owner)
          .order(orderColumn, ascending: false)
          .order('id')
          .range(offset, offset + 499);
      rows.addAll(page.map((r) => Map<String, dynamic>.from(r)));
      if (page.length < 500) break;
    }
    return rows;
  }
  Future<List<TreatmentEvent>> events() async {
    if (demo) return List.of(demoEvents);
    final owner = uid;
    final prefs = await SharedPreferences.getInstance();
    List<TreatmentEvent> list;
    try {
      final rows = await _readAll('treatment_events', 'owner_id', 'local_date', owner);
      list = [
        for (final r in rows)
          TreatmentEvent.fromJson({
            ...r['payload'] as Map,
            'undone': r['undone_at'] != null,
          }),
      ];
      final env = await _readAll('environment_snapshots', 'patient_id', 'event_local_date', owner);
      final links = await _readAll('environment_event_links', 'patient_id', 'created_at', owner);
      for (final r in env) {
        if (r['event_local_date'] == null) continue;
        final linkedIds = {
          for (final l in links)
            if (l['snapshot_id'] == r['id']) l['event_id'],
        };
        final patients = list
            .where((e) => linkedIds.contains(e.id))
            .map((e) => e.patientKey)
            .toSet();
        if (patients.isEmpty) patients.add(owner);
        for (final patient in patients) {
          list.add(
            TreatmentEvent(
              id: 'env:${r['id']}:$patient',
              patientKey: patient,
              kind: 'environment',
              day: r['event_local_date'],
              sourceId: r['id'],
              text:
                  '${r['metric']}: ${r['value']} ${r['unit'] ?? ''}. Regional context only.',
              values: Map<String, dynamic>.from(r),
            ),
          );
        }
      }
      await prefs.setString(
        'cn_s10_events_$owner',
        jsonEncode(list.map((e) => e.toJson()).toList()),
      );
      offline = false;
    } catch (_) {
      final cached = prefs.getString('cn_s10_events_$owner');
      final queued =
          jsonDecode(prefs.getString('cn_s10_queue_$owner') ?? '[]') as List;
      if (cached == null && queued.isEmpty) rethrow;
      list = [
        for (final e in jsonDecode(cached ?? '[]')) TreatmentEvent.fromJson(e),
      ];
      offline = true;
    }
    for (final batch
        in jsonDecode(prefs.getString('cn_s10_queue_$owner') ?? '[]') as List) {
      for (final e in batch as List) {
        if (!list.any((x) => x.id == e['id'])) {
          list.add(TreatmentEvent.fromJson(e));
        }
      }
    }
    if (uid != owner) throw StateError('account_changed');
    final undone = prefs.getStringList('cn_s10_undo_$owner') ?? [];
    return [
      for (final e in list)
        if (undone.contains(e.sourceId))
          TreatmentEvent.fromJson({...e.toJson(), 'undone': true})
        else
          e,
    ];
  }

  Future<bool> record(List<TreatmentEvent> list) => _serial(() async {
    if (list.isEmpty) return true;
    if (list.any(
      (e) => e.patientKey != uid && !e.patientKey.startsWith('$uid/'),
    )) {
      throw StateError('wrong_patient');
    }
    if (demo) {
      for (final e in list) {
        if (!demoEvents.any((x) => x.id == e.id)) demoEvents.add(e);
      }
      RecordsRevision.instance.bump();
      return true;
    }
    final owner = uid;
    final key = queueKey;
    final prefs = await SharedPreferences.getInstance();
    final queue = List<dynamic>.from(jsonDecode(prefs.getString(key) ?? '[]'));
    final batch = list.map((e) => e.toJson()).toList();
    if (!queue.any(
      (b) => (b as List).first['source_id'] == list.first.sourceId,
    )) {
      queue.add(batch);
    }
    await prefs.setString(key, jsonEncode(queue));
    if (uid != owner) throw StateError('account_changed');
    return _flush();
  });
  Future<bool> flush() => _serial(_flush);
  Future<bool> _flush() async {
    if (demo) return true;
    final owner = uid;
    final key = queueKey;
    final prefs = await SharedPreferences.getInstance();
    final undoKey = 'cn_s10_undo_$owner';
    final undone = List<String>.of(prefs.getStringList(undoKey) ?? []);
    while (undone.isNotEmpty) {
      if (uid != owner) throw StateError('account_changed');
      try {
        await SupabaseService.client.rpc(
          'undo_treatment_source',
          params: {'p_source': undone.first},
        );
      } catch (_) {
        return false;
      }
      undone.removeAt(0);
      await prefs.setStringList(undoKey, undone);
    }
    final queue = List<dynamic>.from(jsonDecode(prefs.getString(key) ?? '[]'));
    while (queue.isNotEmpty) {
      if (uid != owner) throw StateError('account_changed');
      try {
        await SupabaseService.client.rpc(
          'save_treatment_batch',
          params: {'p_events': queue.first},
        );
      } catch (_) {
        RecordsRevision.instance.bump();
        return false;
      }
      final completed = queue.removeAt(0) as List;
      await prefs.setString(key, jsonEncode(queue));
      for (final raw in completed) {
        final e = TreatmentEvent.fromJson(raw);
        if (['symptom', 'medication_use'].contains(e.kind) &&
            e.values['negated'] != true) {
          EnvironmentCollector().attachToEvent(
            eventKind: e.kind,
            eventId: e.id,
            occurredAt:
                DateTime.tryParse(e.values['occurred_at'] ?? '') ??
                DateTime.parse('${e.day}T12:00:00'),
            localDate: DateTime.parse(e.day),
          );
        }
      }
    }
    RecordsRevision.instance.bump();
    return true;
  }

  Future<void> undo(String source) => _serial(() async {
    if (demo) {
      demoEvents.removeWhere((e) => e.sourceId == source);
    } else {
      final prefs = await SharedPreferences.getInstance();
      final key = queueKey;
      final q = List<dynamic>.from(jsonDecode(prefs.getString(key) ?? '[]'))
        ..removeWhere((b) => (b as List).any((e) => e['source_id'] == source));
      await prefs.setString(key, jsonEncode(q));
      final undoKey = 'cn_s10_undo_$uid';
      final undone = (prefs.getStringList(undoKey) ?? []).toSet()..add(source);
      await prefs.setStringList(undoKey, undone.toList());
      final cached = prefs.getString('cn_s10_events_$uid');
      if (cached != null) {
        final list = [
          for (final e in jsonDecode(cached))
            if (e['source_id'] == source) {...e as Map, 'undone': true} else e,
        ];
        await prefs.setString('cn_s10_events_$uid', jsonEncode(list));
      }
      await _flush();
    }
    RecordsRevision.instance.bump();
  });
  Future<String> upload(
    String caseId,
    String name,
    String mime,
    Uint8List bytes, {
    bool patientDocument = false,
  }) async {
    if (demo) throw StateError('demo_no_live_upload');
    final path =
        '$uid/${patientDocument ? 'treatment' : caseId}/s10/${preparationId()}-${name.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_')}';
    await SupabaseService.client.storage
        .from('appeal-documents')
        .uploadBinary(path, bytes);
    return path;
  }

  Future<Uint8List> download(String path) =>
      SupabaseService.client.storage.from('appeal-documents').download(path);
  Future<Map> analyze({
    required String action,
    required Map<String, dynamic> input,
  }) async {
    if (demo) throw StateError('live_ai_requires_sign_in');
    final r = await SupabaseService.client.functions.invoke(
      'analyze-letter',
      body: {'action': action, ...input},
    );
    if (r.status != 200 || r.data is! Map || r.data['error'] != null) {
      throw StateError('analysis_failed');
    }
    return r.data as Map;
  }

  Future<Preparation> seed(bool denied) async {
    if (!demo) throw StateError('demo_only');
    demoCases.clear();
    demoEvents.clear();
    var p = await create(
      patientName: 'Diego Martinez (synthetic, age 14)',
      concern:
          'Night waking and difficulty describing treatment history to the care team.',
      currentMedication:
          'Prescribed controller (synthetic label; clinician to verify)',
      proposedMedication: 'Dupixent',
      plan: 'Aetna Better Health of New Jersey',
      policyConfirmed: true,
    );
    for (var i = 0; i < 12; i++) {
      final day = dayKey(today.subtract(Duration(days: i * 2)));
      demoEvents.add(
        TreatmentEvent(
          id: 'demo-s$i',
          patientKey: uid,
          kind: 'symptom',
          day: day,
          sourceId: 'demo-source$i',
          text: 'Synthetic patient report of cough / night waking',
          values: {'symptom': 'cough', 'night_wakings': i % 3 == 0 ? 2 : 0},
          synthetic: true,
        ),
      );
    }
    demoEvents.add(
      TreatmentEvent(
        id: 'demo-rx',
        patientKey: uid,
        kind: 'clinical_document',
        day: '2026-06-01',
        sourceId: 'demo-rx-source',
        text:
            'SAMPLE: prescription history from June through October. Maximum tolerated therapy and actual use need clinical review.',
        values: {
          'document_kind': 'prescription',
          'page': 1,
          'quote': 'SAMPLE prescription history June–October 2026',
        },
        synthetic: true,
      ),
    );
    demoEvents.add(
      TreatmentEvent(
        id: 'demo-ed',
        patientKey: uid,
        kind: 'urgent_visit',
        day: '2026-04-14',
        sourceId: 'demo-ed-source',
        text: 'SAMPLE emergency visit summary. No real provider or signature.',
        values: {'page': 1, 'quote': 'SAMPLE: emergency visit 2026-04-14'},
        synthetic: true,
      ),
    );
    demoEvents.add(
      TreatmentEvent(
        id: 'demo-env',
        patientKey: uid,
        kind: 'environment',
        day: '2026-10-20',
        sourceId: 'demo-env-source',
        text: 'SYNTHETIC regional AQI 112. Context only; no causal claim.',
        values: {
          'value': 112,
          'unit': 'US AQI',
          'provider': 'synthetic',
          'spatial_scope': 'Bergen County example',
          'observed_at': '2026-10-20T16:00:00-04:00',
          'kind': 'synthetic',
        },
        synthetic: true,
      ),
    );
    if (denied) {
      p = p.update({
        'path': 'deniedRequest',
        'history': [
          {
            'type': 'decision',
            'date': '2026-10-18',
            'source': 'synthetic_notice',
            'text':
                'SAMPLE: prior treatment records were not included. This is an alternative starting snapshot.',
          },
        ],
        'needs': [
          for (final n in p.needs)
            {
              ...n.toJson(),
              'origin': n.id == 'treatment' ? 'notice' : n.origin,
              'quote': n.id == 'treatment'
                  ? 'SAMPLE: prior treatment records were not included.'
                  : null,
            },
        ],
      });
    }
    return save(p);
  }
}
