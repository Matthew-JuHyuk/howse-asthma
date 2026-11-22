"""Package the verified scenario, not a fabricated demonstration video."""
import json
import re
import zipfile
from pathlib import Path

root = Path(__file__).resolve().parents[1]
docs = root / 'docs/sprint10'
main = (docs / 'cac_2026_zoom_demo_ko.md').read_text(encoding='utf-8')
sections = re.findall(r'^### (S\d+[^\n]*)\n(.*?)(?=^### |^## |\Z)', main, re.M | re.S)
prompt = ['# CoverNote — English reading copy', '',
          'Target: 02:50. English UI. Read only the quoted lines below.',
          'S06 Spanish audio is played from the real device recording; both presenters stay silent during that clip.',
          'Use the Korean master guide for fallback wording and screen actions.', '']
metrics = []
for heading, body in sections:
    lines = re.findall(r'^> (.+)$', body, re.M)
    prompt.extend(['## '+heading, ''])
    for i, line in enumerate(lines):
        if heading.startswith('S02'):
            prompt.extend(['[Matthew]' if i == 0 else '[Curt]', ''])
        if heading.startswith('S06'):
            prompt.extend([['[Curt 01:07–01:12]', '[Recorded Spanish 01:12–01:21 — presenters silent]', '[Curt 01:21–01:34]'][i], ''])
        prompt.extend([line, ''])
    words = len(re.findall(r"[\w]+(?:[’'-][\w]+)*", ' '.join(lines)))
    metrics.append({'scene': heading.split(' · ')[0], 'spokenWordsIncludingSpanish': words})
(docs / 'cac_2026_teleprompter_en.md').write_text('\n'.join(prompt), encoding='utf-8')
assert len(sections) == 12, 'Missing script scene'

files = [docs / n for n in ['cac_2026_zoom_demo_ko.md', 'cac_2026_demo_shotlist_ko.md',
                           'cac_2026_rules_evidence_ko.md', 'cac_2026_teleprompter_en.md']]
files += sorted((root / 'output/pdf/sprint10-demo').glob('*.pdf'))
out = root / 'output/cac-2026-zoom-demo-kit.zip'
readme = '''# CoverNote CAC 2026 Zoom filming kit

Start: docs/sprint10/cac_2026_zoom_demo_ko.md
English reading copy: docs/sprint10/cac_2026_teleprompter_en.md
Actions/data: docs/sprint10/cac_2026_demo_shotlist_ko.md
Rules/evidence: docs/sprint10/cac_2026_rules_evidence_ko.md

All patient documents in output/pdf/sprint10-demo are fictional.
The main film photographs only 03-denial-notice.pdf; 04/05 are optional tests.
Use the Diego report generated in the app, not the separate Maria layout sample.
This archive contains planning documents and sample source PDFs, not a recorded video.
APK 1.0.17 is supplied separately. Do not include credentials in the public film.
'''
with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED) as z:
    z.writestr('README.md', readme)
    for f in files:
        z.write(f, f.relative_to(root).as_posix())
    z.writestr('script_word_counts.json', json.dumps(metrics, indent=2))
print(json.dumps({'archive': str(out), 'files': len(files)+2,
                  'scenes': len(sections), 'totalSpokenWordsIncludingSpanish': sum(m['spokenWordsIncludingSpanish'] for m in metrics),
                  'perScene': metrics}, ensure_ascii=False, indent=2))
