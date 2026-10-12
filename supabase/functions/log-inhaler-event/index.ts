// Howse Asthma — log-inhaler-event (PAT-02)
// Actions: create (default) · update · void.
// Client may supply location, panic flag and patient-reported details only.
// Environmental snapshot fields are copied from server cache (never client-trusted).

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { encodeGeohash } from "../_shared/geohash.ts";
import { isInServiceArea } from "../_shared/geo_bounds.ts";
import { requireRole, requireUser } from "../_shared/user_client.ts";

const INPUT_MEANS = new Set(["tap", "panic", "voice"]);
const USE_REASONS = new Set(["symptoms", "before_activity", "other"]);
const MEDICATION_STATUSES = new Set(["identified", "not_identified"]);
const MAX_INHALER_LOGS_PER_HOUR = 60;
const MAX_BACKDATE_MS = 31 * 24 * 60 * 60_000;
const MAX_FUTURE_SKEW_MS = 5 * 60_000;
const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

const RETURN_COLUMNS =
  "id, recorded_at, is_panic, input_means, risk_level, ui_state, " +
  "environment_forecast_id, medication_label, medication_status, puff_count, " +
  "use_reason, note, source_language, tz_offset_minutes, client_request_id, " +
  "voided_at, updated_at";

type Details = Record<string, unknown>;

