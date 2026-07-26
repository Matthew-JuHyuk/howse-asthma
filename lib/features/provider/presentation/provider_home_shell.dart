import 'package:flutter/material.dart';

import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../home/presentation/home_shell.dart';
import 'provider_link_screen.dart';
import 'provider_settings_screen.dart';

/// Minimal provider shell (OSMU tablet-friendly entry). Full PRV-01 later.
class ProviderHomeShell extends StatefulWidget {
  const ProviderHomeShell({super.key});

  @override
  State<ProviderHomeShell> createState() => _ProviderHomeShellState();
}

class _ProviderHomeShellState extends State<ProviderHomeShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeController = AppLocaleScope.of(context);

    final pages = [
      _ProviderHomeTab(
        onLinkPatients: () => setState(() => _index = 1),
      ),
      const ProviderLinkScreen(),
      ProviderSettingsScreen(localeController: localeController),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            label: l10n.providerHomeTab,
          ),
          NavigationDestination(
            icon: const Icon(Icons.link_outlined),
            label: l10n.providerLinkTab,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            label: l10n.settingsTitle,
          ),
        ],
      ),
    );
  }
}

class _ProviderHomeTab extends StatelessWidget {
  const _ProviderHomeTab({required this.onLinkPatients});

  final VoidCallback onLinkPatients;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final email = SupabaseService.currentUser?.email ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(l10n.providerHomeTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.providerHomeWelcome(email),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(l10n.providerHomePlaceholder),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onLinkPatients,
              icon: const Icon(Icons.person_add_alt_1_outlined),
              label: Text(l10n.providerLinkPatientsCta),
            ),
          ],
        ),
      ),
    );
  }
}
