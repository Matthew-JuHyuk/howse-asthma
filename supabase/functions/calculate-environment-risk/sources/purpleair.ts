import { optionalEnv } from "../../_shared/env.ts";
import type { LocationQuery, SourceResult, TrapLevel } from "../../_shared/types.ts";

/** PurpleAir TRAP proxy — Points-saving rules in env-api-integration.md 2.2.2. */
export async function fetchPurpleAir(
  query: LocationQuery,
): Promise<SourceResult<{ local_pm25?: number; trap_level?: TrapLevel }>> {
  const key = optionalEnv("PURPLEAIR_READ_KEY");
  if (!key) {
    return { source: "purpleair", ok: false, error: "PURPLEAIR_READ_KEY not set" };
  }
  // TODO(Phase 3): /v1/sensors bbox + minimal fields + modified_since
  void query;
  return { source: "purpleair", ok: true, data: { trap_level: "LOW" } };
}
