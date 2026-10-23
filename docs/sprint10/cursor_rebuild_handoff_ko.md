# Cursor 인계: Sprint 10 설치본 확인과 재빌드

## 확인된 사실

- 작업 폴더는 `C:\work\Howse Asthma`다. Sprint 10 변경은 수정/미추적 파일로 이 폴더에 있고 아직 커밋되지 않았다. 원격 main만 새로 clone하면 이 구현이 없다. reset/clean/discard 하지 않는다.
- `build/sprint10/covernote-sprint10-demo.apk`의 SHA-256은 `ab05e4a89af982e8db679f0b104a55f27c44bc149063f595a168c35194904b50`이다.
- 해당 APK의 세 ABI `libapp.so`에서 `case_preparations`, `structure_record`, `read_clinical_document`, `Prepare for a new treatment` 문자열을 확인했다. 포함 설정은 preview/debug console false다. 이는 코드 포함 확인이며 실기기 정상 동작 증명은 아니다.
- Android applicationId는 기존과 같은 `com.howseasthma.app`, 기본 버전은 아직 `1.0.0+1`이다. 같은 앱 업데이트는 기존 로그인·로컬 데이터를 유지하며, 서버 데이터도 기존 계정 기준으로 조회된다.
- 기존 계정/기존 Sprint 9 케이스는 기존 데이터와 호환 경로를 유지한다. 모든 기존 케이스를 자동으로 데모나 준비 케이스로 바꾸지 않았다.
- 서버 프로젝트 `jnzdovjjahvtxbhacjuv`에는 Sprint 10 마이그레이션과 analyze-letter가 이미 배포됐다. 이번 문서/스토리지 갱신은 함수 변경이 아니다.

## 먼저 설치된 앱을 식별

USB 디버깅 기기가 연결되면 아래 명령을 사용한다. 연결 기기가 없으면 설치본이 어떤 APK인지 단정하지 않는다.

```powershell
adb devices
adb shell dumpsys package com.howseasthma.app
```

설정 탭에 표시된 로그인 이메일을 확인한다. 시연 계정은 `diego@example.com`, 비밀번호는 git 제외 `.env.demo`의 S10_PASSWORD다. 기존 개인 계정이면 로그아웃 후 시연 계정으로 로그인한다. 앱 삭제/데이터 초기화는 필요하지 않다.

Home에 `새 치료 승인 준비` 또는 `Prepare for a new treatment`가 있는지 확인한다. 로그인 없이도 공개 데모에 Sprint 10 A/B 진입 버튼이 있는지 확인할 수 있다. 시연 계정에는 A/B 2개가 있다. 기존 케이스가 기존 화면으로 열리는 것과 새 준비 기능이 없는 것은 구분한다.

## Cursor에서 실행할 순서

1. **같은 로컬 폴더**를 연다. `git status --short`로 수정·미추적 Sprint 10 파일들이 남아 있는지 확인한다.
2. `node tool/make_client_env.mjs --release`로 공개 클라이언트 키만 포함한 설정을 재생성한다. 서버 키·계정 비밀번호를 앱에 넣지 않는다.
3. `flutter analyze --no-pub`, `flutter test --no-pub`를 실행하고 실패를 먼저 해결한다. 앞선 전체 테스트 145개 통과 이후의 최종 재실행은 권한 거절로 완료하지 못했다. 현재 최종 APK의 컴파일은 성공했다.
4. `supabase migration list`로 기존 배포 상태를 확인한다. 미적용 SQL이 있을 때만 검토 후 `supabase db push`. 현재 같은 소스라면 서버 재배포는 필수가 아니다. 함수 변경이 있으면 `supabase functions deploy analyze-letter --use-api`로 배포한다.
5. 새 설치본을 식별할 수 있게 버전을 올려 빌드한다.

```powershell
Set-Location 'C:\work\Howse Asthma'
flutter build apk --release --no-pub --build-name=1.0.10 --build-number=10
Get-FileHash build/app/outputs/flutter-apk/app-release.apk -Algorithm SHA256
```

6. 기기 연결 시 기존 데이터를 유지하며 `adb install -r build/app/outputs/flutter-apk/app-release.apk`로 설치한다. 사용자 동의 없이 uninstall/clear를 실행하지 않는다. 앱을 완전히 닫고 다시 연다. OS 앱 정보/adb에서 1.0.10과 versionCode 10을 확인한다.
7. 시연 계정 로그인 → 새 치료 준비/공개 A/B → 실제 계정 A/B → 증거·기록·영문 공유를 실행해 화면을 확인한다. 실패 시 서버/클라이언트 오류를 구체적으로 기록해 수정한다. 단순 재빌드만으로 기능 버그가 해결됐다고 판단하지 않는다.

현재 Flutter/Dart는 `C:/src/flutter/bin/`에 있다. 캐시 권한 승인이 필요한 환경에서는 정상 승인 절차를 사용한다. 빌드 출력은 `build/app/outputs/flutter-apk/app-release.apk`다.

## 시나리오와 DB 날짜 주의

`test_scenarios_ko.md`, `demo_video_scenario_ko.md`, `db_demo_audit_ko.md`를 사용한다. seed는 2026-10-22 기준이고 현재 날짜가 넘어가면 30일 보고일 수 등이 달라질 수 있다. 원래 초기 집계와 다르다는 이유로 데이터를 삭제하거나 다시 seed하지 않는다. 기록/업로드 테스트 후 DB 상태가 달라지는 것도 정상이다.
