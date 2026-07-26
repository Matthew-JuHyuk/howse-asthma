import 'package:flutter/material.dart';

import '../../../core/location/location_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/environment_risk_repository.dart';
import '../data/environment_snapshot.dart';
import 'forecast_screen.dart';
import 'widgets/state_only_source_badge.dart';

/// SCR-PAT-ENV — live environment detail (WBS 5.1 / 5.1a / 5.3 / 5.4 / 5.9).
class EnvScreen extends StatefulWidget {
  const EnvScreen({super.key, this.initial});

  final EnvironmentSnapshot? initial;

  @override
  State<EnvScreen> createState() => _EnvScreenState();
}

class _EnvScreenState extends State<EnvScreen> {
  final _location = const LocationService();
  final _risk = EnvironmentRiskRepository();
  bool _loading = true;
  String? _error;
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
    setState(() {
      _loading = true;
      _error = null;
    });
    final loc = await _location.getCurrentPosition();
    if (!mounted) return;
    if (!loc.isOk) {
      setState(() {
        _loading = false;
        _error = loc.failure?.name ?? 'unavailable';
      });
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
      setState(() {
        _loading = false;
        _error = 'server_error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final snap = _snap;

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Column(
          children: [
            Text(l10n.envTitle,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const Text(
              'SCR-PAT-ENV',
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
            else if (_error != null && snap == null)
              Text(l10n.locationUnavailable)
            else if (snap != null) ...[
              _banner(l10n, snap),
              if (snap.degraded) ...[
                const SizedBox(height: 8),
                Text(l10n.homeDegradedNotice,
                    style: const TextStyle(fontSize: 12, color: AppTheme.warning600)),
              ],
              const SizedBox(height: 12),
              StateOnlySourceBadge.njdot(snap),
              const SizedBox(height: 20),
              Text(l10n.envThreeAxis,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              _axis(
                icon: Icons.apartment_outlined,
                title: l10n.mockTrapAxis,
                level: snap.trapLevel ?? '—',
                detail: l10n.envTrapDetail,
                tip: l10n.envTrapTip,
                filled: _trapFill(snap.trapLevel),
                meta: [
                  if (snap.aqiEpa != null)
                    'AQI ${snap.aqiEpa} (${snap.aqiSource ?? '—'})',
                  if (snap.localPm25 != null)
                    'Local PM2.5 ${snap.localPm25!.toStringAsFixed(1)}',
                ].join(' · '),
              ),
              const SizedBox(height: 10),
              _axis(
                icon: Icons.flood_outlined,
                title: l10n.mockFloodAxis,
                level: snap.hasFlashFloodWarning
                    ? l10n.homeFloodActive
                    : l10n.homeFloodNone,
                detail: l10n.envFloodDetail,
                tip: snap.floodAlertHeadline ?? l10n.envFloodTipClear,
                filled: snap.hasFlashFloodWarning ? 4 : 1,
                accent: snap.hasFlashFloodWarning ? AppTheme.error600 : null,
                meta: snap.usgsStreamRateFtHr != null
                    ? l10n.envUsgsRate(snap.usgsStreamRateFtHr!.toStringAsFixed(2))
                    : null,
              ),
              const SizedBox(height: 10),
              _axis(
                icon: Icons.grass_outlined,
                title: l10n.mockPollenAxis,
                level: snap.pollenUpi != null ? 'UPI ${snap.pollenUpi}' : '—',
                detail: snap.dominantPollenType ?? l10n.envPollenDetail,
                tip: l10n.envPollenTip,
                filled: (snap.pollenUpi ?? 0).clamp(1, 5),
                accent: (snap.pollenUpi ?? 0) >= 3 ? AppTheme.warning600 : null,
                meta: snap.pollenFetchedAt != null
                    ? l10n.envUpdatedAt(snap.pollenFetchedAt!)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.envSourcesLabel,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                _sourcesLine(snap),
                style: const TextStyle(fontSize: 12, color: AppTheme.subtext),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ForecastScreen(initial: snap),
                    ),
                  );
                },
                icon: const Icon(Icons.trending_up),
                label: Text(l10n.mockForecast),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _sourcesLine(EnvironmentSnapshot snap) {
    final s = snap.dataSourceSummary;
    if (s == null || s.isEmpty) return '—';
    return s.entries.map((e) => '${e.key}:${e.value}').join(' · ');
  }

  int _trapFill(String? level) {
    switch (level) {
      case 'CRITICAL':
        return 5;
      case 'HIGH':
        return 4;
      case 'MODERATE':
        return 3;
      case 'LOW':
        return 1;
      default:
        return 1;
    }
  }

  Widget _banner(AppLocalizations l10n, EnvironmentSnapshot snap) {
    final warning = snap.isWarningOrAbove;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: warning ? const Color(0xFFFFF7ED) : AppTheme.brand50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: warning ? const Color(0xFFFDBA74) : AppTheme.brand200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${snap.uiState} · ${l10n.mockRiskScore} ${snap.riskScore}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: warning ? AppTheme.warning600 : AppTheme.brand700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            warning ? l10n.homeWarningBanner : l10n.envOverallCalm,
            style: const TextStyle(color: AppTheme.neutral700, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _axis({
    required IconData icon,
    required String title,
    required String level,
    required String detail,
    required String tip,
    required int filled,
    Color? accent,
    String? meta,
  }) {
    final color = accent ?? AppTheme.brand600;
    return Material(
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
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
                Text(level,
                    style: TextStyle(fontWeight: FontWeight.w700, color: color)),
              ],
            ),
            const SizedBox(height: 6),
            Text(detail, style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (i) {
                return Expanded(
                  child: Container(
                    height: 6,
                    margin: EdgeInsets.only(right: i < 4 ? 4 : 0),
                    decoration: BoxDecoration(
                      color: i < filled ? color : AppTheme.neutral200,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(tip, style: const TextStyle(fontSize: 12, color: AppTheme.neutral600)),
            if (meta != null && meta.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(meta, style: const TextStyle(fontSize: 11, color: AppTheme.neutral400)),
            ],
          ],
        ),
      ),
    );
  }
}
