/// Minimal E.164 validation / normalization for emergency contacts.
class PhoneE164 {
  static final RegExp _valid = RegExp(r'^\+[1-9]\d{7,14}$');

  static bool isValid(String value) => _valid.hasMatch(value.trim());

  /// Strips formatting; ensures a leading `+` when digits look like E.164.
  /// Returns null if the result is not a valid E.164 number.
  static String? normalize(String raw) {
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return null;

    final hasPlus = trimmed.startsWith('+');
    final digits = trimmed.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return null;

    final candidate = hasPlus || digits.length >= 11 ? '+$digits' : null;
    if (candidate == null) return null;
    return isValid(candidate) ? candidate : null;
  }
}
