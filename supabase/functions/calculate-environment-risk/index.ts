// Howse Asthma — calculate-environment-risk (WBS 1.6 skeleton)
// Spec: doc/env-api-integration.md §4.2, .cursor/rules/env-api-config.json
// Live API wiring: Phase 3. Secrets: WBS 1.7.

import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";

import { aggregateRiskScores } from "./aggregate.ts";
import { readForecastCache, writeForecastCache } from "./cache.ts";
import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { coarseCacheKey } from "../_shared/geohash.ts";
import type { LocationQuery, EnvironmentSnapshot } from "../_shared/types.ts";
import { fetchAirNow } from "./sources/airnow.ts";
import { fetchGooglePollen } from "./sources/google_pollen.ts";
import { fetchNwsAlerts } from "./sources/nws.ts";
import { queryNjdotNearbyAadt } from "./sources/njdot.ts";
import { fetchOpenMeteo } from "./sources/openmeteo.ts";
import { fetchPurpleAir } from "./sources/purpleair.ts";
import { fetchUsgs } from "./sources/usgs.ts";

function parseLocation(body: unknown): LocationQuery | null {
  if (!body || typeof body !== "object") return null;
  const b = body as Record<string, unknown>;
  const latitude = Number(b.latitude);
  const longitude = Number(b.longitude);
  if (!Number.isFinite(latitude) || !Number.isFinite(longitude)) return null;
  if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
    return null;
  }
  const patient_id = typeof b.patient_id === "string" ? b.patient_id : undefined;
  return { latitude, longitude, patient_id };
}

export default {
  fetch: withSupabase({ auth: ["publishable", "secret"] }, async (req, ctx) => {
    if (req.method === "OPTIONS") {
      return new Response("ok", { headers: corsHeaders });
    }

    if (req.method !== "POST") {
      return jsonResponse({ error: "Method not allowed" }, 405);
    }

    let body: unknown;
    try {
      body = await req.json();
    } catch {
      return jsonResponse({ error: "Invalid JSON body" }, 400);
    }

    const query = parseLocation(body);
    if (!query) {
      return jsonResponse(
        {
          error: "Expected { latitude, longitude }",
          skeleton: true,
        },
        400,
      );
    }

    // Cache (service role client available as ctx.supabaseAdmin when auth=secret)
    const admin = ctx.supabaseAdmin ?? ctx.supabase;
    const cached = await readForecastCache(admin, query);
    if (cached) {
      return jsonResponse(cached);
    }

    // Parallel source fetch — stubs until Phase 3
    const settled = await Promise.allSettled([
      fetchNwsAlerts(query),
      fetchAirNow(query),
      fetchPurpleAir(query),
      fetchOpenMeteo(query),
      fetchGooglePollen(query),
      fetchUsgs(query),
      queryNjdotNearbyAadt(query),
    ]);

    const summary: Record<string, string> = {};
    let flashFloodActive = false;
    let aqi: number | null = null;
    let trapLevel: "LOW" | "MODERATE" | "HIGH" | "CRITICAL" | null = "LOW";
    let pollenUpi: number | null = null;
    let pm25: number | null = null;
    let localPm25: number | null = null;

    for (const result of settled) {
      if (result.status !== "fulfilled") {
        summary.rejected = "promise_rejected";
        continue;
      }
      const src = result.value;
      summary[src.source] = src.ok ? "ok" : (src.error ?? "failed");
      if (!src.ok || !src.data) continue;

      if (src.source === "nws" && "flashFloodActive" in src.data) {
        flashFloodActive = Boolean(
          (src.data as { flashFloodActive: boolean }).flashFloodActive,
        );
      }
      if (src.source === "airnow") {
        const d = src.data as { aqi?: number; pm25?: number };
        if (d.aqi != null) aqi = d.aqi;
        if (d.pm25 != null) pm25 = d.pm25;
      }
      if (src.source === "openmeteo" && aqi == null) {
        const d = src.data as { us_aqi?: number; pm25?: number };
        if (d.us_aqi != null) aqi = d.us_aqi;
        if (d.pm25 != null && pm25 == null) pm25 = d.pm25;
      }
      if (src.source === "purpleair") {
        const d = src.data as {
          local_pm25?: number;
          trap_level?: "LOW" | "MODERATE" | "HIGH" | "CRITICAL";
        };
        if (d.local_pm25 != null) localPm25 = d.local_pm25;
        if (d.trap_level) trapLevel = d.trap_level;
      }
      if (src.source === "google_pollen") {
        const d = src.data as { pollen_upi?: number };
        if (d.pollen_upi != null) pollenUpi = d.pollen_upi;
      }
    }

    const aggregated = aggregateRiskScores({
      flashFloodActive,
      aqi,
      trapLevel,
      pollenUpi,
    });

    const snapshot: EnvironmentSnapshot = {
      ...aggregated,
      geohash: coarseCacheKey(query.latitude, query.longitude),
      aqi_epa: aqi,
      pm25,
      local_pm25: localPm25,
      trap_level: trapLevel,
      pollen_upi: pollenUpi,
      has_flash_flood_warning: flashFloodActive,
      data_source_summary: summary,
      from_cache: false,
    };

    await writeForecastCache(admin, query, snapshot);

    return jsonResponse({
      ...snapshot,
      skeleton: true,
      note: "WBS 1.6 skeleton — live API + DB cache in Phase 3; set secrets in WBS 1.7",
    });
  }),
};

/* Deploy / invoke (after 1.7 secrets):
   supabase functions deploy calculate-environment-risk
   POST /functions/v1/calculate-environment-risk
   Body: { "latitude": 40.7357, "longitude": -74.1724 }
*/
