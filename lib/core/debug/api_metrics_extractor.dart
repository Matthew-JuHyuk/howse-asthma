/// Pulls UI chip metrics from Edge Function response bodies.
class ApiMetricsExtractor {
  ApiMetricsExtractor._();

  static Map<String, dynamic> extract(
    String functionName,
    Map<String, dynamic>? body,
  ) {
    if (body == null) return const {};
    if (functionName.contains('calculate-environment-risk')) {
      return _calculate(body);
    }
    if (functionName.contains('notify-environment-risk')) {
      return _notify(body);
    }
    if (functionName.contains('log-inhaler-event')) {
      return _logInhaler(body);
    }
    if (functionName.contains('invite') ||
        functionName.contains('care-link')) {
      return _invite(body);
    }
    return _generic(body);
  }

  static Map<String, dynamic> _calculate(Map<String, dynamic> body) {
    final metrics = <String, dynamic>{};
    _put(metrics, 'risk_score', body['risk_score']);
    _put(metrics, 'ui_state', body['ui_state']);
    _put(metrics, 'aqi_epa', body['aqi_epa']);
    _put(metrics, 'aqi_source', body['aqi_source']);
    _put(metrics, 'pm25', body['pm25'] ?? body['local_pm25']);
    _put(metrics, 'trap_level', body['trap_level']);
    _put(metrics, 'pollen_upi', body['pollen_upi']);
    _put(metrics, 'usgs_stream_rate_ft_hr', body['usgs_stream_rate_ft_hr']);
    _put(metrics, 'from_cache', body['from_cache']);
    _put(metrics, 'degraded', body['degraded']);

    final forecast = body['forecast_points'];
    if (forecast is List) {
      metrics['forecast_days'] = forecast.length;
    }

    final coverage = body['source_coverage'];
    if (coverage is Map) {
      final njdot = coverage['njdot'];
      if (njdot is Map && njdot['applied'] != null) {
        metrics['njdot_applied'] = njdot['applied'];
      }
    }

    final summary = body['data_source_summary'];
    if (summary is Map) {
      final ok = <String>[];
      final bad = <String>[];
      for (final e in summary.entries) {
        final v = e.value;
        final isOk = v == true ||
            v == 'ok' ||
            (v is Map && (v['ok'] == true || v['status'] == 'ok'));
        if (isOk) {
          ok.add(e.key.toString());
        } else if (v != null) {
          bad.add(e.key.toString());
        }
      }
      if (ok.isNotEmpty || bad.isNotEmpty) {
        metrics['sources_ok'] =
            'ok=${ok.join(",")}${bad.isEmpty ? "" : " fail=${bad.join(",")}"}';
      }
    } else if (summary is String && summary.isNotEmpty) {
      metrics['sources_ok'] = summary;
    }

    return metrics;
  }

  static Map<String, dynamic> _notify(Map<String, dynamic> body) {
    final metrics = <String, dynamic>{};
    _put(metrics, 'status', body['status']);
    _put(metrics, 'risk_score', body['risk_score']);
    _put(metrics, 'trigger_reason', body['trigger_reason']);
    _put(metrics, 'cooldown_minutes', body['cooldown_minutes']);
    _put(metrics, 'fcm_sent', body['fcm_sent']);
    // Stable enum only — never raw upstream error text on chips.
    final fcmErr = body['fcm_error'];
    if (fcmErr is String && fcmErr.isNotEmpty) {
      metrics['fcm_error'] = fcmErr.contains(':')
          ? fcmErr.split(':').first
          : fcmErr;
    }
    return metrics;
  }

  static Map<String, dynamic> _logInhaler(Map<String, dynamic> body) {
    final metrics = <String, dynamic>{};
    final event = body['event'];
    if (event is Map) {
      // Full event UUID is scrubbed by DebugRedactor after extract.
      _put(metrics, 'event.id', event['id']);
      _put(metrics, 'is_panic', event['is_panic']);
      _put(metrics, 'risk_level', event['risk_level']);
      _put(metrics, 'ui_state', event['ui_state']);
    } else {
      _put(metrics, 'event.id', body['id']);
      _put(metrics, 'is_panic', body['is_panic']);
      _put(metrics, 'risk_level', body['risk_level']);
    }
    if (body['error'] is String) {
      metrics['error'] = body['error'];
    }
    return metrics;
  }

  static Map<String, dynamic> _invite(Map<String, dynamic> body) {
    final metrics = <String, dynamic>{};
    // Never put raw invite codes on chips (screenshot / shoulder-surf risk).
    if (body['code'] is String && (body['code'] as String).isNotEmpty) {
      metrics['code_set'] = true;
    }
    _put(metrics, 'status', body['status']);
    _put(metrics, 'link_id', body['link_id'] ?? body['id']);
    _put(metrics, 'expires_at', body['expires_at']);
    if (body['error'] is String) {
      metrics['error'] = body['error'];
    }
    return metrics;
  }

  static Map<String, dynamic> _generic(Map<String, dynamic> body) {
    final metrics = <String, dynamic>{};
    if (body['error'] is String) metrics['error'] = body['error'];
    if (body['status'] != null) metrics['status'] = body['status'];
    return metrics;
  }

  static void _put(Map<String, dynamic> m, String key, Object? value) {
    if (value != null) m[key] = value;
  }
}
