import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-PAT-LOCATIONS — saved places for local monitoring. Stub UI.
class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filters = ['All', 'Home', 'School', 'Work'];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: const Column(
          children: [
            Text('My Locations', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text('SCR-PAT-LOCATIONS', style: TextStyle(fontSize: 11, color: AppTheme.neutral400)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Saved Locations', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const Text('Used for local air quality and alerts', style: TextStyle(color: AppTheme.subtext)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (var i = 0; i < filters.length; i++)
                ChoiceChip(
                  label: Text(filters[i]),
                  selected: _filter == i,
                  onSelected: (_) => setState(() => _filter = i),
                  selectedColor: AppTheme.brand600,
                  labelStyle: TextStyle(color: _filter == i ? Colors.white : AppTheme.neutral600),
                ),
            ],
          ),
          const SizedBox(height: 16),
          _placeCard(
            icon: Icons.home_outlined,
            title: l10n.mockHomeLocation,
            address: l10n.mockDummyAddress,
            badge: 'Primary',
            meta: 'TRAP monitoring active · Flood alerts on',
          ),
          const SizedBox(height: 10),
          _placeCard(
            icon: Icons.work_outline,
            title: l10n.mockWorkLocation,
            address: l10n.mockDummyWorkAddress,
            badge: 'Secondary',
            meta: 'Flood alerts off',
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_location_alt_outlined),
            label: Text(l10n.mockAddLocation),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.my_location),
            label: const Text('Use Current Location'),
          ),
        ],
      ),
    );
  }

  Widget _placeCard({
    required IconData icon,
    required String title,
    required String address,
    required String badge,
    required String meta,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
              Icon(icon, color: AppTheme.brand600),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
              Text(badge, style: const TextStyle(fontSize: 11, color: AppTheme.brand700)),
            ],
          ),
          const SizedBox(height: 6),
          Text(address, style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
          const SizedBox(height: 6),
          Text(meta, style: const TextStyle(fontSize: 12, color: AppTheme.brand700)),
        ],
      ),
    );
  }
}
