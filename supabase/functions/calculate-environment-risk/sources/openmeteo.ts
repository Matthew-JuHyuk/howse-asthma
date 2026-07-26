import { fetchWithTimeout } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

const HOURLY =
  "pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,us_aqi,us_aqi_pm2_5,us_aqi_nitrogen_dioxide";

/**
 * Open-Meteo AQ for NJ — pollutants / US AQI only.
 * NEVER request *_pollen (Europe CAMS).
 */
export async function fetchOpenMeteo(
  query: LocationQuery,
): Promise<
  SourceResult<{ us_aqi?: number; pm25?: number; no2?: number }>
> {
  const url = new URL("https://air-quality-api.open-meteo.com/v1/air-quality");
  url.searchParams.set("latitude", String(query.latitude));
  url.searchParams.set("longitude", String(query.longitude));
  url.searchParams.set("hourly", HOURLY);
  url.searchParams.set("timezone", "auto");
  url.searchParams.set("domains", "cams_global");

  if (url.searchParams.get("hourly")?.includes("pollen")) {
    return { source: "openmeteo", ok: false, error: "unavailable" };
  }

  try {
    const res = await fetchWithTimeout(url);
    if (!res.ok) {
      return {
        source: "openmeteo",
        ok: false,
        error: errorFromHttpStatus(res.status),
      };
    }
    const json = await res.json() as {
      hourly?: {
        us_aqi?: Array<number | null>;
        pm2_5?: Array<number | null>;
        nitrogen_dioxide?: Array<number | null>;
      };
    };
    const latest = (arr: Array<number | null> | undefined) => {
      if (!arr) return undefined;
      for (let i = arr.length - 1; i >= 0; i--) {
        const v = arr[i];
        if (v != null && Number.isFinite(v)) return v;
      }
      return undefined;
    };

    return {
      source: "openmeteo",
      ok: true,
      data: {
        us_aqi: latest(json.hourly?.us_aqi),
        pm25: latest(json.hourly?.pm2_5),
        no2: latest(json.hourly?.nitrogen_dioxide),
      },
    };
  } catch (e) {
    return { source: "openmeteo", ok: false, error: errorFromCatch(e) };
  }
}
