import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/push/fcm_service.dart';
import 'core/supabase/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  assert(
    !kReleaseMode || !AppConfig.designPreview,
    'DESIGN_PREVIEW must be false in release builds',
  );
  assert(
    !kReleaseMode || !AppConfig.debugApiConsole,
    'DEBUG_API_CONSOLE must be false in release builds',
  );
  if (kReleaseMode && AppConfig.designPreview) {
    throw StateError('DESIGN_PREVIEW cannot be enabled in release builds');
  }
  if (kReleaseMode && AppConfig.debugApiConsole) {
    throw StateError('DEBUG_API_CONSOLE cannot be enabled in release builds');
  }

  final fcm = FcmService.instance;
  await fcm.initializeFirebase();
  // Must be registered before runApp; skip on desktop when Firebase is unused.
  if (fcm.isSupported) {
    try {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    } catch (_) {}
  }

  await SupabaseService.initialize();
  runApp(const HowseAsthmaApp());
}
