// Pure validation for model output. No Deno or network APIs here so the same
// file runs under Node for tests (tool/test_validate.mjs).
//
// Rules:
// - A value is "extracted" only when its quote is present in the page text.
// - Medication and dose strings must appear verbatim in the page text.
// - A date is "extracted" only when the quote contains that same date.
// - Several different review deadlines are a conflict; none is picked.

export const FACTS_SCHEMA_VERSION = "covernote.facts.v1";

export const DOCUMENT_KINDS = [
  "initial_drug_denial",
  "additional_information_request",
  "reauthorization_notice",
  "final_appeal_denial",
  "eob_or_bill",
  "other",
  "uncertain",
] as const;
export type DocumentKind = typeof DOCUMENT_KINDS[number];

export const REASON_CODES = [
  "missing_information",
  "step_therapy",
  "medical_necessity",
  "formulary",
  "quantity_limit",
  "eligibility_or_benefit",
  "other",
] as const;

export type FactStatus = "extracted" | "missing" | "ambiguous" | "user_entered";

export type Fact = {
  value: string | null;
  page: number | null;
  quote: string | null;
  status: FactStatus;
  confirmed: boolean;
  validation?: string;
};

export type PageText = { page_number: number; text: string; legibility: string };

export type RawFact = { value: string | null; quote: string | null; page: number | null };
export type RawReason = { text: string | null; code: string | null; quote: string | null; page: number | null };
export type RawItem = { label: string | null; quote: string | null; page: number | null };
export type RawDeadline = {
  purpose: string | null;
  kind: string | null;
  date: string | null;
  duration_value: number | null;
  duration_unit: string | null;
  anchor: string | null;
  quote: string | null;
  page: number | null;
};
export type RawExtraction = {
  document_kind: string | null;
  document_kind_quote: string | null;
  document_kind_page: number | null;
  fields: Record<string, RawFact | null | undefined>;
  reasons: RawReason[] | null;
  requested_items: RawItem[] | null;
  deadlines: RawDeadline[] | null;
  received_date_stated: RawFact | null;
};

export const FIELD_KEYS = [
  "patient_name",
  "plan_name",
  "member_id",
  "case_reference",
  "medication",
  "dose",
  "notice_date",
  "contact",
  "submission_route",
] as const;

const VERBATIM_FIELDS = new Set(["medication", "dose", "member_id", "case_reference"]);
const DATE_FIELDS = new Set(["notice_date"]);

/** Lowercase, unify quotes/dashes, collapse whitespace. */
export function normalizeLoose(s: string): string {
  return s
    .normalize("NFKC")
    .replace(/[\u2018\u2019\u201A\u201B]/g, "'")
    .replace(/[\u201C\u201D\u201E\u201F]/g, '"')
    .replace(/[\u2010-\u2015\u2212]/g, "-")
    .replace(/\s+/g, " ")
    .trim()
    .toLowerCase();
}

/** Same as normalizeLoose but keeps letter case (for medication/dose). */
export function normalizeCase(s: string): string {
  return s
    .normalize("NFKC")
    .replace(/[\u2018\u2019\u201A\u201B]/g, "'")
    .replace(/[\u201C\u201D\u201E\u201F]/g, '"')
    .replace(/[\u2010-\u2015\u2212]/g, "-")
    .replace(/\s+/g, " ")
    .trim();
}

/** Returns the 1-based page where the quote occurs, preferring [hint]. */
export function findQuotePage(
  quote: string | null | undefined,
  pages: PageText[],
  hint?: number | null,
): number | null {
  if (!quote || quote.trim().length < 2) return null;
  const q = normalizeLoose(quote);
  const ordered = [...pages].sort((a, b) => {
    if (a.page_number === hint) return -1;
    if (b.page_number === hint) return 1;
    return a.page_number - b.page_number;
  });
  for (const p of ordered) {
    if (normalizeLoose(p.text).includes(q)) return p.page_number;
  }
  return null;
}

function verbatimOnPage(value: string, pages: PageText[], page: number | null): boolean {
  const v = normalizeCase(value);
  if (!v) return false;
  return pages.some((p) =>
    (page == null || p.page_number === page) && normalizeCase(p.text).includes(v)
  );
}

