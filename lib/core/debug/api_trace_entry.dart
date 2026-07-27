/// One Edge Function invoke (request + response) for the Debug API Console.
class ApiTraceEntry {
  const ApiTraceEntry({
    required this.id,
    required this.at,
    required this.name,
    required this.requestBody,
    required this.elapsedMs,
    this.responseBody,
    this.statusCode,
    this.stableError,
    this.fromCache,
    this.degraded,
    this.metrics = const {},
  });

  final String id;
  final DateTime at;
  final String name;
  final Map<String, dynamic> requestBody;
  final Map<String, dynamic>? responseBody;
  final int? statusCode;
  final String? stableError;
  final int elapsedMs;
  final bool? fromCache;
  final bool? degraded;
  final Map<String, dynamic> metrics;

  ApiTraceEntry copyWith({
    Map<String, dynamic>? requestBody,
    Map<String, dynamic>? responseBody,
    int? statusCode,
    String? stableError,
    int? elapsedMs,
    bool? fromCache,
    bool? degraded,
    Map<String, dynamic>? metrics,
  }) {
    return ApiTraceEntry(
      id: id,
      at: at,
      name: name,
      requestBody: requestBody ?? this.requestBody,
      responseBody: responseBody ?? this.responseBody,
      statusCode: statusCode ?? this.statusCode,
      stableError: stableError ?? this.stableError,
      elapsedMs: elapsedMs ?? this.elapsedMs,
      fromCache: fromCache ?? this.fromCache,
      degraded: degraded ?? this.degraded,
      metrics: metrics ?? this.metrics,
    );
  }
}
