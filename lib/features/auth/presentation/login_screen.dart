import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/app_config.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/auth_error_mapper.dart';
import 'sign_up_screen.dart';

/// SCR-AUTH-02 — email/password and OAuth sign-in.
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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.loginTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.appTitle,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(labelText: l10n.loginEmailLabel),
                    validator: (v) => (v == null || !v.contains('@'))
                        ? l10n.authValidationInvalidEmail
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration:
                        InputDecoration(labelText: l10n.loginPasswordLabel),
                    validator: (v) => (v == null || v.length < 8)
                        ? l10n.authValidationPasswordMin
                        : null,
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
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
                  OutlinedButton(
                    onPressed: _isSubmitting
                        ? null
                        : () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
                    child: Text(l10n.signUpButton),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
