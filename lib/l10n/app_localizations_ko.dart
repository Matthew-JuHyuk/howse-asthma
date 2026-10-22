// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'CoverNote';

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
  String get splashTagline => '환경 자극으로부터 호흡을 지키는 스마트한 울타리';

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

  @override
  String get appTagline => '환경 자극으로부터 호흡을 지키는 스마트한 울타리';

  @override
  String get welcomeBenefit1 => '실시간 환경 위험(AQI·꽃가루) 선제 예측 및 알림';

  @override
  String get welcomeBenefit2 => '3초 만에 끝나는 매일의 호흡 주도권 체크';

  @override
  String get welcomeBenefit3 => '의사와 공유하는 신뢰할 수 있는 데이터 리포트';

  @override
  String get welcomeContinueEmail => '또는 이메일로 시작하기';

  @override
  String get welcomeTermsAgree => '이용약관 및 개인정보 처리방침에 동의합니다';

  @override
  String get welcomeTermsPending => '약관 링크는 게시 후 제공됩니다.';

  @override
  String get welcomeClinicianLink => '의료진입니다';

  @override
  String get checkInWelcomeHome => 'Welcome Home!';

  @override
  String get checkInQuestion => '지금 호흡 상태는 어떤가요?';

  @override
  String get checkInBreathUsual => '평소와 같음';

  @override
  String get checkInBreathTight => '약간 답답함';

  @override
  String get checkInBreathSymptoms => '증상 있음';

  @override
  String get checkInAeroPoints => '첫 체크인 완료! +5 AeroPoint';

  @override
  String get shieldLocationTitle => '선제적 울타리를 활성화하세요';

  @override
  String get shieldLocationBody => '당신 주위의 선제적 울타리를 활성화하려면 위치가 필요합니다.';

  @override
  String get shieldLocationAllow => '위치 허용';

  @override
  String get shieldLocationNotNow => '나중에';

  @override
  String get settingsPushMaster => '푸시 알림';

  @override
  String get settingsPushMasterHint => '이 기기에서 Howse Asthma 알림 전체 켜기/끄기';

  @override
  String get pushConsentTitle => '천식 유발 요인을 미리 알림';

  @override
  String get pushConsentBody =>
      '근처 대기·홍수 위험이 오르면 간단한 알림을 보낼 수 있습니다. 설정에서 언제든 바꿀 수 있습니다.';

  @override
  String get pushConsentAllow => '알림 허용';

  @override
  String get pushConsentNotNow => '나중에';

  @override
  String homeNearPlace(String place) {
    return '$place 근처';
  }

  @override
  String get homeStaleLocationNotice => '위치를 기다리는 동안 마지막 읽기를 보여 줍니다.';

  @override
  String get homeStaleRefreshNotice => '마지막 읽기를 보여 줍니다. 연결되면 당겨서 새로고침하세요.';

  @override
  String get homeStaleCacheNotice => '이 읽기는 조금 오래되었을 수 있습니다. 주의해서 보세요.';

  @override
  String get homeNowDoThisHeading => '발작 위험을 낮추려면 지금 할 일';

  @override
  String get homeDraftBadge => '초안';

  @override
  String get homeNowDoThisFloodTitle => '가능하면 실내에 머무르세요';

  @override
  String get homeNowDoThisFloodBody =>
      '홍수 경보는 습기와 관련될 수 있습니다. 흡입기를 가까이 두고 침수 지역을 피하세요.';

  @override
  String get homeNowDoThisTrapTitle => '야외 활동을 줄이세요';

  @override
  String get homeNowDoThisTrapBody =>
      '근처 교통 관련 대기오염이 높아 보입니다. 꼭 필요할 때만 짧게 나가세요.';

  @override
  String get homeNowDoThisPollenTitle => '지금은 창문을 닫아 두세요';

  @override
  String get homeNowDoThisPollenBody => '꽃가루가 높습니다. 외출 후 얼굴을 씻고 옷을 갈아입으세요.';

  @override
  String get homeNowDoThisRiskTitle => '야외에서는 천천히';

  @override
  String get homeNowDoThisRiskBody => '전체 위험이 높습니다. 흡입기를 챙기고 숨이 가쁘면 쉬세요.';

  @override
  String get homeNowDoThisCalmTitle => '환기하기 좋은 시간';

  @override
  String get homeNowDoThisCalmBody =>
      '바깥 공기가 괜찮아 보입니다. 짧게 환기해도 되지만 흡입기는 가까이 두세요.';

  @override
  String get homeAdherenceSection => '이번 주 흡입기';

  @override
  String get adherenceWeekHint => '색칠된 날은 1-Tap 기록이 있는 날입니다.';

  @override
  String get homeMoldAxis => '곰팡이 위험';

  @override
  String get homeMoldElevatedDraft => '습기 신호 높음';

  @override
  String get homeMoldPendingDraft => '습도 데이터 대기';

  @override
  String get homeFloodAsMoldFactor => '홍수/습기 요인';

  @override
  String get homeForecastLink => '단기 전망';

  @override
  String homeForecastHint(String date, String score) {
    return '다음날 $date · 점수 $score';
  }

  @override
  String homeSensorDistance(
    String km,
    String mi,
    String radiusKm,
    String radiusMi,
  ) {
    return '가장 가까운 센서 $km km ($mi mi) · 검색 ~$radiusKm km ($radiusMi mi)';
  }

  @override
  String homeSensorNearestOnly(String km, String mi) {
    return '가장 가까운 센서 $km km ($mi mi)';
  }

  @override
  String homeSensorRadiusOnly(String km, String mi) {
    return '센서 검색 ~$km km ($mi mi)';
  }

  @override
  String get weekdayMonShort => '월';

  @override
  String get weekdayTueShort => '화';

  @override
  String get weekdayWedShort => '수';

  @override
  String get weekdayThuShort => '목';

  @override
  String get weekdayFriShort => '금';

  @override
  String get weekdaySatShort => '토';

  @override
  String get weekdaySunShort => '일';

  @override
  String get logAdherenceCalendarTitle => '복약 캘린더';

  @override
  String get homeNowDoThisMoldTitle => '실내 습기를 줄이세요';

  @override
  String get homeNowDoThisMoldBody =>
      '바깥 습기가 높아 보입니다. 가능하면 선풍기·제습기를 쓰고 젖은 지하실은 피하세요.';

  @override
  String get homeMoldDetail => '근처 습기 조건(실외 추정 — 포자 수치가 아님)';

  @override
  String get homeMoldTip => '곰팡이 위험이 높으면 방을 더 건조하게 유지하세요. 홍수 경보는 습기 위험을 높입니다.';

  @override
  String homeMoldRh(String pct) {
    return '습도 $pct%';
  }

  @override
  String homeMoldTempF(String temp) {
    return '$temp°F';
  }

  @override
  String homeMoldDewF(String temp) {
    return '이슬점 $temp°F';
  }

  @override
  String homeMoldWetHours(int hours) {
    return '습한 시간 $hours시간(24시간)';
  }

  @override
  String get homeMoldProxyDisclaimer => '실외 추정만';

  @override
  String get homeVentilationSnack => '바깥 공기가 비교적 괜찮습니다 — 짧게 환기해도 됩니다.';

  @override
  String get settingsAlertPositive => '환기 팁';

  @override
  String get settingsAlertPositiveHint => '바깥 공기가 잠시 나을 때 짧은 환기 안내(초안 규칙)';

  @override
  String get settingsBgTitle => '백그라운드 갱신';

  @override
  String get settingsBgBody =>
      '앱을 사용하는 동안 근처 공기를 갱신합니다. 이 버전에서는 Always 위치를 요청하지 않습니다.';

  @override
  String get settingsBgRefresh => '앱 사용 중 갱신';

  @override
  String get settingsBgRefreshHint => '이동하거나 앱을 열어 둔 동안 위험을 갱신';

  @override
  String get s5AboutApp => 'Howse Asthma 정보';

  @override
  String get s5AboutAppBody =>
      'Howse Asthma는 증상과 흡입기 사용을 기록하고 의료진에게 보여줄 요약을 준비하도록 돕습니다. 진단하거나 치료를 권고하지 않아요.';

  @override
  String get s5ActNotice =>
      '답변은 의료진과 공유할 수 있도록 저장돼요. 이 설문은 공식 채점 기준으로 검증되지 않았기 때문에 앱에서 점수를 보여주지 않아요.';

  @override
  String get s5ActSaved => '답변을 저장했어요.';

  @override
  String get s5ActSubtitle => '지난 4주에 대한 5개 질문';

  @override
  String get s5ActTitle => '천식 조절 설문';

  @override
  String get s5AddDetails => '상세 추가';

  @override
  String get s5AddRecord => '기록 추가';

  @override
  String get s5AlertArrive => '새 장소에 도착했을 때';

  @override
  String get s5AlertArriveHint => '도착한 곳의 주변 환경이 더 나쁠 때. 앱을 사용하는 동안에만 작동해요.';

  @override
  String get s5AlertFreshAirHint =>
      '실외 대기질·꽃가루·홍수 정보가 모두 잔잔해 보일 때. 일반 정보이며 의학적 조언이 아니에요.';

  @override
  String get s5AlertSavedPlaces => '저장한 장소';

  @override
  String get s5AlertSavedPlacesHint => '저장한 장소의 주변 환경이 나빠질 때.';

  @override
  String get s5AlertWorse => '환경이 나빠질 때';

  @override
  String get s5AlertWorseHint =>
      '주변 대기질·꽃가루·홍수 정보가 나빠질 때. 같은 알림은 1시간 안에 반복하지 않아요.';

  @override
  String get s5AqiGood => '좋음';

  @override
  String get s5AqiModerate => '보통';

  @override
  String get s5AqiUsg => '민감군에 나쁨';

  @override
  String get s5AqiUnhealthy => '나쁨';

  @override
  String get s5AqiVeryUnhealthy => '매우 나쁨';

  @override
  String get s5AqiHazardous => '위험';

  @override
  String s5AqiValue(String category, int aqi) {
    return '$category (AQI $aqi)';
  }

  @override
  String get s5Back => '이전';

  @override
  String get s5BarrierCost => '약값';

  @override
  String get s5BarrierHardToGet => '약을 구하기 어려움';

  @override
  String get s5BarrierHardToUnderstand => '설명을 이해하기 어려움';

  @override
  String get s5BarrierHowToUse => '약 사용법';

  @override
  String get s5BarrierNone => '어려움 없음';

  @override
  String get s5BarrierOtherHint => '직접 입력 (선택)';

  @override
  String get s5Cancel => '취소';

  @override
  String get s5Change => '변경';

  @override
  String get s5ChoosePlace => '지역 선택';

  @override
  String get s5Close => '닫기';

  @override
  String get s5DataSourcesTitle => '데이터 출처';

  @override
  String get s5DataSourcesBody =>
      '대기질: 미국 EPA AirNow, Open-Meteo, 주변 PurpleAir 센서.\n꽃가루: Google Pollen API (Universal Pollen Index).\n날씨·습도: Open-Meteo.\n홍수 알림: 미국 국립기상청(NWS). 하천 수위: 미국 지질조사국(USGS).\n교통량(뉴저지 전용): 뉴저지 교통국(NJDOT).\n값이 늦거나 빠질 수 있어요. 실외 환경을 나타내며 건강 상태를 뜻하지 않아요.';

  @override
  String get s5Delete => '삭제';

  @override
  String get s5DeleteConfirm => '이 기록을 삭제할까요?';

  @override
  String get s5DeleteFailed => '삭제하지 못했어요. 다시 시도해 주세요.';

  @override
  String get s5Edit => '수정';

  @override
  String get s5EnglishVersion => '영문 (의료진용)';

  @override
  String get s5EntryRemoved => '기록을 취소했어요.';

  @override
  String get s5EnvAirDetail =>
      '공공 측정소와 주변 센서의 미국 EPA 대기질 지수예요. 지역의 실외 공기를 나타내며 교통 매연만 따로 측정한 값이 아니에요.';

  @override
  String get s5EnvAirQuality => '대기질';

  @override
  String get s5EnvAlertsHeading => '환경 알림';

  @override
  String get s5EnvCardTitle => '오늘의 주변 환경';

  @override
  String get s5EnvFlood => '홍수 알림';

  @override
  String get s5EnvFloodDetail => '미국 국립기상청(NWS)의 공공 경보예요.';

  @override
  String get s5EnvForecast => '환경 예보';

  @override
  String get s5EnvHumidity => '습도 조건';

  @override
  String get s5EnvHumidityDetail => '실외 기상 자료이며 실내 습도나 곰팡이 측정값이 아니에요.';

  @override
  String get s5EnvLoadFailed => '환경 정보를 불러오지 못했어요.';

  @override
  String get s5EnvNeedPlace => '지역을 선택하면 주변 환경을 볼 수 있어요.';

  @override
  String get s5EnvNotAvailable => '확인 불가';

  @override
  String get s5EnvOlderNotice => '마지막으로 확인한 정보예요.';

  @override
  String get s5EnvPollen => '꽃가루 지수';

  @override
  String get s5EnvPollenDetail =>
      'Google의 Universal Pollen Index로 0(없음)부터 5(매우 높음)까지예요. 낮은 숫자가 모든 사람에게 안전하다는 뜻은 아니에요.';

  @override
  String get s5EnvSeeDetails => '환경 자세히 보기';

  @override
  String get s5EnvUnavailable => '현재 환경 정보를 확인할 수 없어요.';

  @override
  String get s5FewRecordsNotice => '기록이 적어 요약에 빈 항목이 있을 수 있어요.';

  @override
  String get s5FgRefreshTitle => '앱 사용 중 환경 새로고침';

  @override
  String get s5FgRefreshHint => '앱이 열려 있는 동안 주변을 확인해요. 백그라운드에서는 작동하지 않아요.';

  @override
  String get s5FieldDate => '날짜';

  @override
  String get s5FieldMedication => '약';

  @override
  String get s5FieldNote => '메모 (선택)';

  @override
  String get s5FieldPuffs => '흡입 횟수 (선택)';

  @override
  String get s5FieldReason => '사용 이유 (선택)';

  @override
  String get s5FieldTime => '시각';

  @override
  String get s5FilterAll => '전체';

  @override
  String get s5FilterInhaler => '흡입기';

  @override
  String get s5FilterMedCheck => '약 사용 확인';

  @override
  String get s5FilterSymptoms => '증상';

  @override
  String get s5FloodIssued => '홍수 경보 발표됨';

  @override
  String get s5FloodNone => '발표된 홍수 경보 없음';

  @override
  String get s5FloodUnknown => '경보 정보를 확인할 수 없음';

  @override
  String s5ForecastCheckedAt(String time) {
    return '확인 시각 $time';
  }

  @override
  String s5ForecastValidFor(String date) {
    return '$date 예보';
  }

  @override
  String get s5FromUrgentHelp => '긴급 도움에서 기록';

  @override
  String get s5HomeStateEmpty => '첫 기록을 남겨 보세요. 진료 때 전달할 내용을 함께 정리할 수 있어요.';

  @override
  String s5HomeStateQuestions(int n) {
    return '의사에게 전달할 질문 $n개가 있어요.';
  }

  @override
  String s5HomeStateRecords(int n) {
    return '최근 7일 중 기록이 있는 날: $n일';
  }

  @override
  String get s5HomeSubtitle => '기록을 모아 진료 때 전달할 수 있어요.';

  @override
  String get s5HomeTitle => '오늘 상태를 기록해 보세요';

  @override
  String s5HumidityValue(int rh) {
    return '실외 습도 $rh%';
  }

  @override
  String get s5IncludeEnvironment => '주변 환경 (선택)';

  @override
  String get s5IncludeEnvironmentHint =>
      '오늘의 대기질·꽃가루·홍수 알림을 추가해요. 상세 위치는 포함하지 않아요.';

  @override
  String get s5InhalerEditTitle => '흡입기 사용 상세';

  @override
  String get s5InhalerEntry => '흡입기 사용';

  @override
  String get s5InhalerLogged => '흡입기 사용을 기록했어요.';

  @override
  String get s5InhalerOneEntryHint =>
      '한 번 저장은 사용 기록 1건이에요. 1회 흡입이나 1일 사용으로 계산하지 않아요.';

  @override
  String s5InhalerUnknownCount(int n) {
    return '약 이름 미확인: $n건';
  }

  @override
  String get s5InsCost => '비용 어려움';

  @override
  String get s5InsDenial => '거절 사유 (안내받은 경우)';

  @override
  String get s5InsMedHistory => '사용해 본 약';

  @override
  String get s5InsuranceIntro => '의료진의 서류 작성을 위해 정보를 정리해요.';

  @override
  String get s5InsuranceLimits =>
      '모든 항목은 선택이에요. 이 앱은 보험사에 아무것도 제출하지 않으며 승인 여부를 판단하지 않아요.';

  @override
  String get s5InsuranceTitle => '보험 서류 준비';

  @override
  String s5LanguageName(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': '영어',
      'es': '스페인어',
      'fr': '프랑스어',
      'ko': '한국어',
      'ja': '일본어',
      'zh': '중국어',
      'other': '다른 언어',
    });
    return '$_temp0';
  }

  @override
  String get s5Last30Days => '최근 30일';

  @override
  String get s5Last7Days => '최근 7일';

  @override
  String get s5LogInhaler => '흡입기 사용 기록';

  @override
  String get s5LogLegend => '한 줄은 저장된 기록 1건이에요. 기록이 없는 날은 ‘미기록’이며 0과 달라요.';

  @override
  String get s5LogSymptoms => '증상 기록';

  @override
  String get s5MedAdd => '약 추가';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return '사용함 $a일 · 사용하지 않음 $b일 · 기억나지 않음 $c일 · 미기록 $d일';
  }

  @override
  String get s5MedCheckIntro =>
      '약을 사용했는지 스스로 확인하는 기록이에요. 약국 조제 자료를 바탕으로 하지 않아요.';

  @override
  String get s5MedCheckQuestion => '계획한 대로 약을 사용했나요?';

  @override
  String get s5MedCheckTitle => '오늘의 약 사용 확인';

  @override
  String get s5MedChooseHint => '약을 선택하거나 ‘약 이름을 모르겠어요’를 선택하세요.';

  @override
  String get s5MedDailyCheck => '매일 확인';

  @override
  String get s5MedDailyCheckHint =>
      '홈에 ‘오늘의 약 사용 확인’을 표시해요. 의료진이 매일 사용하라고 한 약일 때만 켜세요.';

  @override
  String get s5MedDefault => '빠른 기록 기본값';

  @override
  String get s5MedDefaultHint => '홈에서 ‘흡입기 사용 기록’을 누를 때 사용해요.';

  @override
  String get s5MedEdit => '약 수정';

  @override
  String get s5MedNameLabel => '약 이름 (라벨에 적힌 대로)';

  @override
  String get s5MedNotApplicable => '오늘은 사용할 예정이 아니었음';

  @override
  String s5MedNotApplicableDays(int n) {
    return '해당 없음: $n일';
  }

  @override
  String get s5MedNotRecorded => '약 미기록';

  @override
  String get s5MedNotSure => '기억나지 않아요';

  @override
  String get s5MedNotUsed => '사용하지 않았어요';

  @override
  String get s5MedOther => '다른 이름';

  @override
  String get s5MedOtherHint => '약 이름을 입력하세요';

  @override
  String get s5MedReasonCost => '비용 부담';

  @override
  String get s5MedReasonForgot => '잊음';

  @override
  String get s5MedReasonNoMedicine => '약이 없었음';

  @override
  String get s5MedReasonQuestion => '이유 (선택)';

  @override
  String get s5MedUnknown => '약 이름을 모르겠어요';

  @override
  String get s5MedUnknownShort => '약 이름 미확인';

  @override
  String get s5MedUsed => '사용했어요';

  @override
  String get s5MyLanguage => '내 언어';

  @override
  String get s5MyLogTitle => '내 기록';

  @override
  String get s5MyMedsEmpty => '저장한 약이 아직 없어요.';

  @override
  String get s5MyMedsHint => '직접 확인한 약 이름으로 기록을 빠르게 해요. 복용량 권고가 아니에요.';

  @override
  String get s5MyMedsOpen => '내 약 관리';

  @override
  String get s5MyMedsTitle => '내 약 관리';

  @override
  String get s5NavEnvironment => '환경';

  @override
  String get s5NavLog => '기록';

  @override
  String get s5NavVisitPrep => '진료 준비';

  @override
  String get s5NoAnswer => '답하지 않음';

  @override
  String get s5NoRecordsYet => '아직 기록이 없어요';

  @override
  String s5NoSymptomDays(int n) {
    return '‘증상 없음’으로 기록한 날: $n일';
  }

  @override
  String get s5NotRecorded => '미기록';

  @override
  String get s5NotRecordedToday => '오늘 미기록';

  @override
  String s5NotTranslatedLine(String language, String text) {
    return '[미번역 · 원문 $language] $text';
  }

  @override
  String get s5OsNotificationsOff =>
      '휴대폰 설정에서 Howse Asthma 알림이 꺼져 있어 알림이 표시되지 않아요.';

  @override
  String get s5PdfAboutMedCheck =>
      '약 사용 확인은 환자의 자가보고예요. 약국 조제 자료가 아니며 PDC(처방 일수 비율)가 아니에요.';

  @override
  String get s5PdfAboutNoScore => '설문 점수나 앱이 만든 위험 점수는 포함하지 않아요.';

  @override
  String get s5PdfAboutPatientReported =>
      '모든 기록은 환자가 Howse Asthma 앱에 직접 입력했으며 검증되지 않았어요.';

  @override
  String get s5PdfAppendix => '부록: 환자 메모';

  @override
  String s5PdfDaysNotRecorded(int n) {
    return '증상 기록이 없는 날(미기록): $n일';
  }

  @override
  String get s5PdfDisclaimer =>
      '이 요약은 의료진 검토를 위한 환자 보고 정보예요. 진단이나 사전 승인 결정이 아니에요.';

  @override
  String get s5PdfEnvNote => '요약을 만든 시점의 일반적인 실외 환경이에요. 위치는 포함하지 않아요.';

  @override
  String get s5PdfFailed => 'PDF를 만들지 못했어요. 입력한 내용은 유지했어요. 다시 시도해 주세요.';

  @override
  String get s5PdfFontFailed => 'PDF 글꼴을 준비하지 못했어요. 인터넷 연결을 확인하고 다시 시도해 주세요.';

  @override
  String s5PdfGeneratedAt(String time) {
    return '생성: $time';
  }

  @override
  String s5PdfInhalerByMed(String name, int n) {
    return '$name: $n건';
  }

  @override
  String s5PdfInhalerMedNotRecorded(int n) {
    return '약 미기록: $n건';
  }

  @override
  String s5PdfInhalerUnknown(int n) {
    return '환자가 약 이름을 모름: $n건';
  }

  @override
  String s5PdfInhalerUses(int n, int days) {
    return '흡입기 사용 기록: $n건 ($days일)';
  }

  @override
  String get s5PdfIsEnglish => 'PDF는 영문으로 만들어져요. 직접 입력한 글은 원문 그대로 들어가요.';

  @override
  String get s5PdfMedNamesAsEntered => '약 이름은 환자가 입력한 그대로 표시해요.';

  @override
  String get s5PdfNotRecorded => '미기록';

  @override
  String s5PdfNotUsedReason(String label, int n) {
    return '사용하지 않은 이유(자가보고) — $label: $n일';
  }

  @override
  String get s5PdfOutdated =>
      '마지막 PDF 이후 기록이나 답변이 바뀌었어요. 변경 내용을 넣으려면 PDF를 새로 만드세요.';

  @override
  String s5PdfPeriod(String start, String end, int days) {
    return '요약 기간: $start – $end ($days일)';
  }

  @override
  String s5PdfReasonCount(String label, int n) {
    return '사용 이유 — $label: $n건';
  }

  @override
  String s5PdfRecordedDays(int n) {
    return '환자 기록이 있는 날: $n일';
  }

  @override
  String get s5PdfSectionAboutData => '자료의 성격';

  @override
  String get s5PdfSectionBarriers => '치료 접근의 어려움 (자가보고)';

  @override
  String get s5PdfSectionEnvironment => '주변 환경 (참고)';

  @override
  String get s5PdfSectionInhaler => '흡입기 사용';

  @override
  String get s5PdfSectionInsurance => '서류용 메모 (환자 제공)';

  @override
  String get s5PdfSectionMedChecks => '자가보고 약 사용 기록';

  @override
  String get s5PdfSectionQuestions => '환자 질문';

  @override
  String get s5PdfSectionSymptoms => '증상';

  @override
  String s5PdfSymptomCodeDays(String label, int n) {
    return '$label: $n일';
  }

  @override
  String s5PdfSymptomDays(int n, int days) {
    return '증상이 있었던 날: $days일 중 $n일';
  }

  @override
  String s5PdfSymptomOtherDays(int n) {
    return '환자가 직접 적은 기타 증상: $n일';
  }

  @override
  String get s5PdfTitle => '환자 보고 천식 진료 요약';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return '기간 $days일 · 기록이 있는 날 $n일';
  }

  @override
  String get s5PhoneHint => '국가번호를 포함해 입력하세요. 예: +1 201 555 0123';

  @override
  String get s5PhoneInvalid => '이름과 국가번호를 포함한 전화번호를 입력하세요. 예: +1 201 555 0123';

  @override
  String get s5PollenGrass => '잔디';

  @override
  String s5PollenMainType(String type) {
    return '주요 종류: $type';
  }

  @override
  String get s5PollenTree => '나무';

  @override
  String get s5PollenWeed => '잡초';

  @override
  String get s5PrepareVisit => '진료 준비하기';

  @override
  String get s5PreviewEditHint =>
      '질문이나 메모는 이전 화면에서 고칠 수 있어요. 숫자는 내 기록에서 원래 기록을 고쳐 주세요.';

  @override
  String get s5PreviewSummary => '진료 요약 미리보기';

  @override
  String get s5PreviewTitle => '진료 요약 미리보기';

  @override
  String s5PuffsValue(int n) {
    return '$n회 흡입';
  }

  @override
  String s5QuestionN(int n) {
    return '질문 $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return '질문 $n/$total';
  }

  @override
  String get s5ReasonBeforeActivity => '활동 전';

  @override
  String get s5ReasonOther => '기타';

  @override
  String get s5ReasonSymptoms => '증상 때문에';

  @override
  String s5RecentInhaler(int n) {
    return '흡입기 사용 기록 $n건';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return '증상이 있었던 날 $n일';
  }

  @override
  String get s5RecentTitle => '최근 7일';

  @override
  String get s5RecordsLoadFailed => '기록을 불러오지 못했어요. 다시 시도해 주세요.';

  @override
  String get s5RecordsManageHint =>
      '기록은 내 기록에서 수정하거나 삭제할 수 있어요. 삭제할 때는 항상 확인해요.';

  @override
  String get s5Refresh => '새로고침';

  @override
  String get s5Reload => '다시 불러오기';

  @override
  String get s5Save => '저장';

  @override
  String get s5Saved => '기록을 저장했어요.';

  @override
  String get s5SavedPlacesHint => '집, 학교, 직장 같은 저장한 장소';

  @override
  String get s5SaveFailed => '저장하지 못했어요. 입력한 내용은 유지했어요.';

  @override
  String get s5SavePdf => 'PDF 저장';

  @override
  String get s5SettingsAlerts => '알림';

  @override
  String get s5SettingsArea => '지역';

  @override
  String get s5SettingsHelp => '도움말';

  @override
  String get s5SettingsLanguageNote =>
      '진료 요약은 영문으로 만들어지며, 공유 전에 내 언어와 비교해 확인할 수 있어요.';

  @override
  String get s5SettingsSecurityData => '보안·데이터';

  @override
  String get s5Share => '공유';

  @override
  String get s5SourcesAir => '대기질: EPA AirNow, Open-Meteo, PurpleAir';

  @override
  String get s5SourcesFlood => '홍수 알림: 미국 국립기상청';

  @override
  String get s5SourcesNjTraffic => '교통량 자료는 뉴저지에서만 사용해요.';

  @override
  String get s5SourcesNoRiskScore => '앱 내부 종합 점수는 천식 발작 위험이 아니며 표시하지 않아요.';

  @override
  String get s5SourcesPollen => '꽃가루: Google Pollen API';

  @override
  String get s5SourcesTitle => '출처와 한계';

  @override
  String get s5SourcesWeather => '날씨·습도: Open-Meteo';

  @override
  String get s5StatusLatest => '최신';

  @override
  String get s5StatusOlder => '오래된 자료';

  @override
  String get s5StatusUnavailable => '지금은 확인 불가';

  @override
  String get s5SymActivityLimited => '활동에 지장';

  @override
  String get s5SymCough => '기침';

  @override
  String get s5SymNightWaking => '밤에 잠에서 깸';

  @override
  String get s5SymNone => '증상 없음';

  @override
  String get s5SymOther => '직접 입력';

  @override
  String get s5SymOtherHint => '내 말로 적어 주세요';

  @override
  String get s5SymShortBreath => '숨쉬기 불편함';

  @override
  String get s5SymWheeze => '쌕쌕거림';

  @override
  String get s5SymptomEditTitle => '증상 수정';

  @override
  String get s5SymptomEntry => '증상';

  @override
  String get s5SymptomNoneHint => '기록하지 않은 날은 ‘증상 없음’이 아니라 ‘미기록’으로 표시돼요.';

  @override
  String get s5SymptomQuestion => '어떤 증상이 있었나요?';

  @override
  String get s5Today => '오늘';

  @override
  String get s5Undo => '실행 취소';

  @override
  String s5UntranslatedNotice(int n) {
    return '번역하지 못한 항목 $n개가 있어요. 영문 PDF에 원문 그대로 ‘Not translated’ 표시와 함께 들어가요. 원문을 확인해 주세요.';
  }

  @override
  String s5UpdatedAt(String time) {
    return '갱신 $time';
  }

  @override
  String get s5UpiHigh => '높음';

  @override
  String get s5UpiLow => '낮음';

  @override
  String get s5UpiModerate => '보통';

  @override
  String get s5UpiNone => '없음';

  @override
  String s5UpiValue(int upi, String category) {
    return '5 중 $upi · $category';
  }

  @override
  String get s5UpiVeryHigh => '매우 높음';

  @override
  String get s5UpiVeryLow => '매우 낮음';

  @override
  String get s5UrgentActionPlan => '의료진에게 받은 천식 행동계획이 있다면 그대로 따르세요.';

  @override
  String get s5UrgentCall911Locked => '긴급 도움: 911 전화';

  @override
  String get s5UrgentHelp => '긴급 도움';

  @override
  String get s5UrgentIntro => '숨쉬기가 매우 힘들거나 나아지지 않으면 911에 전화하세요.';

  @override
  String get s5UrgentLogHint => '선택: 흡입기를 사용했다는 기록을 남길 수 있어요.';

  @override
  String get s5UrgentNoContact => '아직 비상 연락처가 없어요. 설정 → 도움말에서 추가하세요.';

  @override
  String s5UsingMedication(String name) {
    return '기록할 약: $name';
  }

  @override
  String get s5ViewMyLog => '내 기록 보기';

  @override
  String get s5VisitBarriers => '치료를 받는 데 어려움이 있었나요?';

  @override
  String s5VisitCardDetail(int days, int recorded, int questions) {
    return '최근 $days일 · 기록이 있는 날 $recorded일 · 질문 $questions개';
  }

  @override
  String get s5VisitCardTitle => '진료 때 전달할 내용';

  @override
  String get s5VisitInclude => '포함할 기록';

  @override
  String get s5VisitIntro => '증상과 궁금한 점을 정리해 의료진에게 보여주세요.';

  @override
  String get s5VisitPeriod => '요약 기간';

  @override
  String get s5VisitPrepTitle => '진료 준비';

  @override
  String get s5VisitQuestions => '의사에게 물어볼 내용';

  @override
  String get s5VisitQuestionsHint => '내 언어로 적으세요. 비워 두어도 괜찮아요.';

  @override
  String get s6AddTime => '시각 추가';

  @override
  String get s6AddVisit => '내가 보고한 진료 추가';

  @override
  String get s6BringPaper => '서류를 가져갈 예정';

  @override
  String get s6BringPaperHint => '서류가 있다는 것은 의료진이 확인했다는 뜻이 아닙니다.';

  @override
  String s6DaySummary(
    String date,
    int used,
    int scheduled,
    int open,
    int symptoms,
    String env,
  ) {
    return '$date · 확인 $used/$scheduled · 미응답 $open · 증상 $symptoms · $env';
  }

  @override
  String get s6DoseLater => '나중에 확인';

  @override
  String get s6DoseNotUsed => '사용하지 못했어요';

  @override
  String get s6DoseUnconfirmed => '아직 응답 없음';

  @override
  String get s6DoseUsed => '사용했어요';

  @override
  String get s6EnvLinked => '환경 연결됨';

  @override
  String get s6EnvNoData => '당시 환경 자료 없음';

  @override
  String get s6EvidenceBody => '의료진이 검토할 기록과 추가로 필요한 정보를 정리합니다.';

  @override
  String get s6EvidenceNotOfficial => '일반적인 자료 목록입니다. 특정 보험의 공식 요구사항 목록이 아닙니다.';

  @override
  String get s6EvidenceTitle => '진료·보험 검토 자료 준비';

  @override
  String get s6HideMedName => '잠금 화면에서 약 이름 숨기기';

  @override
  String get s6HideMedNameHint => '알림은 저장한 복용 시각에만 옵니다. 30분마다 반복되는 알림이 아닙니다.';

  @override
  String get s6HomeWaterNo => '아니요';

  @override
  String get s6HomeWaterQuestion => '집에 누수나 침수가 있었나요?';

  @override
  String get s6HomeWaterYes => '예';

  @override
  String get s6ItemClinician => '의료진 확인 또는 첨부 자료';

  @override
  String get s6ItemEnvironment => '사건 당시 지역 환경 참고자료';

  @override
  String get s6ItemMedication => '약 이름과 처방 내용';

  @override
  String get s6ItemSymptoms => '지속된 증상과 일상생활의 어려움';

  @override
  String get s6ItemUse => '사용 기간과 환자가 확인한 사용 기록';

  @override
  String get s6ItemVisits => '환자가 보고한 진료·응급실 방문';

  @override
  String get s6NoSchedule => '저장한 복용 시각이 없습니다. 내 약에서 추가하세요.';

  @override
  String get s6OccurredLabel => '증상이 생긴 시각';

  @override
  String get s6PdfEnvLimit =>
      '지역 참고입니다. 개인 노출이나 증상의 원인을 보여 주지 않습니다. AQI 하나만으로 오존과 입자를 함께 말하지 않으며, 꽃가루는 포함하지 않습니다.';

  @override
  String get s6PdfEnvTitle => '환경 참고 (부록)';

  @override
  String get s6PuffsEach => '한 번에 흡입하는 횟수';

  @override
  String s6ReminderBodyNamed(String name) {
    return '$name 사용을 확인해 주세요';
  }

  @override
  String get s6ReminderBodyPrivate => '약 사용을 확인해 주세요';

  @override
  String get s6ReminderChannel => '저장한 복용 시각의 알림입니다. 30분마다 오는 대기·날씨 알림이 아닙니다.';

  @override
  String get s6ReminderTitle => '약 사용 확인';

  @override
  String get s6RoleBoth => '매일 그리고 필요할 때';

  @override
  String get s6RoleController => '매일 사용하는 약';

  @override
  String get s6RoleRescue => '필요할 때 사용하는 약';

  @override
  String get s6ScheduleTimes => '복용 시각';

  @override
  String get s6StatusClinician => '의료진 확인 필요';

  @override
  String get s6StatusNeedInfo => '정보 추가 필요';

  @override
  String get s6StatusRecorded => '기록 있음';

  @override
  String get s6TimelineTitle => '치료와 환경';

  @override
  String get s6TodayDoses => '오늘 확인할 약';

  @override
  String get s6VisitKindEr => '응급실 (내가 보고)';

  @override
  String get s6VisitKindOffice => '외래 진료 (내가 보고)';

  @override
  String get s6VisitKindOther => '기타 진료 (내가 보고)';

  @override
  String get s6VisitKindUrgent => '긴급 진료 (내가 보고)';

  @override
  String get v2SettingsTitle => '급여 통지서';

  @override
  String get v2NavToggle => '급여 통지서 홈 보기';

  @override
  String get v2NavToggleHint =>
      '거부 통지서를 읽고 진료 자료를 준비하는 미리보기입니다. 기존 기록은 그대로 열 수 있습니다. 실제 문서 읽기는 꺼져 있습니다.';

  @override
  String get v2HomeHeadline => '급여 거부 편지를 이해하고 진료 준비 자료를 만드세요.';

  @override
  String get v2HomeBody => '앱은 항소를 제출하지 않고, 보험이 승인할지도 판단하지 않습니다.';

  @override
  String get v2AddLetter => '거부 편지 추가';

  @override
  String get v2TrySample => '샘플로 체험';

  @override
  String get v2SampleBanner => '샘플입니다. 실제 통지서도, 실제 분석도 아닙니다.';

  @override
  String get v2LiveOffTitle => '실제 문서 읽기가 꺼져 있습니다';

  @override
  String get v2LiveOffBody =>
      '이 빌드에서는 사진과 파일을 분석하지 않습니다. 표시된 샘플로 단계를 살펴볼 수 있습니다.';

  @override
  String get v2Close => '닫기';

  @override
  String get v2MyRecords => '내 기록';

  @override
  String get v2EmptyCases => '아직 편지가 없습니다.';

  @override
  String get v2MedNeedsReview => '약물 확인 필요';

  @override
  String get v2NextCheck => '다음: 내용 확인';

  @override
  String get v2NextDraft => '다음: 초안 만들기';

  @override
  String get v2Created => '추가됨';

  @override
  String get v2StatusDraft => '초안 준비됨';

  @override
  String get v2StatusReady => '초안을 만들 수 있음';

  @override
  String get v2StatusReview => '확인 필요';

  @override
  String get v2DeadlineLabel => '기한';

  @override
  String get v2ExplainTitle => '쉬운 설명';

  @override
  String get v2CheckTitle => '확인할 내용';

  @override
  String get v2RecordsTitle => '내 기록';

  @override
  String get v2DocsTitle => '문서 만들기';

  @override
  String get v2Original => '원문';

  @override
  String get v2Patient => '통지서의 이름';

  @override
  String get v2EditMedication => '약물명 원문';

  @override
  String get v2Dose => '적힌 그대로의 용량';

  @override
  String get v2ReasonMissing => '이유를 확인하지 못했습니다.';

  @override
  String get v2ConfirmDate => '통지서에 적힌 날짜가 맞습니다';

  @override
  String get v2SaveEdit => '수정 저장';

  @override
  String get v2ConfirmFacts => '이 내용을 확인했습니다';

  @override
  String get v2Confirmed => '확인함';

  @override
  String get v2NoRecords => '연결된 기록이 없습니다. 그래도 초안을 만들 수 있습니다. 복약 비율은 만들지 않습니다.';

  @override
  String get v2SelfReportLabel => '선택 메모 (환자 자가 보고)';

  @override
  String get v2EnglishDraft => '검토용 영어 초안입니다. 제출용 번역본이 아닙니다.';

  @override
  String get v2DraftBannerNote => '모든 페이지에 의사 검토가 필요하다는 표시가 있습니다.';

  @override
  String get v2StaleDraft => '내용이 바뀌었습니다. 공유하기 전에 초안을 다시 만드세요.';

  @override
  String get v2GenerateReview => '검토용 초안 만들기';

  @override
  String get v2GeneratePrepared => '제출 준비용 초안 만들기';

  @override
  String get v2PreparedBlocked => '제출 준비용 초안은 이름, 약물, 거부 이유를 확인해야 합니다.';

  @override
  String get v2NotInitial => '이 문서는 처음 받은 약제 거부가 아닙니다. 항소 초안을 만들지 않습니다.';

  @override
  String get v2GenericError => '이 단계를 마치지 못했습니다. 다시 시도할 수 있습니다.';

  @override
  String get v2Share => '공유';

  @override
  String get v2ClinicianPdf => '의사용 1페이지 PDF';

  @override
  String get v2ShareNotSubmitted => '공유했다고 해서 보험사가 파일을 받은 것은 아닙니다.';

  @override
  String get v2DeleteCase => '이 샘플 삭제';

  @override
  String get v2Deleted => '미리보기에서 제거했습니다.';

  @override
  String get v2FontUnavailable => 'PDF 글꼴을 불러오지 못했습니다. 인터넷에 연결된 뒤 다시 시도하세요.';

  @override
  String get v2NotEntered => '[미입력]';

  @override
  String get v2DocDeadline => '문서에 적힌 기한';

  @override
  String get v2CalcDeadline => '입력한 수령일 기준 계산';

  @override
  String get v2NeedReceived => '통지서는 받은 날부터 며칠로 적혀 있습니다. 날짜를 계산하려면 수령일을 입력하세요.';

  @override
  String get v2UnclearDeadline => '기한 문장이 분명하지 않습니다. 날짜를 계산하지 않았습니다.';

  @override
  String get v2AskPlan => '문서에서 기한을 확인하지 못했습니다. 보험사에 확인하세요.';

  @override
  String get cnTagline => '보험 편지, 다음 할 일을 분명하게';

  @override
  String get cnDemoBadge => '샘플';

  @override
  String get cnDemoBadgeLong => '가상 데이터로 만든 샘플입니다. 결과는 고정되어 있습니다.';

  @override
  String get cnAuthSignInTitle => '로그인';

  @override
  String get cnAuthCreateTitle => '계정 만들기';

  @override
  String get cnAuthResetTitle => '비밀번호 재설정';

  @override
  String get cnAuthSignIn => '로그인';

  @override
  String get cnAuthCreate => '계정 만들기';

  @override
  String get cnAuthSendReset => '재설정 링크 보내기';

  @override
  String cnAuthProfileError(String code) {
    return '로그인은 되었지만 계정 정보를 불러오지 못했습니다($code).';
  }

  @override
  String get cnRetry => '다시 시도';

  @override
  String get cnSignOut => '로그아웃';

  @override
  String get cnAuthPreparingAccount => '계정을 준비하는 중…';

  @override
  String get cnAuthNameLabel => '이름(선택)';

  @override
  String get cnAuthNameHelper => '제출 자료에 표시됩니다. 나중에 바꿀 수 있습니다.';

  @override
  String get cnAuthEmailLabel => '이메일';

  @override
  String get cnAuthPasswordLabel => '비밀번호';

  @override
  String get cnAuthPasswordHelper => '8자 이상';

  @override
  String get cnAuthShowPassword => '비밀번호 보기';

  @override
  String get cnAuthHidePassword => '비밀번호 숨기기';

  @override
  String get cnAuthPasswordRequired => '비밀번호를 입력하세요';

  @override
  String cnAuthCheckEmail(String email) {
    return '$email(으)로 확인 링크를 보냈습니다. 이 휴대폰에서 링크를 연 뒤 로그인하세요.';
  }

  @override
  String cnAuthResetSent(String email) {
    return '$email 계정이 있으면 재설정 링크가 전송됩니다. 이 휴대폰에서 여세요.';
  }

  @override
  String get cnAuthResent => '다시 보냈습니다.';

  @override
  String get cnAuthResend => '메일 다시 보내기';

  @override
  String get cnAuthSignInInstead => '인증했어요. 로그인';

  @override
  String get cnAuthForgot => '비밀번호를 잊으셨나요?';

  @override
  String get cnAuthNoAccount => '처음이신가요? 계정 만들기';

  @override
  String get cnAuthHaveAccount => '계정이 있으신가요? 로그인';

  @override
  String get cnAuthResetHint => '이메일을 입력하면 새 비밀번호를 설정할 링크를 보내드립니다.';

  @override
  String get cnAuthBackToSignIn => '로그인으로 돌아가기';

  @override
  String get cnAuthPrivacyLine => '편지와 기록은 내 계정에서만 볼 수 있습니다.';

  @override
  String get cnAuthPasswordUpdated => '비밀번호를 바꿨습니다.';

  @override
  String get cnAuthNewPasswordTitle => '새 비밀번호 설정';

  @override
  String get cnAuthNewPasswordLabel => '새 비밀번호';

  @override
  String get cnAuthSavePassword => '비밀번호 저장';

  @override
  String get cnLater => '나중에';

  @override
  String get cnAuthErrInvalidCredentials => '이메일 또는 비밀번호가 맞지 않습니다.';

  @override
  String get cnAuthErrNotConfirmed =>
      '먼저 이메일 인증을 완료하세요. 받은편지함을 확인하거나 링크를 다시 보내세요.';

  @override
  String get cnAuthErrExists => '이 이메일로 만든 계정이 이미 있습니다. 로그인하세요.';

  @override
  String get cnAuthErrWeakPassword => '더 안전한 비밀번호를 사용하세요(8자 이상).';

  @override
  String get cnAuthErrSamePassword => '이전과 다른 비밀번호를 사용하세요.';

  @override
  String get cnAuthErrRateLimited => '시도가 너무 많습니다. 잠시 후 다시 시도하세요.';

  @override
  String get cnAuthErrInvalidEmail => '이메일 주소를 확인하세요.';

  @override
  String get cnAuthErrEmailNotAuthorized =>
      '지금은 이 주소로 메일을 보낼 수 없습니다. 나중에 다시 시도하세요.';

  @override
  String get cnAuthErrDisabled => '이 로그인 방식은 꺼져 있습니다.';

  @override
  String get cnAuthErrSessionExpired => '세션이 끝났습니다. 다시 로그인하세요.';

  @override
  String cnAuthErrUnknown(String code) {
    return '문제가 발생했습니다($code). 다시 시도하세요.';
  }

  @override
  String get cnErrNetwork => '인터넷에 연결되어 있지 않습니다. 연결을 확인하고 다시 시도하세요.';

  @override
  String get cnErrServiceDown => '서비스가 응답하지 않습니다. 몇 분 뒤 다시 시도하세요.';

  @override
  String get cnTabHome => '홈';

  @override
  String get cnTabCases => '케이스';

  @override
  String get cnTabRecords => '기록';

  @override
  String get cnTabAccount => '계정';

  @override
  String get cnHomeHeadline => '보험 편지를 쉽게 이해하세요.';

  @override
  String get cnScanLetter => '편지 촬영';

  @override
  String get cnUploadFile => 'PDF·사진 올리기';

  @override
  String get cnTryDemo => '데모 보기';

  @override
  String get cnHomeSignInLine => '케이스를 저장하려면 계정이 필요합니다.';

  @override
  String get cnServiceNotConfigured =>
      '이 빌드는 서버에 연결되어 있지 않습니다. 데모만 사용할 수 있습니다.';

  @override
  String get cnContinueCase => '진행 중인 케이스';

  @override
  String get cnHowItWorks => '이용 방법';

  @override
  String get cnStep1Title => '편지 읽기';

  @override
  String get cnStep1Body => '사진을 찍으면 이유, 다음 할 일, 날짜를 찾아 드립니다.';

  @override
  String get cnStep2Title => '자료 모으기';

  @override
  String get cnStep2Body => '편지가 요청한 자료를 내 기록과 연결합니다.';

  @override
  String get cnStep3Title => '제출 자료 만들기';

  @override
  String get cnStep3Body => '의사용 1페이지 요약과 재검토 요청 초안을 받습니다.';

  @override
  String get cnRecentCases => '다른 케이스';

  @override
  String get cnNoCasesYet => '아직 케이스가 없습니다';

  @override
  String get cnNoOtherCases => '다른 케이스가 없습니다.';

  @override
  String get cnSeeAllCases => '모든 케이스 보기';

  @override
  String get cnNoCasesBody => '보험 편지를 촬영해 시작하세요.';

  @override
  String get cnCasesSignInTitle => '로그인하면 케이스를 볼 수 있습니다';

  @override
  String get cnCasesSignInBody => '또는 데모로 사용 방법을 확인하세요.';

  @override
  String get cnCaseDeleted => '케이스를 삭제했습니다.';

  @override
  String get cnCaseUntitled => '보험 편지';

  @override
  String get cnStatusReading => '편지 읽는 중';

  @override
  String get cnStatusNeedsReview => '확인 필요';

  @override
  String get cnStatusGatherRecords => '자료 모으기';

  @override
  String get cnStatusPacketReady => '자료 준비됨';

  @override
  String get cnStatusNeedsAttention => '조치 필요';

  @override
  String get cnStatusNotStarted => '시작 전';

  @override
  String get cnNextWaitReading => '편지를 읽고 있습니다.';

  @override
  String get cnNextTryAgain => '읽기가 멈췄습니다. 케이스를 열어 다시 시도하세요.';

  @override
  String cnNextFactsToConfirm(int count) {
    return '확인할 내용 $count개';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return '요청 자료 $total개 중 $done개 처리';
  }

  @override
  String get cnNextSharePacket => '보낼 자료가 준비됨';

  @override
  String get cnNextCreatePacket => '다음: 제출 자료 만들기';

  @override
  String cnDateToCheckShort(String date) {
    return '확인할 날짜: $date';
  }

  @override
  String cnDatePassedShort(String date) {
    return '지난 날짜: $date';
  }

  @override
  String get cnMoreActions => '더보기';

  @override
  String get cnDeleteCase => '케이스 삭제';

  @override
  String get cnDeleteCaseTitle => '이 케이스를 삭제할까요?';

  @override
  String get cnDeleteCaseBody =>
      '편지 사진, 읽어낸 내용, 연결한 기록 요약, 제출 자료가 삭제됩니다. 복약·증상 기록은 그대로 남습니다.';

  @override
  String get cnCancel => '취소';

  @override
  String get cnDelete => '삭제';

  @override
  String get cnDeleteFailed => '삭제하지 못했습니다. 연결을 확인하고 다시 시도하세요.';

  @override
  String get cnKindInitialDenial => '약제 보장 거부';

  @override
  String get cnKindInfoRequest => '추가 자료 요청';

  @override
  String get cnKindReauth => '재승인(갱신) 안내';

  @override
  String get cnKindFinalDenial => '최종 이의신청 결정';

  @override
  String get cnKindEob => '청구서 또는 급여 설명서(Explanation of Benefits)';

  @override
  String get cnKindOther => '기타 편지';

  @override
  String get cnKindUncertain => '편지 종류 불분명';

  @override
  String get cnFieldPatientName => '환자 이름';

  @override
  String get cnFieldPlanName => '보험 상품';

  @override
  String get cnFieldMemberId => '회원 번호';

  @override
  String get cnFieldCaseReference => '케이스·참조 번호';

  @override
  String get cnFieldMedication => '약물(원문 그대로)';

  @override
  String get cnFieldDose => '용량(원문 그대로)';

  @override
  String get cnFieldNoticeDate => '통지 날짜';

  @override
  String get cnFieldContact => '문의처';

  @override
  String get cnFieldSubmissionRoute => '제출 경로';

  @override
  String get cnFactEdited => '직접 수정함';

  @override
  String get cnFactChecked => '확인함';

  @override
  String get cnFactNotInLetter => '편지에 없음';

  @override
  String get cnFactNeedsCheck => '확인 필요';

  @override
  String get cnFactFromLetter => '편지에서 찾음';

  @override
  String get cnWhoYou => '본인';

  @override
  String get cnWhoCareTeam => '의료진';

  @override
  String get cnWhoPlan => '보험사';

  @override
  String get cnWhoUnknown => '모름';

  @override
  String get cnReqLinked => '연결됨';

  @override
  String get cnReqAskedCareTeam => '의료진에 요청함';

  @override
  String get cnReqNotAvailable => '자료 없음';

  @override
  String get cnReqNotNeeded => '해당 없음';

  @override
  String get cnReqNeeded => '필요';

  @override
  String get cnReqReset => '필요로 되돌리기';

  @override
  String get cnRecMedication => '복약 기록';

  @override
  String get cnRecSymptoms => '증상 기록';

  @override
  String get cnRecLocalContext => '환경 요인';

  @override
  String get cnRecPrn => '필요 시 흡입기';

  @override
  String get cnDemoTitle => '데모';

  @override
  String get cnDemoReset => '데모 초기화';

  @override
  String get cnDemoResetDone => '데모를 초기화했습니다.';

  @override
  String get cnDemoIntro =>
      '각 단계를 볼 수 있도록 결과가 고정된 가상 편지 3개입니다. 아무것도 업로드되지 않습니다.';

  @override
  String get cnUpEmpty => '빈 파일입니다.';

  @override
  String cnUpTooLarge(int mb) {
    return '파일 하나는 ${mb}MB 이하여야 합니다.';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return '전체 페이지는 ${mb}MB 이하여야 합니다.';
  }

  @override
  String cnUpTooManyPages(int max) {
    return '편지 하나에 최대 $max페이지까지 올릴 수 있습니다.';
  }

  @override
  String get cnUpUnsupported => 'JPG, PNG, PDF를 사용하세요. HEIC 사진은 여기서 다시 촬영하세요.';

  @override
  String get cnUpBadFile => '읽을 수 없는 파일입니다. 다른 사진이나 PDF를 사용하세요.';

  @override
  String get cnUpEncrypted => '암호가 걸린 PDF입니다. 잠금 없는 사본을 저장하거나 사진을 찍으세요.';

  @override
  String get cnCameraUnavailable => '카메라를 사용할 수 없습니다. 대신 사진이나 PDF를 올릴 수 있습니다.';

  @override
  String get cnPhotosUnavailable =>
      '사진을 열 수 없습니다. 설정에서 사진 접근을 허용하거나 PDF를 올리세요.';

  @override
  String get cnFilesUnavailable => '지금은 파일을 열 수 없습니다. 다시 시도하세요.';

  @override
  String get cnUploadFailed => '업로드가 끝나지 않았습니다. 페이지는 그대로 있으니 다시 시도하세요.';

  @override
  String get cnCaptureTitle => '편지 페이지 추가';

  @override
  String get cnReplacePagesTitle => '편지 페이지 교체';

  @override
  String get cnOpening => '여는 중…';

  @override
  String get cnCaptureEmptyTitle => '편지 페이지를 추가하세요';

  @override
  String get cnCaptureTips =>
      '밝은 곳에 종이를 평평하게 놓고 네 모서리가 모두 보이게 찍으세요. 모든 페이지를 순서대로 추가하세요.';

  @override
  String get cnTakePhoto => '사진 찍기';

  @override
  String get cnAddPage => '페이지 추가';

  @override
  String get cnAddPhoto => '사진';

  @override
  String get cnPickGallery => '앨범에서 고르기';

  @override
  String get cnLabelForm => '제형(적힌 그대로)';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    return '$pages페이지 · ${size}MB';
  }

  @override
  String get cnUploadConsent =>
      '업로드하면 이 페이지가 CoverNote 서버로 전송되고 AI 서비스가 내용을 읽습니다. 케이스는 언제든 삭제할 수 있습니다.';

  @override
  String get cnStageUploading => '업로드 중';

  @override
  String get cnUploadAndRead => '업로드하고 읽기';

  @override
  String cnPageN(int n) {
    return '$n페이지';
  }

  @override
  String cnPdfPages(int n, int count) {
    return '파일 $n · PDF $count페이지';
  }

  @override
  String cnPreviewPage(int n) {
    return '$n페이지 미리보기';
  }

  @override
  String get cnRotate => '회전';

  @override
  String get cnRetake => '다시 찍기';

  @override
  String get cnRemovePage => '삭제';

  @override
  String get cnReorder => '끌어서 순서 바꾸기';

  @override
  String get cnServiceUnavailableBody =>
      '지금은 편지 읽기 기능을 사용할 수 없습니다. 페이지는 저장되어 있으니 나중에 다시 시도하세요.';

  @override
  String get cnNeedNewPagesBody => '더 선명하게 찍거나 페이지 수를 줄여 다시 올리세요.';

  @override
  String get cnPagesKept => '페이지는 저장되어 있고 바뀐 것은 없습니다.';

  @override
  String get cnReplacePages => '페이지 교체';

  @override
  String get cnTryAgain => '다시 시도';

  @override
  String get cnStageReading => '읽는 중';

  @override
  String get cnStageChecking => '확인 중';

  @override
  String get cnStageReady => '완료';

  @override
  String get cnReadingTitle => '편지를 읽고 있습니다';

  @override
  String get cnReadingBody => '끝나면 찾아낸 내용을 편지와 비교해 확인합니다.';

  @override
  String get cnReadingLeaveOk => '이 화면을 나가도 됩니다. 읽기는 계속되고 케이스는 저장됩니다.';

  @override
  String get cnStartReading => '읽기 시작';

  @override
  String get cnStepLetter => '편지';

  @override
  String get cnStepReview => '확인';

  @override
  String get cnStepEvidence => '자료';

  @override
  String get cnStepPacket => '제출 자료';

  @override
  String cnStepOf(int n, int total, String name) {
    return '$total단계 중 $n단계: $name';
  }

  @override
  String get cnSaving => '저장 중…';

  @override
  String get cnSaved => '저장됨';

  @override
  String get cnNotSavedRetry => '저장 안 됨 · 재시도';

  @override
  String get cnViewOriginal => '원본 페이지 보기';

  @override
  String cnLetterPagesRead(int count) {
    return '$count페이지 읽음';
  }

  @override
  String cnPagesHardToRead(String list) {
    return '읽기 어려운 페이지: $list. 해당 내용을 꼼꼼히 확인하거나 다시 찍으세요.';
  }

  @override
  String get cnRetakePages => '페이지 다시 찍기';

  @override
  String get cnHardToRead => '읽기 어려움';

  @override
  String get cnContinueToReview => '확인 단계로';

  @override
  String get cnOriginalPages => '원본 페이지';

  @override
  String get cnNoOriginal => '저장된 원본 페이지가 없습니다.';

  @override
  String get cnCheckDetails => '세부 내용 확인';

  @override
  String get cnCheckDetailsHint => '각 값을 편지와 비교하세요. 인용문을 누르면 원문 위치를 볼 수 있습니다.';

  @override
  String cnItemsLeftToCheck(int count) {
    return '계속하려면 $count개 항목을 더 확인하세요';
  }

  @override
  String get cnContinueToEvidence => '자료 단계로';

  @override
  String cnSeePage(int n) {
    return '$n페이지 보기';
  }

  @override
  String get cnWhatLetterIs => '편지 종류';

  @override
  String get cnLooksRight => '맞아요';

  @override
  String get cnChange => '변경';

  @override
  String get cnCardWhyDenied => '거부 이유';

  @override
  String get cnCardWhatTheyNeed => '요청한 내용';

  @override
  String get cnCardWhatItSays => '편지 내용';

  @override
  String get cnNoReasonFound => '편지에서 이유를 찾지 못했습니다.';

  @override
  String get cnCardNextStep => '다음 할 일';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '의료진에게 재검토 요청을 부탁하세요. 편지에 보낼 자료가 $count개 적혀 있습니다.',
      zero: '의료진에게 재검토 요청을 부탁하세요. 편지에 특정 자료는 적혀 있지 않습니다.',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '보험사가 요청한 자료 $count개를 아래 날짜까지 보내세요.',
      zero: '보험사가 요청한 정보를 아래 날짜까지 보내세요.',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth => '현재 승인이 끝나는 날짜를 확인하고 의료진에게 갱신을 시작해 달라고 요청하세요.';

  @override
  String get cnNextFinal =>
      '최종 결정 통지입니다. CoverNote는 이 편지에 대한 1차 재검토 요청 초안을 만들지 않습니다. 편지에 적힌 선택지를 보험사나 의료진에게 문의하세요.';

  @override
  String get cnNextEob => '거부 통지가 아니라 청구서나 급여 설명서로 보입니다. 보험사 회원 서비스에 확인하세요.';

  @override
  String get cnNextUncertain => '먼저 위에서 편지 종류를 확인하세요.';

  @override
  String cnWhereToSend(String route) {
    return '제출 경로: $route';
  }

  @override
  String cnWhoToCall(String contact) {
    return '문의처: $contact';
  }

  @override
  String get cnCardDate => '확인할 날짜';

  @override
  String cnDateCalculated(String anchor, int days) {
    return '계산값: $anchor + 달력일 $days일';
  }

  @override
  String get cnReceivedDateWord => '받은 날짜';

  @override
  String get cnNoticeDateWord => '통지 날짜';

  @override
  String get cnDateEnteredByYou => '직접 입력함';

  @override
  String get cnDateFromLetter => '편지에 적힌 날짜';

  @override
  String cnReceivedOn(String date) {
    return '받은 날짜: $date';
  }

  @override
  String get cnDatePassed => '이 날짜가 지났습니다. 보험사에 지금 할 수 있는 방법을 문의하세요.';

  @override
  String cnNeedReceivedDate(int days) {
    return '편지에는 받은 날로부터 달력일 $days일이라고 적혀 있습니다. 언제 받으셨나요?';
  }

  @override
  String get cnEnterReceivedDate => '받은 날짜 입력';

  @override
  String get cnDateConflict =>
      '편지에 서로 다른 날짜가 있습니다. 어느 날짜가 맞는지 보험사에 확인한 뒤 선택하세요.';

  @override
  String cnUseThisDate(String date) {
    return '$date 사용';
  }

  @override
  String get cnDateUnclear =>
      '표현이 불분명하거나 영업일 기준이라 CoverNote가 계산하지 않습니다. 보험사에 정확한 날짜를 문의하세요.';

  @override
  String get cnNoDeadline => '편지에서 재검토 기한을 찾지 못했습니다.';

  @override
  String cnReplyBy(String date) {
    return '추가 자료 회신 기한: $date(편지 기준)';
  }

  @override
  String get cnEnterDatePlanGave => '날짜 직접 입력';

  @override
  String get cnUseLetterDate => '편지 날짜 사용';

  @override
  String get cnLeaveUnknown => '일단 모름으로 두기';

  @override
  String get cnDateUnknownChecked => '모름으로 표시함';

  @override
  String get cnTypeAsWritten => '편지에 적힌 그대로 입력하세요.';

  @override
  String get cnCheckThisValue => '값이 이상해 보입니다. 편지와 비교하세요.';

  @override
  String get cnDone => '완료';

  @override
  String get cnEdit => '수정';

  @override
  String get cnAdd => '추가';

  @override
  String get cnNoRecordsToLink =>
      '최근 30일 동안 연결할 기록이 없습니다. 누가 자료를 가지고 있는지는 표시할 수 있습니다.';

  @override
  String cnLinkTitle(String label) {
    return '연결할 항목: $label';
  }

  @override
  String get cnLinkNote => '내 기록은 요청을 보완할 뿐, 진료 기록이나 검사 결과를 대신하지 않습니다.';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '예정 $scheduled회 중 복용 $taken / 미복용 $notTaken / 미확인 $unknown';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return '필요 시 사용: $uses회, $puffs회 흡입';
  }

  @override
  String get cnNoEntries => '기록 없음';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return '증상 $days일, 야간 각성 $night일 (총 $total일 중 $entries일 기록)';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return 'PM2.5 자료 $total일 중 $days일, AQI 100 초과 $high일';
  }

  @override
  String cnReportsLine(int count) {
    return '자가 보고 $count건';
  }

  @override
  String get cnSyntheticData => '합성 데이터';

  @override
  String get cnLetterAsksFor => '편지가 요청한 자료';

  @override
  String get cnNoItemsListed => '편지에 특정 자료가 적혀 있지 않습니다. 직접 추가할 수 있습니다.';

  @override
  String get cnAddItemLabel => '추적할 항목 추가';

  @override
  String cnYourRecords(String from, String to) {
    return '내 기록 ($from – $to)';
  }

  @override
  String get cnLocalContextNote =>
      '선택 사항입니다. 실외 환경 요인이며, 집 안 측정값이나 증상의 원인은 아닙니다.';

  @override
  String get cnContinueToPacket => '제출 자료로';

  @override
  String get cnAddedByYou => '직접 추가';

  @override
  String get cnFromLetter => '편지에서';

  @override
  String cnWhoHasIt(String who) {
    return '자료 보유: $who';
  }

  @override
  String cnLinkedTo(String record) {
    return '연결됨: $record';
  }

  @override
  String get cnSeeInLetter => '편지에서 보기';

  @override
  String get cnLinkRecords => '내 기록 연결';

  @override
  String get cnOtherStatus => '다른 상태';

  @override
  String get cnInPacket => '자료에 포함';

  @override
  String get cnRemoveFromPacket => '자료에서 빼기';

  @override
  String get cnAddToPacket => '자료에 넣기';

  @override
  String get cnErrNotSavedYet => '최근 변경 내용이 아직 저장되지 않았습니다. 연결을 확인하고 다시 시도하세요.';

  @override
  String get cnPacketChangedMeanwhile => '자료를 만드는 동안 내용이 바뀌었습니다. 다시 만들어 주세요.';

  @override
  String get cnPacketFailed => '자료를 만들지 못했습니다. 다시 시도하세요.';

  @override
  String get cnBeforeSharingTitle => '공유하기 전에';

  @override
  String get cnBeforeSharingBody =>
      '이 파일에는 이름과 건강 정보가 들어 있습니다. 의료진이나 보험사에만 공유하세요. 공유한다고 제출되는 것은 아닙니다.';

  @override
  String get cnShare => '공유';

  @override
  String get cnMethodFax => '팩스';

  @override
  String get cnMethodMail => '우편';

  @override
  String get cnMethodPortal => '온라인 포털';

  @override
  String get cnMethodInPerson => '직접 방문';

  @override
  String get cnMethodCareTeam => '의료진이 보냄';

  @override
  String get cnMethodOther => '기타';

  @override
  String get cnPacketNoDraftFinal =>
      '최종 결정 편지는 의사용 요약만 만들고 1차 재검토 초안은 만들지 않습니다.';

  @override
  String get cnPacketNoDraftEob => '청구서나 급여 설명서는 의사용 요약만 만듭니다.';

  @override
  String get cnPacketNoDraftReauth => '갱신 안내는 의료진의 갱신을 돕도록 의사용 요약만 만듭니다.';

  @override
  String get cnPacketNoDraftOther => '거부 통지나 추가 자료 요청이 아니면 의사용 요약만 만듭니다.';

  @override
  String get cnPacketContains => '자료 구성';

  @override
  String get cnPartSummary => '의사용 요약(1페이지)';

  @override
  String get cnPartDraft => '재검토 요청 초안(의료진 작성용)';

  @override
  String get cnPartLetterText => '부록: 편지 원문 텍스트';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '기록 요약 $count개 추가됨',
      zero: '추가한 기록 요약 없음',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => '편지 원문을 부록으로 추가';

  @override
  String get cnPacketStale => '마지막 자료 이후 내용이 바뀌었습니다. 다시 만들어 업데이트하세요.';

  @override
  String get cnGenerating => '생성 중…';

  @override
  String get cnGeneratePacket => '제출 자료 만들기';

  @override
  String get cnSaveOrPrint => '저장·인쇄';

  @override
  String get cnISentIt => '보냈어요';

  @override
  String cnSharedOn(String date) {
    return '공유함: $date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return '직접 기록: $date에 보냄($method)';
  }

  @override
  String get cnTabDoctorSummary => '의사용 요약';

  @override
  String get cnTabReviewDraft => '재검토 요청 초안';

  @override
  String get cnSentExplain =>
      '언제 어떻게 보냈는지 기록하세요. CoverNote는 대신 제출하거나 결정을 추적하지 않습니다.';

  @override
  String get cnSave => '저장';

  @override
  String get cnCtxPm25 => 'PM2.5 (AQI)';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => '실외 습도';

  @override
  String cnObservedOn(String date) {
    return '관측일 $date';
  }

  @override
  String get cnCtxIntro =>
      '출처가 있는 대기 측정값과 직접 겪은 일을 따로 기록합니다. 기록을 설명하는 데 도움이 될 때만 케이스에 추가하세요.';

  @override
  String get cnCtxReadings => '대기 측정값';

  @override
  String get cnCtxReadingsNote =>
      '관측한 날짜의 지역 측정값입니다. 우리 집의 차량 배기가스 양을 측정한 것이 아닙니다.';

  @override
  String get cnCtxAddReading => '측정값 추가';

  @override
  String get cnCtxReports => '직접 겪은 일';

  @override
  String get cnCtxReportsNote => '직접 보고한 내용이며 측정값이 아닙니다.';

  @override
  String get cnCtxAddReport => '겪은 일 추가';

  @override
  String get cnReportExhaust => '근처 배기가스 냄새가 심함';

  @override
  String get cnReportWater => '집에 물이 샘';

  @override
  String get cnReportDamp => '실내가 눅눅하거나 곰팡이 냄새가 남';

  @override
  String cnOnDate(String date) {
    return '날짜: $date';
  }

  @override
  String get cnNoteOptional => '메모(선택)';

  @override
  String get cnCtxWhat => '측정 항목';

  @override
  String get cnCtxHumidityNote => '실외 습도는 날씨 자료이며 실내 습기나 곰팡이를 나타내지 않습니다.';

  @override
  String get cnCtxValue => '값';

  @override
  String get cnCtxValueInvalid => '올바른 숫자를 입력하세요.';

  @override
  String get cnCtxSource => '출처';

  @override
  String get cnCtxSourceHelp => '숫자의 출처(예: AirNow, 지역 측정소)';

  @override
  String get cnCtxSourceRequired => '출처를 입력하세요.';

  @override
  String get cnCtxPlace => '장소(선택)';

  @override
  String get cnRecordsSignInBody => '로그인하면 복약·증상·환경 요인 기록을 보관할 수 있습니다.';

  @override
  String get cnRecordsYourRecords => '내 기록';

  @override
  String get cnRecMedicationSub => '복용하는 약과 용량';

  @override
  String get cnRecDailyLog => '일일 기록';

  @override
  String get cnRecDailyLogSub => '증상과 흡입기 사용';

  @override
  String get cnRecLocalContextSub => '대기 측정값과 직접 겪은 일';

  @override
  String get cnHelp => '도움';

  @override
  String get cnUrgentHelp => '긴급 도움';

  @override
  String get cnUrgentHelpSub => '호흡 응급 상황 대처와 911 전화';

  @override
  String cnLast30Days(String from, String to) {
    return '최근 30일 ($from – $to)';
  }

  @override
  String get cnNoSchedule => '정기 복용 일정 없음';

  @override
  String get cnRecordsUnknownNote => '기록이 없는 날은 미확인으로 남고 미복용으로 세지 않습니다.';

  @override
  String get cnDeleteAccountTitle => '계정을 삭제할까요?';

  @override
  String get cnDeleteAccountBody =>
      '계정, 케이스, 올린 편지, 제출 자료, 기록이 영구 삭제되며 되돌릴 수 없습니다.';

  @override
  String get cnTypeDelete => '확인하려면 DELETE 입력';

  @override
  String get cnDeleteAccount => '계정 삭제';

  @override
  String get cnAccountDeleted => '계정을 삭제했습니다.';

  @override
  String get cnDeleteAccountFailed => '계정을 삭제하지 못했습니다. 나중에 다시 시도하세요.';

  @override
  String get cnAccountSignedOut => '로그인하지 않았습니다.';

  @override
  String get cnLanguage => '언어';

  @override
  String get cnServiceStatus => '편지 읽기 서비스';

  @override
  String get cnServiceReady => '사용 가능';

  @override
  String get cnServiceUnavailableShort => '지금은 사용할 수 없음';

  @override
  String get cnChecking => '확인 중…';

  @override
  String get cnServiceUnknown => '확인 안 함';

  @override
  String get cnCheck => '확인';

  @override
  String get cnAbout => '정보';

  @override
  String get cnAboutBody =>
      'CoverNote는 약 관련 보험 편지를 읽고 의료진에게 전달할 자료를 준비하도록 돕습니다. 보험사에 제출하지 않으며, 보장 여부를 판단하지 않고, 의료 조언이 아닙니다.';

  @override
  String get cnDangerZone => '계정 삭제';

  @override
  String get cnErrServiceUnavailable => '지금은 편지 읽기 기능을 사용할 수 없습니다.';

  @override
  String get cnErrBusy => '서비스가 바쁩니다. 잠시 후 다시 시도하세요.';

  @override
  String get cnErrSlow => '읽기에 시간이 너무 오래 걸렸습니다. 다시 시도하세요.';

  @override
  String get cnErrUnreadable => '페이지를 읽지 못했습니다. 더 밝은 곳에서 다시 찍으세요.';

  @override
  String get cnErrTooManyPages => '페이지가 너무 많습니다. 10페이지까지 올리세요.';

  @override
  String get cnErrTooLarge => '파일이 너무 큽니다. 페이지 수나 크기를 줄이세요.';

  @override
  String get cnErrStale => '다른 기기에서 케이스가 바뀌었습니다. 최신 내용을 표시합니다.';

  @override
  String get cnErrCaseGone => '이 케이스는 더 이상 없습니다.';

  @override
  String get cnErrAttempts => '여러 번 읽기에 실패했습니다. 페이지를 교체하거나 나중에 다시 시도하세요.';

  @override
  String get cnErrDemoUpload => '데모에서는 파일을 읽을 수 없습니다. 로그인해 내 편지를 촬영하세요.';

  @override
  String cnErrGeneric(String code) {
    return '문제가 발생했습니다($code). 다시 시도하세요.';
  }

  @override
  String get cnLanguageChoose => '언어를 선택하세요';

  @override
  String get cnLanguageNote =>
      '일부 문구는 소프트웨어로 번역되어 틀릴 수 있습니다. 약 이름과 용량은 적힌 그대로 둡니다. 그 외 편지 내용은 번역해서 보여 줍니다.';

  @override
  String get cnLanguageButtonTooltip => '언어 변경';

  @override
  String get cnPacketEnglishNote => '의료진이 읽을 수 있도록 제출 자료는 영어로 작성됩니다.';

  @override
  String get cnReasonMissingInformation => '보험사는 필요한 정보를 모두 받지 못했다고 합니다.';

  @override
  String get cnReasonStepTherapy => '보험사는 다른 약을 먼저 써 보기를 요구합니다.';

  @override
  String get cnReasonMedicalNecessity =>
      '보험사는 이 약이 의학적으로 필요하다고 확인할 수 없었다고 합니다.';

  @override
  String get cnReasonFormulary => '보험사는 이 약이 보장 약 목록에 없다고 합니다.';

  @override
  String get cnReasonQuantityLimit => '보험사는 요청한 양이 보장 범위를 넘는다고 합니다.';

  @override
  String get cnReasonEligibility => '보험사는 보장 규정상 이 약이 보장되지 않는다고 합니다.';

  @override
  String get cnReasonOther => '편지에 다른 이유가 적혀 있습니다. 해당 부분을 눌러 확인하세요.';

  @override
  String get cnReqHintMedHistory => '지금까지 쓴 약과 현재 쓰는 약';

  @override
  String get cnReqHintVisitNotes => '진료 때 의사가 쓴 기록';

  @override
  String get cnReqHintTestResults => '검사 결과';

  @override
  String get cnReqHintDoctorStatement => '의사 소견서';

  @override
  String get cnTabSettings => '설정';

  @override
  String get cnCasesList => '케이스 목록';

  @override
  String get cnGoHome => '홈으로';

  @override
  String get cnAnalyzingTitle => '보험 편지 · 분석 중';

  @override
  String cnCaseNumber(String n) {
    return '케이스 #$n';
  }

  @override
  String cnAddedAt(String when) {
    return '$when 추가';
  }

  @override
  String get cnAliasHint => '부르는 이름 (선택)';

  @override
  String get cnShareDocuments => '자료 보내기';

  @override
  String get cnRecordDelivery => '보낸 내역 기록';

  @override
  String get cnShareAsk => '이 자료를 보내셨나요?';

  @override
  String get cnDeliveryRecipient => '받는 곳';

  @override
  String get cnRecipientClinic => '병원·의료진';

  @override
  String get cnRecipientInsurer => '보험사';

  @override
  String get cnRecipientSelf => '본인 보관';

  @override
  String get cnRecipientOther => '기타';

  @override
  String get cnDeliveryMethod => '방법';

  @override
  String get cnMethodEmail => '이메일';

  @override
  String get cnMethodMessage => '문자·메신저';

  @override
  String get cnMethodUnknown => '기억 안 남';

  @override
  String get cnDeliveryUserReport => '직접 남기신 내용입니다. 상대가 받았는지는 앱이 확인하지 않습니다.';

  @override
  String get cnShareCancelled => '공유가 취소되었습니다. 보낸 것으로 기록하지 않았습니다.';

  @override
  String get cnRecordsLoading => '기록을 불러오는 중…';

  @override
  String get cnRecordsEmpty => '이 기간에 기록이 없습니다';

  @override
  String get cnRecordsError => '기록을 불러오지 못했습니다';

  @override
  String get cnRecordsPermission => '이 기록에 접근할 수 없습니다';

  @override
  String get cnRecordsPending => '기기에 저장됨 · 동기화 대기';

  @override
  String get cnRecordsFiltered => '필터 때문에 일부 기록이 숨겨져 있습니다';

  @override
  String cnRecordsOutside(int n) {
    return '이 기간 밖 기록 $n건';
  }

  @override
  String get cnWidenRange => '기간을 더 넓히기';

  @override
  String cnLinkedSummary(int days, int med, int sym) {
    return '$days일 · 약 사용 $med건 · 증상 $sym건';
  }

  @override
  String get cnOneDayPacket => '이 자료는 하루치입니다.';

  @override
  String get cnMyMedications => '내 약 관리';

  @override
  String get cnScanLabel => '약 라벨 찍어 등록';

  @override
  String get cnMedManageHint =>
      '쓰는 약은 먼저 등록하고, 처방이 바뀌면 수정하세요. 매일 사용 여부는 기록에서 남깁니다.';

  @override
  String get cnLabelNeedLabel => '약국 라벨이나 상자 글자를 찍어 주세요. 알약 모양만으로는 식별하지 않습니다.';

  @override
  String get cnLabelUnclear => '이 값은 흐려서 확인이 필요합니다.';

  @override
  String get cnConsentLabel => '약 라벨을 AI가 읽도록 허용';

  @override
  String get cnManualMed => '직접 입력';

  @override
  String get cnAirWeather => '내 주변 환경 요인';

  @override
  String get cnAirAutoNote =>
      '지금 위치의 대기질, 교통 관련 대기, 꽃가루, 홍수 알림, 실외 습도를 보여 줍니다. 휴대폰이 공기를 측정하지는 않습니다. 실외 습도는 실내 곰팡이가 아닙니다.';

  @override
  String get cnHomeRecords => '관련 복약 기록';

  @override
  String get cnEnvTrap => '교통 관련 대기';

  @override
  String get cnItemMemo => '메모';

  @override
  String get cnSaveNote => '메모 저장';

  @override
  String get cnLocationNeed => '지금 있는 곳의 환경 요인을 보려면 위치 권한을 허용해 주세요.';

  @override
  String get cnLocationOff => '위치 서비스가 꺼져 있습니다. 켠 다음 다시 시도해 주세요.';

  @override
  String get cnLocationBlocked => '위치 권한이 차단되어 있습니다. 설정에서 허용해 주세요.';

  @override
  String get cnOpenSettings => '설정 열기';

  @override
  String get cnAirNone => '환경정보 없음';

  @override
  String get cnAirRetry => '환경정보 다시 시도';

  @override
  String get cnSetRegion => '지역 설정 (우편번호 또는 도시)';

  @override
  String get cnConfiguredArea => '설정한 지역';

  @override
  String get cnRecordPlace => '기록 장소';

  @override
  String get cnClosestObservation => '기록 시각과 가장 가까운 관측';

  @override
  String get cnEnvUnavailable => '그 시각에 맞는 관측이 없습니다';

  @override
  String cnLogMedication(String name) {
    return '$name 사용했어요';
  }

  @override
  String get cnAsNeededUse => '필요할 때 사용한 약';

  @override
  String get cnAsNeededInhaler => '필요할 때 사용한 흡입기';

  @override
  String get cnScheduledUse => '정기 사용';

  @override
  String get cnExtraUse => '추가 사용';

  @override
  String get cnUndoUse => '되돌리기';

  @override
  String get cnLoggedLocal => '기기에 저장됨';

  @override
  String get cnLoggedPending => '동기화 대기';

  @override
  String get cnLoggedSynced => '동기화됨';

  @override
  String cnDaysLogged(int n) {
    return '이번 주 $n일 기록함';
  }

  @override
  String get cnManageMedsLink => '내 약 관리';

  @override
  String get cnViewAirWeather => '내 주변 환경 요인 보기';

  @override
  String get cnConsentAi => '문서의 AI 분석에 동의';

  @override
  String get cnConsentAiBody => '편지를 읽는 서비스로 이미지가 전송됩니다. 나중에 설정에서 끌 수 있습니다.';

  @override
  String get cnConsentAndAnalyze => '동의하고 분석하기';

  @override
  String get cnConsentLater => '지금은 안 함';

  @override
  String get cnConsentViewLocal => '원본만 보기';

  @override
  String get cnConsentDetails => '데이터 이용 자세히';

  @override
  String get cnConsentLabelPurpose => '약 라벨 읽기';

  @override
  String get cnConsentLetterPurpose => '보험 편지 읽기';

  @override
  String get cnConsentTranslatePurpose => '편지 번역';

  @override
  String get cnToday => '오늘';

  @override
  String get cnLast7 => '최근 7일';

  @override
  String get cnLast30 => '최근 30일';

  @override
  String get cnCustomRange => '날짜 직접 선택';

  @override
  String cnRangeSummary(String from, String to, int days, int count) {
    return '$from–$to · $days일 · $count건';
  }

  @override
  String get cnNoRecordThatDay => '이 날 기록 없음';

  @override
  String get cnNotLogged => '기록하지 않음';

  @override
  String get cnNotTaken => '안 썼다고 표시함';

  @override
  String get cnOriginalFile => '원본 파일';

  @override
  String get cnFullTranslation => '전체 번역';

  @override
  String get cnRecognizedText => '인식된 텍스트';

  @override
  String get cnSameLanguage => '원문과 같은 언어입니다';

  @override
  String get cnTranslationPartial => '아직 번역되지 않은 페이지가 있습니다';

  @override
  String get cnTranslationFailed => '이 페이지를 번역하지 못했습니다';

  @override
  String get cnOriginalMissing => '원본 파일을 찾을 수 없습니다. 다시 올릴 수 있습니다.';

  @override
  String get cnTranslateRetry => '이어서 번역';

  @override
  String get cnKeyDetails => '핵심 내용';

  @override
  String get cnWhatAbout => '무슨 내용인가요?';

  @override
  String get cnWhatToDo => '지금 할 일';

  @override
  String get cnByWhen => '언제까지인가요?';

  @override
  String get cnPreparePacket => '자료 준비하기';

  @override
  String get cnCorrectReading => '잘못 읽힌 내용 알리기';

  @override
  String get cnCorrectReadingNote => '원본 편지는 바뀌지 않습니다. 자동 인식 결과만 바로잡습니다.';

  @override
  String get cnReviewImportant => '자료를 만들기 전에 중요한 값만 확인하세요';

  @override
  String get cnPacketReadyTitle => '자료가 준비됐어요';

  @override
  String get cnNextSendClinic => '의료진에게 자료를 보내 검토를 요청하세요';

  @override
  String get cnNextWaitReply => '답변을 받으면 결과를 남겨 주세요';

  @override
  String get cnExistingSentNewReady => '기존 자료는 전달됨 · 새 자료를 만들 수 있습니다';

  @override
  String get cnWhyRecords =>
      '약 사용과 증상 기록은 의료진이 치료 경과를 확인하는 데 참고할 수 있습니다. 기록이 없어도 편지 내용으로 자료를 만들 수 있어요.';

  @override
  String get cnLetterAskedRecords => '편지에서 최근 치료 기록을 요청했어요';

  @override
  String get cnOptionalReference => '선택 참고자료';

  @override
  String get cnAsthmaContext => '천식 치료 기록 — 정기 약 사용, 필요 시 사용, 호흡 증상을 남깁니다.';

  @override
  String get cnGeneralContext => '치료 기록 — 약 사용과 증상·메모를 남깁니다.';

  @override
  String get cnTreatmentQuestion => '어떤 치료와 관련된 편지인가요?';

  @override
  String get cnTreatmentAsthma => '천식';

  @override
  String get cnTreatmentOther => '다른 치료';

  @override
  String get cnTreatmentUnknown => '아직 모르겠어요';

  @override
  String get cnStatusWaitingClinic => '병원에 전달함 · 검토 기다리는 중';

  @override
  String get cnStatusWaitingInsurer => '보험사에 제출했다고 기록함 · 답변 대기';

  @override
  String get cnFollowUpNeeded => '후속 조치 필요';

  @override
  String get cnOutcomeRecorded => '결과를 기록함';

  @override
  String get cnActiveCases => '진행 중';

  @override
  String get cnCompletedArchived => '완료·보관';

  @override
  String get cnCompleteCase => '케이스 완료';

  @override
  String get cnArchiveCase => '보관';

  @override
  String get cnReopenCase => '다시 진행';

  @override
  String get cnOutcomeApproved => '승인';

  @override
  String get cnOutcomeDenied => '거부';

  @override
  String get cnOutcomeStopped => '더 진행하지 않음';

  @override
  String get cnOutcomeOther => '기타·미기록';

  @override
  String get cnSentIsNotComplete => '보냈다고 해서 완료가 아닙니다.';

  @override
  String get cnArchivedCase => '보관됨';

  @override
  String get cnStepKeyDetails => '핵심 내용';

  @override
  String get cnStepAddRecords => '기록 연결';

  @override
  String get cnStepReviewPacket => '제출 자료';

  @override
  String get cnDataConsent => '데이터 처리';

  @override
  String get cnZipOrCity => '우편번호 또는 도시';

  @override
  String get cnSaveArea => '지역 저장';

  @override
  String get cnWeekCalendar => '이번 주';

  @override
  String get cnMonthCalendar => '이번 달';

  @override
  String get cnUsedShort => '사용했어요';

  @override
  String get cnCalendarLegend => '점이 있으면 그날에 기록을 남긴 것입니다. 빈 날은 약을 안 쓴 날이 아닙니다.';
}
