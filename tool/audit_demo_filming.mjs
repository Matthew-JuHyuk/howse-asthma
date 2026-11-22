// Default: read-only audit of the dedicated demo account.
// Explicit --align-patient / --align-record-owner: backed-up, guarded demo alignment.
import {readFileSync,writeFileSync,mkdirSync} from 'node:fs';
const env=p=>Object.fromEntries(readFileSync(p,'utf8').split(/\r?\n/).filter(x=>/^\w+=/.test(x)).map(x=>{const i=x.indexOf('=');return[x.slice(0,i),x.slice(i+1).trim()]}));
const e=env('.env'),c=env('.env.demo');let token;
async function api(path,body,method=body?'POST':'GET'){const r=await fetch(e.SUPABASE_URL+path,{method,headers:{apikey:e.SUPABASE_ANON_KEY,...(token?{Authorization:`Bearer ${token}`} : {}),'Content-Type':'application/json'},body:body?JSON.stringify(body):undefined});if(!r.ok)throw Error(`Audit request failed: ${r.status} ${path.split('?')[0]}`);const text=await r.text();return text?JSON.parse(text):null}
const login=await api('/auth/v1/token?grant_type=password',{email:c.S10_EMAIL,password:c.S10_PASSWORD});
if(login.user?.email!==c.S10_EMAIL||login.user?.user_metadata?.sprint10_demo!==true)throw Error('Dedicated demo guard failed');token=login.access_token;const uid=login.user.id;
const [cases,rows,meds,regimens,profile]=await Promise.all([
api(`/rest/v1/case_preparations?owner_id=eq.${uid}&select=case_id,revision,payload`),
api(`/rest/v1/treatment_events?owner_id=eq.${uid}&select=payload,undone_at,local_date,kind`),
api(`/rest/v1/patient_medications?patient_id=eq.${uid}&select=display_name,is_default,daily_check_enabled`),
api(`/rest/v1/medication_regimens?patient_id=eq.${uid}&select=role,puffs_per_occasion,effective_from,effective_until`),
api(`/rest/v1/profiles?id=eq.${uid}&select=full_name,language_code,home_city,home_zip`)]);
const active=rows.filter(r=>!r.undone_at&&!r.payload.undone);
if(process.argv.includes('--align-record-owner')){
 const targetCases=cases.filter(c=>c.payload.synthetic===true&&c.payload.patient_name==='Diego Martinez (SAMPLE)'&&c.payload.patient_key.startsWith(uid+'/'));
 const keys=new Set(targetCases.map(c=>c.payload.patient_key));
 const targetRows=rows.filter(r=>keys.has(r.payload.patient_key)&&r.payload.synthetic===true&&['s10-rosa-v1','s10-ux-environment-v1'].includes(r.payload.values?.fixture));
 mkdirSync('build/sprint10',{recursive:true});
 const backup=`build/sprint10/filming-owner-before-${Date.now()}.json`;
 writeFileSync(backup,JSON.stringify({cases:targetCases,records:targetRows},null,2));
 for(const r of targetRows)await api(`/rest/v1/treatment_events?id=eq.${r.payload.id}&owner_id=eq.${uid}`,{patient_key:uid,payload:{...r.payload,patient_key:uid}},'PATCH');
 for(const c of targetCases)await api('/rest/v1/rpc/save_preparation',{p_case_id:c.case_id,p_revision:c.revision,p_payload:{...c.payload,patient_key:uid,revision:c.revision+1}});
 console.log(JSON.stringify({alignment:'done',knownDiegoFixtureRecords:targetRows.length,cases:targetCases.length,clinicalValuesAndDatesUnchanged:true,recordIdsAndLinksUnchanged:true,backup}));process.exit(0);
}
if(process.argv.includes('--align-patient')){
 const unrelated=active.filter(r=>r.payload.synthetic===true&&r.payload.values?.fixture==='s10-rosa-v1'&&r.payload.text==='Rosa reported her own cough. This is not Diego.'&&r.payload.patient_key===uid);
 mkdirSync('build/sprint10',{recursive:true});
 const backup=`build/sprint10/filming-alignment-before-${Date.now()}.json`;
 writeFileSync(backup,JSON.stringify({profile,excludedRecords:unrelated},null,2));
 for(const r of unrelated)await api('/rest/v1/rpc/undo_treatment_source',{p_source:r.payload.source_id});
 if(profile[0]?.full_name==='Rosa Martinez (DEMO)')await api(`/rest/v1/profiles?id=eq.${uid}`,{full_name:'Diego Martinez (DEMO)'},'PATCH');
 console.log(JSON.stringify({alignment:'done',excludedSyntheticCaregiverRecords:unrelated.length,profileName:'Diego Martinez (DEMO)',backup,otherRecordsUnchanged:true}));process.exit(0);
}
const counts=arr=>arr.reduce((a,x)=>(a[x]=(a[x]??0)+1,a),{});
const today=new Intl.DateTimeFormat('en-CA',{timeZone:'America/New_York'}).format(new Date());
const begin=new Date(today+'T12:00:00Z');begin.setUTCDate(begin.getUTCDate()-29);const from=begin.toISOString().slice(0,10);
const inWindow=active.filter(r=>r.local_date>=from&&r.local_date<=today);
const result={capturedAt:new Date().toISOString(),profile,window:{from,to:today},total:rows.length,active:active.length,counts:counts(active.map(r=>r.kind)),windowCounts:counts(inWindow.map(r=>r.kind)),windowDays:new Set(inWindow.filter(r=>['symptom','medication_use'].includes(r.kind)).map(r=>r.local_date)).size,medications:meds,regimens,cases:cases.map(({payload:p})=>({name:p.patient_name,path:p.path,revision:p.revision,needs:p.needs.map(n=>({id:n.id,label:n.label,links:n.links.length,state:n.state})),documents:p.documents.map(d=>d.name),history:p.history})),environment:active.filter(r=>r.kind==='environment').map(r=>({day:r.local_date,...r.payload.values})),otherPatientWarnings:active.filter(r=>/own cough|not Diego/i.test(r.payload.text)).map(r=>({day:r.local_date,text:r.payload.text})),recent:inWindow.filter(r=>r.kind!=='environment').sort((a,b)=>b.local_date.localeCompare(a.local_date)).slice(0,12).map(r=>({day:r.local_date,kind:r.kind,text:r.payload.text,values:r.payload.values}))};
result.patientAlignment={casesUseAccount:cases.every(c=>c.payload.patient_key===uid),knownDiegoFixturesUseAccount:active.filter(r=>['s10-rosa-v1','s10-ux-environment-v1'].includes(r.payload.values?.fixture)).every(r=>r.payload.patient_key===uid),caregiverFixtureActive:result.otherPatientWarnings.length};
result.selectedEnvironmentDates=result.environment.filter(r=>['2026-09-28','2026-10-07','2026-10-16'].includes(r.day));
mkdirSync('build/sprint10',{recursive:true});writeFileSync('build/sprint10/filming-data-audit.json',JSON.stringify(result,null,2));
console.log(JSON.stringify({...result,environment:{count:result.environment.length,categories:counts(result.environment.map(r=>r.category??r.metric??'unknown')),dates:result.environment.map(r=>r.day).sort().filter((_,i,a)=>i===0||i===a.length-1)},cases:result.cases.map(p=>({...p,history:p.history.map(h=>({type:h.type,date:h.date,purpose:h.purpose}))})),recent:result.recent.slice(0,5)},null,2));
