import { optionalEnv } from "../../_shared/env.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

/** PAT-08 Google Pollen forecast:lookup — Geohash TTL 6h (Phase 3). */
export async function fetchGooglePollen(
  query: LocationQuery,
): Promise<SourceResult<{ pollen_upi?: number; dominant?: string }>> {
  const key = optionalEnv("GOOGLE_MAPS_API_KEY");
  if (!key) {
    return { source: "google_pollen", ok: false, error: "GOOGLE_MAPS_API_KEY not set" };
  }
  // TODO(Phase 3): GET pollen.googleapis.com/v1/forecast:lookup (no Heatmap)
  void query;
  return { source: "google_pollen", ok: true, data: {} };
}
