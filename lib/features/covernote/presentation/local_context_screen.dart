import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../records/domain/record_models.dart' show isoDate;
import '../ui/brand.dart';
import 'case_labels.dart';

class _Entry {
  _Entry(Map r)
    : id = r['id'] as String,
      date = DateTime.parse(r['local_date'] as String),
      kind = r['kind'] as String,
      valueKind = r['value_kind'] as String,
      aqi = (r['aqi_value'] as num?)?.toInt(),
      value = (r['numeric_value'] as num?)?.toDouble(),
      unit = r['unit'] as String?,
      source = r['source_name'] as String?,
      place = r['place_label'] as String?,
      report = r['report_code'] as String?,
      note = r['note'] as String?,
      synthetic = r['is_synthetic'] == true;

  final String id;
  final DateTime date;
  final String kind;
  final String valueKind;
  final int? aqi;
  final double? value;
  final String? unit;
  final String? source;
  final String? place;
  final String? report;
  final String? note;
  final bool synthetic;
}

/// Regional air readings (with their source) and the patient's own notes,
/// kept apart. Nothing here is filled in automatically.
class LocalContextScreen extends StatefulWidget {
  const LocalContextScreen({super.key});

  @override
  State<LocalContextScreen> createState() => _LocalContextScreenState();
}

class _LocalContextScreenState extends State<LocalContextScreen> {
  List<_Entry>? _entries;
  bool _failed = false;

  SupabaseClient get _db => SupabaseService.client;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _failed = false);
    try {
      final uid = SupabaseService.currentUser!.id;
      final since = DateTime.now().subtract(const Duration(days: 90));
      final rows = await _db
          .from('local_context_entries')
          .select(
            'id, local_date, kind, value_kind, aqi_value, numeric_value, unit, source_name, place_label, report_code, note, is_synthetic',
          )
          .eq('patient_id', uid)
          .gte('local_date', isoDate(since))
          .order('local_date', ascending: false)
          .limit(300);
      if (mounted) {
        setState(
          () => _entries = [for (final r in rows as List) _Entry(r as Map)],
        );
      }
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  Future<void> _delete(_Entry e) async {
    try {
      await _db.from('local_context_entries').delete().eq('id', e.id);
      await _load();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.cnErrNetwork)),
        );
      }
    }
  }

  Future<void> _add({required bool report}) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _AddSheet(report: report),
    );
    if (saved == true) await _load();
  }

  String _kindLabel(AppLocalizations l, _Entry e) => switch (e.kind) {
    'pm25' => l.cnCtxPm25,
    'no2' => l.cnCtxNo2,
    'outdoor_humidity' => l.cnCtxOutdoorHumidity,
    _ => _reportLabel(l, e.report),
  };

  String _valueText(_Entry e) {
    if (e.aqi != null) return 'AQI ${e.aqi}';
    final v = e.value;
    if (v == null) return '';
    final s = v == v.roundToDouble()
        ? v.toStringAsFixed(0)
        : v.toStringAsFixed(1);
    return e.unit == null ? s : '$s ${e.unit}';
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final entries = _entries;
    final readings =
        entries?.where((e) => e.kind != 'user_report').toList() ??
        const <_Entry>[];
    final reports =
        entries?.where((e) => e.kind == 'user_report').toList() ??
        const <_Entry>[];
    return Scaffold(
      appBar: AppBar(title: Text(l.cnRecLocalContext)),
      body: _failed
          ? Center(
              child: ActionMessage(
                icon: Icons.cloud_off,
                title: l.cnErrNetwork,
                actionLabel: l.cnRetry,
                onAction: _load,
              ),
            )
          : entries == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              children: [
                Text(
                  l.cnCtxIntro,
                  style: const TextStyle(color: CnColors.muted),
                ),
                SectionLabel(l.cnCtxReadings),
                Text(
                  l.cnCtxReadingsNote,
                  style: const TextStyle(color: CnColors.muted, fontSize: 14),
                ),
                const SizedBox(height: 8),
                if (readings.isEmpty)
                  Text(
                    l.cnNoEntries,
                    style: const TextStyle(color: CnColors.muted),
                  ),
                for (final e in readings)
                  _EntryTile(
                    title: '${_kindLabel(l, e)} · ${_valueText(e)}',
                    subtitle: [
                      l.cnObservedOn(formatDay(context, e.date)),
                      if (e.source != null) e.source!,
                      if (e.place != null) e.place!,
                      if (e.valueKind != 'observation') e.valueKind,
                      if (e.synthetic) l.cnSyntheticData,
                    ].join(' · '),
                    onDelete: () => _delete(e),
                  ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => _add(report: false),
                    icon: const Icon(Icons.add),
                    label: Text(l.cnCtxAddReading),
                  ),
                ),
                SectionLabel(l.cnCtxReports),
                Text(
                  l.cnCtxReportsNote,
                  style: const TextStyle(color: CnColors.muted, fontSize: 14),
                ),
                const SizedBox(height: 8),
                if (reports.isEmpty)
                  Text(
                    l.cnNoEntries,
                    style: const TextStyle(color: CnColors.muted),
                  ),
                for (final e in reports)
                  _EntryTile(
                    title: _reportLabel(l, e.report),
                    subtitle: [
                      formatDay(context, e.date),
                      if (e.note != null) e.note!,
                    ].join(' · '),
                    onDelete: () => _delete(e),
                  ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => _add(report: true),
                    icon: const Icon(Icons.add),
                    label: Text(l.cnCtxAddReport),
                  ),
                ),
              ],
            ),
    );
  }
}

