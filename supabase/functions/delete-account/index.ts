// delete-account — removes the caller's own account.
// Storage files under "<uid>/" are removed first, then the auth user. Every
// profile-owned table cascades from auth.users -> profiles.
// POST { confirm: "DELETE" } with the user's JWT. Returns { deleted: true,
// storage_objects_removed } or a safe error code. Only the caller's own id is used.

import { corsHeaders, jsonResponse } from "../_shared/cors.ts";
import { requireUser } from "../_shared/user_client.ts";
import type { SupabaseClient } from "npm:@supabase/supabase-js@2";

const BUCKET = "appeal-documents";

async function listAll(admin: SupabaseClient, prefix: string): Promise<string[]> {
  const out: string[] = [];
  const stack = [prefix];
  while (stack.length > 0) {
    const dir = stack.pop()!;
    let offset = 0;
    for (;;) {
      const { data, error } = await admin.storage.from(BUCKET).list(dir, { limit: 100, offset });
      if (error) throw new Error("storage_list_failed");
      if (!data || data.length === 0) break;
      for (const entry of data) {
        const path = `${dir}/${entry.name}`;
        // Folders have no id in list results.
        if (entry.id == null) stack.push(path);
        else out.push(path);
      }
      if (data.length < 100) break;
      offset += 100;
    }
  }
  return out;
}

Deno.serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return jsonResponse({ error: "method_not_allowed" }, 405);

  const auth = await requireUser(req);
  if (auth instanceof Response) return auth;
  const { user, admin } = auth;

  let body: Record<string, unknown> = {};
  try {
    body = await req.json();
  } catch (_) { /* empty body */ }
  if (body.confirm !== "DELETE") return jsonResponse({ error: "confirmation_required" }, 400);

  let removed = 0;
  try {
    const paths = await listAll(admin, user.id);
    for (let i = 0; i < paths.length; i += 100) {
      const chunk = paths.slice(i, i + 100);
      const { error } = await admin.storage.from(BUCKET).remove(chunk);
      if (error) throw new Error("storage_remove_failed");
      removed += chunk.length;
    }
  } catch (e) {
    console.log(JSON.stringify({ fn: "delete-account", ev: "storage_failed", err: String((e as Error).message) }));
    return jsonResponse({ error: "storage_cleanup_failed", storage_objects_removed: removed }, 500);
  }

  const { error } = await admin.auth.admin.deleteUser(user.id);
  if (error) {
    console.log(JSON.stringify({ fn: "delete-account", ev: "auth_delete_failed" }));
    return jsonResponse({ error: "account_delete_failed", storage_objects_removed: removed }, 500);
  }
  console.log(JSON.stringify({ fn: "delete-account", ev: "deleted", storage_objects_removed: removed }));
  return jsonResponse({ deleted: true, storage_objects_removed: removed });
});
