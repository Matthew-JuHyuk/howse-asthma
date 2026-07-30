import { optionalEnv } from "../../_shared/env.ts";
import { fetchWithTimeout } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult, TrapLevel } from "../../_shared/types.ts";

const HIGH_UGM3 = 12.0;
const CRITICAL_UGM3 = 35.5;
/** Half-width of query bbox in degrees (~8.9 km at mid-latitudes). */
const BBOX_DEG = 0.08;
/** Documented search radius shown in UI (BBOX_DEG * ~111 km/deg). */
export const PURPLEAIR_SEARCH_RADIUS_KM =
  Math.round(BBOX_DEG * 111 * 10) / 10;

function pm25ToTrap(pm25: number): TrapLevel {
  if (pm25 > CRITICAL_UGM3) return "CRITICAL";
  if (pm25 > HIGH_UGM3) return "HIGH";
  if (pm25 > 6) return "MODERATE";
  return "LOW";
}

export function pm25ToApproxAqi(pm25: number): number {
  const bp: Array<[number, number, number, number]> = [
    [0, 12.0, 0, 50],
    [12.1, 35.4, 51, 100],
    [35.5, 55.4, 101, 150],
    [55.5, 150.4, 151, 200],
    [150.5, 250.4, 201, 300],
    [250.5, 500.4, 301, 500],
  ];
  for (const [cLo, cHi, aLo, aHi] of bp) {
    if (pm25 >= cLo && pm25 <= cHi) {
      return Math.round(((aHi - aLo) / (cHi - cLo)) * (pm25 - cLo) + aLo);
    }
  }
  return pm25 > 500 ? 500 : 0;
}

function haversineKm(
  lat1: number,
  lon1: number,
  lat2: number,
  lon2: number,
): number {
  const toRad = (d: number) => (d * Math.PI) / 180;
  const R = 6371;
  const dLat = toRad(lat2 - lat1);
  const dLon = toRad(lon2 - lon1);
  const a =
    Math.sin(dLat / 2) ** 2 +
    Math.cos(toRad(lat1)) * Math.cos(toRad(lat2)) * Math.sin(dLon / 2) ** 2;
  return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
}

/** PurpleAir TRAP proxy — bbox + minimal fields + nearest-sensor distance. */
export async function fetchPurpleAir(
  query: LocationQuery,
): Promise<
  SourceResult<{
    local_pm25?: number;
    trap_level?: TrapLevel;
    approx_aqi?: number;
    nearest_purpleair_km?: number;
    purpleair_search_radius_km?: number;
    httpStatus?: number;
  }>
> {
  const key = optionalEnv("PURPLEAIR_READ_KEY");
  if (!key) {
    return { source: "purpleair", ok: false, error: "unconfigured" };
  }

  const url = new URL("https://api.purpleair.com/v1/sensors");
  url.searchParams.set("fields", "latitude,longitude,pm2.5_10minute,confidence");
  url.searchParams.set("nwlat", String(query.latitude + BBOX_DEG));
  url.searchParams.set("nwlng", String(query.longitude - BBOX_DEG));
  url.searchParams.set("selat", String(query.latitude - BBOX_DEG));
  url.searchParams.set("selng", String(query.longitude + BBOX_DEG));

  try {
    const res = await fetchWithTimeout(url, {
      headers: { "X-API-Key": key },
    });
    if (!res.ok) {
      return {
        source: "purpleair",
        ok: false,
        error: errorFromHttpStatus(res.status),
        data: { httpStatus: res.status },
      };
    }
    const json = await res.json() as {
      data?: Array<Array<number | null>>;
      fields?: string[];
    };
    const fields = json.fields ?? [];
    const pmIdx = fields.indexOf("pm2.5_10minute");
    const confIdx = fields.indexOf("confidence");
    const latIdx = fields.indexOf("latitude");
    const lonIdx = fields.indexOf("longitude");
    if (pmIdx < 0 || !json.data?.length) {
      return {
        source: "purpleair",
        ok: true,
        data: {
          trap_level: "LOW",
          purpleair_search_radius_km: PURPLEAIR_SEARCH_RADIUS_KM,
        },
      };
    }

    let nearestPm: number | null = null;
    let nearestKm: number | null = null;
    for (const row of json.data) {
      const pm = Number(row[pmIdx]);
      if (!Number.isFinite(pm) || pm < 0) continue;
      if (confIdx >= 0) {
        const conf = Number(row[confIdx]);
        if (Number.isFinite(conf) && conf < 50) continue;
      }
      let distKm = Number.POSITIVE_INFINITY;
      if (latIdx >= 0 && lonIdx >= 0) {
        const lat = Number(row[latIdx]);
        const lon = Number(row[lonIdx]);
        if (Number.isFinite(lat) && Number.isFinite(lon)) {
          distKm = haversineKm(query.latitude, query.longitude, lat, lon);
        }
      }
      if (nearestKm == null || distKm < nearestKm) {
        nearestKm = Number.isFinite(distKm) ? distKm : nearestKm;
        nearestPm = pm;
      }
    }
    if (nearestPm == null) {
      return {
        source: "purpleair",
        ok: true,
        data: {
          trap_level: "LOW",
          purpleair_search_radius_km: PURPLEAIR_SEARCH_RADIUS_KM,
        },
      };
    }
    const nearestRounded =
      nearestKm != null && Number.isFinite(nearestKm)
        ? Math.round(nearestKm * 10) / 10
        : undefined;
    return {
      source: "purpleair",
      ok: true,
      data: {
        local_pm25: nearestPm,
        trap_level: pm25ToTrap(nearestPm),
        approx_aqi: pm25ToApproxAqi(nearestPm),
        nearest_purpleair_km: nearestRounded,
        purpleair_search_radius_km: PURPLEAIR_SEARCH_RADIUS_KM,
      },
    };
  } catch (e) {
    return { source: "purpleair", ok: false, error: errorFromCatch(e) };
  }
}
