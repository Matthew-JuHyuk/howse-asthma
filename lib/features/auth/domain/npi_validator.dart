/// NPI format validation (MVP): 10 digits + Luhn checksum with prefix 80840.
/// No NPPES live lookup.
class NpiValidator {
  NpiValidator._();

  static final _digitsOnly = RegExp(r'^\d{10}$');

  /// Returns true when [npi] is a valid 10-digit NPI including checksum.
  static bool isValid(String npi) {
    final trimmed = npi.trim();
    if (!_digitsOnly.hasMatch(trimmed)) return false;
    return _luhnCheck('80840$trimmed');
  }

  static bool _luhnCheck(String digits) {
    var sum = 0;
    var alternate = false;
    for (var i = digits.length - 1; i >= 0; i--) {
      var n = int.parse(digits[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) n -= 9;
      }
      sum += n;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }
}
