import 'package:flutter_test/flutter_test.dart';
import 'package:howse_asthma/core/debug/api_metrics_extractor.dart';
import 'package:howse_asthma/core/debug/debug_redactor.dart';

void main() {
  group('DebugRedactor', () {
    test('masks secret keys recursively', () {
      final out = DebugRedactor.scrub({
        'authorization': 'Bearer secret',
        'nested': {
          'apiKey': 'abc',
          'ok': true,
        },
        'service_role': 'x',
        'privateKey': 'pk',
        'fcm_token': 'tok',
      });
      expect(out['authorization'], '***');
      expect((out['nested'] as Map)['apiKey'], '***');
      expect((out['nested'] as Map)['ok'], isTrue);
      expect(out['service_role'], '***');
      expect(out['privateKey'], '***');
      expect(out['fcm_token'], '***');
    });

    test('masks invite code and care-link ids', () {
      final out = DebugRedactor.scrub({
        'code': 'AB12CD34',
        'patient_id': '11111111-2222-3333-4444-555555555555',
        'provider_id': 'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee',
        'link_id': '99999999-8888-7777-6666-555555555555',
      });
      expect(out['code'], '***');
      expect(out['patient_id'], '***');
      expect(out['provider_id'], '***');
      expect(out['link_id'], '99999999…');
    });

    test('masks email phone and jwt values', () {
      final out = DebugRedactor.scrub({
        'note': 'ok',
        'contact': 'user@example.com',
        'tel': '+15551234567',
        'blob':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxIn0.sig',
      });
      expect(out['note'], 'ok');
      expect(out['contact'], '***');
      expect(out['tel'], '***');
      expect(out['blob'], '***');
    });

    test('truncates long strings', () {
      final long = 'a' * 5000;
      final out = DebugRedactor.scrub({'note': long});
      final note = out['note'] as String;
      expect(note.length, lessThan(long.length));
      expect(note.endsWith('…[truncated]'), isTrue);
    });

    test('rounds coordinates when enabled', () {
      final out = DebugRedactor.scrub(
        {'latitude': 40.7368123, 'longitude': -74.1723456, 'risk': 3},
        roundCoordinates: true,
        coordinateDecimals: 3,
      );
      expect(out['latitude'], 40.737);
      expect(out['longitude'], -74.172);
      expect(out['risk'], 3);
    });

    test('scrubOrNull preserves null', () {
      expect(DebugRedactor.scrubOrNull(null), isNull);
    });

    test('stripHeaders always empty', () {
      expect(
        DebugRedactor.stripHeaders({'Authorization': 'Bearer x'}),
        isEmpty,
      );
    });
  });

  group('ApiMetricsExtractor', () {
    test('extracts calculate metrics', () {
      final m = ApiMetricsExtractor.extract('calculate-environment-risk', {
        'risk_score': 3,
        'ui_state': 'WARNING',
        'aqi_epa': 112,
        'forecast_points': [{}, {}],
        'source_coverage': {
          'njdot': {'applied': true},
        },
        'from_cache': true,
      });
      expect(m['risk_score'], 3);
      expect(m['ui_state'], 'WARNING');
      expect(m['aqi_epa'], 112);
      expect(m['forecast_days'], 2);
      expect(m['njdot_applied'], isTrue);
      expect(m['from_cache'], isTrue);
    });

    test('extracts notify metrics without raw fcm error tail', () {
      final m = ApiMetricsExtractor.extract('notify-environment-risk', {
        'status': 'recorded',
        'fcm_sent': true,
        'trigger_reason': 'RISK_THRESHOLD',
        'fcm_error': 'oauth_token_failed: detail leak',
      });
      expect(m['status'], 'recorded');
      expect(m['fcm_sent'], isTrue);
      expect(m['fcm_error'], 'oauth_token_failed');
    });

    test('extracts log-inhaler metrics', () {
      final m = ApiMetricsExtractor.extract('log-inhaler-event', {
        'event': {'id': 'e1', 'is_panic': false, 'risk_level': 2},
      });
      expect(m['event.id'], 'e1');
      expect(m['is_panic'], isFalse);
    });

    test('invite metrics never expose raw code', () {
      final m = ApiMetricsExtractor.extract('issue-invite-code', {
        'code': 'AB12CD34',
        'status': 'issued',
      });
      expect(m.containsKey('code'), isFalse);
      expect(m['code_set'], isTrue);
      final scrubbed = DebugRedactor.scrub(Map<String, dynamic>.from(m));
      expect(scrubbed['code_set'], isTrue);
    });
  });
}
