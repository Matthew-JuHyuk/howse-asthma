import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/location/location_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../assessments/data/pdc_repository.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../data/medication_repository.dart';
import '../data/records_revision.dart';
import '../data/snapshot_repository.dart';
import '../data/symptom_repository.dart';
import '../domain/record_models.dart';

/// Shared record inputs used by Home and My log (one component per type).
class RecordInputs {
  RecordInputs._();

  static bool _quickBusy = false;

  /// One tap = one inhaler-use entry. With a default medication it saves at
  /// once (undo / add details offered); otherwise the full sheet opens.
  static Future<void> logInhaler(BuildContext context) async {
    if (_quickBusy) return;
    _quickBusy = true;
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    try {
      PatientMedication? def;
      try {
        def = await MedicationRepository().defaultMedication();
      } catch (_) {}
      if (!context.mounted) return;
      if (def == null) {
        await editInhaler(context);
        return;
      }
      final repo = InhalerEventRepository();
      final loc = await const LocationService().getCurrentPosition(
        requestIfDenied: false,
      );
      Map<String, dynamic> row;
      try {
        row = await repo.logUse(
          latitude: loc.position?.latitude,
          longitude: loc.position?.longitude,
          clientRequestId: newRequestId(),
          medicationLabel: def.displayName,
          medicationStatus: InhalerRecord.statusIdentified,
          sourceLanguage: lang,
        );
      } catch (_) {
        messenger.showSnackBar(SnackBar(content: Text(l10n.s5SaveFailed)));
        return;
      }
      RecordsRevision.instance.bump();
      final record = InhalerRecord.fromRow(row);
      if (!context.mounted) return;
      messenger.hideCurrentSnackBar();
      var undone = false;
      messenger.showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 8),
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            children: [
              Text(l10n.s5InhalerLogged),
              TextButton(
                onPressed: () async {
                  if (undone) return;
                  undone = true;
                  messenger.hideCurrentSnackBar();
                  try {
                    await repo.voidEvent(record.id);
                    RecordsRevision.instance.bump();
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.s5EntryRemoved)),
                    );
                  } catch (_) {
                    messenger.showSnackBar(
                      SnackBar(content: Text(l10n.s5DeleteFailed)),
                    );
                  }
                },
                child: Text(l10n.s5Undo),
              ),
              TextButton(
                onPressed: () {
                  messenger.hideCurrentSnackBar();
                  if (context.mounted) {
                    editInhaler(context, existing: record);
                  }
                },
                child: Text(l10n.s5AddDetails),
              ),
            ],
          ),
        ),
      );
    } finally {
      _quickBusy = false;
    }
  }

  static Future<bool> editInhaler(
    BuildContext context, {
    InhalerRecord? existing,
  }) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _InhalerSheet(existing: existing),
    );
    return saved == true;
  }

  static Future<bool> editSymptoms(
    BuildContext context, {
    SymptomRecord? existing,
  }) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _SymptomSheet(existing: existing),
    );
    return saved == true;
  }

  static Future<bool> editMedCheck(
    BuildContext context, {
    MedCheckRecord? existing,
  }) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _MedCheckSheet(existing: existing),
    );
    return saved == true;
  }

  static Future<bool> confirmDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.s5DeleteConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.s5Cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppTheme.error600),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.s5Delete),
          ),
        ],
      ),
    );
    return ok == true;
  }
}

// ---------------------------------------------------------------------------
// Shared sheet chrome
// ---------------------------------------------------------------------------

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({
    required this.title,
    required this.children,
    required this.saving,
    required this.canSave,
    required this.onSave,
    this.error,
    this.onDelete,
  });

  final String title;
  final List<Widget> children;
  final bool saving;
  final bool canSave;
  final VoidCallback onSave;
  final String? error;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scroll) => Column(
          children: [
            Expanded(
              child: ListView(
                controller: scroll,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (onDelete != null)
                        IconButton(
                          tooltip: l10n.s5Delete,
                          onPressed: saving ? null : onDelete,
                          icon: const Icon(Icons.delete_outline),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...children,
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          error!,
                          style: const TextStyle(color: AppTheme.error600),
                        ),
                      ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                      ),
                      onPressed: (saving || !canSave) ? null : onSave,
                      child: saving
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.s5Save),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16, bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  );
}

