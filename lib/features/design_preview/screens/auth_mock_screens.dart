import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../mock_nav.dart';
import '../patient_mock_shell.dart';
import '../screen_ids.dart';
import '../widgets/mock_widgets.dart';

class Auth01SplashMock extends StatelessWidget {
  const Auth01SplashMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.brand50,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppTheme.brand600,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.air, color: AppTheme.neutral0, size: 36),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.appTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.brand700,
                ),
              ),
              const SizedBox(height: 8),
              Text(MockScreenId.auth01.id, style: const TextStyle(color: AppTheme.neutral400)),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: MockPrimaryCta(
                  label: l10n.mockContinue,
                  icon: Icons.arrow_forward,
                  onPressed: () => MockNav.push(context, MockScreenId.auth02),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Auth02LoginMock extends StatelessWidget {
  const Auth02LoginMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.auth02.id,
      title: l10n.loginTitle,
      showBack: true,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 12),
          Center(
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.brand100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.air, color: AppTheme.brand600, size: 28),
                ),
                const SizedBox(height: 12),
                Text(l10n.appTitle, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.brand700)),
              ],
            ),
          ),
          const SizedBox(height: 28),
          TextField(
            decoration: InputDecoration(labelText: l10n.loginEmailLabel),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: l10n.loginPasswordLabel),
            obscureText: true,
          ),
          const SizedBox(height: 24),
          MockPrimaryCta(
            label: l10n.loginButton,
            icon: Icons.login,
            onPressed: () => MockNav.push(context, MockScreenId.auth04),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => MockNav.push(context, MockScreenId.auth03),
            child: Text(l10n.signUpButton),
          ),
        ],
      ),
    );
  }
}

class Auth03SignUpMock extends StatelessWidget {
  const Auth03SignUpMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.auth03.id,
      title: l10n.mockSignUpTitle,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.mockChooseRole, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 12),
          MockSectionCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: AppTheme.brand100,
                    child: Icon(Icons.favorite_outline, color: AppTheme.brand700),
                  ),
                  title: Text(l10n.mockRolePatient),
                  subtitle: Text(l10n.mockRolePatientHint),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => MockNav.push(context, MockScreenId.onb01),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.neutral100,
                    child: Icon(Icons.medical_services_outlined, color: AppTheme.neutral500),
                  ),
                  title: Text(l10n.mockRoleProvider),
                  subtitle: Text(l10n.mockRoleProviderHint),
                  trailing: const Icon(Icons.block, color: AppTheme.neutral400),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.mockProviderNotInPreview)),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Auth04BiometricMock extends StatelessWidget {
  const Auth04BiometricMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.auth04.id,
      title: l10n.mockBiometricTitle,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.fingerprint, size: 88, color: AppTheme.brand600),
            const SizedBox(height: 16),
            Text(l10n.mockBiometricHint, textAlign: TextAlign.center),
            const Spacer(),
            MockPrimaryCta(
              label: l10n.mockUnlock,
              icon: Icons.lock_open,
              onPressed: () => MockNav.push(context, MockScreenId.onb01),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => MockNav.push(context, MockScreenId.auth02),
              child: Text(l10n.mockUsePassword),
            ),
          ],
        ),
      ),
    );
  }
}

class Onb01PatientMock extends StatelessWidget {
  const Onb01PatientMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.onb01.id,
      title: l10n.mockOnboardingTitle,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.settingsLanguageLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: const [
                    MockChip(label: 'EN', selected: true),
                    MockChip(label: 'ES'),
                    MockChip(label: 'FR'),
                    MockChip(label: 'KO'),
                    MockChip(label: 'JA'),
                    MockChip(label: 'ZH'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.mockHomeLocation, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(l10n.mockDummyAddress, style: const TextStyle(color: AppTheme.subtext)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          MockSectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.mockEmergencyContact, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(l10n.mockDummyContact, style: const TextStyle(color: AppTheme.subtext)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.mockInviteCode,
              hintText: '123456',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          MockPrimaryCta(
            label: l10n.mockFinishOnboarding,
            icon: Icons.check,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PatientMockShell()),
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
