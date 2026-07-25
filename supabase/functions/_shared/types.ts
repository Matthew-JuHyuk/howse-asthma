/** Shared types for environment Edge Functions (env-api-integration.md §4.2). */

export type LocationQuery = {
  latitude: number;
  longitude: number;
  /** Optional patient id for alert cooldown / personalization (Phase 5). */
  patient_id?: string;
};

export type TrapLevel = "LOW" | "MODERATE" | "HIGH" | "CRITICAL";

export type UiState = "CALM" | "CAUTION" | "WARNING" | "EMERGENCY";

export type EnvironmentTriggers = {
  flash_flood: boolean;
  air_quality: boolean;
  pollen: boolean;
  smoke_trap: boolean;
};

export type EnvironmentSnapshot = {
  risk_score: 1 | 2 | 3 | 4;
  ui_state: UiState;
  triggers: EnvironmentTriggers;
  geohash?: string;
  aqi_epa?: number | null;
  pm25?: number | null;
  local_pm25?: number | null;
  trap_level?: TrapLevel | null;
  pollen_upi?: number | null;
  has_flash_flood_warning?: boolean;
  data_source_summary?: Record<string, string>;
  /** True when served from environment_forecasts cache. */
  from_cache?: boolean;
};

export type SourceResult<T> = {
  source: string;
  ok: boolean;
  data?: T;
  error?: string;
};
