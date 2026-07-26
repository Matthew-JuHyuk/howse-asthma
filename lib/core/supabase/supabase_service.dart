import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/app_config.dart';

/// Thin wrapper around the Supabase Flutter SDK used for authentication
/// and database access throughout the app.
class SupabaseService {
  SupabaseService._();

  static Future<void> initialize() async {
    if (!AppConfig.isSupabaseConfigured) {
      // Allows the app to boot (e.g. to show setup instructions) even
      // before a real Supabase project has been created.
      return;
    }

    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      publishableKey: AppConfig.supabasePublishableKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
  }

  static SupabaseClient get client => Supabase.instance.client;

  static Stream<AuthState> get authStateChanges =>
      client.auth.onAuthStateChange;

  static User? get currentUser => client.auth.currentUser;
}
