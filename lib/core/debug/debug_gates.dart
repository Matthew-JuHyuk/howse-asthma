import 'package:flutter/foundation.dart';

import '../config/app_config.dart';

/// Triple-gate helper for Debug API Console (design §2).
/// G1: non-release · G2: `.env` DEBUG_API_CONSOLE · G3: UI entry separately.
class DebugGates {
  DebugGates._();

  /// True when Console UI and invoke probing may run.
  static bool get enabled => !kReleaseMode && AppConfig.debugApiConsole;
}
