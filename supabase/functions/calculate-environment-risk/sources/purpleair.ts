import { optionalEnv } from "../../_shared/env.ts";
import { fetchWithTimeout } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult, TrapLevel } from "../../_shared/types.ts";

const HIGH_UGM3 = 12.0;
const CRITICAL_UGM3 = 35.5;
const BBOX_DEG = 0.08;

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

/** PurpleAir TRAP proxy — bbox + minimal fields. */
export async function fetchPurpleAir(
  query: LocationQuery,
): Promise<
  SourceResult<{
    local_pm25?: number;
    trap_level?: TrapLevel;
    approx_aqi?: number;
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
    if (pmIdx < 0 || !json.data?.length) {
      return { source: "purpleair", ok: true, data: { trap_level: "LOW" } };
    }

    const values: number[] = [];
    for (const row of json.data) {
      const pm = Number(row[pmIdx]);
      if (!Number.isFinite(pm) || pm < 0) continue;
      if (confIdx >= 0) {
        const conf = Number(row[confIdx]);
        if (Number.isFinite(conf) && conf < 50) continue;
      }
      values.push(pm);
    }
    if (values.length === 0) {
      return { source: "purpleair", ok: true, data: { trap_level: "LOW" } };
    }
    values.sort((a, b) => a - b);
    const median = values[Math.floor(values.length / 2)]!;
    return {
      source: "purpleair",
      ok: true,
      data: {
        local_pm25: median,
        trap_level: pm25ToTrap(median),
        approx_aqi: pm25ToApproxAqi(median),
      },
    };
  } catch (e) {
    return { source: "purpleair", ok: false, error: errorFromCatch(e) };
  }
}
