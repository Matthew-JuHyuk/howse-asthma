# Howse Asthma — Database Schema (Supabase PostgreSQL)

> **Purpose**: Single source of truth for the **physical DB schema**, derived from
> screen definitions, UX decisions, and feature/requirements specs. Prefer this
> document when designing migrations, RLS, and Edge Functions.
>
> **Inputs (priority order)**  
> 1. `doc/screen-definition.md` §4 logical entities (local Korean docs)  
> 2. `doc/screen-ux-decisions.md` UX-Q1~Q6  
> 3. `doc/feature-spec.md` feature IDs & non-functional requirements  
> 4. `doc/requirements.md` privacy & open questions  
> 5. `doc/donation-funding-research.md` RWD/DON fund separation  
> 6. `doc/env-api-integration.md` environment cache fields  
> 7. `design/subframe/` screen inventory (29) — field consistency check
>
> **History**: Draft DDL formerly lived in `feature-spec.md` §4; it was **removed
> and rewritten** against logical entities. See §7 for differences from the old draft.
>
> **Korean twin (local, gitignored)**: `doc/db-schema.md` — keep both in sync when
> the schema changes. See [`docs/README.md`](./README.md).

Created: 2026-07-25  
Status: **v1.0** (WBS Phase 1.2b)

---

## 0. Design principles

| Principle | Detail |
| --- | --- |
| Screen-first | Logical entity → physical table. Do not invent columns the UI does not need |
| RLS | Patient = own rows only. Provider = patients linked via `patient_care_links.status='active'` |
| Server-only writes | `point_transactions.points_delta`, environment cache, alert dispatch logs → Edge / `service_role` |
| Fund separation | RWD ledger ≠ DON payment. No card/payment-instrument columns |
| Unsettled values | Donation API vendor, e-Fax vendor, final point business values, real voucher partners → no CHECK/hardcode lock-in |
| MVP draft | Point seeds via Edge config only (1-Tap +2 / PDC +1 / ACT +10 / voucher 50pt, UX-Q4) |
| ADRB2 | Keep `adrb2_variant_flag DEFAULT TRUE` (decided 2026-07-24) |

### 0.1 Logical entity → physical table

| Logical entity (`screen-definition` §4) | Physical table / view |
| --- | --- |
| UserAccount | `auth.users` (+ app session / biometrics on client) |
| UserProfile | `profiles` |
| ProviderCredential | `provider_credentials` |
| InviteCode | `invite_codes` |
| PatientCareLink | `patient_care_links` |
| SavedPlace | `saved_locations` |
| NotificationPreference | `notification_preferences` |
| DevicePushToken | `device_push_tokens` |
| EnvironmentNow / Air / Trap / Flood / Pollen / Forecast | `environment_forecasts` (+ JSONB axis detail) |
| AlertDispatch | `environment_alerts_sent` |
| InhalerUseEvent | `inhaler_events` |
| ActAssessment | `act_assessments` |
| PdcDailyCheck | `pdc_daily_checks` |
| PanicEpisode | `panic_episodes` |
| EmergencyContact | `emergency_contacts` |
| PatientRosterSummary / ClinicalTimelinePoint | **views** (aggregates, not base tables) |
| PriorAuthDocument | `pa_documents` |
| SignatureArtifact | `signature_artifacts` |
| OutboundTransmission | `outbound_transmissions` |
| PointLedgerEntry | `point_transactions` |
| PointBalance | **view** `v_point_balances` |
| VoucherOffer | `food_bank_vouchers` |
| VoucherRedemption | `voucher_redemptions` |
| PointToDonation | `point_to_donation_conversions` |
| ExternalDonationRef | `donation_transactions` |
| (clinical adjunct) | `patient_details` |

---

## 1. ER overview

