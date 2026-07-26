import { optionalEnv } from "../../_shared/env.ts";
import { fetchWithTimeout } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

/** EPA AirNow current observation — primary AQI. */
export async function fetchAirNow(
  query: LocationQuery,
): Promise<
  SourceResult<{ aqi?: number; pm25?: number; parameter?: string; httpStatus?: number }>
> {
  const key = optionalEnv("AIRNOW_API_KEY");
  if (!key) {
    return { source: "airnow", ok: false, error: "unconfigured" };
  }

  const url = new URL(
    "https://www.airnowapi.org/aq/observation/latLong/current/",
  );
  url.searchParams.set("format", "application/json");
  url.searchParams.set("latitude", String(query.latitude));
  url.searchParams.set("longitude", String(query.longitude));
  url.searchParams.set("distance", "25");
  url.searchParams.set("API_KEY", key);

  try {
    const res = await fetchWithTimeout(url);
    if (!res.ok) {
      return {
        source: "airnow",
        ok: false,
        error: errorFromHttpStatus(res.status),
        data: { httpStatus: res.status },
      };
    }
    const rows = await res.json() as Array<{
      AQI?: number;
      ParameterName?: string;
    }>;
    if (!Array.isArray(rows) || rows.length === 0) {
      return { source: "airnow", ok: true, data: {} };
    }

    let pm25Aqi: number | undefined;
    let maxAqi = 0;
    let parameter: string | undefined;
    for (const row of rows) {
      const aqi = Number(row.AQI);
      if (!Number.isFinite(aqi)) continue;
      if (aqi > maxAqi) {
        maxAqi = aqi;
        parameter = row.ParameterName;
      }
      const name = (row.ParameterName ?? "").toUpperCase();
      if (name.includes("PM2.5") || name.includes("PM25")) {
        pm25Aqi = aqi;
      }
    }

    return {
      source: "airnow",
      ok: true,
      data: {
        aqi: pm25Aqi ?? (maxAqi > 0 ? maxAqi : undefined),
        parameter,
      },
    };
  } catch (e) {
    return { source: "airnow", ok: false, error: errorFromCatch(e) };
  }
}
