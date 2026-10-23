# Sprint 10 APK 빌드 결과

- 최신 소스 release 빌드: **성공** (`assembleRelease`, 139.7초).
- 전달 파일: `build/sprint10/covernote-sprint10-demo.apk`
- 기본 출력: `build/app/outputs/flutter-apk/app-release.apk`
- 크기: 73,900,017 bytes.
- SHA-256: `ab05e4a89af982e8db679f0b104a55f27c44bc149063f595a168c35194904b50`
- 앱 포함 설정: DEBUG_API_CONSOLE, DESIGN_PREVIEW, SUPABASE_ANON_KEY, SUPABASE_URL. preview/debug console 모두 꺼짐. `.env.demo`와 서버용 `.env` 미포함 확인.
- 기존 Android 설정대로 debug 인증서로 서명한 설치·시연용 release APK다.
- 서버 검증 테스트: 17개 통과. DB/원본 검사는 `db_demo_audit_ko.md` 참조.
- 이번 Flutter 분석·전체 테스트 재실행은 권한 요청 거절로 수행하지 못했다. 이전 회귀 테스트 145개 통과 이후 변경분의 실기기 검증은 남아 있다. APK 컴파일 성공과 수동 기능 검증을 구분한다.

설치 후 `diego@example.com`으로 로그인한다. 입력 자료와 테스트/촬영 시나리오는 `output/sprint10-demo-kit.zip`에 있다. 기기에 기존 앱이 있으면 동일 패키지 설치 방식으로 업데이트할 수 있다.
