import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/medication_repository.dart';
import '../data/records_revision.dart';
import '../domain/record_models.dart';
import 'record_inputs.dart';

/// Patient-confirmed medication names. Input convenience only — the app
/// never suggests a dose or a time to use a medicine.
class MyMedicationsScreen extends StatefulWidget {
  const MyMedicationsScreen({super.key});

  @override
  State<MyMedicationsScreen> createState() => _MyMedicationsScreenState();
}

class _MyMedicationsScreenState extends State<MyMedicationsScreen> {
  final _repo = MedicationRepository();
  List<PatientMedication>? _meds;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final meds = await _repo.list();
      if (mounted) {
        setState(() {
          _meds = meds;
          _failed = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    }
  }

  Future<void> _edit([PatientMedication? existing]) async {
    final l10n = AppLocalizations.of(context)!;
    final nameCtrl = TextEditingController(text: existing?.displayName ?? '');
    var isDefault = existing?.isDefault ?? (_meds?.isEmpty ?? true);
    var daily = existing?.dailyCheckEnabled ?? false;
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(existing == null ? l10n.s5MedAdd : l10n.s5MedEdit),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  maxLength: 120,
                  autofocus: true,
                  decoration: InputDecoration(labelText: l10n.s5MedNameLabel),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.s5MedDefault),
                  subtitle: Text(l10n.s5MedDefaultHint),
                  value: isDefault,
                  onChanged: (v) => setLocal(() => isDefault = v),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.s5MedDailyCheck),
                  subtitle: Text(l10n.s5MedDailyCheckHint),
                  value: daily,
                  onChanged: (v) => setLocal(() => daily = v),
                ),
              ],
            ),
          ),
          actions: [
            if (existing != null)
              TextButton(
                onPressed: () => Navigator.pop(ctx, 'delete'),
                child: Text(
                  l10n.s5Delete,
                  style: const TextStyle(color: AppTheme.error600),
                ),
              ),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.s5Cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, 'save'),
              child: Text(l10n.s5Save),
            ),
          ],
        ),
      ),
    );
    final name = nameCtrl.text.trim();
    nameCtrl.dispose();
    if (!mounted || result == null) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      if (result == 'delete') {
        if (!await RecordInputs.confirmDelete(context)) return;
        await _repo.delete(existing!.id);
      } else {
        if (name.isEmpty) return;
        await _repo.save(
          id: existing?.id,
          displayName: name,
          isDefault: isDefault,
          dailyCheckEnabled: daily,
        );
      }
      RecordsRevision.instance.bump();
      messenger.showSnackBar(SnackBar(content: Text(l10n.s5Saved)));
      await _load();
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.s5SaveFailed)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final meds = _meds;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(title: Text(l10n.s5MyMedsTitle)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(),
        icon: const Icon(Icons.add),
        label: Text(l10n.s5MedAdd),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
        children: [
          Text(
            l10n.s5MyMedsHint,
            style: const TextStyle(fontSize: 16, color: AppTheme.neutral700),
          ),
          const SizedBox(height: 16),
          if (_failed)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.s5RecordsLoadFailed),
                OutlinedButton(onPressed: _load, child: Text(l10n.authRetry)),
              ],
            )
          else if (meds == null)
            const Center(child: CircularProgressIndicator())
          else if (meds.isEmpty)
            Text(l10n.s5MyMedsEmpty, style: const TextStyle(fontSize: 16))
          else
            for (final m in meds)
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppTheme.neutral200),
                ),
                child: ListTile(
                  minVerticalPadding: 12,
                  leading: const Icon(
                    Icons.medication_outlined,
                    color: AppTheme.brand600,
                  ),
                  title: Text(m.displayName),
                  subtitle: Text(
                    [
                      if (m.isDefault) l10n.s5MedDefault,
                      if (m.dailyCheckEnabled) l10n.s5MedDailyCheck,
                    ].join(' · '),
                  ),
                  trailing: const Icon(Icons.edit_outlined),
                  onTap: () => _edit(m),
                ),
              ),
        ],
      ),
    );
  }
}
