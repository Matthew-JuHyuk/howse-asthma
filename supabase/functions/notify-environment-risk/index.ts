// Howse Asthma — notify-environment-risk (PAT-04 / WBS 4.6)
// Server-authoritative risk only (reads environment_forecasts). Client risk_score ignored.
// FCM send deferred until Firebase (WBS 4.6a).

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { encodeGeohash } from "../_shared/geohash.ts";
import { isInServiceArea } from "../_shared/geo_bounds.ts";
import { requireUser } from "../_shared/user_client.ts";

const COOLDOWN_MINUTES = 60;
/** Global per-patient cap (not only per-geohash) to stop geohash hopping. */
const GLOBAL_MAX_ALERTS_PER_HOUR = 3;

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

  const latitude = Number(body.latitude);
  const longitude = Number(body.longitude);

  if (!Number.isFinite(latitude) || !Number.isFinite(longitude)) {
    return jsonResponse({ error: "expected_latitude_longitude" }, 400);
  }
  if (!isInServiceArea(latitude, longitude)) {
    return jsonResponse({ error: "out_of_service_area" }, 400);
  }

  // Honor patient opt-out when prefs exist.
  const { data: prefs } = await admin
    .from("notification_preferences")
    .select("push_risk_ge3")
    .eq("patient_id", user.id)
    .maybeSingle();
  if (prefs && prefs.push_risk_ge3 === false) {
    return jsonResponse({
      status: "skipped",
      reason: "push_risk_ge3_disabled",
      fcm_sent: false,
    });
  }

  const geohash = encodeGeohash(latitude, longitude, 5);
  const nowIso = new Date().toISOString();
  const hourAgo = new Date(Date.now() - 60 * 60_000).toISOString();
  const cooldownSince = new Date(
    Date.now() - COOLDOWN_MINUTES * 60_000,
  ).toISOString();

  // Authoritative risk from server cache (ignore client risk_score / ui_state).
  const { data: forecast } = await admin
    .from("environment_forecasts")
    .select("id, risk_score, ui_state, expires_at, created_at")
    .eq("geohash", geohash)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  if (!forecast) {
    return jsonResponse({ error: "no_server_forecast" }, 409);
  }

  // Allow soft-stale up to 6h for notify decisions (matches env soft stale).
  const createdMs = Date.parse(forecast.created_at as string);
  const softStaleMs = 6 * 60 * 60_000;
  if (!Number.isFinite(createdMs) || Date.now() - createdMs > softStaleMs) {
    return jsonResponse({ error: "forecast_too_stale" }, 409);
  }

  const riskScore = Number(forecast.risk_score);
  const uiState = typeof forecast.ui_state === "string"
    ? forecast.ui_state
    : "WARNING";

  if (!Number.isFinite(riskScore) || riskScore < 3) {
    return jsonResponse({
      status: "skipped",
      reason: "risk_below_threshold",
      risk_score: riskScore,
      fcm_sent: false,
    });
  }

  // Global per-patient rate limit (geohash hopping resistant).
  const { count: globalCount } = await admin
    .from("environment_alerts_sent")
    .select("id", { count: "exact", head: true })
    .eq("patient_id", user.id)
    .eq("trigger_reason", "RISK_THRESHOLD")
    .gte("sent_at", hourAgo);

  if ((globalCount ?? 0) >= GLOBAL_MAX_ALERTS_PER_HOUR) {
    return jsonResponse({
      status: "rate_limited",
      reason: "patient_alert_budget",
      fcm_sent: false,
    });
  }

  const cooldownKey = `COMPOSITE:RISK_THRESHOLD:${geohash}`;
  const { data: recent } = await admin
    .from("environment_alerts_sent")
    .select("id, sent_at")
    .eq("patient_id", user.id)
    .eq("cooldown_key", cooldownKey)
    .gte("sent_at", cooldownSince)
    .limit(1)
    .maybeSingle();

  if (recent) {
    return jsonResponse({
      status: "cooldown",
      reason: "alert_cooldown_active",
      cooldown_minutes: COOLDOWN_MINUTES,
      fcm_sent: false,
      last_sent_at: recent.sent_at,
    });
  }

  const { data: inserted, error } = await admin
    .from("environment_alerts_sent")
    .insert({
      patient_id: user.id,
      alert_type: "COMPOSITE",
      trigger_reason: "RISK_THRESHOLD",
      cooldown_key: cooldownKey,
      risk_level: Math.min(4, Math.max(1, Math.round(riskScore))),
      latitude,
      longitude,
      payload: {
        ui_state: uiState,
        forecast_id: forecast.id,
        forecast_expires_at: forecast.expires_at,
        server_authoritative: true,
        fcm_pending: true,
        note: "FCM delivery requires Firebase (WBS 4.6a)",
        checked_at: nowIso,
      },
    })
    .select("id, sent_at")
    .single();

  if (error) {
    console.error("[notify-environment-risk]", error.message);
    return jsonResponse({ error: "insert_failed" }, 500);
  }

  await admin.from("notification_preferences").upsert({
    patient_id: user.id,
    last_alert_at: inserted.sent_at,
    updated_at: new Date().toISOString(),
  });

  return jsonResponse({
    status: "recorded",
    alert_id: inserted.id,
    sent_at: inserted.sent_at,
    risk_score: riskScore,
    ui_state: uiState,
    fcm_sent: false,
    fcm_pending: true,
  });
});
