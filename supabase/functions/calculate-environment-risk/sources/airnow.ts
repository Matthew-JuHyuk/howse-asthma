import { optionalEnv } from "../../_shared/env.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

/** EPA AirNow current observation — primary AQI (Phase 3). */
export async function fetchAirNow(
  query: LocationQuery,
): Promise<SourceResult<{ aqi?: number; pm25?: number }>> {
  const key = optionalEnv("AIRNOW_API_KEY");
  if (!key) {
    return { source: "airnow", ok: false, error: "AIRNOW_API_KEY not set" };
  }
  // TODO(Phase 3): observation/latLong/current + Fallback chain
  void query;
  return { source: "airnow", ok: true, data: {} };
}
