// Read-only authenticated checks. Empty transcripts prevent paid model calls.
import {readFileSync} from 'node:fs';
import {randomUUID} from 'node:crypto';
import assert from 'node:assert/strict';
const env = path => Object.fromEntries(readFileSync(path,'utf8').split(/\r?\n/).filter(x=>/^\w+=/.test(x)).map(x=>{const i=x.indexOf('=');return [x.slice(0,i),x.slice(i+1).trim()]}));
const e=env('.env'), demo=env('.env.demo');
const loginResponse=await fetch(e.SUPABASE_URL+'/auth/v1/token?grant_type=password',{method:'POST',headers:{apikey:e.SUPABASE_ANON_KEY,'Content-Type':'application/json'},body:JSON.stringify({email:demo.S10_EMAIL,password:demo.S10_PASSWORD})});
assert.equal(loginResponse.status,200,'demo sign-in');
const login=await loginResponse.json();
const uid=login.user.id;
const headers={apikey:e.SUPABASE_ANON_KEY,Authorization:`Bearer ${login.access_token}`,'Content-Type':'application/json'};
const rows=await (await fetch(e.SUPABASE_URL+`/rest/v1/case_preparations?owner_id=eq.${uid}&select=payload`,{headers})).json();
const child=rows.find(r=>r.payload.patient_key!==uid)?.payload.patient_key;
async function check(key,expected){
 const response=await fetch(e.SUPABASE_URL+'/functions/v1/analyze-letter',{method:'POST',headers,body:JSON.stringify({action:'structure_record',patient_key:key,transcript:''})});
 const result=await response.json();
 assert.equal(result.error,expected,'record authorization or validation mismatch');
}
await check(randomUUID(),'patient_not_found');
await check(`${uid}/${randomUUID()}`,'patient_not_found');
await check(uid,'invalid_transcript');
assert.ok(child,'existing care subject');
await check(child,'invalid_transcript');
console.log('PASS: foreign owner blocked; unregistered subject blocked; owner and registered child reach input validation without a case. No model call or record write.');
