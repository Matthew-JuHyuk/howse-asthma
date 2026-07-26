import { optionalEnv } from "../../_shared/env.ts";
import { fetchWithTimeout } from "../../_shared/http.ts";
import {
  errorFromCatch,
  errorFromHttpStatus,
} from "../../_shared/source_errors.ts";
import type { LocationQuery, SourceResult } from "../../_shared/types.ts";

function toUpi(day: Record<string, unknown>): number | undefined {
  const upi = day.upi as { value?: number } | undefined;
  if (upi?.value != null && Number.isFinite(upi.value)) {
    return Math.max(0, Math.min(5, Math.round(upi.value)));
  }
  const types = day.pollenTypeInfo as
    | Array<{ indexInfo?: { value?: number } }>
    | undefined;
  let max = -1;
  for (const t of types ?? []) {
    const v = t.indexInfo?.value;
    if (v != null && v > max) max = v;
  }
  if (max >= 0) return Math.max(0, Math.min(5, Math.round(max)));
  return undefined;
}

function dominantType(day: Record<string, unknown>): string | undefined {
  const types = day.pollenTypeInfo as
    | Array<{
      code?: string;
      displayName?: string;
      indexInfo?: { value?: number };
    }>
    | undefined;
  let best: { name: string; v: number } | undefined;
  for (const t of types ?? []) {
    const v = t.indexInfo?.value ?? -1;
    const name = t.displayName ?? t.code ?? "";
    if (!name) continue;
    if (!best || v > best.v) best = { name, v };
  }
  return best?.name;
}

/** Google Pollen forecast:lookup — Forecast only, no Heatmap. */
export async function fetchGooglePollen(
  query: LocationQuery,
): Promise<
  SourceResult<{ pollen_upi?: number; dominant?: string; httpStatus?: number }>
> {
  const key = optionalEnv("GOOGLE_MAPS_API_KEY");
  if (!key) {
    return { source: "google_pollen", ok: false, error: "unconfigured" };
  }

  const url = new URL("https://pollen.googleapis.com/v1/forecast:lookup");
  url.searchParams.set("key", key);
  url.searchParams.set("location.latitude", String(query.latitude));
  url.searchParams.set("location.longitude", String(query.longitude));
  url.searchParams.set("days", "2");
  url.searchParams.set("plantsDescription", "false");
  url.searchParams.set("languageCode", "en");

  try {
    const res = await fetchWithTimeout(url, {}, 4000);
    if (!res.ok) {
      return {
        source: "google_pollen",
        ok: false,
        error: errorFromHttpStatus(res.status),
        data: { httpStatus: res.status },
      };
    }
    const json = await res.json() as {
      dailyInfo?: Array<Record<string, unknown>>;
    };
    const today = json.dailyInfo?.[0];
    if (!today) {
      return { source: "google_pollen", ok: true, data: {} };
    }
    return {
      source: "google_pollen",
      ok: true,
      data: {
        pollen_upi: toUpi(today),
        dominant: dominantType(today),
      },
    };
  } catch (e) {
    return { source: "google_pollen", ok: false, error: errorFromCatch(e) };
  }
}
