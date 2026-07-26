import { optionalEnv } from "../../_shared/env.ts";
import { fetchWithTimeout } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

const FLOOD_EVENTS = new Set([
  "Flash Flood Warning",
  "Flash Flood Watch",
  "Flood Advisory",
  "Flood Warning",
  "Flood Watch",
]);

/** NWS Active Alerts — flash flood detection. */
export async function fetchNwsAlerts(
  query: LocationQuery,
): Promise<SourceResult<{ flashFloodActive: boolean; headline?: string }>> {
  const contact = optionalEnv("NWS_USER_AGENT_CONTACT");
  if (!contact) {
    return { source: "nws", ok: false, error: "unconfigured" };
  }

  const url = new URL("https://api.weather.gov/alerts/active");
  url.searchParams.set("point", `${query.latitude},${query.longitude}`);
  url.searchParams.set("status", "actual");

  try {
    const res = await fetchWithTimeout(url, {
      headers: {
        Accept: "application/geo+json",
        "User-Agent": `HowseAsthmaApp/1.0 (${contact})`,
      },
    });
    if (!res.ok) {
      return { source: "nws", ok: false, error: errorFromHttpStatus(res.status) };
    }
    const json = await res.json() as {
      features?: Array<{ properties?: { event?: string; headline?: string } }>;
    };
    let flashFloodActive = false;
    let headline: string | undefined;
    for (const f of json.features ?? []) {
      const event = f.properties?.event ?? "";
      if (FLOOD_EVENTS.has(event)) {
        flashFloodActive = true;
        headline = f.properties?.headline ?? event;
        break;
      }
    }
    return { source: "nws", ok: true, data: { flashFloodActive, headline } };
  } catch (e) {
    return { source: "nws", ok: false, error: errorFromCatch(e) };
  }
}
