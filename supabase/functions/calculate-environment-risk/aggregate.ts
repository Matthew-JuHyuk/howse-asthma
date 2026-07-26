import type {
  EnvironmentSnapshot,
  EnvironmentTriggers,
  TrapLevel,
  UiState,
} from "../_shared/types.ts";

/**
 * Risk aggregation (env-api-integration §4.2).
 * TRAP levels use MODERATE (schema) for the medium band.
 */
export function aggregateRiskScores(input: {
  flashFloodActive: boolean;
  aqi?: number | null;
  trapLevel?: TrapLevel | null;
  pollenUpi?: number | null;
}): Pick<EnvironmentSnapshot, "risk_score" | "ui_state" | "triggers"> {
  const aqi = input.aqi ?? 0;
  const trap = input.trapLevel ?? "LOW";
  const pollen = input.pollenUpi ?? 0;

  let score: 1 | 2 | 3 | 4 = 1;

  if (input.flashFloodActive) {
    score = 4;
  } else if (aqi > 150 || trap === "CRITICAL") {
    score = 4;
  } else if (aqi > 100 || trap === "HIGH" || pollen >= 3) {
    score = 3;
  } else if (aqi > 50 || trap === "MODERATE") {
    score = 2;
  }

  // Doc draft maps UPI 4–5 toward higher risk when flood/AQI not already maxed.
  if (!input.flashFloodActive && pollen >= 4 && score < 4) {
    score = 4;
  }

  const triggers: EnvironmentTriggers = {
    flash_flood: input.flashFloodActive,
    air_quality: aqi > 50,
    pollen: pollen >= 3,
    smoke_trap: trap === "HIGH" || trap === "CRITICAL",
  };

  return {
    risk_score: score,
    ui_state: scoreToUiState(score),
    triggers,
  };
}

export function scoreToUiState(score: 1 | 2 | 3 | 4): UiState {
  switch (score) {
    case 1:
      return "CALM";
    case 2:
      return "CAUTION";
    case 3:
      return "WARNING";
    case 4:
      return "EMERGENCY";
  }
}

/** Soft freight weight: bump LOW→MODERATE when near high AADT. */
export function applyFreightWeight(
  trap: TrapLevel | null,
  nearFreight: boolean,
): TrapLevel {
  const base = trap ?? "LOW";
  if (!nearFreight) return base;
  if (base === "LOW") return "MODERATE";
  return base;
}
