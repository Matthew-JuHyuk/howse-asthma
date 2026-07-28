import 'package:shared_preferences/shared_preferences.dart';

/// First breathing check-in after sign-up (Sprint 2). Memory/prefs only.
class FirstCheckInPrefs {
  FirstCheckInPrefs._();

  static const breathUsual = 'breath_usual';
  static const breathSlightlyTight = 'breath_slightly_tight';
  static const breathSymptoms = 'breath_symptoms';

  static const values = [
    breathUsual,
    breathSlightlyTight,
    breathSymptoms,
  ];

  static String _key(String userId) => 'first_check_in_$userId';
  static String _shieldPromptKey(String userId) =>
      'shield_location_prompted_$userId';

  static Future<bool> isDone(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_key(userId));
    return v != null && values.contains(v);
  }

  static Future<void> setBreathing(String userId, String breathId) async {
    if (userId.isEmpty || !values.contains(breathId)) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key(userId), breathId);
  }

  static Future<bool> wasShieldLocationPrompted(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_shieldPromptKey(userId)) ?? false;
  }

  static Future<void> setShieldLocationPrompted(
    String userId,
    bool value,
  ) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_shieldPromptKey(userId), value);
  }
}