const MONTHS: Record<string, number> = {
  jan: 1, january: 1, feb: 2, february: 2, mar: 3, march: 3, apr: 4, april: 4,
  may: 5, jun: 6, june: 6, jul: 7, july: 7, aug: 8, august: 8, sep: 9, sept: 9,
  september: 9, oct: 10, october: 10, nov: 11, november: 11, dec: 12, december: 12,
};

function iso(y: number, m: number, d: number): string | null {
  if (m < 1 || m > 12 || d < 1 || d > 31 || y < 1900 || y > 2100) return null;
  const dt = new Date(Date.UTC(y, m - 1, d));
  if (dt.getUTCMonth() !== m - 1 || dt.getUTCDate() !== d) return null;
  return `${y.toString().padStart(4, "0")}-${m.toString().padStart(2, "0")}-${d.toString().padStart(2, "0")}`;
}

/** Every unambiguous calendar date written in [text], as YYYY-MM-DD. */
export function datesInText(text: string): string[] {
  const out = new Set<string>();
  const t = text.normalize("NFKC");
  for (const m of t.matchAll(/\b(\d{4})-(\d{1,2})-(\d{1,2})\b/g)) {
    const v = iso(+m[1], +m[2], +m[3]);
    if (v) out.add(v);
  }
  for (const m of t.matchAll(/\b(\d{1,2})\/(\d{1,2})\/(\d{4})\b/g)) {
    const v = iso(+m[3], +m[1], +m[2]);
    if (v) out.add(v);
  }
  for (const m of t.matchAll(/\b([A-Za-z]{3,9})\.?\s+(\d{1,2})(?:st|nd|rd|th)?,?\s+(\d{4})\b/g)) {
    const mon = MONTHS[m[1].toLowerCase()];
    if (!mon) continue;
    const v = iso(+m[3], mon, +m[2]);
    if (v) out.add(v);
  }
  for (const m of t.matchAll(/\b(\d{1,2})\s+([A-Za-z]{3,9})\.?,?\s+(\d{4})\b/g)) {
    const mon = MONTHS[m[2].toLowerCase()];
    if (!mon) continue;
    const v = iso(+m[3], mon, +m[1]);
    if (v) out.add(v);
  }
  return [...out];
}

function cleanString(v: unknown, max = 600): string | null {
  if (typeof v !== "string") return null;
  const s = v.trim();
  if (!s) return null;
  return s.length > max ? s.slice(0, max) : s;
}

function cleanPage(v: unknown, pageCount: number): number | null {
  if (typeof v !== "number" || !Number.isInteger(v)) return null;
  return v >= 1 && v <= pageCount ? v : null;
}

export function validateFact(key: string, raw: RawFact | null | undefined, pages: PageText[]): Fact {
  const value = cleanString(raw?.value, 300);
  const quote = cleanString(raw?.quote);
  const hint = cleanPage(raw?.page, pages.length);
  if (!value) {
    return { value: null, page: null, quote: null, status: "missing", confirmed: false };
  }
  const foundPage = findQuotePage(quote, pages, hint);
  if (foundPage == null) {
    return { value, page: hint, quote: null, status: "ambiguous", confirmed: false, validation: "quote_not_found" };
  }
  if (VERBATIM_FIELDS.has(key)) {
    if (!verbatimOnPage(value, pages, foundPage) || !normalizeCase(quote!).includes(normalizeCase(value))) {
      return { value, page: foundPage, quote, status: "ambiguous", confirmed: false, validation: "value_not_verbatim" };
    }
  }
  if (DATE_FIELDS.has(key)) {
    const isoValue = /^\d{4}-\d{2}-\d{2}$/.test(value) ? value : null;
    if (!isoValue || !datesInText(quote!).includes(isoValue)) {
      return { value, page: foundPage, quote, status: "ambiguous", confirmed: false, validation: "date_not_in_quote" };
    }
  }
  return { value, page: foundPage, quote, status: "extracted", confirmed: false };
}

