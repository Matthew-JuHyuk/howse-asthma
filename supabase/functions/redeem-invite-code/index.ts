// Patient redeems an 8-character invite via atomic SECURITY DEFINER RPC.

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { requireRole, requireUser } from "../_shared/user_client.ts";

function mapRpcError(message: string | undefined): Response {
  const m = (message ?? "").toLowerCase();
  if (m.includes("rate_limited")) {
    return jsonResponse({ error: "rate_limited" }, 429);
  }
  if (m.includes("care_link_exists")) {
    return jsonResponse({ error: "conflict" }, 409);
  }
  if (m.includes("forbidden")) {
    return jsonResponse({ error: "forbidden" }, 403);
  }
  // Uniform oracle: invalid / expired / used → same response.
  return jsonResponse({ error: "invite_invalid" }, 400);
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

  const isPatient = await requireRole(admin, user.id, "PATIENT");
  if (!isPatient) {
    return jsonResponse({ error: "forbidden" }, 403);
  }

  let body: { code?: string };
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "invalid_body" }, 400);
  }

  const code = (body.code ?? "").trim().toUpperCase();
  if (!/^[A-Z0-9]{8}$/.test(code)) {
    return jsonResponse({ error: "invite_invalid" }, 400);
  }

  const { data, error } = await admin.rpc("redeem_invite_code_as", {
    p_patient_id: user.id,
    p_code: code,
  });

  if (error) {
    console.error("redeem-invite-code rpc failed", error.message);
    return mapRpcError(error.message);
  }

  return jsonResponse({ link: data });
});
