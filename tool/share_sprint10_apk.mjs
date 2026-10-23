// Publish an expiring private download for the user's explicitly requested email.
// No server key or signed URL is committed or printed.
import {readFileSync,writeFileSync} from 'node:fs';
import {spawnSync} from 'node:child_process';
import {createHash} from 'node:crypto';
const parse=p=>Object.fromEntries(readFileSync(p,'utf8').split(/\r?\n/).filter(x=>/^\w+=/.test(x)).map(x=>{const i=x.indexOf('=');return[x.slice(0,i),x.slice(i+1).trim()]}));
const env=parse('.env');
const ref=readFileSync('supabase/.temp/project-ref','utf8').trim();
if(new URL(env.SUPABASE_URL).hostname!==ref+'.supabase.co')throw Error('Project mismatch');
const result=spawnSync('C:/Users/LG/scoop/shims/supabase.exe',['projects','api-keys','--project-ref',ref,'--output','json'],{encoding:'utf8',windowsHide:true});
if(result.status!==0)throw Error('Project key lookup failed (output suppressed)');
const raw=JSON.parse(result.stdout),keys=Array.isArray(raw)?raw:raw.api_keys??raw.keys??[];
const key=keys.find(x=>x.name==='service_role')?.api_key;
if(!key)throw Error('Service key unavailable');
async function request(path,method='GET',body,mime='application/json'){
 const r=await fetch(env.SUPABASE_URL+'/storage/v1/'+path,{method,headers:{apikey:key,Authorization:`Bearer ${key}`,'Content-Type':mime},body:body===undefined?undefined:body instanceof Uint8Array?body:JSON.stringify(body)});
 const text=await r.text();let j;try{j=JSON.parse(text)}catch{j={}}
 return {ok:r.ok,status:r.status,json:j};
}
const bytes=readFileSync('build/sprint10/covernote-sprint10-demo.apk');
const sha=createHash('sha256').update(bytes).digest('hex');
const bucket='demo-builds';
const found=await request('bucket/'+bucket);
if(!found.ok){
 const created=await request('bucket','POST',{id:bucket,name:bucket,public:false,file_size_limit:100*1024*1024,allowed_mime_types:['application/vnd.android.package-archive']});
 if(!created.ok)throw Error('Private artifact bucket creation failed: '+created.status+' '+JSON.stringify(created.json));
}else if(found.json.public)throw Error('Refusing public artifact bucket');
const path=`sprint10/${sha}/covernote-sprint10-demo.apk`;
const upload=await request('object/'+bucket+'/'+path,'POST',bytes,'application/vnd.android.package-archive');
if(!upload.ok && !['Duplicate','409'].includes(String(upload.json.error)) && upload.status!==409)throw Error('APK upload failed: '+upload.status+' '+JSON.stringify(upload.json));
const expiresIn=7*24*3600;
const signed=await request('object/sign/'+bucket+'/'+path,'POST',{expiresIn});
if(!signed.ok)throw Error('Signed download creation failed: '+signed.status);
const relative=signed.json.signedURL??signed.json.signedUrl;
const url=relative.startsWith('http')?relative:env.SUPABASE_URL+'/storage/v1'+relative;
const verification=await fetch(url);
if(!verification.ok)throw Error('Signed download verification failed: '+verification.status);
const actual=createHash('sha256').update(new Uint8Array(await verification.arrayBuffer())).digest('hex');
if(actual!==sha)throw Error('Downloaded artifact hash mismatch');
writeFileSync('build/sprint10/apk-email-link.json',JSON.stringify({url,sha256:sha,bytes:bytes.length,expiresAt:new Date(Date.now()+expiresIn*1000).toISOString()},null,2));
console.log(JSON.stringify({privateUpload:'passed',downloadHash:'passed',bytes:bytes.length,expiresInDays:7}));
