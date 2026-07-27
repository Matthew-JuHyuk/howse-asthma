import 'package:supabase_flutter/supabase_flutter.dart';

import '../supabase/supabase_service.dart';
import 'api_metrics_extractor.dart';
import 'api_trace_entry.dart';
import 'api_trace_store.dart';
import 'debug_gates.dart';
import 'debug_redactor.dart';

/// Single wrapper for all Edge `functions.invoke` calls (design §3.2).
class DebugFunctionsClient {
  DebugFunctionsClient._();

  static int _seq = 0;

  static Future<FunctionResponse> invoke(
    String name, {
    Map<String, dynamic>? body,
  }) async {
    if (!DebugGates.enabled) {
      return SupabaseService.client.functions.invoke(name, body: body);
    }

    _seq++;
    final id = '${DateTime.now().microsecondsSinceEpoch}-$_seq-$name';
    final at = DateTime.now();
    // Store full precision; UI toggle rounds for display only.
    final redactedRequest = DebugRedactor.scrub(
      body == null ? null : Map<String, dynamic>.from(body),
    );
    final sw = Stopwatch()..start();

    try {
      final response =
          await SupabaseService.client.functions.invoke(name, body: body);
      sw.stop();
      final map = _asMap(response.data);
      final metrics = DebugRedactor.scrub(
        Map<String, dynamic>.from(ApiMetricsExtractor.extract(name, map)),
      );
      ApiTraceStore.instance.add(
        ApiTraceEntry(
          id: id,
          at: at,
          name: name,
          requestBody: redactedRequest,
          responseBody: DebugRedactor.scrubOrNull(map),
          statusCode: response.status,
          elapsedMs: sw.elapsedMilliseconds,
          fromCache: map?['from_cache'] is bool
              ? map!['from_cache'] as bool
              : null,
          degraded: map?['degraded'] is bool ? map!['degraded'] as bool : null,
          metrics: metrics,
        ),
      );
      return response;
    } on FunctionException catch (e) {
      sw.stop();
      final detailsMap = _asMap(e.details);
      final stable = _stableCode(e);
      final metrics = DebugRedactor.scrub({
        ...ApiMetricsExtractor.extract(name, detailsMap),
        'error': stable,
      });
      ApiTraceStore.instance.add(
        ApiTraceEntry(
          id: id,
          at: at,
          name: name,
          requestBody: redactedRequest,
          responseBody: detailsMap != null
              ? DebugRedactor.scrubOrNull(detailsMap)
              : (e.details is String
                  ? DebugRedactor.scrub({'detail': e.details as String})
                  : null),
          statusCode: e.status,
          stableError: stable,
          elapsedMs: sw.elapsedMilliseconds,
          metrics: metrics,
        ),
      );
      rethrow;
    } catch (e) {
      sw.stop();
      ApiTraceStore.instance.add(
        ApiTraceEntry(
          id: id,
          at: at,
          name: name,
          requestBody: redactedRequest,
          statusCode: null,
          stableError: e.runtimeType.toString(),
          elapsedMs: sw.elapsedMilliseconds,
          metrics: {'error': e.runtimeType.toString()},
        ),
      );
      rethrow;
    }
  }

  static Map<String, dynamic>? _asMap(dynamic data) {
    if (data == null) return null;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return null;
  }

  static String _stableCode(FunctionException e) {
    final details = e.details;
    if (details is Map && details['error'] is String) {
      return details['error'] as String;
    }
    if (details is String && details.isNotEmpty) {
      return details.length > 80 ? '${details.substring(0, 80)}…' : details;
    }
    return 'server_error';
  }
}
