import 'package:flutter/material.dart';
import '../../../core/session/session_controller.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
import '../ui/app_chrome.dart';
import 'preparation_strings.dart';

/// One owner, explicitly selected care subject. Never merges sibling records.
class CareProfileRecords extends StatefulWidget {
  const CareProfileRecords({super.key});
  @override
  State<CareProfileRecords> createState() => _CareProfileRecordsState();
}

class _CareProfileRecordsState extends State<CareProfileRecords> {
  final _repo = PreparationRepository();
  Map<String, String>? _profiles;
  List<TreatmentEvent> _events = [];
  String? _selected, _error, _owner;
  @override
  void initState() {
    super.initState();
    _owner = _repo.uid;
    _load();
  }

  Future<void> _load() async {
    try {
      final profiles = await _repo.careProfiles();
      final events = await _repo.events();
      if (!mounted) return;
      final owner = SessionScope.of(context).user?.id;
      if (owner != null) {
        profiles.putIfAbsent(
          owner,
          () =>
              SessionScope.of(context).profile?.fullName ??
              s10(context, 'patient'),
        );
      }
      setState(() {
        _profiles = profiles;
        _events = events;
        _selected ??= profiles.keys.firstOrNull;
        _error = null;
      });
    } catch (_) {
      if (mounted) setState(() => _error = s10(context, 'error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (SessionScope.of(context).user?.id != _owner) {
      return Scaffold(
        appBar: CoverNoteAppBar(title: Text(s10(context, 'careRecords'))),
      );
    }
    final profiles = _profiles;
    return Scaffold(
      appBar: CoverNoteAppBar(title: Text(s10(context, 'timeline'))),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_error != null)
              TextButton(onPressed: _load, child: Text(_error!)),
            if (profiles == null && _error == null)
              const Center(child: CircularProgressIndicator()),
            if (profiles != null && profiles.isNotEmpty)
              DropdownButtonFormField<String>(
                initialValue: _selected,
                isExpanded: true,
                items: [
                  for (final p in profiles.entries)
                    DropdownMenuItem(value: p.key, child: Text(p.value)),
                ],
                onChanged: (v) => setState(() => _selected = v),
              ),
            for (final e in _events.where(
              (e) => !e.undone && e.patientKey == _selected,
            ))
              ListTile(
                title: Text('${e.day} · ${e.kind}'),
                subtitle: Text(e.values['english_summary'] ?? e.text),
              ),
            if (profiles != null &&
                !_events.any((e) => !e.undone && e.patientKey == _selected))
              Text(s10(context, 'empty')),
          ],
        ),
      ),
    );
  }
}
