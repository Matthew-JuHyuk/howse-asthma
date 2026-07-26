/** Stable, non-leaky source error codes (never echo env names or URLs). */

export type SourceErrorCode =
  | "unconfigured"
  | "timeout"
  | "network"
  | "http_403"
  | "http_429"
  | "http_blocked"
  | "circuit_open"
  | "unavailable"
  | "invalid_response";

export function errorFromHttpStatus(status: number): SourceErrorCode {
  if (status === 401 || status === 403) return "http_403";
  if (status === 429) return "http_429";
  if (status === 402 || status === 451) return "http_blocked";
  if (status >= 500) return "unavailable";
  return "unavailable";
}

export function errorFromCatch(e: unknown): SourceErrorCode {
  const name = e instanceof Error ? e.name : "";
  const msg = e instanceof Error ? e.message.toLowerCase() : "";
  if (name === "AbortError" || msg.includes("abort") || msg.includes("timeout")) {
    return "timeout";
  }
  return "network";
}

/** True when the source should cool down (quota / policy / auth). */
export function isCircuitTripError(code: string | undefined): boolean {
  return code === "http_429" || code === "http_403" || code === "http_blocked";
}
