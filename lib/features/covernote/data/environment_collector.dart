import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/location/location_service.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../records/data/records_revision.dart';
import '../../records/domain/record_models.dart';
import '../domain/s9_models.dart';

/// Fetches regional AQI and outdoor humidity. Never blocks a health-record
/// save. Never writes "now" onto a past local date.
class EnvironmentCollector {
  EnvironmentCollector();

  static const maxCurrentSkew = Duration(hours: 2);
  static const freshFor = Duration(hours: 1);
  String get _cacheKey =>
      'cn_env_factors_v2_${SupabaseService.currentUser?.id ?? 'signed_out'}';

  /// Last factors saved on this phone. Empty when nothing has been loaded.
  Future<List<EnvironmentReading>> loadCached() async {
    try {
      final raw = (await SharedPreferences.getInstance()).getString(_cacheKey);
      if (raw == null || raw.isEmpty) return const [];
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return [
        for (final item in decoded)
          if (item is Map) EnvironmentReading.fromJson(item),
      ].where((r) => r.metric.isNotEmpty && r.status == 'ready').toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> remember(List<EnvironmentReading> items) async {
    final ready = items.where((r) => r.status == 'ready').toList();
    if (ready.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _cacheKey,
        jsonEncode([for (final r in ready) r.toJson()]),
      );
    } catch (_) {}
  }

  bool isFresh(List<EnvironmentReading> items) {
    DateTime? latest;
    for (final r in items) {
      final at = r.fetchedAt;
      if (at == null) continue;
      if (latest == null || at.isAfter(latest)) latest = at;
    }
    if (latest == null) return false;
    return DateTime.now().toUtc().difference(latest.toUtc()) < freshFor;
  }

  Future<AreaSetting?> loadArea() async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return null;
    try {
      final row = await SupabaseService.client
          .from('profiles')
          .select('home_zip, home_city, home_lat, home_lon')
          .eq('id', uid)
          .maybeSingle();
      if (row == null) return null;
      return AreaSetting(
        zip: row['home_zip'] as String?,
        city: row['home_city'] as String?,
        lat: (row['home_lat'] as num?)?.toDouble(),
        lon: (row['home_lon'] as num?)?.toDouble(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> saveArea({
    String? zip,
    String? city,
    double? lat,
    double? lon,
  }) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return;
    await SupabaseService.client
        .from('profiles')
        .update({
          'home_zip': zip,
          'home_city': city,
          'home_lat': lat,
          'home_lon': lon,
        })
        .eq('id', uid);
    await (await SharedPreferences.getInstance()).remove(_cacheKey);
  }

  /// Resolve ZIP → lat/lon via Zippopotam (no key). City via Open-Meteo geocoding.
  Future<AreaSetting?> resolveArea({String? zip, String? city}) async {
    if (zip != null && zip.trim().isNotEmpty) {
      final z = zip.trim();
      try {
        final res = await http
            .get(Uri.parse('https://api.zippopotam.us/us/$z'))
            .timeout(const Duration(seconds: 12));
        if (res.statusCode == 200) {
          final j = jsonDecode(res.body) as Map<String, dynamic>;
          final places = j['places'] as List?;
          if (places != null && places.isNotEmpty) {
            final p = places.first as Map<String, dynamic>;
            return AreaSetting(
              zip: z,
              city: p['place name'] as String?,
              lat: double.tryParse('${p['latitude']}'),
              lon: double.tryParse('${p['longitude']}'),
            );
          }
        }
      } catch (_) {}
    }
    if (city != null && city.trim().isNotEmpty) {
      try {
        final res = await http
            .get(
              Uri.parse(
                'https://geocoding-api.open-meteo.com/v1/search'
                '?name=${Uri.encodeQueryComponent(city.trim())}'
                '&count=1&country=US',
              ),
            )
            .timeout(const Duration(seconds: 12));
        if (res.statusCode == 200) {
          final j = jsonDecode(res.body) as Map<String, dynamic>;
          final results = j['results'] as List?;
          if (results != null && results.isNotEmpty) {
            final p = results.first as Map<String, dynamic>;
            return AreaSetting(
              zip: zip,
              city: p['name'] as String?,
              lat: (p['latitude'] as num?)?.toDouble(),
              lon: (p['longitude'] as num?)?.toDouble(),
            );
          }
        }
      } catch (_) {}
    }
    return null;
  }

  /// Current location only. A denied permission is not replaced with a ZIP.
  Future<({double lat, double lon, String label, String precision})?>
  _coords() async {
    final area = await loadArea();
    if (area?.lat != null && area?.lon != null) {
      return (
        lat: area!.lat!,
        lon: area.lon!,
        label: area.city ?? area.zip ?? '',
        precision: 'selected_area',
      );
    }
    final loc = await const LocationService().getCurrentPosition(
      requestIfDenied: false,
    );
    if (loc.position == null) return null;
    return (
      lat: loc.position!.latitude,
      lon: loc.position!.longitude,
      label: '',
      precision: 'gps_coarse',
    );
  }

  /// Current regional observation. Real providers only.
  Future<List<EnvironmentReading>> fetchCurrent() async {
    final cached = await loadCached();
    if (cached.isNotEmpty && isFresh(cached)) return cached;
    final c = await _coords();
    if (c == null) return const [];
    final fromEdge = await _fromEdge(c.lat, c.lon, c.label, c.precision);
    final list = fromEdge.isNotEmpty
        ? fromEdge
        : await _fromOpenMeteoNow(c.lat, c.lon, c.label, c.precision);
    if (list.any((r) => r.status == 'ready')) await remember(list);
    return list;
  }

  /// History for a past local date. Current payload is never used.
  Future<List<EnvironmentReading>> fetchForLocalDate(DateTime localDate) async {
    final today = DateTime.now();
    final day = DateTime(localDate.year, localDate.month, localDate.day);
    final isToday =
        day.year == today.year &&
        day.month == today.month &&
        day.day == today.day;
    if (isToday) return fetchCurrent();
    if (day.isAfter(DateTime(today.year, today.month, today.day))) {
      return [const EnvironmentReading(metric: 'aqi', status: 'unavailable')];
    }
    final c = await _coords();
    if (c == null) {
      return [const EnvironmentReading(metric: 'aqi', status: 'unavailable')];
    }
    return _fromOpenMeteoHistory(c.lat, c.lon, day, c.label, c.precision);
  }

  /// Fire-and-forget attach after a record save.
  void attachToEvent({
    required String eventKind,
    required String eventId,
    required DateTime occurredAt,
    required DateTime localDate,
  }) {
    unawaited(
      _attach(
        eventKind: eventKind,
        eventId: eventId,
        occurredAt: occurredAt,
        localDate: localDate,
      ),
    );
  }

  Future<void> _attach({
    required String eventKind,
    required String eventId,
    required DateTime occurredAt,
    required DateTime localDate,
  }) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return;
    try {
      await _attachBody(
        uid: uid,
        eventKind: eventKind,
        eventId: eventId,
        occurredAt: occurredAt,
        localDate: localDate,
      ).timeout(const Duration(seconds: 40));
    } catch (_) {
      await _markUse(eventId, 'failed');
    } finally {
      RecordsRevision.instance.bump();
    }
  }

  Future<void> _attachBody({
    required String uid,
    required String eventKind,
    required String eventId,
    required DateTime occurredAt,
    required DateTime localDate,
  }) async {
    final now = DateTime.now();
    final day = DateTime(localDate.year, localDate.month, localDate.day);
    final today = DateTime(now.year, now.month, now.day);
    final List<EnvironmentReading> readings;
    if (day == today && now.difference(occurredAt).abs() <= maxCurrentSkew) {
      readings = await fetchCurrent();
    } else if (day.isBefore(today)) {
      readings = await fetchForLocalDate(day);
    } else {
      readings = [
        const EnvironmentReading(metric: 'aqi', status: 'unavailable'),
      ];
    }
    if (readings.isEmpty || readings.every((r) => r.value == null)) {
      await _markUse(eventId, 'unavailable');
      return;
    }
    for (final r in readings) {
      if (r.value == null) continue;
      final snap = await SupabaseService.client
          .from('environment_snapshots')
          .insert({
            'patient_id': uid,
            'provider': r.provider,
            'metric': r.metric,
            'value': r.value,
            'unit': r.unit,
            'observed_at': r.observedAt?.toUtc().toIso8601String(),
            'fetched_at': (r.fetchedAt ?? DateTime.now())
                .toUtc()
                .toIso8601String(),
            'location_label': r.locationLabel,
            'location_precision': r.locationPrecision,
            'source_kind': r.sourceKind ?? 'observation',
            'event_local_date': isoDate(day),
          })
          .select('id')
          .single();
      await SupabaseService.client.from('environment_event_links').insert({
        'snapshot_id': snap['id'],
        'event_kind': eventKind,
        'event_id': eventId.contains(':') ? eventId.split(':').last : eventId,
        'patient_id': uid,
      });
      await _writeLocalContext(uid, day, r);
    }
    await _markUse(eventId, 'ready');
  }

  Future<void> _writeLocalContext(
    String uid,
    DateTime day,
    EnvironmentReading r,
  ) async {
    try {
      final kind = r.metric == 'outdoor_humidity' ? 'outdoor_humidity' : 'pm25';
      await SupabaseService.client.from('local_context_entries').insert({
        'patient_id': uid,
        'local_date': isoDate(day),
        'kind': kind,
        'value_kind': r.sourceKind ?? 'observation',
        'is_synthetic': false,
        'aqi_value': r.metric == 'aqi' ? r.value?.round() : null,
        'numeric_value': r.metric == 'aqi' ? null : r.value,
        'unit': r.unit,
        'source_name': r.provider,
        'place_label': r.locationLabel,
        'observed_at': r.observedAt?.toUtc().toIso8601String(),
        'fetched_at': DateTime.now().toUtc().toIso8601String(),
      });
    } catch (_) {}
  }

  Future<void> _markUse(String eventId, String status) async {
    if (eventId.contains(':')) return;
    try {
      await SupabaseService.client
          .from('medication_use_events')
          .update({'env_status': status})
          .eq('id', eventId);
    } catch (_) {}
  }

  Future<List<EnvironmentReading>> _fromEdge(
    double lat,
    double lon,
    String label,
    String precision,
  ) async {
    try {
      final res = await SupabaseService.client.functions.invoke(
        'calculate-environment-risk',
        body: {'latitude': lat, 'longitude': lon},
      );
      final d = res.data;
      if (d is! Map) return const [];
      final fetched = DateTime.now().toUtc();
      final out = <EnvironmentReading>[];
      final aqi =
          (d['aqi'] as num?)?.toDouble() ?? (d['us_aqi'] as num?)?.toDouble();
      final aqiSource =
          d['aqi_source'] as String? ??
          d['source'] as String? ??
          'calculate-environment-risk';
      if (aqi != null) {
        out.add(
          EnvironmentReading(
            metric: 'aqi',
            value: aqi,
            unit: 'AQI',
            provider: aqiSource,
            fetchedAt: fetched,
            locationLabel: label.isEmpty ? null : label,
            locationPrecision: precision,
            sourceKind: 'observation',
          ),
        );
      }
      final rh =
          (d['mold_rh_pct'] as num?)?.toDouble() ??
          (d['outdoor_humidity'] as num?)?.toDouble() ??
          (d['humidity'] as num?)?.toDouble();
      if (rh != null) {
        out.add(
          EnvironmentReading(
            metric: 'outdoor_humidity',
            value: rh,
            unit: '%',
            provider: 'Open-Meteo',
            fetchedAt: fetched,
            locationLabel: label.isEmpty ? null : label,
            locationPrecision: precision,
            sourceKind: 'observation',
          ),
        );
      }
      final trap = d['trap_level'];
      if (trap is String && trap.trim().isNotEmpty) {
        out.add(
          EnvironmentReading(
            metric: 'trap',
            detail: trap.trim(),
            provider: aqiSource,
            fetchedAt: fetched,
            locationLabel: label.isEmpty ? null : label,
            locationPrecision: precision,
            sourceKind: 'observation',
          ),
        );
      }
      final pollen = (d['pollen_upi'] as num?)?.toDouble();
      if (pollen != null) {
        final kind = d['dominant_pollen_type'];
        out.add(
          EnvironmentReading(
            metric: 'pollen',
            value: pollen,
            unit: 'UPI',
            detail: kind is String && kind.trim().isNotEmpty
                ? kind.trim()
                : null,
            provider: 'Google Pollen',
            fetchedAt: fetched,
            locationLabel: label.isEmpty ? null : label,
            locationPrecision: precision,
            sourceKind: 'forecast',
          ),
        );
      }
      if (d['has_flash_flood_warning'] is bool) {
        final headline = d['flood_alert_headline'];
        out.add(
          EnvironmentReading(
            metric: 'flood',
            value: d['has_flash_flood_warning'] == true ? 1 : 0,
            detail: headline is String && headline.trim().isNotEmpty
                ? headline.trim()
                : null,
            provider: 'NWS',
            fetchedAt: fetched,
            locationLabel: label.isEmpty ? null : label,
            locationPrecision: precision,
            sourceKind: 'observation',
          ),
        );
      }
      return out;
    } catch (_) {
      return const [];
    }
  }

  Future<List<EnvironmentReading>> _fromOpenMeteoNow(
    double lat,
    double lon,
    String label,
    String precision,
  ) async {
    try {
      final aq = await http
          .get(
            Uri.parse(
              'https://air-quality-api.open-meteo.com/v1/air-quality'
              '?latitude=$lat&longitude=$lon'
              '&current=us_aqi&timezone=auto',
            ),
          )
          .timeout(const Duration(seconds: 15));
      final wx = await http
          .get(
            Uri.parse(
              'https://api.open-meteo.com/v1/forecast'
              '?latitude=$lat&longitude=$lon'
              '&current=relative_humidity_2m&timezone=auto',
            ),
          )
          .timeout(const Duration(seconds: 15));
      final out = <EnvironmentReading>[];
      final fetched = DateTime.now().toUtc();
      if (aq.statusCode == 200) {
        final j = jsonDecode(aq.body) as Map<String, dynamic>;
        final cur = j['current'] as Map<String, dynamic>?;
        final aqi = (cur?['us_aqi'] as num?)?.toDouble();
        if (aqi != null) {
          out.add(
            EnvironmentReading(
              metric: 'aqi',
              value: aqi,
              unit: 'AQI',
              provider: 'Open-Meteo',
              observedAt: DateTime.tryParse(cur?['time'] as String? ?? ''),
              fetchedAt: fetched,
              locationLabel: label.isEmpty ? null : label,
              locationPrecision: precision,
              sourceKind: 'observation',
            ),
          );
        }
      }
      if (wx.statusCode == 200) {
        final j = jsonDecode(wx.body) as Map<String, dynamic>;
        final cur = j['current'] as Map<String, dynamic>?;
        final rh = (cur?['relative_humidity_2m'] as num?)?.toDouble();
        if (rh != null) {
          out.add(
            EnvironmentReading(
              metric: 'outdoor_humidity',
              value: rh,
              unit: '%',
              provider: 'Open-Meteo',
              observedAt: DateTime.tryParse(cur?['time'] as String? ?? ''),
              fetchedAt: fetched,
              locationLabel: label.isEmpty ? null : label,
              locationPrecision: precision,
              sourceKind: 'observation',
            ),
          );
        }
      }
      return out;
    } catch (_) {
      return const [];
    }
  }

  Future<List<EnvironmentReading>> _fromOpenMeteoHistory(
    double lat,
    double lon,
    DateTime day,
    String label,
    String precision,
  ) async {
    final ds = isoDate(day);
    try {
      final aq = await http
          .get(
            Uri.parse(
              'https://air-quality-api.open-meteo.com/v1/air-quality'
              '?latitude=$lat&longitude=$lon'
              '&start_date=$ds&end_date=$ds'
              '&hourly=us_aqi&timezone=auto',
            ),
          )
          .timeout(const Duration(seconds: 15));
      final wx = await http
          .get(
            Uri.parse(
              'https://archive-api.open-meteo.com/v1/archive'
              '?latitude=$lat&longitude=$lon'
              '&start_date=$ds&end_date=$ds'
              '&hourly=relative_humidity_2m&timezone=auto',
            ),
          )
          .timeout(const Duration(seconds: 15));
      final out = <EnvironmentReading>[];
      final fetched = DateTime.now().toUtc();
      if (aq.statusCode == 200) {
        final aqi = _midday(jsonDecode(aq.body), 'us_aqi');
        if (aqi != null) {
          out.add(
            EnvironmentReading(
              metric: 'aqi',
              value: aqi.$1,
              unit: 'AQI',
              provider: 'Open-Meteo',
              observedAt: aqi.$2,
              fetchedAt: fetched,
              locationLabel: label.isEmpty ? null : label,
              locationPrecision: precision,
              sourceKind: 'observation',
            ),
          );
        }
      }
      if (wx.statusCode == 200) {
        final rh = _midday(jsonDecode(wx.body), 'relative_humidity_2m');
        if (rh != null) {
          out.add(
            EnvironmentReading(
              metric: 'outdoor_humidity',
              value: rh.$1,
              unit: '%',
              provider: 'Open-Meteo',
              observedAt: rh.$2,
              fetchedAt: fetched,
              locationLabel: label.isEmpty ? null : label,
              locationPrecision: precision,
              sourceKind: 'observation',
            ),
          );
        }
      }
      if (out.isEmpty) {
        return [const EnvironmentReading(metric: 'aqi', status: 'unavailable')];
      }
      return out;
    } catch (_) {
      return [const EnvironmentReading(metric: 'aqi', status: 'unavailable')];
    }
  }

  (double, DateTime?)? _midday(Object decoded, String key) {
    if (decoded is! Map) return null;
    final hourly = decoded['hourly'];
    if (hourly is! Map) return null;
    final times = hourly['time'];
    final values = hourly[key];
    if (times is! List || values is! List || times.isEmpty) return null;
    final idx = times.length > 12 ? 12 : times.length ~/ 2;
    final v = values[idx];
    if (v is! num) return null;
    return (v.toDouble(), DateTime.tryParse('${times[idx]}'));
  }

  Future<List<EnvironmentReading>> listRecent({int days = 7}) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return const [];
    try {
      final from = DateTime.now().subtract(Duration(days: days));
      final rows = await SupabaseService.client
          .from('environment_snapshots')
          .select()
          .eq('patient_id', uid)
          .gte('event_local_date', isoDate(from))
          .order('fetched_at', ascending: false)
          .limit(40);
      return [
        for (final r in rows as List)
          EnvironmentReading(
            metric: r['metric'] as String,
            value: (r['value'] as num?)?.toDouble(),
            unit: r['unit'] as String?,
            provider: r['provider'] as String?,
            observedAt: r['observed_at'] is String
                ? DateTime.tryParse(r['observed_at'] as String)
                : null,
            fetchedAt: r['fetched_at'] is String
                ? DateTime.tryParse(r['fetched_at'] as String)
                : null,
            locationLabel: r['location_label'] as String?,
            locationPrecision: r['location_precision'] as String?,
            sourceKind: r['source_kind'] as String?,
          ),
      ];
    } catch (_) {
      return const [];
    }
  }
}

class AreaSetting {
  const AreaSetting({this.zip, this.city, this.lat, this.lon});

  final String? zip;
  final String? city;
  final double? lat;
  final double? lon;

  bool get hasCoords => lat != null && lon != null;
}
