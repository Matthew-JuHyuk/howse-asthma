import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/app_config.dart';
import '../../../core/locale/app_languages.dart';
import '../../../core/locale/language_picker.dart';
import '../../../core/session/session_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../ui/brand.dart';
import 'auth_errors.dart';

/// Opens sign-in when needed and resolves true once a profile is ready.
Future<bool> requireSignIn(BuildContext context) async {
  final session = SessionScope.read(context);
  if (session.isReady) return true;
  final ok = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      builder: (_) => const AuthScreen(),
      fullscreenDialog: true,
    ),
  );
  return ok == true && session.isReady;
}

enum _Mode { signIn, create, reset }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.startWithCreate = false});

  final bool startWithCreate;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  late _Mode _mode = widget.startWithCreate ? _Mode.create : _Mode.signIn;
  bool _busy = false;
  bool _obscure = true;
  AuthFailure? _failure;
  String? _notice;
  bool _awaitingConfirmation = false;
  SessionController? _session;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final s = SessionScope.of(context);
    if (!identical(s, _session)) {
      _session?.removeListener(_onSession);
      _session = s..addListener(_onSession);
    }
  }

  void _onSession() {
    if (!mounted) return;
    if (_session!.isReady) {
      Navigator.of(context).pop(true);
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _session?.removeListener(_onSession);
    _email.dispose();
    _password.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _failure = null;
      _notice = null;
    });
    final auth = SupabaseService.client.auth;
    final email = _email.text.trim();
    final l = AppLocalizations.of(context)!;
    try {
      switch (_mode) {
        case _Mode.signIn:
          await auth.signInWithPassword(email: email, password: _password.text);
        case _Mode.create:
          final res = await auth.signUp(
            email: email,
            password: _password.text,
            emailRedirectTo: AppConfig.authRedirect,
            data: {
              'role': 'PATIENT',
              if (_name.text.trim().isNotEmpty) 'full_name': _name.text.trim(),
              'language_code':
                  (appLanguageForLocale(Localizations.localeOf(context)) ??
                          defaultAppLanguage)
                      .tag,
            },
          );
          if (res.session == null) {
            // Existing confirmed emails return an obfuscated user with no identities.
            final identities = res.user?.identities;
            if (identities != null && identities.isEmpty) {
              _failure = const AuthFailure(
                AuthFailureKind.alreadyExists,
                'user_already_exists',
              );
            } else {
              _awaitingConfirmation = true;
              _notice = l.cnAuthCheckEmail(email);
            }
          }
        case _Mode.reset:
          await auth.resetPasswordForEmail(
            email,
            redirectTo: AppConfig.authRedirect,
          );
          _notice = l.cnAuthResetSent(email);
      }
    } catch (e) {
      _failure = AuthFailure.from(e);
    }
    if (mounted) setState(() => _busy = false);
  }

  Future<void> _resend() async {
    setState(() {
      _busy = true;
      _failure = null;
    });
    final l = AppLocalizations.of(context)!;
    try {
      await SupabaseService.client.auth.resend(
        type: OtpType.signup,
        email: _email.text.trim(),
        emailRedirectTo: AppConfig.authRedirect,
      );
      _notice = l.cnAuthResent;
    } catch (e) {
      _failure = AuthFailure.from(e);
    }
    if (mounted) setState(() => _busy = false);
  }

  void _switch(_Mode m) => setState(() {
    _mode = m;
    _failure = null;
    _notice = null;
    _awaitingConfirmation = false;
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final session = _session!;
    final title = switch (_mode) {
      _Mode.signIn => l.cnAuthSignInTitle,
      _Mode.create => l.cnAuthCreateTitle,
      _Mode.reset => l.cnAuthResetTitle,
    };
    final profileProblem = session.status == SessionStatus.profileError;
    final loadingProfile = session.status == SessionStatus.loadingProfile;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [LanguageButton(), SizedBox(width: 8)],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const BrandLockup(compact: true),
                const SizedBox(height: 24),
                if (profileProblem) ...[
                  _Banner(
                    text: l.cnAuthProfileError(session.profileErrorCode ?? '-'),
                    error: true,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: session.retryProfile,
                          child: Text(l.cnRetry),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextButton(
                          onPressed: session.signOut,
                          child: Text(l.cnSignOut),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                if (loadingProfile) ...[
                  const LinearProgressIndicator(),
                  const SizedBox(height: 8),
                  Text(l.cnAuthPreparingAccount, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                ],
                Form(
                  key: _form,
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (_mode == _Mode.create) ...[
                          TextFormField(
                            controller: _name,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.name],
                            decoration: InputDecoration(
                              labelText: l.cnAuthNameLabel,
                              helperText: l.cnAuthNameHelper,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: _mode == _Mode.reset
                              ? TextInputAction.done
                              : TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          decoration: InputDecoration(
                            labelText: l.cnAuthEmailLabel,
                          ),
                          validator: (v) {
                            final t = (v ?? '').trim();
                            final ok = RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                            ).hasMatch(t);
                            return ok ? null : l.cnAuthErrInvalidEmail;
                          },
                        ),
                        if (_mode != _Mode.reset) ...[
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _password,
                            obscureText: _obscure,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _busy ? null : _submit(),
                            autofillHints: [
                              _mode == _Mode.create
                                  ? AutofillHints.newPassword
                                  : AutofillHints.password,
                            ],
                            decoration: InputDecoration(
                              labelText: l.cnAuthPasswordLabel,
                              helperText: _mode == _Mode.create
                                  ? l.cnAuthPasswordHelper
                                  : null,
                              suffixIcon: IconButton(
                                tooltip: _obscure
                                    ? l.cnAuthShowPassword
                                    : l.cnAuthHidePassword,
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ),
                            validator: (v) {
                              if (_mode == _Mode.create &&
                                  (v ?? '').length < 8) {
                                return l.cnAuthPasswordHelper;
                              }
                              if ((v ?? '').isEmpty) {
                                return l.cnAuthPasswordRequired;
                              }
                              return null;
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (_failure != null) ...[
                  _Banner(text: _failure!.message(l), error: true),
                  if (_failure!.kind == AuthFailureKind.emailNotConfirmed)
                    TextButton(
                      onPressed: _busy ? null : _resend,
                      child: Text(l.cnAuthResend),
                    ),
                  if (_failure!.kind == AuthFailureKind.alreadyExists)
                    TextButton(
                      onPressed: () => _switch(_Mode.signIn),
                      child: Text(l.cnAuthSignInInstead),
                    ),
                  const SizedBox(height: 8),
                ],
                if (_notice != null) ...[
                  _Banner(text: _notice!, error: false),
                  if (_awaitingConfirmation)
                    TextButton(
                      onPressed: _busy ? null : _resend,
                      child: Text(l.cnAuthResend),
                    ),
                  const SizedBox(height: 8),
                ],
                FilledButton(
                  onPressed: _busy || loadingProfile ? null : _submit,
                  child: _busy
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.5),
                        )
                      : Text(switch (_mode) {
                          _Mode.signIn => l.cnAuthSignIn,
                          _Mode.create => l.cnAuthCreate,
                          _Mode.reset => l.cnAuthSendReset,
                        }),
                ),
                const SizedBox(height: 16),
                if (_mode == _Mode.signIn) ...[
                  TextButton(
                    onPressed: () => _switch(_Mode.reset),
                    child: Text(l.cnAuthForgot),
                  ),
                  TextButton(
                    onPressed: () => _switch(_Mode.create),
                    child: Text(l.cnAuthNoAccount),
                  ),
                ],
                if (_mode == _Mode.create)
                  TextButton(
                    onPressed: () => _switch(_Mode.signIn),
                    child: Text(l.cnAuthHaveAccount),
                  ),
                if (_mode == _Mode.reset) ...[
                  Text(
                    l.cnAuthResetHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () => _switch(_Mode.signIn),
                    child: Text(l.cnAuthBackToSignIn),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  l.cnAuthPrivacyLine,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.text, required this.error});

  final String text;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      liveRegion: true,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: error ? scheme.errorContainer : scheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              error ? Icons.error_outline : Icons.mark_email_read_outlined,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}

/// Shown after the user opens a password-reset link on this device.
class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final _form = GlobalKey<FormState>();
  final _password = TextEditingController();
  bool _busy = false;
  AuthFailure? _failure;

  @override
  void dispose() {
    _password.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_form.currentState?.validate() ?? false)) return;
    setState(() {
      _busy = true;
      _failure = null;
    });
    final session = SessionScope.read(context);
    final messenger = ScaffoldMessenger.of(context);
    final l = AppLocalizations.of(context)!;
    try {
      await SupabaseService.client.auth.updateUser(
        UserAttributes(password: _password.text),
      );
      messenger.showSnackBar(SnackBar(content: Text(l.cnAuthPasswordUpdated)));
      session.clearPasswordRecovery();
    } catch (e) {
      if (mounted) setState(() => _failure = AuthFailure.from(e));
    }
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l.cnAuthNewPasswordTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Form(
              key: _form,
              child: TextFormField(
                controller: _password,
                obscureText: true,
                autofillHints: const [AutofillHints.newPassword],
                decoration: InputDecoration(
                  labelText: l.cnAuthNewPasswordLabel,
                  helperText: l.cnAuthPasswordHelper,
                ),
                validator: (v) =>
                    (v ?? '').length < 8 ? l.cnAuthPasswordHelper : null,
              ),
            ),
            const SizedBox(height: 16),
            if (_failure != null) ...[
              _Banner(text: _failure!.message(l), error: true),
              const SizedBox(height: 8),
            ],
            FilledButton(
              onPressed: _busy ? null : _save,
              child: Text(l.cnAuthSavePassword),
            ),
            TextButton(
              onPressed: () =>
                  SessionScope.read(context).clearPasswordRecovery(),
              child: Text(l.cnLater),
            ),
          ],
        ),
      ),
    );
  }
}
