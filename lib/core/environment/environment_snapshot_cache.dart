import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/environment/data/environment_snapshot.dart';

/// Client last-good environment snapshot (Sprint 3 S3-UXFIX / W3-2).
class EnvironmentSnapshotCache {
  EnvironmentSnapshotCache._();

  static String _key(String userId) => 'env_snapshot_cache_$userId';

  static Future<EnvironmentSnapshot?> read(String userId) async {
    if (userId.isEmpty) return null;
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(userId));
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return EnvironmentSnapshot.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  static Future<void> write(String userId, EnvironmentSnapshot snap) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key(userId),
      jsonEncode(snap.copyWith(fromCache: true, fromStaleCache: true).toJson()),
    );
  }

  static Future<void> clear(String userId) async {
    if (userId.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key(userId));
  }
}