class _TimeField extends StatelessWidget {
  const _TimeField({required this.value, required this.onChanged});
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final text = DateFormat.yMMMd(locale).add_jm().format(value);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.schedule, color: AppTheme.brand600),
      title: Text(text),
      trailing: TextButton(
        onPressed: () async {
          final now = DateTime.now();
          final d = await showDatePicker(
            context: context,
            initialDate: value,
            firstDate: now.subtract(const Duration(days: 30)),
            lastDate: now,
          );
          if (d == null || !context.mounted) return;
          final t = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(value),
          );
          if (t == null) return;
          var picked = DateTime(d.year, d.month, d.day, t.hour, t.minute);
          if (picked.isAfter(now)) picked = now;
          onChanged(picked);
        },
        child: Text(l10n.s5Change),
      ),
    );
  }
}

String _saveErrorText(AppLocalizations l10n) => l10n.s5SaveFailed;

// ---------------------------------------------------------------------------
// Inhaler use
// ---------------------------------------------------------------------------

class _InhalerSheet extends StatefulWidget {
  const _InhalerSheet({this.existing});
  final InhalerRecord? existing;

  @override
  State<_InhalerSheet> createState() => _InhalerSheetState();
}

class _InhalerSheetState extends State<_InhalerSheet> {
  static const _unknown = '__unknown__';
  static const _other = '__other__';

  final _repo = InhalerEventRepository();
  final _otherCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();

  /// Stable across retries so a resend never creates a second entry.
  final _requestId = newRequestId();

  List<PatientMedication> _meds = const [];
  String? _medChoice;
  int? _puffs;
  String? _reason;
  late DateTime _time;
  bool _saving = false;
  String? _error;

