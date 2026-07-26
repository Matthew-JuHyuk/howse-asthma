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
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.brand700,
              AppTheme.brand800,
              AppTheme.neutral900,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    MockScreenId.auth01.id,
                    style: TextStyle(
                      color: AppTheme.brand200.withValues(alpha: 0.7),
                      fontSize: 11,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppTheme.brand400.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.air, size: 48, color: AppTheme.brand200),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.appTitle,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.neutral0,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: 48,
                  height: 2,
                  color: AppTheme.brand400.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.splashTagline,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.brand200, height: 1.5),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.brand400,
                      foregroundColor: AppTheme.neutral900,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => MockNav.push(context, MockScreenId.auth03),
                    child: Text(l10n.splashGetStarted),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => MockNav.push(context, MockScreenId.auth02),
                  child: Text(
                    '${l10n.splashAlreadyHaveAccount} ${l10n.splashSignIn}',
                    style: const TextStyle(color: AppTheme.brand300),
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

class Auth02LoginMock extends StatelessWidget {
  const Auth02LoginMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.neutral0,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          children: [
            Text(MockScreenId.auth02.id,
                style: const TextStyle(color: AppTheme.neutral400, fontSize: 11)),
            const SizedBox(height: 24),
            Row(
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
                Text(l10n.appTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.brand700,
                      fontSize: 18,
                    )),
              ],
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: l10n.loginEmailLabel,
                hintText: 'you@example.com',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                labelText: l10n.loginPasswordLabel,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(l10n.authForgotPassword),
              ),
            ),
            const SizedBox(height: 8),
            MockPrimaryCta(
              label: l10n.loginButton,
              icon: Icons.login,
              onPressed: () => MockNav.push(context, MockScreenId.auth04),
            ),
            const SizedBox(height: 12),
            Center(
              child: TextButton(
                onPressed: () => MockNav.push(context, MockScreenId.auth03),
                child: Text('${l10n.authNoAccount} ${l10n.signUpButton}'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(l10n.authOrContinueWith,
                      style: const TextStyle(color: AppTheme.neutral500)),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.g_mobiledata),
              label: Text(l10n.authContinueGoogle),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.apple),
              label: Text(l10n.authContinueApple),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.authUseBiometricHint,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.neutral500, fontSize: 13),
            ),
          ],
        ),
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
      title: l10n.authChooseRole,
      showBack: true,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: _RoleCard(
                  label: l10n.authRolePatient,
                  selected: false,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RoleCard(
                  label: l10n.authRoleProvider,
                  selected: true,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.authFullNameLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Text(l10n.settingsLanguageLabel,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const ['EN', 'ES', 'FR', 'KO', 'JA', 'ZH']
                .map((c) => Chip(label: Text(c)))
                .toList(),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.authNpiLabel,
              helperText: l10n.authNpiHelper,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.loginPasswordLabel,
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          MockPrimaryCta(
            label: l10n.mockContinue,
            icon: Icons.arrow_forward,
            onPressed: () => MockNav.push(context, MockScreenId.onb02),
          ),
          TextButton(
            onPressed: () => MockNav.push(context, MockScreenId.auth02),
            child: Text('${l10n.splashAlreadyHaveAccount} ${l10n.splashSignIn}'),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: selected ? AppTheme.brand50 : AppTheme.neutral50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppTheme.brand600 : AppTheme.neutral200,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              selected ? Icons.medical_services : Icons.person_outline,
              size: 40,
              color: selected ? AppTheme.brand600 : AppTheme.neutral400,
            ),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: selected ? AppTheme.brand700 : AppTheme.neutral500,
                )),
          ],
        ),
      ),
    );
  }
}

class Auth04BiometricMock extends StatelessWidget {
  const Auth04BiometricMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.neutral0,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Text(MockScreenId.auth04.id,
                  style: const TextStyle(color: AppTheme.neutral400, fontSize: 11)),
              const Spacer(),
              Container(
                width: 128,
                height: 128,
                decoration: const BoxDecoration(
                  color: AppTheme.brand50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.fingerprint, size: 64, color: AppTheme.brand600),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.authBiometricTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.neutral900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.authBiometricHint,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.neutral500),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.authTouchSensorHint,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.neutral400, fontSize: 13),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => MockNav.push(context, MockScreenId.auth02),
                child: Text(l10n.mockUsePassword),
              ),
              const SizedBox(height: 12),
              MockPrimaryCta(
                label: l10n.mockUnlock,
                icon: Icons.lock_open,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(
                      builder: (_) => const PatientMockShell(),
                    ),
                    (_) => false,
                  );
                },
              ),
            ],
          ),
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
      title: l10n.authOnboardingTitle,
      showBack: true,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.mockChooseLanguage,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const ['EN', 'ES', 'FR', 'KO', 'JA', 'ZH']
                .map((c) => Chip(label: Text(c)))
                .toList(),
          ),
          const Divider(height: 32),
          Text(l10n.mockYourLocation,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.my_location),
            label: Text(l10n.mockUseCurrentLocation),
          ),
          Text(l10n.mockLocationTrapOnly,
              style: const TextStyle(color: AppTheme.neutral400, fontSize: 12)),
          const Divider(height: 32),
          Text(l10n.mockLabelYourPlace,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: Text(l10n.mockHomeLocation)),
              Chip(label: Text(l10n.mockSchool)),
              Chip(label: Text(l10n.mockWork)),
              Chip(label: Text(l10n.mockOther)),
            ],
          ),
          const Divider(height: 32),
          Text(l10n.mockEmergencyContact,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          Text(l10n.mockEmergencyOnePerson,
              style: const TextStyle(color: AppTheme.neutral500)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.mockContactName,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.mockPhoneNumber,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          const Divider(height: 32),
          Text(l10n.mockProviderPairing,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          Text(l10n.authInviteCodeHelper,
              style: const TextStyle(color: AppTheme.neutral500)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.authInviteCodeLabel,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
          Text(l10n.mockPairingOptional,
              style: const TextStyle(color: AppTheme.neutral400, fontSize: 12)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<void>(
                        builder: (_) => const PatientMockShell(),
                      ),
                      (_) => false,
                    );
                  },
                  child: Text(l10n.authOnboardingSkip),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute<void>(
                        builder: (_) => const PatientMockShell(),
                      ),
                      (_) => false,
                    );
                  },
                  child: Text(l10n.mockNext),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Onb02ProviderMock extends StatelessWidget {
  const Onb02ProviderMock({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MockScreenChrome(
      screenId: MockScreenId.onb02.id,
      title: l10n.mockProfessionalProfile,
      showBack: true,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.mockStep2Of4,
              style: const TextStyle(color: AppTheme.brand600, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(l10n.mockProfessionalProfile,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          Text(l10n.mockTellPractice,
              style: const TextStyle(color: AppTheme.neutral500)),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.authFullNameLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.mockSpecialtyLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.mockClinicLabel,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              labelText: l10n.authNpiLabel,
              helperText: l10n.mockNpiFormatOnly,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          Text(l10n.mockCredentialsSecure,
              style: const TextStyle(color: AppTheme.neutral500, fontSize: 12)),
          const SizedBox(height: 20),
          MockPrimaryCta(
            label: l10n.mockContinue,
            icon: Icons.arrow_forward,
            onPressed: () {},
          ),
          TextButton(
            onPressed: () => MockNav.push(context, MockScreenId.auth02),
            child: Text('${l10n.splashAlreadyHaveAccount} ${l10n.splashSignIn}'),
          ),
        ],
      ),
    );
  }
}
