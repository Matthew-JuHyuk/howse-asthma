// Howse Asthma — log-inhaler-event (PAT-02)
// Client may only supply lat/lon/is_panic/input_means.
// Environmental snapshot fields are copied from server cache (never client-trusted).

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { encodeGeohash } from "../_shared/geohash.ts";
import { isInServiceArea } from "../_shared/geo_bounds.ts";
import { requireUser } from "../_shared/user_client.ts";

const INPUT_MEANS = new Set(["tap", "panic", "voice"]);

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

  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "invalid_body" }, 400);
  }

  const latitude = body.latitude == null ? null : Number(body.latitude);
  const longitude = body.longitude == null ? null : Number(body.longitude);
  const isPanic = body.is_panic === true;
  let inputMeans = typeof body.input_means === "string"
    ? body.input_means
    : (isPanic ? "panic" : "tap");
  if (!INPUT_MEANS.has(inputMeans)) {
    return jsonResponse({ error: "invalid_input_means" }, 400);
  }
  if (isPanic) inputMeans = "panic";

  if (latitude != null || longitude != null) {
    if (
      !Number.isFinite(latitude) ||
      !Number.isFinite(longitude) ||
      latitude! < -90 ||
      latitude! > 90 ||
      longitude! < -180 ||
      longitude! > 180
    ) {
      return jsonResponse({ error: "invalid_coordinates" }, 400);
    }
    if (!isInServiceArea(latitude!, longitude!)) {
      return jsonResponse({ error: "out_of_service_area" }, 400);
    }
  }

  let envFields: Record<string, unknown> = {};
  if (latitude != null && longitude != null) {
    const geohash = encodeGeohash(latitude, longitude, 5);
    const { data: forecast } = await admin
      .from("environment_forecasts")
      .select(
        "id, risk_score, ui_state, pm25, local_pm25, has_flash_flood_warning, pollen_upi, raw_response, created_at",
      )
      .eq("geohash", geohash)
      .order("created_at", { ascending: false })
      .limit(1)
      .maybeSingle();

    if (forecast) {
      const createdMs = Date.parse(forecast.created_at as string);
      const softStaleMs = 6 * 60 * 60_000;
      if (Number.isFinite(createdMs) && Date.now() - createdMs <= softStaleMs) {
        const raw = forecast.raw_response as {
          data_source_summary?: Record<string, string>;
        } | null;
        envFields = {
          risk_level: forecast.risk_score,
          ui_state: forecast.ui_state,
          pm25_level: forecast.pm25,
          local_pm25_snapshot: forecast.local_pm25,
          flash_flood_alert_active: Boolean(forecast.has_flash_flood_warning),
          pollen_upi_snapshot: forecast.pollen_upi,
          environment_forecast_id: forecast.id,
          data_source_summary: raw?.data_source_summary ?? null,
        };
      }
    }
  }

  const { data: inserted, error } = await admin
    .from("inhaler_events")
    .insert({
      patient_id: user.id,
      latitude,
      longitude,
      is_panic: isPanic,
      input_means: inputMeans,
      ...envFields,
    })
    .select("id, recorded_at, is_panic, risk_level, ui_state, environment_forecast_id")
    .single();

  if (error) {
    console.error("[log-inhaler-event]", error.message);
    return jsonResponse({ error: "insert_failed" }, 500);
  }

  return jsonResponse({ event: inserted });
});
