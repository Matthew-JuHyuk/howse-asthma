import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/supabase/supabase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  assert(
    !kReleaseMode || !AppConfig.designPreview,
    'DESIGN_PREVIEW must be false in release builds',
  );
  if (kReleaseMode && AppConfig.designPreview) {
    throw StateError('DESIGN_PREVIEW cannot be enabled in release builds');
  }
  await SupabaseService.initialize();
  runApp(const HowseAsthmaApp());
}
