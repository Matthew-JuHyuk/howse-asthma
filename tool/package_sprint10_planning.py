"""Package reconstructed planning texts, retaining explicit source limitations."""
from pathlib import Path
import hashlib
import json
import zipfile

root = Path(__file__).resolve().parents[1] / 'docs' / 'sprint10'
names = [
    'CoverNote_Sprint10_Integrated_Requirements.md', 'Cursor_Sprint10_Prompt.txt',
    'CoverNote_Sprint10_Demo_Outline.md', 'START_HERE_Sprint10.md',
    'Sprint10_All_Prompts.md', 'Sprint10_Model_and_Usage_Plan.md',
    'Sprint10_Request_Coverage_Audit.md', 'CoverNote_Filming_Reference_Guide.md',
    'CAC_Video_Sources_and_Access_Log.md', 'Sprint10_Verified_Policy_Mapping.md',
    'Sprint10_Research_Closure.md', 'Sprint10_Validation_Gates.md',
]
manifest = {
    'sync_date': '2026-10-22', 'timezone': 'America/New_York',
    'planning_revision': '1.5',
    'source_chat_title': 'Sprint 8 프롬프트 작성',
    'source_chat_id': '6ad82d4d-b148-83ea-9baf-e3208a13c496',
    'source_execution_id': '01a15c71-01d8-7150-83e2-610653e7d01d',
    'method': 'Reconstructed from recorded document creation/update commands; original archive identity not verified.',
    'local_annotations': ['START_HERE_Sprint10.md'],
    'missing': [{'name': 'references/Dupixent_Official_NJ.pdf', 'reason': 'Original remote binary unavailable; official CDN returned 403.',
                 'reported_bytes': 289867, 'reported_sha256': '7f8cb604f95511aea4597fd2d82cb552da319238f0f1c3844ddeed0868141f21'}],
    'files': [],
}
for name in names:
    data = (root / name).read_bytes()
    manifest['files'].append({'name': name, 'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()})
(root / 'sync_manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
with zipfile.ZipFile(root / 'CoverNote_Sprint10_Planning_Package.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
    for name in [*names, 'SYNC_STATUS.md', 'sync_manifest.json']:
        archive.write(root / name, name)
    assert archive.testzip() is None
print(f'Packaged {len(names)} planning texts; source limitations and manifest included.')
