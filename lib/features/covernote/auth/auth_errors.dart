import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../l10n/app_localizations.dart';

/// Safe, code-based auth failure. [code] is shown to the user for support.
class AuthFailure {
  const AuthFailure(this.kind, this.code);

  final AuthFailureKind kind;
  final String code;

  static AuthFailure from(Object e) {
    if (e is AuthRetryableFetchException ||
        e is SocketException ||
        e is TimeoutException ||
        e is HttpException) {
      return const AuthFailure(AuthFailureKind.network, 'network');
    }
    if (e is AuthApiException || e is AuthException) {
      final ae = e as AuthException;
      final code =
          ae.code ??
          (ae.statusCode == null ? 'auth_error' : 'http_${ae.statusCode}');
      return AuthFailure(_kindFor(code, ae.statusCode), code);
    }
    final s = e.toString();
    if (s.contains('SocketException') ||
        s.contains('ClientException') ||
        s.contains('Failed host lookup')) {
      return const AuthFailure(AuthFailureKind.network, 'network');
    }
    return const AuthFailure(AuthFailureKind.unknown, 'unknown');
  }

  static AuthFailureKind _kindFor(String code, String? status) {
    switch (code) {
      case 'invalid_credentials':
        return AuthFailureKind.invalidCredentials;
      case 'email_not_confirmed':
        return AuthFailureKind.emailNotConfirmed;
      case 'user_already_exists':
      case 'email_exists':
        return AuthFailureKind.alreadyExists;
      case 'weak_password':
        return AuthFailureKind.weakPassword;
      case 'same_password':
        return AuthFailureKind.samePassword;
      case 'over_email_send_rate_limit':
      case 'over_request_rate_limit':
      case 'over_sms_send_rate_limit':
        return AuthFailureKind.rateLimited;
      case 'email_address_invalid':
      case 'validation_failed':
        return AuthFailureKind.invalidEmail;
      case 'email_address_not_authorized':
        return AuthFailureKind.emailNotAuthorized;
      case 'signup_disabled':
      case 'email_provider_disabled':
      case 'provider_disabled':
        return AuthFailureKind.disabled;
      case 'session_not_found':
      case 'session_expired':
      case 'refresh_token_not_found':
      case 'refresh_token_already_used':
        return AuthFailureKind.sessionExpired;
    }
    if (status == '429') return AuthFailureKind.rateLimited;
    if (status != null && status.startsWith('5')) {
      return AuthFailureKind.serviceDown;
    }
    return AuthFailureKind.unknown;
  }

  String message(AppLocalizations l) {
    switch (kind) {
      case AuthFailureKind.invalidCredentials:
        return l.cnAuthErrInvalidCredentials;
      case AuthFailureKind.emailNotConfirmed:
        return l.cnAuthErrNotConfirmed;
      case AuthFailureKind.alreadyExists:
        return l.cnAuthErrExists;
      case AuthFailureKind.weakPassword:
        return l.cnAuthErrWeakPassword;
      case AuthFailureKind.samePassword:
        return l.cnAuthErrSamePassword;
      case AuthFailureKind.rateLimited:
        return l.cnAuthErrRateLimited;
      case AuthFailureKind.invalidEmail:
        return l.cnAuthErrInvalidEmail;
      case AuthFailureKind.emailNotAuthorized:
        return l.cnAuthErrEmailNotAuthorized;
      case AuthFailureKind.disabled:
        return l.cnAuthErrDisabled;
      case AuthFailureKind.sessionExpired:
        return l.cnAuthErrSessionExpired;
      case AuthFailureKind.network:
        return l.cnErrNetwork;
      case AuthFailureKind.serviceDown:
        return l.cnErrServiceDown;
      case AuthFailureKind.unknown:
        return l.cnAuthErrUnknown(code);
    }
  }
}

enum AuthFailureKind {
  invalidCredentials,
  emailNotConfirmed,
  alreadyExists,
  weakPassword,
  samePassword,
  rateLimited,
  invalidEmail,
  emailNotAuthorized,
  disabled,
  sessionExpired,
  network,
  serviceDown,
  unknown,
}
