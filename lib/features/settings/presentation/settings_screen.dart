import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' show LocationPermission;

import '../../../core/biometrics/biometric_prefs.dart';
import '../../../core/biometrics/biometric_service.dart';
import '../../../core/debug/debug_gates.dart';
import '../../../core/environment/environment_snapshot_cache.dart';
import '../../../core/locale/locale_controller.dart';
import '../../../core/location/environment_monitor.dart';
import '../../../core/location/location_service.dart';
import '../../../core/phone/phone_e164.dart';
import '../../../core/push/fcm_service.dart';
import '../../../core/push/medication_reminder.dart';
import '../../../core/push/notification_consent_prefs.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/data/care_link_repository.dart';
import '../../debug/presentation/api_console_screen.dart';
import '../../environment/data/environment_controller.dart';
import '../../locations/presentation/locations_screen.dart';
import '../../panic/presentation/panic_screen.dart';
import '../../records/presentation/my_medications_screen.dart';
import '../data/emergency_contact_repository.dart';
import '../data/notification_prefs_repository.dart';

/// Settings — Language · My medications · Alerts · Area · Security & data ·
/// Help. Internal screen id: SCR-PAT-SETTINGS.
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
  bool _pushMaster = false;
  bool _hideMedName = true;
  bool _pushPositive = true;
  bool _fgRefresh = true;
  bool? _osPushGranted;
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
    final pushMaster = await NotificationConsentPrefs.isMasterEnabled(userId);
    final pushPositive = await NotificationConsentPrefs.isPositiveEnabled(
      userId,
    );
    final fgRefresh = await NotificationConsentPrefs.isBgRefreshEnabled(userId);
    final osPush = await FcmService.instance.osPermissionGranted();
    final hideMedName = await MedicationReminder.instance.hideMedicationName();
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
        _pushPositive = prefs.containsKey('push_positive_ventilation')
            ? prefs['push_positive_ventilation'] != false
            : pushPositive;
      } else {
        _pushPositive = pushPositive;
      }
      _pushMaster = pushMaster;
      _hideMedName = hideMedName;
      _fgRefresh = fgRefresh;
      _osPushGranted = osPush;
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
        SnackBar(content: Text(l10n.s5PhoneInvalid)),
      );
      return;
    }
    setState(() => _savingContact = true);
    try {
      await _contacts.upsert(displayName: name, phoneE164: phone);
      _contactPhoneController.text = phone;
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.s5Saved)),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.s5SaveFailed)),
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
    await EnvironmentController.instance.refresh();
  }

  Future<void> _setMaster(bool v) async {
    final userId = SupabaseService.currentUser?.id ?? '';
    final previous = _pushMaster;
    setState(() => _pushMaster = v);
    try {
      await NotificationConsentPrefs.setMasterEnabled(userId, v);
      await NotificationConsentPrefs.setConsentPrompted(userId, true);
      if (v) {
        await FcmService.instance.registerCurrentDevice();
        await _notifPrefs.getOrCreate();
      } else {
        await FcmService.instance.unregisterCurrentDevice();
      }
      final os = await FcmService.instance.osPermissionGranted();
      if (mounted) setState(() => _osPushGranted = os);
    } catch (_) {
      if (mounted) setState(() => _pushMaster = previous);
    }
  }

  Future<void> _setPref(
    bool v,
    bool previous,
    void Function(bool) apply,
    Future<void> Function() write,
  ) async {
    setState(() => apply(v));
    try {
      await write();
    } catch (_) {
      if (mounted) setState(() => apply(previous));
    }
  }

  Future<void> _setFgRefresh(bool v) async {
    final userId = SupabaseService.currentUser?.id ?? '';
    final previous = _fgRefresh;
    setState(() => _fgRefresh = v);
    try {
      await NotificationConsentPrefs.setBgRefreshEnabled(userId, v);
      await NotificationConsentPrefs.setBgExplained(userId, true);
      if (!mounted) return;
      final monitor = EnvironmentMonitor.maybeOf(context);
      if (v) {
        monitor?.start();
      } else {
        monitor?.stop();
      }
    } catch (_) {
      if (mounted) setState(() => _fgRefresh = previous);
    }
  }

  void _showDataSources() {
    final l10n = AppLocalizations.of(context)!;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.s5DataSourcesTitle),
        content: SingleChildScrollView(child: Text(l10n.s5DataSourcesBody)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.s5Close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              top: false,
              child: ValueListenableBuilder<Locale>(
                valueListenable: widget.localeController,
                builder: (context, currentLocale, _) => ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  children: _groups(context, l10n, currentLocale),
                ),
              ),
            ),
    );
  }

  List<Widget> _groups(
    BuildContext context,
    AppLocalizations l10n,
    Locale currentLocale,
  ) {
    final locationLabel = switch (_locationStatus) {
      'granted' => l10n.locationStatusGranted,
      'deniedForever' => l10n.locationPermissionDeniedForever,
      'serviceDisabled' => l10n.locationServiceDisabled,
      _ => l10n.locationPermissionDenied,
    };
    final alertsEnabled = _pushMaster;

    return [
      // 1. Language
      _section(
        title: l10n.settingsLanguageLabel,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: supportedLocales.map((locale) {
                return FilterChip(
                  label: Text(
                    localeDisplayNames[locale.languageCode] ??
                        locale.languageCode,
                  ),
                  selected: currentLocale.languageCode == locale.languageCode,
                  onSelected: (_) => widget.localeController.setLocale(locale),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Text(l10n.s5SettingsLanguageNote, style: _hint),
          ],
        ),
      ),
      // 2. My medications
      _section(
        title: l10n.s5MyMedsTitle,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Icons.medication_outlined,
            color: AppTheme.brand600,
          ),
          title: Text(l10n.s5MyMedsOpen),
          subtitle: Text(l10n.s5MyMedsHint),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MyMedicationsScreen()),
          ),
        ),
      ),
      // 3. Alerts (only behavior that exists)
      _section(
        title: l10n.s5SettingsAlerts,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.settingsPushMaster),
              subtitle: Text(l10n.settingsPushMasterHint),
              value: _pushMaster,
              onChanged: _setMaster,
            ),
            if (_pushMaster && _osPushGranted == false) ...[
              Text(l10n.s5OsNotificationsOff, style: _warn),
              TextButton(
                onPressed: () => _location.openAppSettings(),
                child: Text(l10n.locationOpenSettings),
              ),
            ],
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.s6HideMedName),
              subtitle: Text(l10n.s6HideMedNameHint),
              value: _hideMedName,
              onChanged: (v) async {
                await MedicationReminder.instance.setHideMedicationName(v);
                if (mounted) setState(() => _hideMedName = v);
              },
            ),
            Text(l10n.s5EnvAlertsHeading, style: _subhead),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.s5AlertWorse),
              subtitle: Text(l10n.s5AlertWorseHint),
              value: _pushRiskGe3,
              onChanged: !alertsEnabled
                  ? null
                  : (v) => _setPref(
                      v,
                      _pushRiskGe3,
                      (x) => _pushRiskGe3 = x,
                      () => _notifPrefs.update(pushRiskGe3: v),
                    ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.s5AlertArrive),
              subtitle: Text(l10n.s5AlertArriveHint),
              value: _pushLocationEntry,
              onChanged: !alertsEnabled
                  ? null
                  : (v) => _setPref(
                      v,
                      _pushLocationEntry,
                      (x) => _pushLocationEntry = x,
                      () => _notifPrefs.update(pushLocationEntry: v),
                    ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.s5AlertSavedPlaces),
              subtitle: Text(l10n.s5AlertSavedPlacesHint),
              value: _pushHome,
              onChanged: !alertsEnabled
                  ? null
                  : (v) => _setPref(
                      v,
                      _pushHome,
                      (x) => _pushHome = x,
                      () => _notifPrefs.update(pushSavedLocationChange: v),
                    ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.settingsAlertPositive),
              subtitle: Text(l10n.s5AlertFreshAirHint),
              value: _pushPositive,
              onChanged: !alertsEnabled
                  ? null
                  : (v) => _setPref(v, _pushPositive, (x) => _pushPositive = x, () async {
                      final userId = SupabaseService.currentUser?.id ?? '';
                      await NotificationConsentPrefs.setPositiveEnabled(
                        userId,
                        v,
                      );
                      await _notifPrefs.update(pushPositiveVentilation: v);
                    }),
            ),
          ],
        ),
      ),
      // 4. Area
      _section(
        title: l10n.s5SettingsArea,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(locationLabel),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: _locationStatus == 'deniedForever' ||
                      _locationStatus == 'serviceDisabled'
                  ? () => _location.openAppSettings()
                  : _requestLocation,
              child: Text(
                _locationStatus == 'deniedForever' ||
                        _locationStatus == 'serviceDisabled'
                    ? l10n.locationOpenSettings
                    : l10n.mockUseCurrentLocation,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.place_outlined, color: AppTheme.brand600),
              title: Text(l10n.s5ChoosePlace),
              subtitle: Text(l10n.s5SavedPlacesHint),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LocationsScreen()),
                );
                await EnvironmentController.instance.refresh();
              },
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.s5FgRefreshTitle),
              subtitle: Text(l10n.s5FgRefreshHint),
              value: _fgRefresh,
              onChanged: _setFgRefresh,
            ),
          ],
        ),
      ),
      // 5. Security & data
      _section(
        title: l10n.s5SettingsSecurityData,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
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
            Text(l10n.s5RecordsManageHint, style: _hint),
            const SizedBox(height: 16),
            Text(l10n.mockInviteCode, style: _subhead),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _inviteController,
                    keyboardType: TextInputType.visiblePassword,
                    textCapitalization: TextCapitalization.characters,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                      LengthLimitingTextInputFormatter(8),
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
      // 6. Help
      _section(
        title: l10n.s5SettingsHelp,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.sos_outlined, color: AppTheme.error600),
              title: Text(l10n.s5UrgentHelp),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const PanicScreen())),
            ),
            const SizedBox(height: 8),
            Text(l10n.mockEmergencyContact, style: _subhead),
            const SizedBox(height: 8),
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
                helperText: l10n.s5PhoneHint,
                helperMaxLines: 2,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton(
                onPressed: _savingContact ? null : _saveContact,
                child: Text(l10n.emergencyContactSave),
              ),
            ),
            const Divider(height: 24),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info_outline, color: AppTheme.brand600),
              title: Text(l10n.s5AboutApp),
              subtitle: Text(l10n.s5AboutAppBody),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.source_outlined,
                color: AppTheme.brand600,
              ),
              title: Text(l10n.s5DataSourcesTitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: _showDataSources,
            ),
          ],
        ),
      ),
      if (DebugGates.enabled)
        _section(
          title: l10n.settingsDeveloperSection,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.bug_report_outlined,
              color: AppTheme.brand600,
            ),
            title: Text(l10n.settingsApiConsole),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ApiConsoleScreen())),
          ),
        ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.logout, color: AppTheme.error600),
        title: Text(l10n.authSignOut),
        onTap: () async {
          final navigator = Navigator.of(context);
          final userId = SupabaseService.currentUser?.id;
          try {
            await FcmService.instance.unregisterCurrentDevice();
          } catch (_) {}
          if (userId != null) {
            try {
              await EnvironmentSnapshotCache.clear(userId);
            } catch (_) {}
          }
          await SupabaseService.client.auth.signOut();
          navigator.popUntil((r) => r.isFirst);
        },
      ),
    ];
  }

  static const _hint = TextStyle(fontSize: 14, color: AppTheme.neutral700);
  static const _warn = TextStyle(fontSize: 14, color: AppTheme.warning600);
  static const _subhead = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  Widget _section({required String title, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
