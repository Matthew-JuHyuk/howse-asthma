// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Howse Asthma';

  @override
  String get loginTitle => '로그인';

  @override
  String get loginEmailLabel => '이메일';

  @override
  String get loginPasswordLabel => '비밀번호';

  @override
  String get loginButton => '로그인';

  @override
  String get signUpButton => '회원가입';

  @override
  String get supabaseNotConfigured =>
      'Supabase가 아직 구성되지 않았습니다.\n.env 파일에 SUPABASE_URL과 SUPABASE_ANON_KEY를 추가하세요.';

  @override
  String get homeGreeting => '안녕하세요';

  @override
  String get homeAirQualityTitle => '내 주변 대기질';

  @override
  String get homeWeatherTitle => '내 주변 날씨';

  @override
  String get asthmaRiskLow => '천식 위험 낮음';

  @override
  String get asthmaRiskModerate => '천식 위험 보통';

  @override
  String get asthmaRiskHigh => '천식 위험 높음 — 주의하세요';

  @override
  String get medicationLogTitle => '복약 기록';

  @override
  String get medicationLogAddButton => '흡입기 / 약물 사용 기록';

  @override
  String get medicationNameLabel => '약물 이름';

  @override
  String get medicationDoseLabel => '용량';

  @override
  String get medicationTimeLabel => '복용 시각';

  @override
  String get medicationEffectivenessLabel => '도움이 되었나요?';

  @override
  String get reportTitle => '보험 보고서';

  @override
  String get reportGenerateButton => '의사 / 보험용 보고서 생성';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsLanguageLabel => '언어';

  @override
  String get settingsLocationLabel => '위치';

  @override
  String get notificationAttackWarningTitle => '천식 발작 위험 알림';

  @override
  String get mockContinue => '계속';

  @override
  String get mockSignUpTitle => '계정 만들기';

  @override
  String get mockChooseRole => '역할을 선택하세요';

  @override
  String get mockRolePatient => '환자';

  @override
  String get mockRolePatientHint => '대기 위험과 흡입기 사용을 추적';

  @override
  String get mockRoleProvider => '의료진';

  @override
  String get mockRoleProviderHint => '이 디자인 미리보기에 포함되지 않음';

  @override
  String get mockProviderNotInPreview => '의료진 화면은 이 환자 디자인 미리보기에 없습니다.';

  @override
  String get mockBiometricTitle => '잠금 해제';

  @override
  String get mockBiometricHint => '생체 인증으로 Howse Asthma 잠금 해제 (디자인 미리보기).';

  @override
  String get mockUnlock => '잠금 해제';

  @override
  String get mockUsePassword => '대신 비밀번호 사용';

  @override
  String get mockOnboardingTitle => '환자 설정';

  @override
  String get mockHomeLocation => '집';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => '비상 연락처';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => '의료진 초대 코드';

  @override
  String get mockFinishOnboarding => '홈으로 이동';

  @override
  String get mockAllScreens => '모든 화면';

  @override
  String get mockAllScreensHint => '디자인 검토용 Screen ID 열기';

  @override
  String get mockStateCalm => 'CALM';

  @override
  String get mockStateWarning => 'WARNING';

  @override
  String get mockHomeCalmMessage => '주변 공기가 관리 가능해 보입니다. 언제든지 흡입기를 기록하세요.';

  @override
  String get mockHomeWarnMessage => '주변 위험이 높습니다. 야외 노출을 줄이고 흡입기를 준비하세요.';

  @override
  String get mockRiskScore => '위험 점수';

  @override
  String get mockDummyLocation => 'Newark, NJ 근처';

  @override
  String get mockEnvDetail => '환경 상세';

  @override
  String get mockForecast => '예보';

  @override
  String get mockForecastHint => '앞으로 며칠의 대기·꽃가루 전망';

  @override
  String get mockAlertPreview => '알림 화면';

  @override
  String get mockAlertPreviewHint => '위험 알림 화면 미리보기';

  @override
  String get mockShowWarningHome => 'WARNING 홈 미리보기';

  @override
  String get mockBackToCalmHome => '뒤로';

  @override
  String get mockPanicCta => '패닉 모드';

  @override
  String get mockTrapAxis => 'TRAP / 매연';

  @override
  String get mockFloodAxis => '돌발 홍수';

  @override
  String get mockPollenAxis => '꽃가루';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · 꽃가루 전망';

  @override
  String get mockActSurvey => 'ACT 설문';

  @override
  String get mockActHint => '그림 질문 5개 (4주)';

  @override
  String get mockPdcCheck => '일일 PDC 확인';

  @override
  String get mockPdcHint => '한 번 탭으로 복약 확인';

  @override
  String get mockInhalerEvent => '흡입기 기록됨';

  @override
  String get mockActIntro => '지난 4주 기준으로 답하세요. 디자인 미리보기 — 답변은 저장되지 않습니다.';

  @override
  String get mockQuestion => '질문';

  @override
  String get mockSubmit => '제출';

  @override
  String get mockPdcPrompt => '오늘 조절제를 복용하셨나요?';

  @override
  String get mockTakenYes => '네, 복용했습니다';

  @override
  String get mockTakenNo => '오늘은 안 함';

  @override
  String get mockEvidenceSummary => '근거 요약';

  @override
  String get mockEvidenceBody => 'PA/LMN 지원용 예시 요약입니다. 디자인 미리보기 전용.';

  @override
  String get mockInhalerEvents30d => '흡입기 이벤트 (30일)';

  @override
  String get mockActScore => '최근 ACT';

  @override
  String get mockPdcRate => 'PDC (30일)';

  @override
  String get mockLocationsTitle => '저장한 장소';

  @override
  String get mockLocationsHint => '집과 직장 모니터링';

  @override
  String get mockWorkLocation => '직장';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => '장소 추가';

  @override
  String get mockRewardTitle => '리워드';

  @override
  String get mockDraftBanner => '초안 — 포인트와 바우처는 미리보기 전용';

  @override
  String get mockPointsBalance => '포인트 잔액';

  @override
  String get mockVoucherTitle => '푸드뱅크 바우처';

  @override
  String get mockVoucherHint => '포인트 교환 (대기 목록)';

  @override
  String get mockDonateTitle => '기부';

  @override
  String get mockDonateHint => '제3자 기부만 가능';

  @override
  String get mockRewardHistory => '기록';

  @override
  String get mockRewardHistoryHint => '포인트와 기부';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank (데모)';

  @override
  String get mockVoucherCost => '50포인트 · \$10 상당 (초안)';

  @override
  String get mockJoinWaitlist => '대기 목록 참여';

  @override
  String get mockDonateTransparency =>
      '기부는 검증된 제3자 비영리 플랫폼을 통해 이루어집니다. Howse Asthma는 카드 정보를 저장하지 않습니다.';

  @override
  String get mockDonateCta => '기부 열기 (외부)';

  @override
  String get mockExternalOnly => '외부 기부 제공자는 디자인 미리보기에 연결되지 않았습니다.';

  @override
  String get mockSignOutPreview => '로그아웃 (미리보기)';

  @override
  String get mockOpenAuthFlow => '인증 흐름 열기';

  @override
  String get mockAlertBody => '위치 근처 위험이 상승했습니다. 환경 상세를 확인하세요.';

  @override
  String get mockDismiss => '닫기';

  @override
  String get mockPanicTitle => '지금 도움이 필요하신가요?';

  @override
  String get mockPanicStep1Body => '1단계 — 흡입기와 함께 계세요. 비상 연락처로 계속하세요.';

  @override
  String get mockPanicStep2Title => '도움 요청';

  @override
  String get mockPanicStep2Body =>
      '디자인 미리보기: 버튼은 실제 통화를 걸지 않습니다. 기기 빌드에서는 2단계가 tel: 링크를 사용합니다.';

  @override
  String get mockCall911 => '911 호출';

  @override
  String get mockCallGuardian => '비상 연락처에 전화';

  @override
  String get mockFeelingBetter => '조금 나아졌어요';

  @override
  String get mockTabHome => '홈';

  @override
  String get mockTabLog => '기록';

  @override
  String get mockTabReport => '보고서';

  @override
  String get mockTabReward => '리워드';

  @override
  String get mockTabSettings => '설정';

  @override
  String get navHome => '홈';

  @override
  String get signUpTitle => '계정 만들기';

  @override
  String get authChooseRole => '역할을 선택하세요';

  @override
  String get authRolePatient => '환자';

  @override
  String get authRolePatientHint => '대기질 위험과 흡입기 사용을 추적';

  @override
  String get authRoleProvider => '의료진';

  @override
  String get authRoleProviderHint => '환자를 연결하고 임상 근거를 검토';

  @override
  String get authFullNameLabel => '이름';

  @override
  String get authNpiLabel => 'NPI 번호';

  @override
  String get authNpiHelper => '10자리 국가 의료 제공자 식별번호';

  @override
  String get authOrContinueWith => '또는 다음으로 계속';

  @override
  String get authContinueGoogle => 'Google로 계속';

  @override
  String get authContinueApple => 'Apple로 계속';

  @override
  String get authCheckEmailTitle => '이메일을 확인하세요';

  @override
  String authCheckEmailBody(String email) {
    return '$email로 확인 링크를 보냈습니다. 연 다음 로그인하세요.';
  }

  @override
  String get authBackToSignIn => '로그인으로 돌아가기';

  @override
  String get authCompleteProfileTitle => '프로필 완성';

  @override
  String get authCompleteProfileBody => '올바른 홈 화면을 열 수 있도록 역할을 알려 주세요.';

  @override
  String get authSaveProfile => '프로필 저장';

  @override
  String get authSignOut => '로그아웃';

  @override
  String get authRetry => '다시 시도';

  @override
  String get authWorking => '처리 중…';

  @override
  String get authValidationInvalidEmail => '유효한 이메일을 입력하세요';

  @override
  String get authValidationPasswordMin => '비밀번호는 8자 이상이어야 합니다';

  @override
  String get authValidationNameRequired => '이름은 필수입니다';

  @override
  String get authValidationInvalidNpi => '유효한 10자리 NPI를 입력하세요';

  @override
  String get authErrorGeneric => '문제가 발생했습니다. 다시 시도해 주세요.';

  @override
  String get authErrorInvalidCredentials => '이메일 또는 비밀번호가 올바르지 않습니다';

  @override
  String get authErrorEmailTaken => '이 이메일로 등록된 계정이 이미 있습니다';

  @override
  String get authErrorEmailNotConfirmed => '로그인하기 전에 이메일을 확인하세요';

  @override
  String get authErrorWeakPassword => '비밀번호가 너무 약합니다';

  @override
  String get authErrorRateLimited => '시도 횟수가 너무 많습니다. 나중에 다시 시도하세요.';

  @override
  String get authBiometricTitle => 'Howse Asthma 잠금 해제';

  @override
  String get authBiometricHint => '생체 인증으로 계속';

  @override
  String get authBiometricReason => 'Howse Asthma 잠금 해제';

  @override
  String get authBiometricUnlock => '잠금 해제';

  @override
  String get authBiometricFailed => '생체 잠금 해제에 실패했습니다. 다시 시도하세요.';

  @override
  String get authBiometricToggle => '생체 잠금 해제';

  @override
  String get authBiometricToggleHint => '앱을 열 때 생체 잠금 해제 요구';

  @override
  String get authBiometricUnavailable => '이 기기에서는 생체 인증을 사용할 수 없습니다';

  @override
  String get authOnboardingTitle => '환자 설정';

  @override
  String get authOnboardingBody =>
      '의료진이 공유한 8자 초대 코드가 있으면 지금 입력하세요. 나중에 설정에서도 할 수 있습니다.';

  @override
  String get authOnboardingSkip => '지금은 건너뛰기';

  @override
  String get authInviteCodeLabel => '의료진 초대 코드';

  @override
  String get authInviteCodeHelper => '문자/숫자 8자, 24시간 후 만료';

  @override
  String get authInviteRedeem => '사용하기';

  @override
  String get authInviteRedeemAndContinue => '사용하고 계속';

  @override
  String get authInviteInvalidFormat => '초대 코드는 문자 또는 숫자 8자여야 합니다';

  @override
  String get authInviteRedeemedPending => '초대가 사용되었습니다. 의료진 확인을 기다리는 중입니다.';

  @override
  String get authInviteRedeemFailed => '초대 코드를 사용할 수 없습니다';

  @override
  String get authInviteIssueFailed => '초대 코드를 발급할 수 없습니다';

  @override
  String get authConfirmLink => '확인';

  @override
  String get authRejectLink => '거절';

  @override
  String get authLinkStatusPending => '확인 대기 중';

  @override
  String get settingsSystemDefault => '시스템 기본값';

  @override
  String get settingsLocationTodo => '위치 권한은 이후 업데이트에서 요청됩니다';

  @override
  String get providerHomeTab => '홈';

  @override
  String get providerLinkTab => '연결';

  @override
  String get providerHomeTitle => '의료진 홈';

  @override
  String providerHomeWelcome(String email) {
    return '$email로 로그인됨';
  }

  @override
  String get providerHomePlaceholder =>
      '환자 임상 대시보드는 이후 버전에 제공됩니다. 먼저 환자를 연결하세요.';

  @override
  String get providerLinkPatientsCta => '환자 연결';

  @override
  String get providerLinkTitle => '환자 연결';

  @override
  String get providerLinkIntro => '8자 코드를 발급하세요(24시간 유효). 환자가 입력한 뒤 양측이 확인합니다.';

  @override
  String get providerIssueInviteCta => '초대 코드 발급';

  @override
  String get providerInviteTtlHint => '24시간 동안 유효';

  @override
  String get providerInviteCopied => '초대 코드가 복사됨';

  @override
  String get providerPendingLinks => '대기 중인 연결';

  @override
  String get providerNoPendingLinks => '대기 중인 연결 없음';

  @override
  String providerPendingPatient(String idPrefix) {
    return '환자 $idPrefix…';
  }

  @override
  String get providerRecentInvites => '최근 초대 코드';

  @override
  String get providerNoInvites => '아직 초대 코드 없음';

  @override
  String get providerInviteConsumed => '사용됨';

  @override
  String get providerInviteActive => '활성';

  @override
  String get splashTagline => '모든 가족을 위한 더 스마트한 천식 예방.';

  @override
  String get splashGetStarted => '시작하기';

  @override
  String get splashAlreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get splashSignIn => '로그인';

  @override
  String get authForgotPassword => '비밀번호를 잊으셨나요?';

  @override
  String get authNoAccount => '계정이 없으신가요?';

  @override
  String get authUseBiometricHint => 'Face ID 또는 지문으로 잠금 해제';

  @override
  String get authTouchSensorHint => '센서를 터치하거나 카메라를 보세요';

  @override
  String get navLog => '기록';

  @override
  String get navReport => '보고서';

  @override
  String get navRewards => '리워드';

  @override
  String get mockChooseLanguage => '언어 선택';

  @override
  String get mockYourLocation => '내 위치';

  @override
  String get mockUseCurrentLocation => '현재 위치 사용';

  @override
  String get mockLocationTrapOnly => '위치는 TRAP 대기질 데이터에만 사용됩니다';

  @override
  String get mockLabelYourPlace => '장소 이름 지정';

  @override
  String get mockSchool => '학교';

  @override
  String get mockWork => '직장';

  @override
  String get mockOther => '기타';

  @override
  String get mockEmergencyOnePerson => '비상 시 전화할 한 사람';

  @override
  String get mockContactName => '연락처 이름';

  @override
  String get mockPhoneNumber => '전화번호';

  @override
  String get mockProviderPairing => '의료진 연결';

  @override
  String get mockPairingOptional => '선택 사항 — 나중에 설정에서 추가할 수 있습니다';

  @override
  String get mockNext => '다음';

  @override
  String get mockProfessionalProfile => '전문가 프로필';

  @override
  String get mockStep2Of4 => '4단계 중 2단계';

  @override
  String get mockTellPractice => '의료 진료에 대해 알려 주세요';

  @override
  String get mockSpecialtyLabel => '전문 분야';

  @override
  String get mockClinicLabel => '진료소 / 클리닉 이름';

  @override
  String get mockNpiFormatOnly => '형식 확인만 합니다. NPI 검증은 제출 후 진행됩니다.';

  @override
  String get mockCredentialsSecure =>
      '자격 정보는 암호화되어 안전하게 저장됩니다. 동의 없이 의료진 데이터를 공유하지 않습니다.';

  @override
  String get oneTapFab => '1-Tap';

  @override
  String get oneTapLoggedSnack => '흡입기 사용이 기록되었습니다 (stub)';

  @override
  String get oneTapLoggedOk => '흡입기 사용이 기록되었습니다';

  @override
  String get oneTapLoggedFailed => '흡입기 사용을 기록할 수 없습니다. 다시 시도하세요.';

  @override
  String get homeDailySummary => '오늘의 요약입니다';

  @override
  String get homeWarningBanner => '주변 위험이 높습니다. 야외 노출을 줄이고 흡입기를 준비하세요.';

  @override
  String get homeEnvFactors => '환경 요인';

  @override
  String get homeViewDetails => '자세히 보기';

  @override
  String get homeFloodActive => '활성 경보';

  @override
  String get homeFloodNone => '없음';

  @override
  String get homeLastInhalerNone => '아직 기록된 흡입기 사용이 없습니다';

  @override
  String get homeLastInhalerToday => '마지막 흡입기 사용: 오늘';

  @override
  String homeLastInhalerDays(int days) {
    return '마지막 흡입기 사용: $days일 전';
  }

  @override
  String get locationServiceDisabled => '주변 천식 위험을 보려면 위치 서비스를 켜세요.';

  @override
  String get locationPermissionDenied => '주변 대기질을 보려면 위치 권한이 필요합니다.';

  @override
  String get locationPermissionDeniedForever => '위치 권한이 차단되었습니다. 설정에서 허용하세요.';

  @override
  String get locationUnavailable => '위치를 가져올 수 없습니다. 당겨서 새로고침하거나 다시 시도하세요.';

  @override
  String get locationOutOfServiceArea => 'Howse Asthma는 현재 미국 내 위치를 지원합니다.';

  @override
  String get locationOpenSettings => '설정 열기';

  @override
  String get locationStatusGranted => '위치 접근이 켜져 있습니다';

  @override
  String get njOnlyDataNotice =>
      'NJ 전용 데이터: 화물 AADT 가중치는 뉴저지에서만 적용됩니다. TRAP는 전국 대기질 센서를 계속 사용합니다.';

  @override
  String get homeDegradedNotice =>
      '일부 대기질 소스를 사용할 수 없습니다. 위험이 불완전할 수 있으니 주의하세요.';

  @override
  String logWeekSummary(int count) {
    return '최근 7일 흡입기 이벤트 $count건';
  }

  @override
  String get logFilterAll => '전체';

  @override
  String get logFilterRescue => '응급';

  @override
  String get logFilterPanic => '패닉';

  @override
  String get logEmpty => '아직 흡입기 이벤트가 없습니다. 홈에서 1-Tap을 사용하세요.';

  @override
  String get logEventRescue => '흡입기 사용';

  @override
  String get logEventPanic => '패닉 흡입기 사용';

  @override
  String get actTitle => '천식 점검';

  @override
  String get actPast4Weeks => '지난 4주 동안';

  @override
  String get actQ1 => '천식 때문에 직장·학교·집에서 평소만큼 일을 하지 못한 시간은 어느 많았나요?';

  @override
  String get actQ2 => '숨이 찬 증상은 얼마나 자주 있었나요?';

  @override
  String get actQ3 => '천식 증상으로 밤중에 깨거나 평소보다 일찍 깬 적이 얼마나 자주 있었나요?';

  @override
  String get actQ4 => '응급 흡입기나 네뷸라이저를 얼마나 자주 사용했나요?';

  @override
  String get actQ5 => '천식 조절 상태를 어떻게 평가하시겠습니까?';

  @override
  String get actOpt1 => '항상';

  @override
  String get actOpt2 => '대부분';

  @override
  String get actOpt3 => '가끔';

  @override
  String get actOpt4 => '거의 없음';

  @override
  String get actOpt5 => '전혀 없음';

  @override
  String get actQ5Opt1 => '전혀 조절되지 않음';

  @override
  String get actQ5Opt2 => '잘 조절되지 않음';

  @override
  String get actQ5Opt3 => '어느 정도 조절됨';

  @override
  String get actQ5Opt4 => '잘 조절됨';

  @override
  String get actQ5Opt5 => '완전히 조절됨';

  @override
  String actSaved(int score) {
    return 'ACT가 저장되었습니다. 점수: $score';
  }

  @override
  String get pdcTitle => '일일 복약 확인';

  @override
  String get pdcSaved => '일일 확인이 저장되었습니다';

  @override
  String get pdcAlreadyYes => '오늘은 이미 복용으로 표시했습니다. 수정할 수 있습니다.';

  @override
  String get pdcAlreadyNo => '오늘은 이미 미복용으로 표시했습니다. 수정할 수 있습니다.';

  @override
  String pdcStreakHint(int taken, int total, String rate) {
    return '최근 30일: $total일 중 $taken일 복용 ($rate)';
  }

  @override
  String get panicEmergencyBadge => '응급';

  @override
  String get panicBreatheTitle => '숨 고르기 & 흡입기 사용';

  @override
  String get panicTakeInhalerNow => '지금 흡입기 사용';

  @override
  String get panicNeedHelp => '도움이 더 필요해요';

  @override
  String get panicNoAutoDial => '버튼은 전화 다이얼러를 엽니다. 통화는 자동으로 연결되지 않습니다.';

  @override
  String panicCallNamed(String name) {
    return '$name에게 전화';
  }

  @override
  String get panicDialFailed => '이 기기에서 전화 다이얼러를 열 수 없습니다.';

  @override
  String get alertTitle => '위험 알림';

  @override
  String get alertFcmPendingNote =>
      '이 기기에서 푸시가 켜져 있으면 앱이 백그라운드일 때도 OS 알림을 받습니다.';

  @override
  String get reportEvidenceBody => '의료진 또는 보험 검토용 흡입기 사용, ACT, PDC 요약.';

  @override
  String get reportShareTodo => '공유/내보내기는 의료진 PA/LMN 흐름과 함께 제공됩니다.';

  @override
  String get settingsAlertsTitle => '알림 환경설정';

  @override
  String get settingsAlertRisk => '위험 알림';

  @override
  String get settingsAlertRiskHint => '종합 위험 점수가 3 이상일 때';

  @override
  String get settingsAlertHome => '저장한 장소 알림';

  @override
  String get settingsAlertHomeHint => '저장한 장소(집, 학교, 직장)에서 위험이 상승할 때';

  @override
  String get settingsAlertLocationEntry => '위치 진입 알림';

  @override
  String get settingsAlertLocationEntryHint => '앱이 열린 상태에서 더 위험한 지역으로 이동할 때';

  @override
  String get settingsSecurityTitle => '보안';

  @override
  String get emergencyContactRequired => '연락처 이름과 전화번호를 입력하세요';

  @override
  String get emergencyContactInvalidPhone =>
      '국가번호가 포함된 유효한 전화번호(E.164)를 입력하세요. 예: +15551234567';

  @override
  String get emergencyContactSaved => '비상 연락처가 저장되었습니다';

  @override
  String get emergencyContactSave => '연락처 저장';

  @override
  String get emergencyContactPhoneHint => '국가번호(E.164)를 포함하세요. 예: +15551234567';

  @override
  String get commonCancel => '취소';

  @override
  String get commonSave => '저장';

  @override
  String get commonDelete => '삭제';

  @override
  String get envTitle => '환경';

  @override
  String get envThreeAxis => '세 가지 위험 축';

  @override
  String get envTrapDetail => '교통 관련 대기오염 지표(센서 + 선택적 NJ 화물 가중치)';

  @override
  String get envTrapTip => 'TRAP가 높음 또는 위험일 때 야외 격한 활동을 줄이세요.';

  @override
  String get envFloodDetail => '주변 NWS 돌발 홍수 / 하천 경보';

  @override
  String get envFloodTipClear => '이 지역에 활성 돌발 홍수 경보가 없습니다.';

  @override
  String get envPollenDetail => 'Google 꽃가루 예보';

  @override
  String get envPollenTip => 'UPI가 높을 때는 창문을 닫고 야외 활동 후 헹구세요.';

  @override
  String envUsgsRate(String rate) {
    return 'USGS 하천 변화: $rate ft/hr';
  }

  @override
  String envUpdatedAt(String when) {
    return '업데이트: $when';
  }

  @override
  String get envSourcesLabel => '데이터 소스';

  @override
  String get envOverallCalm => '상황은 관리 가능해 보입니다. 흡입기를 가까이 두세요.';

  @override
  String get forecastIntro => '대기질과 꽃가루 예보를 이용한 향후 전망입니다.';

  @override
  String get forecastEmpty => '예보 시리즈를 아직 사용할 수 없습니다. 당겨서 새로고침하세요.';

  @override
  String get forecastPollenNote =>
      '꽃가루는 Google Pollen API를 사용합니다(Open-Meteo 아님). MVP에서는 히트맵을 사용하지 않습니다.';

  @override
  String forecastDayPollen(int upi, String type) {
    return '꽃가루 UPI $upi · $type';
  }

  @override
  String forecastDayAqi(int aqi) {
    return '최대 US AQI $aqi';
  }

  @override
  String get forecastMorning => '오전';

  @override
  String get forecastAfternoon => '오후';

  @override
  String get forecastEvening => '저녁';

  @override
  String get locationsTitle => '내 위치';

  @override
  String get locationsIntro =>
      '앱이 열린 동안 저장한 장소의 위험 변화를 확인합니다. 백그라운드 OS 푸시는 Firebase가 필요합니다(다음).';

  @override
  String get locationsEmpty => '저장한 장소가 없습니다. 현재 위치를 추가하세요.';

  @override
  String get locationsAddTitle => '이 장소 저장';

  @override
  String get locationsNameLabel => '이름';

  @override
  String get locationsAddCurrent => '현재 위치 추가';

  @override
  String get locationsSaveFailed => '저장한 위치를 업데이트할 수 없습니다. 다시 시도하세요.';

  @override
  String get locationsCapReached => '장소는 최대 10개까지 저장할 수 있습니다. 하나 삭제한 뒤 추가하세요.';

  @override
  String get locationsDeleteTitle => '장소를 제거할까요?';

  @override
  String locationsDeleteBody(String name) {
    return '모니터링에서 “$name”을(를) 제거할까요?';
  }

  @override
  String locationsCoords(String lat, String lon) {
    return '$lat, $lon';
  }

  @override
  String get locationsPrimaryBadge => '기본';

  @override
  String get stateOnlyNjApplied => 'NJ 전용: 화물 AADT 가중치 적용됨';

  @override
  String get stateOnlyNjNotApplied => 'NJ 전용: 화물 AADT 가중치 미적용';

  @override
  String get stateOnlyNjAppliedHint =>
      '주변 NJDOT 교통량이 TRAP 가중치를 높였습니다. 대기질 센서는 전국에서 계속 적용됩니다.';

  @override
  String get stateOnlyNjOutsideHint =>
      '뉴저지 밖입니다. 화물 AADT 가중치는 NJ 전용이며, TRAP는 공기 센서를 계속 사용합니다.';

  @override
  String get stateOnlyNjNoCountHint =>
      '주변 NJDOT 화물 교통량이 없습니다. TRAP는 NJ 화물 가중치 없이 대기질 센서를 사용합니다.';

  @override
  String get settingsDeveloperSection => '개발자';

  @override
  String get settingsApiConsole => 'API 콘솔';

  @override
  String get debugApiConsoleBanner => 'DEBUG — 공개 공유용 스크린샷 금지';
}
