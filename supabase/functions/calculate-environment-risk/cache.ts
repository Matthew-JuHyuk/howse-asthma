import { encodeGeohash } from "../_shared/geohash.ts";
import {
  CACHE_TTL,
  type EnvironmentSnapshot,
  type LocationQuery,
} from "../_shared/types.ts";

// Minimal client surface used by cache (service_role).
// deno-lint-ignore no-explicit-any
type Admin = { from: (table: string) => any };

function rowToSnapshot(
  row: Record<string, unknown>,
  opts?: { from_stale_cache?: boolean },
): EnvironmentSnapshot {
  const triggersRaw = (row.raw_response as {
    triggers?: EnvironmentSnapshot["triggers"];
  } | null)?.triggers;
  const raw = row.raw_response as {
    data_source_summary?: Record<string, string>;
    source_coverage?: EnvironmentSnapshot["source_coverage"];
    pollen_fetched_at?: string;
    degraded?: boolean;
  } | null;

  return {
    risk_score: row.risk_score as 1 | 2 | 3 | 4,
    ui_state: row.ui_state as EnvironmentSnapshot["ui_state"],
    triggers: triggersRaw ?? {
      flash_flood: Boolean(row.has_flash_flood_warning),
      air_quality: Number(row.aqi_epa ?? 0) > 50,
      pollen: Number(row.pollen_upi ?? 0) >= 3,
      smoke_trap: row.trap_level === "HIGH" || row.trap_level === "CRITICAL",
    },
    forecast_id: row.id as string | undefined,
    geohash: row.geohash as string,
    aqi_epa: row.aqi_epa as number | null,
    aqi_source: row.aqi_source as string | null,
    pm25: row.pm25 != null ? Number(row.pm25) : null,
    local_pm25: row.local_pm25 != null ? Number(row.local_pm25) : null,
    trap_level: row.trap_level as EnvironmentSnapshot["trap_level"],
    trap_near_freight_weight: Boolean(row.trap_near_freight_weight),
    pollen_upi: row.pollen_upi != null ? Number(row.pollen_upi) : null,
    dominant_pollen_type: row.dominant_pollen_type as string | null,
    has_flash_flood_warning: Boolean(row.has_flash_flood_warning),
    flood_alert_headline: row.flood_alert_headline as string | null,
    usgs_stream_rate_ft_hr: row.usgs_stream_rate_ft_hr != null
      ? Number(row.usgs_stream_rate_ft_hr)
      : null,
    data_source_summary: raw?.data_source_summary,
    source_coverage: raw?.source_coverage,
    from_cache: true,
    from_stale_cache: opts?.from_stale_cache ?? false,
    degraded: Boolean(raw?.degraded) || Boolean(opts?.from_stale_cache),
    pollen_fetched_at: raw?.pollen_fetched_at ?? null,
  };
}

/** Latest non-expired forecast for geohash, or null. */
export async function readForecastCache(
  admin: Admin,
  query: LocationQuery,
): Promise<EnvironmentSnapshot | null> {
  const geohash = encodeGeohash(query.latitude, query.longitude, 5);
  const now = new Date().toISOString();
  const { data, error } = await admin
    .from("environment_forecasts")
    .select("*")
    .eq("geohash", geohash)
    .gt("expires_at", now)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  if (error) {
    console.error("[cache] read error", error.message);
    return null;
  }
  if (!data) return null;
  return rowToSnapshot(data as Record<string, unknown>);
}

/**
 * Expired but recent forecast — used when live APIs are blocked, circuit-open,
 * or the caller is rate-limited on a cold path.
 */
export async function readSoftStaleForecastCache(
  admin: Admin,
  query: LocationQuery,
): Promise<EnvironmentSnapshot | null> {
  const geohash = encodeGeohash(query.latitude, query.longitude, 5);
  const nowMs = Date.now();
  const softCutoff = new Date(
    nowMs - CACHE_TTL.softStaleMinutes * 60_000,
  ).toISOString();
  const nowIso = new Date(nowMs).toISOString();

  const { data, error } = await admin
    .from("environment_forecasts")
    .select("*")
    .eq("geohash", geohash)
    .gte("created_at", softCutoff)
    .lte("expires_at", nowIso)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  if (error) {
    console.error("[cache] soft-stale read error", error.message);
    return null;
  }
  if (!data) return null;
  return rowToSnapshot(data as Record<string, unknown>, {
    from_stale_cache: true,
  });
}

/**
 * Recent pollen fields for geohash within pollen TTL (even if AQ cache expired).
 * Used to skip Google Pollen API calls (6h).
 */
export async function readRecentPollen(
  admin: Admin,
  query: LocationQuery,
): Promise<
  { pollen_upi: number | null; dominant: string | null; fetched_at: string } | null
> {
  const geohash = encodeGeohash(query.latitude, query.longitude, 5);
  const cutoff = new Date(
    Date.now() - CACHE_TTL.pollenMinutes * 60_000,
  ).toISOString();

  const { data, error } = await admin
    .from("environment_forecasts")
    .select("pollen_upi, dominant_pollen_type, created_at, raw_response")
    .eq("geohash", geohash)
    .gte("created_at", cutoff)
    .not("pollen_upi", "is", null)
    .order("created_at", { ascending: false })
    .limit(1)
    .maybeSingle();

  if (error || !data) return null;
  const fetchedAt =
    (data.raw_response as { pollen_fetched_at?: string } | null)
      ?.pollen_fetched_at ?? (data.created_at as string);
  return {
    pollen_upi: data.pollen_upi != null ? Number(data.pollen_upi) : null,
    dominant: (data.dominant_pollen_type as string) ?? null,
    fetched_at: fetchedAt,
  };
}

export async function writeForecastCache(
  admin: Admin,
  query: LocationQuery,
  snapshot: EnvironmentSnapshot,
): Promise<string | null> {
  const geohash = encodeGeohash(query.latitude, query.longitude, 5);
  const ttlMin = snapshot.has_flash_flood_warning
    ? CACHE_TTL.flashFloodMinutes
    : CACHE_TTL.defaultMinutes;
  const expiresAt = new Date(Date.now() + ttlMin * 60_000).toISOString();

  const { data, error } = await admin.from("environment_forecasts").insert({
    geohash,
    latitude: query.latitude,
    longitude: query.longitude,
    risk_score: snapshot.risk_score,
    ui_state: snapshot.ui_state,
    aqi_epa: snapshot.aqi_epa ?? null,
    pm25: snapshot.pm25 ?? null,
    aqi_source: snapshot.aqi_source ?? null,
    local_pm25: snapshot.local_pm25 ?? null,
    trap_level: snapshot.trap_level ?? null,
    trap_near_freight_weight: snapshot.trap_near_freight_weight ?? false,
    has_flash_flood_warning: snapshot.has_flash_flood_warning ?? false,
    flood_alert_headline: snapshot.flood_alert_headline ?? null,
    usgs_stream_rate_ft_hr: snapshot.usgs_stream_rate_ft_hr ?? null,
    pollen_upi: snapshot.pollen_upi ?? null,
    dominant_pollen_type: snapshot.dominant_pollen_type ?? null,
    pollen_forecast_days: 2,
    expires_at: expiresAt,
    raw_response: {
      triggers: snapshot.triggers,
      data_source_summary: snapshot.data_source_summary,
      source_coverage: snapshot.source_coverage,
      pollen_fetched_at: snapshot.pollen_fetched_at,
      degraded: snapshot.degraded ?? false,
    },
  }).select("id").single();

  if (error) {
    console.error("[cache] write error", error.message);
    return null;
  }
  return (data?.id as string | undefined) ?? null;
}
