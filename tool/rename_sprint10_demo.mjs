// Update ONLY the marked existing S10 demo user; preserve auth UUID and all data.
// Usage: node tool/rename_sprint10_demo.mjs <new-email> <new-password>
import {readFileSync,writeFileSync} from 'node:fs';
import {spawnSync} from 'node:child_process';
const parse=p=>Object.fromEntries(readFileSync(p,'utf8').split(/\r?\n/).filter(x=>/^\w+=/.test(x)).map(x=>{const i=x.indexOf('=');return[x.slice(0,i),x.slice(i+1).trim()]}));
const env=parse('.env'),demo=parse('.env.demo');
const [email,password]=process.argv.slice(2);
if(!email?.includes('@')||!password||password.length<8)throw Error('Email and password (8+ characters) required');
const base=env.SUPABASE_URL;
const login=await fetch(base+'/auth/v1/token?grant_type=password',{method:'POST',headers:{apikey:env.SUPABASE_ANON_KEY,'Content-Type':'application/json'},body:JSON.stringify({email:demo.S10_EMAIL,password:demo.S10_PASSWORD})});
const session=await login.json();
if(!login.ok||session.user?.email!==demo.S10_EMAIL||session.user?.user_metadata?.sprint10_demo!==true)throw Error('Existing dedicated demo account guard failed');
const ref=readFileSync('supabase/.temp/project-ref','utf8').trim();
if(new URL(base).hostname!==ref+'.supabase.co')throw Error('Linked project mismatch');
const cli=spawnSync('C:/Users/LG/scoop/shims/supabase.exe',['projects','api-keys','--project-ref',ref,'--output','json'],{encoding:'utf8',windowsHide:true});
if(cli.status!==0)throw Error('Could not retrieve project admin key (output suppressed)');
let raw;try{raw=JSON.parse(cli.stdout)}catch{throw Error('Unrecognized key response (output suppressed)')}
const keys=Array.isArray(raw)?raw:raw.api_keys??raw.keys??[];
const key=keys.find(x=>x.name==='service_role')?.api_key;
if(!key)throw Error('Legacy service role key not available');
const updated=await fetch(base+'/auth/v1/admin/users/'+session.user.id,{method:'PUT',headers:{apikey:key,Authorization:`Bearer ${key}`,'Content-Type':'application/json'},body:JSON.stringify({email,password,email_confirm:true})});
if(!updated.ok)throw Error('Admin update failed: '+updated.status);
let text=readFileSync('.env.demo','utf8').replace(/^S10_EMAIL=.*$/m,'S10_EMAIL='+email).replace(/^S10_PASSWORD=.*$/m,'S10_PASSWORD='+password);
writeFileSync('.env.demo',text);
const test=await fetch(base+'/auth/v1/token?grant_type=password',{method:'POST',headers:{apikey:env.SUPABASE_ANON_KEY,'Content-Type':'application/json'},body:JSON.stringify({email,password})});
const result=await test.json();
if(!test.ok||result.user.id!==session.user.id)throw Error('Updated login verification failed');
console.log(JSON.stringify({email,passwordChanged:true,emailConfirmed:!!result.user.email_confirmed_at,sameUserId:true,login:'passed'}));
