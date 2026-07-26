import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/app_config.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/auth_error_mapper.dart';
import 'sign_up_screen.dart';

/// SCR-AUTH-02 — email/password and OAuth sign-in (basic design reference).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  String? _errorMessage;

  static const _oauthRedirect = 'io.supabase.howseasthma://login-callback/';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final l10n = AppLocalizations.of(context)!;
    try {
      await SupabaseService.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (mounted) Navigator.of(context).popUntil((r) => r.isFirst);
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = AuthErrorMapper.map(e, l10n));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _oauth(OAuthProvider provider) async {
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

  Future<void> _forgotPassword() async {
    final email = _emailController.text.trim();
    final l10n = AppLocalizations.of(context)!;
    if (!email.contains('@')) {
      setState(() => _errorMessage = l10n.authValidationInvalidEmail);
      return;
    }
    try {
      await SupabaseService.client.auth.resetPasswordForEmail(email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.authCheckEmailTitle)),
      );
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = AuthErrorMapper.map(e, l10n));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final showApple = !kIsWeb && Platform.isIOS;

    if (!AppConfig.isSupabaseConfigured) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.appTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              l10n.supabaseNotConfigured,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.neutral0,
      appBar: AppBar(
        backgroundColor: AppTheme.neutral0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppTheme.brand100,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.air, size: 16, color: AppTheme.brand600),
            ),
            const SizedBox(width: 8),
            Text(l10n.appTitle),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: l10n.loginEmailLabel,
                      hintText: 'you@example.com',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || !v.contains('@'))
                        ? l10n.authValidationInvalidEmail
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: l10n.loginPasswordLabel,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.length < 8)
                        ? l10n.authValidationPasswordMin
                        : null,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _isSubmitting ? null : _forgotPassword,
                      child: Text(l10n.authForgotPassword),
                    ),
                  ),
                  if (_errorMessage != null) ...[
                    Text(
                      _errorMessage!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                    const SizedBox(height: 12),
                  ],
                  FilledButton(
                    onPressed: _isSubmitting ? null : _signIn,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.loginButton),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _isSubmitting
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
                    child: Text('${l10n.authNoAccount} ${l10n.signUpButton}'),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(l10n.authOrContinueWith),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _isSubmitting
                        ? null
                        : () => _oauth(OAuthProvider.google),
                    icon: const Icon(Icons.g_mobiledata),
                    label: Text(l10n.authContinueGoogle),
                  ),
                  if (showApple) ...[
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: _isSubmitting
                          ? null
                          : () => _oauth(OAuthProvider.apple),
                      icon: const Icon(Icons.apple),
                      label: Text(l10n.authContinueApple),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Text(
                    l10n.authUseBiometricHint,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppTheme.neutral500, fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
