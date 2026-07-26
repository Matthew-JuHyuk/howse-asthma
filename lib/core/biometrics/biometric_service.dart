import 'package:local_auth/local_auth.dart';

/// Thin wrapper around [LocalAuthentication].
class BiometricService {
  BiometricService({LocalAuthentication? auth})
      : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  Future<bool> canCheckBiometrics() async {
    try {
      final supported = await _auth.isDeviceSupported();
      if (!supported) return false;
      return await _auth.canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate({required String localizedReason}) async {
    try {
      return await _auth.authenticate(
        localizedReason: localizedReason,
        biometricOnly: false,
      );
    } catch (_) {
      return false;
    }
  }
}
