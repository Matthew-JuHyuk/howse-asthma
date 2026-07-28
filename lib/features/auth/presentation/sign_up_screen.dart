import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/locale/locale_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../home/presentation/home_shell.dart';
import '../data/profile_repository.dart';
import '../domain/auth_error_mapper.dart';
import '../domain/npi_validator.dart';
import '../domain/user_profile.dart';
import 'check_email_screen.dart';

/// SCR-AUTH-03 — email signup with role, name, language, and NPI for providers.
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, this.initialRole = UserRole.patient});

  /// Welcome clinician link uses [UserRole.provider].
  final UserRole initialRole;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _npiController = TextEditingController();
  final _profiles = ProfileRepository();

  late UserRole _role;
  String _languageCode = 'en';
  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _role = widget.initialRole;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _npiController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final l10n = AppLocalizations.of(context)!;
    try {
      final response = await SupabaseService.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        data: {
          'role': _role.dbValue,
          'full_name': _nameController.text.trim(),
          'language_code': _languageCode,
          if (_role == UserRole.provider) 'npi': _npiController.text.trim(),
        },
      );

      if (response.session == null) {
        if (!mounted) return;
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (_) => CheckEmailScreen(
              email: _emailController.text.trim(),
            ),
          ),
        );
        return;
      }

      await _profiles.createProfile(
        role: _role,
        fullName: _nameController.text,
        languageCode: _languageCode,
        npi: _role == UserRole.provider ? _npiController.text : null,
      );

      if (!mounted) return;
      AppLocaleScope.of(context).setLocale(Locale(_languageCode));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on ArgumentError catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.message == 'Invalid NPI'
              ? l10n.authValidationInvalidNpi
              : l10n.authErrorGeneric;
        });
      }
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

    return Scaffold(
      appBar: AppBar(title: Text(l10n.signUpTitle)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.authChooseRole,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<UserRole>(
                    segments: [
                      ButtonSegment(
                        value: UserRole.patient,
                        label: Text(l10n.authRolePatient),
                        icon: const Icon(Icons.person_outline),
                      ),
                      ButtonSegment(
                        value: UserRole.provider,
                        label: Text(l10n.authRoleProvider),
                        icon: const Icon(Icons.medical_services_outlined),
                      ),
                    ],
                    selected: {_role},
                    onSelectionChanged: (value) {
                      setState(() => _role = value.first);
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _role == UserRole.patient
                        ? l10n.authRolePatientHint
                        : l10n.authRoleProviderHint,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(labelText: l10n.authFullNameLabel),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l10n.authValidationNameRequired
                        : null,
                  ),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    // ignore: deprecated_member_use
                    value: _languageCode,
                    decoration:
                        InputDecoration(labelText: l10n.settingsLanguageLabel),
                    items: supportedLocales
                        .map(
                          (locale) => DropdownMenuItem(
                            value: locale.languageCode,
                            child: Text(
                              localeDisplayNames[locale.languageCode] ??
                                  locale.languageCode,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => _languageCode = value);
                    },
                  ),
                  if (_role == UserRole.provider) ...[
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _npiController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        labelText: l10n.authNpiLabel,
                        helperText: l10n.mockNpiFormatOnly,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (_role != UserRole.provider) return null;
                        if (v == null || !NpiValidator.isValid(v)) {
                          return l10n.authValidationInvalidNpi;
                        }
                        return null;
                      },
                    ),
                  ],
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
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.signUpButton),
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
