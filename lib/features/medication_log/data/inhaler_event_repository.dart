import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/debug/debug_functions_client.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../records/domain/record_models.dart';

const _listColumns =
    'id, recorded_at, is_panic, input_means, risk_level, ui_state, '
    'latitude, longitude, pollen_upi_snapshot, flash_flood_alert_active, '
    'medication_label, medication_status, puff_count, use_reason, note, '
    'source_language, tz_offset_minutes, updated_at';

/// Inhaler events — writes go through Edge `log-inhaler-event` so
/// environmental snapshot fields are server-authored only.
class InhalerEventRepository {
  InhalerEventRepository();

  Future<Map<String, dynamic>> logUse({
    required double? latitude,
    required double? longitude,
    bool isPanic = false,
    String inputMeans = 'tap',
    String? clientRequestId,
    String? medicationLabel,
    String? medicationStatus,
    int? puffCount,
    String? useReason,
    String? note,
    String? sourceLanguage,
    DateTime? recordedAt,
  }) {
    return _invoke({
      'action': 'create',
      'latitude': ?latitude,
      'longitude': ?longitude,
      'is_panic': isPanic,
      'input_means': isPanic ? 'panic' : inputMeans,
      'client_request_id': ?clientRequestId,
      'medication_label': ?medicationLabel,
      'medication_status': ?medicationStatus,
      'puff_count': ?puffCount,
      'use_reason': ?useReason,
      'note': ?note,
      'source_language': ?sourceLanguage,
      'tz_offset_minutes': DateTime.now().timeZoneOffset.inMinutes,
      if (recordedAt != null)
        'recorded_at': recordedAt.toUtc().toIso8601String(),
    });
  }

  /// Patient-reported details only; null clears a field.
  Future<Map<String, dynamic>> updateDetails({
    required String id,
    required String? medicationLabel,
    required String? medicationStatus,
    required int? puffCount,
    required String? useReason,
    required String? note,
    String? sourceLanguage,
    DateTime? recordedAt,
  }) {
    return _invoke({
      'action': 'update',
      'id': id,
      'medication_label': medicationLabel,
      'medication_status': medicationStatus,
      'puff_count': puffCount,
      'use_reason': useReason,
      'note': note,
      'source_language': ?sourceLanguage,
      if (recordedAt != null)
        'recorded_at': recordedAt.toUtc().toIso8601String(),
    });
  }

  /// Soft delete (undo / delete). Hidden from every list and summary.
  Future<void> voidEvent(String id) async {
    await _invoke({'action': 'void', 'id': id});
  }

  Future<Map<String, dynamic>> _invoke(Map<String, dynamic> body) async {
    try {
      final response = await DebugFunctionsClient.invoke(
        'log-inhaler-event',
        body: body,
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
        .select(_listColumns)
        .eq('patient_id', userId)
        .isFilter('voided_at', null)
        .gte('recorded_at', since)
        .order('recorded_at', ascending: false)
        .limit(500);

    return List<Map<String, dynamic>>.from(rows as List);
  }

  /// Live records whose local date may fall in [start]..[end] (callers filter).
  Future<List<InhalerRecord>> listBetween(DateTime start, DateTime end) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];
    final from = start.subtract(const Duration(days: 1)).toUtc();
    final to = end.add(const Duration(days: 2)).toUtc();
    final rows = await SupabaseService.client
        .from('inhaler_events')
        .select(_listColumns)
        .eq('patient_id', userId)
        .isFilter('voided_at', null)
        .gte('recorded_at', from.toIso8601String())
        .lt('recorded_at', to.toIso8601String())
        .order('recorded_at', ascending: false)
        .limit(1000);
    return (rows as List)
        .map((r) => InhalerRecord.fromRow(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  Future<DateTime?> latestRecordedAt() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return null;
    final row = await SupabaseService.client
        .from('inhaler_events')
        .select('recorded_at')
        .eq('patient_id', userId)
        .isFilter('voided_at', null)
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
