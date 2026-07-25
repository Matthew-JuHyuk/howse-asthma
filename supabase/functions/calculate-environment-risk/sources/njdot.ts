import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

/**
 * NJDOT AADT static weight — queryNjdotNearbyAadt with spatial branch
 * (si_lat/si_lon; no within_circle without Point). Phase 3.
 */
export async function queryNjdotNearbyAadt(
  query: LocationQuery,
  _radiusM = 1500,
): Promise<SourceResult<{ aadt?: number; near_freight?: boolean }>> {
  void query;
  return { source: "njdot", ok: true, data: { near_freight: false } };
}
