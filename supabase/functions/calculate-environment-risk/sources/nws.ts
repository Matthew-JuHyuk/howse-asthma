import { optionalEnv } from "../../_shared/env.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

/** NWS Active Alerts — endpoint from env-api-config.json (Phase 3). */
export async function fetchNwsAlerts(
  query: LocationQuery,
): Promise<SourceResult<{ flashFloodActive: boolean; headline?: string }>> {
  const contact = optionalEnv("NWS_USER_AGENT_CONTACT");
  if (!contact) {
    return { source: "nws", ok: false, error: "NWS_USER_AGENT_CONTACT not set" };
  }
  // TODO(Phase 3): GET https://api.weather.gov/alerts/active?point=lat,lon
  void query;
  return {
    source: "nws",
    ok: true,
    data: { flashFloodActive: false },
  };
}
