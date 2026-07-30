/**
 * Ventilation / fresh-air eligibility (must match Flutter `_canSuggestVentilation`).
 * Server-authoritative — never trust client for FCM.
 */

export type VentilationForecastFields = {
  risk_score?: number | null;
  aqi_epa?: number | null;
  pollen_upi?: number | null;
  trap_level?: string | null;
  has_flash_flood_warning?: boolean | null;
  raw_response?: {
    mold_score?: number | null;
  } | null;
};

export function canSuggestVentilation(
  row: VentilationForecastFields,
): boolean {
  if (row.has_flash_flood_warning === true) return false;
  const mold = Number(row.raw_response?.mold_score ?? 0);
  if (Number.isFinite(mold) && mold > 2) return false;
  const pollen = Number(row.pollen_upi ?? 0);
  if (Number.isFinite(pollen) && pollen > 2) return false;
  const trap = row.trap_level ?? null;
  if (trap === "HIGH" || trap === "CRITICAL") return false;
  const aqi = row.aqi_epa;
  if (aqi != null && Number.isFinite(Number(aqi)) && Number(aqi) > 50) {
    return false;
  }
  const risk = Number(row.risk_score);
  if (!Number.isFinite(risk) || risk >= 3) return false;
  return true;
}
