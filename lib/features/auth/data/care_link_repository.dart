import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/debug/debug_functions_client.dart';
import '../../../core/supabase/supabase_service.dart';

/// Patient–provider invite pairing via Edge Functions.
class CareLinkRepository {
  CareLinkRepository();

  Future<Map<String, dynamic>> issueInviteCode() async {
    try {
      final response = await DebugFunctionsClient.invoke(
        'issue-invite-code',
        body: const <String, dynamic>{},
      );
      return _asMap(response.data);
    } on FunctionException catch (e) {
      throw CareLinkException(_stableCode(e));
    }
  }

  Future<Map<String, dynamic>> redeemInviteCode(String code) async {
    try {
      final response = await DebugFunctionsClient.invoke(
        'redeem-invite-code',
        body: {'code': code.trim().toUpperCase()},
      );
      return _asMap(response.data);
    } on FunctionException catch (e) {
      throw CareLinkException(_stableCode(e));
    }
  }

  Future<Map<String, dynamic>> confirmCareLink({
    required String linkId,
    required bool accept,
  }) async {
    try {
      final response = await DebugFunctionsClient.invoke(
        'confirm-care-link',
        body: {
          'link_id': linkId,
          'action': accept ? 'confirm' : 'reject',
        },
      );
      return _asMap(response.data);
    } on FunctionException catch (e) {
      throw CareLinkException(_stableCode(e));
    }
  }

  Future<List<Map<String, dynamic>>> listMyCareLinks() async {
    final rows = await SupabaseService.client
        .from('patient_care_links')
        .select(
          'id, patient_id, provider_id, status, patient_confirmed_at, '
          'provider_confirmed_at, activated_at, created_at',
        )
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(rows as List);
  }

  Future<List<Map<String, dynamic>>> listMyInviteCodes() async {
    final rows = await SupabaseService.client
        .from('invite_codes')
        .select('id, code, expires_at, consumed_at, created_at')
        .order('created_at', ascending: false)
        .limit(20);
    return List<Map<String, dynamic>>.from(rows as List);
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    throw StateError('Unexpected Edge Function response');
  }

  String _stableCode(FunctionException e) {
    final details = e.details;
    if (details is Map && details['error'] is String) {
      return details['error'] as String;
    }
    return 'server_error';
  }
}

/// Stable, non-leaky pairing error code from Edge Functions.
class CareLinkException implements Exception {
  CareLinkException(this.code);
  final String code;

  @override
  String toString() => 'CareLinkException($code)';
}
