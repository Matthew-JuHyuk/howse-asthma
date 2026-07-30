import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/debug/debug_gates.dart';
import '../../../core/environment/environment_snapshot_cache.dart';
import '../../../core/location/location_service.dart';
import '../../../core/location/place_label_resolver.dart';
import '../../../core/onboarding/first_check_in_prefs.dart';
import '../../../core/push/fcm_service.dart';
import '../../../core/push/notification_consent_prefs.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../alerts/presentation/alert_screen.dart';
import '../../debug/presentation/api_console_screen.dart';
import '../../environment/data/environment_risk_repository.dart';
import '../../environment/data/environment_snapshot.dart';
import '../../environment/presentation/env_screen.dart';
import '../../environment/presentation/forecast_screen.dart';
import '../../environment/presentation/widgets/state_only_source_badge.dart';
import '../../medication_log/data/inhaler_event_repository.dart';
import '../../medication_log/presentation/widgets/adherence_week_strip.dart';
import '../../panic/presentation/panic_screen.dart';
import '../../settings/data/notification_prefs_repository.dart';

/// SCR-PAT-HOME — binds Edge risk + location (WBS 4.1–4.2a / Sprint 3).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _location = const LocationService();
  final _riskRepo = EnvironmentRiskRepository();
  final _inhalerRepo = InhalerEventRepository();
  final _placeLabels = PlaceLabelResolver();

  bool _loading = true;
  bool _quietRefresh = false;
  String? _errorCode;
  String? _softNotice;
  EnvironmentSnapshot? _snapshot;
  DateTime? _lastInhalerAt;
  List<Map<String, dynamic>> _recentEvents = const [];
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _hydrateCache();
      await _maybePromptShieldLocation();
      if (mounted) await _maybePromptNotificationConsent();
      if (mounted) await _refresh();
    });
  }

  Future<void> _hydrateCache() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return;
    final cached = await EnvironmentSnapshotCache.read(userId);
    if (cached != null && mounted) {
      setState(() {
        _snapshot = cached;
        _loading = false;
        _softNotice = null;
      });
    }
  }

  /// S2-PERM — once-per-user shield copy, then When-In-Use only.
  Future<void> _maybePromptShieldLocation() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null || !mounted) return;
    if (await FirstCheckInPrefs.wasShieldLocationPrompted(userId)) return;

    final perm = await _location.checkPermission();
    if (perm == LocationPermission.whileInUse ||
        perm == LocationPermission.always ||
        perm == LocationPermission.deniedForever) {
      await FirstCheckInPrefs.setShieldLocationPrompted(userId, true);
      return;
    }

    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final allow = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.shieldLocationTitle),
        content: Text(l10n.shieldLocationBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.shieldLocationNotNow),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.shieldLocationAllow),
          ),
        ],
      ),
    );

    await FirstCheckInPrefs.setShieldLocationPrompted(userId, true);
    if (allow == true) {
      await _location.requestPermission();
    }
  }

  /// W3-3.3 — explain before OS notification permission.
  Future<void> _maybePromptNotificationConsent() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return;
    if (!mounted) return;
    if (await NotificationConsentPrefs.wasConsentPrompted(userId)) return;

    if (!mounted) return;
    final l10n = AppLocalizations.of(context)!;
    final allow = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            24 + MediaQuery.paddingOf(ctx).bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.pushConsentTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(l10n.pushConsentBody),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.pushConsentAllow),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.pushConsentNotNow),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted) return;
    await NotificationConsentPrefs.setConsentPrompted(userId, true);
    if (allow == true) {
      await NotificationConsentPrefs.setMasterEnabled(userId, true);
      await NotificationConsentPrefs.setPositiveEnabled(userId, true);
      try {
        await NotificationPrefsRepository().update(
          pushPositiveVentilation: true,
        );
      } catch (_) {}
      await FcmService.instance.registerCurrentDevice();
    } else {
      await NotificationConsentPrefs.setMasterEnabled(userId, false);
    }
  }

  bool _refreshing = false;

  Future<void> _refresh() async {
    if (_refreshing) return;
    _refreshing = true;
    final hadSnap = _snapshot != null;
    setState(() {
      if (!hadSnap) {
        _loading = true;
      } else {
        _quietRefresh = true;
      }
      _errorCode = null;
      _softNotice = null;
    });

    try {
      final loc = await _location.getCurrentPosition();
      if (!mounted) return;

      if (!loc.isOk) {
        setState(() {
          _loading = false;
          _quietRefresh = false;
          if (hadSnap) {
            _softNotice = 'location';
          } else {
            _errorCode = loc.failure?.name ?? 'unavailable';
            _snapshot = null;
          }
        });
        return;
      }

      final lat = loc.position!.latitude;
      final lon = loc.position!.longitude;
      final label = await _placeLabels.resolve(latitude: lat, longitude: lon);

      try {
        final snap = await _riskRepo.fetchRisk(
          latitude: lat,
          longitude: lon,
        );
        final enriched = snap.copyWith(locationLabel: label);
        final last = await _inhalerRepo.latestRecordedAt();
        final events = await _inhalerRepo.listRecent(days: 14);
        final userId = SupabaseService.currentUser?.id;
        if (userId != null) {
          await EnvironmentSnapshotCache.write(userId, enriched);
        }
        if (!mounted) return;
        setState(() {
          _snapshot = enriched;
          _lastInhalerAt = last;
          _recentEvents = events;
          _loading = false;
          _quietRefresh = false;
        });
        await _maybeNotifyAndOfferAlert(enriched, lat, lon);
        await _maybeOfferVentilationTip(enriched, lat, lon);
      } on EnvironmentRiskException catch (e) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _quietRefresh = false;
          if (hadSnap) {
            _softNotice = 'refresh';
          } else {
            _errorCode = e.code;
          }
        });
      } catch (_) {
        if (!mounted) return;
        setState(() {
          _loading = false;
          _quietRefresh = false;
          if (hadSnap) {
            _softNotice = 'refresh';
          } else {
            _errorCode = 'server_error';
          }
        });
      }
    } finally {
      _refreshing = false;
    }
  }

  Future<void> _maybeOfferVentilationTip(
    EnvironmentSnapshot snap,
    double lat,
    double lon,
  ) async {
    if (!_canSuggestVentilation(snap)) return;
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return;
    if (!await NotificationConsentPrefs.isMasterEnabled(userId)) return;
    if (!await NotificationConsentPrefs.isPositiveEnabled(userId)) return;
    if (!await NotificationConsentPrefs.canSendPositive(userId)) return;

    try {
      final result = await _riskRepo.notifyRiskThreshold(
        latitude: lat,
        longitude: lon,
        triggerReason: 'VENTILATION_WINDOW',
      );
      final status = result['status'] as String?;
      if (status == 'recorded') {
        await NotificationConsentPrefs.markPositiveSent(userId);
      }
      if (!mounted) return;
      if (status == 'recorded') {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.homeVentilationSnack)),
        );
      }
    } catch (_) {
      // Offline / Edge unavailable — Home CTA already covers the tip.
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
      final result = await _riskRepo.notifyRiskThreshold(
        latitude: lat,
        longitude: lon,
      );
      status = result['status'] as String?;
    } catch (_) {
      return;
    }
    if (!mounted) return;
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

  /// Draft “now do this” rules (Q-S3-04 / wbs3-decisions) — plain actions.
  ({String title, String body}) _nowDoThis(
    AppLocalizations l10n,
    EnvironmentSnapshot snap,
  ) {
    if (snap.hasFlashFloodWarning) {
      return (title: l10n.homeNowDoThisFloodTitle, body: l10n.homeNowDoThisFloodBody);
    }
    final trap = snap.trapLevel;
    if (trap == 'HIGH' || trap == 'CRITICAL') {
      return (title: l10n.homeNowDoThisTrapTitle, body: l10n.homeNowDoThisTrapBody);
    }
    if ((snap.pollenUpi ?? 0) >= 3) {
      return (
        title: l10n.homeNowDoThisPollenTitle,
        body: l10n.homeNowDoThisPollenBody,
      );
    }
    if ((snap.moldScore ?? 0) >= 3) {
      return (
        title: l10n.homeNowDoThisMoldTitle,
        body: l10n.homeNowDoThisMoldBody,
      );
    }
    if (snap.riskScore >= 3) {
      return (
        title: l10n.homeNowDoThisRiskTitle,
        body: l10n.homeNowDoThisRiskBody,
      );
    }
    if (_canSuggestVentilation(snap)) {
      return (
        title: l10n.homeNowDoThisCalmTitle,
        body: l10n.homeNowDoThisCalmBody,
      );
    }
    return (
      title: l10n.homeNowDoThisCalmTitle,
      body: l10n.homeNowDoThisCalmBody,
    );
  }

  /// Q-S3-04 draft: no flood, AQI≤50 (or missing+TRAP≤LOW), pollen≤2, mold≤2.
  bool _canSuggestVentilation(EnvironmentSnapshot snap) {
    if (snap.hasFlashFloodWarning) return false;
    if ((snap.moldScore ?? 0) > 2) return false;
    if ((snap.pollenUpi ?? 0) > 2) return false;
    final trap = snap.trapLevel;
    if (trap == 'HIGH' || trap == 'CRITICAL') return false;
    final aqi = snap.aqiEpa;
    if (aqi != null && aqi > 50) return false;
    if (aqi == null && trap != null && trap != 'LOW' && trap != 'MODERATE') {
      return false;
    }
    return true;
  }

  String _moldAxisValue(AppLocalizations l10n, EnvironmentSnapshot snap) {
    final level = snap.moldLevel;
    if (level != null && level.isNotEmpty) return level;
    if (snap.moldScore != null) return '${snap.moldScore}';
    return l10n.homeMoldPendingDraft;
  }

  String? _moldFactorsLine(AppLocalizations l10n, EnvironmentSnapshot snap) {
    final parts = <String>[];
    if (snap.moldRhPct != null) {
      parts.add(l10n.homeMoldRh(snap.moldRhPct!.round().toString()));
    }
    if (snap.moldTempC != null) {
      final f = snap.moldTempC! * 9 / 5 + 32;
      parts.add(l10n.homeMoldTempF(f.round().toString()));
    }
    if (snap.moldDewPointC != null) {
      final f = snap.moldDewPointC! * 9 / 5 + 32;
      parts.add(l10n.homeMoldDewF(f.round().toString()));
    }
    if (snap.moldHWetHours != null) {
      parts.add(l10n.homeMoldWetHours(snap.moldHWetHours!));
    }
    if (parts.isEmpty) return null;
    return parts.join(' · ');
  }

  String? _sensorDistanceLine(AppLocalizations l10n, EnvironmentSnapshot snap) {
    final nearest = snap.nearestPurpleAirKm;
    final radius = snap.purpleAirSearchRadiusKm;
    if (nearest == null && radius == null) return null;
    final miNearest =
        nearest == null ? null : (nearest * 0.621371).toStringAsFixed(1);
    final miRadius =
        radius == null ? null : (radius * 0.621371).toStringAsFixed(1);
    if (nearest != null && radius != null) {
      return l10n.homeSensorDistance(
        nearest.toStringAsFixed(1),
        miNearest!,
        radius.toStringAsFixed(1),
        miRadius!,
      );
    }
    if (nearest != null) {
      return l10n.homeSensorNearestOnly(
        nearest.toStringAsFixed(1),
        miNearest!,
      );
    }
    return l10n.homeSensorRadiusOnly(
      radius!.toStringAsFixed(1),
      miRadius!,
    );
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
                          snap?.locationLabel != null
                              ? l10n.homeNearPlace(snap!.locationLabel!)
                              : 'SCR-PAT-HOME',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.neutral400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_quietRefresh)
                    const Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: (_loading && snap == null) ? null : _refresh,
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
              if (_softNotice != null) ...[
                const SizedBox(height: 10),
                Text(
                  _softNotice == 'location'
                      ? l10n.homeStaleLocationNotice
                      : l10n.homeStaleRefreshNotice,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.warning600,
                  ),
                ),
              ],
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
              if (_loading && snap == null)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (_errorCode != null && snap == null)
                _LocationErrorCard(
                  code: _errorCode!,
                  onRetry: _refresh,
                  onOpenSettings: () => _location.openAppSettings(),
                )
              else if (snap != null) ...[
                Builder(
                  builder: (context) {
                    final action = _nowDoThis(l10n, snap);
                    return Material(
                      color: AppTheme.brand50,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    l10n.homeNowDoThisHeading,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Text(
                                  l10n.homeDraftBadge,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.neutral400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              action.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.brand700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              action.body,
                              style: const TextStyle(
                                color: AppTheme.neutral700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),
                Text(
                  l10n.homeAdherenceSection,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                AdherenceWeekStrip(events: _recentEvents),
                Text(
                  _lastInhalerLabel(l10n),
                  style: const TextStyle(color: AppTheme.subtext, fontSize: 13),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.homeEnvFactors,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EnvScreen(initial: snap),
                      ),
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
                          : AppTheme.neutral0,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: warning
                            ? const Color(0xFFFDBA74)
                            : AppTheme.neutral200,
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
                              if (_sensorDistanceLine(l10n, snap) != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  _sensorDistanceLine(l10n, snap)!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.neutral400,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right,
                            color: AppTheme.neutral400),
                      ],
                    ),
                  ),
                ),
                if (snap.degraded || snap.fromStaleCache) ...[
                  const SizedBox(height: 10),
                  Text(
                    snap.fromStaleCache
                        ? l10n.homeStaleCacheNotice
                        : l10n.homeDegradedNotice,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.warning600,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                StateOnlySourceBadge.njdot(snap, compact: true),
                const SizedBox(height: 8),
                _FactorRow(
                  icon: Icons.local_shipping_outlined,
                  title: l10n.mockTrapAxis,
                  value: _axisLevel(snap.trapLevel, false),
                ),
                _FactorRow(
                  icon: Icons.spa_outlined,
                  title: l10n.homeMoldAxis,
                  value: _moldAxisValue(l10n, snap),
                  subtitle: _moldFactorsLine(l10n, snap),
                ),
                _FactorRow(
                  icon: Icons.flood_outlined,
                  title: l10n.homeFloodAsMoldFactor,
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
                if (snap.forecastPoints.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_view_day_outlined,
                        color: AppTheme.brand600),
                    title: Text(l10n.homeForecastLink),
                    subtitle: Text(
                      l10n.homeForecastHint(
                        snap.forecastPoints.first.date,
                        '${snap.forecastPoints.first.compositeScore ?? '—'}',
                      ),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ForecastScreen(initial: snap),
                        ),
                      );
                    },
                  ),
                ],
                if (warning) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EnvScreen(initial: snap),
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
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppTheme.brand600),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(fontSize: 11, color: AppTheme.neutral400),
            )
          : null,
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
