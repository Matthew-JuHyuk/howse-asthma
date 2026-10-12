// Copies the current environment cache onto an event snapshot only when the
// event time is within 20 minutes of now and of the cache time.
// A past symptom never receives today's reading. Clients cannot send the values.

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { encodeGeohash } from "../_shared/geohash.ts";
import { isInServiceArea } from "../_shared/geo_bounds.ts";
import { requireRole, requireUser } from "../_shared/user_client.ts";

const WINDOW_MS = 20 * 60_000;
const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

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
  if (!await requireRole(admin, user.id, "PATIENT")) {
    return jsonResponse({ error: "forbidden" }, 403);
  }

  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "invalid_body" }, 400);
  }

  const snapshotId = body.snapshot_id;
  const occurredRaw = body.occurred_at;
  if (typeof snapshotId !== "string" || !UUID_RE.test(snapshotId)) {
    return jsonResponse({ error: "invalid_snapshot" }, 400);
  }
  if (typeof occurredRaw !== "string") {
    return jsonResponse({ error: "invalid_occurred_at" }, 400);
  }
  const occurredMs = Date.parse(occurredRaw);
  if (!Number.isFinite(occurredMs)) {
    return jsonResponse({ error: "invalid_occurred_at" }, 400);
  }

  const { data: snapshot, error: findErr } = await admin
    .from("environment_event_snapshots")
    .select("id, patient_id, status")
    .eq("id", snapshotId)
    .maybeSingle();
  if (findErr || !snapshot || snapshot.patient_id !== user.id) {
    return jsonResponse({ error: "not_found" }, 404);
  }

  const now = Date.now();
  const closeToNow = Math.abs(now - occurredMs) <= WINDOW_MS;
  const latitude = body.latitude == null ? null : Number(body.latitude);
  const longitude = body.longitude == null ? null : Number(body.longitude);
  const coordsOk = latitude != null &&
    longitude != null &&
    Number.isFinite(latitude) &&
    Number.isFinite(longitude) &&
    latitude >= -90 &&
    latitude <= 90 &&
    longitude >= -180 &&
    longitude <= 180 &&
    isInServiceArea(latitude, longitude);

  const markNoData = async () => {
    await admin.from("environment_event_snapshots").update({
      status: "no_data",
      data_kind: "unavailable",
      provider: null,
      numeric_value: null,
      aqi_value: null,
      pollen_upi: null,
      outdoor_humidity: null,
      event_time: new Date(occurredMs).toISOString(),
      rule_version: "s6-window-20m",
    }).eq("id", snapshotId);
    return jsonResponse({ status: "no_data" });
  };

  if (!closeToNow || !coordsOk) return await markNoData();

  const geohash = encodeGeohash(latitude!, longitude!, 5);
  const { data: forecast } = await admin
    .from("environment_forecasts")
    .select(
      "id, created_at, aqi_epa, aqi_source, pm25, pollen_upi, dominant_pollen_type, has_flash_flood_warning",
    )
    .eq("geohash", geohash)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  const createdMs = forecast ? Date.parse(forecast.created_at as string) : NaN;
  if (!forecast || !Number.isFinite(createdMs) || Math.abs(createdMs - occurredMs) > WINDOW_MS) {
    return await markNoData();
  }

  const source = typeof forecast.aqi_source === "string" ? forecast.aqi_source : "";
  const airNow = source.toLowerCase().includes("airnow");
  const dataKind = airNow ? "provisional" : "model";
  const provider = airNow
    ? "AirNow (provisional)"
    : (source || "environment cache");

  const { error: updErr } = await admin
    .from("environment_event_snapshots")
    .update({
      status: "linked",
      provider,
      source_ref: forecast.id,
      pollutant: forecast.pm25 == null ? null : "PM2.5",
      numeric_value: forecast.pm25,
      unit: forecast.pm25 == null ? null : "ug/m3",
      aqi_value: forecast.aqi_epa,
      aqi_framework: forecast.aqi_epa == null ? null : "US EPA AQI",
      observed_at: forecast.created_at,
      collected_at: new Date(now).toISOString(),
      event_time: new Date(occurredMs).toISOString(),
      delta_minutes: Math.round((createdMs - occurredMs) / 60000),
      data_kind: dataKind,
      location_basis: "current_fix",
      pollen_upi: forecast.pollen_upi,
      pollen_type: forecast.dominant_pollen_type,
      flood_alert: forecast.has_flash_flood_warning === true,
      rule_version: "s6-window-20m",
    })
    .eq("id", snapshotId);
  if (updErr) {
    console.error("[link-event-environment]", updErr.message);
    return jsonResponse({ error: "update_failed" }, 500);
  }
  return jsonResponse({ status: "linked" });
});
