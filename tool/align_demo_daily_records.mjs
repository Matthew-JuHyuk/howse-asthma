// Align the dedicated demo account's recent daily log through today.
// Default is read-only. --apply updates only that account.
// Does not rewrite fixture rows, shift old dates, or delete symptom history.
import { createHash } from 'node:crypto';
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';

const env = (p) =>
  Object.fromEntries(
    readFileSync(p, 'utf8')
      .split(/\r?\n/)
      .filter((x) => /^\w+=/.test(x))
      .map((x) => {
        const i = x.indexOf('=');
        return [x.slice(0, i), x.slice(i + 1).trim()];
      }),
  );
const e = env('.env');
const cfg = env('.env.demo');
const apply = process.argv.includes('--apply');
let token;

async function api(path, method = 'GET', body) {
  const r = await fetch(e.SUPABASE_URL + path, {
    method,
    headers: {
      apikey: e.SUPABASE_ANON_KEY,
      ...(token ? { Authorization: `Bearer ${token}` } : {}),
      'Content-Type': 'application/json',
      Prefer: 'return=representation',
    },
    body: body === undefined ? undefined : JSON.stringify(body),
  });
  const text = await r.text();
  if (!r.ok) {
    throw Error(`${method} ${path.split('?')[0]} failed (${r.status}) ${text.slice(0, 240)}`);
  }
  return text ? JSON.parse(text) : null;
}

const login = await api('/auth/v1/token?grant_type=password', 'POST', {
  email: cfg.S10_EMAIL,
  password: cfg.S10_PASSWORD,
});
if (login.user?.email !== cfg.S10_EMAIL || login.user?.user_metadata?.sprint10_demo !== true) {
  throw Error('Dedicated demo account guard failed');
}
token = login.access_token;
const uid = login.user.id;
const today = new Intl.DateTimeFormat('en-CA', { timeZone: 'America/New_York' }).format(new Date());
const idFor = (name) => {
  const h = createHash('sha256').update(`${uid}/s10/${name}`).digest('hex');
  return `${h.slice(0, 8)}-${h.slice(8, 12)}-4${h.slice(13, 16)}-8${h.slice(17, 20)}-${h.slice(20, 32)}`;
};
const addDays = (day, n) => {
  const d = new Date(`${day}T12:00:00Z`);
  d.setUTCDate(d.getUTCDate() + n);
  return d.toISOString().slice(0, 10);
};

const [events, meds, regimens, snapshots, uses] = await Promise.all([
  api(`/rest/v1/treatment_events?owner_id=eq.${uid}&select=id,patient_key,source_id,local_date,kind,undone_at,created_at,payload&order=local_date.asc`),
  api(`/rest/v1/patient_medications?patient_id=eq.${uid}&select=id,display_name`),
  api(`/rest/v1/medication_regimens?patient_id=eq.${uid}&effective_until=is.null&select=id,medication_id,role,puffs_per_occasion`),
  api(`/rest/v1/environment_snapshots?patient_id=eq.${uid}&select=id,event_local_date,metric,value,unit,created_at,fetched_at&order=created_at.asc`),
  api(`/rest/v1/medication_use_events?patient_id=eq.${uid}&local_date=gte.2026-10-01&undone_at=is.null&select=id,local_date,medication_name,medication_id,quantity,unit`),
]);
const controller = regimens.find((r) => r.role === 'controller' && r.puffs_per_occasion === 2);
const controllerMed = meds.find((m) => m.id === controller?.medication_id);
if (!controller || !/budesonide\/formoterol/i.test(controllerMed?.display_name ?? '')) {
  throw Error('Expected controller regimen was not found; nothing changed');
}

const active = events.filter((r) => !r.undone_at && r.payload?.undone !== true);
const fixtureScheduled = active
  .filter(
    (r) =>
      r.kind === 'medication_use' &&
      r.payload?.values?.fixture === 's10-rosa-v1' &&
      r.payload?.values?.use_kind === 'scheduled' &&
      /budesonide\/formoterol/i.test(r.payload?.values?.medication ?? ''),
  )
  .map((r) => r.local_date)
  .sort();
const lastFixture = fixtureScheduled.at(-1);
if (!lastFixture || lastFixture >= today) throw Error('Fixture schedule does not end before today');
const gapStart = addDays(lastFixture, 1);

const namedScheduled = (day) =>
  active.some(
    (r) =>
      r.local_date === day &&
      r.kind === 'medication_use' &&
      r.payload?.values?.use_kind === 'scheduled' &&
      /budesonide\/formoterol/i.test(r.payload?.values?.medication ?? '') &&
      r.payload?.values?.quantity === 2,
  );

const blankUses = active
  .filter(
    (r) =>
      r.local_date >= gapStart &&
      r.local_date <= today &&
      r.kind === 'medication_use' &&
      r.payload?.synthetic !== true &&
      !(r.payload?.values?.medication ?? '').trim(),
  )
  .sort((a, b) => a.created_at.localeCompare(b.created_at) || a.id.localeCompare(b.id));

const byDay = new Map();
for (const row of blankUses) {
  const list = byDay.get(row.local_date) ?? [];
  list.push(row);
  byDay.set(row.local_date, list);
}

const patches = [];
const undos = [];
for (const [day, rows] of byDay) {
  const scheduled = rows.filter((r) => r.payload?.values?.use_kind === 'scheduled' && r.patient_key === uid);
  const keep = scheduled[0];
  if (keep) patches.push(keep);
  for (const row of rows) if (row !== keep) undos.push(row);
}

