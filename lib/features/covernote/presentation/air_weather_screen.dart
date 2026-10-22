import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/locale/app_languages.dart';
import '../../../core/location/location_service.dart';
import '../../../l10n/app_localizations.dart';
import '../data/environment_collector.dart';
import '../domain/s9_models.dart';
import '../ui/app_chrome.dart';
import '../ui/brand.dart';

/// Compact entry to the automatic air and weather screen.
class AirWeatherLink extends StatelessWidget {
  const AirWeatherLink({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return CnCard(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AirWeatherScreen()),
      ),
      child: Row(
        children: [
          const Icon(Icons.air, color: CnColors.teal),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.cnAirWeather,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: CnColors.navy,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.cnAirAutoNote,
                  style: const TextStyle(fontSize: 13, color: CnColors.muted),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: CnColors.muted),
        ],
      ),
    );
  }
}

class AirWeatherScreen extends StatefulWidget {
  const AirWeatherScreen({super.key});

  @override
  State<AirWeatherScreen> createState() => _AirWeatherScreenState();
}

class _AirWeatherScreenState extends State<AirWeatherScreen> {
  List<EnvironmentReading> _now = const [];
  List<EnvironmentReading> _hist = const [];
  LocationFailure? _location;
  String? _error;
  var _loading = true;
  final _env = EnvironmentCollector();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cached = await _env.loadCached();
    if (!mounted) return;
    final fresh = cached.isNotEmpty && _env.isFresh(cached);
    setState(() {
      if (cached.isNotEmpty) _now = cached;
      _loading = !fresh && cached.isEmpty;
      _error = null;
      _location = null;
    });
    if (fresh) {
      final hist = await _env.listRecent();
      if (mounted) setState(() => _hist = hist);
      return;
    }
    if (cached.isNotEmpty && mounted) {
      setState(() => _loading = true);
    }
    final here = await const LocationService().getCurrentPosition(
      requestIfDenied: true,
    );
    if (!mounted) return;
    if (here.position == null) {
      setState(() {
        _loading = false;
        if (_now.isEmpty) {
          _location = here.failure ?? LocationFailure.unavailable;
        }
      });
      return;
    }
    try {
      final now = await _env.fetchCurrent();
      final hist = await _env.listRecent();
      if (!mounted) return;
      setState(() {
        if (now.isNotEmpty) _now = now;
        _hist = hist;
        _loading = false;
        if (_now.isEmpty) _error = 'fetch_error';
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
          if (_now.isEmpty) _error = 'fetch_error';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CoverNoteAppBar(title: Text(l.cnAirWeather)),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            CnCard(
              child: Text(
                l.cnAirAutoNote,
                style: const TextStyle(fontSize: 15, height: 1.35),
              ),
            ),
            const SizedBox(height: 12),
            if (_location != null)
              ActionMessage(
                icon: Icons.location_off_outlined,
                title: switch (_location!) {
                  LocationFailure.serviceDisabled => l.cnLocationOff,
                  LocationFailure.permissionDeniedForever => l.cnLocationBlocked,
                  _ => l.cnLocationNeed,
                },
                actionLabel: _location == LocationFailure.permissionDeniedForever
                    ? l.cnOpenSettings
                    : l.cnAirRetry,
                onAction: _location == LocationFailure.permissionDeniedForever
                    ? () => const LocationService().openAppSettings()
                    : _load,
              ),
            if (_loading) const LinearProgressIndicator(),
            if (_error != null)
              ActionMessage(
                icon: Icons.cloud_off,
                title: l.cnAirNone,
                actionLabel: l.cnAirRetry,
                onAction: _load,
              ),
            for (final r in _now) _line(context, l, r, current: true),
            if (_now.isEmpty && !_loading && _error == null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(l.cnAirNone),
              ),
            SectionLabel(l.cnLast30),
            for (final r in _hist.take(12))
              _line(context, l, r, current: false),
          ],
        ),
      ),
    );
  }

  Widget _line(
    BuildContext context,
    AppLocalizations l,
    EnvironmentReading r, {
    required bool current,
  }) {
    final (title, value, note) = switch (r.metric) {
      'aqi' => (
        l.s5EnvAirQuality,
        r.value == null ? l.cnEnvUnavailable : _aqiLine(l, r.value!),
        l.s5EnvAirDetail,
      ),
      'trap' => (
        l.cnEnvTrap,
        _trapLine(l, r.detail),
        l.envTrapDetail,
      ),
      'pollen' => (
        l.s5EnvPollen,
        r.value == null
            ? l.cnEnvUnavailable
            : 'UPI ${r.value!.round()}${r.detail == null ? '' : ' · ${r.detail}'}',
        l.envPollenDetail,
      ),
      'flood' => (
        l.s5EnvFlood,
        r.value == 1
            ? (r.detail == null || r.detail!.isEmpty
                  ? l.s5FloodIssued
                  : '${l.s5FloodIssued} · ${r.detail}')
            : l.s5FloodNone,
        l.envFloodDetail,
      ),
      'outdoor_humidity' => (
        l.cnCtxOutdoorHumidity,
        r.value == null ? l.cnEnvUnavailable : '${r.value!.round()}%',
        l.cnCtxHumidityNote,
      ),
      _ => (r.metric, r.value?.round().toString() ?? l.cnEnvUnavailable, ''),
    };
    final when = (r.fetchedAt ?? r.observedAt)?.toLocal();
    final stamp = when == null
        ? null
        : DateFormat.MMMd(
            intlLocaleFor(Localizations.localeOf(context)),
          ).add_jm().format(when);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: CnCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 13, color: CnColors.muted),
            ),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            if (current && note.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(note, style: const TextStyle(fontSize: 13, height: 1.35)),
            ],
            if (stamp != null) ...[
              const SizedBox(height: 4),
              Text(
                l.envUpdatedAt(stamp),
                style: const TextStyle(fontSize: 13, color: CnColors.muted),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

String _aqiLine(AppLocalizations l, double aqi) {
  final n = aqi.round();
  final category = switch (n) {
    <= 50 => l.s5AqiGood,
    <= 100 => l.s5AqiModerate,
    <= 150 => l.s5AqiUsg,
    <= 200 => l.s5AqiUnhealthy,
    <= 300 => l.s5AqiVeryUnhealthy,
    _ => l.s5AqiHazardous,
  };
  return l.s5AqiValue(category, n);
}

String _trapLine(AppLocalizations l, String? level) => switch (level?.toUpperCase()) {
  'LOW' => l.s5AqiGood,
  'MODERATE' => l.s5AqiModerate,
  'HIGH' => l.s5AqiUnhealthy,
  'CRITICAL' => l.s5AqiVeryUnhealthy,
  null || '' => l.cnEnvUnavailable,
  _ => level!,
};
