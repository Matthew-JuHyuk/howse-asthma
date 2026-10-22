import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../records/data/medication_repository.dart';
import '../../records/data/records_revision.dart';
import '../../records/domain/record_models.dart';
import '../data/environment_collector.dart';
import '../data/medication_use_repository.dart';
import '../domain/s9_models.dart';
import '../ui/brand.dart';

/// One-tap scheduled / as-needed log used on Home and Records.
class QuickLogPanel extends StatefulWidget {
  const QuickLogPanel({super.key, this.day});

  /// Calendar day the use is stored on. Today records the current time.
  final DateTime? day;

  @override
  State<QuickLogPanel> createState() => _QuickLogPanelState();
}

class _QuickLogPanelState extends State<QuickLogPanel> {
  List<PatientMedication> _meds = const [];
  var _busy = false;

  @override
  void initState() {
    super.initState();
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
      final list = await MedicationRepository().list();
      if (mounted) setState(() => _meds = list);
    } catch (_) {}
  }

  Future<void> _log(PatientMedication? med, UseKind kind) async {
    if (_busy) return;
    setState(() => _busy = true);
    final l = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final event = await MedicationUseRepository().log(
        kind: kind,
        occurredAt: _when(),
        medicationId: med?.id,
        medicationName: med?.displayName,
        inputPath: 'home',
        clientRequestId: newRequestId(),
      );
      EnvironmentCollector().attachToEvent(
        eventKind: 'medication_use',
        eventId: event.id,
        occurredAt: event.occurredAt,
        localDate: event.localDate,
      );
      messenger.hideCurrentSnackBar();
      messenger.showSnackBar(
        SnackBar(
          content: Text(l.cnSaved),
          duration: const Duration(seconds: 4),
          persist: false,
          action: SnackBarAction(
            label: l.cnUndoUse,
            onPressed: () => MedicationUseRepository().undo(event),
          ),
        ),
      );
      RecordsRevision.instance.bump();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l.cnErrNetwork)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  DateTime _when() {
    final day = widget.day;
    final now = DateTime.now();
    if (day == null) return now;
    final selected = DateTime(day.year, day.month, day.day);
    final today = DateTime(now.year, now.month, now.day);
    if (!selected.isBefore(today)) return now;
    return DateTime(selected.year, selected.month, selected.day, 12);
  }

  bool get _futureDay {
    final day = widget.day;
    if (day == null) return false;
    final now = DateTime.now();
    return DateTime(day.year, day.month, day.day).isAfter(
      DateTime(now.year, now.month, now.day),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (_meds.isEmpty) {
      return CnCard(
        child: Text(l.cnMedManageHint, style: const TextStyle(fontSize: 15)),
      );
    }
    return Column(
      children: [
        for (final m in _meds)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CnCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: CnColors.ink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton(
                      onPressed: _busy || _futureDay
                          ? null
                          : () => _log(m, UseKind.unspecified),
                      child: Text(
                        l.cnUsedShort,
                        semanticsLabel: l.cnLogMedication(m.displayName),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
