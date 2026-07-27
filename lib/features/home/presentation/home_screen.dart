import 'package:flutter/material.dart';

import '../../../core/debug/debug_gates.dart';
import '../../../core/location/location_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../alerts/presentation/alert_screen.dart';
import '../../debug/presentation/api_console_screen.dart';
import '../../environment/data/environment_risk_repository.dart';
import '../../environment/data/environment_snapshot.dart';
import '../../environment/presentation/env_screen.dart';
import '../../environment/presentation/widgets/state_only_source_badge.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../../panic/presentation/panic_screen.dart';

/// SCR-PAT-HOME — binds Edge risk + location (WBS 4.1–4.2a).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _location = const LocationService();
  final _riskRepo = EnvironmentRiskRepository();
  final _inhalerRepo = InhalerEventRepository();

  bool _loading = true;
  String? _errorCode;
  EnvironmentSnapshot? _snapshot;
  DateTime? _lastInhalerAt;
  bool _alertOffered = false;
  int _debugTitleTaps = 0;
  DateTime? _debugTitleTapAt;

  void _onDebugTitleTap() {
    if (!DebugGates.enabled) return;
    final now = DateTime.now();
    if (_debugTitleTapAt == null ||
        now.difference(_debugTitleTapAt!) > const Duration(seconds: 2)) {
      _debugTitleTaps = 0;
    }
    _debugTitleTapAt = now;
    _debugTitleTaps++;
    if (_debugTitleTaps >= 5) {
      _debugTitleTaps = 0;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const ApiConsoleScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  bool _refreshing = false;

  Future<void> _refresh() async {
    if (_refreshing) return;
    _refreshing = true;
    setState(() {
      _loading = true;
      _errorCode = null;
    });

    try {
      final loc = await _location.getCurrentPosition();
      if (!mounted) return;

      if (!loc.isOk) {
        setState(() {
          _loading = false;
          _errorCode = loc.failure?.name ?? 'unavailable';
          _snapshot = null;
        });
        return;
      }

      try {
        final snap = await _riskRepo.fetchRisk(
          latitude: loc.position!.latitude,
          longitude: loc.position!.longitude,
        );
        final last = await _inhalerRepo.latestRecordedAt();
        if (!mounted) return;
        setState(() {
          _snapshot = snap;
          _lastInhalerAt = last;
          _loading = false;
        });
        await _maybeNotifyAndOfferAlert(
          snap,
          loc.position!.latitude,
          loc.position!.longitude,
        );
      } on EnvironmentRiskException catch (e) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _errorCode = e.code;
        });
      } catch (_) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _errorCode = 'server_error';
        });
      }
    } finally {
      _refreshing = false;
    }
  }

  Future<void> _maybeNotifyAndOfferAlert(
    EnvironmentSnapshot snap,
    double lat,
    double lon,
  ) async {
    if (!snap.isWarningOrAbove) {
      _alertOffered = false;
      return;
    }
    if (_alertOffered) return;
    _alertOffered = true;
    String? status;
    try {
      // Server recomputes risk from cache; client scores are not trusted.
      final result = await _riskRepo.notifyRiskThreshold(
        latitude: lat,
        longitude: lon,
      );
      status = result['status'] as String?;
    } catch (_) {
      // Cooldown / offline — do not force a duplicate alert UI.
      return;
    }
    if (!mounted) return;
    // Align with EnvironmentMonitor: only land in-app when Edge recorded.
    if (status != 'recorded') return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AlertScreen(snapshot: snap),
      ),
    );
  }

  String _riskCaption(AppLocalizations l10n, int score) {
    if (score <= 1) return l10n.asthmaRiskLow;
    if (score == 2) return l10n.asthmaRiskModerate;
    return l10n.asthmaRiskHigh;
  }

  String _axisLevel(String? level, bool flood) {
    if (flood) return 'Active';
    return level ?? '—';
  }

  String _lastInhalerLabel(AppLocalizations l10n) {
    final at = _lastInhalerAt?.toLocal();
    if (at == null) return l10n.homeLastInhalerNone;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(at.year, at.month, at.day);
    final days = today.difference(day).inDays;
    if (days <= 0) return l10n.homeLastInhalerToday;
    return l10n.homeLastInhalerDays(days);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final snap = _snapshot;
    final warning = snap?.isWarningOrAbove ?? false;
    final stateLabel = snap?.uiState ?? 'CALM';

    return Scaffold(
      backgroundColor: AppTheme.defaultBackground,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.brand600,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.air, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _onDebugTitleTap,
                          child: Text(
                            l10n.appTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.brand700,
                            ),
                          ),
                        ),
                        Text(
                          'SCR-PAT-HOME',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.neutral400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _loading ? null : _refresh,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                l10n.homeGreeting,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              Text(
                l10n.homeDailySummary,
                style: const TextStyle(color: AppTheme.subtext),
              ),
              if (warning) ...[
                const SizedBox(height: 12),
                Material(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded,
                            color: AppTheme.warning600),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            l10n.homeWarningBanner,
                            style: const TextStyle(
                              color: AppTheme.neutral800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_errorCode != null)
                _LocationErrorCard(
                  code: _errorCode!,
                  onRetry: _refresh,
                  onOpenSettings: () => _location.openAppSettings(),
                )
              else if (snap != null) ...[
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const EnvScreen()),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: warning
                          ? const Color(0xFFFFF7ED)
                          : AppTheme.brand50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: warning
                            ? const Color(0xFFFDBA74)
                            : AppTheme.brand200,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: warning
                              ? const Color(0xFFFED7AA)
                              : AppTheme.brand100,
                          child: Icon(
                            warning
                                ? Icons.warning_amber_rounded
                                : Icons.show_chart,
                            color: warning
                                ? AppTheme.warning600
                                : AppTheme.brand600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    stateLabel,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: warning
                                          ? AppTheme.warning600
                                          : AppTheme.brand700,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${l10n.mockRiskScore} ${snap.riskScore}',
                                    style: const TextStyle(
                                      color: AppTheme.subtext,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _riskCaption(l10n, snap.riskScore),
                                style: const TextStyle(
                                  color: AppTheme.neutral700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right,
                            color: AppTheme.neutral400),
                      ],
                    ),
                  ),
                ),
                if (snap.degraded) ...[
                  const SizedBox(height: 10),
                  Text(
                    l10n.homeDegradedNotice,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.warning600,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                StateOnlySourceBadge.njdot(snap, compact: true),
                const SizedBox(height: 20),
                Text(
                  l10n.homeEnvFactors,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                _FactorRow(
                  icon: Icons.local_shipping_outlined,
                  title: l10n.mockTrapAxis,
                  value: _axisLevel(snap.trapLevel, false),
                ),
                _FactorRow(
                  icon: Icons.flood_outlined,
                  title: l10n.mockFloodAxis,
                  value: snap.hasFlashFloodWarning
                      ? l10n.homeFloodActive
                      : l10n.homeFloodNone,
                ),
                _FactorRow(
                  icon: Icons.grass_outlined,
                  title: l10n.mockPollenAxis,
                  value: snap.pollenUpi != null
                      ? 'UPI ${snap.pollenUpi}'
                      : '—',
                ),
                const SizedBox(height: 16),
                Text(
                  _lastInhalerLabel(l10n),
                  style: const TextStyle(color: AppTheme.subtext, fontSize: 13),
                ),
                if (warning) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const EnvScreen(),
                              ),
                            );
                          },
                          child: Text(l10n.homeViewDetails),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.error600,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const PanicScreen(),
                              ),
                            );
                          },
                          child: Text(l10n.mockPanicCta),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FactorRow extends StatelessWidget {
  const _FactorRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppTheme.brand600),
      title: Text(title),
      trailing: Text(
        value,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _LocationErrorCard extends StatelessWidget {
  const _LocationErrorCard({
    required this.code,
    required this.onRetry,
    required this.onOpenSettings,
  });

  final String code;
  final VoidCallback onRetry;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String message;
    switch (code) {
      case 'serviceDisabled':
        message = l10n.locationServiceDisabled;
      case 'permissionDenied':
        message = l10n.locationPermissionDenied;
      case 'permissionDeniedForever':
        message = l10n.locationPermissionDeniedForever;
      case 'out_of_service_area':
        message = l10n.locationOutOfServiceArea;
      default:
        message = l10n.locationUnavailable;
    }

    return Material(
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
            Text(message),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                FilledButton(onPressed: onRetry, child: Text(l10n.authRetry)),
                if (code == 'permissionDeniedForever' ||
                    code == 'serviceDisabled')
                  OutlinedButton(
                    onPressed: onOpenSettings,
                    child: Text(l10n.locationOpenSettings),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
