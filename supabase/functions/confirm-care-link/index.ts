// Confirm/reject a pending care link via atomic SECURITY DEFINER RPC.

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { requireUser } from "../_shared/user_client.ts";

const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

function mapRpcError(message: string | undefined): Response {
  const m = (message ?? "").toLowerCase();
  if (m.includes("forbidden")) {
    return jsonResponse({ error: "forbidden" }, 403);
  }
  if (m.includes("not_found")) {
    return jsonResponse({ error: "not_found" }, 404);
  }
  if (m.includes("not_pending") || m.includes("bad_action")) {
    return jsonResponse({ error: "conflict" }, 409);
  }
  return jsonResponse({ error: "server_error" }, 500);
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

  let body: { link_id?: string; action?: string };
  try {
    body = await req.json();
  } catch {
    return jsonResponse({ error: "invalid_body" }, 400);
  }

  const linkId = body.link_id?.trim() ?? "";
  const action = body.action?.trim() ?? "";
  if (!UUID_RE.test(linkId) || (action !== "confirm" && action !== "reject")) {
    return jsonResponse({ error: "invalid_body" }, 400);
  }

  const { data, error } = await admin.rpc("confirm_care_link_as", {
    p_actor_id: user.id,
    p_link_id: linkId,
    p_action: action,
  });

  if (error) {
    console.error("confirm-care-link rpc failed", error.message);
    return mapRpcError(error.message);
  }

  return jsonResponse({ link: data });
});
