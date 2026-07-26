import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/biometrics/biometric_prefs.dart';
import '../../../l10n/app_localizations.dart';
import '../data/care_link_repository.dart';

/// Light patient onboarding: optional provider invite code.
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
  final _careLinks = CareLinkRepository();
  bool _busy = false;
  String? _message;
  bool _isError = false;

  @override
  void dispose() {
    _codeController.dispose();
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
      await BiometricPrefs.setPatientOnboardingDone(widget.userId, true);
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
      appBar: AppBar(title: Text(l10n.authOnboardingTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.authOnboardingBody),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _codeController,
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
                if (_message != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _message!,
                    style: TextStyle(
                      color: _isError
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _busy ? null : () => _finish(redeem: true),
                  child: Text(l10n.authInviteRedeemAndContinue),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _busy ? null : () => _finish(redeem: false),
                  child: Text(l10n.authOnboardingSkip),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
