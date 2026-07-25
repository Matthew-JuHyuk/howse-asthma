import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

/**
 * Open-Meteo AQ for NJ — pm10, pm2_5, gases, us_aqi only.
 * NEVER request *_pollen (Europe CAMS).
 */
export async function fetchOpenMeteo(
  query: LocationQuery,
): Promise<SourceResult<{ us_aqi?: number; pm25?: number }>> {
  // TODO(Phase 3): air-quality-api with allowed fields only
  void query;
  return { source: "openmeteo", ok: true, data: {} };
}
