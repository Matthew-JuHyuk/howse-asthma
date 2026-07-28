import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/locale/locale_controller.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../home/presentation/home_shell.dart';
import '../data/profile_repository.dart';
import '../domain/npi_validator.dart';
import '../domain/user_profile.dart';

/// Completes profile after OAuth (or any session without a profiles row).
///
/// [lockedRole] hides the patient/provider switcher (Sprint 2: default patient).
class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({
    super.key,
    this.onCompleted,
    this.lockedRole,
  });

  final VoidCallback? onCompleted;
  final UserRole? lockedRole;

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _npiController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _clinicController = TextEditingController();
  final _profiles = ProfileRepository();

  late UserRole _role;
  String _languageCode = 'en';
  bool _isSubmitting = false;
  String? _errorMessage;

  bool get _roleLocked => widget.lockedRole != null;

  @override
  void initState() {
    super.initState();
    _role = widget.lockedRole ?? UserRole.patient;
    final meta = SupabaseService.currentUser?.userMetadata ?? {};
    final role = UserRole.fromDb(meta['role'] as String?);
    if (!_roleLocked && role != null) _role = role;
    final name = (meta['full_name'] as String?) ?? (meta['name'] as String?);
    if (name != null && name.isNotEmpty) _nameController.text = name;
    if (_nameController.text.isEmpty) {
      final email = SupabaseService.currentUser?.email;
      if (email != null && email.contains('@')) {
        _nameController.text = email.split('@').first;
      }
    }
    final lang = meta['language_code'] as String?;
    if (lang != null && localeDisplayNames.containsKey(lang)) {
      _languageCode = lang;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final saved = await LocaleController.savedLanguageCode();
        if (saved != null && mounted) {
          setState(() => _languageCode = saved);
        }
      });
    }
    final npi = meta['npi'] as String?;
    if (npi != null) _npiController.text = npi;

    // Signup may have inserted the profile while this screen was mounting.
    WidgetsBinding.instance.addPostFrameCallback((_) => _recoverIfExists());
  }

  Future<void> _recoverIfExists() async {
    final existing = await _profiles.fetchCurrent();
    if (existing != null && mounted) {
      widget.onCompleted?.call();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _npiController.dispose();
    _specialtyController.dispose();
    _clinicController.dispose();
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
      await _profiles.createProfile(
        role: _role,
        fullName: _nameController.text,
        languageCode: _languageCode,
        npi: _role == UserRole.provider ? _npiController.text : null,
      );
      if (!mounted) return;
      AppLocaleScope.of(context).setLocale(Locale(_languageCode));
      widget.onCompleted?.call();
    } on ArgumentError catch (e) {
      setState(() {
        _errorMessage = e.message == 'Invalid NPI'
            ? l10n.authValidationInvalidNpi
            : l10n.authErrorGeneric;
      });
    } catch (_) {
      setState(() => _errorMessage = l10n.authErrorGeneric);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isProvider = _role == UserRole.provider;

    return Scaffold(
      backgroundColor: AppTheme.neutral0,
      appBar: AppBar(
        title: Text(
          isProvider ? l10n.mockProfessionalProfile : l10n.authCompleteProfileTitle,
        ),
        backgroundColor: AppTheme.neutral0,
      ),
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
                  if (isProvider) ...[
                    Text(
                      l10n.mockStep2Of4,
                      style: const TextStyle(
                        color: AppTheme.brand600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.mockTellPractice,
                      style: const TextStyle(color: AppTheme.neutral500),
                    ),
                  ] else
                    Text(l10n.authCompleteProfileBody),
                  const SizedBox(height: 16),
                  if (!_roleLocked) ...[
                    SegmentedButton<UserRole>(
                      segments: [
                        ButtonSegment(
                          value: UserRole.patient,
                          label: Text(l10n.authRolePatient),
                        ),
                        ButtonSegment(
                          value: UserRole.provider,
                          label: Text(l10n.authRoleProvider),
                        ),
                      ],
                      selected: {_role},
                      onSelectionChanged: (value) {
                        setState(() => _role = value.first);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: l10n.authFullNameLabel,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l10n.authValidationNameRequired
                        : null,
                  ),
                  if (isProvider) ...[
                    const SizedBox(height: 12),
                    TextField(
                      controller: _specialtyController,
                      decoration: InputDecoration(
                        labelText: l10n.mockSpecialtyLabel,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _clinicController,
                      decoration: InputDecoration(
                        labelText: l10n.mockClinicLabel,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    // ignore: deprecated_member_use
                    value: _languageCode,
                    decoration: InputDecoration(
                      labelText: l10n.settingsLanguageLabel,
                      border: const OutlineInputBorder(),
                    ),
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
                  if (isProvider) ...[
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
                        if (v == null || !NpiValidator.isValid(v)) {
                          return l10n.authValidationInvalidNpi;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.mockCredentialsSecure,
                      style: const TextStyle(
                        color: AppTheme.neutral500,
                        fontSize: 12,
                      ),
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
                        : Text(l10n.mockContinue),
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