```text
auth.users ──1:1── profiles ──┬── PATIENT ── patient_details
                              │                 │
                              │                 ├── emergency_contacts (0..1 MVP)
                              │                 ├── notification_preferences
                              │                 ├── device_push_tokens *
                              │                 ├── saved_locations *
                              │                 ├── inhaler_events *
                              │                 ├── act_assessments *
                              │                 ├── pdc_daily_checks *
                              │                 ├── panic_episodes *
                              │                 ├── point_transactions *
                              │                 └── …
                              │
                              └── PROVIDER ── provider_credentials
                                              ├── invite_codes *
                                              ├── patient_care_links * (↔ PATIENT)
                                              ├── pa_documents *
                                              ├── signature_artifacts *
                                              └── outbound_transmissions *

environment_forecasts          (shared cache, Geohash)
environment_alerts_sent        (per-patient cooldown / history)
food_bank_vouchers             (catalog; draft/dummy allowed)
```

---

## 2. DDL (PostgreSQL)

> Apply order: extensions → profiles → dependent tables → indexes → views → RLS.  
> Runtime apply via `supabase/migrations` (WBS 1.3).

```sql
-- Extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ---------------------------------------------------------------------------
-- 2.1 Accounts · roles · profiles
-- ---------------------------------------------------------------------------

CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users (id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL CHECK (role IN ('PATIENT', 'PROVIDER')),
    full_name TEXT NOT NULL,
    language_code VARCHAR(10) NOT NULL DEFAULT 'en'
        CHECK (language_code IN ('en', 'es', 'fr', 'ko', 'ja', 'zh')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.provider_credentials (
    provider_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    npi VARCHAR(10) NOT NULL, -- MVP: format (digits + checksum) only
    license_display_name TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT provider_credentials_npi_digits CHECK (npi ~ '^[0-9]{10}$')
);

CREATE TABLE public.patient_details (
    patient_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    -- Denormalized cache of active primary provider; source of truth = care_links(active)
    primary_provider_id UUID REFERENCES public.profiles (id),
    primary_diagnosis_icd10 VARCHAR(20) NOT NULL DEFAULT 'J45.909',
    adrb2_variant_flag BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- UX-Q5: 6-digit invite code, TTL 24h
CREATE TABLE public.invite_codes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    code CHAR(6) NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    consumed_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    CONSTRAINT invite_codes_code_format CHECK (code ~ '^[0-9]{6}$')
);

CREATE UNIQUE INDEX uq_invite_codes_active_code
    ON public.invite_codes (code)
    WHERE consumed_at IS NULL;

CREATE TABLE public.patient_care_links (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    invite_code_id UUID REFERENCES public.invite_codes (id),
    status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (status IN ('pending', 'active', 'rejected')),
    patient_confirmed_at TIMESTAMPTZ,
    provider_confirmed_at TIMESTAMPTZ,
    activated_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    UNIQUE (patient_id, provider_id)
);

-- ---------------------------------------------------------------------------
-- 2.2 Locations · notification preferences
-- ---------------------------------------------------------------------------

CREATE TABLE public.saved_locations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    label VARCHAR(50) NOT NULL, -- HOME / SCHOOL / WORK / OTHER, etc.
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    monitoring_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.notification_preferences (
    patient_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    push_risk_ge3 BOOLEAN NOT NULL DEFAULT TRUE,
    push_location_entry BOOLEAN NOT NULL DEFAULT TRUE,
    push_saved_location_change BOOLEAN NOT NULL DEFAULT TRUE,
    last_alert_at TIMESTAMPTZ, -- UX helper; server cooldown uses alerts_sent
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.device_push_tokens (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    profile_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    fcm_token TEXT NOT NULL,
    platform VARCHAR(20) CHECK (platform IN ('android', 'ios', 'web')),
    last_seen_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    UNIQUE (profile_id, fcm_token)
);

CREATE TABLE public.emergency_contacts (
    patient_id UUID PRIMARY KEY REFERENCES public.profiles (id) ON DELETE CASCADE,
    display_name TEXT NOT NULL,
    phone_e164 TEXT NOT NULL, -- for tel: dial; no server SMS/push channel (UX-Q1)
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- ---------------------------------------------------------------------------
-- 2.3 Environment cache · alert history
-- ---------------------------------------------------------------------------

CREATE TABLE public.environment_forecasts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    geohash TEXT NOT NULL,
    latitude NUMERIC(8, 5) NOT NULL,
    longitude NUMERIC(8, 5) NOT NULL,
    risk_score SMALLINT NOT NULL CHECK (risk_score BETWEEN 1 AND 4),
    ui_state VARCHAR(20) NOT NULL
        CHECK (ui_state IN ('CALM', 'CAUTION', 'WARNING', 'EMERGENCY')),
    -- Air quality
    aqi_epa INT,
    pm25 NUMERIC(6, 2),
    no2_ppb NUMERIC(6, 2),
    aqi_source VARCHAR(40), -- EPA_AirNow / OpenMeteo / PurpleAir, etc.
    -- TRAP proxy (not truck counts)
    local_pm25 NUMERIC(6, 2),
    trap_level VARCHAR(20)
        CHECK (trap_level IN ('LOW', 'MODERATE', 'HIGH', 'CRITICAL')),
    trap_near_freight_weight BOOLEAN DEFAULT FALSE,
    -- Flood
    has_flash_flood_warning BOOLEAN NOT NULL DEFAULT FALSE,
    flood_alert_headline TEXT,
    flood_severity TEXT,
    usgs_stream_rate_ft_hr NUMERIC(5, 2),
    -- Pollen (PAT-08 = Google Pollen UPI)
    pollen_upi SMALLINT CHECK (pollen_upi BETWEEN 0 AND 5),
    dominant_pollen_type TEXT, -- GRASS / TREE / WEED, etc.
    pollen_forecast_days SMALLINT,
    baseline_comparison_pct NUMERIC(6, 2), -- after historical baseline exists
    -- Per-day forecast axis as JSONB — ForecastPoint logical entity
    forecast_points JSONB,
    raw_response JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    expires_at TIMESTAMPTZ NOT NULL
);

CREATE INDEX idx_env_forecasts_geohash
    ON public.environment_forecasts (geohash, expires_at);

CREATE TABLE public.environment_alerts_sent (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    alert_type VARCHAR(20) NOT NULL
        CHECK (alert_type IN ('TRAP_SOOT', 'FLASH_FLOOD', 'POLLEN', 'COMPOSITE')),
    trigger_reason VARCHAR(40) NOT NULL
        CHECK (trigger_reason IN (
            'LOCATION_ENTRY', 'SAVED_LOCATION_CHANGE', 'RISK_THRESHOLD', 'MANUAL'
        )),
    cooldown_key TEXT NOT NULL, -- type + grid key for de-duplication
    risk_level SMALLINT CHECK (risk_level BETWEEN 1 AND 4),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    payload JSONB,
    sent_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE INDEX idx_alerts_sent_cooldown
    ON public.environment_alerts_sent (patient_id, cooldown_key, sent_at DESC);

-- ---------------------------------------------------------------------------
-- 2.4 Clinical · adherence · panic
-- ---------------------------------------------------------------------------

CREATE TABLE public.inhaler_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    recorded_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    is_panic BOOLEAN NOT NULL DEFAULT FALSE,
    input_means VARCHAR(20) NOT NULL DEFAULT 'tap'
        CHECK (input_means IN ('tap', 'panic', 'voice')), -- voice = later (UX-Q6 MVP off)
    risk_level SMALLINT CHECK (risk_level BETWEEN 1 AND 4),
    ui_state VARCHAR(20)
        CHECK (ui_state IN ('CALM', 'CAUTION', 'WARNING', 'EMERGENCY')),
    pm25_level NUMERIC(6, 2),
    no2_level NUMERIC(6, 2),
    local_pm25_snapshot NUMERIC(6, 2),
    flash_flood_alert_active BOOLEAN NOT NULL DEFAULT FALSE,
    pollen_upi_snapshot SMALLINT CHECK (pollen_upi_snapshot BETWEEN 0 AND 5),
    environment_forecast_id UUID REFERENCES public.environment_forecasts (id),
    data_source_summary JSONB
);

CREATE TABLE public.act_assessments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    q1 SMALLINT NOT NULL CHECK (q1 BETWEEN 1 AND 5),
    q2 SMALLINT NOT NULL CHECK (q2 BETWEEN 1 AND 5),
    q3 SMALLINT NOT NULL CHECK (q3 BETWEEN 1 AND 5),
    q4 SMALLINT NOT NULL CHECK (q4 BETWEEN 1 AND 5),
    q5 SMALLINT NOT NULL CHECK (q5 BETWEEN 1 AND 5),
    total_score SMALLINT NOT NULL CHECK (total_score BETWEEN 5 AND 25),
    language_used VARCHAR(10) NOT NULL,
    submitted_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.pdc_daily_checks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    check_date DATE NOT NULL,
    taken BOOLEAN NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    UNIQUE (patient_id, check_date)
);

CREATE TABLE public.panic_episodes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    started_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    ended_at TIMESTAMPTZ,
    help_requested BOOLEAN NOT NULL DEFAULT FALSE, -- Step2 CTA tapped (call is OS)
    outcome_chip VARCHAR(40), -- Step3 chip (e.g. feeling_better / still_hard / called_911)
    inhaler_event_id UUID REFERENCES public.inhaler_events (id),
    notes TEXT
);

-- ---------------------------------------------------------------------------
-- 2.5 Provider documents · signature · outbound
-- ---------------------------------------------------------------------------

CREATE TABLE public.pa_documents (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    doc_type VARCHAR(10) NOT NULL CHECK (doc_type IN ('PA', 'LMN')),
    pdf_storage_path TEXT NOT NULL,
    review_checklist JSONB, -- on-screen review check state
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.signature_artifacts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pa_document_id UUID NOT NULL REFERENCES public.pa_documents (id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    storage_path TEXT NOT NULL, -- image / vector
    signed_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- UX-Q2/Q3: email first (Resend). Fax only when EFAX_ENABLED. No mock SENT
CREATE TABLE public.outbound_transmissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    pa_document_id UUID NOT NULL REFERENCES public.pa_documents (id) ON DELETE CASCADE,
    provider_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    channel VARCHAR(10) NOT NULL CHECK (channel IN ('EMAIL', 'FAX')),
    recipient TEXT NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'QUEUED'
        CHECK (status IN (
            'QUEUED', 'SENDING', 'SENT', 'FAILED', 'FAILOVER_EMAIL', 'CANCELLED'
        )),
    external_message_id TEXT, -- Resend / e-Fax provider ID
    error_detail TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- ---------------------------------------------------------------------------
-- 2.6 Rewards · vouchers · donations (fund separation)
-- ---------------------------------------------------------------------------

CREATE TABLE public.point_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    action_type VARCHAR(40) NOT NULL CHECK (action_type IN (
        'INHALER_LOG',
        'ACT_ASSESSMENT',
        'PDC_CHECKIN',
        'VOUCHER_REDEEMED',
        'VOUCHER_WAITLIST',
        'DONATION_CONVERTED',
        'ADJUSTMENT'
    )),
    points_delta INT NOT NULL, -- INSERT from Edge Function only
    related_entity_id UUID,
    note TEXT, -- audit note (e.g. draft seed)
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.food_bank_vouchers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    food_bank_name TEXT NOT NULL,
    voucher_value_usd NUMERIC(8, 2),
    point_cost INT NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    is_draft BOOLEAN NOT NULL DEFAULT TRUE, -- UX-Q4: true until partner confirmed
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.voucher_redemptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    voucher_id UUID NOT NULL REFERENCES public.food_bank_vouchers (id),
    points_spent INT NOT NULL,
    redemption_code TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'WAITLIST'
        CHECK (status IN (
            'WAITLIST', 'PENDING', 'ISSUED', 'REDEEMED', 'EXPIRED', 'CANCELLED'
        )),
    redeemed_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE TABLE public.point_to_donation_conversions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    patient_id UUID NOT NULL REFERENCES public.profiles (id) ON DELETE CASCADE,
    points_spent INT NOT NULL,
    cash_equivalent_usd NUMERIC(8, 2), -- policy unsettled → nullable
    target_org_label TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- DON: third-party reference metadata only. Do not CHECK-lock external_provider
CREATE TABLE public.donation_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    donor_profile_id UUID REFERENCES public.profiles (id),
    amount_usd NUMERIC(10, 2),
    external_provider TEXT, -- free text until vendor decided
    external_transaction_id TEXT,
    receipt_url TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- ---------------------------------------------------------------------------
-- 2.7 Views
-- ---------------------------------------------------------------------------

CREATE OR REPLACE VIEW public.v_point_balances AS
SELECT
    patient_id,
    COALESCE(SUM(points_delta), 0)::INT AS balance
FROM public.point_transactions
GROUP BY patient_id;

-- PatientRosterSummary / ClinicalTimelinePoint: Edge or SQL views in Phase 7
```

