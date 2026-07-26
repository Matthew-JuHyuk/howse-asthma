import 'package:flutter/material.dart';

import '../../../core/biometrics/biometric_service.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';

/// SCR-AUTH-04 — unlock an existing session with device biometrics.
class BiometricLockScreen extends StatefulWidget {
  const BiometricLockScreen({
    super.key,
    required this.onUnlocked,
  });

  final VoidCallback onUnlocked;

  @override
  State<BiometricLockScreen> createState() => _BiometricLockScreenState();
}

class _BiometricLockScreenState extends State<BiometricLockScreen> {
  final _biometrics = BiometricService();
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryUnlock());
  }

  Future<void> _tryUnlock() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final l10n = AppLocalizations.of(context)!;
    final ok = await _biometrics.authenticate(
      localizedReason: l10n.authBiometricReason,
    );
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) {
      widget.onUnlocked();
    } else {
      setState(() => _error = l10n.authBiometricFailed);
    }
  }

  Future<void> _signOut() async {
    await SupabaseService.client.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.fingerprint, size: 64),
                const SizedBox(height: 16),
                Text(
                  l10n.authBiometricTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.authBiometricHint,
                  textAlign: TextAlign.center,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _busy ? null : _tryUnlock,
                  child: Text(l10n.authBiometricUnlock),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _busy ? null : _signOut,
                  child: Text(l10n.authSignOut),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
