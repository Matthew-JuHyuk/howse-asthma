import type { EnvironmentSnapshot, LocationQuery } from "../_shared/types.ts";
import { coarseCacheKey } from "../_shared/geohash.ts";

/**
 * environment_forecasts cache read/write — implemented in Phase 3.
 * Skeleton returns miss so the handler can fall through to live fetch stubs.
 */

export async function readForecastCache(
  _admin: unknown,
  query: LocationQuery,
): Promise<EnvironmentSnapshot | null> {
  const key = coarseCacheKey(query.latitude, query.longitude);
  console.log("[cache] miss (stub)", key);
  return null;
}

export async function writeForecastCache(
  _admin: unknown,
  query: LocationQuery,
  snapshot: EnvironmentSnapshot,
): Promise<void> {
  const key = coarseCacheKey(query.latitude, query.longitude);
  console.log("[cache] write skipped (stub)", key, snapshot.risk_score);
}