const inserts = [];
for (let day = gapStart; day <= today; day = addDays(day, 1)) {
  const keeping = patches.some((r) => r.local_date === day);
  if (namedScheduled(day) || keeping) continue;
  const eventId = idFor(`align-controller-${day}`);
  const sourceId = idFor(`align-controller-source-${day}`);
  const name = controllerMed.display_name;
  inserts.push({
    id: eventId,
    patient_key: uid,
    kind: 'medication_use',
    day,
    source_id: sourceId,
    synthetic: false,
    text: `Scheduled: ${name} · 2 puffs`,
    values: {
      input_path: 'demo_alignment',
      occurred_at: `${day}T16:00:00.000Z`,
      language: 'en',
      use_kind: 'scheduled',
      medication: name,
      medication_id: controllerMed.id,
      regimen_id: controller.id,
      quantity: 2,
      unit: 'puffs',
      quantity_source: 'user_confirmed_visible_preset',
    },
  });
}

const seen = new Set();
const dropSnapshots = [];
for (const snap of snapshots) {
  if (!snap.event_local_date || snap.event_local_date < gapStart || snap.event_local_date > today) continue;
  const key = `${snap.event_local_date}:${snap.metric}`;
  if (seen.has(key)) dropSnapshots.push(snap);
  else seen.add(key);
}

const mirrorFixes = uses.filter(
  (row) =>
    row.local_date >= gapStart &&
    row.local_date <= today &&
    row.medication_id == null &&
    row.medication_name === controllerMed.display_name &&
    row.quantity === 2 &&
    row.unit === 'puffs',
);

const plan = {
  mode: apply ? 'apply' : 'audit',
  today,
  gapStart,
  lastFixtureScheduledDay: lastFixture,
  patchScheduled: patches.map((r) => ({ day: r.local_date, id: r.id })),
  undoBlank: undos.map((r) => ({ day: r.local_date, id: r.id, use: r.payload?.values?.use_kind, patient: r.patient_key === uid ? 'account' : 'subject' })),
  insertScheduled: inserts.map((r) => r.day),
  mirrorMedicationIds: mirrorFixes.map((r) => ({ day: r.local_date, id: r.id })),
  dropDuplicateSnapshots: dropSnapshots.map((s) => ({ day: s.event_local_date, metric: s.metric, value: s.value, id: s.id })),
  controller: controllerMed.display_name,
};
if (!apply) {
  console.log(JSON.stringify(plan, null, 2));
  process.exit(0);
}

mkdirSync('build/sprint10', { recursive: true });
const backup = `build/sprint10/daily-align-before-${Date.now()}.json`;
writeFileSync(
  backup,
  JSON.stringify(
    {
      events: events.filter((r) => r.local_date >= gapStart),
      snapshots: snapshots.filter((s) => s.event_local_date >= gapStart),
    },
    null,
    2,
  ),
);

const name = controllerMed.display_name;
for (const row of patches) {
  const payload = {
    ...row.payload,
    patient_key: uid,
    text: `Scheduled: ${name} · 2 puffs`,
    values: {
      ...row.payload.values,
      medication: name,
      medication_id: controllerMed.id,
      regimen_id: controller.id,
      quantity: 2,
      unit: 'puffs',
      quantity_source: 'user_confirmed_visible_preset',
    },
  };
  await api(`/rest/v1/treatment_events?id=eq.${row.id}&owner_id=eq.${uid}`, 'PATCH', {
    patient_key: uid,
    payload,
  });
  await api(`/rest/v1/medication_use_events?id=eq.${row.id}&patient_id=eq.${uid}`, 'PATCH', {
    medication_name: name,
    medication_id: controllerMed.id,
    quantity: 2,
    unit: 'puffs',
  });
}
for (const row of undos) {
  await api('/rest/v1/rpc/undo_treatment_source', 'POST', { p_source: row.source_id });
}
if (inserts.length) {
  await api('/rest/v1/rpc/save_treatment_batch', 'POST', { p_events: inserts });
  for (const row of inserts) {
    await api(`/rest/v1/medication_use_events?id=eq.${row.id}&patient_id=eq.${uid}`, 'PATCH', {
      medication_id: controllerMed.id,
    });
  }
}
for (const row of mirrorFixes) {
  await api(`/rest/v1/medication_use_events?id=eq.${row.id}&patient_id=eq.${uid}`, 'PATCH', {
    medication_id: controllerMed.id,
  });
}
if (dropSnapshots.length) {
  const ids = dropSnapshots.map((s) => s.id).join(',');
  await api(`/rest/v1/environment_snapshots?id=in.(${ids})&patient_id=eq.${uid}`, 'DELETE');
}

const check = await api(
  `/rest/v1/treatment_events?owner_id=eq.${uid}&local_date=gte.${gapStart}&local_date=lte.${today}&undone_at=is.null&select=local_date,kind,patient_key,payload&order=local_date.asc`,
);
const days = {};
for (const row of check) {
  const v = row.payload?.values ?? {};
  const label =
    row.kind === 'medication_use'
      ? `${v.use_kind}:${v.medication ?? 'unnamed'}:${v.quantity ?? 'no-qty'}`
      : row.kind === 'environment'
        ? `env:${v.category ?? v.metric ?? 'context'}`
        : row.kind;
  (days[row.local_date] ??= []).push(label);
}
console.log(JSON.stringify({ ...plan, backup, days }, null, 2));
