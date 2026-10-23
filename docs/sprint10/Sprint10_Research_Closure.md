# Sprint10 남은 확인사항 조사 결론·설계 반영 v1.5
확인일 2026-10-22 America/New_York. PUBLIC_SOURCE_CHECKED, DESIGN_RESOLVED, NEEDS_RUNTIME, NEEDS_HUMAN, BLOCKED_SOURCE를 구분한다. 미검증을 완료로 바꾸지 않는다.

## 1. 대상 규모와 발표용 인용 — 공개자료 조사 종료 기준
| 항목 | 확인값/상태 | 사용 범위 |
|---|---|---|
| NJ 소아 현재 천식 | 2023 NSCH 추정153,048명,7.8% | 전체 소아 천식 분모, 목표앱 이용자 수 아님 |
| NJ 성인 현재 천식 | 2023 BRFSS 추정627,531명,8.6% | 별도 조사·성인 분모 |
| NJ 가정 내 비영어 사용 | ACS2020~2024,5세 이상33.1% | 언어 다양성 배경. 영어 미숙·의료언어장벽 비율과 다름 |
| Medicaid×언어장벽×약변경/거절 | 현행 공동분포 미확보 | 숫자/통계적 범위 발표 제외 |
CDC: https://www.cdc.gov/asthma-data/about/most-recent-asthma-data.html
Census: https://www.census.gov/quickfacts/NJ
새로 확인한 2023~2024 묶음 추정치는 다른 기간/조사 설계이므로 위2023값과 혼합하지 않는다. 소아+성인 합산은 다른 조사 추정치의 단순합이며 대표 페르소나 규모로 사용하지 않는다. 민족/모국어/저소득/Medicaid를 동일 범주로 치환하지 않는다.

구체적인 교집합을 추정할 신뢰할 만한 현재 분모와 조건부확률이 없어 ‘몇 명’이라는 단일 숫자는 방어하기 어렵다. 이 항목은 조사를 하지 않은 상태가 아니라, 확보된 근거로 식별 불가능하다는 결론으로 처리한다. 제품 대상을 불필요하게 이 모든 조건의 교집합으로 제한하지 않는다. 최초신청경로에는 거절 경험이 필요 없으며, 사용에 Medicaid/비영어 사용을 의무 입력으로 강제하지 않는다.
발표 추천 인용: “2023년 조사에서 NJ 소아 약15만3천 명이 천식이 있는 것으로 추정됐습니다.” 통계는 오프닝 이후/설명자료에서1개만. “NJ에서5세이상 약3분의1이 가정에서영어이외언어를사용합니다”는 언어 다양성 설명으로만. 이를 영어장벽 환자 수라고 말하지 않는다.

내부 계획 민감도 예시만 허용: N=153048×q. q를1%/3%/5%로 임의 가정하면 각각약1530/4591/7652. q는 관측률·통계적추정·신뢰구간이 아니며 본문 발표/시장규모 숫자로 사용하지 않는다. 실제 q는 향후 동의된 사용자 조사/집계 claims와 survey 결합으로 검증해야 한다. 집계 요청수와 고유 환자수·가구수를 구분한다.
과거 CDC 연구에는 NJ Medicaid/CHIP 소아천식/ED비용 추정이 있으나 기반연도2010/2011이므로 현재규모·가격으로 사용하지 않는다. https://www.asthmacommunitynetwork.org/sites/default/files/resource_files/CDC-PedAsthmaED.pdf
추가로 확인한 Aetna2025 PA 공개 통계는 제목상약제를제외한다. 약물거절률/우리앱성과로차용금지: https://www.aetnabetterhealth.com/content/dam/aetna/medicaid/newjersey/pdf/2025_ABHNJ_CMS_Web_Metrics-Member.pdf

