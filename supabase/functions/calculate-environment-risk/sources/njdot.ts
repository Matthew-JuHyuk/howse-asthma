import { fetchWithTimeout, haversineKm } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

const FREIGHT_AADT = 25000;

/**
 * NJDOT AADT static weight — bbox on si_lat/si_lon + Haversine.
 */
export async function queryNjdotNearbyAadt(
  query: LocationQuery,
  radiusM = 1500,
): Promise<SourceResult<{ aadt?: number; near_freight?: boolean }>> {
  const deg = radiusM / 111_000;
  const minLat = query.latitude - deg;
  const maxLat = query.latitude + deg;
  const minLon = query.longitude - deg;
  const maxLon = query.longitude + deg;

  const url = new URL("https://data.nj.gov/resource/c74r-6c8d.json");
  url.searchParams.set("$select", "ev_aadt_tot,si_lat,si_lon");
  url.searchParams.set(
    "$where",
    `si_lat between ${minLat} and ${maxLat} AND si_lon between ${minLon} and ${maxLon}`,
  );
  url.searchParams.set("$limit", "100");

  try {
    const res = await fetchWithTimeout(url, {}, 4000);
    if (!res.ok) {
      return {
        source: "njdot",
        ok: false,
        error: errorFromHttpStatus(res.status),
      };
    }
    const rows = await res.json() as Array<{
      ev_aadt_tot?: string | number;
      si_lat?: string | number;
      si_lon?: string | number;
    }>;

    let bestAadt: number | undefined;
    let bestDist = Infinity;
    for (const row of Array.isArray(rows) ? rows : []) {
      const lat = Number(row.si_lat);
      const lon = Number(row.si_lon);
      const aadt = Number(row.ev_aadt_tot);
      if (!Number.isFinite(lat) || !Number.isFinite(lon) || !Number.isFinite(aadt)) {
        continue;
      }
      const distM =
        haversineKm(query.latitude, query.longitude, lat, lon) * 1000;
      if (distM > radiusM) continue;
      if (distM < bestDist) {
        bestDist = distM;
        bestAadt = aadt;
      }
    }

    if (bestAadt == null) {
      return { source: "njdot", ok: true, data: { near_freight: false } };
    }
    return {
      source: "njdot",
      ok: true,
      data: {
        aadt: bestAadt,
        near_freight: bestAadt >= FREIGHT_AADT,
      },
    };
  } catch (e) {
    return { source: "njdot", ok: false, error: errorFromCatch(e) };
  }
}
