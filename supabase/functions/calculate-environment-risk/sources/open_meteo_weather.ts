/**
 * Open-Meteo Forecast — humidity / dew / temp for mold dampness proxy (W3-6).
 * Docs: https://open-meteo.com/en/docs
 * NEVER request pollen fields here.
 */

import { fetchWithTimeout } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

const HOURLY = "relative_humidity_2m,dew_point_2m,temperature_2m";

export type WeatherHour = {
  time: string;
  rh?: number;
  dew_c?: number;
  temp_c?: number;
};

export type OpenMeteoWeatherData = {
  hours: WeatherHour[];
  current_rh?: number;
  current_dew_c?: number;
  current_temp_c?: number;
};

export async function fetchOpenMeteoWeather(
  query: LocationQuery,
): Promise<SourceResult<OpenMeteoWeatherData>> {
  const url = new URL("https://api.open-meteo.com/v1/forecast");
  url.searchParams.set("latitude", String(query.latitude));
  url.searchParams.set("longitude", String(query.longitude));
  url.searchParams.set("hourly", HOURLY);
  url.searchParams.set("timezone", "auto");
  url.searchParams.set("forecast_days", "2");
  url.searchParams.set("past_days", "1");

  try {
    const res = await fetchWithTimeout(url);
    if (!res.ok) {
      return {
        source: "openmeteo_weather",
        ok: false,
        error: errorFromHttpStatus(res.status),
      };
    }
    const json = await res.json() as {
      hourly?: {
        time?: string[];
        relative_humidity_2m?: Array<number | null>;
        dew_point_2m?: Array<number | null>;
        temperature_2m?: Array<number | null>;
      };
    };
    const times = json.hourly?.time ?? [];
    const rhArr = json.hourly?.relative_humidity_2m ?? [];
    const dewArr = json.hourly?.dew_point_2m ?? [];
    const tArr = json.hourly?.temperature_2m ?? [];
    const hours: WeatherHour[] = [];
    for (let i = 0; i < times.length; i++) {
      const rh = rhArr[i];
      const dew = dewArr[i];
      const temp = tArr[i];
      hours.push({
        time: times[i]!,
        rh: rh != null && Number.isFinite(rh) ? Number(rh) : undefined,
        dew_c: dew != null && Number.isFinite(dew) ? Number(dew) : undefined,
        temp_c: temp != null && Number.isFinite(temp) ? Number(temp) : undefined,
      });
    }

    // Prefer hour closest to now (past or present).
    const now = Date.now();
    let best: WeatherHour | undefined;
    let bestDelta = Number.POSITIVE_INFINITY;
    for (const h of hours) {
      const t = Date.parse(h.time);
      if (!Number.isFinite(t)) continue;
      const d = Math.abs(t - now);
      if (d < bestDelta && h.rh != null) {
        bestDelta = d;
        best = h;
      }
    }

    return {
      source: "openmeteo_weather",
      ok: true,
      data: {
        hours,
        current_rh: best?.rh,
        current_dew_c: best?.dew_c,
        current_temp_c: best?.temp_c,
      },
    };
  } catch (e) {
    return {
      source: "openmeteo_weather",
      ok: false,
      error: errorFromCatch(e),
    };
  }
}
