import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

/** USGS Instantaneous Values — stream rise rate (Phase 3). */
export async function fetchUsgs(
  query: LocationQuery,
): Promise<SourceResult<{ stream_rate_ft_hr?: number }>> {
  // TODO(Phase 3): waterservices.usgs.gov IV, stateCd=nj / bBox
  void query;
  return { source: "usgs", ok: true, data: {} };
}
