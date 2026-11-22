import 'package:flutter/material.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
import '../domain/quick_medication.dart';
import '../../records/presentation/my_medications_screen.dart';
import '../../records/data/records_revision.dart';
import '../ui/brand.dart';
import 'preparation_strings.dart';

/// A tap reports use, never a prescribed dose or an inferred medicine name.
class QuickTreatmentActions extends StatefulWidget {
  const QuickTreatmentActions({
    super.key,
    required this.repository,
    required this.patientKey,
    required this.patientName,
    this.onSaved,
    this.compact = false,
  });
  final PreparationRepository repository;
  final String patientKey, patientName;
  final VoidCallback? onSaved;
  final bool compact;
  @override
  State<QuickTreatmentActions> createState() => _QuickTreatmentActionsState();
}

class _QuickTreatmentActionsState extends State<QuickTreatmentActions> {
  bool _busy = false;
  List<QuickMedication>? _medications;
  bool _loadFailed = false;
  @override
  void initState() {
    super.initState();
    RecordsRevision.instance.addListener(_loadMedications);
    _loadMedications();
  }

  @override
  void dispose() {
    RecordsRevision.instance.removeListener(_loadMedications);
    super.dispose();
  }

  Future<void> _loadMedications() async {
    final owner = widget.repository.uid;
    try {
      final meds = await widget.repository.quickMedications(widget.patientKey);
      if (mounted && widget.repository.uid == owner) {
        setState(() {
          _medications = meds;
          _loadFailed = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loadFailed = true);
    }
  }

  List<QuickMedication> _choices(String kind) {
    final meds = _medications ?? const <QuickMedication>[];
    final matched = meds.where((m) => m.supports(kind)).toList();
    return matched.isNotEmpty
        ? matched
        : meds.where((m) => m.role == null).toList();
  }

  String _medicineLabel(QuickMedication med) =>
      '${med.name}${med.puffs == null ? '' : ' · ${med.puffs} ${s10(context, 'puffUnit')}'}';
  String _buttonLabel(String kind) {
    final choices = _choices(kind);
    final title = s10(context, kind == 'scheduled' ? 'scheduled' : 'rescue');
    return choices.length == 1
        ? '$title\n${_medicineLabel(choices.single)}'
        : title;
  }

  Future<QuickMedication?> _choose(String kind) async {
    final choices = _choices(kind);
    if (choices.length == 1) return choices.single;
    if (choices.isEmpty) return null;
    return showModalBottomSheet<QuickMedication>(
      context: context,
      isScrollControlled: true,
      builder: (c) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(c).height * .7,
          ),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                s10(c, 'chooseMedicine'),
                style: Theme.of(c).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              for (final med in choices)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(c, med),
                    child: Text(_medicineLabel(med)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _record(String kind) async {
    if (_busy) return;
    final repo = widget.repository;
    final patient = widget.patientKey;
    final owner = repo.uid;
    final now = repo.today;
    setState(() => _busy = true);
    try {
      final medication = await _choose(kind);
      if (medication == null || !mounted || repo.uid != owner) return;
      final events = await repo.events();
      if (!mounted || repo.uid != owner) return;
      if (kind == 'scheduled' &&
          events.any(
            (e) =>
                !e.undone &&
                e.patientKey == patient &&
                e.day == dayKey(now) &&
                e.kind == 'medication_use' &&
                (e.values['medication_id'] == medication.id ||
                    e.values['medication'] == medication.name) &&
                e.values['use_kind'] == kind,
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
        if (additional != true || !mounted || repo.uid != owner) return;
      }
      final source = preparationId();
      final synced = await repo.record([
        TreatmentEvent(
          id: preparationId(),
          patientKey: patient,
          kind: 'medication_use',
          day: dayKey(now),
          sourceId: source,
          synthetic: repo.demo,
          text:
              '${s10(context, kind == 'scheduled' ? 'scheduled' : 'rescue')}: ${_medicineLabel(medication)}',
          values: {
            'input_path': 'quick',
            'occurred_at': now.toUtc().toIso8601String(),
            'language': Localizations.localeOf(context).toLanguageTag(),
            'use_kind': kind,
            'medication': medication.name,
            'medication_id': medication.id,
            'regimen_id': medication.regimenId,
            'quantity': medication.puffs,
            'unit': medication.puffs == null ? null : 'puffs',
            'quantity_source': medication.puffs == null
                ? null
                : 'user_confirmed_visible_preset',
          },
        ),
      ]);
      if (!mounted || repo.uid != owner) return;
      widget.onSaved?.call();
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          persist: false,
          duration: const Duration(seconds: 4),
          content: Text(s10(context, synced ? 'saved' : 'pending')),
          action: SnackBarAction(
            label: s10(context, 'undo'),
            onPressed: () async {
              try {
                if (repo.uid != owner) return;
                await repo.undo(source);
                if (mounted && repo.uid == owner) widget.onSaved?.call();
              } catch (_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(s10(context, 'error'))),
                  );
                }
              }
            },
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
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadFailed) {
      return TextButton.icon(
        onPressed: _loadMedications,
        icon: const Icon(Icons.refresh),
        label: Text(s10(context, 'retry')),
      );
    }
    if (_medications == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: LinearProgressIndicator(),
      );
    }
    if (_medications!.isEmpty) {
      return CnCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(s10(context, 'registerMedicineHint')),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: widget.repository.demo
                  ? null
                  : () async {
                      await Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MyMedicationsScreen(),
                        ),
                      );
                      if (mounted) await _loadMedications();
                    },
              icon: const Icon(Icons.medication_outlined),
              label: Text(s10(context, 'registerMedicine')),
            ),
          ],
        ),
      );
    }
    if (widget.compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            s10(context, 'quickToday'),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: CnColors.muted,
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            key: const ValueKey('quick-scheduled'),
            onPressed: _busy || _choices('scheduled').isEmpty
                ? null
                : () => _record('scheduled'),
            icon: const Icon(Icons.medication_outlined),
            label: Text(_buttonLabel('scheduled'), textAlign: TextAlign.center),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            key: const ValueKey('quick-rescue'),
            onPressed: _busy || _choices('as_needed').isEmpty
                ? null
                : () => _record('as_needed'),
            icon: const Icon(Icons.air),
            label: Text(_buttonLabel('as_needed'), textAlign: TextAlign.center),
          ),
          if (_busy) ...[
            const SizedBox(height: 8),
            const LinearProgressIndicator(),
          ],
        ],
      );
    }
    return CnCard(
      color: CnColors.mint,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const CnIconWell(Icons.today_outlined, background: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s10(context, 'quickToday'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${widget.patientName} · ${MaterialLocalizations.of(context).formatMediumDate(widget.repository.today)}',
                      style: const TextStyle(color: CnColors.ink),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            key: const ValueKey('quick-scheduled'),
            onPressed: _busy || _choices('scheduled').isEmpty
                ? null
                : () => _record('scheduled'),
            icon: const Icon(Icons.medication_outlined),
            label: Text(_buttonLabel('scheduled'), textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            key: const ValueKey('quick-rescue'),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: CnColors.teal.withValues(alpha: 0.35)),
            ),
            onPressed: _busy || _choices('as_needed').isEmpty
                ? null
                : () => _record('as_needed'),
            icon: const Icon(Icons.air),
            label: Text(_buttonLabel('as_needed'), textAlign: TextAlign.center),
          ),
          const SizedBox(height: 12),
          Text(
            s10(context, 'quickUseHint'),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (_busy) ...[
            const SizedBox(height: 12),
            const LinearProgressIndicator(),
          ],
        ],
      ),
    );
  }
}