  bool get _isEdit => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _time = e?.localTime ?? DateTime.now();
    _puffs = e?.puffCount;
    _reason = e?.useReason;
    _noteCtrl.text = e?.note ?? '';
    if (e != null) {
      if (e.medicationUnknown) {
        _medChoice = _unknown;
      } else if (e.medicationLabel != null) {
        _medChoice = _other;
        _otherCtrl.text = e.medicationLabel!;
      }
    }
    _loadMeds();
  }

  Future<void> _loadMeds() async {
    try {
      final meds = await MedicationRepository().list();
      if (!mounted) return;
      setState(() {
        _meds = meds;
        final e = widget.existing;
        if (e?.medicationLabel != null) {
          for (final m in meds) {
            if (m.displayName == e!.medicationLabel) _medChoice = m.id;
          }
        } else if (e == null && _medChoice == null) {
          for (final m in meds) {
            if (m.isDefault) _medChoice = m.id;
          }
        }
      });
    } catch (_) {}
  }

  @override
  void dispose() {
    _otherCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  ({String? label, String? status}) _medication() {
    if (_medChoice == null) return (label: null, status: null);
    if (_medChoice == _unknown) {
      return (label: null, status: InhalerRecord.statusNotIdentified);
    }
    if (_medChoice == _other) {
      final t = _otherCtrl.text.trim();
      return t.isEmpty
          ? (label: null, status: null)
          : (label: t, status: InhalerRecord.statusIdentified);
    }
    final m = _meds.where((m) => m.id == _medChoice).firstOrNull;
    return m == null
        ? (label: null, status: null)
        : (label: m.displayName, status: InhalerRecord.statusIdentified);
  }

  bool get _canSave => _isEdit || _medication().status != null;

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    setState(() {
      _saving = true;
      _error = null;
    });
    final med = _medication();
    final note = _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim();
    try {
      if (_isEdit) {
        await _repo.updateDetails(
          id: widget.existing!.id,
          medicationLabel: med.label,
          medicationStatus: med.status,
          puffCount: _puffs,
          useReason: _reason,
          note: note,
          sourceLanguage: lang,
          recordedAt: _time,
        );
      } else {
        final loc = await const LocationService().getCurrentPosition(
          requestIfDenied: false,
        );
        await _repo.logUse(
          latitude: loc.position?.latitude,
          longitude: loc.position?.longitude,
          clientRequestId: _requestId,
          medicationLabel: med.label,
          medicationStatus: med.status,
          puffCount: _puffs,
          useReason: _reason,
          note: note,
          sourceLanguage: lang,
          recordedAt: _time,
        );
      }
      RecordsRevision.instance.bump();
      if (!mounted) return;
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isEdit ? l10n.s5Saved : l10n.s5InhalerLogged),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = _saveErrorText(l10n);
      });
    }
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context)!;
    if (!await RecordInputs.confirmDelete(context)) return;
    setState(() => _saving = true);
    try {
      await _repo.voidEvent(widget.existing!.id);
      RecordsRevision.instance.bump();
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = l10n.s5DeleteFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _SheetFrame(
      title: _isEdit ? l10n.s5InhalerEditTitle : l10n.s5LogInhaler,
      saving: _saving,
      canSave: _canSave,
      onSave: _save,
      error: _error,
      onDelete: _isEdit ? _delete : null,
      children: [
        Text(
          l10n.s5InhalerOneEntryHint,
          style: const TextStyle(color: AppTheme.neutral600),
        ),
        _SectionLabel(l10n.s5FieldTime),
        _TimeField(value: _time, onChanged: (t) => setState(() => _time = t)),
        _SectionLabel(l10n.s5FieldMedication),
        RadioGroup<String>(
          groupValue: _medChoice,
          onChanged: (v) => setState(() => _medChoice = v),
          child: Column(
            children: [
              for (final m in _meds)
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  value: m.id,
                  title: Text(m.displayName),
                ),
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                value: _other,
                title: Text(l10n.s5MedOther),
              ),
              if (_medChoice == _other)
                TextField(
                  controller: _otherCtrl,
                  maxLength: 120,
                  decoration: InputDecoration(hintText: l10n.s5MedOtherHint),
                  onChanged: (_) => setState(() {}),
                ),
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                value: _unknown,
                title: Text(l10n.s5MedUnknown),
              ),
            ],
          ),
        ),
        if (!_canSave)
          Text(
            l10n.s5MedChooseHint,
            style: const TextStyle(color: AppTheme.neutral600, fontSize: 14),
          ),
        _SectionLabel(l10n.s5FieldPuffs),
        DropdownButtonFormField<int?>(
          initialValue: _puffs,
          items: [
            DropdownMenuItem<int?>(value: null, child: Text(l10n.s5NotRecorded)),
            for (var i = 1; i <= 10; i++)
              DropdownMenuItem<int?>(value: i, child: Text('$i')),
          ],
          onChanged: (v) => setState(() => _puffs = v),
        ),
        _SectionLabel(l10n.s5FieldReason),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final r in InhalerRecord.reasons)
              ChoiceChip(
                label: Text(s5UseReasonLabel(l10n, r)),
                selected: _reason == r,
                onSelected: (sel) => setState(() => _reason = sel ? r : null),
              ),
          ],
        ),
        _SectionLabel(l10n.s5FieldNote),
        TextField(
          controller: _noteCtrl,
          maxLength: 1000,
          minLines: 2,
          maxLines: 5,
        ),
      ],
    );
  }
}

String s5UseReasonLabel(AppLocalizations l10n, String code) => switch (code) {
  'symptoms' => l10n.s5ReasonSymptoms,
  'before_activity' => l10n.s5ReasonBeforeActivity,
  _ => l10n.s5ReasonOther,
};

String s5SymptomLabel(AppLocalizations l10n, String code) => switch (code) {
  'cough' => l10n.s5SymCough,
  'wheeze' => l10n.s5SymWheeze,
  'short_breath' => l10n.s5SymShortBreath,
  'night_waking' => l10n.s5SymNightWaking,
  'activity_limited' => l10n.s5SymActivityLimited,
  _ => code,
};

String s5MedStatusLabel(AppLocalizations l10n, String status) =>
    switch (status) {
      MedCheckRecord.used => l10n.s5MedUsed,
      MedCheckRecord.notUsed => l10n.s5MedNotUsed,
      MedCheckRecord.notSure => l10n.s5MedNotSure,
      _ => l10n.s5MedNotApplicable,
    };