/** Validates optional patient-reported fields. Returns error code or parsed values. */
function parseDetails(body: Record<string, unknown>): Details | string {
  const out: Details = {};

  if ("medication_status" in body) {
    const s = body.medication_status;
    if (s != null && (typeof s !== "string" || !MEDICATION_STATUSES.has(s))) {
      return "invalid_medication_status";
    }
    out.medication_status = s ?? null;
  }
  if ("medication_label" in body) {
    const label = body.medication_label;
    if (label != null) {
      if (typeof label !== "string") return "invalid_medication_label";
      const trimmed = label.trim();
      if (trimmed.length === 0 || trimmed.length > 120) {
        return "invalid_medication_label";
      }
      out.medication_label = trimmed;
    } else {
      out.medication_label = null;
    }
  }
  if (out.medication_status === "not_identified") {
    out.medication_label = null;
  }
  if ("puff_count" in body) {
    const n = body.puff_count;
    if (n != null && (!Number.isInteger(n) || (n as number) < 1 || (n as number) > 20)) {
      return "invalid_puff_count";
    }
    out.puff_count = n ?? null;
  }
  if ("use_reason" in body) {
    const r = body.use_reason;
    if (r != null && (typeof r !== "string" || !USE_REASONS.has(r))) {
      return "invalid_use_reason";
    }
    out.use_reason = r ?? null;
  }
  if ("note" in body) {
    const note = body.note;
    if (note != null) {
      if (typeof note !== "string" || note.length > 1000) return "invalid_note";
      out.note = note.trim().length === 0 ? null : note;
    } else {
      out.note = null;
    }
  }
  if ("source_language" in body) {
    const lang = body.source_language;
    if (lang != null && (typeof lang !== "string" || !/^[a-z]{2}(-[A-Za-z]{2,4})?$/.test(lang))) {
      return "invalid_source_language";
    }
    out.source_language = lang ?? null;
  }
  if ("tz_offset_minutes" in body) {
    const tz = body.tz_offset_minutes;
    if (tz != null && (!Number.isInteger(tz) || (tz as number) < -840 || (tz as number) > 840)) {
      return "invalid_tz_offset";
    }
    out.tz_offset_minutes = tz ?? null;
  }
  if ("recorded_at" in body && body.recorded_at != null) {
    if (typeof body.recorded_at !== "string") return "invalid_recorded_at";
    const ms = Date.parse(body.recorded_at);
    const now = Date.now();
    if (
      !Number.isFinite(ms) || ms > now + MAX_FUTURE_SKEW_MS ||
      ms < now - MAX_BACKDATE_MS
    ) {
      return "invalid_recorded_at";
    }
    out.recorded_at = new Date(ms).toISOString();
  }
  return out;
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

  let body: Record<string, unknown>;
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "invalid_body" }, 400);
  }

  const action = typeof body.action === "string" ? body.action : "create";

  if (action === "update" || action === "void") {
    const id = body.id;
    if (typeof id !== "string" || !UUID_RE.test(id)) {
      return jsonResponse({ error: "invalid_id" }, 400);
    }
    const { data: existing, error: findErr } = await admin
      .from("inhaler_events")
      .select("id, voided_at")
      .eq("id", id)
      .eq("patient_id", user.id)
      .maybeSingle();
    if (findErr) return jsonResponse({ error: "lookup_failed" }, 503);
    if (!existing) return jsonResponse({ error: "not_found" }, 404);

    const nowIso = new Date().toISOString();
    let patch: Details;
    if (action === "void") {
      if (existing.voided_at) {
        return jsonResponse({ event: existing, already_voided: true });
      }
      patch = { voided_at: nowIso, updated_at: nowIso };
    } else {
      if (existing.voided_at) return jsonResponse({ error: "voided" }, 409);
      const parsed = parseDetails(body);
      if (typeof parsed === "string") return jsonResponse({ error: parsed }, 400);
      patch = { ...parsed, updated_at: nowIso };
    }

    const { data: updated, error: updErr } = await admin
      .from("inhaler_events")
      .update(patch)
      .eq("id", id)
      .eq("patient_id", user.id)
      .select(RETURN_COLUMNS)
      .single();
    if (updErr) {
      console.error("[log-inhaler-event] update", updErr.message);
      return jsonResponse({ error: "update_failed" }, 500);
    }
    return jsonResponse({ event: updated });
  }

  if (action !== "create") {
    return jsonResponse({ error: "invalid_action" }, 400);
  }

  const clientRequestId = body.client_request_id;
  if (clientRequestId != null) {
    if (typeof clientRequestId !== "string" || !UUID_RE.test(clientRequestId)) {
      return jsonResponse({ error: "invalid_client_request_id" }, 400);
    }
    const { data: dup } = await admin
      .from("inhaler_events")
      .select(RETURN_COLUMNS)
      .eq("patient_id", user.id)
      .eq("client_request_id", clientRequestId)
      .maybeSingle();
    if (dup) return jsonResponse({ event: dup, duplicate: true });
  }

  const hourAgo = new Date(Date.now() - 60 * 60_000).toISOString();
  const { count: recentLogs, error: rateErr } = await admin
    .from("inhaler_events")
    .select("id", { count: "exact", head: true })
    .eq("patient_id", user.id)
    .gte("recorded_at", hourAgo);
  if (rateErr) {
    return jsonResponse({ error: "rate_check_failed" }, 503);
  }
  if ((recentLogs ?? 0) >= MAX_INHALER_LOGS_PER_HOUR) {
    return jsonResponse({ error: "rate_limited" }, 429);
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

  const details = parseDetails(body);
  if (typeof details === "string") return jsonResponse({ error: details }, 400);

  let envFields: Record<string, unknown> = {};
  // Do not attach the current cache to a back-dated entry.
  const eventIso = typeof details.recorded_at === "string"
    ? details.recorded_at
    : new Date().toISOString();
  const eventMs = Date.parse(eventIso);
  const envWindowMs = 20 * 60_000;
  const eventIsNow = Number.isFinite(eventMs) &&
    Math.abs(Date.now() - eventMs) <= envWindowMs;
  if (latitude != null && longitude != null && eventIsNow) {
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
      if (Number.isFinite(createdMs) && Math.abs(eventMs - createdMs) <= envWindowMs) {
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
      client_request_id: clientRequestId ?? null,
      ...details,
      ...envFields,
    })
    .select(RETURN_COLUMNS)
    .single();

  if (error) {
    // Concurrent retry with the same key lost the race — return the winner.
    if (clientRequestId != null && error.code === "23505") {
      const { data: dup } = await admin
        .from("inhaler_events")
        .select(RETURN_COLUMNS)
        .eq("patient_id", user.id)
        .eq("client_request_id", clientRequestId)
        .maybeSingle();
      if (dup) return jsonResponse({ event: dup, duplicate: true });
    }
    console.error("[log-inhaler-event]", error.message);
    return jsonResponse({ error: "insert_failed" }, 500);
  }

  return jsonResponse({ event: inserted });
});
