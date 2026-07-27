import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'push_token_repository.dart';

/// Firebase Cloud Messaging bootstrap (WBS 4.6a).
/// Android-first; no-ops on unsupported platforms or when Firebase is missing.
///
/// Use [instance] so register/unregister share the same token-refresh subscription.
class FcmService {
  FcmService._({PushTokenRepository? tokens})
      : _tokens = tokens ?? PushTokenRepository();

  static final FcmService instance = FcmService._();

  final PushTokenRepository _tokens;
  StreamSubscription<String>? _tokenRefreshSub;
  bool _firebaseReady = false;

  bool get isSupported {
    if (kIsWeb) return false;
    return !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS);
  }

  /// Call once from [main] before [runApp]. Safe if google-services.json missing.
  Future<void> initializeFirebase() async {
    if (!isSupported) return;
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      _firebaseReady = true;
    } catch (e, st) {
      debugPrint('[FcmService] Firebase.initializeApp failed: $e\n$st');
      _firebaseReady = false;
    }
  }

  /// Request permission, upsert token, listen for refresh (patient session).
  Future<void> registerCurrentDevice() async {
    if (!_firebaseReady || !isSupported) return;
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Android 13+ also needs runtime POST_NOTIFICATIONS — requestPermission
      // covers iOS; on Android 13 firebase_messaging requests notification perm.
      final token = await messaging.getToken();
      if (token == null || token.isEmpty) return;

      await _tokens.upsert(
        fcmToken: token,
        platform: _platformLabel(),
      );

      await _tokenRefreshSub?.cancel();
      _tokenRefreshSub = messaging.onTokenRefresh.listen((newToken) async {
        try {
          await _tokens.upsert(
            fcmToken: newToken,
            platform: _platformLabel(),
          );
        } catch (e) {
          debugPrint('[FcmService] token refresh upsert failed: $e');
        }
      });
    } catch (e, st) {
      debugPrint('[FcmService] registerCurrentDevice failed: $e\n$st');
    }
  }

  Future<void> unregisterCurrentDevice() async {
    await _tokenRefreshSub?.cancel();
    _tokenRefreshSub = null;
    if (!_firebaseReady || !isSupported) return;
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await _tokens.deleteToken(token);
      }
    } catch (e) {
      debugPrint('[FcmService] unregister failed: $e');
    }
  }

  String _platformLabel() {
    if (kIsWeb) return 'web';
    if (Platform.isIOS) return 'ios';
    return 'android';
  }

  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
    _tokenRefreshSub = null;
  }
}

/// Background isolate entry (must be top-level). Data-only handling is minimal;
/// OS shows the `notification` payload from Edge when app is backgrounded/killed.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Keep lightweight — no Flutter UI. Ensure Firebase is up in this isolate.
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (_) {}
}