export type Reason = {
  text: string;
  code: string;
  page: number | null;
  quote: string | null;
  status: FactStatus;
  confirmed: boolean;
  validation?: string;
};

export type RequestedItem = {
  label: string;
  page: number | null;
  quote: string | null;
  status: FactStatus;
  validation?: string;
};

export type Deadline = {
  purpose: "review_request" | "information_response" | "other";
  kind: "explicit_date" | "relative" | "unclear";
  date: string | null;
  duration_value: number | null;
  duration_unit: "calendar_day" | "business_day" | null;
  anchor: "received_date" | "notice_date" | null;
  raw_text: string | null;
  page: number | null;
  quote: string | null;
  status: FactStatus;
  validation?: string;
};

export type Facts = {
  schema_version: string;
  source: "ai" | "user_edit" | "demo_seed";
  document_kind: { value: DocumentKind; page: number | null; quote: string | null; status: FactStatus; confirmed: boolean };
  fields: Record<string, Fact>;
  reasons: Reason[];
  requested_items: RequestedItem[];
  deadlines: Deadline[];
  deadline_state: {
    conflict: boolean;
    received_date: string | null;
    received_date_source: "document" | "user" | null;
    confirmed: boolean;
  };
  pages: { page_number: number; legibility: string }[];
  warnings: string[];
};

function enumOr<T extends string>(v: unknown, allowed: readonly T[], fallback: T): T {
  return typeof v === "string" && (allowed as readonly string[]).includes(v) ? (v as T) : fallback;
}

