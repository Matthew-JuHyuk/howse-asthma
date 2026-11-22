// Idempotent, dedicated-demo-only registration. Never rewrites historical use.
import {readFileSync} from 'node:fs';
import {createHash} from 'node:crypto';
const env=p=>Object.fromEntries(readFileSync(p,'utf8').split(/\r?\n/).filter(x=>/^\w+=/.test(x)).map(x=>{const i=x.indexOf('=');return [x.slice(0,i),x.slice(i+1).trim()]}));
const e=env('.env'), cfg=env('.env.demo');
let token;
async function api(path,method='GET',body){
 const r=await fetch(e.SUPABASE_URL+path,{method,headers:{apikey:e.SUPABASE_ANON_KEY,...(token?{Authorization:`Bearer ${token}`} : {}),'Content-Type':'application/json',Prefer:'return=representation'},body:body===undefined?undefined:JSON.stringify(body)});
 if(!r.ok)throw Error(`${method} ${path.split('?')[0]} failed (${r.status})`);
 const text=await r.text();return text?JSON.parse(text):null;
}
const login=await api('/auth/v1/token?grant_type=password','POST',{email:cfg.S10_EMAIL,password:cfg.S10_PASSWORD});
if(login.user?.email!==cfg.S10_EMAIL||login.user?.user_metadata?.sprint10_demo!==true)throw Error('Dedicated demo account guard failed');
token=login.access_token;
const uid=login.user.id;
const query=table=>`/rest/v1/${table}?patient_id=eq.${uid}`;
const records=await api(`/rest/v1/treatment_events?owner_id=eq.${uid}&kind=eq.medication_use&undone_at=is.null&select=payload,local_date`);
const cases=await api(`/rest/v1/case_preparations?owner_id=eq.${uid}&select=payload`);
const source=cases.map(x=>x.payload.current_medication??'').join(' ');
if(!/budesonide\/formoterol/i.test(source)||!/albuterol/i.test(source))throw Error('Existing fictional prescription does not match fixture');
const definitions=[
 {name:'Budesonide/formoterol 160/4.5 mcg',match:/budesonide\/formoterol/i,role:'controller',times:[480,1200]},
 {name:'Albuterol 90 mcg',match:/albuterol/i,role:'rescue',times:[]},
];
let meds=await api(query('patient_medications')+'&select=*');
let regimens=await api(query('medication_regimens')+'&select=*');
const apply=process.argv.includes('--apply');
const results=[];
for(const d of definitions){
 const matching=records.filter(r=>d.match.test(r.payload.values?.medication??''));
 if(!matching.length||matching.some(r=>r.payload.values?.quantity!==2||r.payload.values?.unit!=='puffs'))throw Error('Existing use records differ from the expected fictional prescription');
 let med=meds.find(m=>d.match.test(m.display_name));
 let created=false;
 if(!med&&apply){
  const h=createHash('sha256').update(uid+'/registered-demo/'+d.role).digest('hex');
  const id=`${h.slice(0,8)}-${h.slice(8,12)}-4${h.slice(13,16)}-8${h.slice(17,20)}-${h.slice(20,32)}`;
  [med]=await api('/rest/v1/patient_medications','POST',{id,patient_id:uid,display_name:d.name,is_default:d.role==='controller'&&!meds.some(m=>m.is_default),daily_check_enabled:d.role==='controller'});
  meds.push(med);created=true;
 }
 let regimen=med&&regimens.find(r=>r.medication_id===med.id&&r.effective_until===null);
 if(med&&!regimen&&apply){
  [regimen]=await api('/rest/v1/medication_regimens','POST',{patient_id:uid,medication_id:med.id,role:d.role,occasions_per_day:d.times.length,puffs_per_occasion:2,times_minutes:d.times,effective_from:matching.map(r=>r.local_date).sort()[0]});
 }
 if(regimen&&(regimen.role!==d.role||regimen.puffs_per_occasion!==2))throw Error('Existing regimen differs; retained without overwriting');
 results.push({medication:med?.display_name??d.name,existingUseCount:matching.length,registered:!!med,regimenRegistered:!!regimen,created});
}
const after=await api(query('patient_medications')+'&select=id,display_name');
console.log(JSON.stringify({mode:apply?'apply':'audit',results,registeredMedications:after.map(m=>m.display_name),registeredMedicationCount:after.length,historicalRecordsChanged:0},null,2));