String _reportLabel(AppLocalizations l, String? code) => switch (code) {
  'strong_exhaust' => l.cnReportExhaust,
  'water_intrusion' => l.cnReportWater,
  'damp_musty' => l.cnReportDamp,
  _ => code ?? '',
};

class _EntryTile extends StatelessWidget {
  const _EntryTile({
    required this.title,
    required this.subtitle,
    required this.onDelete,
  });

  final String title;
  final String subtitle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CnCard(
        padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: CnColors.muted, fontSize: 14),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: l.cnDelete,
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddSheet extends StatefulWidget {
  const _AddSheet({required this.report});

  final bool report;

  @override
  State<_AddSheet> createState() => _AddSheetState();
}

class _AddSheetState extends State<_AddSheet> {
  final _form = GlobalKey<FormState>();
  late DateTime _date = _today();
  String _kind = 'pm25';
  String _report = 'strong_exhaust';
  final _value = TextEditingController();
  final _source = TextEditingController();
  final _place = TextEditingController();
  final _note = TextEditingController();
  bool _saving = false;
  String? _error;

  static DateTime _today() {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  @override
  void dispose() {
    _value.dispose();
    _source.dispose();
    _place.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_form.currentState!.validate()) return;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final uid = SupabaseService.currentUser!.id;
      final row = <String, Object?>{
        'patient_id': uid,
        'local_date': isoDate(_date),
      };
      if (widget.report) {
        row.addAll({
          'kind': 'user_report',
          'report_code': _report,
          'value_kind': 'user_report',
          if (_note.text.trim().isNotEmpty) 'note': _note.text.trim(),
        });
      } else {
        final v = double.parse(_value.text.trim());
        row.addAll({
          'kind': _kind,
          'value_kind': 'observation',
          'source_name': _source.text.trim(),
          if (_place.text.trim().isNotEmpty) 'place_label': _place.text.trim(),
          'observed_at': DateTime(
            _date.year,
            _date.month,
            _date.day,
            12,
          ).toUtc().toIso8601String(),
          if (_kind == 'pm25') ...{
            'aqi_value': v.round(),
            'unit': 'AQI',
          } else ...{
            'numeric_value': v,
            'unit': _kind == 'no2' ? 'ppb' : '%',
          },
        });
      }
      await SupabaseService.client.from('local_context_entries').insert(row);
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() => _error = AppLocalizations.of(context)!.cnErrNetwork);
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.report ? l.cnCtxAddReport : l.cnCtxAddReading,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(_date.year - 1),
                    lastDate: _today(),
                  );
                  if (d != null) setState(() => _date = d);
                },
                icon: const Icon(Icons.event),
                label: Text(l.cnOnDate(formatDay(context, _date))),
              ),
              const SizedBox(height: 12),
              if (widget.report) ...[
                RadioGroup<String>(
                  groupValue: _report,
                  onChanged: (v) => setState(() => _report = v ?? _report),
                  child: Column(
                    children: [
                      for (final c in const [
                        'strong_exhaust',
                        'water_intrusion',
                        'damp_musty',
                      ])
                        RadioListTile<String>(
                          value: c,
                          title: Text(_reportLabel(l, c)),
                          contentPadding: EdgeInsets.zero,
                        ),
                    ],
                  ),
                ),
                TextFormField(
                  controller: _note,
                  maxLength: 300,
                  decoration: InputDecoration(labelText: l.cnNoteOptional),
                ),
              ] else ...[
                DropdownButtonFormField<String>(
                  initialValue: _kind,
                  decoration: InputDecoration(labelText: l.cnCtxWhat),
                  items: [
                    DropdownMenuItem(value: 'pm25', child: Text(l.cnCtxPm25)),
                    DropdownMenuItem(value: 'no2', child: Text(l.cnCtxNo2)),
                    DropdownMenuItem(
                      value: 'outdoor_humidity',
                      child: Text(l.cnCtxOutdoorHumidity),
                    ),
                  ],
                  onChanged: (v) => setState(() => _kind = v ?? _kind),
                ),
                if (_kind == 'outdoor_humidity')
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      l.cnCtxHumidityNote,
                      style: const TextStyle(
                        color: CnColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _value,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  decoration: InputDecoration(
                    labelText: l.cnCtxValue,
                    suffixText: switch (_kind) {
                      'pm25' => 'AQI',
                      'no2' => 'ppb',
                      _ => '%',
                    },
                  ),
                  validator: (v) {
                    final x = double.tryParse((v ?? '').trim());
                    if (x == null || x < 0) return l.cnCtxValueInvalid;
                    if (_kind == 'pm25' && x > 999) return l.cnCtxValueInvalid;
                    if (_kind == 'outdoor_humidity' && x > 100) {
                      return l.cnCtxValueInvalid;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _source,
                  maxLength: 120,
                  decoration: InputDecoration(
                    labelText: l.cnCtxSource,
                    helperText: l.cnCtxSourceHelp,
                  ),
                  validator: (v) =>
                      (v ?? '').trim().isEmpty ? l.cnCtxSourceRequired : null,
                ),
                TextFormField(
                  controller: _place,
                  maxLength: 120,
                  decoration: InputDecoration(labelText: l.cnCtxPlace),
                ),
              ],
              if (_error != null)
                Text(_error!, style: const TextStyle(color: CnColors.warn)),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: _saving ? null : _save,
                child: Text(l.cnSave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
