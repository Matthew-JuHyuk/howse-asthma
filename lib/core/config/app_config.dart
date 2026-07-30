import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Central place to read environment-specific configuration values.
///
/// Values come from the `.env` file (loaded via flutter_dotenv in `main.dart`).
/// Copy `.env.example` to `.env` and fill in real Supabase project values
/// before running the app.
class AppConfig {
  AppConfig._();

  static String get supabaseUrl => _read('SUPABASE_URL');

  /// The Supabase "publishable" (anon) key. The env var is kept as
  /// `SUPABASE_ANON_KEY` since that's the name shown on the Supabase
  /// dashboard, even though the Flutter SDK now calls it `publishableKey`.
  static String get supabasePublishableKey => _read('SUPABASE_ANON_KEY');

  static bool get isSupabaseConfigured =>
      _read('SUPABASE_URL').startsWith('http') &&
      _read('SUPABASE_ANON_KEY').isNotEmpty &&
      _read('SUPABASE_ANON_KEY') != 'YOUR_SUPABASE_ANON_KEY';

  /// When true, skip AuthGate and open patient design-preview mockups.
  /// Set in `.env` for device design feedback (see `lib/features/design_preview/`).
  static bool get designPreview {
    final raw = _read('DESIGN_PREVIEW').trim().toLowerCase();
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  /// Debug API Console (see `doc/qa/debug-mode-design.md`). Release builds forbid true.
  static bool get debugApiConsole {
    final raw = _read('DEBUG_API_CONSOLE').trim().toLowerCase();
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  static String _read(String key) {
    if (!dotenv.isInitialized) return '';
    return dotenv.env[key] ?? '';
  }
}