---

## 3. RLS policy outline

> Implemented in [`supabase/migrations/20260725210000_rls_policies.sql`](../supabase/migrations/20260725210000_rls_policies.sql).  
> Summary: [`rls-policies.md`](./rls-policies.md).

Recommended helper:

```sql
-- Is the caller an active linked provider for this patient?
CREATE OR REPLACE FUNCTION public.is_active_provider_of(p_patient UUID)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.patient_care_links l
    WHERE l.patient_id = p_patient
      AND l.provider_id = auth.uid()
      AND l.status = 'active'
  );
$$;
```

| Table | Patient | Linked provider | Other |
| --- | --- | --- | --- |
| `profiles` | Own R/W | Linked patient profile R | — |
| `provider_credentials` | — | Own R/W | — |
| `patient_details` | Own R/W | Linked R | — |
| `invite_codes` | — | Own issued R/W | Patient redeem via Edge RPC |
| `patient_care_links` | Own links R + confirm update | Own links R + confirm | Create via Edge preferred |
| `emergency_contacts` ~ `panic_episodes` | Own | Linked R (writes restricted) | — |
| `inhaler_events`, ACT/PDC | Own R/W | Linked R | — |
| `pa_documents` family | Own R | Authoring provider R/W | Send via Edge |
| `environment_forecasts` | Auth user **SELECT** | Same | INSERT/UPDATE = `service_role` |
| `food_bank_vouchers` | Auth **SELECT** | Same | Writes = admin/service |
| `point_transactions` ledger | Own **SELECT** | — | **INSERT = Edge only** |
| `donation_transactions` | Own SELECT | — | INSERT = Edge (webhook/callback) |

