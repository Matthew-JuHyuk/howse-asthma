/**
 * Read Edge Function secrets. Never hardcode API keys in source.
 * Register with: `supabase secrets set KEY=value`
 */

export function requireEnv(name: string): string {
  const value = Deno.env.get(name);
  if (!value || value.trim() === "") {
    throw new Error(`Missing Edge Function secret: ${name}`);
  }
  return value;
}

export function optionalEnv(name: string): string | undefined {
  const value = Deno.env.get(name);
  if (!value || value.trim() === "") return undefined;
  return value;
}

/** Secrets expected for calculate-environment-risk. */
export const ENV_KEYS = {
  AIRNOW_API_KEY: "AIRNOW_API_KEY",
  PURPLEAIR_READ_KEY: "PURPLEAIR_READ_KEY",
  GOOGLE_MAPS_API_KEY: "GOOGLE_MAPS_API_KEY",
  NWS_USER_AGENT_CONTACT: "NWS_USER_AGENT_CONTACT",
  SUPABASE_URL: "SUPABASE_URL",
  SUPABASE_SERVICE_ROLE_KEY: "SUPABASE_SERVICE_ROLE_KEY",
} as const;
