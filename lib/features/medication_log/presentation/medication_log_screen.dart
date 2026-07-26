import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../assessments/presentation/act_screen.dart';
import '../../assessments/presentation/pdc_screen.dart';

/// SCR-PAT-LOG — inhaler timeline with filters. Placeholder events.
class MedicationLogScreen extends StatefulWidget {
  const MedicationLogScreen({super.key});

  @override
  State<MedicationLogScreen> createState() => _MedicationLogScreenState();
}

class _MedicationLogScreenState extends State<MedicationLogScreen> {
  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filters = ['All', 'Rescue', 'Controller', 'Missed'];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.brand600,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.air, color: Colors.white, size: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
                      const Text('SCR-PAT-LOG', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Inhaler Log', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            Text(
              l10n.medicationLogTitle,
              style: const TextStyle(color: AppTheme.subtext),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < filters.length; i++) ...[
                    if (i > 0) const SizedBox(width: 8),
                    ChoiceChip(
                      label: Text(filters[i]),
                      selected: _filter == i,
                      onSelected: (_) => setState(() => _filter = i),
                      selectedColor: AppTheme.brand600,
                      labelStyle: TextStyle(
                        color: _filter == i ? Colors.white : AppTheme.neutral600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.brand50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.bar_chart, color: AppTheme.brand600, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text('7 uses this week', style: TextStyle(fontSize: 12, color: AppTheme.brand700)),
                  ),
                  Text('5 rescue | 2 controller', style: TextStyle(fontSize: 12, color: AppTheme.brand600)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.quiz_outlined, color: AppTheme.brand600),
                    title: Text(l10n.mockActSurvey),
                    subtitle: Text(l10n.mockActHint),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ActScreen()));
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.task_alt_outlined, color: AppTheme.brand600),
                    title: Text(l10n.mockPdcCheck),
                    subtitle: Text(l10n.mockPdcHint),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const PdcScreen()));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Text('Today', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(width: 8),
                Text('Jul 25', style: TextStyle(fontSize: 12, color: AppTheme.neutral400)),
              ],
            ),
            const SizedBox(height: 8),
            _logCard('Albuterol', 'Rescue', '8:15 AM', '2 puffs', 'Wheezing before use', true),
            _logCard('Fluticasone', 'Controller', '7:00 AM', '1 puff', 'Morning routine', false),
            const SizedBox(height: 8),
            const Row(
              children: [
                Text('Yesterday', style: TextStyle(fontWeight: FontWeight.w700)),
                SizedBox(width: 8),
                Text('Jul 24', style: TextStyle(fontSize: 12, color: AppTheme.neutral400)),
              ],
            ),
            const SizedBox(height: 8),
            _logCard('Albuterol', 'Rescue', '9:30 PM', '2 puffs', 'Shortness of breath', true),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddLogSheet(context, l10n),
        icon: const Icon(Icons.add),
        label: Text(l10n.medicationLogAddButton),
      ),
    );
  }

  Widget _logCard(
    String name,
    String type,
    String time,
    String dose,
    String note,
    bool rescue,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.neutral0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.w700))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: rescue ? AppTheme.brand100 : AppTheme.neutral100,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 11,
                    color: rescue ? AppTheme.brand700 : AppTheme.neutral600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('$time · $dose', style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: rescue ? AppTheme.warning50 : const Color(0xFFECFDF5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              note,
              style: TextStyle(
                fontSize: 12,
                color: rescue ? AppTheme.warning700 : AppTheme.success600,
              ),
            ),
          ),
        ],
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
