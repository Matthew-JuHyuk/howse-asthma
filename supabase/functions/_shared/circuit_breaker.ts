import type { SupabaseClient } from "npm:@supabase/supabase-js@2";

const COOLDOWN_MS = 15 * 60_000;

/** Returns true if this source should be skipped (circuit open). */
export async function isCircuitOpen(
  admin: SupabaseClient,
  source: string,
): Promise<boolean> {
  const { data, error } = await admin
    .from("env_api_circuits")
    .select("open_until")
    .eq("source", source)
    .maybeSingle();
  if (error || !data?.open_until) return false;
  return new Date(data.open_until as string).getTime() > Date.now();
}

export async function tripCircuit(
  admin: SupabaseClient,
  source: string,
  httpStatus?: number,
): Promise<void> {
  const openUntil = new Date(Date.now() + COOLDOWN_MS).toISOString();
  const { error } = await admin.from("env_api_circuits").upsert({
    source,
    open_until: openUntil,
    last_status: httpStatus ?? null,
    updated_at: new Date().toISOString(),
  });
  if (error) {
    console.error("[circuit] trip failed", source, error.message);
  }
}