Cooldown: `environment_alerts_sent` + `alert_policy.cooldown_minutes=60`
(`env-api-config.json`).

---

## 4. Boundary with Edge Functions / secrets

| Data | Direct client write | Notes |
| --- | --- | --- |
| `points_delta` | ❌ | Draft seed values also server config |
| `environment_forecasts` | ❌ | `calculate-environment-risk` |
| `environment_alerts_sent` | ❌ | Alert-dispatch Edge Function |
| `outbound_transmissions` status | ❌ | Resend/e-Fax EF. No mock SENT |
| Invite consume / link activate | Limited / RPC | `active` only after both confirm |
| Inhaler · ACT · PDC · locations · emergency contact | ✅ (within RLS) | — |

Secrets: `AIRNOW_API_KEY`, `PURPLEAIR_READ_KEY`, `GOOGLE_MAPS_API_KEY`,
`RESEND_API_KEY`, `RESEND_FROM_EMAIL`, `RESEND_REPLY_TO`, `EFAX_ENABLED`,
`NWS_USER_AGENT_CONTACT` — never hardcode in source.

---

## 5. Screen ↔ table matrix (summary)

| Screen ID | Primary reads | Primary writes |
| --- | --- | --- |
| AUTH-* | `profiles` | `profiles`, (`provider_credentials`) |
| ONB-01 | — | `saved_locations`, `emergency_contacts`, care link pending |
| ONB-02 | — | `provider_credentials` |
| PAT-HOME / ENV / FORECAST | `environment_forecasts`, `v_point_balances` | `inhaler_events` |
| PAT-LOG | inhaler / pdc / act | — |
| PAT-ACT / PDC | history | `act_assessments` / `pdc_daily_checks` |
| PAT-LOCATIONS | `saved_locations` | `saved_locations` |
| PAT-SETTINGS | prefs, contact, link | same |
| SYS-ALERT | alerts / forecast | — (dispatch is server) |
| SYS-PANIC | contact, forecast | `inhaler_events`, `panic_episodes` |
| PAT-REWARD* | ledger, vouchers, donations | request only → Edge |
| PRV-HOME / DETAIL | aggregate views + events | — |
| PRV-LINK | invite / links | issue invite, confirm |
| PRV-DOC / SIGN | `pa_documents` | signature + outbound (Edge) |

