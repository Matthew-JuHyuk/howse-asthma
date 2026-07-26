import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' show LocationPermission;

import '../../../core/biometrics/biometric_prefs.dart';
import '../../../core/biometrics/biometric_service.dart';
import '../../../core/locale/locale_controller.dart';
import '../../../core/location/location_service.dart';
import '../../../core/phone/phone_e164.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/care_link_repository.dart';
import '../../locations/presentation/locations_screen.dart';
import '../data/emergency_contact_repository.dart';
import '../data/notification_prefs_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.localeController});

  final LocaleController localeController;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _biometrics = BiometricService();
  final _careLinks = CareLinkRepository();
  final _contacts = EmergencyContactRepository();
  final _notifPrefs = NotificationPrefsRepository();
  final _location = const LocationService();
  final _inviteController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _contactPhoneController = TextEditingController();

  bool _biometricEnabled = false;
  bool _biometricAvailable = false;
  bool _loading = true;
  bool _redeeming = false;
  bool _savingContact = false;
  bool _pushRiskGe3 = true;
  bool _pushLocationEntry = true;
  bool _pushHome = true;
  String? _locationStatus;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _inviteController.dispose();
    _contactNameController.dispose();
    _contactPhoneController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final userId = SupabaseService.currentUser?.id ?? '';
    final enabled = await BiometricPrefs.isUnlockEnabled(userId);
    final available = await _biometrics.canCheckBiometrics();
    Map<String, dynamic>? contact;
    Map<String, dynamic>? prefs;
    try {
      contact = await _contacts.get();
    } catch (_) {}
    try {
      prefs = await _notifPrefs.getOrCreate();
    } catch (_) {}

    final perm = await _location.checkPermission();
    final serviceOn = await _location.isServiceEnabled();

    if (!mounted) return;
    setState(() {
      _biometricEnabled = enabled;
      _biometricAvailable = available;
      if (contact != null) {
        _contactNameController.text =
            (contact['display_name'] as String?) ?? '';
        _contactPhoneController.text =
            (contact['phone_e164'] as String?) ?? '';
      }
      if (prefs != null) {
        _pushRiskGe3 = prefs['push_risk_ge3'] != false;
        _pushLocationEntry = prefs['push_location_entry'] != false;
        _pushHome = prefs['push_saved_location_change'] != false;
      }
      _locationStatus = !serviceOn
          ? 'serviceDisabled'
          : perm == LocationPermission.deniedForever
              ? 'deniedForever'
              : perm == LocationPermission.denied
                  ? 'denied'
                  : 'granted';
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

  Future<void> _saveContact() async {
    final l10n = AppLocalizations.of(context)!;
    final name = _contactNameController.text.trim();
    final phone = PhoneE164.normalize(_contactPhoneController.text);
    if (name.isEmpty || phone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.emergencyContactInvalidPhone)),
      );
      return;
    }
    setState(() => _savingContact = true);
    try {
      await _contacts.upsert(displayName: name, phoneE164: phone);
      _contactPhoneController.text = phone;
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.emergencyContactSaved)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authErrorGeneric)),
      );
    } finally {
      if (mounted) setState(() => _savingContact = false);
    }
  }

  Future<void> _redeemInvite() async {
    final l10n = AppLocalizations.of(context)!;
    final code = _inviteController.text.trim();
    if (!RegExp(r'^[A-Za-z0-9]{8}$').hasMatch(code)) {
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

  Future<void> _requestLocation() async {
    await _location.getCurrentPosition();
    await _load();
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

    String locationLabel;
    switch (_locationStatus) {
      case 'granted':
        locationLabel = l10n.locationStatusGranted;
      case 'deniedForever':
        locationLabel = l10n.locationPermissionDeniedForever;
      case 'serviceDisabled':
        locationLabel = l10n.locationServiceDisabled;
      default:
        locationLabel = l10n.locationPermissionDenied;
    }

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: SafeArea(
        child: ValueListenableBuilder<Locale>(
          valueListenable: widget.localeController,
          builder: (context, currentLocale, _) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
              children: [
                Text(
                  l10n.settingsTitle,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'SCR-PAT-SETTINGS',
                  style: TextStyle(color: AppTheme.neutral400, fontSize: 12),
                ),
                const SizedBox(height: 16),
                _section(
                  title: l10n.settingsLanguageLabel,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: supportedLocales.map((locale) {
                      final selected =
                          currentLocale.languageCode == locale.languageCode;
                      return FilterChip(
                        label: Text(
                          localeDisplayNames[locale.languageCode] ??
                              locale.languageCode,
                        ),
                        selected: selected,
                        onSelected: (_) =>
                            widget.localeController.setLocale(locale),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  title: l10n.settingsAlertsTitle,
                  child: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.settingsAlertRisk),
                        subtitle: Text(l10n.settingsAlertRiskHint),
                        value: _pushRiskGe3,
                        onChanged: (v) async {
                          final previous = _pushRiskGe3;
                          setState(() => _pushRiskGe3 = v);
                          try {
                            await _notifPrefs.update(pushRiskGe3: v);
                          } catch (_) {
                            if (mounted) setState(() => _pushRiskGe3 = previous);
                          }
                        },
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.settingsAlertLocationEntry),
                        subtitle: Text(l10n.settingsAlertLocationEntryHint),
                        value: _pushLocationEntry,
                        onChanged: (v) async {
                          final previous = _pushLocationEntry;
                          setState(() => _pushLocationEntry = v);
                          try {
                            await _notifPrefs.update(pushLocationEntry: v);
                          } catch (_) {
                            if (mounted) {
                              setState(() => _pushLocationEntry = previous);
                            }
                          }
                        },
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.settingsAlertHome),
                        subtitle: Text(l10n.settingsAlertHomeHint),
                        value: _pushHome,
                        onChanged: (v) async {
                          final previous = _pushHome;
                          setState(() => _pushHome = v);
                          try {
                            await _notifPrefs.update(
                              pushSavedLocationChange: v,
                            );
                          } catch (_) {
                            if (mounted) setState(() => _pushHome = previous);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  title: l10n.settingsSecurityTitle,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locationLabel),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: _requestLocation,
                        child: Text(l10n.mockUseCurrentLocation),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.place_outlined,
                            color: AppTheme.brand600),
                        title: Text(l10n.mockLocationsTitle),
                        subtitle: Text(l10n.mockLocationsHint),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const LocationsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  title: l10n.mockEmergencyContact,
                  child: Column(
                    children: [
                      TextField(
                        controller: _contactNameController,
                        decoration: InputDecoration(
                          labelText: l10n.mockContactName,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _contactPhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: l10n.mockPhoneNumber,
                          helperText: l10n.emergencyContactPhoneHint,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FilledButton(
                          onPressed: _savingContact ? null : _saveContact,
                          child: Text(l10n.emergencyContactSave),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                _section(
                  title: l10n.mockInviteCode,
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
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading:
                      const Icon(Icons.logout, color: AppTheme.error600),
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
