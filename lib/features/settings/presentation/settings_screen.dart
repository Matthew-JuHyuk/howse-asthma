import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/biometrics/biometric_prefs.dart';
import '../../../core/biometrics/biometric_service.dart';
import '../../../core/locale/locale_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/care_link_repository.dart';
import '../../locations/presentation/locations_screen.dart';

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
        backgroundColor: AppTheme.defaultBackground,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: SafeArea(
        child: ValueListenableBuilder<Locale?>(
          valueListenable: widget.localeController,
          builder: (context, currentLocale, _) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              children: [
                Text(l10n.settingsTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                const Text('SCR-PAT-SETTINGS', style: TextStyle(color: AppTheme.neutral400, fontSize: 12)),
                const SizedBox(height: 16),
                _section(
                  title: l10n.settingsLanguageLabel,
                  child: Column(
                    children: [
                      Text(
                        currentLocale == null
                            ? l10n.settingsSystemDefault
                            : localeDisplayNames[currentLocale.languageCode] ??
                                currentLocale.languageCode,
                        style: const TextStyle(color: AppTheme.subtext, fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      RadioGroup<Locale>(
                        groupValue: currentLocale,
                        onChanged: (value) => widget.localeController.setLocale(value),
                        child: Column(
                          children: supportedLocales
                              .map(
                                (locale) => RadioListTile<Locale>(
                                  contentPadding: EdgeInsets.zero,
                                  dense: true,
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
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  title: 'Alert Preferences',
                  child: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Risk Alerts'),
                        subtitle: const Text('Score changes and warnings'),
                        value: true,
                        onChanged: (_) {},
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Home Alerts'),
                        subtitle: const Text('TRAP and pollen at home location'),
                        value: true,
                        onChanged: (_) {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  title: 'Security',
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.authBiometricToggle),
                    subtitle: Text(
                      _biometricAvailable
                          ? l10n.authBiometricToggleHint
                          : l10n.authBiometricUnavailable,
                    ),
                    value: _biometricEnabled && _biometricAvailable,
                    onChanged: _biometricAvailable ? _toggleBiometric : null,
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  title: l10n.settingsLocationLabel,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.place_outlined, color: AppTheme.brand600),
                    title: Text(l10n.mockLocationsTitle),
                    subtitle: Text(l10n.settingsLocationTodo),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LocationsScreen()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  title: 'Provider Pairing',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.authInviteCodeHelper, style: const TextStyle(fontSize: 13, color: AppTheme.subtext)),
                      const SizedBox(height: 12),
                      Row(
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
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.logout, color: AppTheme.error600),
                  title: Text(l10n.authSignOut),
                  onTap: () => SupabaseService.client.auth.signOut(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _section({required String title, required Widget child}) {
    return Material(
      color: AppTheme.neutral0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.neutral200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}
