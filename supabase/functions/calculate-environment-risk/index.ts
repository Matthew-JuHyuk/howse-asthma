// Howse Asthma — calculate-environment-risk (hardened live sources + Geohash cache)

import { aggregateRiskScores, applyFreightWeight, scoreToUiState } from "./aggregate.ts";
import {
  applyMoldToComposite,
  computeMoldIndex,
} from "./mold_score.ts";
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
  ForecastDayPoint,
  LocationQuery,
  SourceResult,
  TrapLevel,
} from "../_shared/types.ts";
import { requireRole, requireUser } from "../_shared/user_client.ts";
import { fetchAirNow } from "./sources/airnow.ts";
import { fetchGooglePollen } from "./sources/google_pollen.ts";
import { fetchNwsAlerts } from "./sources/nws.ts";
import { queryNjdotNearbyAadt } from "./sources/njdot.ts";
import { fetchOpenMeteo } from "./sources/openmeteo.ts";
import { fetchOpenMeteoWeather } from "./sources/open_meteo_weather.ts";
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

  const isPatient = await requireRole(admin, user.id, "PATIENT");
  if (!isPatient) {
    return jsonResponse({ error: "forbidden" }, 403);
  }

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
    guardedSource(admin, "openmeteo_weather", () => fetchOpenMeteoWeather(query)),
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
  let nearestPurpleAirKm: number | null = null;
  let purpleAirSearchRadiusKm: number | null = null;
  let nearFreight = false;
  let streamRate: number | null = null;
  let openMeteoDaily: Array<{
    date: string;
    periods: Array<{ period: "morning" | "afternoon" | "evening"; us_aqi?: number }>;
    us_aqi_max?: number;
  }> = [];
  let pollenDaily: Array<{
    date?: string;
    pollen_upi?: number;
    dominant?: string;
  }> = [];
  let weatherHours: Array<{
    time: string;
    rh?: number;
    dew_c?: number;
    temp_c?: number;
  }> = [];
  let weatherRh: number | undefined;
  let weatherDew: number | undefined;
  let weatherTemp: number | undefined;

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
      const d = src.data as {
        us_aqi?: number;
        pm25?: number;
        daily?: typeof openMeteoDaily;
      };
      if (d.us_aqi != null) openMeteoAqi = d.us_aqi;
      if (d.pm25 != null && pm25 == null) pm25 = d.pm25;
      if (d.daily?.length) openMeteoDaily = d.daily;
    }
    if (src.source === "openmeteo_weather") {
      const d = src.data as {
        hours?: typeof weatherHours;
        current_rh?: number;
        current_dew_c?: number;
        current_temp_c?: number;
      };
      if (d.hours?.length) weatherHours = d.hours;
      weatherRh = d.current_rh;
      weatherDew = d.current_dew_c;
      weatherTemp = d.current_temp_c;
    }
    if (src.source === "purpleair") {
      const d = src.data as {
        local_pm25?: number;
        trap_level?: TrapLevel;
        approx_aqi?: number;
        nearest_purpleair_km?: number;
        purpleair_search_radius_km?: number;
      };
      if (d.local_pm25 != null) localPm25 = d.local_pm25;
      if (d.trap_level) trapLevel = d.trap_level;
      if (d.approx_aqi != null) purpleApproxAqi = d.approx_aqi;
      if (d.nearest_purpleair_km != null) {
        nearestPurpleAirKm = d.nearest_purpleair_km;
      }
      if (d.purpleair_search_radius_km != null) {
        purpleAirSearchRadiusKm = d.purpleair_search_radius_km;
      }
    }
    if (src.source === "google_pollen") {
      const d = src.data as {
        pollen_upi?: number;
        dominant?: string;
        daily?: typeof pollenDaily;
        from_pollen_cache?: boolean;
      };
      if (d.pollen_upi != null) pollenUpi = d.pollen_upi;
      if (d.dominant) dominantPollen = d.dominant;
      if (d.daily?.length) pollenDaily = d.daily;
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

  const mold = computeMoldIndex({
    hours: weatherHours,
    current_rh: weatherRh,
    current_dew_c: weatherDew,
    current_temp_c: weatherTemp,
    flashFloodActive,
    usgsStreamRateFtHr: streamRate,
  });

  const baseAgg = aggregateRiskScores({
    flashFloodActive,
    aqi,
    trapLevel,
    pollenUpi,
  });
  const mergedScore = applyMoldToComposite(
    baseAgg.risk_score,
    mold.mold_score,
    flashFloodActive,
  );
  const aggregated = {
    risk_score: mergedScore,
    ui_state: scoreToUiState(mergedScore),
    triggers: {
      ...baseAgg.triggers,
      mold: mold.mold_score >= 3,
    },
  };

  const degraded = isDegraded(summary, aqi);

  const njdotApplied = inNewJersey && nearFreight;

  // Build SCR-PAT-FORECAST series (OM periods + Google pollen days).
  const forecastPoints: ForecastDayPoint[] = [];
  const dates = new Set<string>();
  for (const d of openMeteoDaily) dates.add(d.date);
  for (const d of pollenDaily) if (d.date) dates.add(d.date);
  const today = new Date().toISOString().slice(0, 10);
  if (dates.size === 0) {
    dates.add(today);
  }
  const floodAnchorDate = openMeteoDaily[0]?.date ?? today;
  for (const date of [...dates].sort()) {
    const om = openMeteoDaily.find((d) => d.date === date);
    const pol = pollenDaily.find((d) => d.date === date);
    const dayPollen = pol?.pollen_upi ??
      (date === today || date === pollenDaily[0]?.date ? pollenUpi : null);
    const dayFlood = Boolean(flashFloodActive && date === floodAnchorDate);
    const dayMoldScore = date === today ? mold.mold_score : mold.mold_score;
    const periods = (om?.periods ?? [
      { period: "morning" as const },
      { period: "afternoon" as const },
      { period: "evening" as const },
    ]).map((p) => ({
      period: p.period,
      us_aqi: p.us_aqi ?? null,
      pollen_upi: dayPollen ?? null,
      trap_level: trapLevel,
      flood_active: dayFlood,
    }));
    const dayScore = aggregateRiskScores({
      flashFloodActive: dayFlood,
      aqi: om?.us_aqi_max ?? aqi,
      trapLevel,
      pollenUpi: dayPollen,
    });
    const dayMerged = applyMoldToComposite(
      dayScore.risk_score,
      dayMoldScore,
      dayFlood,
    );
    forecastPoints.push({
      date,
      periods,
      pollen_upi: dayPollen ?? null,
      dominant_pollen_type: pol?.dominant ?? dominantPollen,
      us_aqi_max: om?.us_aqi_max ?? null,
      composite_score: dayMerged,
      mold_score: dayMoldScore,
    });
  }

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
    forecast_points: forecastPoints.slice(0, 2),
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
    nearest_purpleair_km: nearestPurpleAirKm,
    purpleair_search_radius_km: purpleAirSearchRadiusKm,
    mold_score: mold.mold_score,
    mold_level: mold.mold_level,
    mold_rh_pct: mold.rh_pct ?? null,
    mold_dew_point_c: mold.dew_point_c ?? null,
    mold_temp_c: mold.temp_c ?? null,
    mold_h_wet_hours: mold.h_wet_hours,
    mold_factors: mold.factors,
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
