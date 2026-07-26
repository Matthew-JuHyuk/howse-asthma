import 'package:flutter/material.dart';

import '../../../core/biometrics/biometric_prefs.dart';
import '../../../core/biometrics/biometric_service.dart';
import '../../../core/locale/locale_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';

class ProviderSettingsScreen extends StatefulWidget {
  const ProviderSettingsScreen({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  State<ProviderSettingsScreen> createState() => _ProviderSettingsScreenState();
}

class _ProviderSettingsScreenState extends State<ProviderSettingsScreen> {
  final _biometrics = BiometricService();
  bool _biometricEnabled = false;
  bool _biometricAvailable = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final userId = SupabaseService.currentUser?.id ?? '';
    final enabled = await BiometricPrefs.isUnlockEnabled(userId);
    final available = await _biometrics.canCheckBiometrics();
    if (!mounted) return;
    setState(() {
      _biometricEnabled = enabled;
      _biometricAvailable = available;
      _loading = false;
    });
  }

  Future<void> _toggleBiometric(bool value) async {
    final l10n = AppLocalizations.of(context)!;
    final userId = SupabaseService.currentUser?.id ?? '';
    if (userId.isEmpty) return;
    if (value) {
      final ok = await _biometrics.authenticate(
        localizedReason: l10n.authBiometricReason,
      );
      if (!ok) return;
    }
    await BiometricPrefs.setUnlockEnabled(userId, value);
    if (!mounted) return;
    setState(() => _biometricEnabled = value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ValueListenableBuilder<Locale?>(
              valueListenable: widget.localeController,
              builder: (context, currentLocale, _) {
                return ListView(
                  children: [
                    ListTile(
                      title: Text(l10n.settingsLanguageLabel),
                      subtitle: Text(
                        currentLocale == null
                            ? l10n.settingsSystemDefault
                            : localeDisplayNames[currentLocale.languageCode] ??
                                currentLocale.languageCode,
                      ),
                    ),
                    RadioGroup<Locale>(
                      groupValue: currentLocale,
                      onChanged: (value) =>
                          widget.localeController.setLocale(value),
                      child: Column(
                        children: supportedLocales
                            .map(
                              (locale) => RadioListTile<Locale>(
                                title: Text(
                                  localeDisplayNames[locale.languageCode] ??
                                      locale.languageCode,
                                ),
                                value: locale,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: Text(l10n.authBiometricToggle),
                      subtitle: Text(
                        _biometricAvailable
                            ? l10n.authBiometricToggleHint
                            : l10n.authBiometricUnavailable,
                      ),
                      value: _biometricEnabled && _biometricAvailable,
                      onChanged:
                          _biometricAvailable ? _toggleBiometric : null,
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text(l10n.authSignOut),
                      onTap: () => SupabaseService.client.auth.signOut(),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
