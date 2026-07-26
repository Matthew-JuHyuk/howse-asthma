import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/supabase/supabase_service.dart';
import 'environment_snapshot.dart';

class EnvironmentRiskException implements Exception {
  EnvironmentRiskException(this.code);
  final String code;

  @override
  String toString() => 'EnvironmentRiskException($code)';
}

/// Invokes Edge `calculate-environment-risk` with lat/lon only (no patient_id).
class EnvironmentRiskRepository {
  EnvironmentRiskRepository();

  Future<EnvironmentSnapshot> fetchRisk({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await SupabaseService.client.functions.invoke(
        'calculate-environment-risk',
        body: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );
      final map = _asMap(response.data);
      if (map['error'] is String) {
        throw EnvironmentRiskException(map['error'] as String);
      }
      return EnvironmentSnapshot.fromJson(map);
    } on FunctionException catch (e) {
      throw EnvironmentRiskException(_stableCode(e));
    }
  }

  /// Records a risk-threshold alert attempt (cooldown + history).
  /// FCM delivery requires Firebase (WBS 4.6a); this still writes
  /// `environment_alerts_sent` when the Edge accepts the call.
  Future<Map<String, dynamic>> notifyRiskThreshold({
    required double latitude,
    required double longitude,
    String triggerReason = 'RISK_THRESHOLD',
  }) async {
    try {
      final response = await SupabaseService.client.functions.invoke(
        'notify-environment-risk',
        body: {
          'latitude': latitude,
          'longitude': longitude,
          'trigger_reason': triggerReason,
        },
      );
      return _asMap(response.data);
    } on FunctionException catch (e) {
      throw EnvironmentRiskException(_stableCode(e));
    }
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw EnvironmentRiskException('unexpected_response');
  }

  String _stableCode(FunctionException e) {
    final details = e.details;
    if (details is Map && details['error'] is String) {
      return details['error'] as String;
    }
    return 'server_error';
  }
}
