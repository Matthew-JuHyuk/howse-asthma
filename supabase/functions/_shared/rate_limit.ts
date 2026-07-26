import type { SupabaseClient } from "npm:@supabase/supabase-js@2";

const WINDOW_MS = 15 * 60_000;
const MAX_REQUESTS = 30;
const MAX_UNIQUE_GEOHASH = 20;

export type RateLimitResult =
  | { allowed: true }
  | { allowed: false; reason: "rate_limited" | "geohash_budget" };

/**
 * Per-user abuse controls for calculate-environment-risk cold paths.
 * Cache hits should not call this (or call with a lighter budget).
 */
export async function checkAndRecordEnvRiskRate(
  admin: SupabaseClient,
  userId: string,
  geohash: string,
): Promise<RateLimitResult> {
  const since = new Date(Date.now() - WINDOW_MS).toISOString();

  const { count: reqCount, error: cErr } = await admin
    .from("env_risk_rate_events")
    .select("id", { count: "exact", head: true })
    .eq("user_id", userId)
    .gte("created_at", since);

  if (cErr) {
    console.error("[rate] count failed", cErr.message);
    // Fail open lightly — still record
  } else if ((reqCount ?? 0) >= MAX_REQUESTS) {
    return { allowed: false, reason: "rate_limited" };
  }

  const { data: hashes, error: hErr } = await admin
    .from("env_risk_rate_events")
    .select("geohash")
    .eq("user_id", userId)
    .gte("created_at", since);

  if (!hErr && hashes) {
    const unique = new Set(hashes.map((r) => r.geohash as string));
    if (!unique.has(geohash) && unique.size >= MAX_UNIQUE_GEOHASH) {
      return { allowed: false, reason: "geohash_budget" };
    }
  }

  const { error: iErr } = await admin.from("env_risk_rate_events").insert({
    user_id: userId,
    geohash,
  });
  if (iErr) {
    console.error("[rate] insert failed", iErr.message);
  }

  return { allowed: true };
}
