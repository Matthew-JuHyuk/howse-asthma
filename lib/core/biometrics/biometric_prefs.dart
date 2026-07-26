import 'package:shared_preferences/shared_preferences.dart';

/// Local-only biometric / onboarding flags, scoped per auth user id.
class BiometricPrefs {
  BiometricPrefs._();

  static String _enabledKey(String userId) => 'biometric_unlock_enabled_$userId';
  static String _onboardingKey(String userId) => 'patient_onboarding_done_$userId';

  static Future<bool> isUnlockEnabled(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_enabledKey(userId)) ?? false;
  }

  static Future<void> setUnlockEnabled(String userId, bool enabled) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey(userId), enabled);
  }

  static Future<bool> isPatientOnboardingDone(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey(userId)) ?? false;
  }

  static Future<void> setPatientOnboardingDone(String userId, bool done) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey(userId), done);
  }

  /// Removes biometric unlock for this user (call on sign-out).
  static Future<void> clearUnlockForUser(String userId) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_enabledKey(userId));
  }
}
