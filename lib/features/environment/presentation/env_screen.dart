import 'package:flutter/material.dart';

import '../../../core/debug/debug_gates.dart';
import '../../../core/location/location_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../locations/presentation/locations_screen.dart';
import '../data/environment_controller.dart';
import '../data/environment_snapshot.dart';
import 'env_labels.dart';
import 'forecast_screen.dart';

/// Today's local environment. Internal screen id: SCR-PAT-ENV.
///
/// Shows provider categories only; the internal composite score is never
/// presented as asthma risk (developer builds can see it under sources).
class EnvScreen extends StatefulWidget {
  const EnvScreen({super.key, this.embedded = false});

  /// True inside the bottom-tab shell (shell provides the app bar).
  final bool embedded;

  @override
  State<EnvScreen> createState() => _EnvScreenState();
}

class _EnvScreenState extends State<EnvScreen> {
  final _env = EnvironmentController.instance;

  @override
  void initState() {
    super.initState();
    _env.addListener(_changed);
    WidgetsBinding.instance.addPostFrameCallback((_) => _env.ensureLoaded());
  }

  @override
  void dispose() {
    _env.removeListener(_changed);
    super.dispose();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final body = RefreshIndicator(
      onRefresh: () => _env.refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: _content(context, l10n),
      ),
    );
    if (widget.embedded) return body;
    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(title: Text(l10n.s5EnvCardTitle)),
      body: body,
    );
  }

  List<Widget> _content(BuildContext context, AppLocalizations l10n) {
    final snap = _env.snapshot;
    final older =
        _env.showingOlder ||
        (snap?.fromStaleCache ?? false) ||
        _env.status == EnvLoadStatus.failed;

    final header = <Widget>[
      Row(
        children: [
          Expanded(
            child: Text(
              l10n.s5EnvCardTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
          ),
          if (_env.refreshing)
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          IconButton(
            tooltip: l10n.s5Refresh,
            onPressed: _env.status == EnvLoadStatus.loading
                ? null
                : () => _env.refresh(userInitiated: true),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      if (snap?.locationLabel != null)
        Text(
          l10n.homeNearPlace(snap!.locationLabel!),
          style: const TextStyle(fontSize: 16, color: AppTheme.neutral700),
        ),
      if (snap?.fetchedAt != null)
        Text(
          l10n.s5UpdatedAt(EnvLabels.localDateTime(context, snap!.fetchedAt!)),
          style: const TextStyle(color: AppTheme.neutral700),
        ),
    ];

    if (snap == null) {
      return [
        ...header,
        const SizedBox(height: 16),
        switch (_env.status) {
          EnvLoadStatus.idle || EnvLoadStatus.loading => const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          ),
          EnvLoadStatus.noLocation => _NoLocation(controller: _env),
          _ => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.s5EnvUnavailable, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => _env.refresh(userInitiated: true),
                child: Text(l10n.s5Reload),
              ),
            ],
          ),
        },
      ];
    }

    return [
      ...header,
      if (older) ...[
        const SizedBox(height: 8),
        Text(
          _env.status == EnvLoadStatus.failed
              ? l10n.s5EnvLoadFailed
              : l10n.s5EnvOlderNotice,
          style: const TextStyle(color: AppTheme.warning600),
        ),
      ],
      if (_env.status == EnvLoadStatus.noLocation) ...[
        const SizedBox(height: 8),
        _NoLocation(controller: _env),
      ],
      const SizedBox(height: 16),
      _EnvItemCard(
        icon: Icons.air,
        title: l10n.s5EnvAirQuality,
        value: EnvLabels.airQualityValue(l10n, snap),
        status: EnvLabels.status(snap.aqiEpa != null, older: older),
        detail: l10n.s5EnvAirDetail,
      ),
      _EnvItemCard(
        icon: Icons.grass_outlined,
        title: l10n.s5EnvPollen,
        value: EnvLabels.pollenValue(l10n, snap),
        status: EnvLabels.status(snap.pollenUpi != null, older: older),
        detail: l10n.s5EnvPollenDetail,
        extra: [
          if (snap.dominantPollenType != null)
            l10n.s5PollenMainType(_pollenType(l10n, snap.dominantPollenType!)),
          if (EnvLabels.localDateTimeIso(context, snap.pollenFetchedAt) != null)
            l10n.s5UpdatedAt(
              EnvLabels.localDateTimeIso(context, snap.pollenFetchedAt)!,
            ),
        ],
      ),
      _EnvItemCard(
        icon: Icons.water_drop_outlined,
        title: l10n.s5EnvHumidity,
        value: EnvLabels.humidityValue(l10n, snap),
        status: EnvLabels.status(snap.moldRhPct != null, older: older),
        detail: l10n.s5EnvHumidityDetail,
        extra: [
          if (snap.moldTempC != null)
            l10n.homeMoldTempF((snap.moldTempC! * 9 / 5 + 32).round().toString()),
          if (snap.moldDewPointC != null)
            l10n.homeMoldDewF(
              (snap.moldDewPointC! * 9 / 5 + 32).round().toString(),
            ),
        ],
      ),
      _EnvItemCard(
        icon: Icons.flood_outlined,
        title: l10n.s5EnvFlood,
        value: EnvLabels.floodValue(l10n, snap),
        status: EnvLabels.status(
          snap.hasFlashFloodWarning || snap.sourceOk('nws'),
          older: older,
        ),
        detail: l10n.s5EnvFloodDetail,
        extra: [
          if (snap.hasFlashFloodWarning && snap.floodAlertHeadline != null)
            snap.floodAlertHeadline!,
        ],
      ),
      if (snap.forecastPoints.isNotEmpty)
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.calendar_month, color: AppTheme.brand600),
          title: Text(l10n.s5EnvForecast),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ForecastScreen(initial: snap)),
          ),
        ),
      const SizedBox(height: 8),
      _SourcesAndLimits(snapshot: snap),
    ];
  }

  String _pollenType(AppLocalizations l10n, String raw) =>
      switch (raw.toUpperCase()) {
        'GRASS' => l10n.s5PollenGrass,
        'TREE' => l10n.s5PollenTree,
        'WEED' => l10n.s5PollenWeed,
        _ => raw,
      };
}

