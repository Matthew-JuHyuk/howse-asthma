import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/care_report_repository.dart';
import '../data/records_revision.dart';
import '../data/regimen_repository.dart';
import '../data/snapshot_repository.dart';
import '../domain/evidence_prep.dart';
import '../domain/record_models.dart';
import '../domain/record_summary.dart';
import '../data/records_loader.dart';

/// General packet for a clinician. Not an insurer requirement checklist.
class EvidencePrepScreen extends StatefulWidget {
  const EvidencePrepScreen({super.key});

  @override
  State<EvidencePrepScreen> createState() => _EvidencePrepScreenState();
}

class _EvidencePrepScreenState extends State<EvidencePrepScreen> {
  List<PrepItem>? _items;
  bool _failed = false;

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
      final range = RecordRange.lastDays(30);
      final results = await Future.wait([
        RecordsLoader().load(range),
        RegimenRepository().listAll(),
        RegimenRepository().listBetween(range.start, range.end),
        SnapshotRepository().listRecent(),
        CareReportRepository().listRecent(),
      ]);
      final bundle = results[0] as RecordBundle;
      final regimens = results[1] as List<MedicationRegimen>;
      final checks = results[2] as List<OccasionCheck>;
      final snaps = results[3] as List<EnvSnapshot>;
      final visits = results[4] as List<CareReport>;
      final summary = RecordSummary.compute(range, bundle);
      final items = EvidencePrep.assess(
        hasPrescription: regimens.isNotEmpty,
        confirmedUseResponses: checks.length,
        hasSymptoms: summary.symptomDays > 0 || summary.noSymptomDays > 0,
        careReports: visits.length,
        clinicianConfirmedVisits: visits
            .where((v) => v.clinicianConfirmed)
            .length,
        attachments: visits.where((v) => v.hasAttachment).length,
        linkedEnvironment: snaps.where((s) => s.linked).length,
      );
      if (mounted) {
        setState(() {
          _items = items;
          _failed = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  Future<void> _addVisit() async {
    final l10n = AppLocalizations.of(context)!;
    var kind = 'er';
    var paper = false;
    final noteCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(l10n.s6AddVisit),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                isExpanded: true,
                value: kind,
                items: [
                  DropdownMenuItem(value: 'er', child: Text(l10n.s6VisitKindEr)),
                  DropdownMenuItem(
                    value: 'urgent_care',
                    child: Text(l10n.s6VisitKindUrgent),
                  ),
                  DropdownMenuItem(
                    value: 'office',
                    child: Text(l10n.s6VisitKindOffice),
                  ),
                  DropdownMenuItem(
                    value: 'other',
                    child: Text(l10n.s6VisitKindOther),
                  ),
                ],
                onChanged: (v) => setLocal(() => kind = v ?? kind),
              ),
              TextField(
                controller: noteCtrl,
                maxLength: 1000,
                decoration: InputDecoration(labelText: l10n.s5FieldNote),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l10n.s6BringPaper),
                subtitle: Text(l10n.s6BringPaperHint),
                value: paper,
                onChanged: (v) => setLocal(() => paper = v),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.s5Cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(l10n.s5Save),
            ),
          ],
        ),
      ),
    );
    final note = noteCtrl.text;
    noteCtrl.dispose();
    if (ok != true || !mounted) return;
    try {
      await CareReportRepository().add(
        occurredAt: DateTime.now(),
        kind: kind,
        note: note,
        hasAttachment: paper,
      );
      RecordsRevision.instance.bump();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.s5SaveFailed)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(title: Text(l10n.s6EvidenceTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(l10n.s6EvidenceBody, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          Text(
            l10n.s6EvidenceNotOfficial,
            style: const TextStyle(color: AppTheme.neutral700),
          ),
          const SizedBox(height: 16),
          if (_failed)
            Text(l10n.s5RecordsLoadFailed)
          else if (_items == null)
            const LinearProgressIndicator()
          else
            for (final item in _items!)
              Card(
                child: ListTile(
                  title: Text(_itemTitle(l10n, item.id)),
                  subtitle: Text(_status(l10n, item.status)),
                ),
              ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: _addVisit,
            child: Text(l10n.s6AddVisit),
          ),
        ],
      ),
    );
  }

  String _itemTitle(AppLocalizations l10n, String id) => switch (id) {
    'medication' => l10n.s6ItemMedication,
    'use' => l10n.s6ItemUse,
    'symptoms' => l10n.s6ItemSymptoms,
    'visits' => l10n.s6ItemVisits,
    'environment' => l10n.s6ItemEnvironment,
    _ => l10n.s6ItemClinician,
  };

  String _status(AppLocalizations l10n, PrepStatus status) => switch (status) {
    PrepStatus.recorded => l10n.s6StatusRecorded,
    PrepStatus.needInfo => l10n.s6StatusNeedInfo,
    PrepStatus.clinicianNeeded => l10n.s6StatusClinician,
  };
}
