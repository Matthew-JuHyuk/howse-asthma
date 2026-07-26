// Howse Asthma — calculate-environment-risk (hardened live sources + Geohash cache)

import { aggregateRiskScores, applyFreightWeight } from "./aggregate.ts";
import {
  readForecastCache,
  readRecentPollen,
  readSoftStaleForecastCache,
  writeForecastCache,
} from "./cache.ts";
import { isCircuitOpen, tripCircuit } from "../_shared/circuit_breaker.ts";
import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { encodeGeohash } from "../_shared/geohash.ts";
import { isInNewJersey, isInServiceArea } from "../_shared/geo_bounds.ts";
import { checkAndRecordEnvRiskRate } from "../_shared/rate_limit.ts";
import { isCircuitTripError } from "../_shared/source_errors.ts";
import type {
  EnvironmentSnapshot,
  LocationQuery,
  SourceResult,
  TrapLevel,
} from "../_shared/types.ts";
import { requireUser } from "../_shared/user_client.ts";
import { fetchAirNow } from "./sources/airnow.ts";
import { fetchGooglePollen } from "./sources/google_pollen.ts";
import { fetchNwsAlerts } from "./sources/nws.ts";
import { queryNjdotNearbyAadt } from "./sources/njdot.ts";
import { fetchOpenMeteo } from "./sources/openmeteo.ts";
import { fetchPurpleAir } from "./sources/purpleair.ts";
import { fetchUsgs } from "./sources/usgs.ts";

// deno-lint-ignore no-explicit-any
type Admin = any;

function parseLocation(body: unknown): LocationQuery | null {
  if (!body || typeof body !== "object") return null;
  const b = body as Record<string, unknown>;
  const latitude = Number(b.latitude);
  const longitude = Number(b.longitude);
  if (!Number.isFinite(latitude) || !Number.isFinite(longitude)) return null;
  if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
    return null;
  }
  // Ignore patient_id / other client fields — no IDOR surface.
  return { latitude, longitude };
}

async function guardedSource<T>(
  admin: Admin,
  source: string,
  fn: () => Promise<SourceResult<T>>,
): Promise<SourceResult<T>> {
  if (await isCircuitOpen(admin, source)) {
    return { source, ok: false, error: "circuit_open" };
  }
  const result = await fn();
  if (!result.ok && isCircuitTripError(result.error)) {
    const status = (result.data as { httpStatus?: number } | undefined)
      ?.httpStatus;
    await tripCircuit(admin, source, status);
  }
  return result;
}

