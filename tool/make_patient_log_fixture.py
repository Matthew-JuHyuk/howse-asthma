"""Synthetic data for the reviewed log layout; never writes to the app database."""
import json
from datetime import date, timedelta
from pathlib import Path

start = date(2026, 8, 4)  # 30 inclusive days ending September 2.
events = []
def event(key, kind, index, values):
    events.append(dict(id=key, patient_key='sample-maria', source_id=key,
        kind=kind, day=str(start + timedelta(days=index)), text='',
        values=values, synthetic=True, undone=False))

for i in range(30):
    event(f'env-{i}', 'environment', i, dict(metric='aqi',
        value=128 if i in [4, 6, 8, 10, 12, 14, 16] else 82,
        pollen_level='High' if 3 <= i <= 11 else 'Moderate', source_kind='observation'))
for i in [4, 6, 8, 10, 12, 14, 22, 26]:
    event(f'use-{i}', 'medication_use', i, dict(use_kind='as_needed',
        medication='Albuterol', medication_class='SABA', quantity=2, unit='puffs'))
for i in range(19):
    event(f'symptom-{i}', 'symptom', i, dict(symptom='cough', time_of_day='daytime',
        night_wakings=2 if i in [4, 10, 16] else 0))

for dose in range(51):
    event(f'scheduled-{dose}', 'medication_use', dose // 2,
        dict(use_kind='scheduled', medication='Fluticasone Propionate 110 mcg', quantity=2, unit='puffs'))

fixture = dict(patient_key='sample-maria', patient_name='Maria Santos',
    dob='1978-05-12', period_end='2026-09-02',
    controller='Fluticasone Propionate 110 mcg (2 puffs BID)',
    act_score=14, act_day='2026-09-02', scheduled_doses=60, logged_doses=51,
    synthetic=True, events=events)
path = Path('test/fixtures/patient_log_sample.json')
path.parent.mkdir(parents=True, exist_ok=True)
path.write_text(json.dumps(fixture, indent=2), encoding='utf-8')
print(path)