## 2. 환경 소스 계약 — 새로운유료구독 없이 우선 설계
| 데이터 | 우선 소스/계약 | 구현시 필수검증 |
|---|---|---|
| 현재 지역 AQI | AirNow 선택지역 관측·캐시 | reporting area를주소실측으로보이지않게,오염물질/시각/예보구분 |
| 과거 대기 | EPA AQS/AirData의공개파일/API | 시점/지점/자료품질/확정지연,현재값소급금지 |
| 기상·실외습도·홍수경보 | NWS 관측/alerts | User-Agent·rate limit·cache,경보없음/조회실패구분 |
| 꽃가루 | 기존공급자 실제라이선스·지역/기간확인 | 공급자없으면미제공,임의값·AI추정금지 |
| 트럭노출/매연 | 실제확보한교통측정 또는사용자보고 | AQI로디젤·트럭기여도판정금지 |
| 산불연기/침수후실내습기 | 날짜있는공식사건/보고·생활보고 | 원인확정/실내곰팡이측정위장금지 |
소스확인: https://docs.airnowapi.org/faq ; https://www.epa.gov/aqs/obtaining-aqs-data ; https://www.weather.gov/documentation/services-web-api
AirNow는동일지역시간캐시를권고하며모든ZIP반복조회로DB를만드는용도가아니다. AQS는과거자료,AirNow는실시간목적에맞게선택. 문서에접근한것과실제지역API응답검증은다르다. 키가필요하면운영자가보유한키를환경설정으로제공,구매/키발급을대행하지않는다.
source envelope: provider,kind(observed/forecast/reported/synthetic),spatial_scope,area_or_station,parameter,unit,observed_at,fetched_at,valid_period,quality,missing_reason. 데이터없음/미지원/오래됨/사용자지역없음을구분. 로컬설정의신선도허용값은정책자료인것처럼표시하지않는다.
Demo는대표환경사건1개를합성으로일관되게보여줄수있으나,Live는실제확보지역/시각데이터만. 환경확보실패가음성/복약저장을막지않는다. 세밀위치불허시선택동네,상시GPS추적없음. 사용자가현재동네밖에있으면과거노출위치를추측하지않고기본지역맥락임을표시한다.

## 3. 소송 사실확인 종료 범위
2023 소송제기·원고·의원지지는이미확인. Sokolich/Galler 사건번호2:23-cv-21728. 공개docket미러는과거기록중심이고최신진행/종결을확정할현재법원기록은확보하지못했다. ‘현재의원실이소송중’이라는앱/영상문구를제외하는설계결정으로종료. 다른주체의별도소송결과를이사건에대입하지않는다.
참고: https://dockets.justia.com/docket/new-jersey/njdce/2:2023cv21728/535304
현재MTA의NJ완화예산은별도확인된기존5B를유지. 앱은정책인과/보상대상결정을하지않는다. 현재소송상태는핵심개발의선행조건이아니다.

## 4. CAC 제출요건 재확인
공식2026규정: 기능이작동해야하고,1~3분영상에는참가자/앱명/목적/대상/도구·언어/실기능이필요. 공개YouTube/Vimeo. 실제앱/소스접근을요구받을수있음. AI는보조용도·전체기술개발대체불가,실제학생기여/이해와사용공개가필요. ‘학생이설명만나중에한다’고자격이확정되는것은아니다.
https://www.congressionalappchallenge.us/wp-content/uploads/2026/05/2026-CAC-Rules.pdf
마감충돌재확인: 규정PDF10/26정오EDT,전국등록페이지동일일21:00ET,NJ05페이지20:00. 공식확인된충돌이며임의로하나를최종정답으로택하지않는다. 계획은10/25제출목표,확인없이는10/26정오이전기준. 지역사무실/최종접수화면확인은사용자다음행동으로남김. 현재연락/제출미실행.
https://www.congressionalappchallenge.us/students/student-registration/
https://gottheimer.house.gov/congressional-app-challenge
실제포털은 https://webportalapp.com/sp/login/congressional_app_challenge_2026 로그인화면까지확인. 로그인후정확한필드/파일요건은미열람이며이름/주소/연락처를임의입력하지않음. 소스/APK업로드가공통필수라고단정하지않고실제폼에서확인.
개발은학생분담을기다릴필요없이진행할수있으나AI로개발한범위를이후학생독자개발로소급표현하지않는다. 실질학생구현/수정/이해의증거와모듈별기여표는최종제출판단전에검토. 접수가능/당선가능을확정하지않는다.

## 5. 미완료항목을 실제로 끝낼 게이트
정책본문과공개숫자·소스계약·제출공개요건은위범위내확인. 실제앱/사용자/영상/로그인포털은별도Validation_Gates문서에담당·입력·통과증거를정의. 코드미접근상태에서완료체크하지않는다. 영상접근실패는다시같은URL을계속검색하지않고파일제공후프레임분석으로재개.
