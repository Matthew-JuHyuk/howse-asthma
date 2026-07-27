/// Scrubs secrets and optionally rounds coordinates for Debug Console display.
class DebugRedactor {
  DebugRedactor._();

  /// Keys whose values are always replaced with `***`.
  static final _secretKey = RegExp(
    r'(token|password|authorization|apikey|api_key|service_role|'
    r'private_key|privatekey|secret|jwt|refresh_token|access_token|'
    r'anon_key|email|phone|phone_e164|mobile|patient_id|provider_id|'
    r'invite_code|^code$)',
    caseSensitive: false,
  );

  static final _emailValue = RegExp(
    r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
  );
  static final _e164Value = RegExp(r'^\+[1-9]\d{7,14}$');
  static final _jwtValue = RegExp(r'^eyJ[A-Za-z0-9_-]+\.');
  static final _uuidKey = RegExp(
    r'(^id$|_id$|link_id|event\.id|user_id)',
    caseSensitive: false,
  );

  static const int maxStringLength = 4000;

  /// Headers are never recorded (Authorization / apikey).
  static Map<String, String> stripHeaders(Map<String, String>? _) =>
      const <String, String>{};

  /// Returns null when [input] is null (preserves missing vs empty map).
  static Map<String, dynamic>? scrubOrNull(
    Map<String, dynamic>? input, {
    bool roundCoordinates = false,
    int coordinateDecimals = 3,
  }) {
    if (input == null) return null;
    return scrub(
      input,
      roundCoordinates: roundCoordinates,
      coordinateDecimals: coordinateDecimals,
    );
  }

  static Map<String, dynamic> scrub(
    Map<String, dynamic>? input, {
    bool roundCoordinates = false,
    int coordinateDecimals = 3,
  }) {
    if (input == null) return {};
    return Map<String, dynamic>.from(
      _scrubValue(
            input,
            roundCoordinates: roundCoordinates,
            coordinateDecimals: coordinateDecimals,
          )
          as Map,
    );
  }

  static dynamic _scrubValue(
    dynamic value, {
    required bool roundCoordinates,
    required int coordinateDecimals,
    String? parentKey,
  }) {
    if (value is Map) {
      final out = <String, dynamic>{};
      for (final entry in value.entries) {
        final key = entry.key.toString();
        if (_secretKey.hasMatch(key)) {
          out[key] = '***';
          continue;
        }
        out[key] = _scrubValue(
          entry.value,
          roundCoordinates: roundCoordinates,
          coordinateDecimals: coordinateDecimals,
          parentKey: key,
        );
      }
      return out;
    }
    if (value is List) {
      return value
          .map(
            (e) => _scrubValue(
              e,
              roundCoordinates: roundCoordinates,
              coordinateDecimals: coordinateDecimals,
              parentKey: parentKey,
            ),
          )
          .toList();
    }
    if (value is String) {
      if (parentKey != null && _secretKey.hasMatch(parentKey)) {
        return '***';
      }
      if (_emailValue.hasMatch(value) ||
          _e164Value.hasMatch(value) ||
          _jwtValue.hasMatch(value)) {
        return '***';
      }
      if (parentKey != null &&
          _uuidKey.hasMatch(parentKey) &&
          _looksLikeUuid(value)) {
        return _shortId(value);
      }
      if (value.length > maxStringLength) {
        return '${value.substring(0, maxStringLength)}…[truncated]';
      }
      return value;
    }
    if (roundCoordinates &&
        value is num &&
        parentKey != null &&
        _isCoordinateKey(parentKey)) {
      final factor = _pow10(coordinateDecimals);
      return (value * factor).round() / factor;
    }
    return value;
  }

  static bool _isCoordinateKey(String key) {
    final k = key.toLowerCase();
    return k == 'latitude' ||
        k == 'longitude' ||
        k == 'lat' ||
        k == 'lon' ||
        k == 'lng';
  }

  static bool _looksLikeUuid(String value) {
    return RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$',
    ).hasMatch(value);
  }

  /// First 8 hex chars of a UUID (or raw string), for QA without full IDs.
  static String _shortId(String value) {
    final compact = value.replaceAll('-', '');
    if (compact.length <= 8) return '***';
    return '${compact.substring(0, 8)}…';
  }

  static int _pow10(int n) {
    var p = 1;
    for (var i = 0; i < n; i++) {
      p *= 10;
    }
    return p;
  }
}
