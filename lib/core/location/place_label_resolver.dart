import 'package:geolocator/geolocator.dart';

import '../../features/locations/data/saved_location_repository.dart';

/// Resolve a human place name without inventing reverse-geocode APIs.
/// Prefer nearest saved location label within [maxMeters] (W3-4.1).
class PlaceLabelResolver {
  PlaceLabelResolver({SavedLocationRepository? repo})
      : _repo = repo ?? SavedLocationRepository();

  final SavedLocationRepository _repo;

  /// Match radius: 2 km — close enough to treat as "at" a saved place.
  static const maxMeters = 2000.0;

  Future<String?> resolve({
    required double latitude,
    required double longitude,
  }) async {
    final locs = await _repo.list();
    if (locs.isEmpty) return null;

    SavedLocation? best;
    var bestDist = double.infinity;
    for (final loc in locs) {
      final d = Geolocator.distanceBetween(
        latitude,
        longitude,
        loc.latitude,
        loc.longitude,
      );
      if (d < bestDist) {
        bestDist = d;
        best = loc;
      }
    }
    if (best == null || bestDist > maxMeters) {
      // Still show primary label as context when far from all saved places.
      for (final loc in locs) {
        if (loc.isPrimary) return loc.label;
      }
      return null;
    }
    return best.label;
  }
}