---

## 6. Unsettled · intentionally unfixed

| Item | Schema treatment |
| --- | --- |
| Donation API vendor | `donation_transactions.external_provider` TEXT, no enum CHECK |
| e-Fax vendor | No vendor-specific column on `outbound_transmissions`; secrets / `EFAX_ENABLED` |
| Final point business values | No award constants in tables → Edge config |
| Real food-bank partners | `food_bank_vouchers.is_draft=true` + redemption `WAITLIST` |
| Points→donation conversion policy | `cash_equivalent_usd` nullable |
| PA/LMN form copy | Storage PDF + `review_checklist` JSONB only |
| VUI voice input | `input_means='voice'` allowed; unused in MVP |

---

## 7. Changes vs former `feature-spec.md` §4 draft

| Old schema | Change |
| --- | --- |
| `profiles` only | + `provider_credentials`, 6-language CHECK |
| `patient_details.provider_id` | → `primary_provider_id` + **`patient_care_links` / `invite_codes`** |
| Mixed `pro_assessments` | → **`act_assessments` + `pdc_daily_checks`** |
| `inhaler_events` | + `is_panic`, `input_means`, `ui_state`, UPI snapshot |
| (missing) | **`emergency_contacts`, `panic_episodes`, `notification_preferences`, `device_push_tokens`** |
| `saved_locations` | + `monitoring_enabled`, `is_primary` |
| `environment_forecasts` | + `ui_state`, `trap_level`, **`pollen_upi`**, `forecast_points` |
| `pa_documents.fax_status` | → `doc_type`/`review_checklist` + **`signature_artifacts` + `outbound_transmissions`** |
| `voucher_redemptions` | + **`WAITLIST`**, catalog `is_draft` |
| `donation_transactions` | No provider CHECK (do not hardcode research candidates) |

