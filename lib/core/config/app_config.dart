import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Central place to read environment-specific configuration values.
///
/// Values come from the bundled `.env.client` asset (loaded via flutter_dotenv
/// in `main.dart`). Generate it with `node tool/make_client_env.mjs`, which
/// copies only the client-safe keys from `.env`.
class AppConfig {
  AppConfig._();

  static const appName = 'CoverNote';

  /// Deep link registered in AndroidManifest (scheme + host) and in the
  /// Supabase Auth redirect allow list.
  static const authRedirect = 'io.supabase.howseasthma://login-callback/';

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
  static bool get designPreview {
    final raw = _read('DESIGN_PREVIEW').trim().toLowerCase();
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  /// Debug API Console. Release builds forbid true.
  static bool get debugApiConsole {
    final raw = _read('DEBUG_API_CONSOLE').trim().toLowerCase();
    return raw == 'true' || raw == '1' || raw == 'yes';
  }

  static String _read(String key) {
    if (!dotenv.isInitialized) return '';
    return dotenv.env[key] ?? '';
  }
}