String s5MedReasonLabel(AppLocalizations l10n, String code) => switch (code) {
  'no_medicine' => l10n.s5MedReasonNoMedicine,
  'cost' => l10n.s5MedReasonCost,
  'forgot' => l10n.s5MedReasonForgot,
  'other' => l10n.s5ReasonOther,
  _ => l10n.s5NoAnswer,
};

// ---------------------------------------------------------------------------
// Symptoms
// ---------------------------------------------------------------------------

class _SymptomSheet extends StatefulWidget {
  const _SymptomSheet({this.existing});
  final SymptomRecord? existing;

  @override
  State<_SymptomSheet> createState() => _SymptomSheetState();
}

class _SymptomSheetState extends State<_SymptomSheet> {
  final _repo = SymptomRepository();
  final _otherCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final Set<String> _selected = {};
  bool _none = false;
  bool _otherOn = false;
  late DateTime _time;
  String? _homeWater;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _time = e?.localTime ?? DateTime.now();
    if (e != null) {
      _selected.addAll(e.symptoms);
      _none = e.noSymptoms;
      _otherCtrl.text = e.otherText ?? '';
      _otherOn = _otherCtrl.text.isNotEmpty;
      _noteCtrl.text = e.note ?? '';
      _homeWater = e.homeWater;
    }
  }

  @override
  void dispose() {
    _otherCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  bool get _canSave =>
      _none ||
      _selected.isNotEmpty ||
      (_otherOn && _otherCtrl.text.trim().isNotEmpty);

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final lang = Localizations.localeOf(context).languageCode;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final saved = await _repo.save(
        id: widget.existing?.id,
        recordedAt: widget.existing?.recordedAtUtc ?? DateTime.now(),
        occurredAt: _time,
        symptoms: SymptomRecord.codes.where(_selected.contains).toList(),
        noSymptoms: _none,
        otherText: _otherOn ? _otherCtrl.text : null,
        note: _noteCtrl.text,
        homeWater: _homeWater,
        sourceLanguage: lang,
      );
      final loc = await const LocationService().getCurrentPosition(
        requestIfDenied: false,
      );
      await SnapshotRepository().linkSymptom(
        symptomId: saved.id,
        occurredAt: saved.occurredAtUtc,
        latitude: loc.position?.latitude,
        longitude: loc.position?.longitude,
      );
      RecordsRevision.instance.bump();
      if (!mounted) return;
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.s5Saved)),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = _saveErrorText(l10n);
      });
    }
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context)!;
    if (!await RecordInputs.confirmDelete(context)) return;
    setState(() => _saving = true);
    try {
      await _repo.delete(widget.existing!.id);
      RecordsRevision.instance.bump();
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = l10n.s5DeleteFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _SheetFrame(
      title: widget.existing == null
          ? l10n.s5LogSymptoms
          : l10n.s5SymptomEditTitle,
      saving: _saving,
      canSave: _canSave,
      onSave: _save,
      error: _error,
      onDelete: widget.existing != null ? _delete : null,
      children: [
        _SectionLabel(l10n.s6OccurredLabel),
        _TimeField(value: _time, onChanged: (t) => setState(() => _time = t)),
        _SectionLabel(l10n.s6HomeWaterQuestion),
        Wrap(
          spacing: 8,
          children: [
            ChoiceChip(
              label: Text(l10n.s6HomeWaterYes),
              selected: _homeWater == 'yes',
              onSelected: (_) => setState(() => _homeWater = 'yes'),
            ),
            ChoiceChip(
              label: Text(l10n.s6HomeWaterNo),
              selected: _homeWater == 'no',
              onSelected: (_) => setState(() => _homeWater = 'no'),
            ),
            ChoiceChip(
              label: Text(l10n.s5NoAnswer),
              selected: _homeWater == 'no_answer',
              onSelected: (_) => setState(() => _homeWater = 'no_answer'),
            ),
          ],
        ),
        _SectionLabel(l10n.s5SymptomQuestion),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final code in SymptomRecord.codes)
              FilterChip(
                label: Text(s5SymptomLabel(l10n, code)),
                selected: _selected.contains(code),
                onSelected: (sel) => setState(() {
                  if (sel) {
                    _selected.add(code);
                    _none = false;
                  } else {
                    _selected.remove(code);
                  }
                }),
              ),
            FilterChip(
              label: Text(l10n.s5SymOther),
              selected: _otherOn,
              onSelected: (sel) => setState(() {
                _otherOn = sel;
                if (sel) _none = false;
              }),
            ),
            FilterChip(
              label: Text(l10n.s5SymNone),
              selected: _none,
              onSelected: (sel) => setState(() {
                _none = sel;
                if (sel) {
                  _selected.clear();
                  _otherOn = false;
                }
              }),
            ),
          ],
        ),
        if (_otherOn) ...[
          const SizedBox(height: 8),
          TextField(
            controller: _otherCtrl,
            maxLength: 300,
            decoration: InputDecoration(hintText: l10n.s5SymOtherHint),
            onChanged: (_) => setState(() {}),
          ),
        ],
        const SizedBox(height: 8),
        Text(
          l10n.s5SymptomNoneHint,
          style: const TextStyle(color: AppTheme.neutral600, fontSize: 14),
        ),
        _SectionLabel(l10n.s5FieldNote),
        TextField(
          controller: _noteCtrl,
          maxLength: 1000,
          minLines: 2,
          maxLines: 5,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Daily medication check-in (self-reported)
// ---------------------------------------------------------------------------

class _MedCheckSheet extends StatefulWidget {
  const _MedCheckSheet({this.existing});
  final MedCheckRecord? existing;

  @override
  State<_MedCheckSheet> createState() => _MedCheckSheetState();
}

class _MedCheckSheetState extends State<_MedCheckSheet> {
  final _repo = PdcRepository();
  late DateTime _date;
  String? _status;
  String? _reason;
  bool _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _date = e?.date ?? dateOnly(DateTime.now());
    _status = e?.status;
    _reason = e?.reason;
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await _repo.upsert(date: _date, status: _status!, reason: _reason);
      RecordsRevision.instance.bump();
      if (!mounted) return;
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.s5Saved)),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saving = false;
        _error = _saveErrorText(l10n);
      });
    }
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context)!;
    if (!await RecordInputs.confirmDelete(context)) return;
    setState(() => _saving = true);
    try {
      await _repo.delete(widget.existing!.id);
      RecordsRevision.instance.bump();
      if (mounted) Navigator.pop(context, true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = l10n.s5DeleteFailed;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final today = dateOnly(DateTime.now());
    return _SheetFrame(
      title: l10n.s5MedCheckTitle,
      saving: _saving,
      canSave: _status != null,
      onSave: _save,
      error: _error,
      onDelete: widget.existing != null ? _delete : null,
      children: [
        Text(
          l10n.s5MedCheckIntro,
          style: const TextStyle(color: AppTheme.neutral600),
        ),
        _SectionLabel(l10n.s5FieldDate),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 0; i < 7; i++)
              Builder(
                builder: (_) {
                  final d = today.subtract(Duration(days: i));
                  return ChoiceChip(
                    label: Text(
                      i == 0
                          ? l10n.s5Today
                          : DateFormat.MMMd(locale).format(d),
                    ),
                    selected: _date == d,
                    onSelected: widget.existing != null
                        ? null
                        : (_) => setState(() => _date = d),
                  );
                },
              ),
          ],
        ),
        _SectionLabel(l10n.s5MedCheckQuestion),
        RadioGroup<String>(
          groupValue: _status,
          onChanged: (v) => setState(() {
            _status = v;
            if (v != MedCheckRecord.notUsed) _reason = null;
          }),
          child: Column(
            children: [
              for (final s in MedCheckRecord.statuses)
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  value: s,
                  title: Text(s5MedStatusLabel(l10n, s)),
                ),
            ],
          ),
        ),
        if (_status == MedCheckRecord.notUsed) ...[
          _SectionLabel(l10n.s5MedReasonQuestion),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final r in MedCheckRecord.reasons)
                ChoiceChip(
                  label: Text(s5MedReasonLabel(l10n, r)),
                  selected: _reason == r,
                  onSelected: (sel) =>
                      setState(() => _reason = sel ? r : null),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
