/**
 * Geohash helpers for environment_forecasts cache keys.
 * Full encode/decode lands in Phase 3 — skeleton uses a coarse string key.
 */

export function coarseCacheKey(latitude: number, longitude: number, precision = 5): string {
  // Placeholder until a proper geohash encoder is added.
  const lat = latitude.toFixed(precision);
  const lon = longitude.toFixed(precision);
  return `ll:${lat},${lon}`;
}
