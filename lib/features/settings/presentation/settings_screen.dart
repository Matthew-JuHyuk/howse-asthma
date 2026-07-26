import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/biometrics/biometric_prefs.dart';
import '../../../core/biometrics/biometric_service.dart';
import '../../../core/locale/locale_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/care_link_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _biometrics = BiometricService();
  final _careLinks = CareLinkRepository();
  final _inviteController = TextEditingController();

  bool _biometricEnabled = false;
  bool _biometricAvailable = false;
  bool _loading = true;
  bool _redeeming = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _inviteController.dispose();
    super.dispose();
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

  Future<void> _redeemInvite() async {
    final l10n = AppLocalizations.of(context)!;
    final code = _inviteController.text.trim();
    if (!RegExp(r'^\d{6}$').hasMatch(code)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authInviteInvalidFormat)),
      );
      return;
    }
    setState(() => _redeeming = true);
    try {
      await _careLinks.redeemInviteCode(code);
      if (!mounted) return;
      _inviteController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authInviteRedeemedPending)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authInviteRedeemFailed)),
      );
    } finally {
      if (mounted) setState(() => _redeeming = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.settingsTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ValueListenableBuilder<Locale?>(
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
                onChanged: (value) => widget.localeController.setLocale(value),
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
                onChanged: _biometricAvailable ? _toggleBiometric : null,
              ),
              const Divider(),
              ListTile(
                title: Text(l10n.settingsLocationLabel),
                subtitle: Text(l10n.settingsLocationTodo),
                trailing: const Icon(Icons.location_on_outlined),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Text(
                  l10n.authInviteCodeLabel,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inviteController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: InputDecoration(
                          labelText: l10n.authInviteCodeLabel,
                          helperText: l10n.authInviteCodeHelper,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _redeeming ? null : _redeemInvite,
                      child: Text(l10n.authInviteRedeem),
                    ),
                  ],
                ),
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
