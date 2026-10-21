// Server-side model adapters. Keys come from Edge secrets only.
//   AI_PROVIDER = gemini | openai
//   GEMINI_API_KEY or OPENAI_API_KEY
//   AI_MODEL (required; a model the account can use with file input and JSON schema output)
// Requests set store=false. No tools are declared, so the model cannot browse
// or call anything named in a document.

export type InputFile = { mime: string; base64: string; name: string };

export type ModelCall = {
  system: string;
  files: InputFile[];
  text: string;
  schema: Record<string, unknown>;
  timeoutMs: number;
};

export type ModelResult = {
  json: unknown;
  requestId: string | null;
  inputTokens: number | null;
  outputTokens: number | null;
};

export class ProviderError extends Error {
  constructor(public code: string, public retryable: boolean, public httpStatus?: number) {
    super(code);
  }
}

export type ProviderConfig = {
  provider: "gemini" | "openai";
  model: string;
  key: string;
};

export function readProviderConfig(): ProviderConfig | { missing: string } {
  const provider = (Deno.env.get("AI_PROVIDER") ?? "").trim().toLowerCase();
  if (provider !== "gemini" && provider !== "openai") return { missing: "AI_PROVIDER" };
  const keyName = provider === "gemini" ? "GEMINI_API_KEY" : "OPENAI_API_KEY";
  const key = (Deno.env.get(keyName) ?? "").trim();
  if (!key) return { missing: keyName };
  const model = (Deno.env.get("AI_MODEL") ?? "").trim();
  if (!model) return { missing: "AI_MODEL" };
  return { provider, model, key };
}

function mapStatus(status: number): ProviderError {
  if (status === 429) return new ProviderError("ai_rate_limited", true, status);
  if (status === 401 || status === 403) return new ProviderError("ai_auth_failed", false, status);
  if (status === 404) return new ProviderError("ai_model_not_found", false, status);
  if (status === 413) return new ProviderError("ai_input_too_large", false, status);
  if (status >= 500) return new ProviderError("ai_unavailable", true, status);
  return new ProviderError("ai_request_rejected", false, status);
}

async function postJson(url: string, headers: Record<string, string>, body: unknown, timeoutMs: number) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeoutMs);
  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json", ...headers },
      body: JSON.stringify(body),
      signal: controller.signal,
    });
    const text = await res.text();
    if (!res.ok) {
      // Provider error bodies can echo input; log status and a short code only.
      let providerCode = "";
      try {
        const j = JSON.parse(text);
        providerCode = String(j?.error?.status ?? j?.error?.code ?? j?.error?.type ?? "").slice(0, 60);
      } catch (_) { /* ignore */ }
      console.log(JSON.stringify({ ev: "ai_http_error", status: res.status, provider_code: providerCode }));
      throw mapStatus(res.status);
    }
    return { json: JSON.parse(text), headers: res.headers };
  } catch (e) {
    if (e instanceof ProviderError) throw e;
    if ((e as Error).name === "AbortError") throw new ProviderError("ai_timeout", true);
    throw new ProviderError("ai_network_error", true);
  } finally {
    clearTimeout(timer);
  }
}

function parseModelJson(text: string): unknown {
  const trimmed = text.trim().replace(/^```(?:json)?\s*/i, "").replace(/```\s*$/, "");
  try {
    return JSON.parse(trimmed);
  } catch (_) {
    throw new ProviderError("ai_bad_output", true);
  }
}

async function callGemini(cfg: ProviderConfig, call: ModelCall): Promise<ModelResult> {
  const input: unknown[] = [];
  for (const f of call.files) {
    if (f.mime === "application/pdf") {
      input.push({ type: "document", data: f.base64, mime_type: f.mime });
    } else {
      input.push({ type: "image", data: f.base64, mime_type: f.mime, resolution: "high" });
    }
  }
  input.push({ type: "text", text: call.text });
  const { json } = await postJson(
    "https://generativelanguage.googleapis.com/v1beta/interactions",
    { "x-goog-api-key": cfg.key },
    {
      model: cfg.model,
      system_instruction: call.system,
      input,
      response_format: { type: "text", mime_type: "application/json", schema: call.schema },
      store: false,
      generation_config: { thinking_level: "low", max_output_tokens: 32768 },
    },
    call.timeoutMs,
  );
  // deno-lint-ignore no-explicit-any
  const j = json as any;
  if (j?.status && j.status !== "completed") {
    throw new ProviderError("ai_incomplete", true);
  }
  let text = "";
  for (const step of j?.steps ?? []) {
    if (step?.type !== "model_output") continue;
    for (const c of step?.content ?? []) {
      if (c?.type === "text" && typeof c.text === "string") text += c.text;
    }
  }
  if (!text && Array.isArray(j?.outputs)) {
    for (const c of j.outputs) {
      if (c?.type === "text" && typeof c.text === "string") text += c.text;
    }
  }
  if (!text) throw new ProviderError("ai_empty_output", true);
  return {
    json: parseModelJson(text),
    requestId: typeof j?.id === "string" ? j.id : null,
    inputTokens: Number.isFinite(j?.usage?.total_input_tokens) ? j.usage.total_input_tokens : null,
    outputTokens: Number.isFinite(j?.usage?.total_output_tokens) ? j.usage.total_output_tokens : null,
  };
}

async function callOpenAi(cfg: ProviderConfig, call: ModelCall): Promise<ModelResult> {
  const content: unknown[] = [];
  call.files.forEach((f, i) => {
    if (f.mime === "application/pdf") {
      content.push({ type: "input_file", filename: `file-${i + 1}.pdf`, file_data: `data:${f.mime};base64,${f.base64}` });
    } else {
      content.push({ type: "input_image", image_url: `data:${f.mime};base64,${f.base64}`, detail: "high" });
    }
  });
  content.push({ type: "input_text", text: call.text });
  const { json, headers } = await postJson(
    "https://api.openai.com/v1/responses",
    { Authorization: `Bearer ${cfg.key}` },
    {
      model: cfg.model,
      instructions: call.system,
      input: [{ role: "user", content }],
      text: { format: { type: "json_schema", name: "result", schema: call.schema, strict: true } },
      store: false,
    },
    call.timeoutMs,
  );
  // deno-lint-ignore no-explicit-any
  const j = json as any;
  if (j?.status && j.status !== "completed") throw new ProviderError("ai_incomplete", true);
  let text = "";
  for (const item of j?.output ?? []) {
    if (item?.type !== "message") continue;
    for (const c of item?.content ?? []) {
      if (c?.type === "output_text" && typeof c.text === "string") text += c.text;
      if (c?.type === "refusal") throw new ProviderError("ai_refused", false);
    }
  }
  if (!text) throw new ProviderError("ai_empty_output", true);
  return {
    json: parseModelJson(text),
    requestId: (typeof j?.id === "string" ? j.id : null) ?? headers.get("x-request-id"),
    inputTokens: Number.isFinite(j?.usage?.input_tokens) ? j.usage.input_tokens : null,
    outputTokens: Number.isFinite(j?.usage?.output_tokens) ? j.usage.output_tokens : null,
  };
}

export function callModel(cfg: ProviderConfig, call: ModelCall): Promise<ModelResult> {
  return cfg.provider === "gemini" ? callGemini(cfg, call) : callOpenAi(cfg, call);
}