class _EnvItemCard extends StatelessWidget {
  const _EnvItemCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.status,
    required this.detail,
    this.extra = const [],
  });

  final IconData icon;
  final String title;
  final String value;
  final EnvItemStatus status;
  final String detail;
  final List<String> extra;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final statusColor = switch (status) {
      EnvItemStatus.latest => AppTheme.brand700,
      EnvItemStatus.older => AppTheme.warning600,
      EnvItemStatus.unavailable => AppTheme.neutral700,
    };
    final statusIcon = switch (status) {
      EnvItemStatus.latest => Icons.check_circle_outline,
      EnvItemStatus.older => Icons.history,
      EnvItemStatus.unavailable => Icons.help_outline,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppTheme.neutral0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppTheme.neutral200),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: AppTheme.brand600),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(statusIcon, size: 18, color: statusColor),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      EnvLabels.statusLabel(l10n, status),
                      style: TextStyle(color: statusColor),
                    ),
                  ),
                ],
              ),
              for (final e in extra) ...[
                const SizedBox(height: 4),
                Text(e, style: const TextStyle(color: AppTheme.neutral700)),
              ],
              const SizedBox(height: 8),
              Text(
                detail,
                style: const TextStyle(fontSize: 14, color: AppTheme.neutral700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoLocation extends StatelessWidget {
  const _NoLocation({required this.controller});
  final EnvironmentController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final code = controller.errorCode;
    final blocked =
        code == 'permissionDeniedForever' || code == 'serviceDisabled';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.s5EnvNeedPlace, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LocationsScreen()),
                );
                await controller.refresh();
              },
              child: Text(l10n.s5ChoosePlace),
            ),
            TextButton(
              onPressed: blocked
                  ? () => const LocationService().openAppSettings()
                  : () => controller.refresh(userInitiated: true),
              child: Text(
                blocked
                    ? l10n.locationOpenSettings
                    : l10n.mockUseCurrentLocation,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SourcesAndLimits extends StatelessWidget {
  const _SourcesAndLimits({required this.snapshot});
  final EnvironmentSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final s = snapshot;
    String st(List<String> sources) => sources.any(s.sourceOk)
        ? l10n.s5StatusLatest
        : l10n.s5StatusUnavailable;
    final lines = <String>[
      '${l10n.s5SourcesAir} — ${st(['airnow', 'openmeteo', 'purpleair'])}',
      '${l10n.s5SourcesPollen} — ${st(['google_pollen'])}',
      '${l10n.s5SourcesWeather} — ${st(['openmeteo_weather'])}',
      '${l10n.s5SourcesFlood} — ${st(['nws'])}',
      if (s.nearestPurpleAirKm != null)
        l10n.homeSensorNearestOnly(
          s.nearestPurpleAirKm!.toStringAsFixed(1),
          (s.nearestPurpleAirKm! * 0.621371).toStringAsFixed(1),
        ),
      if (s.showNjOnlyFreightNotice) l10n.s5SourcesNjTraffic,
      l10n.s5SourcesNoRiskScore,
      if (DebugGates.enabled)
        'debug: ui_state=${s.uiState} score=${s.riskScore} '
            '${s.dataSourceSummary ?? const {}}',
    ];
    return Material(
      color: AppTheme.neutral0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.neutral200),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        title: Text(l10n.s5SourcesTitle),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(line, style: const TextStyle(fontSize: 14)),
            ),
        ],
      ),
    );
  }
}
