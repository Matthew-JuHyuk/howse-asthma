"""Package Korean scenarios and synthetic inputs; never include account secrets."""
import json
import zipfile
import hashlib
from pathlib import Path
from pypdf import PdfReader

root=Path('output/pdf/sprint10-demo')
report=json.loads(Path('build/sprint10/demo-verification.json').read_text(encoding='utf-8'))
pdfs=sorted(root.glob('*.pdf'))
assert len(pdfs)==5
for p in pdfs:
    reader=PdfReader(p)
    assert len(reader.pages)==1, p
    text=reader.pages[0].extract_text()
    assert 'SYNTHETIC' in text and 'Diego Martinez' in text, p
manifest=json.loads(Path('build/sprint10/demo-documents.json').read_text(encoding='utf-8'))
for d in manifest[:3]:
    normalized=lambda s:' '.join(s.split())
    assert normalized(d['lines'][1]) in normalized(PdfReader(root/d['file']).pages[0].extract_text()), d['file']
    assert report['storedHashes'][d['file']]==hashlib.sha256((root/d['file']).read_bytes()).hexdigest()
assert all(report['scenarioMapping'].values())
stats=report['expected30DaySummary']
audit=f'''# Sprint 10 데모 DB·문서 점검 결과 — 한글

점검 기준일: {report['date']}. 실제 데모 계정으로 비밀번호 로그인 후 RLS가 적용된 REST API와 스토리지에서 조회했다. 운영 환자 데이터나 앱 하드코딩은 사용하지 않았다.

| 항목 | 실제 결과 |
|---|---|
| 로그인 | {report['accountPasswordLogin']} — diego@example.com |
| 케이스 / 기록 | {report['caseCount']}개 / {report['eventCount']}건 |
| Diego 30일 보고일 | {stats['observedDays']}일 |
| 증상 보고일 / 필요시 사용 / 각성 | {stats['symptomDays']}일 / {stats['rescueUses']}건 / {stats['nightWakings']}회 |
| A/B 같은 care subject | 확인 |
| A 최초 준비 / B 거절 대응 | 확인 |
| 처방 근거 A 연결·B 미연결 | 확인 |
| 두 케이스 검사 근거 미연결 | 확인 — 실연 시작 상태 |
| 과거 방문 | 52일 전 기록 확인, 12개월에 해당 |
| 두 기한 | 추가정보 2026-11-01 / 검토 요청 2026-12-01 확인 |
| 원본 PDF 다운로드·해시 | {report['sourceFilesVerified']}개 일치 |
| 포털/종이 검사 PDF | 의도적으로 DB 미등록 — TC-05/06에서 입력 |
| Rosa 본인 기록 분리 | {report['careSubjectIsolation']} |
| 임의 다른 owner 조회 | {report['foreignOwnerQuery']} — 비어 있음. 이것만으로 모든 RLS 변경 공격을 검증한 것은 아님 |
| AI 최초 동의 차단 | {report['aiConsentGate']} |
| 로컬 PDF | 5개 모두 1페이지·SAMPLE 확인, 세 사전 등록 문서의 인용문 일치 |

개선된 문서는 해시를 포함한 새 경로로 저장하고 기존 케이스/이벤트 ID를 유지한 채 경로 참조를 갱신했다. 과거 파일은 파괴적으로 삭제하지 않았다. 저장소 UPDATE 정책을 완화하지 않았다.

## 자동 검사와 실기기 테스트 구분

이 결과는 계정·DB 초기 상태·원본 다운로드 검사다. 사진 OCR/ASR/AI 추출 정확도, 공유창·알림·잠금 동작은 실제 기기에서 아직 확인하지 않았다. 상세 수동 항목은 `test_scenarios_ko.md`를 따른다. APK 빌드 성공은 해당 기능 테스트 통과를 뜻하지 않는다.

## 등록된 원본 해시

'''
for name,sha in report['storedHashes'].items():
    audit+=f'- `{name}`: `{sha}`\n'
Path('docs/sprint10/db_demo_audit_ko.md').write_text(audit,encoding='utf-8')
Path('docs/sprint10/demo_recording_scenario.md').write_text('''# Sprint 10 한글 시나리오 안내

1. [기능 테스트 시나리오 — 절차·기대값·DB 초기 상태](test_scenarios_ko.md)
2. [데모 영상 시나리오 — 3분 촬영 순서·대사·편집](demo_video_scenario_ko.md)
3. [실제 DB 및 원본 문서 점검 결과](db_demo_audit_ko.md)

핵심 문서는 포털 검사 PDF, 종이 검사 결과 인쇄본, 우편 거절 통지서다. 보조 처방·응급 방문 자료와 함께 `output/pdf/sprint10-demo/`에 있다. 전체 묶음: `output/sprint10-demo-kit.zip`.

로그인 이메일: `diego@example.com`. 비밀번호는 git 제외 `.env.demo`에서 관리한다. Rosa 계정과 Diego care subject의 데이터는 유지했다.
''',encoding='utf-8')
Path('output').mkdir(exist_ok=True)
with zipfile.ZipFile('output/sprint10-demo-kit.zip','w',zipfile.ZIP_DEFLATED) as z:
    for p in pdfs:z.write(p,'documents/'+p.name)
    for name in ['demo_recording_scenario.md','test_scenarios_ko.md','demo_video_scenario_ko.md','db_demo_audit_ko.md']:
        z.write(Path('docs/sprint10')/name,'scenarios/'+name)
    build_guide=Path('docs/sprint10/apk_build_ko.md')
    if build_guide.exists(): z.write(build_guide,'scenarios/'+build_guide.name)
print('Packaged five PDFs and Korean guides; no credentials or keys included.')
