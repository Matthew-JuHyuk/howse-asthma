import 'package:flutter/material.dart';

import '../../../core/location/location_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/saved_location_repository.dart';

/// SCR-PAT-LOCATIONS — saved places + monitoring (WBS 5.6).
class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final _repo = SavedLocationRepository();
  final _location = const LocationService();
  bool _loading = true;
  String? _error;
  List<SavedLocation> _items = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = await _repo.list();
      if (!mounted) return;
      setState(() {
        _items = items;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = 'load_failed';
      });
    }
  }

  Future<void> _addCurrent() async {
    final l10n = AppLocalizations.of(context)!;
    final nameCtrl = TextEditingController(text: l10n.mockHomeLocation);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.locationsAddTitle),
        content: TextField(
          controller: nameCtrl,
          decoration: InputDecoration(labelText: l10n.locationsNameLabel),
          autofocus: true,
          maxLength: 50,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final name = nameCtrl.text.trim();
    if (name.isEmpty) return;

    final loc = await _location.getCurrentPosition();
    if (!mounted) return;
    if (!loc.isOk) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.locationUnavailable)),
      );
      return;
    }
    try {
      await _repo.upsert(
        label: name,
        latitude: loc.position!.latitude,
        longitude: loc.position!.longitude,
        monitoringEnabled: true,
        isPrimary: _items.isEmpty,
      );
      await _load();
    } catch (e) {
      if (!mounted) return;
      final msg = e is StateError && e.message == 'saved_locations_cap'
          ? l10n.locationsCapReached
          : l10n.locationsSaveFailed;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  Future<void> _toggleMonitoring(SavedLocation item, bool value) async {
    try {
      await _repo.setMonitoring(item.id, value);
      await _load();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.locationsSaveFailed)),
      );
    }
  }

  Future<void> _delete(SavedLocation item) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.locationsDeleteTitle),
        content: Text(l10n.locationsDeleteBody(item.label)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await _repo.delete(item.id);
      await _load();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.locationsSaveFailed)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              l10n.locationsTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Text(
              'SCR-PAT-LOCATIONS',
              style: TextStyle(fontSize: 11, color: AppTheme.neutral400),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addCurrent,
        icon: const Icon(Icons.add_location_alt_outlined),
        label: Text(l10n.locationsAddCurrent),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          children: [
            Text(
              l10n.locationsIntro,
              style: const TextStyle(color: AppTheme.subtext, fontSize: 13),
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Text(l10n.locationsSaveFailed)
            else if (_items.isEmpty)
              Text(
                l10n.locationsEmpty,
                style: const TextStyle(color: AppTheme.subtext),
              )
            else
              ..._items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Material(
                    color: AppTheme.neutral0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppTheme.neutral200),
                    ),
                    child: ListTile(
                      title: Text(
                        item.label,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        [
                          l10n.locationsCoords(
                            item.latitude.toStringAsFixed(4),
                            item.longitude.toStringAsFixed(4),
                          ),
                          if (item.isPrimary) l10n.locationsPrimaryBadge,
                        ].join(' · '),
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: item.monitoringEnabled,
                            onChanged: (v) => _toggleMonitoring(item, v),
                          ),
                          IconButton(
                            onPressed: () => _delete(item),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
