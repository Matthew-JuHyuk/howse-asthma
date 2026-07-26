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
      'Supabase가 아직 설정되지 않았습니다.\n.env 파일에 SUPABASE_URL과 SUPABASE_ANON_KEY를 입력하세요.';

  @override
  String get homeGreeting => '안녕하세요';

  @override
  String get homeAirQualityTitle => '내 주변 대기질';

  @override
  String get homeWeatherTitle => '내 주변 날씨';

  @override
  String get asthmaRiskLow => '천식 위험도 낮음';

  @override
  String get asthmaRiskModerate => '천식 위험도 보통';

  @override
  String get asthmaRiskHigh => '천식 위험도 높음 - 주의가 필요합니다';

  @override
  String get medicationLogTitle => '약물 사용 기록';

  @override
  String get medicationLogAddButton => '흡입기/약물 사용 기록하기';

  @override
  String get medicationNameLabel => '약물 이름';

  @override
  String get medicationDoseLabel => '용량';

  @override
  String get medicationTimeLabel => '복용 시간';

  @override
  String get medicationEffectivenessLabel => '효과가 있었나요?';

  @override
  String get reportTitle => '보험 제출용 리포트';

  @override
  String get reportGenerateButton => '의사/보험사 제출용 리포트 생성';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsLanguageLabel => '언어';

  @override
  String get settingsLocationLabel => '위치';

  @override
  String get notificationAttackWarningTitle => '천식 발작 위험 알림';

  @override
  String get mockContinue => 'Continue';

  @override
  String get mockSignUpTitle => 'Create account';

  @override
  String get mockChooseRole => 'Choose your role';

  @override
  String get mockRolePatient => 'Patient';

  @override
  String get mockRolePatientHint => 'Track air risk and inhaler use';

  @override
  String get mockRoleProvider => 'Provider';

  @override
  String get mockRoleProviderHint => 'Not in this design preview';

  @override
  String get mockProviderNotInPreview =>
      'Provider screens are not in this patient design preview.';

  @override
  String get mockBiometricTitle => 'Unlock';

  @override
  String get mockBiometricHint =>
      'Use biometrics to unlock Howse Asthma (design preview).';

  @override
  String get mockUnlock => 'Unlock';

  @override
  String get mockUsePassword => 'Use password instead';

  @override
  String get mockOnboardingTitle => 'Patient setup';

  @override
  String get mockHomeLocation => 'Home';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => 'Emergency contact';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => 'Provider invite code';

  @override
  String get mockFinishOnboarding => 'Go to home';

  @override
  String get mockAllScreens => 'All screens';

  @override
  String get mockAllScreensHint => 'Open any Screen ID for design review';

  @override
  String get mockStateCalm => 'CALM';

  @override
  String get mockStateWarning => 'WARNING';

  @override
  String get mockHomeCalmMessage =>
      'Air looks manageable nearby. Log inhaler use anytime.';

  @override
  String get mockHomeWarnMessage =>
      'Elevated risk nearby. Limit outdoor exposure and keep your inhaler ready.';

  @override
  String get mockRiskScore => 'Risk score';

  @override
  String get mockDummyLocation => 'Near Newark, NJ';

  @override
  String get mockEnvDetail => 'Environment detail';

  @override
  String get mockForecast => 'Forecast';

  @override
  String get mockForecastHint => 'Next days air & pollen outlook';

  @override
  String get mockAlertPreview => 'Alert landing';

  @override
  String get mockAlertPreviewHint => 'Preview risk alert screen';

  @override
  String get mockShowWarningHome => 'Preview WARNING home';

  @override
  String get mockBackToCalmHome => 'Back';

  @override
  String get mockPanicCta => 'Panic mode';

  @override
  String get mockTrapAxis => 'TRAP / soot';

  @override
  String get mockFloodAxis => 'Flash flood';

  @override
  String get mockPollenAxis => 'Pollen';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · Pollen outlook';

  @override
  String get mockActSurvey => 'ACT survey';

  @override
  String get mockActHint => '5 pictogram questions (4 weeks)';

  @override
  String get mockPdcCheck => 'Daily PDC check';

  @override
  String get mockPdcHint => 'One-tap adherence';

  @override
  String get mockInhalerEvent => 'Inhaler logged';

  @override
  String get mockActIntro =>
      'Answer based on the last 4 weeks. Design preview — answers are not saved.';

  @override
  String get mockQuestion => 'Question';

  @override
  String get mockSubmit => 'Submit';

  @override
  String get mockPdcPrompt => 'Did you take your controller medicine today?';

  @override
  String get mockTakenYes => 'Yes, I took it';

  @override
  String get mockTakenNo => 'Not today';

  @override
  String get mockEvidenceSummary => 'Your evidence summary';

  @override
  String get mockEvidenceBody =>
      'Dummy summary for PA/LMN support. Design preview only.';

  @override
  String get mockInhalerEvents30d => 'Inhaler events (30d)';

  @override
  String get mockActScore => 'Latest ACT';

  @override
  String get mockPdcRate => 'PDC (30d)';

  @override
  String get mockLocationsTitle => 'Saved places';

  @override
  String get mockLocationsHint => 'Home and work monitoring';

  @override
  String get mockWorkLocation => 'Work';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => 'Add place';

  @override
  String get mockRewardTitle => 'Rewards';

  @override
  String get mockDraftBanner => 'DRAFT — points & vouchers are preview only';

  @override
  String get mockPointsBalance => 'Points balance';

  @override
  String get mockVoucherTitle => 'Food bank voucher';

  @override
  String get mockVoucherHint => 'Exchange points (waitlist)';

  @override
  String get mockDonateTitle => 'Donate';

  @override
  String get mockDonateHint => 'Third-party giving only';

  @override
  String get mockRewardHistory => 'History';

  @override
  String get mockRewardHistoryHint => 'Points and donations';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank (demo)';

  @override
  String get mockVoucherCost => '50 points · \$10 value (draft)';

  @override
  String get mockJoinWaitlist => 'Join waitlist';

  @override
  String get mockDonateTransparency =>
      'Donations go through a verified third-party nonprofit platform. Howse Asthma never stores card details.';

  @override
  String get mockDonateCta => 'Open donate (external)';

  @override
  String get mockExternalOnly =>
      'External donation provider is not wired in design preview.';

  @override
  String get mockSignOutPreview => 'Sign out (preview)';

  @override
  String get mockOpenAuthFlow => 'Open auth flow';

  @override
  String get mockAlertBody =>
      'Risk rose near your location. Review environment details.';

  @override
  String get mockDismiss => 'Dismiss';

  @override
  String get mockPanicTitle => 'Need help now?';

  @override
  String get mockPanicStep1Body =>
      'Step 1 — Stay with your inhaler. Continue for emergency contacts.';

  @override
  String get mockPanicStep2Title => 'Call for help';

  @override
  String get mockPanicStep2Body =>
      'Design preview: buttons do not place a real call. On device builds, Step 2 uses tel: links.';

  @override
  String get mockCall911 => 'Call 911';

  @override
  String get mockCallGuardian => 'Call emergency contact';

  @override
  String get mockFeelingBetter => 'I am feeling better';

  @override
  String get mockTabHome => 'Home';

  @override
  String get mockTabLog => 'Log';

  @override
  String get mockTabReport => 'Report';

  @override
  String get mockTabReward => 'Reward';

  @override
  String get mockTabSettings => 'Settings';

  @override
  String get navHome => '홈';

  @override
  String get signUpTitle => '계정 만들기';

  @override
  String get authChooseRole => '역할을 선택하세요';

  @override
  String get authRolePatient => '환자';

  @override
  String get authRolePatientHint => '대기 위험과 흡입기 사용을 기록합니다';

  @override
  String get authRoleProvider => '의료진';

  @override
  String get authRoleProviderHint => '환자를 연결하고 임상 근거를 확인합니다';

  @override
  String get authFullNameLabel => '이름';

  @override
  String get authNpiLabel => 'NPI 번호';

  @override
  String get authNpiHelper => '10자리 의료인 식별번호';

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
  String get authCompleteProfileBody => '올바른 홈 화면을 위해 역할을 알려주세요.';

  @override
  String get authSaveProfile => '프로필 저장';

  @override
  String get authSignOut => '로그아웃';

  @override
  String get authRetry => '다시 시도';

  @override
  String get authWorking => '처리 중…';

  @override
  String get authValidationInvalidEmail => '올바른 이메일을 입력하세요';

  @override
  String get authValidationPasswordMin => '비밀번호는 8자 이상이어야 합니다';

  @override
  String get authValidationNameRequired => '이름을 입력하세요';

  @override
  String get authValidationInvalidNpi => '올바른 10자리 NPI를 입력하세요';

  @override
  String get authErrorGeneric => '문제가 발생했습니다. 다시 시도하세요.';

  @override
  String get authErrorInvalidCredentials => '이메일 또는 비밀번호가 올바르지 않습니다';

  @override
  String get authErrorEmailTaken => '이미 등록된 이메일입니다';

  @override
  String get authErrorEmailNotConfirmed => '로그인 전에 이메일을 확인하세요';

  @override
  String get authErrorWeakPassword => '비밀번호가 너무 약합니다';

  @override
  String get authErrorRateLimited => '시도가 너무 많습니다. 나중에 다시 시도하세요.';

  @override
  String get authBiometricTitle => 'Howse Asthma 잠금 해제';

  @override
  String get authBiometricHint => '지문 또는 얼굴로 계속하세요.';

  @override
  String get authBiometricReason => 'Howse Asthma 잠금 해제';

  @override
  String get authBiometricUnlock => '잠금 해제';

  @override
  String get authBiometricFailed => '생체 인증에 실패했습니다. 다시 시도하세요.';

  @override
  String get authBiometricToggle => '생체 인증 잠금 해제';

  @override
  String get authBiometricToggleHint => '앱을 열 때 생체 인증 요구';

  @override
  String get authBiometricUnavailable => '이 기기에서는 생체 인증을 사용할 수 없습니다';

  @override
  String get authOnboardingTitle => '환자 설정';

  @override
  String get authOnboardingBody =>
      '의료진이 공유한 6자리 초대 코드가 있으면 지금 입력하세요. 나중에 설정에서도 할 수 있습니다.';

  @override
  String get authOnboardingSkip => '나중에 하기';

  @override
  String get authInviteCodeLabel => '의료진 초대 코드';

  @override
  String get authInviteCodeHelper => '6자리, 24시간 후 만료';

  @override
  String get authInviteRedeem => '등록';

  @override
  String get authInviteRedeemAndContinue => '등록하고 계속';

  @override
  String get authInviteInvalidFormat => '초대 코드는 6자리여야 합니다';

  @override
  String get authInviteRedeemedPending => '초대가 등록되었습니다. 의료진 확인을 기다리는 중입니다.';

  @override
  String get authInviteRedeemFailed => '초대 코드를 등록할 수 없습니다';

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
    return '$email으로 로그인됨';
  }

  @override
  String get providerHomePlaceholder => '임상 대시보드는 이후 버전에서 제공됩니다. 먼저 환자를 연결하세요.';

  @override
  String get providerLinkPatientsCta => '환자 연결';

  @override
  String get providerLinkTitle => '환자 연결';

  @override
  String get providerLinkIntro =>
      '6자리 코드를 발급하세요(24시간 유효). 환자가 입력한 뒤 양쪽이 확인합니다.';

  @override
  String get providerIssueInviteCta => '초대 코드 발급';

  @override
  String get providerInviteTtlHint => '24시간 유효';

  @override
  String get providerInviteCopied => '초대 코드가 복사되었습니다';

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
  String get providerNoInvites => '아직 초대 코드가 없습니다';

  @override
  String get providerInviteConsumed => '사용됨';

  @override
  String get providerInviteActive => '유효';

  @override
  String get splashTagline => 'Smarter asthma prevention for every family.';

  @override
  String get splashGetStarted => 'Get Started';

  @override
  String get splashAlreadyHaveAccount => 'Already have an account?';

  @override
  String get splashSignIn => 'Sign in';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authNoAccount => 'No account?';

  @override
  String get authUseBiometricHint => 'Use Face ID or fingerprint to unlock';

  @override
  String get authTouchSensorHint => 'Touch sensor or look at camera';

  @override
  String get navLog => 'Log';

  @override
  String get navReport => 'Report';

  @override
  String get navRewards => 'Rewards';

  @override
  String get mockChooseLanguage => 'Choose Language';

  @override
  String get mockYourLocation => 'Your Location';

  @override
  String get mockUseCurrentLocation => 'Use Current Location';

  @override
  String get mockLocationTrapOnly =>
      'Location is used for TRAP air quality data only';

  @override
  String get mockLabelYourPlace => 'Label Your Place';

  @override
  String get mockSchool => 'School';

  @override
  String get mockWork => 'Work';

  @override
  String get mockOther => 'Other';

  @override
  String get mockEmergencyOnePerson => 'One person to call in an emergency';

  @override
  String get mockContactName => 'Contact Name';

  @override
  String get mockPhoneNumber => 'Phone Number';

  @override
  String get mockProviderPairing => 'Provider Pairing';

  @override
  String get mockPairingOptional =>
      'Optional — you can add this later in Settings';

  @override
  String get mockNext => 'Next';

  @override
  String get mockProfessionalProfile => 'Professional Profile';

  @override
  String get mockStep2Of4 => 'Step 2 of 4';

  @override
  String get mockTellPractice => 'Tell us about your medical practice';

  @override
  String get mockSpecialtyLabel => 'Specialty';

  @override
  String get mockClinicLabel => 'Practice / Clinic Name';

  @override
  String get mockNpiFormatOnly =>
      'Format check only. NPI verification occurs after submission.';

  @override
  String get mockCredentialsSecure =>
      'Your credentials are encrypted and stored securely. We never share provider data without consent.';

  @override
  String get oneTapFab => '1-Tap';

  @override
  String get oneTapLoggedSnack => 'Inhaler use logged (stub)';
}