---

## 8. Rollout order (WBS)

1. **1.2b** — This document finalized ← **✅ done** (2026-07-25)
2. **1.3** — Init schema ← **✅ applied** remotely (`20260725200000_init_schema.sql`)
3. **1.4** — RLS policies ← **✅ applied** (`20260725210000_rls_policies.sql`) — see [`rls-policies.md`](./rls-policies.md)
4. **1.6–1.7** — Edge Function skeleton + secrets + **deploy** ← **✅** ([`edge-functions.md`](./edge-functions.md))
5. **Phase 2** — Auth / role routing ← **next**
6. Phases 3/4/7/9 — Live APIs and feature screens

When applying migrations, update this file (and the Korean twin under `doc/`) in the same commit when practical.

---

## 9. Related documents

| Document | Relation |
| --- | --- |
| [`README.md`](./README.md) | `docs/` commit convention |
| `doc/screen-definition.md` §4 | Logical entity input (local) |
| `doc/screen-ux-decisions.md` | UX → schema decisions (local) |
| `doc/feature-spec.md` | Feature IDs & NFRs (local; physical DDL is this doc) |
| `doc/requirements.md` | Open questions · HIPAA-oriented (local) |
| `doc/env-api-integration.md` | Environment cache TTL · fields (local) |
| `doc/donation-funding-research.md` | RWD/DON separation (local) |
| `doc/wbs.md` | Phase 1.2b~1.4 (local) |
| `design/subframe/` | UI field consistency (tracked) |
| `supabase/` | Applied migrations & functions (tracked) |
