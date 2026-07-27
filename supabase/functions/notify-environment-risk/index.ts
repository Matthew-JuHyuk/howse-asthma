// Howse Asthma — notify-environment-risk (PAT-04 / PAT-09 / PAT-10)
// Server-authoritative risk from environment_forecasts + FCM HTTP v1 (WBS 4.6a).

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { sendFcmToTokens } from "../_shared/fcm.ts";
import { encodeGeohash } from "../_shared/geohash.ts";
import { isInServiceArea } from "../_shared/geo_bounds.ts";
import { requireRole, requireUser } from "../_shared/user_client.ts";

const COOLDOWN_MINUTES = 60;
const GLOBAL_MAX_ALERTS_PER_HOUR = 3;

const TRIGGER_REASONS = new Set([
  "RISK_THRESHOLD",
  "LOCATION_ENTRY",
  "SAVED_LOCATION_CHANGE",
  "MANUAL",
]);

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

  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "invalid_body" }, 400);
  }

  const latitude = Number(body.latitude);
  const longitude = Number(body.longitude);
  const triggerReason = typeof body.trigger_reason === "string"
    ? body.trigger_reason
    : "RISK_THRESHOLD";

  if (!Number.isFinite(latitude) || !Number.isFinite(longitude)) {
    return jsonResponse({ error: "expected_latitude_longitude" }, 400);
  }
  if (!isInServiceArea(latitude, longitude)) {
    return jsonResponse({ error: "out_of_service_area" }, 400);
  }
  if (!TRIGGER_REASONS.has(triggerReason)) {
    return jsonResponse({ error: "invalid_trigger_reason" }, 400);
  }

  const { data: prefs } = await admin
    .from("notification_preferences")
    .select("push_risk_ge3, push_location_entry, push_saved_location_change")
    .eq("patient_id", user.id)
    .maybeSingle();

  if (prefs) {
    if (
      (triggerReason === "RISK_THRESHOLD" || triggerReason === "MANUAL") &&
      prefs.push_risk_ge3 === false
    ) {
      return jsonResponse({
        status: "skipped",
        reason: "push_risk_ge3_disabled",
        fcm_sent: false,
      });
    }
    if (
      triggerReason === "LOCATION_ENTRY" &&
      prefs.push_location_entry === false
    ) {
      return jsonResponse({
        status: "skipped",
        reason: "push_location_entry_disabled",
        fcm_sent: false,
      });
    }
    if (
      triggerReason === "SAVED_LOCATION_CHANGE" &&
      prefs.push_saved_location_change === false
    ) {
      return jsonResponse({
        status: "skipped",
        reason: "push_saved_location_change_disabled",
        fcm_sent: false,
      });
    }
  }

  const geohash = encodeGeohash(latitude, longitude, 5);
  const nowIso = new Date().toISOString();
  const hourAgo = new Date(Date.now() - 60 * 60_000).toISOString();

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

  const createdMs = Date.parse(forecast.created_at as string);
  const expiresMs = Date.parse(forecast.expires_at as string);
  const softStaleMs = 6 * 60 * 60_000;
  const fresh = Number.isFinite(expiresMs) && expiresMs > Date.now();
  const softOk = Number.isFinite(createdMs) &&
    Date.now() - createdMs <= softStaleMs;
  if (!fresh && !softOk) {
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

  const { count: globalCount } = await admin
    .from("environment_alerts_sent")
    .select("id", { count: "exact", head: true })
    .eq("patient_id", user.id)
    .gte("sent_at", hourAgo);

  if ((globalCount ?? 0) >= GLOBAL_MAX_ALERTS_PER_HOUR) {
    return jsonResponse({
      status: "rate_limited",
      reason: "patient_alert_budget",
      fcm_sent: false,
    });
  }

  // Dedup per patient + geohash (shared across trigger reasons — 5.7 hardening)
  const cooldownKey = `COMPOSITE:${geohash}`;

  const { data: claimed, error: claimErr } = await admin.rpc(
    "try_claim_alert_cooldown",
    {
      p_patient_id: user.id,
      p_cooldown_key: cooldownKey,
      p_minutes: COOLDOWN_MINUTES,
    },
  );
  if (claimErr) {
    console.error("[notify-environment-risk] claim", claimErr.message);
    return jsonResponse({ error: "cooldown_claim_failed" }, 503);
  }
  if (claimed !== true) {
    return jsonResponse({
      status: "cooldown",
      reason: "alert_cooldown_active",
      cooldown_minutes: COOLDOWN_MINUTES,
      fcm_sent: false,
    });
  }

  // History row (best-effort after atomic claim).
  const { data: inserted, error } = await admin
    .from("environment_alerts_sent")
    .insert({
      patient_id: user.id,
      alert_type: "COMPOSITE",
      trigger_reason: triggerReason,
      cooldown_key: cooldownKey,
      risk_level: Math.min(4, Math.max(1, Math.round(riskScore))),
      latitude,
      longitude,
      payload: {
        ui_state: uiState,
        forecast_id: forecast.id,
        server_authoritative: true,
        fcm_pending: true,
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

  const { data: tokenRows } = await admin
    .from("device_push_tokens")
    .select("id, fcm_token")
    .eq("profile_id", user.id);

  const fcm = await sendFcmToTokens(
    admin,
    (tokenRows ?? []) as Array<{ id: string; fcm_token: string }>,
    {
      alertId: inserted.id as string,
      riskScore: Math.min(4, Math.max(1, Math.round(riskScore))),
      uiState,
      triggerReason,
    },
  );

  const fcmSent = fcm.sent > 0;
  await admin
    .from("environment_alerts_sent")
    .update({
      payload: {
        ui_state: uiState,
        forecast_id: forecast.id,
        server_authoritative: true,
        fcm_pending: !fcmSent,
        fcm_sent: fcmSent,
        fcm_attempted: fcm.attempted,
        fcm_sent_count: fcm.sent,
        fcm_failed_count: fcm.failed,
        fcm_error: fcm.error ?? null,
        checked_at: nowIso,
      },
    })
    .eq("id", inserted.id);

  return jsonResponse({
    status: "recorded",
    alert_id: inserted.id,
    sent_at: inserted.sent_at,
    risk_score: riskScore,
    ui_state: uiState,
    trigger_reason: triggerReason,
    fcm_sent: fcmSent,
    fcm_pending: !fcmSent,
    fcm_attempted: fcm.attempted,
    fcm_sent_count: fcm.sent,
    fcm_failed_count: fcm.failed,
    fcm_error: fcm.error ?? null,
  });
});