function isDegraded(summary: Record<string, string>, aqi: number | null): boolean {
  if (aqi == null) return true;
  for (const code of Object.values(summary)) {
    if (
      code === "http_429" ||
      code === "http_403" ||
      code === "http_blocked" ||
      code === "circuit_open" ||
      code === "timeout"
    ) {
      return true;
    }
  }
  return false;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }
  if (req.method !== "POST") {
    return jsonResponse({ error: "method_not_allowed" }, 405);
  }

  const authed = await requireUser(req);
  if (authed instanceof Response) return authed;
  const { user, admin } = authed;

  let body: unknown;
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "invalid_body" }, 400);
  }

  const query = parseLocation(body);
  if (!query) {
    return jsonResponse({ error: "expected_latitude_longitude" }, 400);
  }
  if (!isInServiceArea(query.latitude, query.longitude)) {
    return jsonResponse({ error: "out_of_service_area" }, 400);
  }

  const geohash = encodeGeohash(query.latitude, query.longitude, 5);

  const cached = await readForecastCache(admin, query);
  if (cached) {
    return jsonResponse(cached);
  }

  const rate = await checkAndRecordEnvRiskRate(admin, user.id, geohash);
  if (!rate.allowed) {
    const stale = await readSoftStaleForecastCache(admin, query);
    if (stale) {
      return jsonResponse({
        ...stale,
        data_source_summary: {
          ...(stale.data_source_summary ?? {}),
          rate_limit: rate.reason,
        },
      });
    }
    return jsonResponse({ error: rate.reason }, 429);
  }

  const recentPollen = await readRecentPollen(admin, query);
  const skipPollenApi = recentPollen != null;
  const inNewJersey = isInNewJersey(query.latitude, query.longitude);

  const settled = await Promise.allSettled([
    guardedSource(admin, "nws", () => fetchNwsAlerts(query)),
    guardedSource(admin, "airnow", () => fetchAirNow(query)),
    guardedSource(admin, "purpleair", () => fetchPurpleAir(query)),
    guardedSource(admin, "openmeteo", () => fetchOpenMeteo(query)),
    skipPollenApi
      ? Promise.resolve({
        source: "google_pollen",
        ok: true,
        data: {
          pollen_upi: recentPollen!.pollen_upi ?? undefined,
          dominant: recentPollen!.dominant ?? undefined,
          from_pollen_cache: true,
        },
      } satisfies SourceResult<{
        pollen_upi?: number;
        dominant?: string;
        from_pollen_cache?: boolean;
      }>)
      : guardedSource(admin, "google_pollen", () => fetchGooglePollen(query)),
    guardedSource(admin, "usgs", () => fetchUsgs(query)),
    inNewJersey
      ? guardedSource(admin, "njdot", () => queryNjdotNearbyAadt(query))
      : Promise.resolve({
        source: "njdot",
        ok: true,
        data: { near_freight: false, skipped_outside_nj: true },
      } satisfies SourceResult<{
        near_freight?: boolean;
        skipped_outside_nj?: boolean;
      }>),
  ]);

  const summary: Record<string, string> = {};
  let flashFloodActive = false;
  let floodHeadline: string | null = null;
  let airnowAqi: number | null = null;
  let openMeteoAqi: number | null = null;
  let purpleApproxAqi: number | null = null;
  let trapLevel: TrapLevel | null = "LOW";
  let pollenUpi: number | null = null;
  let dominantPollen: string | null = null;
  let pollenFetchedAt: string | null = null;
  let pm25: number | null = null;
  let localPm25: number | null = null;
  let nearFreight = false;
  let streamRate: number | null = null;

  for (const result of settled) {
    if (result.status !== "fulfilled") {
      summary.rejected = "unavailable";
      continue;
    }
    const src = result.value;
    summary[src.source] = src.ok ? "ok" : (src.error ?? "unavailable");
    if (!src.ok || !src.data) continue;

    if (src.source === "nws") {
      const d = src.data as { flashFloodActive: boolean; headline?: string };
      flashFloodActive = Boolean(d.flashFloodActive);
      floodHeadline = d.headline ?? null;
    }
    if (src.source === "airnow") {
      const d = src.data as { aqi?: number; pm25?: number };
      if (d.aqi != null) airnowAqi = d.aqi;
      if (d.pm25 != null) pm25 = d.pm25;
    }
    if (src.source === "openmeteo") {
      const d = src.data as { us_aqi?: number; pm25?: number };
      if (d.us_aqi != null) openMeteoAqi = d.us_aqi;
      if (d.pm25 != null && pm25 == null) pm25 = d.pm25;
    }
    if (src.source === "purpleair") {
      const d = src.data as {
        local_pm25?: number;
        trap_level?: TrapLevel;
        approx_aqi?: number;
      };
      if (d.local_pm25 != null) localPm25 = d.local_pm25;
      if (d.trap_level) trapLevel = d.trap_level;
      if (d.approx_aqi != null) purpleApproxAqi = d.approx_aqi;
    }
    if (src.source === "google_pollen") {
      const d = src.data as {
        pollen_upi?: number;
        dominant?: string;
        from_pollen_cache?: boolean;
      };
      if (d.pollen_upi != null) pollenUpi = d.pollen_upi;
      if (d.dominant) dominantPollen = d.dominant;
      if (d.from_pollen_cache && recentPollen) {
        summary.google_pollen = "pollen_cache_6h";
        pollenFetchedAt = recentPollen.fetched_at;
      } else if (d.pollen_upi != null) {
        pollenFetchedAt = new Date().toISOString();
      }
    }
    if (src.source === "usgs") {
      const d = src.data as { stream_rate_ft_hr?: number };
      if (d.stream_rate_ft_hr != null) streamRate = d.stream_rate_ft_hr;
    }
    if (src.source === "njdot") {
      const d = src.data as {
        near_freight?: boolean;
        skipped_outside_nj?: boolean;
      };
      if (!d.skipped_outside_nj) {
        nearFreight = Boolean(d.near_freight);
      }
    }
  }

  // AQI fallback: AirNow → Open-Meteo us_aqi → PurpleAir approx
  let aqi: number | null = null;
  let aqiSource: string | null = null;
  if (airnowAqi != null) {
    aqi = airnowAqi;
    aqiSource = "airnow";
  } else if (openMeteoAqi != null) {
    aqi = openMeteoAqi;
    aqiSource = "openmeteo";
  } else if (purpleApproxAqi != null) {
    aqi = purpleApproxAqi;
    aqiSource = "purpleair";
  }

  // No usable AQI and hard blocks on paid sources → prefer soft stale over empty risk.
  const blockedHeavy =
    (summary.airnow === "http_429" ||
      summary.airnow === "http_403" ||
      summary.airnow === "circuit_open") &&
    (summary.purpleair === "http_429" ||
      summary.purpleair === "http_403" ||
      summary.purpleair === "circuit_open" ||
      summary.purpleair === "unconfigured") &&
    aqi == null;

  if (blockedHeavy) {
    const stale = await readSoftStaleForecastCache(admin, query);
    if (stale) {
      return jsonResponse({
        ...stale,
        data_source_summary: {
          ...(stale.data_source_summary ?? {}),
          ...summary,
          soft_stale: "upstream_blocked",
        },
      });
    }
  }

  trapLevel = applyFreightWeight(trapLevel, nearFreight);

  const aggregated = aggregateRiskScores({
    flashFloodActive,
    aqi,
    trapLevel,
    pollenUpi,
  });

  const degraded = isDegraded(summary, aqi);

  const njdotApplied = inNewJersey && nearFreight;
  const snapshot: EnvironmentSnapshot = {
    ...aggregated,
    geohash,
    aqi_epa: aqi,
    aqi_source: aqiSource,
    pm25,
    local_pm25: localPm25,
    trap_level: trapLevel,
    trap_near_freight_weight: nearFreight,
    pollen_upi: pollenUpi,
    dominant_pollen_type: dominantPollen,
    has_flash_flood_warning: flashFloodActive,
    flood_alert_headline: floodHeadline,
    usgs_stream_rate_ft_hr: streamRate,
    data_source_summary: summary,
    source_coverage: {
      njdot: {
        scope: "NJ_ONLY",
        applied: njdotApplied,
        reason: !inNewJersey
          ? "outside_nj"
          : nearFreight
          ? "freight_aadt_weight"
          : "no_nearby_freight_count",
      },
    },
    from_cache: false,
    from_stale_cache: false,
    degraded,
    pollen_fetched_at: pollenFetchedAt,
  };

  const forecastId = await writeForecastCache(admin, query, snapshot);

  return jsonResponse({
    ...snapshot,
    forecast_id: forecastId ?? undefined,
  });
});

/* Deploy / invoke:
   supabase functions deploy calculate-environment-risk
   POST /functions/v1/calculate-environment-risk
   Authorization: Bearer <user JWT>  (anon key alone → 401)
   Body: { "latitude": 40.7357, "longitude": -74.1724 }
*/
