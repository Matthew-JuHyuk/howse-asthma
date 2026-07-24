import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/config/app_config.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../home/presentation/home_shell.dart';
import 'login_screen.dart';

/// Shows [LoginScreen] or [HomeShell] depending on the current Supabase
/// auth session, and reacts live to sign-in / sign-out events.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    if (!AppConfig.isSupabaseConfigured) {
      return const LoginScreen();
    }

    return StreamBuilder<AuthState>(
      stream: SupabaseService.authStateChanges,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? SupabaseService.client.auth.currentSession;
        if (session != null) {
          return const HomeShell();
        }
        return const LoginScreen();
      },
    );
  }
}
