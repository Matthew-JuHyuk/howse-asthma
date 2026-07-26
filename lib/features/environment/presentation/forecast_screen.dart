import 'package:flutter/material.dart';

import '../../../core/location/location_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/environment_risk_repository.dart';
import '../data/environment_snapshot.dart';
import 'widgets/state_only_source_badge.dart';

/// SCR-PAT-FORECAST — 48h / multi-day outlook (WBS 5.2–5.4).
class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key, this.initial});

  final EnvironmentSnapshot? initial;

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final _location = const LocationService();
  final _risk = EnvironmentRiskRepository();
  bool _loading = true;
  EnvironmentSnapshot? _snap;

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) {
      _snap = widget.initial;
      _loading = false;
    }
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final loc = await _location.getCurrentPosition();
    if (!mounted) return;
    if (!loc.isOk) {
      setState(() => _loading = false);
      return;
    }
    try {
      final snap = await _risk.fetchRisk(
        latitude: loc.position!.latitude,
        longitude: loc.position!.longitude,
      );
      if (!mounted) return;
      setState(() {
        _snap = snap;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final snap = _snap;
    final points = snap?.forecastPoints ?? const <ForecastDayPoint>[];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(l10n.mockForecast,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text(
              'SCR-PAT-FORECAST',
              style: TextStyle(fontSize: 11, color: AppTheme.neutral400),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: _loading ? null : _load, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            if (_loading && snap == null)
              const Padding(
                padding: EdgeInsets.all(40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (snap == null)
              Text(l10n.locationUnavailable)
            else ...[
              Text(
                l10n.forecastIntro,
                style: const TextStyle(color: AppTheme.subtext, fontSize: 13),
              ),
              const SizedBox(height: 8),
              StateOnlySourceBadge.njdot(snap),
              if (snap.hasFlashFloodWarning) ...[
                const SizedBox(height: 12),
                Material(
                  color: const Color(0xFFFEF2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFFECACA)),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.flood, color: AppTheme.error600),
                    title: Text(l10n.homeFloodActive,
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(
                      snap.floodAlertHeadline ?? l10n.envFloodDetail,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              if (points.isEmpty)
                Text(l10n.forecastEmpty,
                    style: const TextStyle(color: AppTheme.subtext))
              else
                ...points.map((d) => _dayCard(l10n, d)),
              const SizedBox(height: 12),
              Text(
                l10n.forecastPollenNote,
                style: const TextStyle(fontSize: 11, color: AppTheme.neutral400),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _dayCard(AppLocalizations l10n, ForecastDayPoint day) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppTheme.neutral0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppTheme.neutral200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      day.date,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  if (day.compositeScore != null)
                    Text(
                      '${l10n.mockRiskScore} ${day.compositeScore}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.brand700,
                      ),
                    ),
                ],
              ),
              if (day.pollenUpi != null) ...[
                const SizedBox(height: 4),
                Text(
                  l10n.forecastDayPollen(
                    day.pollenUpi!,
                    day.dominantPollenType ?? '—',
                  ),
                  style: const TextStyle(fontSize: 12, color: AppTheme.subtext),
                ),
              ],
              if (day.usAqiMax != null) ...[
                const SizedBox(height: 2),
                Text(
                  l10n.forecastDayAqi(day.usAqiMax!),
                  style: const TextStyle(fontSize: 12, color: AppTheme.subtext),
                ),
              ],
              if (day.periods.isNotEmpty) ...[
                const SizedBox(height: 10),
                ...day.periods.map((p) => _periodRow(l10n, p)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _periodRow(AppLocalizations l10n, ForecastPeriodPoint p) {
    final label = switch (p.period) {
      'afternoon' => l10n.forecastAfternoon,
      'evening' => l10n.forecastEvening,
      _ => l10n.forecastMorning,
    };
    final bits = <String>[
      if (p.usAqi != null) 'AQI ${p.usAqi}',
      if (p.pollenUpi != null) 'UPI ${p.pollenUpi}',
      if (p.trapLevel != null) 'TRAP ${p.trapLevel}',
      if (p.floodActive) l10n.homeFloodActive,
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 88,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          Expanded(
            child: Text(
              bits.isEmpty ? '—' : bits.join(' · '),
              style: const TextStyle(fontSize: 12, color: AppTheme.neutral700),
            ),
          ),
        ],
      ),
    );
  }
}
