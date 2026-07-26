import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../features/alerts/presentation/alert_screen.dart';
import '../../features/environment/data/environment_risk_repository.dart';
import '../../features/locations/data/saved_location_repository.dart';
import 'location_service.dart';

/// Foreground monitor for PAT-09 / PAT-10 (WBS 5.5–5.6).
/// Significant move → risk refresh + LOCATION_ENTRY notify when risk ≥ 3.
/// Saved places polled every [savedPollInterval] while the app is open.
/// FCM delivery still requires 4.6a — this records alerts + optional in-app.
class EnvironmentMonitor {
  EnvironmentMonitor({
    LocationService? location,
    EnvironmentRiskRepository? riskRepo,
    SavedLocationRepository? savedRepo,
    this.significantMoveMeters = 500,
    this.savedPollInterval = const Duration(minutes: 20),
    this.maxMonitoredSavedLocations = 8,
  })  : _location = location ?? const LocationService(),
        _risk = riskRepo ?? EnvironmentRiskRepository(),
        _saved = savedRepo ?? SavedLocationRepository();

  final LocationService _location;
  final EnvironmentRiskRepository _risk;
  final SavedLocationRepository _saved;
  final double significantMoveMeters;
  final Duration savedPollInterval;
  final int maxMonitoredSavedLocations;

  StreamSubscription<Position>? _posSub;
  Timer? _savedTimer;
  Position? _lastSignificant;
  bool _evaluating = false;
  bool _savedPollPending = false;
  int _epoch = 0;
  GlobalKey<NavigatorState>? _navKey;

  void attachNavigator(GlobalKey<NavigatorState> key) {
    _navKey = key;
  }

  /// Safe outside [build] (post-frame / dispose). Does not register a dependency.
  static EnvironmentMonitor? maybeOf(BuildContext context) {
    return context
        .getInheritedWidgetOfExactType<EnvironmentMonitorScope>()
        ?.monitor;
  }

  /// Prefer [maybeOf] outside build; this registers an InheritedWidget dependency.
  static EnvironmentMonitor? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<EnvironmentMonitorScope>()
        ?.monitor;
  }

  Future<void> start() async {
    final epoch = ++_epoch;
    await stop(bumpEpoch: false);
    if (epoch != _epoch) return;

    final seed = await _location.getCurrentPosition();
    if (epoch != _epoch) return;
    if (seed.isOk) {
      _lastSignificant = seed.position;
    }

    final permission = await _location.checkPermission();
    if (epoch != _epoch) return;
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    _posSub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 100,
      ),
    ).listen(_onPosition);

    _savedTimer = Timer.periodic(savedPollInterval, (_) => _pollSaved());
    unawaited(_pollSaved());
  }

  Future<void> stop({bool bumpEpoch = true}) async {
    if (bumpEpoch) _epoch++;
    await _posSub?.cancel();
    _posSub = null;
    _savedTimer?.cancel();
    _savedTimer = null;
    _evaluating = false;
    _savedPollPending = false;
  }

  Future<void> _onPosition(Position pos) async {
    if (_evaluating) return;
    final prev = _lastSignificant;
    if (prev != null) {
      final meters = Geolocator.distanceBetween(
        prev.latitude,
        prev.longitude,
        pos.latitude,
        pos.longitude,
      );
      if (meters < significantMoveMeters) return;
    }

    final advanced = await _evaluate(
      latitude: pos.latitude,
      longitude: pos.longitude,
      triggerReason: 'LOCATION_ENTRY',
    );
    if (advanced) {
      _lastSignificant = pos;
    }
  }

  Future<void> _pollSaved() async {
    if (_evaluating) {
      _savedPollPending = true;
      return;
    }
    _savedPollPending = false;
    try {
      final places = await _saved.list();
      final monitored = places
          .where((e) => e.monitoringEnabled)
          .take(maxMonitoredSavedLocations)
          .toList();
      for (final p in monitored) {
        await _evaluate(
          latitude: p.latitude,
          longitude: p.longitude,
          triggerReason: 'SAVED_LOCATION_CHANGE',
        );
      }
    } catch (_) {
      // Offline — ignore.
    } finally {
      if (_savedPollPending && !_evaluating) {
        _savedPollPending = false;
        unawaited(_pollSaved());
      }
    }
  }

  /// Returns true when risk was checked (success path), so callers may advance
  /// geofence anchors. Returns false on lock contention / abort.
  Future<bool> _evaluate({
    required double latitude,
    required double longitude,
    required String triggerReason,
  }) async {
    if (_evaluating) return false;
    final epoch = _epoch;
    _evaluating = true;
    try {
      final snap = await _risk.fetchRisk(
        latitude: latitude,
        longitude: longitude,
      );
      if (epoch != _epoch) return false;
      if (!snap.isWarningOrAbove) return true;

      final result = await _risk.notifyRiskThreshold(
        latitude: latitude,
        longitude: longitude,
        triggerReason: triggerReason,
      );
      if (epoch != _epoch) return false;
      final status = result['status'] as String?;
      if (status != 'recorded') return true;

      final nav = _navKey?.currentState;
      if (nav == null || !nav.mounted) return true;
      // Do not await the route under the evaluate lock (would freeze polling).
      unawaited(
        nav.push(
          MaterialPageRoute(builder: (_) => AlertScreen(snapshot: snap)),
        ),
      );
      return true;
    } catch (_) {
      return false;
    } finally {
      _evaluating = false;
      if (_savedPollPending) {
        unawaited(_pollSaved());
      }
    }
  }
}

class EnvironmentMonitorScope extends InheritedWidget {
  const EnvironmentMonitorScope({
    super.key,
    required this.monitor,
    required super.child,
  });

  final EnvironmentMonitor monitor;

  @override
  bool updateShouldNotify(EnvironmentMonitorScope oldWidget) =>
      monitor != oldWidget.monitor;
}
