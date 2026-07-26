import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/biometrics/biometric_prefs.dart';
import '../../../core/location/location_service.dart';
import '../../../core/phone/phone_e164.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../home/presentation/home_shell.dart';
import '../../settings/data/emergency_contact_repository.dart';
import '../data/care_link_repository.dart';

/// SCR-ONB-01 — patient onboarding (basic design reference layout).
class PatientOnboardingScreen extends StatefulWidget {
  const PatientOnboardingScreen({
    super.key,
    required this.userId,
    required this.onFinished,
  });

  final String userId;
  final VoidCallback onFinished;

  @override
  State<PatientOnboardingScreen> createState() =>
      _PatientOnboardingScreenState();
}

class _PatientOnboardingScreenState extends State<PatientOnboardingScreen> {
  final _codeController = TextEditingController();
  final _contactNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _careLinks = CareLinkRepository();
  final _contacts = EmergencyContactRepository();
  final _location = const LocationService();
  String _languageCode = 'en';
  String _placeLabel = 'Home';
  bool _busy = false;
  String? _message;
  bool _isError = false;
  String? _locationHint;

  static const _langs = ['en', 'es', 'fr', 'ko', 'ja', 'zh'];

  @override
  void dispose() {
    _codeController.dispose();
    _contactNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _finish({bool redeem = false}) async {
    setState(() {
      _busy = true;
      _message = null;
      _isError = false;
    });
    final l10n = AppLocalizations.of(context)!;

    try {
      if (redeem) {
        final code = _codeController.text.trim();
        if (code.isNotEmpty) {
          if (!RegExp(r'^\d{6}$').hasMatch(code)) {
            setState(() {
              _message = l10n.authInviteInvalidFormat;
              _isError = true;
            });
            return;
          }
          await _careLinks.redeemInviteCode(code);
          if (mounted) {
            setState(() {
              _message = l10n.authInviteRedeemedPending;
              _isError = false;
            });
          }
        }
      }
      final name = _contactNameController.text.trim();
      final phone = PhoneE164.normalize(_phoneController.text);
      if (name.isNotEmpty && phone != null) {
        await _contacts.upsert(displayName: name, phoneE164: phone);
      }
      if (!mounted) return;
      await AppLocaleScope.of(context).setLocale(Locale(_languageCode));
      await BiometricPrefs.setPatientOnboardingDone(widget.userId, true);
      if (!mounted) return;
      widget.onFinished();
    } catch (_) {
      if (mounted) {
        setState(() {
          _message = l10n.authInviteRedeemFailed;
          _isError = true;
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppTheme.neutral0,
      appBar: AppBar(
        title: Text(l10n.appTitle),
        backgroundColor: AppTheme.neutral0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            l10n.mockChooseLanguage,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _langs.map((code) {
              final selected = _languageCode == code;
              return ChoiceChip(
                label: Text(code.toUpperCase()),
                selected: selected,
                onSelected: (_) => setState(() => _languageCode = code),
              );
            }).toList(),
          ),
          const Divider(height: 32),
          Text(
            l10n.mockYourLocation,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _busy
                ? null
                : () async {
                    final result = await _location.getCurrentPosition();
                    if (!mounted) return;
                    setState(() {
                      if (result.isOk) {
                        _locationHint =
                            '${result.position!.latitude.toStringAsFixed(4)}, '
                            '${result.position!.longitude.toStringAsFixed(4)}';
                      } else {
                        _locationHint = result.failure?.name;
                      }
                    });
                  },
            icon: const Icon(Icons.my_location),
            label: Text(l10n.mockUseCurrentLocation),
          ),
          if (_locationHint != null) ...[
            const SizedBox(height: 4),
            Text(
              _locationHint!,
              style: const TextStyle(color: AppTheme.brand700, fontSize: 12),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            l10n.mockLocationTrapOnly,
            style: const TextStyle(color: AppTheme.neutral400, fontSize: 12),
          ),
          const Divider(height: 32),
          Text(
            l10n.mockLabelYourPlace,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              (l10n.mockHomeLocation, 'Home'),
              (l10n.mockSchool, 'School'),
              (l10n.mockWork, 'Work'),
              (l10n.mockOther, 'Other'),
            ].map((e) {
              final selected = _placeLabel == e.$2;
              return ChoiceChip(
                label: Text(e.$1),
                selected: selected,
                onSelected: (_) => setState(() => _placeLabel = e.$2),
              );
            }).toList(),
          ),
          const Divider(height: 32),
          Text(
            l10n.mockEmergencyContact,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            l10n.mockEmergencyOnePerson,
            style: const TextStyle(color: AppTheme.neutral500),
          ),
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
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: l10n.mockPhoneNumber,
              border: const OutlineInputBorder(),
            ),
          ),
          const Divider(height: 32),
          Text(
            l10n.mockProviderPairing,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          Text(
            l10n.authInviteCodeHelper,
            style: const TextStyle(color: AppTheme.neutral500),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: l10n.authInviteCodeLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          Text(
            l10n.mockPairingOptional,
            style: const TextStyle(color: AppTheme.neutral400, fontSize: 12),
          ),
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(
              _message!,
              style: TextStyle(
                color: _isError
                    ? Theme.of(context).colorScheme.error
                    : AppTheme.success600,
              ),
            ),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _busy ? null : () => _finish(redeem: false),
                  child: Text(l10n.authOnboardingSkip),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _busy ? null : () => _finish(redeem: true),
                  child: Text(l10n.mockNext),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
