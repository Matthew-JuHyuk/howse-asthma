import { fetchWithTimeout } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

const HOURLY =
  "pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,us_aqi,us_aqi_pm2_5,us_aqi_nitrogen_dioxide";

export type AqiPeriod = {
  period: "morning" | "afternoon" | "evening";
  us_aqi?: number;
};

export type AqiDay = {
  date: string;
  periods: AqiPeriod[];
  us_aqi_max?: number;
};

/**
 * Open-Meteo AQ — pollutants / US AQI only. NEVER request *_pollen.
 */
export async function fetchOpenMeteo(
  query: LocationQuery,
): Promise<
  SourceResult<{
    us_aqi?: number;
    pm25?: number;
    no2?: number;
    daily?: AqiDay[];
  }>
> {
  const url = new URL("https://air-quality-api.open-meteo.com/v1/air-quality");
  url.searchParams.set("latitude", String(query.latitude));
  url.searchParams.set("longitude", String(query.longitude));
  url.searchParams.set("hourly", HOURLY);
  url.searchParams.set("timezone", "auto");
  url.searchParams.set("domains", "cams_global");
  url.searchParams.set("forecast_days", "2");

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
        time?: string[];
        us_aqi?: Array<number | null>;
        pm2_5?: Array<number | null>;
        nitrogen_dioxide?: Array<number | null>;
      };
    };

    const times = json.hourly?.time ?? [];
    const aqiArr = json.hourly?.us_aqi ?? [];
    const latest = (arr: Array<number | null> | undefined) => {
      if (!arr) return undefined;
      for (let i = arr.length - 1; i >= 0; i--) {
        const v = arr[i];
        if (v != null && Number.isFinite(v)) return v;
      }
      return undefined;
    };

    const byDay = new Map<string, {
      morning: number[];
      afternoon: number[];
      evening: number[];
    }>();

    for (let i = 0; i < times.length; i++) {
      const t = times[i];
      const aqi = aqiArr[i];
      if (!t || aqi == null || !Number.isFinite(aqi)) continue;
      const date = t.slice(0, 10);
      const hour = Number(t.slice(11, 13));
      if (!byDay.has(date)) {
        byDay.set(date, { morning: [], afternoon: [], evening: [] });
      }
      const bucket = byDay.get(date)!;
      if (hour >= 6 && hour < 12) bucket.morning.push(aqi);
      else if (hour >= 12 && hour < 18) bucket.afternoon.push(aqi);
      else if (hour >= 18 && hour < 24) bucket.evening.push(aqi);
    }

    const avg = (xs: number[]) =>
      xs.length === 0
        ? undefined
        : Math.round(xs.reduce((a, b) => a + b, 0) / xs.length);

    const daily: AqiDay[] = [];
    for (const [date, buckets] of byDay) {
      const periods: AqiPeriod[] = [
        { period: "morning", us_aqi: avg(buckets.morning) },
        { period: "afternoon", us_aqi: avg(buckets.afternoon) },
        { period: "evening", us_aqi: avg(buckets.evening) },
      ];
      const vals = periods.map((p) => p.us_aqi).filter((v): v is number =>
        v != null
      );
      daily.push({
        date,
        periods,
        us_aqi_max: vals.length ? Math.max(...vals) : undefined,
      });
    }
    daily.sort((a, b) => a.date.localeCompare(b.date));

    return {
      source: "openmeteo",
      ok: true,
      data: {
        us_aqi: latest(json.hourly?.us_aqi),
        pm25: latest(json.hourly?.pm2_5),
        no2: latest(json.hourly?.nitrogen_dioxide),
        daily: daily.slice(0, 2),
      },
    };
  } catch (e) {
    return { source: "openmeteo", ok: false, error: errorFromCatch(e) };
  }
}
