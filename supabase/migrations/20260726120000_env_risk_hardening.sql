-- Environment risk abuse controls + RLS tighten

-- ---------------------------------------------------------------------------
-- Circuit breaker + rate-limit tables (service_role only)
-- ---------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS public.env_api_circuits (
    source TEXT PRIMARY KEY,
    open_until TIMESTAMPTZ NOT NULL,
    last_status INT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

ALTER TABLE public.env_api_circuits ENABLE ROW LEVEL SECURITY;
-- No authenticated policies → deny-by-default

CREATE TABLE IF NOT EXISTS public.env_risk_rate_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users (id) ON DELETE CASCADE,
    geohash TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE INDEX IF NOT EXISTS idx_env_risk_rate_user_time
  ON public.env_risk_rate_events (user_id, created_at DESC);

ALTER TABLE public.env_risk_rate_events ENABLE ROW LEVEL SECURITY;

-- ---------------------------------------------------------------------------
-- environment_forecasts: stop broad client SELECT of all cached locations
-- Clients should call the Edge Function; service_role reads/writes cache.
-- ---------------------------------------------------------------------------

DROP POLICY IF EXISTS environment_forecasts_select_authenticated
  ON public.environment_forecasts;

-- Optional: authenticated may SELECT only via future RPC; none for now.
