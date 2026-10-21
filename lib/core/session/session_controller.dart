import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/data/profile_repository.dart';
import '../../features/auth/domain/user_profile.dart';
import '../config/app_config.dart';
import '../supabase/supabase_service.dart';

enum SessionStatus {
  unconfigured,
  signedOut,
  loadingProfile,
  ready,
  profileError,
}

/// Auth session + profile for the whole app.
///
/// The shell stays visible while signed out; screens that save data call
/// [SessionScope.requireSignIn] and continue once a profile is ready.
class SessionController extends ChangeNotifier {
  SessionController({ProfileRepository? profiles})
    : _profiles = profiles ?? ProfileRepository();

  final ProfileRepository _profiles;
  StreamSubscription<AuthState>? _sub;

  SessionStatus status = SessionStatus.signedOut;
  UserProfile? profile;
  String? profileErrorCode;
  bool passwordRecovery = false;
  String? _loadedFor;

  User? get user =>
      AppConfig.isSupabaseConfigured ? SupabaseService.currentUser : null;
  bool get isReady => status == SessionStatus.ready && profile != null;
  bool get isPatient => profile?.role == UserRole.patient;

  void start() {
    if (!AppConfig.isSupabaseConfigured) {
      status = SessionStatus.unconfigured;
      notifyListeners();
      return;
    }
    _sub = SupabaseService.authStateChanges.listen(_onAuth, onError: (_) {});
    final current = SupabaseService.client.auth.currentSession;
    if (current != null) {
      unawaited(_loadProfile(current.user));
    }
  }

  void _onAuth(AuthState state) {
    if (state.event == AuthChangeEvent.passwordRecovery) {
      passwordRecovery = true;
      notifyListeners();
    }
    final session = state.session;
    if (session == null) {
      _loadedFor = null;
      profile = null;
      profileErrorCode = null;
      passwordRecovery = false;
      status = SessionStatus.signedOut;
      notifyListeners();
      return;
    }
    if (_loadedFor != session.user.id || status == SessionStatus.signedOut) {
      unawaited(_loadProfile(session.user));
    }
  }

  Future<void> retryProfile() async {
    final u = user;
    if (u != null) await _loadProfile(u, force: true);
  }

  Future<void> _loadProfile(User u, {bool force = false}) async {
    if (!force && _loadedFor == u.id && status != SessionStatus.profileError) {
      return;
    }
    _loadedFor = u.id;
    status = SessionStatus.loadingProfile;
    profileErrorCode = null;
    notifyListeners();
    try {
      var p = await _profiles.fetchCurrent();
      p ??= await _createPatientProfile(u);
      if (SupabaseService.currentUser?.id != u.id) return;
      profile = p;
      status = SessionStatus.ready;
    } on PostgrestException catch (e) {
      profileErrorCode = e.code ?? 'db_error';
      status = SessionStatus.profileError;
    } on AuthException catch (e) {
      profileErrorCode = e.code ?? 'auth_error';
      status = SessionStatus.profileError;
    } catch (e) {
      profileErrorCode = _isNetwork(e) ? 'network' : 'profile_unavailable';
      status = SessionStatus.profileError;
    }
    notifyListeners();
  }

  Future<UserProfile> _createPatientProfile(User u) async {
    final meta = u.userMetadata ?? const {};
    var name = (meta['full_name'] as String?)?.trim() ?? '';
    if (name.isEmpty) {
      final email = u.email ?? '';
      name = email.contains('@') ? email.split('@').first : 'Patient';
    }
    final lang = (meta['language_code'] as String?) ?? 'en';
    try {
      return await _profiles.createProfile(
        role: UserRole.patient,
        fullName: name,
        languageCode: lang,
      );
    } on PostgrestException catch (e) {
      // Another tab or the sign-up screen may have inserted it first.
      if (e.code == '23505') {
        final again = await _profiles.fetchCurrent();
        if (again != null) return again;
      }
      rethrow;
    }
  }

  void clearPasswordRecovery() {
    passwordRecovery = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await SupabaseService.client.auth.signOut();
    } catch (_) {
      // Local session is cleared by the SDK even if the network call fails.
    }
  }

  static bool _isNetwork(Object e) {
    final s = e.toString();
    return s.contains('SocketException') ||
        s.contains('ClientException') ||
        s.contains('Failed host lookup') ||
        s.contains('TimeoutException');
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

class SessionScope extends InheritedNotifier<SessionController> {
  const SessionScope({
    super.key,
    required SessionController controller,
    required super.child,
  }) : super(notifier: controller);

  static SessionController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SessionScope>();
    assert(scope != null, 'SessionScope missing');
    return scope!.notifier!;
  }

  static SessionController read(BuildContext context) {
    final scope = context.getInheritedWidgetOfExactType<SessionScope>();
    return scope!.notifier!;
  }
}
