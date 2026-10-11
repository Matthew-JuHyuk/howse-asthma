import 'package:flutter/foundation.dart';

import '../../../core/environment/environment_snapshot_cache.dart';
import '../../../core/location/location_service.dart';
import '../../../core/location/place_label_resolver.dart';
import '../../../core/push/notification_consent_prefs.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../locations/data/saved_location_repository.dart';
import 'environment_risk_repository.dart';
import 'environment_snapshot.dart';

enum EnvLoadStatus { idle, loading, ready, noLocation, failed }

/// One environment state for Home and the Environment tab.
///
/// Never shows the OS location prompt on its own: automatic refreshes use the
/// current permission or the patient's primary saved place.
class EnvironmentController extends ChangeNotifier {
  EnvironmentController._();

  static final instance = EnvironmentController._();

  final _location = const LocationService();
  final _risk = EnvironmentRiskRepository();
  final _labels = PlaceLabelResolver();
  final _saved = SavedLocationRepository();

  EnvLoadStatus status = EnvLoadStatus.idle;
  EnvironmentSnapshot? snapshot;

  /// Location failure name or Edge error code for the last attempt.
  String? errorCode;

  /// True while a refresh runs with a snapshot already on screen.
  bool refreshing = false;

  /// Last refresh failed but an older snapshot is still shown.
  bool showingOlder = false;

  bool _hydrated = false;
  bool _warningSent = false;
  String? _userId;

  Future<void> ensureLoaded() async {
    final uid = SupabaseService.currentUser?.id;
    if (uid != _userId) {
      _userId = uid;
      _hydrated = false;
      snapshot = null;
      status = EnvLoadStatus.idle;
    }
    if (!_hydrated) {
      _hydrated = true;
      if (uid != null) {
        final cached = await EnvironmentSnapshotCache.read(uid);
        if (cached != null && snapshot == null) {
          snapshot = cached;
          showingOlder = true;
          notifyListeners();
        }
      }
    }
    if (status == EnvLoadStatus.idle) await refresh();
  }

  /// [userInitiated] allows the OS permission prompt (user tapped a button).
  Future<void> refresh({bool userInitiated = false}) async {
    if (status == EnvLoadStatus.loading || refreshing) return;
    final had = snapshot != null;
    if (had) {
      refreshing = true;
    } else {
      status = EnvLoadStatus.loading;
    }
    errorCode = null;
    notifyListeners();

    try {
      double? lat;
      double? lon;
      final loc = await _location.getCurrentPosition(
        requestIfDenied: userInitiated,
      );
      if (loc.isOk) {
        lat = loc.position!.latitude;
        lon = loc.position!.longitude;
      } else {
        final place = await _primaryPlace();
        if (place != null) {
          lat = place.latitude;
          lon = place.longitude;
        } else {
          errorCode = loc.failure?.name ?? 'unavailable';
          status = EnvLoadStatus.noLocation;
          showingOlder = had;
          return;
        }
      }

      final label = await _labels.resolve(latitude: lat, longitude: lon);
      final snap = await _risk.fetchRisk(latitude: lat, longitude: lon);
      final enriched = snap.copyWith(
        locationLabel: label,
        fetchedAt: DateTime.now().toUtc(),
      );
      final uid = SupabaseService.currentUser?.id;
      if (uid != null) await EnvironmentSnapshotCache.write(uid, enriched);
      snapshot = enriched;
      showingOlder = false;
      status = EnvLoadStatus.ready;
      await _quietServerNotify(enriched, lat, lon);
    } on EnvironmentRiskException catch (e) {
      errorCode = e.code;
      status = EnvLoadStatus.failed;
      showingOlder = had;
    } catch (_) {
      errorCode = 'server_error';
      status = EnvLoadStatus.failed;
      showingOlder = had;
    } finally {
      refreshing = false;
      notifyListeners();
    }
  }

  Future<SavedLocation?> _primaryPlace() async {
    try {
      final list = await _saved.list();
      if (list.isEmpty) return null;
      return list.firstWhere((l) => l.isPrimary, orElse: () => list.first);
    } catch (_) {
      return null;
    }
  }

  /// Existing server-side alert path (cooldown enforced by the Edge function).
  /// No full-screen alert and no new thresholds are added here.
  Future<void> _quietServerNotify(
    EnvironmentSnapshot snap,
    double lat,
    double lon,
  ) async {
    final uid = SupabaseService.currentUser?.id;
    if (uid == null) return;
    try {
      if (!await NotificationConsentPrefs.isMasterEnabled(uid)) return;
      if (snap.isWarningOrAbove) {
        if (_warningSent) return;
        _warningSent = true;
        await _risk.notifyRiskThreshold(latitude: lat, longitude: lon);
      } else {
        _warningSent = false;
      }
    } catch (_) {}
  }
}
