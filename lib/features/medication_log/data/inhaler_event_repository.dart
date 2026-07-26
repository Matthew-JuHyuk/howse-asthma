import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase/supabase_service.dart';

/// Inhaler events — writes go through Edge `log-inhaler-event` so
/// environmental snapshot fields are server-authored only.
class InhalerEventRepository {
  InhalerEventRepository();

  Future<Map<String, dynamic>> logUse({
    required double? latitude,
    required double? longitude,
    bool isPanic = false,
    String inputMeans = 'tap',
  }) async {
    try {
      final response = await SupabaseService.client.functions.invoke(
        'log-inhaler-event',
        body: {
          'latitude': ?latitude,
          'longitude': ?longitude,
          'is_panic': isPanic,
          'input_means': isPanic ? 'panic' : inputMeans,
        },
      );
      final data = response.data;
      if (data is Map && data['event'] is Map) {
        return Map<String, dynamic>.from(data['event'] as Map);
      }
      if (data is Map && data['error'] is String) {
        throw InhalerEventException(data['error'] as String);
      }
      throw InhalerEventException('unexpected_response');
    } on FunctionException catch (e) {
      final details = e.details;
      if (details is Map && details['error'] is String) {
        throw InhalerEventException(details['error'] as String);
      }
      throw InhalerEventException('server_error');
    }
  }

  Future<List<Map<String, dynamic>>> listRecent({int days = 30}) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];

    final since = DateTime.now()
        .toUtc()
        .subtract(Duration(days: days))
        .toIso8601String();

    final rows = await SupabaseService.client
        .from('inhaler_events')
        .select(
          'id, recorded_at, is_panic, input_means, risk_level, ui_state, '
          'latitude, longitude, pollen_upi_snapshot, flash_flood_alert_active',
        )
        .eq('patient_id', userId)
        .gte('recorded_at', since)
        .order('recorded_at', ascending: false)
        .limit(200);

    return List<Map<String, dynamic>>.from(rows as List);
  }

  Future<DateTime?> latestRecordedAt() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return null;
    final row = await SupabaseService.client
        .from('inhaler_events')
        .select('recorded_at')
        .eq('patient_id', userId)
        .order('recorded_at', ascending: false)
        .limit(1)
        .maybeSingle();
    if (row == null) return null;
    final raw = row['recorded_at'] as String?;
    return raw == null ? null : DateTime.tryParse(raw);
  }
}

class InhalerEventException implements Exception {
  InhalerEventException(this.code);
  final String code;

  @override
  String toString() => 'InhalerEventException($code)';
}
