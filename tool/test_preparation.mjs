import assert from 'node:assert/strict';
import {test} from 'node:test';
import {validDay,validateProposals} from '../supabase/functions/analyze-letter/preparation_validate.ts';
const event=(quote,rest={})=>({kind:'symptom',quote,day:null,night_wakings:null,quantity:null,...rest});
test('calendar dates reject normalized impossible dates and timestamp strings',()=>{
 assert.equal(validDay('2026-02-30'),false);assert.equal(validDay('2024-02-29'),true);assert.equal(validDay('2026-10-22T00:00:00Z'),false);
});
test('English, Spanish and Korean exact source quotes preserve unknown fields',()=>{
 for(const quote of ['I do not know the dose.','No recuerdo cuántas veces.','몇 번인지는 기억나지 않아요.']){
  const result=validateProposals({events:[event(quote)]},quote);assert.equal(result[0].quantity,null);assert.equal(result[0].quote,quote);
 }
});
test('source fabrication and invalid counts fail closed',()=>{
 assert.throws(()=>validateProposals({events:[event('invented')]},'cough'));
 assert.throws(()=>validateProposals({events:[event('cough',{night_wakings:1.5})]},'cough'));
 assert.throws(()=>validateProposals({events:[event('cough',{quantity:-1})]},'cough'));
});
test('negation and corrected subject are preserved, not converted to medication use',()=>{
 const e=event('My son did not use it.',{kind:'medication_use',negated:true,subject:'other'});
 assert.deepEqual(validateProposals({events:[e]},e.quote),[e]);
});
test('oversized batches and invalid dates are rejected',()=>{
 assert.throws(()=>validateProposals({events:Array(13).fill(event('cough'))},'cough'));
 assert.throws(()=>validateProposals({events:[event('cough',{day:'2026-02-30'})]},'cough'));
});
