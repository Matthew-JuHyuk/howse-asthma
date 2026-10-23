/** Pure validation; no model, storage or credentials. */
export function validDay(value: unknown): boolean {
  if(typeof value!=='string'||!/^\d{4}-\d{2}-\d{2}$/.test(value))return false;
  const d=new Date(value);
  return Number.isFinite(d.getTime())&&d.toISOString().slice(0,10)===value;
}
export function validateProposals(raw:unknown,transcript:string):Record<string,unknown>[] {
 const events=(raw as {events?:unknown})?.events;
 if(!Array.isArray(events)||events.length>12)throw Error('invalid_proposal');
 return events.map(e=>{
  if(!e||!['symptom','medication_use','urgent_visit'].includes(e.kind)||typeof e.quote!=='string'||!e.quote.trim()||!transcript.includes(e.quote))throw Error('unsupported_source');
  if(e.day!==null&&!validDay(e.day))throw Error('invalid_date');
  if(e.night_wakings!==null&&(!Number.isInteger(e.night_wakings)||e.night_wakings<0||e.night_wakings>100))throw Error('invalid_count');
  if(e.quantity!==null&&(typeof e.quantity!=='number'||!Number.isFinite(e.quantity)||e.quantity<=0))throw Error('invalid_quantity');
  return e;
 });
}
