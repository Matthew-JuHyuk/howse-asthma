// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Howse Asthma';

  @override
  String get loginTitle => 'ログイン';

  @override
  String get loginEmailLabel => 'メールアドレス';

  @override
  String get loginPasswordLabel => 'パスワード';

  @override
  String get loginButton => 'ログイン';

  @override
  String get signUpButton => 'アカウント作成';

  @override
  String get supabaseNotConfigured =>
      'Supabase がまだ設定されていません。\n.env ファイルに SUPABASE_URL と SUPABASE_ANON_KEY を設定してください。';

  @override
  String get homeGreeting => 'こんにちは';

  @override
  String get homeAirQualityTitle => '現在地の大気質';

  @override
  String get homeWeatherTitle => '現在地の天気';

  @override
  String get asthmaRiskLow => '喘息リスク：低い';

  @override
  String get asthmaRiskModerate => '喘息リスク：中程度';

  @override
  String get asthmaRiskHigh => '喘息リスク：高い - 注意してください';

  @override
  String get medicationLogTitle => '服薬記録';

  @override
  String get medicationLogAddButton => '吸入器・薬の使用を記録する';

  @override
  String get medicationNameLabel => '薬剤名';

  @override
  String get medicationDoseLabel => '用量';

  @override
  String get medicationTimeLabel => '服用時間';

  @override
  String get medicationEffectivenessLabel => '効果はありましたか？';

  @override
  String get reportTitle => '保険提出用レポート';

  @override
  String get reportGenerateButton => '医師・保険会社向けレポートを作成';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguageLabel => '言語';

  @override
  String get settingsLocationLabel => '位置情報';

  @override
  String get notificationAttackWarningTitle => '喘息発作リスクの通知';

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
  String get navHome => 'ホーム';

  @override
  String get signUpTitle => 'アカウント作成';

  @override
  String get authChooseRole => '役割を選択';

  @override
  String get authRolePatient => '患者';

  @override
  String get authRolePatientHint => '大気リスクと吸入器の使用を記録します';

  @override
  String get authRoleProvider => '医療者';

  @override
  String get authRoleProviderHint => '患者を連携し臨床エビデンスを確認します';

  @override
  String get authFullNameLabel => '氏名';

  @override
  String get authNpiLabel => 'NPI番号';

  @override
  String get authNpiHelper => '10桁の国家プロバイダ識別子';

  @override
  String get authOrContinueWith => 'または次で続行';

  @override
  String get authContinueGoogle => 'Googleで続行';

  @override
  String get authContinueApple => 'Appleで続行';

  @override
  String get authCheckEmailTitle => 'メールを確認';

  @override
  String authCheckEmailBody(String email) {
    return '$email に確認リンクを送信しました。開いてからサインインしてください。';
  }

  @override
  String get authBackToSignIn => 'サインインに戻る';

  @override
  String get authCompleteProfileTitle => 'プロフィールを完成';

  @override
  String get authCompleteProfileBody => '正しいホーム画面を開くため、役割を教えてください。';

  @override
  String get authSaveProfile => 'プロフィールを保存';

  @override
  String get authSignOut => 'サインアウト';

  @override
  String get authRetry => '再試行';

  @override
  String get authWorking => '処理中…';

  @override
  String get authValidationInvalidEmail => '有効なメールを入力してください';

  @override
  String get authValidationPasswordMin => 'パスワードは8文字以上必要です';

  @override
  String get authValidationNameRequired => '氏名は必須です';

  @override
  String get authValidationInvalidNpi => '有効な10桁のNPIを入力してください';

  @override
  String get authErrorGeneric => '問題が発生しました。もう一度お試しください。';

  @override
  String get authErrorInvalidCredentials => 'メールまたはパスワードが正しくありません';

  @override
  String get authErrorEmailTaken => 'このメールのアカウントは既に存在します';

  @override
  String get authErrorEmailNotConfirmed => 'サインイン前にメールを確認してください';

  @override
  String get authErrorWeakPassword => 'パスワードが弱すぎます';

  @override
  String get authErrorRateLimited => '試行が多すぎます。後でもう一度お試しください。';

  @override
  String get authBiometricTitle => 'Howse Asthma のロック解除';

  @override
  String get authBiometricHint => '指紋または顔で続行します。';

  @override
  String get authBiometricReason => 'Howse Asthma のロック解除';

  @override
  String get authBiometricUnlock => 'ロック解除';

  @override
  String get authBiometricFailed => '生体認証に失敗しました。再試行してください。';

  @override
  String get authBiometricToggle => '生体認証ロック解除';

  @override
  String get authBiometricToggleHint => 'アプリ起動時に生体認証を要求';

  @override
  String get authBiometricUnavailable => 'この端末では生体認証を利用できません';

  @override
  String get authOnboardingTitle => '患者セットアップ';

  @override
  String get authOnboardingBody => '臨床医から共有された6桁コードがあれば今入力できます。後で設定からも可能です。';

  @override
  String get authOnboardingSkip => '今はスキップ';

  @override
  String get authInviteCodeLabel => '招待コード';

  @override
  String get authInviteCodeHelper => '6桁、24時間で期限切れ';

  @override
  String get authInviteRedeem => '登録';

  @override
  String get authInviteRedeemAndContinue => '登録して続行';

  @override
  String get authInviteInvalidFormat => '招待コードは6桁です';

  @override
  String get authInviteRedeemedPending => '招待を登録しました。医療者の確認待ちです。';

  @override
  String get authInviteRedeemFailed => '招待コードを登録できませんでした';

  @override
  String get authInviteIssueFailed => '招待コードを発行できませんでした';

  @override
  String get authConfirmLink => '確認';

  @override
  String get authRejectLink => '拒否';

  @override
  String get authLinkStatusPending => '確認待ち';

  @override
  String get settingsSystemDefault => 'システム既定';

  @override
  String get settingsLocationTodo => '位置情報の許可は今後の更新で要求します';

  @override
  String get providerHomeTab => 'ホーム';

  @override
  String get providerLinkTab => '連携';

  @override
  String get providerHomeTitle => '医療者ホーム';

  @override
  String providerHomeWelcome(String email) {
    return '$email でサインイン中';
  }

  @override
  String get providerHomePlaceholder => '臨床ダッシュボードは今後追加されます。まず患者を連携してください。';

  @override
  String get providerLinkPatientsCta => '患者を連携';

  @override
  String get providerLinkTitle => '患者連携';

  @override
  String get providerLinkIntro => '6桁コードを発行（24時間有効）。患者が入力し、双方が確認します。';

  @override
  String get providerIssueInviteCta => '招待コードを発行';

  @override
  String get providerInviteTtlHint => '24時間有効';

  @override
  String get providerInviteCopied => '招待コードをコピーしました';

  @override
  String get providerPendingLinks => '保留中の連携';

  @override
  String get providerNoPendingLinks => '保留中の連携はありません';

  @override
  String providerPendingPatient(String idPrefix) {
    return '患者 $idPrefix…';
  }

  @override
  String get providerRecentInvites => '最近の招待コード';

  @override
  String get providerNoInvites => 'まだ招待コードがありません';

  @override
  String get providerInviteConsumed => '使用済み';

  @override
  String get providerInviteActive => '有効';

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
