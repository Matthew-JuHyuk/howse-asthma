/** Shared types for environment Edge Functions. */

export type LocationQuery = {
  latitude: number;
  longitude: number;
};

export type TrapLevel = "LOW" | "MODERATE" | "HIGH" | "CRITICAL";

export type UiState = "CALM" | "CAUTION" | "WARNING" | "EMERGENCY";

export type EnvironmentTriggers = {
  flash_flood: boolean;
  air_quality: boolean;
  pollen: boolean;
  smoke_trap: boolean;
};

export type SourceCoverageEntry = {
  /** e.g. NJ_ONLY — UI must show state-limited notice when not applied. */
  scope: "NJ_ONLY" | "US" | "GLOBAL";
  applied: boolean;
  reason?: string;
};

export type ForecastPeriodPoint = {
  period: "morning" | "afternoon" | "evening";
  us_aqi?: number | null;
  pollen_upi?: number | null;
  trap_level?: TrapLevel | null;
  flood_active?: boolean;
};

export type ForecastDayPoint = {
  date: string;
  periods: ForecastPeriodPoint[];
  pollen_upi?: number | null;
  dominant_pollen_type?: string | null;
  us_aqi_max?: number | null;
  composite_score?: 1 | 2 | 3 | 4;
};

export type EnvironmentSnapshot = {
  risk_score: 1 | 2 | 3 | 4;
  ui_state: UiState;
  triggers: EnvironmentTriggers;
  geohash?: string;
  /** Multi-day outlook for SCR-PAT-FORECAST (Open-Meteo periods + Google pollen). */
  forecast_points?: ForecastDayPoint[];
  aqi_epa?: number | null;
  aqi_source?: string | null;
  pm25?: number | null;
  local_pm25?: number | null;
  trap_level?: TrapLevel | null;
  trap_near_freight_weight?: boolean;
  pollen_upi?: number | null;
  dominant_pollen_type?: string | null;
  has_flash_flood_warning?: boolean;
  flood_alert_headline?: string | null;
  usgs_stream_rate_ft_hr?: number | null;
  data_source_summary?: Record<string, string>;
  /** Per-source coverage meta for UI badges (PAT-01 / 4.2a). */
  source_coverage?: Record<string, SourceCoverageEntry>;
  /** Row id in environment_forecasts when available. */
  forecast_id?: string;
  /** True when served from environment_forecasts cache. */
  from_cache?: boolean;
  /** True when served past TTL (soft stale) after upstream failures / rate limits. */
  from_stale_cache?: boolean;
  /** True when one or more live sources were skipped or failed (partial snapshot). */
  degraded?: boolean;
  /** ISO timestamp when pollen fields were last refreshed from Google. */
  pollen_fetched_at?: string | null;
};

export type SourceResult<T> = {
  source: string;
  ok: boolean;
  data?: T;
  error?: string;
};

export const CACHE_TTL = {
  defaultMinutes: 60,
  flashFloodMinutes: 5,
  pollenMinutes: 360,
  /** Serve expired rows up to this age when live APIs are blocked / rate-limited. */
  softStaleMinutes: 360,
} as const;
