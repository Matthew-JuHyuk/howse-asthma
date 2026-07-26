import { fetchWithTimeout, haversineKm } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

const MAX_KM = 5;

type TimeSeries = {
  sourceInfo?: {
    geoLocation?: {
      geogLocation?: { latitude?: number; longitude?: number };
    };
  };
  values?: Array<{
    value?: Array<{ value?: string; dateTime?: string }>;
  }>;
};

function pickBestRate(
  seriesList: TimeSeries[],
  query: LocationQuery,
): number | undefined {
  let bestRate: number | undefined;
  let bestDist = Infinity;

  for (const series of seriesList) {
    const loc = series.sourceInfo?.geoLocation?.geogLocation;
    const lat = Number(loc?.latitude);
    const lon = Number(loc?.longitude);
    if (!Number.isFinite(lat) || !Number.isFinite(lon)) continue;
    const dist = haversineKm(query.latitude, query.longitude, lat, lon);
    if (dist > MAX_KM) continue;

    const points = series.values?.[0]?.value ?? [];
    if (points.length < 2) continue;
    const first = points[0]!;
    const last = points[points.length - 1]!;
    const v0 = Number(first.value);
    const v1 = Number(last.value);
    const t0 = Date.parse(first.dateTime ?? "");
    const t1 = Date.parse(last.dateTime ?? "");
    if (!Number.isFinite(v0) || !Number.isFinite(v1) || !(t1 > t0)) continue;
    const hours = (t1 - t0) / 3_600_000;
    if (hours <= 0) continue;
    const rate = (v1 - v0) / hours;
    if (dist < bestDist) {
      bestDist = dist;
      bestRate = rate;
    }
  }
  return bestRate;
}

/**
 * USGS Instantaneous Values — nearby gage only (bbox).
 * No statewide fallback (avoids large-response DoS amplification).
 */
export async function fetchUsgs(
  query: LocationQuery,
): Promise<SourceResult<{ stream_rate_ft_hr?: number }>> {
  const d = 0.08;
  const west = (query.longitude - d).toFixed(5);
  const south = (query.latitude - d).toFixed(5);
  const east = (query.longitude + d).toFixed(5);
  const north = (query.latitude + d).toFixed(5);

  const url = new URL("https://waterservices.usgs.gov/nwis/iv/");
  url.searchParams.set("format", "json");
  url.searchParams.set("bBox", `${west},${south},${east},${north}`);
  url.searchParams.set("parameterCd", "00065");
  url.searchParams.set("period", "PT2H");
  url.searchParams.set("siteStatus", "active");

  try {
    const res = await fetchWithTimeout(url, {
      headers: { Accept: "application/json" },
    }, 4000);
    if (!res.ok) {
      // Empty neighborhood is fine for risk; treat client errors as soft miss.
      if (res.status === 400 || res.status === 404) {
        return { source: "usgs", ok: true, data: {} };
      }
      return {
        source: "usgs",
        ok: false,
        error: errorFromHttpStatus(res.status),
      };
    }
    const json = await res.json() as {
      value?: { timeSeries?: TimeSeries[] };
    };
    const bestRate = pickBestRate(json.value?.timeSeries ?? [], query);
    return {
      source: "usgs",
      ok: true,
      data: bestRate != null
        ? { stream_rate_ft_hr: Math.round(bestRate * 100) / 100 }
        : {},
    };
  } catch (e) {
    return { source: "usgs", ok: false, error: errorFromCatch(e) };
  }
}
