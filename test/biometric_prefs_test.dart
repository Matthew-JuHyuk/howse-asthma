import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/core/biometrics/biometric_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('biometric prefs are scoped per user id', () async {
    await BiometricPrefs.setUnlockEnabled('user-a', true);
    await BiometricPrefs.setUnlockEnabled('user-b', false);

    expect(await BiometricPrefs.isUnlockEnabled('user-a'), isTrue);
    expect(await BiometricPrefs.isUnlockEnabled('user-b'), isFalse);
    expect(await BiometricPrefs.isUnlockEnabled(''), isFalse);
  });

  test('onboarding flag is scoped per user id', () async {
    await BiometricPrefs.setPatientOnboardingDone('user-a', true);
    expect(await BiometricPrefs.isPatientOnboardingDone('user-a'), isTrue);
    expect(await BiometricPrefs.isPatientOnboardingDone('user-b'), isFalse);
  });

  test('clearUnlockForUser removes only that user flag', () async {
    await BiometricPrefs.setUnlockEnabled('user-a', true);
    await BiometricPrefs.setUnlockEnabled('user-b', true);
    await BiometricPrefs.clearUnlockForUser('user-a');

    expect(await BiometricPrefs.isUnlockEnabled('user-a'), isFalse);
    expect(await BiometricPrefs.isUnlockEnabled('user-b'), isTrue);
  });
}
