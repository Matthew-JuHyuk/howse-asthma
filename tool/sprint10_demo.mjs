// Dedicated real-login demo account; fixtures live in Supabase, never in app code.
// node tool/sprint10_demo.mjs prepare | seed | refresh-documents | verify | credentials
// Credentials are stored only in the existing git-ignored .env.demo.
import {readFileSync,writeFileSync,appendFileSync,mkdirSync} from 'node:fs';
import {randomBytes,randomUUID,createHash} from 'node:crypto';
const env=p=>Object.fromEntries(readFileSync(p,'utf8').split(/\r?\n/).filter(x=>/^\w+=/.test(x)).map(x=>{const i=x.indexOf('=');return[x.slice(0,i),x.slice(i+1).trim()]}));
const e=env('.env'), cfg=env('.env.demo');
const command=process.argv[2];
if(!cfg.S10_EMAIL){
 const [name,domain]=e.TEST_EMAIL_RECIPIENT.split('@');
 cfg.S10_EMAIL=`${name}+sprint10-rosa@${domain}`;
 cfg.S10_PASSWORD=`S10!${randomBytes(18).toString('base64url')}`;
 appendFileSync('.env.demo',`\nS10_EMAIL=${cfg.S10_EMAIL}\nS10_PASSWORD=${cfg.S10_PASSWORD}\n`);
}
if(command==='credentials'){console.log(JSON.stringify({email:cfg.S10_EMAIL,password:cfg.S10_PASSWORD}));process.exit(0)}
let token;
async function api(path,method='GET',body,extra={}){
 const r=await fetch(e.SUPABASE_URL+path,{method,headers:{apikey:e.SUPABASE_ANON_KEY,...(token?{Authorization:`Bearer ${token}`} : {}),'Content-Type':'application/json',...extra},body:body===undefined?undefined:body instanceof Uint8Array?body:JSON.stringify(body)});
 const t=await r.text();let j;try{j=JSON.parse(t)}catch{j=t}
 if(!r.ok)throw new Error(`${method} ${path.split('?')[0]}: ${r.status} ${j.code??j.error_code??j.error??'request_failed'}`);
 return j;
}
let login;try{login=await api('/auth/v1/token?grant_type=password','POST',{email:cfg.S10_EMAIL,password:cfg.S10_PASSWORD})}catch{
 await api('/auth/v1/signup','POST',{email:cfg.S10_EMAIL,password:cfg.S10_PASSWORD,data:{full_name:'Rosa Martinez (DEMO)',role:'PATIENT',language_code:'es',demo_account:true,sprint10_demo:true}});
 login=await api('/auth/v1/token?grant_type=password','POST',{email:cfg.S10_EMAIL,password:cfg.S10_PASSWORD});
}
token=login.access_token;const uid=login.user.id;
if(login.user.email!==cfg.S10_EMAIL||login.user.user_metadata.sprint10_demo!==true)throw Error('Dedicated demo account guard failed');
const id=name=>{const h=createHash('sha256').update(uid+'/s10/'+name).digest('hex');return `${h.slice(0,8)}-${h.slice(8,12)}-4${h.slice(13,16)}-8${h.slice(17,20)}-${h.slice(20,32)}`};
const now=new Date(); const today=process.argv.find(x=>x.startsWith('--today='))?.slice(8)??`${now.getFullYear()}-${String(now.getMonth()+1).padStart(2,'0')}-${String(now.getDate()).padStart(2,'0')}`;
const day=n=>{const d=new Date(today+'T12:00:00Z');d.setUTCDate(d.getUTCDate()+n);return d.toISOString().slice(0,10)};
const patient=`${uid}/${id('diego')}`;
const docs=[
 {file:'01-treatment-history.pdf',title:'Prior prescribed treatment history',kind:'prescription',date:day(-110),lines:[`Record date: ${day(-5)}. Patient: Diego Martinez, age 14.`,`Controller prescribed from ${day(-110)}: budesonide/formoterol 160/4.5 mcg, two inhalations twice daily. This is a fictional existing prescription, not advice.`,`Rescue prescription: albuterol 90 mcg, two puffs as needed, as recorded in the fictional care plan. Prescription history does not prove adherence.`,`At the fictional review on ${day(-5)}, the family asked about a clinician-proposed Dupixent review. No eligibility determination has been made.`]},
 {file:'02-urgent-visit.pdf',title:'Urgent visit record',kind:'urgent_visit',date:day(-52),lines:[`Visit date: ${day(-52)}. Patient: Diego Martinez, age 14.`,`Family reported wheeze and shortness of breath after soccer. An urgent assessment and inhaled treatment were recorded. No hospitalization was recorded.`,`Follow-up with the usual care team was requested. This visit is within the prior 12 months but outside the app summary's 30-day window.`]},
 {file:'03-denial-notice.pdf',title:'Fictional initial authorization denial notice',kind:'notice',date:day(-3),lines:[`Notice date: ${day(-3)}. Patient: Diego Martinez. Requested medicine: Dupixent.`,`DEMO scenario plan: Aetna Better Health of New Jersey. This document is fabricated for demonstration; it was not issued by that organization.`,`The initial request is denied because prior controller treatment records and the relevant clinician assessment and test results were not included. This is a documentation scenario, not a determination that treatment is unsuitable.`,`For this fictional scenario only: submit additional information by ${day(10)}. A review request must be received by ${day(40)}. These are different dates. Contact the actual plan and care team to verify real procedures.`]},
 {file:'04-lab-to-upload-live.pdf',title:'Test result to add during the demonstration',kind:'lab',date:day(-2),lines:[`Specimen date: ${day(-2)}. Patient: Diego Martinez, age 14.`,`Absolute eosinophil count: 420 cells/uL. Fictional laboratory result for software demonstration only.`,`This isolated value does not establish eligibility, diagnosis, treatment failure or an indication for any medicine. The full assessment and interpretation remain with the care team.`]}
];
mkdirSync('build/sprint10',{recursive:true});
if(command==='prepare'){
 await api('/rest/v1/profiles?on_conflict=id','POST',{id:uid,role:'PATIENT',full_name:'Rosa Martinez (DEMO)',language_code:'es',home_zip:'07601',home_city:'Hackensack, NJ'},{Prefer:'resolution=merge-duplicates'});
 await api('/rest/v1/patient_details?on_conflict=patient_id','POST',{patient_id:uid},{Prefer:'resolution=ignore-duplicates'});
 writeFileSync('build/sprint10/demo-documents.json',JSON.stringify(docs,null,2));console.log(JSON.stringify({account:'created / password login verified',today,documents:4}));process.exit(0);
}
if(command==='seed'){
 const existing=await api(`/rest/v1/treatment_events?owner_id=eq.${uid}&select=id`);
 if(existing.length)throw Error('Refusing to overwrite a used demo account. Existing records retained; use verify.');
 const events=[];
 function event(key,kind,date,text,values={},subject=patient){const v={id:id(key),patient_key:subject,kind,day:date,source_id:id('source-'+key),text,values:{...values,fixture:'s10-rosa-v1'},synthetic:true,undone:false};events.push({id:v.id,owner_id:uid,patient_key:subject,source_id:v.source_id,local_date:date,kind,payload:v});return v.id}
 for(let n=-29;n<=-1;n++){
  event('controller'+n,'medication_use',day(n),'Caregiver reported scheduled controller use.',{use_kind:'scheduled',medication:'budesonide/formoterol',quantity:2,unit:'puffs',input_path:'caregiver_report'});
  if([-28,-25,-23,-20,-18,-15,-12,-10,-8,-6,-4,-2].includes(n))event('symptom'+n,'symptom',day(n),'Diego tuvo tos; Rosa confirmed the report.',{symptom:'cough',night_wakings:[-23,-15,-8,-2].includes(n)?2:0,language:'es',quote:'Diego tuvo tos.'});
  if([-28,-23,-20,-15,-12,-8,-6,-2].includes(n))event('rescue'+n,'medication_use',day(n),'Caregiver reported albuterol use as needed.',{use_kind:'as_needed',medication:'albuterol',quantity:2,unit:'puffs',input_path:'caregiver_report'});
 }
 event('negation','symptom',day(-3),'No tuvo silbidos hoy.',{symptom:'wheeze',negated:true,night_wakings:0,quote:'No tuvo silbidos hoy.'});
 event('unknown-med','medication_use',day(-5),'Used the blue inhaler; drug and dose unknown.',{use_kind:'unspecified',medication:null,quantity:null,uncertainty:'Color is insufficient to identify medicine.'});
 event('rosa-separate','symptom',day(-7),'Rosa reported her own cough. This is not Diego.',{symptom:'cough',night_wakings:0},uid);
 const documentRefs=[];const clinicalIds=[];
 for(const d of docs.slice(0,3)){
  const path=`${uid}/treatment/s10/demo/${d.file}`;
  await api('/storage/v1/object/appeal-documents/'+path,'POST',new Uint8Array(readFileSync('output/pdf/sprint10-demo/'+d.file)),{'Content-Type':'application/pdf','x-upsert':'true'});
  documentRefs.push({path,name:d.file,mime:'application/pdf',kind:d.kind,status:'confirmed'});
  clinicalIds.push(event('doc-'+d.kind,d.kind==='urgent_visit'?'urgent_visit':'clinical_document',d.date,d.title,{document_kind:d.kind,object_path:path,mime:'application/pdf',name:d.file,page:1,quote:d.lines[1],patient_name:'Diego Martinez',source:'synthetic_fixture'}));
 }
 await api('/rest/v1/treatment_events','POST',events,{Prefer:'return=minimal'});
 for(const variant of ['A','B']){
  const cid=id('case-'+variant);const denied=variant==='B';
  const needs=[{id:'treatment',label:'Prior treatment history',reason:'Care team must review the prior treatment record.',origin:denied?'notice':'applicable_policy',owner:'care_team',links:denied?[]:[clinicalIds[0]],state:denied?'missing':'linked_unreviewed',page:1},
   {id:'burden',label:'Symptoms and urgent visits',reason:'Patient reports plus prior-12-month visit; clinical review needed.',origin:'applicable_policy',owner:'care_team',links:[clinicalIds[1]],state:'linked_unreviewed',page:2},
   {id:'tests',label:'Test results and clinician assessment',reason:'Add the available test result and ask the care team for the full assessment.',origin:denied?'notice':'applicable_policy',owner:'care_team',links:[],state:'missing',page:1}];
  const p={id:cid,patient_key:patient,patient_name:'Diego Martinez (SAMPLE)',path:denied?'deniedRequest':'newRequest',concern:'Night cough and rescue use interfere with sleep and soccer. Caregiver wants a complete record for the care team.',current_medication:'Budesonide/formoterol 160/4.5 mcg, 2 puffs twice daily (fictional existing prescription); albuterol as needed per recorded care plan.',proposed_medication:'Dupixent',plan:'Aetna Better Health of New Jersey',policy_confirmed:true,revision:1,lifecycle:'active',needs,documents:denied?documentRefs:documentRefs.slice(0,2),exports:[],synthetic:true,english_fields:{},history:denied?[{type:'initial_drug_denial',date:day(-3),text:'SAMPLE: Outside-app initial request denied for missing documentation. This is an alternate scenario, not a continuation of A.',source:documentRefs[2].path},{type:'deadline',purpose:'information_response',date:day(10),text:docs[2].lines[3],page:1,source:documentRefs[2].path},{type:'deadline',purpose:'review_request',date:day(40),text:docs[2].lines[3],page:1,source:documentRefs[2].path}]:[]};
  await api('/rest/v1/appeal_cases','POST',{id:cid,owner_id:uid,title:'Dupixent',status:'draft',treatment_context:'asthma',case_start_reason:denied?'denied_request':'new_request',demo_mode:true,display_alias:denied?'B - Already denied / SAMPLE':'A - Before first request / SAMPLE',plan_name_cache:p.plan});
  await api('/rest/v1/case_preparations','POST',{case_id:cid,owner_id:uid,revision:1,payload:p});
 }
 console.log(JSON.stringify({seeded:true,events:events.length,cases:2,uploadedDocuments:3,liveUploadDocument:docs[3].file}));
}
const cases=await api(`/rest/v1/case_preparations?owner_id=eq.${uid}&select=case_id,payload,revision`);
if(command==='refresh-documents'){
 const replacements=new Map();
 for(const d of docs.slice(0,3)){
  const prior=cases.flatMap(c=>c.payload.documents).filter(x=>x.name===d.file);
  if(!prior.length||prior.some(x=>!x.path.startsWith(uid+'/treatment/s10/')))throw Error('Unreferenced document guard');
  const bytes=new Uint8Array(readFileSync('output/pdf/sprint10-demo/'+d.file));
  const hash=createHash('sha256').update(bytes).digest('hex');
  const path=`${uid}/treatment/s10/demo/${hash.slice(0,16)}/${d.file}`;
  const check=await fetch(e.SUPABASE_URL+'/storage/v1/object/authenticated/appeal-documents/'+path,{headers:{apikey:e.SUPABASE_ANON_KEY,Authorization:`Bearer ${token}`}});
  if(!check.ok)await api('/storage/v1/object/appeal-documents/'+path,'POST',bytes,{'Content-Type':'application/pdf'});
  else if(createHash('sha256').update(new Uint8Array(await check.arrayBuffer())).digest('hex')!==hash)throw Error('Versioned source hash mismatch');
  for(const doc of prior)replacements.set(doc.path,path);
 }
 const sourceRows=await api(`/rest/v1/treatment_events?owner_id=eq.${uid}&kind=in.(clinical_document,urgent_visit)&select=id,payload`);
 for(const row of sourceRows){
  const next=replacements.get(row.payload.values?.object_path);
  if(next)await api(`/rest/v1/treatment_events?id=eq.${row.id}&owner_id=eq.${uid}`,'PATCH',{payload:{...row.payload,values:{...row.payload.values,object_path:next}}});
 }
 for(const c of cases){
  c.payload={...c.payload,documents:c.payload.documents.map(d=>({...d,path:replacements.get(d.path)??d.path})),history:c.payload.history.map(h=>h.source?{...h,source:replacements.get(h.source)??h.source}:h)};
  c.revision=await api('/rest/v1/rpc/save_preparation','POST',{p_case_id:c.case_id,p_revision:c.revision,p_payload:c.payload});
 }
 console.log('Stored versioned synthetic originals and updated owned references; retained all source event IDs.');
}
const rows=await api(`/rest/v1/treatment_events?owner_id=eq.${uid}&select=payload`);
const foreign=await api(`/rest/v1/treatment_events?owner_id=eq.${randomUUID()}&select=id`);
if(foreign.length)throw Error('Unexpected cross-owner records');
let sourceFilesVerified=0;
const storedHashes={};
for(const doc of cases.find(x=>x.payload.path==='deniedRequest').payload.documents){
 const response=await fetch(e.SUPABASE_URL+'/storage/v1/object/authenticated/appeal-documents/'+doc.path,{headers:{apikey:e.SUPABASE_ANON_KEY,Authorization:`Bearer ${token}`}});
 const bytes=new Uint8Array(await response.arrayBuffer());
 if(!response.ok||new TextDecoder().decode(bytes.slice(0,5))!=='%PDF-')throw Error('Stored source PDF verification failed');
 const actual=createHash('sha256').update(bytes).digest('hex');
 const expected=createHash('sha256').update(readFileSync('output/pdf/sprint10-demo/'+doc.name)).digest('hex');
 if(actual!==expected)throw Error('Stored PDF differs from delivered document');
 storedHashes[doc.name]=actual;
 sourceFilesVerified++;
}
const child=rows.map(x=>x.payload).filter(x=>x.patient_key===patient&&x.day>=day(-29)&&x.day<=today&&!x.undone);
const a=cases.find(x=>x.payload.path==='newRequest')?.payload;
const b=cases.find(x=>x.payload.path==='deniedRequest')?.payload;
if(!a||!b||a.patient_key!==b.patient_key||a.documents.length!==2||b.documents.length!==3)throw Error('Scenario case mapping mismatch');
if(a.needs.find(n=>n.id==='treatment')?.links.length!==1||b.needs.find(n=>n.id==='treatment')?.links.length!==0)throw Error('Treatment evidence staging mismatch');
for(const c of [a,b])for(const need of c.needs)for(const link of need.links){
 if(!rows.some(x=>x.payload.id===link&&x.payload.patient_key===c.patient_key))throw Error('Evidence link points outside selected care subject');
}
for(const doc of b.documents){
 if(!rows.some(x=>x.payload.values?.object_path===doc.path&&x.payload.patient_key===b.patient_key))throw Error('Original document event reference mismatch');
}
if(![a,b].every(x=>x.needs.find(n=>n.id==='tests')?.links.length===0))throw Error('Test result should remain missing before recording');
if(rows.some(x=>x.payload.values?.document_kind==='lab'))throw Error('Live-upload lab must not be pre-seeded');
if(!rows.some(x=>x.payload.kind==='urgent_visit'&&x.payload.day===day(-52)))throw Error('Prior-year visit missing');
if(!b.history.some(x=>x.purpose==='information_response'&&x.date===day(10))||!b.history.some(x=>x.purpose==='review_request'&&x.date===day(40)))throw Error('Separate notice deadlines missing');
const stats={observedDays:new Set(child.filter(x=>!['clinical_document','environment'].includes(x.kind)).map(x=>x.day)).size,symptomDays:new Set(child.filter(x=>x.kind==='symptom'&&!x.values.negated).map(x=>x.day)).size,rescueUses:child.filter(x=>x.kind==='medication_use'&&x.values.use_kind==='as_needed').length,nightWakings:child.filter(x=>x.kind==='symptom').reduce((n,x)=>n+(x.values.night_wakings??0),0)};
if(cases.length!==2||stats.symptomDays!==12||stats.rescueUses!==8||stats.nightWakings!==8)throw Error('Fixture verification failed');
// Server invocation must require consent: do not fabricate the demo user's consent.
const gate=await api('/functions/v1/analyze-letter','POST',{action:'structure_record',case_id:cases[0].case_id,transcript:'Ayer Diego tosió.',today,patient_name:'Diego Martinez',language:'es',timezone:'America/New_York'}).catch(x=>({transport_error:x.message}));
if(!JSON.stringify(gate).includes('consent_required'))throw Error('Expected consent gate was not observed');
const report={date:today,accountPasswordLogin:'passed',caseCount:cases.length,eventCount:rows.length,sourceFilesVerified,storedHashes,expected30DaySummary:stats,scenarioMapping:{sameChildAcrossCases:true,A_initialRequest:true,B_deniedWithSeparateDeadlines:true,priorYearVisit:true,labIntentionallyNotUploaded:true,missingTestsInBothCases:true,treatmentEvidenceStaged:true,sourceLinksMatchChild:true},aiConsentGate:'passed: consent_required',foreignOwnerQuery:'empty',errorFreeSeed:true,careSubjectIsolation:rows.filter(x=>x.payload.patient_key===uid).length===1};
writeFileSync('build/sprint10/demo-verification.json',JSON.stringify(report,null,2));console.log(JSON.stringify(report));
