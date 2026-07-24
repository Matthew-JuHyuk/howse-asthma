import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Lets the patient log every use of an inhaler / controller medication,
/// including whether it relieved symptoms. This history is what gets
/// exported later for the insurance "step therapy failure" report.
///
/// TODO: persist entries to Supabase (table e.g. `medication_logs`) and
/// list them here ordered by time, grouped by day.
class MedicationLogScreen extends StatelessWidget {
  const MedicationLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.medicationLogTitle)),
      body: Center(
        child: Text(
          l10n.medicationLogTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddLogSheet(context, l10n),
        icon: const Icon(Icons.add),
        label: Text(l10n.medicationLogAddButton),
      ),
    );
  }

  void _showAddLogSheet(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.medicationLogAddButton, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(decoration: InputDecoration(labelText: l10n.medicationNameLabel)),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: l10n.medicationDoseLabel)),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: l10n.medicationTimeLabel)),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: l10n.medicationEffectivenessLabel)),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
