import 'package:flutter/material.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../records/data/records_revision.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
import '../ui/brand.dart';
import 'preparation_strings.dart';

/// Home-ready actions explicitly target the selected case's care subject.
class HomePreparationLog extends StatefulWidget {
  const HomePreparationLog({
    super.key,
    required this.preparation,
    required this.onVoice,
    this.repository,
  });
  final Preparation preparation;
  final VoidCallback onVoice;
  final PreparationRepository? repository;
  @override
  State<HomePreparationLog> createState() => _HomePreparationLogState();
}

class _HomePreparationLogState extends State<HomePreparationLog> {
  late final PreparationRepository _repo =
      widget.repository ?? PreparationRepository();
  List<TreatmentEvent> _events = [];
  bool _busy = false;
  String? _message;
  @override
  void initState() {
    super.initState();
    RecordsRevision.instance.addListener(_load);
    _load();
  }

  @override
  void didUpdateWidget(HomePreparationLog old) {
    super.didUpdateWidget(old);
    if (old.preparation.id != widget.preparation.id) _load();
  }

  @override
  void dispose() {
    RecordsRevision.instance.removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final events = await _repo.events();
      if (mounted) setState(() => _events = events);
    } catch (_) {
      if (mounted) setState(() => _message = s10(context, 'error'));
    }
  }

  Future<void> _log(String kind) async {
    if (_busy) return;
    final p = widget.preparation;
    String? symptom;
    if (kind == 'symptom') {
      symptom = await showModalBottomSheet<String>(
        context: context,
        builder: (c) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final x in ['cough', 'night'])
                ListTile(
                  title: Text(s10(c, x)),
                  onTap: () => Navigator.pop(c, x),
                ),
            ],
          ),
        ),
      );
      if (symptom == null) return;
    }
    if (!mounted) return;
    if (kind == 'scheduled' &&
        _events.any(
          (e) =>
              !e.undone &&
              e.patientKey == p.patientKey &&
              e.kind == 'medication_use' &&
              e.day == dayKey(_repo.today) &&
              e.values['use_kind'] == 'scheduled',
        )) {
      final ok = await showDialog<bool>(
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
      if (ok != true) return;
    }
    if (!mounted) return;
    setState(() => _busy = true);
    final source = preparationId();
    try {
      final synced = await _repo.record([
        TreatmentEvent(
          id: preparationId(),
          patientKey: p.patientKey,
          kind: kind == 'symptom' ? 'symptom' : 'medication_use',
          day: dayKey(_repo.today),
          sourceId: source,
          synthetic: _repo.demo,
          text: kind == 'symptom'
              ? 'Patient reported ${symptom == 'night' ? 'night waking, count unknown' : 'cough'}.'
              : 'Patient confirmed ${kind == 'scheduled' ? 'scheduled' : 'as-needed'} medicine use; quantity unknown.',
          values: {
            'selected_patient_name': p.patientName,
            'input_path': 'home',
            'occurred_at': _repo.today.toUtc().toIso8601String(),
            'symptom': symptom == 'night' ? 'night_waking' : 'cough',
            'use_kind': kind == 'scheduled' ? 'scheduled' : 'as_needed',
            'medication': kind == 'scheduled' && p.currentMedication.isNotEmpty
                ? p.currentMedication
                : null,
            'quantity': null,
            'unit': null,
          },
        ),
      ]);
      await _load();
      if (!mounted) return;
      setState(() => _message = s10(context, synced ? 'saved' : 'pending'));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_message!),
          action: SnackBarAction(
            label: s10(context, 'undo'),
            onPressed: () async {
              await _repo.undo(source);
              await _load();
            },
          ),
        ),
      );
    } catch (_) {
      if (mounted) setState(() => _message = s10(context, 'error'));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.preparation;
    final owner = SupabaseService.currentUser?.id;
    if (!_repo.demo &&
        (owner == null ||
            !(p.patientKey == owner || p.patientKey.startsWith('$owner/')))) {
      return const SizedBox.shrink();
    }
    return CnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            p.patientName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            s10(context, 'voiceGuide'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            s10(context, 'voiceExample'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(64),
            ),
            onPressed: _busy ? null : widget.onVoice,
            icon: const Icon(Icons.mic_rounded, size: 32),
            label: Text(s10(context, 'voice')),
          ),
          const SizedBox(height: 8),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: Text(s10(context, 'tapInstead')),
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: _busy ? null : () => _log('scheduled'),
                    child: Text(s10(context, 'scheduled')),
                  ),
                  OutlinedButton(
                    onPressed: _busy ? null : () => _log('as_needed'),
                    child: Text(s10(context, 'rescue')),
                  ),
                  OutlinedButton(
                    onPressed: _busy ? null : () => _log('symptom'),
                    child: Text(s10(context, 'symptom')),
                  ),
                ],
              ),
            ],
          ),
          if (_message != null)
            Text(_message!, style: const TextStyle(color: CnColors.muted)),
        ],
      ),
    );
  }
}
