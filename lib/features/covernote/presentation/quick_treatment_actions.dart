import 'package:flutter/material.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
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
  });
  final PreparationRepository repository;
  final String patientKey, patientName;
  final VoidCallback? onSaved;
  @override
  State<QuickTreatmentActions> createState() => _QuickTreatmentActionsState();
}

class _QuickTreatmentActionsState extends State<QuickTreatmentActions> {
  bool _busy = false;
  Future<void> _record(String kind) async {
    if (_busy) return;
    final repo = widget.repository;
    final patient = widget.patientKey;
    final owner = repo.uid;
    final now = repo.today;
    setState(() => _busy = true);
    try {
      final events = await repo.events();
      if (!mounted || repo.uid != owner) return;
      if (kind == 'scheduled' &&
          events.any(
            (e) =>
                !e.undone &&
                e.patientKey == patient &&
                e.day == dayKey(now) &&
                e.kind == 'medication_use' &&
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
          text: s10(
            context,
            kind == 'scheduled' ? 'scheduledReport' : 'rescueReport',
          ),
          values: {
            'input_path': 'quick',
            'occurred_at': now.toUtc().toIso8601String(),
            'language': Localizations.localeOf(context).toLanguageTag(),
            'use_kind': kind,
            'medication': null,
            'quantity': null,
            'unit': null,
          },
        ),
      ]);
      if (!mounted || repo.uid != owner) return;
      widget.onSaved?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
  Widget build(BuildContext context) => CnCard(
    color: CnColors.mint,
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          s10(context, 'quickToday'),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          '${widget.patientName} · ${MaterialLocalizations.of(context).formatMediumDate(widget.repository.today)}',
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          key: const ValueKey('quick-scheduled'),
          onPressed: _busy ? null : () => _record('scheduled'),
          icon: const Icon(Icons.medication_outlined),
          label: Text(s10(context, 'scheduled')),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          key: const ValueKey('quick-rescue'),
          onPressed: _busy ? null : () => _record('as_needed'),
          icon: const Icon(Icons.air),
          label: Text(s10(context, 'rescue')),
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
