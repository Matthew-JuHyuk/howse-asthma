// Issue an 8-char alphanumeric invite code (TTL 24h) for the signed-in provider.

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { requireRole, requireUser } from "../_shared/user_client.ts";

const MAX_ACTIVE_INVITES = 5;
const CODE_ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789"; // no 0/O/1/I

/** Unbiased 8-char code (Crockford-ish alphabet). */
function randomInviteCode(): string {
  const bytes = new Uint8Array(8);
  crypto.getRandomValues(bytes);
  let out = "";
  for (let i = 0; i < 8; i++) {
    out += CODE_ALPHABET[bytes[i]! % CODE_ALPHABET.length]!;
  }
  return out;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }
  if (req.method !== "POST") {
    return jsonResponse({ error: "method_not_allowed" }, 405);
  }

  const authed = await requireUser(req);
  if (authed instanceof Response) return authed;
  const { user, admin } = authed;

  const isProvider = await requireRole(admin, user.id, "PROVIDER");
  if (!isProvider) {
    return jsonResponse({ error: "forbidden" }, 403);
  }

  const nowIso = new Date().toISOString();
  const { count, error: countError } = await admin
    .from("invite_codes")
    .select("id", { count: "exact", head: true })
    .eq("provider_id", user.id)
    .is("consumed_at", null)
    .gt("expires_at", nowIso);

  if (countError) {
    console.error("issue-invite-code count failed", countError);
    return jsonResponse({ error: "server_error" }, 500);
  }
  if ((count ?? 0) >= MAX_ACTIVE_INVITES) {
    return jsonResponse({ error: "invite_limit" }, 429);
  }

  const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000).toISOString();

  for (let attempt = 0; attempt < 8; attempt++) {
    const code = randomInviteCode();
    const { data, error } = await admin
      .from("invite_codes")
      .insert({
        provider_id: user.id,
        code,
        expires_at: expiresAt,
      })
      .select("id, code, expires_at")
      .single();

    if (!error && data) {
      return jsonResponse({
        id: data.id,
        code: data.code,
        expires_at: data.expires_at,
      });
    }

    if (error?.code !== "23505") {
      console.error("issue-invite-code insert failed", error);
      return jsonResponse({ error: "server_error" }, 500);
    }
  }

  return jsonResponse({ error: "server_error" }, 500);
});
