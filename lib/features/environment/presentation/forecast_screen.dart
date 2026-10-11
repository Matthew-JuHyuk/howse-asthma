import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/environment_controller.dart';
import '../data/environment_snapshot.dart';
import 'env_labels.dart';

/// Environmental forecast (multi-day). Internal screen id: SCR-PAT-FORECAST.
class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key, this.initial});

  final EnvironmentSnapshot? initial;

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  final _env = EnvironmentController.instance;

  @override
  void initState() {
    super.initState();
    _env.addListener(_changed);
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
    final snap = _env.snapshot ?? widget.initial;
    final points = snap?.forecastPoints ?? const <ForecastDayPoint>[];

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      appBar: AppBar(
        title: Text(l10n.s5EnvForecast),
        actions: [
          IconButton(
            tooltip: l10n.s5Refresh,
            onPressed: _env.refreshing ? null : () => _env.refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _env.refresh(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          children: [
            if (snap == null)
              Text(l10n.s5EnvUnavailable, style: const TextStyle(fontSize: 16))
            else ...[
              if (snap.fetchedAt != null)
                Text(
                  l10n.s5ForecastCheckedAt(
                    EnvLabels.localDateTime(context, snap.fetchedAt!),
                  ),
                  style: const TextStyle(color: AppTheme.neutral700),
                ),
              const SizedBox(height: 16),
              if (points.isEmpty)
                Text(l10n.forecastEmpty, style: const TextStyle(fontSize: 16))
              else
                ...points.map((d) => _dayCard(context, l10n, d)),
              const SizedBox(height: 12),
              Text(
                l10n.s5EnvPollenDetail,
                style: const TextStyle(fontSize: 14, color: AppTheme.neutral700),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _dayLabel(BuildContext context, String iso) {
    final d = DateTime.tryParse(iso);
    if (d == null) return iso;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return DateFormat.yMMMEd(locale).format(d);
  }

  Widget _dayCard(
    BuildContext context,
    AppLocalizations l10n,
    ForecastDayPoint day,
  ) {
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
              Text(
                l10n.s5ForecastValidFor(_dayLabel(context, day.date)),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              if (day.usAqiMax != null) ...[
                const SizedBox(height: 6),
                Text(
                  '${l10n.s5EnvAirQuality}: ${l10n.s5AqiValue(EnvLabels.aqiCategory(l10n, day.usAqiMax!), day.usAqiMax!)}',
                ),
              ],
              if (day.pollenUpi != null) ...[
                const SizedBox(height: 4),
                Text(
                  '${l10n.s5EnvPollen}: ${l10n.s5UpiValue(day.pollenUpi!, EnvLabels.upiCategory(l10n, day.pollenUpi!))}',
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
      if (p.usAqi != null) '${l10n.s5EnvAirQuality} ${p.usAqi}',
      if (p.pollenUpi != null) '${l10n.s5EnvPollen} ${p.pollenUpi}',
      if (p.floodActive) l10n.s5FloodIssued,
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: bits.isEmpty ? '—' : bits.join(' · ')),
          ],
        ),
      ),
    );
  }
}
