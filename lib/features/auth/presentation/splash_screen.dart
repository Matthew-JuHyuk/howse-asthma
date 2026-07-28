import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/app_config.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/auth_error_mapper.dart';
import '../domain/user_profile.dart';
import 'login_screen.dart';
import 'sign_up_screen.dart';
import 'widgets/breathing_shield_logo.dart';
import 'widgets/welcome_language_chip.dart';

/// S2-SCR-01 — Direction C Welcome & Auth (replaces legacy splash gate).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _termsAccepted = false;
  bool _isSubmitting = false;
  String? _errorMessage;

  static const _oauthRedirect = 'io.supabase.howseasthma://login-callback/';

  Future<void> _oauth(OAuthProvider provider) async {
    if (!_termsAccepted) return;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    final l10n = AppLocalizations.of(context)!;
    try {
      await SupabaseService.client.auth.signInWithOAuth(
        provider,
        redirectTo: kIsWeb ? null : _oauthRedirect,
      );
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = AuthErrorMapper.map(e, l10n));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _termsPendingSnack() {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.welcomeTermsPending)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final showApple = !kIsWeb && Platform.isIOS;
    final configured = AppConfig.isSupabaseConfigured;
    final canAuth = configured && _termsAccepted && !_isSubmitting;

    return Scaffold(
      backgroundColor: AppTheme.welcomeBackground,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.35),
            radius: 1.1,
            colors: [
              AppTheme.welcomeAccent.withValues(alpha: 0.22),
              AppTheme.welcomeBackground,
              AppTheme.neutral900,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: WelcomeLanguageChip(),
                ),
                const SizedBox(height: 24),
                const Center(child: BreathingShieldLogo()),
                const SizedBox(height: 20),
                Text(
                  l10n.appTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.welcomeOnBackground,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.appTagline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: AppTheme.welcomeMuted,
                  ),
                ),
                const SizedBox(height: 24),
                _Benefit(text: l10n.welcomeBenefit1),
                _Benefit(text: l10n.welcomeBenefit2),
                _Benefit(text: l10n.welcomeBenefit3),
                const SizedBox(height: 28),
                if (!configured) ...[
                  Text(
                    l10n.supabaseNotConfigured,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppTheme.error500),
                  ),
                  const SizedBox(height: 12),
                ],
                if (_errorMessage != null) ...[
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppTheme.error500),
                  ),
                  const SizedBox(height: 8),
                ],
                if (showApple) ...[
                  FilledButton.icon(
                    onPressed:
                        canAuth ? () => _oauth(OAuthProvider.apple) : null,
                    icon: const Icon(Icons.apple),
                    label: Text(l10n.authContinueApple),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.neutral0,
                      foregroundColor: AppTheme.neutral900,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                FilledButton.icon(
                  onPressed:
                      canAuth ? () => _oauth(OAuthProvider.google) : null,
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: Text(l10n.authContinueGoogle),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.welcomeAccent,
                    foregroundColor: AppTheme.neutral900,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: !canAuth
                      ? null
                      : () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                  child: Text(
                    l10n.welcomeContinueEmail,
                    style: TextStyle(
                      color: canAuth
                          ? AppTheme.welcomeMuted
                          : AppTheme.neutral500,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      checkColor: AppTheme.neutral900,
                      side: const BorderSide(color: AppTheme.welcomeMuted),
                      fillColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppTheme.welcomeAccent;
                        }
                        return Colors.transparent;
                      }),
                      onChanged: configured
                          ? (v) =>
                              setState(() => _termsAccepted = v ?? false)
                          : null,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: GestureDetector(
                          onTap: _termsPendingSnack,
                          child: Text(
                            l10n.welcomeTermsAgree,
                            style: const TextStyle(
                              color: AppTheme.welcomeMuted,
                              fontSize: 13,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: configured
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const SignUpScreen(
                                initialRole: UserRole.provider,
                              ),
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    l10n.welcomeClinicianLink,
                    style: const TextStyle(
                      color: AppTheme.brand300,
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check, size: 18, color: AppTheme.welcomeAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppTheme.welcomeOnBackground,
                fontSize: 14,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
