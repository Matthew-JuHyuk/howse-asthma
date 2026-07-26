import { createClient, type SupabaseClient, type User } from "npm:@supabase/supabase-js@2";

import { jsonResponse } from "./cors.ts";

export type AuthedClients = {
  user: User;
  userClient: SupabaseClient;
  admin: SupabaseClient;
};

/** Build user-scoped and service-role clients from the request JWT. */
export async function requireUser(
  req: Request,
): Promise<AuthedClients | Response> {
  const authHeader = req.headers.get("Authorization");
  if (!authHeader?.startsWith("Bearer ")) {
    return jsonResponse({ error: "Missing Authorization bearer token" }, 401);
  }

  const url = Deno.env.get("SUPABASE_URL");
  const anon = Deno.env.get("SUPABASE_ANON_KEY");
  const service = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
  if (!url || !anon || !service) {
    return jsonResponse({ error: "Server misconfigured" }, 500);
  }

  const userClient = createClient(url, anon, {
    global: { headers: { Authorization: authHeader } },
  });
  const { data, error } = await userClient.auth.getUser();
  if (error || !data.user) {
    return jsonResponse({ error: "Unauthorized" }, 401);
  }

  const admin = createClient(url, service);
  return { user: data.user, userClient, admin };
}

export async function requireRole(
  admin: SupabaseClient,
  userId: string,
  role: "PATIENT" | "PROVIDER",
): Promise<boolean> {
  const { data, error } = await admin
    .from("profiles")
    .select("role")
    .eq("id", userId)
    .maybeSingle();
  if (error || !data) return false;
  return data.role === role;
}