export function validateExtraction(raw: RawExtraction, pages: PageText[]): Facts {
  const warnings: string[] = [];
  const fields: Record<string, Fact> = {};
  for (const key of FIELD_KEYS) {
    const f = validateFact(key, raw.fields?.[key] ?? null, pages);
    if (f.validation) warnings.push(`${f.validation}:${key}`);
    fields[key] = f;
  }

  const reasons: Reason[] = [];
  for (const r of (raw.reasons ?? []).slice(0, 6)) {
    const text = cleanString(r?.text, 500);
    if (!text) continue;
    const quote = cleanString(r?.quote);
    const page = findQuotePage(quote, pages, cleanPage(r?.page, pages.length));
    const code = enumOr(r?.code, REASON_CODES, "other");
    if (page == null) {
      warnings.push("quote_not_found:reason");
      reasons.push({ text, code, page: null, quote: null, status: "ambiguous", confirmed: false, validation: "quote_not_found" });
    } else {
      reasons.push({ text, code, page, quote, status: "extracted", confirmed: false });
    }
  }

  const items: RequestedItem[] = [];
  const seen = new Set<string>();
  for (const it of (raw.requested_items ?? []).slice(0, 8)) {
    const label = cleanString(it?.label, 300);
    if (!label) continue;
    const key = normalizeLoose(label);
    if (seen.has(key)) continue;
    seen.add(key);
    const quote = cleanString(it?.quote);
    const page = findQuotePage(quote, pages, cleanPage(it?.page, pages.length));
    if (page == null) {
      warnings.push("quote_not_found:requested_item");
      items.push({ label, page: null, quote: null, status: "ambiguous", validation: "quote_not_found" });
    } else {
      items.push({ label, page, quote, status: "extracted" });
    }
  }

  const deadlines: Deadline[] = [];
  for (const d of (raw.deadlines ?? []).slice(0, 6)) {
    const quote = cleanString(d?.quote);
    const page = findQuotePage(quote, pages, cleanPage(d?.page, pages.length));
    const purpose = enumOr(d?.purpose, ["review_request", "information_response", "other"] as const, "other");
    let kind = enumOr(d?.kind, ["explicit_date", "relative", "unclear"] as const, "unclear");
    const unit = enumOr(d?.duration_unit, ["calendar_day", "business_day"] as const, null as unknown as "calendar_day");
    const anchor = enumOr(d?.anchor, ["received_date", "notice_date"] as const, null as unknown as "received_date");
    const durationValue = typeof d?.duration_value === "number" && Number.isInteger(d.duration_value) &&
        d.duration_value > 0 && d.duration_value <= 366
      ? d.duration_value
      : null;
    let date = typeof d?.date === "string" && /^\d{4}-\d{2}-\d{2}$/.test(d.date) ? d.date : null;
    let status: FactStatus = "extracted";
    let validation: string | undefined;
    if (page == null) {
      status = "ambiguous";
      validation = "quote_not_found";
    } else if (kind === "explicit_date") {
      if (!date || !datesInText(quote!).includes(date)) {
        status = "ambiguous";
        validation = "date_not_in_quote";
      }
    } else if (kind === "relative") {
      date = null;
      if (durationValue == null || unit == null || anchor == null) {
        status = "ambiguous";
        validation = "relative_terms_incomplete";
      }
    } else {
      date = null;
      status = "ambiguous";
      validation = "deadline_unclear";
    }
    if (validation) warnings.push(`${validation}:deadline`);
    if (kind !== "explicit_date") date = null;
    deadlines.push({
      purpose,
      kind,
      date,
      duration_value: kind === "relative" ? durationValue : null,
      duration_unit: kind === "relative" ? unit : null,
      anchor: kind === "relative" ? anchor : null,
      raw_text: quote,
      page,
      quote: page == null ? null : quote,
      status,
      validation,
    });
  }

  const reviewDates = new Set(
    deadlines
      .filter((d) => d.purpose === "review_request" && d.kind === "explicit_date" && d.date)
      .map((d) => d.date!),
  );
  const reviewRelative = deadlines.filter((d) => d.purpose === "review_request" && d.kind === "relative");
  const conflict = reviewDates.size > 1 || (reviewDates.size >= 1 && reviewRelative.length >= 1);
  if (conflict) {
    warnings.push("deadline_conflict");
    for (const d of deadlines) {
      if (d.purpose === "review_request") {
        d.status = "ambiguous";
        d.validation = d.validation ?? "deadline_conflict";
      }
    }
  }

  let receivedDate: string | null = null;
  if (raw.received_date_stated) {
    const f = validateFact("notice_date", raw.received_date_stated, pages);
    if (f.status === "extracted") receivedDate = f.value;
  }

  let kind = enumOr(raw.document_kind, DOCUMENT_KINDS, "uncertain");
  const kindQuote = cleanString(raw.document_kind_quote);
  const kindPage = findQuotePage(kindQuote, pages, cleanPage(raw.document_kind_page, pages.length));
  let kindStatus: FactStatus = kindPage == null ? "ambiguous" : "extracted";
  if (kind === "initial_drug_denial" && reasons.length === 0) {
    kindStatus = "ambiguous";
    warnings.push("denial_without_reason");
  }
  if (kind === "uncertain") kindStatus = "ambiguous";

  const pageMeta = pages.map((p) => ({
    page_number: p.page_number,
    legibility: ["clear", "partly_unreadable", "unreadable"].includes(p.legibility) ? p.legibility : "clear",
  }));
  for (const p of pageMeta) {
    if (p.legibility !== "clear") warnings.push(`page_${p.legibility}:${p.page_number}`);
  }

  return {
    schema_version: FACTS_SCHEMA_VERSION,
    source: "ai",
    document_kind: { value: kind, page: kindPage, quote: kindPage == null ? null : kindQuote, status: kindStatus, confirmed: false },
    fields,
    reasons,
    requested_items: items,
    deadlines,
    deadline_state: {
      conflict,
      received_date: receivedDate,
      received_date_source: receivedDate ? "document" : null,
      confirmed: false,
    },
    pages: pageMeta,
    warnings: [...new Set(warnings)],
  };
}

/** Responsible party guess for a requested item, for the checklist only. */
export function responsibleFor(label: string): "patient" | "care_team" | "unknown" {
  const l = normalizeLoose(label);
  if (/(visit note|chart|clinical|office note|letter of medical|prescriber|doctor|physician|test result|lab|spirometr|reason .* could not)/.test(l)) {
    return "care_team";
  }
  if (/(medication history|pharmacy|prior medication|symptom|diary|log)/.test(l)) return "patient";
  return "unknown";
}
