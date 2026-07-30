import 'package:shared_preferences/shared_preferences.dart';

/// In-app notification consent + master / category toggles (Sprint 3 W3-3 / W3-9).
/// Positive + BG prefs stay client-side until DB columns are approved.
class NotificationConsentPrefs {
  NotificationConsentPrefs._();

  static String _promptedKey(String userId) =>
      'push_consent_prompted_$userId';
  static String _masterKey(String userId) => 'push_master_enabled_$userId';
  static String _positiveKey(String userId) =>
      'push_positive_ventilation_$userId';
  static String _bgExplainedKey(String userId) =>
      'bg_refresh_explained_$userId';
  static String _bgEnabledKey(String userId) => 'bg_refresh_enabled_$userId';
  static String _positiveCooldownKey(String userId) =>
      'push_positive_last_at_$userId';

  static Future<bool> wasConsentPrompted(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_promptedKey(userId)) ?? false;
  }

  static Future<void> setConsentPrompted(String userId, bool value) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_promptedKey(userId), value);
  }

  /// Default false until explicit allow.
  static Future<bool> isMasterEnabled(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_masterKey(userId)) ?? false;
  }

  static Future<void> setMasterEnabled(String userId, bool value) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_masterKey(userId), value);
  }

  /// Positive / ventilation tips (Q-S3-05). Default true after master on.
  static Future<bool> isPositiveEnabled(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_positiveKey(userId)) ?? true;
  }

  static Future<void> setPositiveEnabled(String userId, bool value) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_positiveKey(userId), value);
  }

  static Future<bool> wasBgExplained(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_bgExplainedKey(userId)) ?? false;
  }

  static Future<void> setBgExplained(String userId, bool value) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_bgExplainedKey(userId), value);
  }

  /// Soft “refresh while using the app” — not Always location (Q-S3-02).
  static Future<bool> isBgRefreshEnabled(String userId) async {
    if (userId.isEmpty) return true;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_bgEnabledKey(userId)) ?? true;
  }

  static Future<void> setBgRefreshEnabled(String userId, bool value) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_bgEnabledKey(userId), value);
  }

  /// 6h client cooldown for positive tips (wbs3-decisions).
  static Future<bool> canSendPositive(String userId) async {
    if (userId.isEmpty) return false;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_positiveCooldownKey(userId));
    if (raw == null) return true;
    final at = DateTime.tryParse(raw);
    if (at == null) return true;
    return DateTime.now().toUtc().difference(at) >= const Duration(hours: 6);
  }

  static Future<void> markPositiveSent(String userId) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _positiveCooldownKey(userId),
      DateTime.now().toUtc().toIso8601String(),
    );
  }
}
