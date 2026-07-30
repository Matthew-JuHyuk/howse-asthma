/**
 * Mold dampness index v0 (W3-1.4 / wbs3-decisions.md).
 * Outdoor proxy only — UI must disclose limitations.
 */

import type { TrapLevel } from "../_shared/types.ts";
import type { WeatherHour } from "./sources/open_meteo_weather.ts";

/** USGS stream rise (ft/hr) treated as elevated dampness factor. */
export const USGS_ELEVATED_FT_HR = 0.5;

export type MoldFactors = {
  h_wet_hours: number;
  rh80_streak_hours: number;
  flood_or_stream: boolean;
  rh_threshold_wet: number;
  rh_threshold_high: number;
};

export type MoldResult = {
  mold_score: 1 | 2 | 3 | 4;
  mold_level: TrapLevel;
  rh_pct?: number;
  dew_point_c?: number;
  temp_c?: number;
  h_wet_hours: number;
  factors: MoldFactors;
};

function scoreToLevel(score: 1 | 2 | 3 | 4): TrapLevel {
  switch (score) {
    case 1:
      return "LOW";
    case 2:
      return "MODERATE";
    case 3:
      return "HIGH";
    case 4:
      return "CRITICAL";
  }
}

/**
 * Compute mold axis from last ~24h of hourly RH (+ flood/USGS flag).
 */
export function computeMoldIndex(input: {
  hours: WeatherHour[];
  current_rh?: number;
  current_dew_c?: number;
  current_temp_c?: number;
  flashFloodActive: boolean;
  usgsStreamRateFtHr?: number | null;
}): MoldResult {
  const now = Date.now();
  const windowStart = now - 24 * 60 * 60 * 1000;
  const recent = input.hours.filter((h) => {
    const t = Date.parse(h.time);
    return Number.isFinite(t) && t >= windowStart && t <= now + 60 * 60 * 1000;
  });

  let hWet = 0;
  let maxRh80Streak = 0;
  let streak = 0;
  for (const h of recent) {
    const rh = h.rh;
    if (rh == null) {
      streak = 0;
      continue;
    }
    if (rh >= 70) hWet += 1;
    if (rh >= 80) {
      streak += 1;
      if (streak > maxRh80Streak) maxRh80Streak = streak;
    } else {
      streak = 0;
    }
  }

  const streamElevated =
    input.usgsStreamRateFtHr != null &&
    Number.isFinite(input.usgsStreamRateFtHr) &&
    input.usgsStreamRateFtHr >= USGS_ELEVATED_FT_HR;
  const floodOrStream = Boolean(input.flashFloodActive || streamElevated);

  let score = 1;
  if (hWet >= 12) score += 2;
  else if (hWet >= 6) score += 1;
  if (maxRh80Streak >= 3) score += 1;
  if (floodOrStream) score += 1;
  if (score > 4) score = 4;
  const moldScore = score as 1 | 2 | 3 | 4;

  return {
    mold_score: moldScore,
    mold_level: scoreToLevel(moldScore),
    rh_pct: input.current_rh,
    dew_point_c: input.current_dew_c,
    temp_c: input.current_temp_c,
    h_wet_hours: hWet,
    factors: {
      h_wet_hours: hWet,
      rh80_streak_hours: maxRh80Streak,
      flood_or_stream: floodOrStream,
      rh_threshold_wet: 70,
      rh_threshold_high: 80,
    },
  };
}

/**
 * Merge mold into composite: flood still 4; mold alone caps at WARNING (3).
 */
export function applyMoldToComposite(
  baseScore: 1 | 2 | 3 | 4,
  moldScore: 1 | 2 | 3 | 4,
  flashFloodActive: boolean,
): 1 | 2 | 3 | 4 {
  if (flashFloodActive) return 4;
  const moldCap = Math.min(moldScore, 3) as 1 | 2 | 3;
  return Math.max(baseScore, moldCap) as 1 | 2 | 3 | 4;
}
