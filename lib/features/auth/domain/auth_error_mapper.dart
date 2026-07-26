import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../l10n/app_localizations.dart';

/// Maps Supabase / Auth exceptions to localized user-facing messages.
class AuthErrorMapper {
  AuthErrorMapper._();

  static String map(Object error, AppLocalizations l10n) {
    if (error is AuthException) {
      final message = error.message.toLowerCase();
      if (message.contains('invalid login credentials') ||
          message.contains('invalid credentials')) {
        return l10n.authErrorInvalidCredentials;
      }
      if (message.contains('user already registered') ||
          message.contains('already been registered')) {
        return l10n.authErrorEmailTaken;
      }
      if (message.contains('email not confirmed')) {
        return l10n.authErrorEmailNotConfirmed;
      }
      if (message.contains('password') && message.contains('weak')) {
        return l10n.authErrorWeakPassword;
      }
      if (message.contains('rate limit') || message.contains('too many')) {
        return l10n.authErrorRateLimited;
      }
      return l10n.authErrorGeneric;
    }
    return l10n.authErrorGeneric;
  }
}
