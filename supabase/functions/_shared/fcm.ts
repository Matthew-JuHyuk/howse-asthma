/**
 * FCM HTTP v1 sender (WBS 4.6a).
 * Requires Edge secret FIREBASE_SERVICE_ACCOUNT_JSON (full service-account JSON).
 * Never log private_key or the full JSON.
 */

import * as jose from "npm:jose@5.9.6";

export type FcmSendResult = {
  attempted: boolean;
  sent: number;
  failed: number;
  error?: string;
};

type ServiceAccount = {
  project_id: string;
  client_email: string;
  private_key: string;
  token_uri?: string;
};

function loadServiceAccount(): ServiceAccount | null {
  const raw = Deno.env.get("FIREBASE_SERVICE_ACCOUNT_JSON");
  if (!raw?.trim()) return null;
  try {
    const parsed = JSON.parse(raw) as ServiceAccount;
    if (!parsed.project_id || !parsed.client_email || !parsed.private_key) {
      return null;
    }
    // Handle escaped newlines in private_key from env storage.
    parsed.private_key = parsed.private_key.replace(/\\n/g, "\n");
    return parsed;
  } catch {
    return null;
  }
}

let cachedToken: { value: string; expMs: number } | null = null;

async function getAccessToken(sa: ServiceAccount): Promise<string> {
  const nowMs = Date.now();
  if (cachedToken && cachedToken.expMs > nowMs + 60_000) {
    return cachedToken.value;
  }

  const now = Math.floor(nowMs / 1000);
  const privateKey = await jose.importPKCS8(sa.private_key, "RS256");
  const jwt = await new jose.SignJWT({
    scope: "https://www.googleapis.com/auth/firebase.messaging",
  })
    .setProtectedHeader({ alg: "RS256", typ: "JWT" })
    .setIssuer(sa.client_email)
    .setSubject(sa.client_email)
    .setAudience(sa.token_uri ?? "https://oauth2.googleapis.com/token")
    .setIssuedAt(now)
    .setExpirationTime(now + 3600)
    .sign(privateKey);

  const tokenRes = await fetch(
    sa.token_uri ?? "https://oauth2.googleapis.com/token",
    {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: new URLSearchParams({
        grant_type: "urn:ietf:params:oauth:grant-type:jwt-bearer",
        assertion: jwt,
      }),
    },
  );
  if (!tokenRes.ok) {
    throw new Error(`oauth_token_${tokenRes.status}`);
  }
  const body = await tokenRes.json() as { access_token?: string; expires_in?: number };
  if (!body.access_token) throw new Error("oauth_token_missing");
  const expiresIn = typeof body.expires_in === "number" ? body.expires_in : 3600;
  cachedToken = {
    value: body.access_token,
    expMs: nowMs + expiresIn * 1000,
  };
  return body.access_token;
}

export type FcmAlertPayload = {
  alertId: string;
  riskScore: number;
  uiState: string;
  triggerReason: string;
};

/** Send the same alert to all device tokens. Removes invalid tokens. */
export async function sendFcmToTokens(
  // deno-lint-ignore no-explicit-any
  admin: any,
  tokens: Array<{ id: string; fcm_token: string }>,
  payload: FcmAlertPayload,
): Promise<FcmSendResult> {
  const sa = loadServiceAccount();
  if (!sa) {
    return {
      attempted: false,
      sent: 0,
      failed: 0,
      error: "fcm_unconfigured",
    };
  }
  if (tokens.length === 0) {
    return { attempted: true, sent: 0, failed: 0, error: "no_tokens" };
  }

  let accessToken: string;
  try {
    accessToken = await getAccessToken(sa);
  } catch (e) {
    console.error("[fcm] access token failed");
    return {
      attempted: true,
      sent: 0,
      failed: tokens.length,
      error: e instanceof Error ? e.message : "oauth_failed",
    };
  }

  const url =
    `https://fcm.googleapis.com/v1/projects/${sa.project_id}/messages:send`;
  let sent = 0;
  let failed = 0;

  const isPositive = payload.triggerReason === "VENTILATION_WINDOW";
  const title = isPositive
    ? "Good window for fresh air"
    : "Asthma risk alert";
  const body = isPositive
    ? "Outside air looks calmer. A short air-out may help — keep your inhaler nearby."
    : `Risk level ${payload.riskScore} (${payload.uiState}). Open Howse Asthma for details.`;

  for (const row of tokens) {
    const bodyMsg = {
      message: {
        token: row.fcm_token,
        notification: {
          title,
          body,
        },
        data: {
          alert_id: payload.alertId,
          risk_score: String(payload.riskScore),
          ui_state: payload.uiState,
          trigger_reason: payload.triggerReason,
          type: isPositive ? "ventilation_tip" : "environment_risk",
        },
        android: {
          priority: "HIGH",
        },
      },
    };

    try {
      const res = await fetch(url, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${accessToken}`,
          "Content-Type": "application/json",
          "User-Agent": "HowseAsthma-Edge/1.0",
        },
        body: JSON.stringify(bodyMsg),
      });
      if (res.ok) {
        sent++;
        continue;
      }
      failed++;
      const errText = await res.text();
      // Drop only clearly dead tokens. INVALID_ARGUMENT often means payload /
      // project misconfig — do not mass-delete valid device rows.
      const deadToken =
        res.status === 404 ||
        errText.includes("UNREGISTERED") ||
        errText.includes("NOT_FOUND") ||
        errText.includes('"errorCode":"UNREGISTERED"');
      if (deadToken) {
        await admin.from("device_push_tokens").delete().eq("id", row.id);
      } else {
        console.error("[fcm] send failed", res.status, errText.slice(0, 200));
      }
    } catch {
      failed++;
    }
  }

  return { attempted: true, sent, failed };
}
