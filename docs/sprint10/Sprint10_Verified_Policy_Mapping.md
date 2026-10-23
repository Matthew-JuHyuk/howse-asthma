# Sprint10 정책 근거·자료 연결 설계 v1.5
확인일 2026-10-22 America/New_York. 설계·출처 검증이며 실제 보험심사나 환자 처방 판단이 아니다.

## 공식 문서 확인 결과
Aetna Better Health of New Jersey의 Dupixent 공식 프로토콜 4페이지를 열고 천식 부분(p1~2)을 시각 확인했다. 표지의 최근 DURB 승인 표기는 2025-10, Commissioners 승인 표기는 2026-02이다. 시행일이 별도로 확인됐다는 뜻은 아니다. 공식 안내의 Dupixent 링크와 일치한다.
원본 사본: references/Dupixent_Official_NJ.pdf. SHA256 7f8cb604f95511aea4597fd2d82cb552da319238f0f1c3844ddeed0868141f21. 289867 bytes. 향후 배포 전 현재 정책 및 실제 가입상품 적용 여부 재확인.

## 정책 항목과 자료 연결 — 간결한 요약, 전체 원문을 대체하지 않음
| 식별자/위치 | 확인한 기준의 요지 | 앱에서 연결할 자료 |
|---|---|---|
| G1~6 / p1 | 연령·동시치료·전문의·금기·해당 시 체중·허용 적응증/용법 등 공통 조건 | 진료팀 확인 영역 |
| A-a / p1 | 중등도~중증 천식. 호산구 표현형과 현재 혈중수치 ≥150 cells/µL 또는 경구 스테로이드 의존 경로 | 진단/검사/진료 문서 |
| A-b / p1~2 | 최근 최소3개월 최대내약 기존 치료. 12세 이상은 ICS/LABA에 LAMA·LTRA·theophylline 중 해당 조합, 세부 대안은 원문 유지 | 처방 이력·시작/종료·진료팀 검토 |
| A-c / p2 | 요청약과 함께 기존 치료 지속 | 진료팀 계획 |
| A-d / p2 | 지난12개월 기존 치료 중 전신스테로이드 필요 악화≥2회, 입원/응급진료 필요 악화≥1회, 또는 조절불량 증상 경로 | 악화/ED 문서, 증상·구제약·활동·야간 기록 |
14세 예시는 12세 이상 분기를 사용. 6~11세 분기는 별도이므로 같은 조건을 복제하지 않는다. 정책 문구의 빈도 표현에 앱이 임의 수치 기준을 만들지 않는다.
출처: https://www.aetnabetterhealth.com/newjersey/providers/pharmacy-guidelines.html
원문: https://www.aetnabetterhealth.com/content/dam/aetna/medicaid/pdfs/formulary/guidelines/Dupixent-Protocol-NJ-ua.pdf

## 앱 로직으로 확정할 설계
위 표는 정책의 모든 예외/적응증/투약량/승인조건을 구현한 자격 판정기가 아니다. 전체 정책의 적용 확인과 임상 판단은 진료팀에 남긴다. 기간은 달력 월/원문 기준을 보존하고 3개월=최근 앱30일 기록으로 대체하지 않는다. 다른 질환의 호산구 기준을 섞지 않는다.
각 requirement는 policy_id, indication, age_branch, clause, page, source_url, checked_at, policy_approval_labels, evidence_candidates[], reviewer, review_state를 보존. 전체 원문 사본 해시와 조회일을 연결하되 approval label을 effective_date로 오인하지 않는다. 실제 가입상품 확인 전 policy_match=unconfirmed.
연결 상태는 ‘자료 없음/후보/연결됨/진료팀 확인 필요’. 혈액검사 수치가 있어도 임상 조건 충족·승인을 자동 선언하지 않는다. 비교용 숫자 판독은 단위·환자·검사일·원문일치 확인에만 사용하며 임상자격 점수 금지. 앱 로그로 최대내약·정확한 흡입·준수를 입증했다고 처리하지 않는다.
현재 증상/구제약 이벤트를 정책의 어떤 항목이 참고하는지 연결하되 환자가 정책 기준을 맞추려고 약 사용량/증상을 바꾸게 유도하지 않는다. 미확보 검사자료를 ‘추가 증상 기록’으로 채우지 않는다.

## 최초 요청에 필요한 문서
공식 universal pharmacy PA form 2페이지 확인: 환자·처방자·약 정보, 기존 치료 기간/중단 이유, 관련 검사, 임상자료와 처방자 서명 영역. 진료기록 없이 불완전한 서식은 반환될 수 있다는 안내가 있다. 앱의 요약만으로 공식 신청서가 완성됐다고 표시하지 않는다. NPI/서명/의학적 소견은 생성하지 않는다. 서식은 자주 바뀌므로 사용 직전 원본 확인.
출처: https://www.aetnabetterhealth.com/newjersey/providers/pharmacy-prior-authorization.html
서식: https://www.aetnabetterhealth.com/content/dam/aetna/medicaid/pdfs/formulary/fax-forms/Universal-Pharmacy-Prior-Authorization-Request-Form-NJ-ua.pdf
병원 ePA 또는 해당 약제의 최신 요청서로 제출. 앱은 환자 제공 자료 묶음과 병원 요청문을 준비하며 실제 제출을 자동 실행하지 않는다.

## 거절 후에는 다른 절차/기한/수신처
회원 보장거절 이의신청 공식 페이지는 통지서 날짜부터 60 calendar days를 안내한다. 대표자 서면 허용과 긴급 절차·별도 후속 권리도 있어 상황 확인이 필요하다. 공급자 청구지급 이의신청과 구분한다.
출처: https://www.aetnabetterhealth.com/newjersey/medicaid-grievance-appeal.html
최초 약제 PA 경로/서식과 회원 appeal 연락처를 혼용하지 않는다. 앱 데이터는 destination_type=initial_pharmacy_pa/member_appeal/provider_claim_appeal 등과 출처·checked_at을 분리. 예시 거절의 수신처는 합성으로 표시하고 실제 연락처로 자동 발송하지 않는다.
통지서에 기한/주소가 있으면 그대로 추출하여 공식 안내와 대조, 충돌은 사용자·진료팀 확인. 페이지의60일을 모든 플랜/회신/외부심사 기한으로 일반화하지 않는다. 원문 기한 미확인시 ‘정책 안내상 확인할 기한’으로 표시하고 사건 확정기한으로 조용히 치환하지 않는다. 보완 제출을 했다고 appeal 기한이 정지된다고 계산하지 않는다.
초기 요청의 진행시간과 환자가 대응해야 할 기한은 다른 필드다. 약제제외 의료서비스의 공개 지표/처리기한을 약제 PA로 복제하지 않는다.
