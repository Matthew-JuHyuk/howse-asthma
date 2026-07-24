import 'package:flutter/material.dart';

import '../../../core/locale/locale_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ValueListenableBuilder<Locale?>(
        valueListenable: localeController,
        builder: (context, currentLocale, _) {
          return ListView(
            children: [
              ListTile(
                title: Text(l10n.settingsLanguageLabel),
                subtitle: Text(
                  currentLocale == null
                      ? 'System default'
                      : localeDisplayNames[currentLocale.languageCode] ?? currentLocale.languageCode,
                ),
              ),
              RadioGroup<Locale>(
                groupValue: currentLocale,
                onChanged: (value) => localeController.setLocale(value),
                child: Column(
                  children: supportedLocales
                      .map(
                        (locale) => RadioListTile<Locale>(
                          title: Text(localeDisplayNames[locale.languageCode] ?? locale.languageCode),
                          value: locale,
                        ),
                      )
                      .toList(),
                ),
              ),
              const Divider(),
              ListTile(
                title: Text(l10n.settingsLocationLabel),
                subtitle: const Text('TODO: request location permission (geolocator)'),
                trailing: const Icon(Icons.location_on_outlined),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign out'),
                onTap: () => SupabaseService.client.auth.signOut(),
              ),
            ],
          );
        },
      ),
    );
  }
}
