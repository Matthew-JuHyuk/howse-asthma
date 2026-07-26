import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/biometrics/biometric_prefs.dart';
import '../../../core/config/app_config.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../home/presentation/home_shell.dart';
import '../../provider/presentation/provider_home_shell.dart';
import '../data/profile_repository.dart';
import '../domain/user_profile.dart';
import 'biometric_lock_screen.dart';
import 'complete_profile_screen.dart';
import 'login_screen.dart';
import 'patient_onboarding_screen.dart';

/// Session gate: login → optional biometric → profile → role shell.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> with WidgetsBindingObserver {
  final _profiles = ProfileRepository();

  UserProfile? _profile;
  bool _loadingProfile = false;
  String? _sessionUserId;
  bool _loadScheduled = false;
  bool _unlocked = false;
  bool _biometricRequired = false;
  bool _checkingBiometric = false;
  String? _biometricCheckedForUser;
  bool _onboardingDone = true;
  Object? _profileError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Relock only when backgrounded — not on transient `inactive` (e.g. app switcher).
    if (state == AppLifecycleState.paused && _biometricRequired) {
      setState(() => _unlocked = false);
    }
  }

  Future<void> _ensureBiometricGate(String userId) async {
    if (_biometricCheckedForUser == userId) return;
    setState(() {
      _checkingBiometric = true;
      _biometricCheckedForUser = userId;
    });
    final enabled = await BiometricPrefs.isUnlockEnabled(userId);
    if (!mounted) return;
    setState(() {
      _biometricRequired = enabled;
      _checkingBiometric = false;
      _unlocked = !enabled;
    });
  }

  Future<void> _loadProfile(String userId) async {
    setState(() {
      _loadingProfile = true;
      _profileError = null;
      _sessionUserId = userId;
      _loadScheduled = true;
    });

    try {
      final profile = await _profiles.fetchCurrent();
      final onboardingDone = profile?.role == UserRole.patient
          ? await BiometricPrefs.isPatientOnboardingDone(userId)
          : true;
      if (!mounted) return;
      setState(() {
        _profile = profile;
        _onboardingDone = onboardingDone;
        _loadingProfile = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _profileError = e;
        _loadingProfile = false;
      });
    }
  }

  void _resetForSignedOut() {
    _profile = null;
    _sessionUserId = null;
    _loadScheduled = false;
    _loadingProfile = false;
    _profileError = null;
    _onboardingDone = true;
    _biometricCheckedForUser = null;
    _biometricRequired = false;
    _checkingBiometric = false;
    _unlocked = false;
  }

  void _scheduleProfileLoad(String userId) {
    if (_loadingProfile || _loadScheduled) return;
    _loadScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadProfile(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!AppConfig.isSupabaseConfigured) {
      return const LoginScreen();
    }

    return StreamBuilder<AuthState>(
      stream: SupabaseService.authStateChanges,
      builder: (context, snapshot) {
        final session =
            snapshot.data?.session ?? SupabaseService.client.auth.currentSession;

        if (session == null) {
          if (_sessionUserId != null || _biometricCheckedForUser != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) setState(_resetForSignedOut);
            });
          }
          return const LoginScreen();
        }

        final userId = session.user.id;

        if (_biometricCheckedForUser != userId) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _ensureBiometricGate(userId);
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_checkingBiometric) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_biometricRequired && !_unlocked) {
          return BiometricLockScreen(
            onUnlocked: () => setState(() => _unlocked = true),
          );
        }

        if (_sessionUserId != userId) {
          _sessionUserId = userId;
          _profile = null;
          _profileError = null;
          _loadScheduled = false;
          _loadingProfile = false;
        }

        if (_profile == null &&
            !_loadingProfile &&
            _profileError == null &&
            !_loadScheduled) {
          _scheduleProfileLoad(userId);
        }

        if (_loadingProfile ||
            (_profile == null && _profileError == null && _loadScheduled)) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_profileError != null && _profile == null) {
          final l10n = AppLocalizations.of(context);
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _loadScheduled = false;
                          _profileError = null;
                        });
                        _loadProfile(userId);
                      },
                      child: Text(l10n?.authRetry ?? 'Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (_profile == null) {
          return CompleteProfileScreen(
            onCompleted: () {
              setState(() {
                _loadScheduled = false;
                _profile = null;
                _profileError = null;
              });
              _loadProfile(userId);
            },
          );
        }

        if (_profile!.role == UserRole.patient && !_onboardingDone) {
          return PatientOnboardingScreen(
            userId: userId,
            onFinished: () => setState(() => _onboardingDone = true),
          );
        }

        if (_profile!.role == UserRole.provider) {
          return const ProviderHomeShell();
        }

        return const HomeShell();
      },
    );
  }
}
