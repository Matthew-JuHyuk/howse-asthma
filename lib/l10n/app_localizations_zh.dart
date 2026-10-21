// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginEmailLabel => '电子邮箱';

  @override
  String get loginPasswordLabel => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get signUpButton => '注册';

  @override
  String get supabaseNotConfigured =>
      'Supabase is not configured yet.\nAdd SUPABASE_URL and SUPABASE_ANON_KEY to your .env file.';

  @override
  String get homeGreeting => 'Hello';

  @override
  String get homeAirQualityTitle => 'Air Quality Near You';

  @override
  String get homeWeatherTitle => 'Weather Near You';

  @override
  String get asthmaRiskLow => 'Low asthma risk';

  @override
  String get asthmaRiskModerate => 'Moderate asthma risk';

  @override
  String get asthmaRiskHigh => 'High asthma risk - take precautions';

  @override
  String get medicationLogTitle => 'Medication Log';

  @override
  String get medicationLogAddButton => '记录吸入器/药物使用';

  @override
  String get medicationNameLabel => 'Medication Name';

  @override
  String get medicationDoseLabel => 'Dose';

  @override
  String get medicationTimeLabel => 'Time Taken';

  @override
  String get medicationEffectivenessLabel => 'Did it help?';

  @override
  String get reportTitle => 'Insurance Report';

  @override
  String get reportGenerateButton => 'Generate Report for Doctor / Insurance';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguageLabel => '语言';

  @override
  String get settingsLocationLabel => 'Location';

  @override
  String get notificationAttackWarningTitle => 'Asthma Attack Risk Alert';

  @override
  String get mockContinue => '继续';

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
  String get mockUnlock => '解锁';

  @override
  String get mockUsePassword => '改用密码';

  @override
  String get mockOnboardingTitle => 'Patient setup';

  @override
  String get mockHomeLocation => '家';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => '紧急联系人';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => '医疗人员邀请码';

  @override
  String get mockFinishOnboarding => 'Go to home';

  @override
  String get mockAllScreens => '所有页面';

  @override
  String get mockAllScreensHint => 'Open any Screen ID for design review';

  @override
  String get mockStateCalm => '平稳';

  @override
  String get mockStateWarning => '警告';

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
  String get mockForecast => '预报';

  @override
  String get mockForecastHint => 'Next days air & pollen outlook';

  @override
  String get mockAlertPreview => 'Alert landing';

  @override
  String get mockAlertPreviewHint => 'Preview risk alert screen';

  @override
  String get mockShowWarningHome => '预览“警告”首页';

  @override
  String get mockBackToCalmHome => '返回';

  @override
  String get mockPanicCta => 'Panic mode';

  @override
  String get mockTrapAxis => 'TRAP／烟尘';

  @override
  String get mockFloodAxis => '山洪暴发';

  @override
  String get mockPollenAxis => '花粉';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · Pollen outlook';

  @override
  String get mockActSurvey => 'ACT 问卷';

  @override
  String get mockActHint => '5 个图示问题（过去 4 周）';

  @override
  String get mockPdcCheck => '每日 PDC 检查';

  @override
  String get mockPdcHint => '一键记录用药';

  @override
  String get mockInhalerEvent => '已记录吸入器使用';

  @override
  String get mockActIntro =>
      'Answer based on the last 4 weeks. Design preview — answers are not saved.';

  @override
  String get mockQuestion => '问题';

  @override
  String get mockSubmit => '提交';

  @override
  String get mockPdcPrompt => '您今天用了控制类药物吗？';

  @override
  String get mockTakenYes => '是，我用了';

  @override
  String get mockTakenNo => '今天没用';

  @override
  String get mockEvidenceSummary => 'Your evidence summary';

  @override
  String get mockEvidenceBody =>
      'Dummy summary for PA/LMN support. Design preview only.';

  @override
  String get mockInhalerEvents30d => 'Inhaler events (30d)';

  @override
  String get mockActScore => '最近一次 ACT';

  @override
  String get mockPdcRate => 'PDC（30 天）';

  @override
  String get mockLocationsTitle => '已保存的地点';

  @override
  String get mockLocationsHint => '家和工作地点监测';

  @override
  String get mockWorkLocation => '工作地点';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => '添加地点';

  @override
  String get mockRewardTitle => 'Rewards';

  @override
  String get mockDraftBanner => '草稿——积分和代金券仅供预览';

  @override
  String get mockPointsBalance => '积分余额';

  @override
  String get mockVoucherTitle => '食物银行代金券';

  @override
  String get mockVoucherHint => 'Exchange points (waitlist)';

  @override
  String get mockDonateTitle => '捐款';

  @override
  String get mockDonateHint => '仅限通过第三方捐款';

  @override
  String get mockRewardHistory => '历史记录';

  @override
  String get mockRewardHistoryHint => '积分和捐款';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank（演示）';

  @override
  String get mockVoucherCost => '50 积分 · 价值 \$10（草稿）';

  @override
  String get mockJoinWaitlist => '加入候补名单';

  @override
  String get mockDonateTransparency =>
      '捐款通过经过验证的第三方非营利平台办理。Howse Asthma 从不保存银行卡信息。';

  @override
  String get mockDonateCta => '打开捐款页面（外部）';

  @override
  String get mockExternalOnly => '设计预览中未接入外部捐款服务。';

  @override
  String get mockSignOutPreview => '退出登录（预览）';

  @override
  String get mockOpenAuthFlow => 'Open auth flow';

  @override
  String get mockAlertBody =>
      'Risk rose near your location. Review environment details.';

  @override
  String get mockDismiss => '关闭';

  @override
  String get mockPanicTitle => 'Need help now?';

  @override
  String get mockPanicStep1Body => '第 1 步——请把吸入器带在身边。点“继续”查看紧急联系人。';

  @override
  String get mockPanicStep2Title => '呼叫求助';

  @override
  String get mockPanicStep2Body =>
      '设计预览：这些按钮不会真的拨打电话。在手机应用版本中，第 2 步使用 tel: 链接。';

  @override
  String get mockCall911 => '拨打 911';

  @override
  String get mockCallGuardian => '呼叫紧急联系人';

  @override
  String get mockFeelingBetter => '我感觉好些了';

  @override
  String get mockTabHome => '首页';

  @override
  String get mockTabLog => '记录';

  @override
  String get mockTabReport => '报告';

  @override
  String get mockTabReward => '奖励';

  @override
  String get mockTabSettings => '设置';

  @override
  String get navHome => 'Home';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get authChooseRole => '请选择您的身份';

  @override
  String get authRolePatient => '患者';

  @override
  String get authRolePatientHint => 'Track air quality risk and inhaler use';

  @override
  String get authRoleProvider => '医疗人员';

  @override
  String get authRoleProviderHint =>
      'Link patients and review clinical evidence';

  @override
  String get authFullNameLabel => '姓名';

  @override
  String get authNpiLabel => 'NPI 号码';

  @override
  String get authNpiHelper => '10 位国家医疗服务提供者标识码';

  @override
  String get authOrContinueWith => '或使用以下方式继续';

  @override
  String get authContinueGoogle => '使用 Google 继续';

  @override
  String get authContinueApple => '使用 Apple 继续';

  @override
  String get authCheckEmailTitle => 'Check your email';

  @override
  String authCheckEmailBody(String email) {
    return 'We sent a confirmation link to $email. Open it, then sign in.';
  }

  @override
  String get authBackToSignIn => 'Back to sign in';

  @override
  String get authCompleteProfileTitle => 'Complete your profile';

  @override
  String get authCompleteProfileBody =>
      'Tell us who you are so we can open the right home screen.';

  @override
  String get authSaveProfile => 'Save profile';

  @override
  String get authSignOut => '退出登录';

  @override
  String get authRetry => '重试';

  @override
  String get authWorking => '处理中…';

  @override
  String get authValidationInvalidEmail => 'Enter a valid email';

  @override
  String get authValidationPasswordMin =>
      'Password must be at least 8 characters';

  @override
  String get authValidationNameRequired => 'Name is required';

  @override
  String get authValidationInvalidNpi => 'Enter a valid 10-digit NPI';

  @override
  String get authErrorGeneric => '出了点问题，请再试一次。';

  @override
  String get authErrorInvalidCredentials => 'Invalid email or password';

  @override
  String get authErrorEmailTaken => 'An account with this email already exists';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirm your email before signing in';

  @override
  String get authErrorWeakPassword => 'Password is too weak';

  @override
  String get authErrorRateLimited => 'Too many attempts. Try again later.';

  @override
  String get authBiometricTitle => '解锁 Howse Asthma';

  @override
  String get authBiometricHint => '使用生物识别继续';

  @override
  String get authBiometricReason => '解锁 Howse Asthma';

  @override
  String get authBiometricUnlock => 'Unlock';

  @override
  String get authBiometricFailed => 'Biometric unlock failed. Try again.';

  @override
  String get authBiometricToggle => '生物识别解锁';

  @override
  String get authBiometricToggleHint => '打开应用时需要生物识别解锁';

  @override
  String get authBiometricUnavailable => '此设备不支持生物识别';

  @override
  String get authOnboardingTitle => '患者设置';

  @override
  String get authOnboardingBody =>
      'If your clinician shared an 8-character invite code, enter it now. You can also do this later in Settings.';

  @override
  String get authOnboardingSkip => '暂时跳过';

  @override
  String get authInviteCodeLabel => '医疗人员邀请码';

  @override
  String get authInviteCodeHelper => '8 位字母或数字，24 小时后失效';

  @override
  String get authInviteRedeem => 'Redeem';

  @override
  String get authInviteRedeemAndContinue => 'Redeem and continue';

  @override
  String get authInviteInvalidFormat =>
      'Invite code must be 8 letters or numbers';

  @override
  String get authInviteRedeemedPending =>
      'Invite redeemed. Waiting for provider confirmation.';

  @override
  String get authInviteRedeemFailed => 'Could not redeem invite code';

  @override
  String get authInviteIssueFailed => '无法生成邀请码';

  @override
  String get authConfirmLink => '确认';

  @override
  String get authRejectLink => '拒绝';

  @override
  String get authLinkStatusPending => '等待确认';

  @override
  String get settingsSystemDefault => 'System default';

  @override
  String get settingsLocationTodo =>
      'Location permission will be requested in a later update';

  @override
  String get providerHomeTab => '首页';

  @override
  String get providerLinkTab => '关联';

  @override
  String get providerHomeTitle => '医疗人员首页';

  @override
  String providerHomeWelcome(String email) {
    return '已登录账号：$email';
  }

  @override
  String get providerHomePlaceholder => '患者临床看板将在后续版本中推出。请先关联患者。';

  @override
  String get providerLinkPatientsCta => '关联患者';

  @override
  String get providerLinkTitle => '关联患者';

  @override
  String get providerLinkIntro => '生成一个 8 位邀请码（24 小时内有效）。患者输入后，双方再各自确认。';

  @override
  String get providerIssueInviteCta => '生成邀请码';

  @override
  String get providerInviteTtlHint => '24 小时内有效';

  @override
  String get providerInviteCopied => '邀请码已复制';

  @override
  String get providerPendingLinks => '待确认的关联';

  @override
  String get providerNoPendingLinks => '没有待确认的关联';

  @override
  String providerPendingPatient(String idPrefix) {
    return '患者 $idPrefix…';
  }

  @override
  String get providerRecentInvites => '最近的邀请码';

  @override
  String get providerNoInvites => '还没有邀请码';

  @override
  String get providerInviteConsumed => '已使用';

  @override
  String get providerInviteActive => '有效';

  @override
  String get splashTagline => '帮您挡住诱发因素的智能防护盾';

  @override
  String get splashGetStarted => '开始使用';

  @override
  String get splashAlreadyHaveAccount => '已有账号？';

  @override
  String get splashSignIn => '登录';

  @override
  String get authForgotPassword => '忘记密码？';

  @override
  String get authNoAccount => '还没有账号？';

  @override
  String get authUseBiometricHint => '使用 Face ID 或指纹解锁';

  @override
  String get authTouchSensorHint => '触摸传感器或看向摄像头';

  @override
  String get navLog => 'Log';

  @override
  String get navReport => 'Report';

  @override
  String get navRewards => 'Rewards';

  @override
  String get mockChooseLanguage => '选择语言';

  @override
  String get mockYourLocation => '您的位置';

  @override
  String get mockUseCurrentLocation => '使用当前位置';

  @override
  String get mockLocationTrapOnly => '位置仅用于获取 TRAP 空气质量数据';

  @override
  String get mockLabelYourPlace => '给这个地点命名';

  @override
  String get mockSchool => '学校';

  @override
  String get mockWork => '工作地点';

  @override
  String get mockOther => '其他';

  @override
  String get mockEmergencyOnePerson => '紧急情况下可联系的一个人';

  @override
  String get mockContactName => '联系人姓名';

  @override
  String get mockPhoneNumber => '电话号码';

  @override
  String get mockProviderPairing => '与医疗人员配对';

  @override
  String get mockPairingOptional => '可选——以后也可以在“设置”中添加';

  @override
  String get mockNext => '下一步';

  @override
  String get mockProfessionalProfile => '专业资料';

  @override
  String get mockStep2Of4 => '第 2 步，共 4 步';

  @override
  String get mockTellPractice => '请介绍一下您的诊所';

  @override
  String get mockSpecialtyLabel => '专科';

  @override
  String get mockClinicLabel => '诊所/机构名称';

  @override
  String get mockNpiFormatOnly => '仅检查格式。提交后才会核实 NPI。';

  @override
  String get mockCredentialsSecure => '您的资质信息已加密并安全保存。未经您同意，我们不会分享医疗人员的数据。';

  @override
  String get oneTapFab => '1-Tap';

  @override
  String get oneTapLoggedSnack => 'Inhaler use logged (stub)';

  @override
  String get oneTapLoggedOk => 'Inhaler use logged';

  @override
  String get oneTapLoggedFailed => 'Could not log inhaler use. Try again.';

  @override
  String get homeDailySummary => 'Here is your daily summary';

  @override
  String get homeWarningBanner =>
      'Elevated risk nearby. Limit outdoor exposure and keep your inhaler ready.';

  @override
  String get homeEnvFactors => 'Environmental Factors';

  @override
  String get homeViewDetails => 'View details';

  @override
  String get homeFloodActive => 'Active warning';

  @override
  String get homeFloodNone => 'None';

  @override
  String get homeLastInhalerNone => 'No inhaler use logged yet';

  @override
  String get homeLastInhalerToday => 'Last inhaler use: today';

  @override
  String homeLastInhalerDays(int days) {
    return 'Last inhaler use: $days days ago';
  }

  @override
  String get locationServiceDisabled =>
      'Turn on location services to see nearby asthma risk.';

  @override
  String get locationPermissionDenied =>
      'Location permission is needed for air quality near you.';

  @override
  String get locationPermissionDeniedForever =>
      'Location permission is blocked. Open settings to allow it.';

  @override
  String get locationUnavailable =>
      'Could not get your location. Pull to refresh or try again.';

  @override
  String get locationOutOfServiceArea =>
      'Howse Asthma currently supports locations in the United States.';

  @override
  String get locationOpenSettings => 'Open settings';

  @override
  String get locationStatusGranted => 'Location access is on';

  @override
  String get njOnlyDataNotice =>
      'NJ-only data: freight AADT weighting applies in New Jersey only. TRAP still uses air-quality sensors nationwide.';

  @override
  String get homeDegradedNotice =>
      'Some air-quality sources are unavailable. Risk may be incomplete — treat with caution.';

  @override
  String logWeekSummary(int count) {
    return '$count inhaler events in the last 7 days';
  }

  @override
  String get logFilterAll => 'All';

  @override
  String get logFilterRescue => 'Rescue';

  @override
  String get logFilterPanic => 'Panic';

  @override
  String get logEmpty => 'No inhaler events yet. Use 1-Tap on Home.';

  @override
  String get logEventRescue => 'Inhaler use';

  @override
  String get logEventPanic => 'Panic inhaler use';

  @override
  String get actTitle => 'Asthma Check';

  @override
  String get actPast4Weeks => '过去 4 周内';

  @override
  String get actQ1 => '您的哮喘在多长时间里妨碍了您在工作、学校或家里做事？';

  @override
  String get actQ2 => '您多久出现一次气短？';

  @override
  String get actQ3 => '哮喘症状多久会让您夜里醒来，或比平时早醒一次？';

  @override
  String get actQ4 => '您多久使用一次急救吸入器或雾化药物？';

  @override
  String get actQ5 => '您觉得自己的哮喘控制得怎么样？';

  @override
  String get actOpt1 => '一直如此';

  @override
  String get actOpt2 => '大部分时间';

  @override
  String get actOpt3 => '有些时候';

  @override
  String get actOpt4 => '偶尔';

  @override
  String get actOpt5 => '从未';

  @override
  String get actQ5Opt1 => '完全没有控制';

  @override
  String get actQ5Opt2 => '控制得很差';

  @override
  String get actQ5Opt3 => '控制得一般';

  @override
  String get actQ5Opt4 => '控制得很好';

  @override
  String get actQ5Opt5 => '完全控制';

  @override
  String actSaved(int score) {
    return 'ACT saved. Score: $score';
  }

  @override
  String get pdcTitle => 'Daily medicine check';

  @override
  String get pdcSaved => 'Daily check saved';

  @override
  String get pdcAlreadyYes =>
      'You already marked today as taken. You can update it.';

  @override
  String get pdcAlreadyNo =>
      'You already marked today as not taken. You can update it.';

  @override
  String pdcStreakHint(int taken, int total, String rate) {
    return 'Last 30 days: $taken of $total days taken ($rate)';
  }

  @override
  String get panicEmergencyBadge => 'EMERGENCY';

  @override
  String get panicBreatheTitle => 'Breathe & Use Inhaler';

  @override
  String get panicTakeInhalerNow => 'Take Inhaler Now';

  @override
  String get panicNeedHelp => 'I need more help';

  @override
  String get panicNoAutoDial => '按钮会打开手机拨号界面。不会自动拨出电话。';

  @override
  String panicCallNamed(String name) {
    return '呼叫 $name';
  }

  @override
  String get panicDialFailed => '无法在此设备上打开拨号界面。';

  @override
  String get alertTitle => 'Risk alert';

  @override
  String get alertFcmPendingNote =>
      'If push is enabled on this device, you also get an OS notification when the app is in the background.';

  @override
  String get reportEvidenceBody =>
      'Summary of inhaler use, ACT, and PDC for clinician or insurance review.';

  @override
  String get reportShareTodo =>
      'Share / export will arrive with provider PA/LMN flow.';

  @override
  String get settingsAlertsTitle => 'Alert Preferences';

  @override
  String get settingsAlertRisk => 'Risk Alerts';

  @override
  String get settingsAlertRiskHint =>
      'When your composite risk score reaches 3 or higher';

  @override
  String get settingsAlertHome => 'Saved place alerts';

  @override
  String get settingsAlertHomeHint =>
      'When risk rises at places you saved (home, school, work)';

  @override
  String get settingsAlertLocationEntry => 'Location entry alerts';

  @override
  String get settingsAlertLocationEntryHint =>
      'When you move into a higher-risk area while the app is open';

  @override
  String get settingsSecurityTitle => 'Security';

  @override
  String get emergencyContactRequired =>
      'Enter a contact name and phone number';

  @override
  String get emergencyContactInvalidPhone =>
      'Enter a valid phone with country code (E.164), e.g. +15551234567';

  @override
  String get emergencyContactSaved => 'Emergency contact saved';

  @override
  String get emergencyContactSave => 'Save contact';

  @override
  String get emergencyContactPhoneHint =>
      'Include country code (E.164), e.g. +15551234567';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get envTitle => 'Environment';

  @override
  String get envThreeAxis => 'Three risk axes';

  @override
  String get envTrapDetail =>
      'Traffic-related air pollution proxy (sensors + optional NJ freight weight)';

  @override
  String get envTrapTip =>
      'Limit outdoor exertion when TRAP is HIGH or CRITICAL.';

  @override
  String get envFloodDetail => 'NWS flash-flood / stream warnings near you';

  @override
  String get envFloodTipClear => 'No active flash-flood warning for this area.';

  @override
  String get envPollenDetail => 'Google Pollen forecast';

  @override
  String get envPollenTip =>
      'Keep windows closed and rinse after outdoor time when UPI is high.';

  @override
  String envUsgsRate(String rate) {
    return 'USGS stream change: $rate ft/hr';
  }

  @override
  String envUpdatedAt(String when) {
    return 'Updated: $when';
  }

  @override
  String get envSourcesLabel => 'Data sources';

  @override
  String get envOverallCalm =>
      'Conditions look manageable. Keep your inhaler nearby.';

  @override
  String get forecastIntro =>
      'Outlook for the next periods using air quality and pollen forecasts.';

  @override
  String get forecastEmpty =>
      'Forecast series is not available yet. Pull to refresh.';

  @override
  String get forecastPollenNote =>
      'Pollen uses Google Pollen API (not Open-Meteo). Heatmaps are not used in MVP.';

  @override
  String forecastDayPollen(int upi, String type) {
    return 'Pollen UPI $upi · $type';
  }

  @override
  String forecastDayAqi(int aqi) {
    return 'Max US AQI $aqi';
  }

  @override
  String get forecastMorning => 'Morning';

  @override
  String get forecastAfternoon => 'Afternoon';

  @override
  String get forecastEvening => 'Evening';

  @override
  String get locationsTitle => 'My Locations';

  @override
  String get locationsIntro =>
      'Saved places are checked for risk changes while the app is open. Background OS push needs Firebase (next).';

  @override
  String get locationsEmpty =>
      'No saved places yet. Add your current location.';

  @override
  String get locationsAddTitle => 'Save this place';

  @override
  String get locationsNameLabel => 'Label';

  @override
  String get locationsAddCurrent => 'Add current location';

  @override
  String get locationsSaveFailed =>
      'Could not update saved locations. Try again.';

  @override
  String get locationsCapReached =>
      'You can save up to 10 places. Remove one to add another.';

  @override
  String get locationsDeleteTitle => 'Remove place?';

  @override
  String locationsDeleteBody(String name) {
    return 'Remove “$name” from monitoring?';
  }

  @override
  String locationsCoords(String lat, String lon) {
    return '$lat, $lon';
  }

  @override
  String get locationsPrimaryBadge => 'Primary';

  @override
  String get stateOnlyNjApplied => 'NJ-only: freight AADT weight applied';

  @override
  String get stateOnlyNjNotApplied =>
      'NJ-only: freight AADT weight not applied';

  @override
  String get stateOnlyNjAppliedHint =>
      'Nearby NJDOT traffic counts raised the TRAP weight. Air quality sensors still apply nationwide.';

  @override
  String get stateOnlyNjOutsideHint =>
      'You are outside New Jersey. Freight AADT weighting is NJ-only; TRAP still uses air sensors.';

  @override
  String get stateOnlyNjNoCountHint =>
      'No nearby NJDOT freight count. TRAP uses air-quality sensors without the NJ freight weight.';

  @override
  String get settingsDeveloperSection => 'Developer';

  @override
  String get settingsApiConsole => 'API Console';

  @override
  String get debugApiConsoleBanner =>
      'DEBUG — do not screenshot for public share';

  @override
  String get appTagline => 'Your smart shield against triggers';

  @override
  String get welcomeBenefit1 =>
      'Proactive alerts for air quality & pollen risk';

  @override
  String get welcomeBenefit2 =>
      'A 3-second daily check-in for breathing control';

  @override
  String get welcomeBenefit3 =>
      'Trusted data reports you can share with your clinician';

  @override
  String get welcomeContinueEmail => 'or continue with email';

  @override
  String get welcomeTermsAgree =>
      'I agree to the Terms of Service and Privacy Policy';

  @override
  String get welcomeTermsPending =>
      'Legal document links will be available once published.';

  @override
  String get welcomeClinicianLink => 'I\'m a clinician';

  @override
  String get checkInWelcomeHome => 'Welcome Home!';

  @override
  String get checkInQuestion => 'How is your breathing right now?';

  @override
  String get checkInBreathUsual => 'About the same as usual';

  @override
  String get checkInBreathTight => 'A bit tight';

  @override
  String get checkInBreathSymptoms => 'I have symptoms';

  @override
  String get checkInAeroPoints => 'First check-in done! +5 AeroPoints';

  @override
  String get shieldLocationTitle => 'Activate your preemptive shield';

  @override
  String get shieldLocationBody =>
      'Turn on your preemptive shield around you — we need location for nearby air & pollen.';

  @override
  String get shieldLocationAllow => 'Allow location';

  @override
  String get shieldLocationNotNow => 'Not now';

  @override
  String get settingsPushMaster => 'Push notifications';

  @override
  String get settingsPushMasterHint =>
      'Master switch for all Howse Asthma alerts on this device';

  @override
  String get pushConsentTitle => 'Stay ahead of asthma triggers';

  @override
  String get pushConsentBody =>
      'We can send simple alerts when nearby air or flood risk rises, and later tips for safer times to open windows. You can change this anytime in Settings.';

  @override
  String get pushConsentAllow => 'Allow notifications';

  @override
  String get pushConsentNotNow => 'Not now';

  @override
  String homeNearPlace(String place) {
    return 'Near $place';
  }

  @override
  String get homeStaleLocationNotice =>
      'Showing your last saved reading while we wait for location.';

  @override
  String get homeStaleRefreshNotice =>
      'Showing your last saved reading. Pull to refresh when you have a connection.';

  @override
  String get homeStaleCacheNotice =>
      'This reading may be a little old. Treat with care.';

  @override
  String get homeNowDoThisHeading =>
      'Do this now to lower your chance of an attack';

  @override
  String get homeDraftBadge => 'Draft';

  @override
  String get homeNowDoThisFloodTitle => 'Stay inside if you can';

  @override
  String get homeNowDoThisFloodBody =>
      'Flood alerts often mean damp rooms. Keep your inhaler close and avoid flooded areas.';

  @override
  String get homeNowDoThisTrapTitle => 'Ease up on outdoor activity';

  @override
  String get homeNowDoThisTrapBody =>
      'Traffic-related air pollution nearby looks high. Short outdoor trips only if needed.';

  @override
  String get homeNowDoThisPollenTitle => 'Keep windows closed for now';

  @override
  String get homeNowDoThisPollenBody =>
      'Pollen is high. Rinse face and change clothes after being outside.';

  @override
  String get homeNowDoThisRiskTitle => 'Slow down outdoors';

  @override
  String get homeNowDoThisRiskBody =>
      'Overall risk is elevated. Keep your inhaler with you and rest if breathing feels hard.';

  @override
  String get homeNowDoThisCalmTitle => 'A calmer window for fresh air';

  @override
  String get homeNowDoThisCalmBody =>
      'Outside air looks manageable. A short air-out may help — still keep your inhaler nearby.';

  @override
  String get homeAdherenceSection => 'Your inhaler week';

  @override
  String get adherenceWeekHint =>
      'Filled days show logged inhaler uses (1-Tap).';

  @override
  String get homeMoldAxis => 'Mold risk';

  @override
  String get homeMoldElevatedDraft => 'Higher dampness signal';

  @override
  String get homeMoldPendingDraft => 'Humidity data pending';

  @override
  String get homeFloodAsMoldFactor => 'Flood / damp factor';

  @override
  String get homeForecastLink => 'Short outlook';

  @override
  String homeForecastHint(String date, String score) {
    return 'Next day $date · score $score';
  }

  @override
  String homeSensorDistance(
    String km,
    String mi,
    String radiusKm,
    String radiusMi,
  ) {
    return 'Nearest air sensor $km km ($mi mi) · search ~$radiusKm km ($radiusMi mi)';
  }

  @override
  String homeSensorNearestOnly(String km, String mi) {
    return 'Nearest air sensor $km km ($mi mi)';
  }

  @override
  String homeSensorRadiusOnly(String km, String mi) {
    return 'Sensor search ~$km km ($mi mi)';
  }

  @override
  String get weekdayMonShort => 'M';

  @override
  String get weekdayTueShort => 'T';

  @override
  String get weekdayWedShort => 'W';

  @override
  String get weekdayThuShort => 'T';

  @override
  String get weekdayFriShort => 'F';

  @override
  String get weekdaySatShort => 'S';

  @override
  String get weekdaySunShort => 'S';

  @override
  String get logAdherenceCalendarTitle => 'Adherence calendar';

  @override
  String get homeNowDoThisMoldTitle => 'Cut down indoor dampness';

  @override
  String get homeNowDoThisMoldBody =>
      'Outdoor dampness looks high. Run a fan or dehumidifier if you have one, and avoid wet basements.';

  @override
  String get homeMoldDetail =>
      'Dampness conditions near you (outdoor proxy — not a spore count)';

  @override
  String get homeMoldTip =>
      'High mold risk means keep rooms drier when you can. Flood warnings raise dampness risk.';

  @override
  String homeMoldRh(String pct) {
    return 'Humidity $pct%';
  }

  @override
  String homeMoldTempF(String temp) {
    return '$temp°F';
  }

  @override
  String homeMoldDewF(String temp) {
    return 'Dew $temp°F';
  }

  @override
  String homeMoldWetHours(int hours) {
    return '$hours wet hours (24h)';
  }

  @override
  String get homeMoldProxyDisclaimer => 'Outdoor estimate only';

  @override
  String get homeVentilationSnack =>
      'Outside air looks calmer — a short air-out may help.';

  @override
  String get settingsAlertPositive => 'Fresh-air tips';

  @override
  String get settingsAlertPositiveHint =>
      'When outdoor air looks safer for a short window open (draft rules)';

  @override
  String get settingsBgTitle => 'Background refresh';

  @override
  String get settingsBgBody =>
      'Howse Asthma refreshes nearby air while you use the app. We do not request Always location in this version.';

  @override
  String get settingsBgRefresh => 'Refresh while using the app';

  @override
  String get settingsBgRefreshHint =>
      'Update risk when you move or keep the app open';

  @override
  String get s5AboutApp => 'About Howse Asthma';

  @override
  String get s5AboutAppBody =>
      'Howse Asthma helps you keep a record of symptoms and inhaler use and prepare a summary for your clinician. It does not diagnose or give treatment advice.';

  @override
  String get s5ActNotice => '您的回答已保存，可以分享给您的医生。这份问卷的版本尚未按官方评分方法核对，所以应用不显示分数。';

  @override
  String get s5ActSaved => '您的回答已保存。';

  @override
  String get s5ActSubtitle => '关于过去 4 周的 5 个问题';

  @override
  String get s5ActTitle => '哮喘控制问卷';

  @override
  String get s5AddDetails => '添加详情';

  @override
  String get s5AddRecord => '添加记录';

  @override
  String get s5AlertArrive => 'When you arrive somewhere';

  @override
  String get s5AlertArriveHint =>
      'When local conditions are worse where you arrive. Only while the app is open.';

  @override
  String get s5AlertFreshAirHint =>
      'When outdoor air quality, pollen, and flood information all look calm. General information, not medical advice.';

  @override
  String get s5AlertSavedPlaces => 'Saved places';

  @override
  String get s5AlertSavedPlacesHint =>
      'When local conditions get worse at a place you saved.';

  @override
  String get s5AlertWorse => 'When conditions get worse';

  @override
  String get s5AlertWorseHint =>
      'When air quality, pollen, or flood information near you gets worse. The same alert is not repeated within an hour.';

  @override
  String get s5AqiGood => 'Good';

  @override
  String get s5AqiModerate => 'Moderate';

  @override
  String get s5AqiUsg => 'Unhealthy for sensitive groups';

  @override
  String get s5AqiUnhealthy => 'Unhealthy';

  @override
  String get s5AqiVeryUnhealthy => 'Very unhealthy';

  @override
  String get s5AqiHazardous => 'Hazardous';

  @override
  String s5AqiValue(String category, int aqi) {
    return '$category (AQI $aqi)';
  }

  @override
  String get s5Back => '返回';

  @override
  String get s5BarrierCost => 'Cost of medicine';

  @override
  String get s5BarrierHardToGet => 'Hard to get medicine';

  @override
  String get s5BarrierHardToUnderstand => 'Hard to understand instructions';

  @override
  String get s5BarrierHowToUse => 'How to use my medicine';

  @override
  String get s5BarrierNone => 'No difficulties';

  @override
  String get s5BarrierOtherHint => 'Describe in your own words (optional)';

  @override
  String get s5Cancel => '取消';

  @override
  String get s5Change => '更改';

  @override
  String get s5ChoosePlace => 'Choose a place';

  @override
  String get s5Close => 'Close';

  @override
  String get s5DataSourcesTitle => 'Data sources';

  @override
  String get s5DataSourcesBody =>
      'Air quality: U.S. EPA AirNow, Open-Meteo, and nearby PurpleAir sensors.\nPollen: Google Pollen API (Universal Pollen Index).\nWeather and humidity: Open-Meteo.\nFlood alerts: U.S. National Weather Service. Stream levels: U.S. Geological Survey.\nTraffic counts (New Jersey only): NJ Department of Transportation.\nValues can be delayed or missing. They describe outdoor conditions, not your health.';

  @override
  String get s5Delete => '删除';

  @override
  String get s5DeleteConfirm => '要删除这条记录吗？';

  @override
  String get s5DeleteFailed => '无法删除，请再试一次。';

  @override
  String get s5Edit => '编辑';

  @override
  String get s5EnglishVersion => 'English (for clinician)';

  @override
  String get s5EntryRemoved => '记录已删除。';

  @override
  String get s5EnvAirDetail =>
      'U.S. EPA Air Quality Index from public monitors and nearby sensors. It describes outdoor air in your area, not traffic exhaust specifically.';

  @override
  String get s5EnvAirQuality => 'Air quality';

  @override
  String get s5EnvAlertsHeading => 'Environment alerts';

  @override
  String get s5EnvCardTitle => 'Today\'s local environment';

  @override
  String get s5EnvFlood => 'Flood alerts';

  @override
  String get s5EnvFloodDetail =>
      'Public alerts from the U.S. National Weather Service.';

  @override
  String get s5EnvForecast => 'Environmental forecast';

  @override
  String get s5EnvHumidity => 'Humidity conditions';

  @override
  String get s5EnvHumidityDetail =>
      'Outdoor weather data. It is not an indoor humidity or mold measurement.';

  @override
  String get s5EnvLoadFailed => 'Couldn\'t load environmental information.';

  @override
  String get s5EnvNeedPlace => 'Choose a place to see your local environment.';

  @override
  String get s5EnvNotAvailable => 'Not available';

  @override
  String get s5EnvOlderNotice => 'This is the last information we checked.';

  @override
  String get s5EnvPollen => 'Pollen index';

  @override
  String get s5EnvPollenDetail =>
      'Universal Pollen Index from Google, from 0 (none) to 5 (very high). A low number does not mean it is safe for everyone.';

  @override
  String get s5EnvSeeDetails => 'See environment details';

  @override
  String get s5EnvUnavailable => 'Environmental data is currently unavailable.';

  @override
  String get s5FewRecordsNotice =>
      'Some sections may be empty because few records are available.';

  @override
  String get s5FgRefreshTitle => 'Refresh environment while using the app';

  @override
  String get s5FgRefreshHint =>
      'Checks your area while the app is open. It does not run in the background.';

  @override
  String get s5FieldDate => '日期';

  @override
  String get s5FieldMedication => '药物';

  @override
  String get s5FieldNote => '备注（可选）';

  @override
  String get s5FieldPuffs => '喷数（可选）';

  @override
  String get s5FieldReason => '原因（可选）';

  @override
  String get s5FieldTime => '时间';

  @override
  String get s5FilterAll => '全部';

  @override
  String get s5FilterInhaler => '吸入器';

  @override
  String get s5FilterMedCheck => '用药确认';

  @override
  String get s5FilterSymptoms => '症状';

  @override
  String get s5FloodIssued => 'Flood warning issued';

  @override
  String get s5FloodNone => 'No flood warnings issued';

  @override
  String get s5FloodUnknown => 'Can\'t check alert information';

  @override
  String s5ForecastCheckedAt(String time) {
    return 'Checked $time';
  }

  @override
  String s5ForecastValidFor(String date) {
    return 'Forecast for $date';
  }

  @override
  String get s5FromUrgentHelp => '从“紧急求助”记录';

  @override
  String get s5HomeStateEmpty =>
      'Make your first record. You can organize what to share at your visit along the way.';

  @override
  String s5HomeStateQuestions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'You have $n questions for your doctor.',
      one: 'You have 1 question for your doctor.',
    );
    return '$_temp0';
  }

  @override
  String s5HomeStateRecords(int n) {
    return 'Days with records in the last 7 days: $n';
  }

  @override
  String get s5HomeSubtitle => 'Bring your records to your next visit.';

  @override
  String get s5HomeTitle => 'Record how you\'re doing today';

  @override
  String s5HumidityValue(int rh) {
    return 'Outdoor humidity $rh%';
  }

  @override
  String get s5IncludeEnvironment => 'Local environment (optional)';

  @override
  String get s5IncludeEnvironmentHint =>
      'Adds today\'s air quality, pollen, and flood alerts. Your exact location is not included.';

  @override
  String get s5InhalerEditTitle => '吸入器使用详情';

  @override
  String get s5InhalerEntry => '吸入器使用';

  @override
  String get s5InhalerLogged => '已记录吸入器使用。';

  @override
  String get s5InhalerOneEntryHint => '每保存一次就是一条吸入器使用记录。它不会被算作一喷或一天。';

  @override
  String s5InhalerUnknownCount(int n) {
    return '未确定药物：$n';
  }

  @override
  String get s5InsCost => 'Cost difficulties';

  @override
  String get s5InsDenial => 'Reason given for a denial, if any';

  @override
  String get s5InsMedHistory => 'Medicines I have tried';

  @override
  String get s5InsuranceIntro =>
      'Organize information for your clinician\'s paperwork.';

  @override
  String get s5InsuranceLimits =>
      'Everything here is optional. This app does not submit anything to insurers and does not decide approvals.';

  @override
  String get s5InsuranceTitle => 'Prepare insurance paperwork';

  @override
  String s5LanguageName(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'ko': 'Korean',
      'ja': 'Japanese',
      'zh': 'Chinese',
      'other': 'another language',
    });
    return '$_temp0';
  }

  @override
  String get s5Last30Days => '最近 30 天';

  @override
  String get s5Last7Days => '最近 7 天';

  @override
  String get s5LogInhaler => '记录吸入器使用';

  @override
  String get s5LogLegend => '每一行是一条已保存的记录。没有记录的日子显示为“未记录”，这和“零”不一样。';

  @override
  String get s5LogSymptoms => '记录症状';

  @override
  String get s5MedAdd => '添加药物';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return '已用药天数：$a · 未用药：$b · 不记得：$c · 未记录：$d';
  }

  @override
  String get s5MedCheckIntro => '这是您自己报告的用药情况确认，不是根据药房记录得出的。';

  @override
  String get s5MedCheckQuestion => '您按计划用药了吗？';

  @override
  String get s5MedCheckTitle => '今日用药确认';

  @override
  String get s5MedChooseHint => '请选择一种药物，或选“我不知道药物名称”。';

  @override
  String get s5MedDailyCheck => '每日确认';

  @override
  String get s5MedDailyCheckHint => '在首页显示“今日用药确认”。只有在医生要求您每天使用这种药时才打开。';

  @override
  String get s5MedDefault => '快速记录的默认药物';

  @override
  String get s5MedDefaultHint => '在首页点“记录吸入器使用”时会用这个药物。';

  @override
  String get s5MedEdit => '编辑药物';

  @override
  String get s5MedNameLabel => '药物名称（与药品标签一致）';

  @override
  String get s5MedNotApplicable => '今天没有安排';

  @override
  String s5MedNotApplicableDays(int n) {
    return '未安排：$n 天';
  }

  @override
  String get s5MedNotRecorded => '未记录药物';

  @override
  String get s5MedNotSure => '我不记得了';

  @override
  String get s5MedNotUsed => '我没有用';

  @override
  String get s5MedOther => '其他名称';

  @override
  String get s5MedOtherHint => '输入药物名称';

  @override
  String get s5MedReasonCost => '费用';

  @override
  String get s5MedReasonForgot => '忘记了';

  @override
  String get s5MedReasonNoMedicine => '手边没有这种药';

  @override
  String get s5MedReasonQuestion => '原因（可选）';

  @override
  String get s5MedUnknown => '我不知道药物名称';

  @override
  String get s5MedUnknownShort => '未确定药物';

  @override
  String get s5MedUsed => '我用了';

  @override
  String get s5MyLanguage => 'My language';

  @override
  String get s5MyLogTitle => '我的记录';

  @override
  String get s5MyMedsEmpty => '还没有保存任何药物。';

  @override
  String get s5MyMedsHint => '这里是您确认过的药物名称，方便更快地记录。这不是用药剂量建议。';

  @override
  String get s5MyMedsOpen => 'Manage my medications';

  @override
  String get s5MyMedsTitle => '我的药物';

  @override
  String get s5NavEnvironment => 'Environment';

  @override
  String get s5NavLog => 'Log';

  @override
  String get s5NavVisitPrep => 'Visit prep';

  @override
  String get s5NoAnswer => '不想回答';

  @override
  String get s5NoRecordsYet => '还没有记录';

  @override
  String s5NoSymptomDays(int n) {
    return '标记为“无症状”的天数：$n';
  }

  @override
  String get s5NotRecorded => '未记录';

  @override
  String get s5NotRecordedToday => 'Not recorded today';

  @override
  String s5NotTranslatedLine(String language, String text) {
    return '[Not translated · original in $language] $text';
  }

  @override
  String get s5OsNotificationsOff =>
      'Notifications are turned off for Howse Asthma in your phone settings, so alerts can\'t appear.';

  @override
  String get s5PdfAboutMedCheck =>
      'Medication check-ins are self-reported by the patient. They are not pharmacy refill data and are not a proportion of days covered (PDC).';

  @override
  String get s5PdfAboutNoScore =>
      'No questionnaire score or app-generated risk score is included.';

  @override
  String get s5PdfAboutPatientReported =>
      'All entries were recorded by the patient in the Howse Asthma app and have not been verified.';

  @override
  String get s5PdfAppendix => 'Appendix: patient notes';

  @override
  String s5PdfDaysNotRecorded(int n) {
    return 'Days with no symptom entry (not recorded): $n';
  }

  @override
  String get s5PdfDisclaimer =>
      'This summary contains patient-reported information for clinician review. It is not a diagnosis or a prior authorization decision.';

  @override
  String get s5PdfEnvNote =>
      'General outdoor conditions when this summary was created. Location is not included.';

  @override
  String get s5PdfFailed =>
      'Couldn\'t create the PDF. Your entries are kept. Please try again.';

  @override
  String get s5PdfFontFailed =>
      'Couldn\'t prepare the PDF fonts. Check your internet connection and try again.';

  @override
  String s5PdfGeneratedAt(String time) {
    return 'Created: $time';
  }

  @override
  String s5PdfInhalerByMed(String name, int n) {
    return '$name: $n entries';
  }

  @override
  String s5PdfInhalerMedNotRecorded(int n) {
    return 'Medication not recorded: $n entries';
  }

  @override
  String s5PdfInhalerUnknown(int n) {
    return 'Medication not identified by patient: $n entries';
  }

  @override
  String s5PdfInhalerUses(int n, int days) {
    return 'Inhaler use entries: $n (on $days days)';
  }

  @override
  String get s5PdfIsEnglish =>
      'The PDF is created in English. Free text you typed stays in your language.';

  @override
  String get s5PdfMedNamesAsEntered =>
      'Medication names are shown as entered by the patient.';

  @override
  String get s5PdfNotRecorded => 'Not recorded';

  @override
  String s5PdfNotUsedReason(String label, int n) {
    return 'Reason for not using (self-reported) — $label: $n days';
  }

  @override
  String get s5PdfOutdated =>
      'Your records or answers changed after the last PDF. Create a new PDF to include the changes.';

  @override
  String s5PdfPeriod(String start, String end, int days) {
    return 'Summary period: $start – $end ($days days)';
  }

  @override
  String s5PdfReasonCount(String label, int n) {
    return 'Reason — $label: $n entries';
  }

  @override
  String s5PdfRecordedDays(int n) {
    return 'Days with any patient entry: $n';
  }

  @override
  String get s5PdfSectionAboutData => 'About this information';

  @override
  String get s5PdfSectionBarriers =>
      'Difficulties getting care (self-reported)';

  @override
  String get s5PdfSectionEnvironment => 'Local environment (reference)';

  @override
  String get s5PdfSectionInhaler => 'Inhaler use';

  @override
  String get s5PdfSectionInsurance => 'Notes for paperwork (patient-provided)';

  @override
  String get s5PdfSectionMedChecks => 'Self-reported medication use';

  @override
  String get s5PdfSectionQuestions => 'Patient questions';

  @override
  String get s5PdfSectionSymptoms => 'Symptoms';

  @override
  String s5PdfSymptomCodeDays(String label, int n) {
    return '$label: $n days';
  }

  @override
  String s5PdfSymptomDays(int n, int days) {
    return 'Days with any symptom: $n of $days';
  }

  @override
  String s5PdfSymptomOtherDays(int n) {
    return 'Other symptoms described by patient: $n days';
  }

  @override
  String get s5PdfTitle => 'Patient-reported asthma visit summary';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return '时间段：$days 天 · 有记录的天数：$n';
  }

  @override
  String get s5PhoneHint =>
      'Include the country code. Example: +1 201 555 0123';

  @override
  String get s5PhoneInvalid =>
      'Enter a name and a phone number with the country code, for example +1 201 555 0123.';

  @override
  String get s5PollenGrass => 'Grass';

  @override
  String s5PollenMainType(String type) {
    return 'Main type: $type';
  }

  @override
  String get s5PollenTree => 'Tree';

  @override
  String get s5PollenWeed => 'Weed';

  @override
  String get s5PrepareVisit => 'Prepare for visit';

  @override
  String get s5PreviewEditHint =>
      'To change a question or note, go back and edit it. To change numbers, edit the entries in My log.';

  @override
  String get s5PreviewSummary => 'Preview visit summary';

  @override
  String get s5PreviewTitle => 'Visit summary preview';

  @override
  String s5PuffsValue(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 喷',
      one: '1 喷',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return 'Question $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return '第 $n 题，共 $total 题';
  }

  @override
  String get s5ReasonBeforeActivity => '活动前';

  @override
  String get s5ReasonOther => '其他';

  @override
  String get s5ReasonSymptoms => '因为有症状';

  @override
  String s5RecentInhaler(int n) {
    return '吸入器使用记录：$n 条';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return '有症状的天数：$n';
  }

  @override
  String get s5RecentTitle => 'Last 7 days';

  @override
  String get s5RecordsLoadFailed => '无法加载您的记录，请再试一次。';

  @override
  String get s5RecordsManageHint =>
      'You can edit or delete entries in My log. Deleting always asks you to confirm.';

  @override
  String get s5Refresh => 'Refresh';

  @override
  String get s5Reload => 'Load again';

  @override
  String get s5Save => '保存';

  @override
  String get s5Saved => '已保存。';

  @override
  String get s5SavedPlacesHint => 'Saved places such as home, school, or work';

  @override
  String get s5SaveFailed => '无法保存。您填写的内容还在。';

  @override
  String get s5SavePdf => 'Save PDF';

  @override
  String get s5SettingsAlerts => 'Alerts';

  @override
  String get s5SettingsArea => 'Area';

  @override
  String get s5SettingsHelp => 'Help';

  @override
  String get s5SettingsLanguageNote =>
      'Your visit summary is created in English. You can compare it with your own language before sharing.';

  @override
  String get s5SettingsSecurityData => 'Security and data';

  @override
  String get s5Share => 'Share';

  @override
  String get s5SourcesAir => 'Air quality: EPA AirNow, Open-Meteo, PurpleAir';

  @override
  String get s5SourcesFlood => 'Flood alerts: National Weather Service';

  @override
  String get s5SourcesNjTraffic =>
      'Traffic count data is used only in New Jersey.';

  @override
  String get s5SourcesNoRiskScore =>
      'The app\'s internal combined score is not an asthma attack risk and is not shown.';

  @override
  String get s5SourcesPollen => 'Pollen: Google Pollen API';

  @override
  String get s5SourcesTitle => 'Sources and limits';

  @override
  String get s5SourcesWeather => 'Weather and humidity: Open-Meteo';

  @override
  String get s5StatusLatest => 'Latest';

  @override
  String get s5StatusOlder => 'Older data';

  @override
  String get s5StatusUnavailable => 'Can\'t check right now';

  @override
  String get s5SymActivityLimited => '活动受限';

  @override
  String get s5SymCough => '咳嗽';

  @override
  String get s5SymNightWaking => '夜里醒来';

  @override
  String get s5SymNone => '没有症状';

  @override
  String get s5SymOther => '其他情况';

  @override
  String get s5SymOtherHint => '用您自己的话描述';

  @override
  String get s5SymShortBreath => '呼吸困难';

  @override
  String get s5SymWheeze => '喘鸣';

  @override
  String get s5SymptomEditTitle => '编辑症状';

  @override
  String get s5SymptomEntry => '症状';

  @override
  String get s5SymptomNoneHint => '您没有记录的日子会显示为“未记录”，而不是“无症状”。';

  @override
  String get s5SymptomQuestion => '您注意到了什么？';

  @override
  String get s5Today => '今天';

  @override
  String get s5Undo => '撤销';

  @override
  String s5UntranslatedNotice(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other:
          '$n entries are not translated. They appear in the English PDF in your language, marked “Not translated”.',
      one:
          '1 entry is not translated. It appears in the English PDF in your language, marked “Not translated”.',
    );
    return '$_temp0';
  }

  @override
  String s5UpdatedAt(String time) {
    return 'Updated $time';
  }

  @override
  String get s5UpiHigh => 'High';

  @override
  String get s5UpiLow => 'Low';

  @override
  String get s5UpiModerate => 'Moderate';

  @override
  String get s5UpiNone => 'None';

  @override
  String s5UpiValue(int upi, String category) {
    return '$upi of 5 · $category';
  }

  @override
  String get s5UpiVeryHigh => 'Very high';

  @override
  String get s5UpiVeryLow => 'Very low';

  @override
  String get s5UrgentActionPlan => '如果医生给了您哮喘行动计划，请按计划做。';

  @override
  String get s5UrgentCall911Locked => 'Urgent help: call 911';

  @override
  String get s5UrgentHelp => '紧急求助';

  @override
  String get s5UrgentIntro => '如果呼吸非常困难或没有好转，请拨打 911。';

  @override
  String get s5UrgentLogHint => '可选：保存一条您使用了吸入器的记录。';

  @override
  String get s5UrgentNoContact => '还没有紧急联系人。请在“设置”→“帮助”中添加。';

  @override
  String s5UsingMedication(String name) {
    return 'Logs as: $name';
  }

  @override
  String get s5ViewMyLog => 'View my log';

  @override
  String get s5VisitBarriers => 'Did you have trouble getting care?';

  @override
  String s5VisitCardDetail(int days, int recorded, int questions) {
    return 'Last $days days · Days with records: $recorded · Questions: $questions';
  }

  @override
  String get s5VisitCardTitle => 'What to share at your visit';

  @override
  String get s5VisitInclude => 'Records to include';

  @override
  String get s5VisitIntro =>
      'Organize your symptoms and questions to show your clinician.';

  @override
  String get s5VisitPeriod => 'Summary period';

  @override
  String get s5VisitPrepTitle => 'Visit prep';

  @override
  String get s5VisitQuestions => 'Questions for your doctor';

  @override
  String get s5VisitQuestionsHint =>
      'Write in your own language. You can leave these empty.';

  @override
  String get s6AddTime => '添加时间';

  @override
  String get s6AddVisit => 'Add a visit I reported';

  @override
  String get s6BringPaper => 'I will bring a paper';

  @override
  String get s6BringPaperHint =>
      'Bringing a paper does not mean a clinician has confirmed it.';

  @override
  String s6DaySummary(
    String date,
    int used,
    int scheduled,
    int open,
    int symptoms,
    String env,
  ) {
    return '$date · confirmed $used/$scheduled · unconfirmed $open · symptoms $symptoms · $env';
  }

  @override
  String get s6DoseLater => '稍后确认';

  @override
  String get s6DoseNotUsed => '我没法用';

  @override
  String get s6DoseUnconfirmed => 'No answer yet';

  @override
  String get s6DoseUsed => '我用了';

  @override
  String get s6EnvLinked => 'Environment linked';

  @override
  String get s6EnvNoData => 'No environment data for that time';

  @override
  String get s6EvidenceBody =>
      'Organizes records for your clinician and what still needs to be added.';

  @override
  String get s6EvidenceNotOfficial =>
      'This is a general list. It is not an official list of requirements from a specific insurance plan.';

  @override
  String get s6EvidenceTitle =>
      'Prepare records for a visit or insurance review';

  @override
  String get s6HideMedName => 'Hide the medicine name on the lock screen';

  @override
  String get s6HideMedNameHint =>
      'The reminder still arrives at the times you saved. It is not a repeating background alert.';

  @override
  String get s6HomeWaterNo => '没有';

  @override
  String get s6HomeWaterQuestion => '家里有漏水或进水吗？';

  @override
  String get s6HomeWaterYes => '有';

  @override
  String get s6ItemClinician => 'Clinician confirmation or papers to bring';

  @override
  String get s6ItemEnvironment =>
      'Local environment reference at the time of an event';

  @override
  String get s6ItemMedication => 'Medicine name and prescription';

  @override
  String get s6ItemSymptoms => 'Ongoing symptoms and limits on daily life';

  @override
  String get s6ItemUse => 'Time period and use you confirmed';

  @override
  String get s6ItemVisits => 'Visits and emergency visits you reported';

  @override
  String get s6NoSchedule =>
      'No saved dose times yet. Add them under My medications.';

  @override
  String get s6OccurredLabel => '发生时间';

  @override
  String get s6PdfEnvLimit =>
      'Regional reference only. It does not show personal exposure or the cause of symptoms. A single AQI does not name ozone and particles together, and it does not include pollen.';

  @override
  String get s6PdfEnvTitle => 'Environment reference (appendix)';

  @override
  String get s6PuffsEach => '每次喷数';

  @override
  String s6ReminderBodyNamed(String name) {
    return '该确认 $name 了';
  }

  @override
  String get s6ReminderBodyPrivate => '该确认您的药了';

  @override
  String get s6ReminderChannel => '在您保存的用药时间提醒。不是 30 分钟提醒。';

  @override
  String get s6ReminderTitle => '用药确认';

  @override
  String get s6RoleBoth => '每天用，也按需用';

  @override
  String get s6RoleController => '每日用药';

  @override
  String get s6RoleRescue => '按需使用';

  @override
  String get s6ScheduleTimes => '您的用药时间';

  @override
  String get s6StatusClinician => 'Clinician confirmation needed';

  @override
  String get s6StatusNeedInfo => 'More information needed';

  @override
  String get s6StatusRecorded => 'Recorded';

  @override
  String get s6TimelineTitle => 'Treatment and environment';

  @override
  String get s6TodayDoses => 'Medicines to confirm today';

  @override
  String get s6VisitKindEr => 'Emergency room (I reported this)';

  @override
  String get s6VisitKindOffice => 'Clinic visit (I reported this)';

  @override
  String get s6VisitKindOther => 'Other visit (I reported this)';

  @override
  String get s6VisitKindUrgent => 'Urgent care (I reported this)';

  @override
  String get v2SettingsTitle => 'Coverage letters';

  @override
  String get v2NavToggle => 'Show coverage-letter home';

  @override
  String get v2NavToggleHint =>
      'A preview for reading a denial notice and preparing visit materials. Your records stay available. Live document reading stays off.';

  @override
  String get v2HomeHeadline =>
      'Understand a coverage denial letter and prepare materials for a visit.';

  @override
  String get v2HomeBody =>
      'The app does not send an appeal and does not decide whether a plan will approve it.';

  @override
  String get v2AddLetter => 'Add a denial letter';

  @override
  String get v2TrySample => 'Try a sample';

  @override
  String get v2SampleBanner =>
      'Sample. Not a real notice and not a live reading.';

  @override
  String get v2LiveOffTitle => 'Live reading is off';

  @override
  String get v2LiveOffBody =>
      'Photos and files are not analyzed in this build. You can open the labeled sample and walk through the steps.';

  @override
  String get v2Close => 'Close';

  @override
  String get v2MyRecords => 'My records';

  @override
  String get v2EmptyCases => 'No letters yet.';

  @override
  String get v2MedNeedsReview => 'Medication needs review';

  @override
  String get v2NextCheck => 'Next: review the facts';

  @override
  String get v2NextDraft => 'Next: make a draft';

  @override
  String get v2Created => 'Added';

  @override
  String get v2StatusDraft => 'Draft ready';

  @override
  String get v2StatusReady => 'Ready for a draft';

  @override
  String get v2StatusReview => 'Needs review';

  @override
  String get v2DeadlineLabel => 'Deadline';

  @override
  String get v2ExplainTitle => 'Plain explanation';

  @override
  String get v2CheckTitle => 'Things to check';

  @override
  String get v2RecordsTitle => 'My records';

  @override
  String get v2DocsTitle => 'Make documents';

  @override
  String get v2Original => 'Original text';

  @override
  String get v2Patient => 'Name on the notice';

  @override
  String get v2EditMedication => 'Medication text';

  @override
  String get v2Dose => 'Dose as written';

  @override
  String get v2ReasonMissing => 'The reason could not be confirmed.';

  @override
  String get v2ConfirmDate => 'I confirm the date printed on the notice';

  @override
  String get v2SaveEdit => 'Save correction';

  @override
  String get v2ConfirmFacts => 'I reviewed these facts';

  @override
  String get v2Confirmed => 'Reviewed';

  @override
  String get v2NoRecords =>
      'No records linked. You can still make a draft. No adherence figure is added.';

  @override
  String get v2SelfReportLabel => 'Optional note (patient self-report)';

  @override
  String get v2EnglishDraft =>
      'English draft for review. This is the draft to check, not a filed translation.';

  @override
  String get v2DraftBannerNote =>
      'Every page says clinician review is required.';

  @override
  String get v2StaleDraft =>
      'Facts changed. Make the draft again before sharing.';

  @override
  String get v2GenerateReview => 'Make a review draft';

  @override
  String get v2GeneratePrepared => 'Make a prepared draft';

  @override
  String get v2PreparedBlocked =>
      'A prepared draft needs a confirmed name, medication, and denial reason.';

  @override
  String get v2NotInitial =>
      'This document is not an initial drug denial. An appeal draft is not created.';

  @override
  String get v2GenericError => 'That step did not finish. You can try again.';

  @override
  String get v2Share => 'Share';

  @override
  String get v2ClinicianPdf => 'Clinician one-page PDF';

  @override
  String get v2ShareNotSubmitted =>
      'Sharing does not mean the plan received this file.';

  @override
  String get v2DeleteCase => 'Delete this sample';

  @override
  String get v2Deleted => 'Removed from this preview.';

  @override
  String get v2FontUnavailable =>
      'The PDF font could not be loaded. Try again when you are online.';

  @override
  String get v2NotEntered => '[not entered]';

  @override
  String get v2DocDeadline => 'Deadline written on the document';

  @override
  String get v2CalcDeadline => 'Calculated from the received date you entered';

  @override
  String get v2NeedReceived =>
      'The notice counts days after you receive it. Enter that date before a date can be calculated.';

  @override
  String get v2UnclearDeadline =>
      'The deadline wording is unclear. No date was calculated.';

  @override
  String get v2AskPlan =>
      'A deadline was not found in the document. Ask the plan.';

  @override
  String get cnTagline => '保险信件，清楚的下一步';

  @override
  String get cnDemoBadge => '示例';

  @override
  String get cnDemoBadgeLong => '示例使用虚构数据，结果是固定的。';

  @override
  String get cnAuthSignInTitle => '登录';

  @override
  String get cnAuthCreateTitle => '创建账号';

  @override
  String get cnAuthResetTitle => '重设密码';

  @override
  String get cnAuthSignIn => '登录';

  @override
  String get cnAuthCreate => '创建账号';

  @override
  String get cnAuthSendReset => '发送重设链接';

  @override
  String cnAuthProfileError(String code) {
    return '您已登录，但无法加载您的账号（$code）。';
  }

  @override
  String get cnRetry => '再试一次';

  @override
  String get cnSignOut => '退出登录';

  @override
  String get cnAuthPreparingAccount => '正在设置您的账号…';

  @override
  String get cnAuthNameLabel => '姓名（可选）';

  @override
  String get cnAuthNameHelper => '会显示在您的资料包上。以后可以修改。';

  @override
  String get cnAuthEmailLabel => '电子邮箱';

  @override
  String get cnAuthPasswordLabel => '密码';

  @override
  String get cnAuthPasswordHelper => '至少 8 个字符';

  @override
  String get cnAuthShowPassword => '显示密码';

  @override
  String get cnAuthHidePassword => '隐藏密码';

  @override
  String get cnAuthPasswordRequired => '请输入密码';

  @override
  String cnAuthCheckEmail(String email) {
    return '我们已向 $email 发送了确认链接。请在这部手机上打开链接，然后登录。';
  }

  @override
  String cnAuthResetSent(String email) {
    return '如果 $email 对应的账号存在，重设链接已在发送途中。请在这部手机上打开链接。';
  }

  @override
  String get cnAuthResent => '已再次发送。';

  @override
  String get cnAuthResend => '重新发送邮件';

  @override
  String get cnAuthSignInInstead => '我已确认，去登录';

  @override
  String get cnAuthForgot => '忘记密码？';

  @override
  String get cnAuthNoAccount => '第一次使用？创建账号';

  @override
  String get cnAuthHaveAccount => '已有账号？登录';

  @override
  String get cnAuthResetHint => '输入您的电子邮箱，我们会发送一个设置新密码的链接。';

  @override
  String get cnAuthBackToSignIn => '返回登录';

  @override
  String get cnAuthPrivacyLine => '您的信件和记录只有您的账号能看到。';

  @override
  String get cnAuthPasswordUpdated => '密码已更新。';

  @override
  String get cnAuthNewPasswordTitle => '设置新密码';

  @override
  String get cnAuthNewPasswordLabel => '新密码';

  @override
  String get cnAuthSavePassword => '保存密码';

  @override
  String get cnLater => '以后再说';

  @override
  String get cnAuthErrInvalidCredentials => '电子邮箱或密码不正确。';

  @override
  String get cnAuthErrNotConfirmed => '请先确认您的电子邮箱。请查看收件箱，或重新发送链接。';

  @override
  String get cnAuthErrExists => '这个电子邮箱已有账号。请直接登录。';

  @override
  String get cnAuthErrWeakPassword => '请设置更安全的密码（至少 8 个字符）。';

  @override
  String get cnAuthErrSamePassword => '新密码不能和旧密码相同。';

  @override
  String get cnAuthErrRateLimited => '尝试次数太多。请等一分钟后再试。';

  @override
  String get cnAuthErrInvalidEmail => '请检查电子邮箱地址。';

  @override
  String get cnAuthErrEmailNotAuthorized => '我们现在无法向这个地址发送邮件。请稍后再试。';

  @override
  String get cnAuthErrDisabled => '这种登录方式已关闭。';

  @override
  String get cnAuthErrSessionExpired => '您的登录已过期，请重新登录。';

  @override
  String cnAuthErrUnknown(String code) {
    return '出了点问题（$code）。请再试一次。';
  }

  @override
  String get cnErrNetwork => '没有网络连接。请检查网络后再试。';

  @override
  String get cnErrServiceDown => '服务没有响应。请几分钟后再试。';

  @override
  String get cnTabHome => '首页';

  @override
  String get cnTabCases => '案件';

  @override
  String get cnTabRecords => '记录';

  @override
  String get cnTabAccount => '账号';

  @override
  String get cnHomeHeadline => '帮您读懂保险信件。';

  @override
  String get cnScanLetter => '扫描信件';

  @override
  String get cnUploadFile => '上传 PDF／照片';

  @override
  String get cnTryDemo => '试用示例';

  @override
  String get cnHomeSignInLine => '保存您的案件需要账号。';

  @override
  String get cnServiceNotConfigured => '此版本未连接到服务器，只能使用示例。';

  @override
  String get cnContinueCase => '继续处理您的案件';

  @override
  String get cnHowItWorks => '使用方法';

  @override
  String get cnStep1Title => '读信';

  @override
  String get cnStep1Body => '拍一张照片。我们会找出原因、下一步和日期。';

  @override
  String get cnStep2Title => '整理记录';

  @override
  String get cnStep2Body => '把信里要求的内容和您自己的记录对应起来。';

  @override
  String get cnStep3Title => '生成资料包';

  @override
  String get cnStep3Body => '得到一页纸的医生摘要和复核申请草稿。';

  @override
  String get cnRecentCases => '其他案件';

  @override
  String get cnNoCasesYet => '还没有案件';

  @override
  String get cnNoOtherCases => '没有其他案件。';

  @override
  String get cnSeeAllCases => '查看所有案件';

  @override
  String get cnNoCasesBody => '扫描一封保险信件就可以开始。';

  @override
  String get cnCasesSignInTitle => '登录后查看您的案件';

  @override
  String get cnCasesSignInBody => '或者打开示例，看看它是怎么用的。';

  @override
  String get cnCaseDeleted => '案件已删除。';

  @override
  String get cnCaseUntitled => '保险信件';

  @override
  String get cnStatusReading => '正在读信';

  @override
  String get cnStatusNeedsReview => '需要核对';

  @override
  String get cnStatusGatherRecords => '整理记录';

  @override
  String get cnStatusPacketReady => '资料包已备好';

  @override
  String get cnStatusNeedsAttention => '需要留意';

  @override
  String get cnStatusNotStarted => '未开始';

  @override
  String get cnNextWaitReading => '我们正在读这封信。';

  @override
  String get cnNextTryAgain => '读取已中断。请打开案件再试一次。';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 项信息待确认',
      one: '1 项信息待确认',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return '要求的 $total 项中已处理 $done 项';
  }

  @override
  String get cnNextSharePacket => '资料包已备好，可以分享';

  @override
  String get cnNextCreatePacket => '下一步：生成资料包';

  @override
  String cnDateToCheckShort(String date) {
    return '需要留意的日期：$date';
  }

  @override
  String cnDatePassedShort(String date) {
    return '日期已过：$date';
  }

  @override
  String get cnMoreActions => '更多操作';

  @override
  String get cnDeleteCase => '删除案件';

  @override
  String get cnDeleteCaseTitle => '要删除这个案件吗？';

  @override
  String get cnDeleteCaseBody => '这会删除信件页面、从中读取的信息、关联的记录摘要和资料包。您的用药和症状记录会保留。';

  @override
  String get cnCancel => '取消';

  @override
  String get cnDelete => '删除';

  @override
  String get cnDeleteFailed => '无法删除。请检查网络后再试。';

  @override
  String get cnKindInitialDenial => '药物承保拒绝（Denial）';

  @override
  String get cnKindInfoRequest => '要求补充信息';

  @override
  String get cnKindReauth => '续期（重新授权）通知';

  @override
  String get cnKindFinalDenial => '最终申诉决定（Appeal）';

  @override
  String get cnKindEob => '账单或福利说明（EOB）';

  @override
  String get cnKindOther => '其他信件';

  @override
  String get cnKindUncertain => '信件类型不明确';

  @override
  String get cnFieldPatientName => '患者姓名';

  @override
  String get cnFieldPlanName => '保险计划';

  @override
  String get cnFieldMemberId => '会员编号';

  @override
  String get cnFieldCaseReference => '案件或参考编号';

  @override
  String get cnFieldMedication => '药物（按原文）';

  @override
  String get cnFieldDose => '剂量（按原文）';

  @override
  String get cnFieldNoticeDate => '通知日期';

  @override
  String get cnFieldContact => '联系方式';

  @override
  String get cnFieldSubmissionRoute => '寄送方式';

  @override
  String get cnFactEdited => '您已修改';

  @override
  String get cnFactChecked => '已核对';

  @override
  String get cnFactNotInLetter => '信中没有';

  @override
  String get cnFactNeedsCheck => '需要核对';

  @override
  String get cnFactFromLetter => '来自信件';

  @override
  String get cnWhoYou => '您';

  @override
  String get cnWhoCareTeam => '医疗团队';

  @override
  String get cnWhoPlan => '保险计划';

  @override
  String get cnWhoUnknown => '不确定';

  @override
  String get cnReqLinked => '已关联';

  @override
  String get cnReqAskedCareTeam => '已询问医疗团队';

  @override
  String get cnReqNotAvailable => '没有';

  @override
  String get cnReqNotNeeded => '不需要';

  @override
  String get cnReqNeeded => '需要';

  @override
  String get cnReqReset => '标为需要';

  @override
  String get cnRecMedication => '用药史';

  @override
  String get cnRecSymptoms => '症状记录';

  @override
  String get cnRecLocalContext => '当地情况';

  @override
  String get cnRecPrn => '按需使用的吸入器';

  @override
  String get cnDemoTitle => '示例';

  @override
  String get cnDemoReset => '重置示例';

  @override
  String get cnDemoResetDone => '示例已重置。';

  @override
  String get cnDemoIntro => '三封虚构的信件，结果是固定的，方便您看清每一步。不会上传任何内容。';

  @override
  String get cnUpEmpty => '这个文件是空的。';

  @override
  String cnUpTooLarge(int mb) {
    return '每个文件不能超过 $mb MB。';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return '所有页面加起来不能超过 $mb MB。';
  }

  @override
  String cnUpTooManyPages(int max) {
    return '每封信最多 $max 页。';
  }

  @override
  String get cnUpUnsupported => '请使用 JPG、PNG 或 PDF。HEIC 照片请在这里重新拍一张。';

  @override
  String get cnUpBadFile => '无法读取这个文件。请换一张照片或 PDF 试试。';

  @override
  String get cnUpEncrypted => '这个 PDF 有密码保护。请保存一份未加密的副本，或者拍照。';

  @override
  String get cnCameraUnavailable => '无法使用相机。您可以改为上传照片或 PDF。';

  @override
  String get cnPhotosUnavailable => '无法打开照片。请在设置中允许访问照片，或上传 PDF。';

  @override
  String get cnFilesUnavailable => '现在无法打开文件。请再试一次。';

  @override
  String get cnUploadFailed => '上传没有完成。您的页面还在。请再试一次。';

  @override
  String get cnCaptureTitle => '添加信件页面';

  @override
  String get cnReplacePagesTitle => '替换信件页面';

  @override
  String get cnOpening => '正在打开…';

  @override
  String get cnCaptureEmptyTitle => '添加您信件的各页';

  @override
  String get cnCaptureTips => '把信纸平放在光线好的地方，让四个角都在取景框内。请按顺序添加每一页。';

  @override
  String get cnTakePhoto => '拍照';

  @override
  String get cnAddPage => '添加页面';

  @override
  String get cnAddPhoto => '照片';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages 页',
      one: '1 页',
    );
    return '$_temp0 · $size MB';
  }

  @override
  String get cnUploadConsent =>
      '上传会把这些页面发送到 CoverNote 服务器，由 AI 服务为您读取。您可以随时删除案件。';

  @override
  String get cnStageUploading => '上传中';

  @override
  String get cnUploadAndRead => '上传并读取';

  @override
  String cnPageN(int n) {
    return '第 $n 页';
  }

  @override
  String cnPdfPages(int n, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 页',
      one: '1 页',
    );
    return '文件 $n · PDF，$_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return '预览第 $n 页';
  }

  @override
  String get cnRotate => '旋转';

  @override
  String get cnRetake => '重拍';

  @override
  String get cnRemovePage => '移除';

  @override
  String get cnReorder => '拖动可调整顺序';

  @override
  String get cnServiceUnavailableBody => '信件读取功能现在还没有设置好。您的页面已保存，请稍后再试。';

  @override
  String get cnNeedNewPagesBody => '请拍更清楚的照片，或减少页数，然后重新上传。';

  @override
  String get cnPagesKept => '您的页面已保存，没有任何改动。';

  @override
  String get cnReplacePages => '替换页面';

  @override
  String get cnTryAgain => '再试一次';

  @override
  String get cnStageReading => '读取中';

  @override
  String get cnStageChecking => '检查中';

  @override
  String get cnStageReady => '已完成';

  @override
  String get cnReadingTitle => '正在读您的信';

  @override
  String get cnReadingBody => '读完后，请您把我们找到的内容和信件对照核对。';

  @override
  String get cnReadingLeaveOk => '您可以离开这个页面。读取会继续，您的案件已保存。';

  @override
  String get cnStartReading => '开始读取';

  @override
  String get cnStepLetter => '信件';

  @override
  String get cnStepReview => '核对';

  @override
  String get cnStepEvidence => '佐证记录';

  @override
  String get cnStepPacket => '资料包';

  @override
  String cnStepOf(int n, int total, String name) {
    return '第 $n 步，共 $total 步：$name';
  }

  @override
  String get cnSaving => '正在保存…';

  @override
  String get cnSaved => '已保存';

  @override
  String get cnNotSavedRetry => '未保存 · 重试';

  @override
  String get cnViewOriginal => '查看原始页面';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已读取 $count 页',
      one: '已读取 1 页',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return '难以辨认：第 $list 页。请仔细核对这些信息，或重拍这些页面。';
  }

  @override
  String get cnRetakePages => '重拍页面';

  @override
  String get cnHardToRead => '难以辨认';

  @override
  String get cnContinueToReview => '继续核对';

  @override
  String get cnOriginalPages => '原始页面';

  @override
  String get cnNoOriginal => '没有保存原始页面。';

  @override
  String get cnCheckDetails => '核对详细信息';

  @override
  String get cnCheckDetailsHint => '请把每一项和您的信件对照。点一下引用的文字，可以看到它出自哪里。';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '还要核对 $count 项才能继续',
      one: '还要核对 1 项才能继续',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => '继续整理佐证记录';

  @override
  String cnSeePage(int n) {
    return '查看第 $n 页';
  }

  @override
  String get cnWhatLetterIs => '这是一封什么信';

  @override
  String get cnLooksRight => '没错';

  @override
  String get cnChange => '更改';

  @override
  String get cnCardWhyDenied => '被拒绝的原因';

  @override
  String get cnCardWhatTheyNeed => '对方要求的内容';

  @override
  String get cnCardWhatItSays => '信里写了什么';

  @override
  String get cnNoReasonFound => '信中没有找到原因。';

  @override
  String get cnCardNextStep => '下一步';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '请医疗团队申请复核。信中列出了 $count 项需要寄送的内容。',
      one: '请医疗团队申请复核。信中列出了 1 项需要寄送的内容。',
      zero: '请医疗团队申请复核。信中没有列出具体项目。',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '请在下面的日期前，把保险计划要求的 $count 项内容寄给对方。',
      one: '请在下面的日期前，把保险计划要求的 1 项内容寄给对方。',
      zero: '请在下面的日期前，把保险计划要求的信息寄给对方。',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth => '请记下现有批准何时结束，并请医疗团队开始办理续期。';

  @override
  String get cnNextFinal =>
      '这是最终决定。CoverNote 不会为它起草首次复核申请。请向保险计划或您的医疗团队询问信中列出的其他选择。';

  @override
  String get cnNextEob => '这看起来是账单或福利说明，不是拒绝信。请向保险计划的会员服务部门核实。';

  @override
  String get cnNextUncertain => '请先在上方确认这是一封什么类型的信。';

  @override
  String cnWhereToSend(String route) {
    return '寄送方式：$route';
  }

  @override
  String cnWhoToCall(String contact) {
    return '联系方式：$contact';
  }

  @override
  String get cnCardDate => '需要留意的日期';

  @override
  String cnDateCalculated(String anchor, int days) {
    return '计算方式：$anchor + $days 个日历日';
  }

  @override
  String get cnReceivedDateWord => '您收到信件的日期';

  @override
  String get cnNoticeDateWord => '通知日期';

  @override
  String get cnDateEnteredByYou => '由您填写';

  @override
  String get cnDateFromLetter => '信中写明';

  @override
  String cnReceivedOn(String date) {
    return '您在 $date 收到';
  }

  @override
  String get cnDatePassed => '这个日期已经过了。请致电保险计划，询问您还能怎么做。';

  @override
  String cnNeedReceivedDate(int days) {
    return '信中写的是从您收到信的那天起 $days 个日历日。您是哪天收到的？';
  }

  @override
  String get cnEnterReceivedDate => '输入收到日期';

  @override
  String get cnDateConflict => '信中给出了不同的日期。请向保险计划询问以哪个为准，然后选择它。';

  @override
  String cnUseThisDate(String date) {
    return '使用 $date';
  }

  @override
  String get cnDateUnclear =>
      '信中的说法不清楚，或按工作日计算，所以 CoverNote 不做计算。请向保险计划询问确切日期。';

  @override
  String get cnNoDeadline => '信中没有找到复核期限。';

  @override
  String cnReplyBy(String date) {
    return '请在 $date 前回复信息要求（来自信件）';
  }

  @override
  String get cnEnterDatePlanGave => '输入日期';

  @override
  String get cnUseLetterDate => '使用信中的日期';

  @override
  String get cnLeaveUnknown => '暂时保持未知';

  @override
  String get cnDateUnknownChecked => '未知，已记下';

  @override
  String get cnTypeAsWritten => '请完全按信上写的输入。';

  @override
  String get cnCheckThisValue => '这个值看起来不太寻常。请和信件对照一下。';

  @override
  String get cnDone => '完成';

  @override
  String get cnEdit => '编辑';

  @override
  String get cnAdd => '添加';

  @override
  String get cnNoRecordsToLink => '最近 30 天没有可关联的记录。您仍然可以标记这一项在谁手上。';

  @override
  String cnLinkTitle(String label) {
    return '关联记录到：$label';
  }

  @override
  String get cnLinkNote => '您自己的记录可以支持这份申请，但不能代替诊所病历或检查结果。';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '计划用药 $scheduled 次：已用 $taken 次 / 未用 $notTaken 次 / 不确定 $unknown 次';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return '按需使用：$uses 次，$puffs 喷';
  }

  @override
  String get cnNoEntries => '没有记录';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return '$days 天有症状，$night 天夜里醒来（已记录的 $total 天中有 $entries 天有记录）';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return '$total 天中有 $days 天有 PM2.5 数据；$high 天 AQI 高于 100';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条自述',
      one: '1 条自述',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => '模拟数据';

  @override
  String get cnLetterAsksFor => '信里要求的内容';

  @override
  String get cnNoItemsListed => '信中没有列出具体项目。您可以添加自己的项目。';

  @override
  String get cnAddItemLabel => '添加要跟进的项目';

  @override
  String cnYourRecords(String from, String to) {
    return '您的记录（$from – $to）';
  }

  @override
  String get cnLocalContextNote => '仅供参考。这不是在您家中测得的数据，也不是症状的原因。';

  @override
  String get cnContinueToPacket => '继续生成资料包';

  @override
  String get cnAddedByYou => '由您添加';

  @override
  String get cnFromLetter => '来自信件';

  @override
  String cnWhoHasIt(String who) {
    return '在谁手上：$who';
  }

  @override
  String cnLinkedTo(String record) {
    return '已关联：$record';
  }

  @override
  String get cnSeeInLetter => '在信中查看';

  @override
  String get cnLinkRecords => '关联我的记录';

  @override
  String get cnOtherStatus => '其他状态';

  @override
  String get cnInPacket => '已放入资料包';

  @override
  String get cnRemoveFromPacket => '从资料包移除';

  @override
  String get cnAddToPacket => '加入资料包';

  @override
  String get cnErrNotSavedYet => '您最近的更改还没有保存。请检查网络后再试。';

  @override
  String get cnPacketChangedMeanwhile => '生成资料包期间，信息或记录发生了变化。请重新生成。';

  @override
  String get cnPacketFailed => '无法生成资料包。请再试一次。';

  @override
  String get cnBeforeSharingTitle => '分享之前';

  @override
  String get cnBeforeSharingBody =>
      '这个文件包含您的姓名和健康信息。请只分享给您的医疗团队或您的保险计划。分享并不会替您提交任何东西。';

  @override
  String get cnShare => '分享';

  @override
  String get cnMethodFax => '传真';

  @override
  String get cnMethodMail => '邮寄';

  @override
  String get cnMethodPortal => '在线门户网站';

  @override
  String get cnMethodInPerson => '当面递交';

  @override
  String get cnMethodCareTeam => '医疗团队已发送';

  @override
  String get cnMethodOther => '其他';

  @override
  String get cnPacketNoDraftFinal => '对于最终决定，资料包只包含医生摘要，不会生成第一级复核申请草稿。';

  @override
  String get cnPacketNoDraftEob => '对于账单或福利说明，资料包只包含医生摘要。';

  @override
  String get cnPacketNoDraftReauth => '对于续期通知，资料包只包含医生摘要，以帮助您的医疗团队办理续期。';

  @override
  String get cnPacketNoDraftOther => '除非信件是拒绝信或信息要求，否则资料包只包含医生摘要。';

  @override
  String get cnPacketContains => '此资料包将包含';

  @override
  String get cnPartSummary => '医生摘要（1 页）';

  @override
  String get cnPartDraft => '复核申请草稿（由您的医疗团队完成）';

  @override
  String get cnPartLetterText => '附录：信件文字';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已添加 $count 份记录摘要',
      one: '已添加 1 份记录摘要',
      zero: '未添加记录摘要',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => '把信件文字作为附录加入';

  @override
  String get cnPacketStale => '自上次生成资料包后，信息或记录发生了变化。请重新生成以更新。';

  @override
  String get cnGenerating => '正在生成…';

  @override
  String get cnGeneratePacket => '生成复核资料包';

  @override
  String get cnSaveOrPrint => '保存或打印';

  @override
  String get cnISentIt => '我已寄出';

  @override
  String cnSharedOn(String date) {
    return '分享于 $date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return '您报告已于 $date 寄出（$method）';
  }

  @override
  String get cnTabDoctorSummary => '医生摘要';

  @override
  String get cnTabReviewDraft => '复核申请草稿';

  @override
  String get cnSentExplain => '请记录寄出的时间和方式。CoverNote 不会代您寄出，也不会跟踪结果。';

  @override
  String get cnSave => '保存';

  @override
  String get cnCtxPm25 => 'PM2.5（AQI）';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => '室外湿度';

  @override
  String cnObservedOn(String date) {
    return '观测日期 $date';
  }

  @override
  String get cnCtxIntro =>
      '来自明确来源的空气读数，和您自己注意到的情况，分开记录。只有在有助于说明您的记录时，才把它们加入案件。';

  @override
  String get cnCtxReadings => '空气读数';

  @override
  String get cnCtxReadingsNote => '这是观测当天的地区读数，不能反映您家附近的车辆尾气。';

  @override
  String get cnCtxAddReading => '添加读数';

  @override
  String get cnCtxReports => '您注意到的情况';

  @override
  String get cnCtxReportsNote => '这是您自己的报告，不是测量数据。';

  @override
  String get cnCtxAddReport => '添加您注意到的情况';

  @override
  String get cnReportExhaust => '附近有浓重的尾气';

  @override
  String get cnReportWater => '家里进水';

  @override
  String get cnReportDamp => '室内有潮湿或霉味的地方';

  @override
  String cnOnDate(String date) {
    return '日期：$date';
  }

  @override
  String get cnNoteOptional => '备注（可选）';

  @override
  String get cnCtxWhat => '读数类型';

  @override
  String get cnCtxHumidityNote => '室外湿度是天气数据，不能说明您家里是否潮湿或有霉菌。';

  @override
  String get cnCtxValue => '数值';

  @override
  String get cnCtxValueInvalid => '请输入有效的数字。';

  @override
  String get cnCtxSource => '来源';

  @override
  String get cnCtxSourceHelp => '数字的出处，例如 AirNow 或当地监测站';

  @override
  String get cnCtxSourceRequired => '请填写来源。';

  @override
  String get cnCtxPlace => '地点（邮编或城镇，可选）';

  @override
  String get cnRecordsSignInBody => '登录后可保存用药、症状和当地情况记录。';

  @override
  String get cnRecordsYourRecords => '您的记录';

  @override
  String get cnRecMedicationSub => '您使用的药物和剂量';

  @override
  String get cnRecDailyLog => '每日记录';

  @override
  String get cnRecDailyLogSub => '症状和吸入器使用';

  @override
  String get cnRecLocalContextSub => '空气读数和您注意到的情况';

  @override
  String get cnHelp => '帮助';

  @override
  String get cnUrgentHelp => '紧急求助';

  @override
  String get cnUrgentHelpSub => '呼吸紧急情况的处理步骤和拨打 911';

  @override
  String cnLast30Days(String from, String to) {
    return '最近 30 天（$from – $to）';
  }

  @override
  String get cnNoSchedule => '未设置固定用药时间';

  @override
  String get cnRecordsUnknownNote => '没有记录的日子保持“未知”，不会被算作漏用。';

  @override
  String get cnDeleteAccountTitle => '要删除您的账号吗？';

  @override
  String get cnDeleteAccountBody => '这会永久删除您的账号、案件、上传的信件、资料包和记录，并且无法恢复。';

  @override
  String get cnTypeDelete => '输入 DELETE 以确认';

  @override
  String get cnDeleteAccount => '删除账号';

  @override
  String get cnAccountDeleted => '您的账号已删除。';

  @override
  String get cnDeleteAccountFailed => '无法删除账号。请稍后再试。';

  @override
  String get cnAccountSignedOut => '您尚未登录。';

  @override
  String get cnLanguage => '语言';

  @override
  String get cnServiceStatus => '信件读取服务';

  @override
  String get cnServiceReady => '可用';

  @override
  String get cnServiceUnavailableShort => '暂时不可用';

  @override
  String get cnChecking => '检查中…';

  @override
  String get cnServiceUnknown => '尚未检查';

  @override
  String get cnCheck => '检查';

  @override
  String get cnAbout => '关于';

  @override
  String get cnAboutBody =>
      'CoverNote 帮您读懂有关药物的保险信件，并为您的医疗团队准备文件。它不会向您的保险计划提交任何东西，不会决定是否承保，也不是医疗建议。';

  @override
  String get cnDangerZone => '删除账号';

  @override
  String get cnErrServiceUnavailable => '信件读取功能暂时不可用。';

  @override
  String get cnErrBusy => '服务正忙。请等一分钟后再试。';

  @override
  String get cnErrSlow => '读取用时太长。请再试一次。';

  @override
  String get cnErrUnreadable => '无法读取这些页面。请在光线更好的地方重拍。';

  @override
  String get cnErrTooManyPages => '页数太多。最多上传 10 页。';

  @override
  String get cnErrTooLarge => '文件太大。请减少页数，或使用更小的页面。';

  @override
  String get cnErrStale => '这个案件已在另一台设备上更改。现在显示的是最新版本。';

  @override
  String get cnErrCaseGone => '这个案件已不存在。';

  @override
  String get cnErrAttempts => '读取多次失败。请替换页面，或稍后再试。';

  @override
  String get cnErrDemoUpload => '示例无法读取文件。请登录后扫描您自己的信件。';

  @override
  String cnErrGeneric(String code) {
    return '出了点问题（$code）。请再试一次。';
  }

  @override
  String get cnLanguageChoose => '选择您的语言';

  @override
  String get cnLanguageNote => '部分文字由软件翻译，可能有错误。药物名称、剂量、日期和信中的引文都不会被翻译。';

  @override
  String get cnLanguageButtonTooltip => '更改语言';

  @override
  String get cnPacketEnglishNote => '资料包用英文撰写，方便您的医疗团队阅读。';

  @override
  String get cnReasonMissingInformation => '保险计划说它没有收到所需的全部信息。';

  @override
  String get cnReasonStepTherapy => '保险计划要求您先试用其他药物。';

  @override
  String get cnReasonMedicalNecessity => '保险计划说无法确认这种药在医学上是必需的。';

  @override
  String get cnReasonFormulary => '保险计划说这种药不在它的承保药物清单上。';

  @override
  String get cnReasonQuantityLimit => '保险计划说您申请的数量超出了它承保的范围。';

  @override
  String get cnReasonEligibility => '保险计划说按其承保规则，这项不在承保范围内。';

  @override
  String get cnReasonOther => '信中给出了其他原因。请打开信件引文阅读。';

  @override
  String get cnReqHintMedHistory => '您过去和现在使用的药物';

  @override
  String get cnReqHintVisitNotes => '您看诊时医生的记录';

  @override
  String get cnReqHintTestResults => '检查或化验结果';

  @override
  String get cnReqHintDoctorStatement => '医生出具的说明';
}

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginEmailLabel => '电子邮箱';

  @override
  String get loginPasswordLabel => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get signUpButton => '注册';

  @override
  String get medicationLogAddButton => '记录吸入器/药物使用';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguageLabel => '语言';

  @override
  String get mockContinue => '继续';

  @override
  String get mockUnlock => '解锁';

  @override
  String get mockUsePassword => '改用密码';

  @override
  String get mockHomeLocation => '家';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => '紧急联系人';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => '医疗人员邀请码';

  @override
  String get mockAllScreens => '所有页面';

  @override
  String get mockStateCalm => '平稳';

  @override
  String get mockStateWarning => '警告';

  @override
  String get mockForecast => '预报';

  @override
  String get mockShowWarningHome => '预览“警告”首页';

  @override
  String get mockBackToCalmHome => '返回';

  @override
  String get mockTrapAxis => 'TRAP／烟尘';

  @override
  String get mockFloodAxis => '山洪暴发';

  @override
  String get mockPollenAxis => '花粉';

  @override
  String get mockActSurvey => 'ACT 问卷';

  @override
  String get mockActHint => '5 个图示问题（过去 4 周）';

  @override
  String get mockPdcCheck => '每日 PDC 检查';

  @override
  String get mockPdcHint => '一键记录用药';

  @override
  String get mockInhalerEvent => '已记录吸入器使用';

  @override
  String get mockQuestion => '问题';

  @override
  String get mockSubmit => '提交';

  @override
  String get mockPdcPrompt => '您今天用了控制类药物吗？';

  @override
  String get mockTakenYes => '是，我用了';

  @override
  String get mockTakenNo => '今天没用';

  @override
  String get mockActScore => '最近一次 ACT';

  @override
  String get mockPdcRate => 'PDC（30 天）';

  @override
  String get mockLocationsTitle => '已保存的地点';

  @override
  String get mockLocationsHint => '家和工作地点监测';

  @override
  String get mockWorkLocation => '工作地点';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => '添加地点';

  @override
  String get mockDraftBanner => '草稿——积分和代金券仅供预览';

  @override
  String get mockPointsBalance => '积分余额';

  @override
  String get mockVoucherTitle => '食物银行代金券';

  @override
  String get mockDonateTitle => '捐款';

  @override
  String get mockDonateHint => '仅限通过第三方捐款';

  @override
  String get mockRewardHistory => '历史记录';

  @override
  String get mockRewardHistoryHint => '积分和捐款';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank（演示）';

  @override
  String get mockVoucherCost => '50 积分 · 价值 \$10（草稿）';

  @override
  String get mockJoinWaitlist => '加入候补名单';

  @override
  String get mockDonateTransparency =>
      '捐款通过经过验证的第三方非营利平台办理。Howse Asthma 从不保存银行卡信息。';

  @override
  String get mockDonateCta => '打开捐款页面（外部）';

  @override
  String get mockExternalOnly => '设计预览中未接入外部捐款服务。';

  @override
  String get mockSignOutPreview => '退出登录（预览）';

  @override
  String get mockDismiss => '关闭';

  @override
  String get mockPanicStep1Body => '第 1 步——请把吸入器带在身边。点“继续”查看紧急联系人。';

  @override
  String get mockPanicStep2Title => '呼叫求助';

  @override
  String get mockPanicStep2Body =>
      '设计预览：这些按钮不会真的拨打电话。在手机应用版本中，第 2 步使用 tel: 链接。';

  @override
  String get mockCall911 => '拨打 911';

  @override
  String get mockCallGuardian => '呼叫紧急联系人';

  @override
  String get mockFeelingBetter => '我感觉好些了';

  @override
  String get mockTabHome => '首页';

  @override
  String get mockTabLog => '记录';

  @override
  String get mockTabReport => '报告';

  @override
  String get mockTabReward => '奖励';

  @override
  String get mockTabSettings => '设置';

  @override
  String get authChooseRole => '请选择您的身份';

  @override
  String get authRolePatient => '患者';

  @override
  String get authRoleProvider => '医疗人员';

  @override
  String get authFullNameLabel => '姓名';

  @override
  String get authNpiLabel => 'NPI 号码';

  @override
  String get authNpiHelper => '10 位国家医疗服务提供者标识码';

  @override
  String get authOrContinueWith => '或使用以下方式继续';

  @override
  String get authContinueGoogle => '使用 Google 继续';

  @override
  String get authContinueApple => '使用 Apple 继续';

  @override
  String get authSignOut => '退出登录';

  @override
  String get authRetry => '重试';

  @override
  String get authWorking => '处理中…';

  @override
  String get authErrorGeneric => '出了点问题，请再试一次。';

  @override
  String get authBiometricTitle => '解锁 Howse Asthma';

  @override
  String get authBiometricHint => '使用生物识别继续';

  @override
  String get authBiometricReason => '解锁 Howse Asthma';

  @override
  String get authBiometricToggle => '生物识别解锁';

  @override
  String get authBiometricToggleHint => '打开应用时需要生物识别解锁';

  @override
  String get authBiometricUnavailable => '此设备不支持生物识别';

  @override
  String get authOnboardingTitle => '患者设置';

  @override
  String get authOnboardingSkip => '暂时跳过';

  @override
  String get authInviteCodeLabel => '医疗人员邀请码';

  @override
  String get authInviteCodeHelper => '8 位字母或数字，24 小时后失效';

  @override
  String get authInviteIssueFailed => '无法生成邀请码';

  @override
  String get authConfirmLink => '确认';

  @override
  String get authRejectLink => '拒绝';

  @override
  String get authLinkStatusPending => '等待确认';

  @override
  String get providerHomeTab => '首页';

  @override
  String get providerLinkTab => '关联';

  @override
  String get providerHomeTitle => '医疗人员首页';

  @override
  String providerHomeWelcome(String email) {
    return '已登录账号：$email';
  }

  @override
  String get providerHomePlaceholder => '患者临床看板将在后续版本中推出。请先关联患者。';

  @override
  String get providerLinkPatientsCta => '关联患者';

  @override
  String get providerLinkTitle => '关联患者';

  @override
  String get providerLinkIntro => '生成一个 8 位邀请码（24 小时内有效）。患者输入后，双方再各自确认。';

  @override
  String get providerIssueInviteCta => '生成邀请码';

  @override
  String get providerInviteTtlHint => '24 小时内有效';

  @override
  String get providerInviteCopied => '邀请码已复制';

  @override
  String get providerPendingLinks => '待确认的关联';

  @override
  String get providerNoPendingLinks => '没有待确认的关联';

  @override
  String providerPendingPatient(String idPrefix) {
    return '患者 $idPrefix…';
  }

  @override
  String get providerRecentInvites => '最近的邀请码';

  @override
  String get providerNoInvites => '还没有邀请码';

  @override
  String get providerInviteConsumed => '已使用';

  @override
  String get providerInviteActive => '有效';

  @override
  String get splashTagline => '帮您挡住诱发因素的智能防护盾';

  @override
  String get splashGetStarted => '开始使用';

  @override
  String get splashAlreadyHaveAccount => '已有账号？';

  @override
  String get splashSignIn => '登录';

  @override
  String get authForgotPassword => '忘记密码？';

  @override
  String get authNoAccount => '还没有账号？';

  @override
  String get authUseBiometricHint => '使用 Face ID 或指纹解锁';

  @override
  String get authTouchSensorHint => '触摸传感器或看向摄像头';

  @override
  String get mockChooseLanguage => '选择语言';

  @override
  String get mockYourLocation => '您的位置';

  @override
  String get mockUseCurrentLocation => '使用当前位置';

  @override
  String get mockLocationTrapOnly => '位置仅用于获取 TRAP 空气质量数据';

  @override
  String get mockLabelYourPlace => '给这个地点命名';

  @override
  String get mockSchool => '学校';

  @override
  String get mockWork => '工作地点';

  @override
  String get mockOther => '其他';

  @override
  String get mockEmergencyOnePerson => '紧急情况下可联系的一个人';

  @override
  String get mockContactName => '联系人姓名';

  @override
  String get mockPhoneNumber => '电话号码';

  @override
  String get mockProviderPairing => '与医疗人员配对';

  @override
  String get mockPairingOptional => '可选——以后也可以在“设置”中添加';

  @override
  String get mockNext => '下一步';

  @override
  String get mockProfessionalProfile => '专业资料';

  @override
  String get mockStep2Of4 => '第 2 步，共 4 步';

  @override
  String get mockTellPractice => '请介绍一下您的诊所';

  @override
  String get mockSpecialtyLabel => '专科';

  @override
  String get mockClinicLabel => '诊所/机构名称';

  @override
  String get mockNpiFormatOnly => '仅检查格式。提交后才会核实 NPI。';

  @override
  String get mockCredentialsSecure => '您的资质信息已加密并安全保存。未经您同意，我们不会分享医疗人员的数据。';

  @override
  String get actPast4Weeks => '过去 4 周内';

  @override
  String get actQ1 => '您的哮喘在多长时间里妨碍了您在工作、学校或家里做事？';

  @override
  String get actQ2 => '您多久出现一次气短？';

  @override
  String get actQ3 => '哮喘症状多久会让您夜里醒来，或比平时早醒一次？';

  @override
  String get actQ4 => '您多久使用一次急救吸入器或雾化药物？';

  @override
  String get actQ5 => '您觉得自己的哮喘控制得怎么样？';

  @override
  String get actOpt1 => '一直如此';

  @override
  String get actOpt2 => '大部分时间';

  @override
  String get actOpt3 => '有些时候';

  @override
  String get actOpt4 => '偶尔';

  @override
  String get actOpt5 => '从未';

  @override
  String get actQ5Opt1 => '完全没有控制';

  @override
  String get actQ5Opt2 => '控制得很差';

  @override
  String get actQ5Opt3 => '控制得一般';

  @override
  String get actQ5Opt4 => '控制得很好';

  @override
  String get actQ5Opt5 => '完全控制';

  @override
  String get panicNoAutoDial => '按钮会打开手机拨号界面。不会自动拨出电话。';

  @override
  String panicCallNamed(String name) {
    return '呼叫 $name';
  }

  @override
  String get panicDialFailed => '无法在此设备上打开拨号界面。';

  @override
  String get s5ActNotice => '您的回答已保存，可以分享给您的医生。这份问卷的版本尚未按官方评分方法核对，所以应用不显示分数。';

  @override
  String get s5ActSaved => '您的回答已保存。';

  @override
  String get s5ActSubtitle => '关于过去 4 周的 5 个问题';

  @override
  String get s5ActTitle => '哮喘控制问卷';

  @override
  String get s5AddDetails => '添加详情';

  @override
  String get s5AddRecord => '添加记录';

  @override
  String get s5Back => '返回';

  @override
  String get s5Cancel => '取消';

  @override
  String get s5Change => '更改';

  @override
  String get s5Delete => '删除';

  @override
  String get s5DeleteConfirm => '要删除这条记录吗？';

  @override
  String get s5DeleteFailed => '无法删除，请再试一次。';

  @override
  String get s5Edit => '编辑';

  @override
  String get s5EntryRemoved => '记录已删除。';

  @override
  String get s5FieldDate => '日期';

  @override
  String get s5FieldMedication => '药物';

  @override
  String get s5FieldNote => '备注（可选）';

  @override
  String get s5FieldPuffs => '喷数（可选）';

  @override
  String get s5FieldReason => '原因（可选）';

  @override
  String get s5FieldTime => '时间';

  @override
  String get s5FilterAll => '全部';

  @override
  String get s5FilterInhaler => '吸入器';

  @override
  String get s5FilterMedCheck => '用药确认';

  @override
  String get s5FilterSymptoms => '症状';

  @override
  String get s5FromUrgentHelp => '从“紧急求助”记录';

  @override
  String get s5InhalerEditTitle => '吸入器使用详情';

  @override
  String get s5InhalerEntry => '吸入器使用';

  @override
  String get s5InhalerLogged => '已记录吸入器使用。';

  @override
  String get s5InhalerOneEntryHint => '每保存一次就是一条吸入器使用记录。它不会被算作一喷或一天。';

  @override
  String s5InhalerUnknownCount(int n) {
    return '未确定药物：$n';
  }

  @override
  String get s5Last30Days => '最近 30 天';

  @override
  String get s5Last7Days => '最近 7 天';

  @override
  String get s5LogInhaler => '记录吸入器使用';

  @override
  String get s5LogLegend => '每一行是一条已保存的记录。没有记录的日子显示为“未记录”，这和“零”不一样。';

  @override
  String get s5LogSymptoms => '记录症状';

  @override
  String get s5MedAdd => '添加药物';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return '已用药天数：$a · 未用药：$b · 不记得：$c · 未记录：$d';
  }

  @override
  String get s5MedCheckIntro => '这是您自己报告的用药情况确认，不是根据药房记录得出的。';

  @override
  String get s5MedCheckQuestion => '您按计划用药了吗？';

  @override
  String get s5MedCheckTitle => '今日用药确认';

  @override
  String get s5MedChooseHint => '请选择一种药物，或选“我不知道药物名称”。';

  @override
  String get s5MedDailyCheck => '每日确认';

  @override
  String get s5MedDailyCheckHint => '在首页显示“今日用药确认”。只有在医生要求您每天使用这种药时才打开。';

  @override
  String get s5MedDefault => '快速记录的默认药物';

  @override
  String get s5MedDefaultHint => '在首页点“记录吸入器使用”时会用这个药物。';

  @override
  String get s5MedEdit => '编辑药物';

  @override
  String get s5MedNameLabel => '药物名称（与药品标签一致）';

  @override
  String get s5MedNotApplicable => '今天没有安排';

  @override
  String s5MedNotApplicableDays(int n) {
    return '未安排：$n 天';
  }

  @override
  String get s5MedNotRecorded => '未记录药物';

  @override
  String get s5MedNotSure => '我不记得了';

  @override
  String get s5MedNotUsed => '我没有用';

  @override
  String get s5MedOther => '其他名称';

  @override
  String get s5MedOtherHint => '输入药物名称';

  @override
  String get s5MedReasonCost => '费用';

  @override
  String get s5MedReasonForgot => '忘记了';

  @override
  String get s5MedReasonNoMedicine => '手边没有这种药';

  @override
  String get s5MedReasonQuestion => '原因（可选）';

  @override
  String get s5MedUnknown => '我不知道药物名称';

  @override
  String get s5MedUnknownShort => '未确定药物';

  @override
  String get s5MedUsed => '我用了';

  @override
  String get s5MyLogTitle => '我的记录';

  @override
  String get s5MyMedsEmpty => '还没有保存任何药物。';

  @override
  String get s5MyMedsHint => '这里是您确认过的药物名称，方便更快地记录。这不是用药剂量建议。';

  @override
  String get s5MyMedsTitle => '我的药物';

  @override
  String get s5NoAnswer => '不想回答';

  @override
  String get s5NoRecordsYet => '还没有记录';

  @override
  String s5NoSymptomDays(int n) {
    return '标记为“无症状”的天数：$n';
  }

  @override
  String get s5NotRecorded => '未记录';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return '时间段：$days 天 · 有记录的天数：$n';
  }

  @override
  String s5PuffsValue(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 喷',
      one: '1 喷',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return '第 $n 题，共 $total 题';
  }

  @override
  String get s5ReasonBeforeActivity => '活动前';

  @override
  String get s5ReasonOther => '其他';

  @override
  String get s5ReasonSymptoms => '因为有症状';

  @override
  String s5RecentInhaler(int n) {
    return '吸入器使用记录：$n 条';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return '有症状的天数：$n';
  }

  @override
  String get s5RecordsLoadFailed => '无法加载您的记录，请再试一次。';

  @override
  String get s5Save => '保存';

  @override
  String get s5Saved => '已保存。';

  @override
  String get s5SaveFailed => '无法保存。您填写的内容还在。';

  @override
  String get s5SymActivityLimited => '活动受限';

  @override
  String get s5SymCough => '咳嗽';

  @override
  String get s5SymNightWaking => '夜里醒来';

  @override
  String get s5SymNone => '没有症状';

  @override
  String get s5SymOther => '其他情况';

  @override
  String get s5SymOtherHint => '用您自己的话描述';

  @override
  String get s5SymShortBreath => '呼吸困难';

  @override
  String get s5SymWheeze => '喘鸣';

  @override
  String get s5SymptomEditTitle => '编辑症状';

  @override
  String get s5SymptomEntry => '症状';

  @override
  String get s5SymptomNoneHint => '您没有记录的日子会显示为“未记录”，而不是“无症状”。';

  @override
  String get s5SymptomQuestion => '您注意到了什么？';

  @override
  String get s5Today => '今天';

  @override
  String get s5Undo => '撤销';

  @override
  String get s5UrgentActionPlan => '如果医生给了您哮喘行动计划，请按计划做。';

  @override
  String get s5UrgentHelp => '紧急求助';

  @override
  String get s5UrgentIntro => '如果呼吸非常困难或没有好转，请拨打 911。';

  @override
  String get s5UrgentLogHint => '可选：保存一条您使用了吸入器的记录。';

  @override
  String get s5UrgentNoContact => '还没有紧急联系人。请在“设置”→“帮助”中添加。';

  @override
  String get s6AddTime => '添加时间';

  @override
  String get s6DoseLater => '稍后确认';

  @override
  String get s6DoseNotUsed => '我没法用';

  @override
  String get s6DoseUsed => '我用了';

  @override
  String get s6HomeWaterNo => '没有';

  @override
  String get s6HomeWaterQuestion => '家里有漏水或进水吗？';

  @override
  String get s6HomeWaterYes => '有';

  @override
  String get s6OccurredLabel => '发生时间';

  @override
  String get s6PuffsEach => '每次喷数';

  @override
  String s6ReminderBodyNamed(String name) {
    return '该确认 $name 了';
  }

  @override
  String get s6ReminderBodyPrivate => '该确认您的药了';

  @override
  String get s6ReminderChannel => '在您保存的用药时间提醒。不是 30 分钟提醒。';

  @override
  String get s6ReminderTitle => '用药确认';

  @override
  String get s6RoleBoth => '每天用，也按需用';

  @override
  String get s6RoleController => '每日用药';

  @override
  String get s6RoleRescue => '按需使用';

  @override
  String get s6ScheduleTimes => '您的用药时间';

  @override
  String get cnTagline => '保险信件，清楚的下一步';

  @override
  String get cnDemoBadge => '示例';

  @override
  String get cnDemoBadgeLong => '示例使用虚构数据，结果是固定的。';

  @override
  String get cnAuthSignInTitle => '登录';

  @override
  String get cnAuthCreateTitle => '创建账号';

  @override
  String get cnAuthResetTitle => '重设密码';

  @override
  String get cnAuthSignIn => '登录';

  @override
  String get cnAuthCreate => '创建账号';

  @override
  String get cnAuthSendReset => '发送重设链接';

  @override
  String cnAuthProfileError(String code) {
    return '您已登录，但无法加载您的账号（$code）。';
  }

  @override
  String get cnRetry => '再试一次';

  @override
  String get cnSignOut => '退出登录';

  @override
  String get cnAuthPreparingAccount => '正在设置您的账号…';

  @override
  String get cnAuthNameLabel => '姓名（可选）';

  @override
  String get cnAuthNameHelper => '会显示在您的资料包上。以后可以修改。';

  @override
  String get cnAuthEmailLabel => '电子邮箱';

  @override
  String get cnAuthPasswordLabel => '密码';

  @override
  String get cnAuthPasswordHelper => '至少 8 个字符';

  @override
  String get cnAuthShowPassword => '显示密码';

  @override
  String get cnAuthHidePassword => '隐藏密码';

  @override
  String get cnAuthPasswordRequired => '请输入密码';

  @override
  String cnAuthCheckEmail(String email) {
    return '我们已向 $email 发送了确认链接。请在这部手机上打开链接，然后登录。';
  }

  @override
  String cnAuthResetSent(String email) {
    return '如果 $email 对应的账号存在，重设链接已在发送途中。请在这部手机上打开链接。';
  }

  @override
  String get cnAuthResent => '已再次发送。';

  @override
  String get cnAuthResend => '重新发送邮件';

  @override
  String get cnAuthSignInInstead => '我已确认，去登录';

  @override
  String get cnAuthForgot => '忘记密码？';

  @override
  String get cnAuthNoAccount => '第一次使用？创建账号';

  @override
  String get cnAuthHaveAccount => '已有账号？登录';

  @override
  String get cnAuthResetHint => '输入您的电子邮箱，我们会发送一个设置新密码的链接。';

  @override
  String get cnAuthBackToSignIn => '返回登录';

  @override
  String get cnAuthPrivacyLine => '您的信件和记录只有您的账号能看到。';

  @override
  String get cnAuthPasswordUpdated => '密码已更新。';

  @override
  String get cnAuthNewPasswordTitle => '设置新密码';

  @override
  String get cnAuthNewPasswordLabel => '新密码';

  @override
  String get cnAuthSavePassword => '保存密码';

  @override
  String get cnLater => '以后再说';

  @override
  String get cnAuthErrInvalidCredentials => '电子邮箱或密码不正确。';

  @override
  String get cnAuthErrNotConfirmed => '请先确认您的电子邮箱。请查看收件箱，或重新发送链接。';

  @override
  String get cnAuthErrExists => '这个电子邮箱已有账号。请直接登录。';

  @override
  String get cnAuthErrWeakPassword => '请设置更安全的密码（至少 8 个字符）。';

  @override
  String get cnAuthErrSamePassword => '新密码不能和旧密码相同。';

  @override
  String get cnAuthErrRateLimited => '尝试次数太多。请等一分钟后再试。';

  @override
  String get cnAuthErrInvalidEmail => '请检查电子邮箱地址。';

  @override
  String get cnAuthErrEmailNotAuthorized => '我们现在无法向这个地址发送邮件。请稍后再试。';

  @override
  String get cnAuthErrDisabled => '这种登录方式已关闭。';

  @override
  String get cnAuthErrSessionExpired => '您的登录已过期，请重新登录。';

  @override
  String cnAuthErrUnknown(String code) {
    return '出了点问题（$code）。请再试一次。';
  }

  @override
  String get cnErrNetwork => '没有网络连接。请检查网络后再试。';

  @override
  String get cnErrServiceDown => '服务没有响应。请几分钟后再试。';

  @override
  String get cnTabHome => '首页';

  @override
  String get cnTabCases => '案件';

  @override
  String get cnTabRecords => '记录';

  @override
  String get cnTabAccount => '账号';

  @override
  String get cnHomeHeadline => '帮您读懂保险信件。';

  @override
  String get cnScanLetter => '扫描信件';

  @override
  String get cnUploadFile => '上传 PDF／照片';

  @override
  String get cnTryDemo => '试用示例';

  @override
  String get cnHomeSignInLine => '保存您的案件需要账号。';

  @override
  String get cnServiceNotConfigured => '此版本未连接到服务器，只能使用示例。';

  @override
  String get cnContinueCase => '继续处理您的案件';

  @override
  String get cnHowItWorks => '使用方法';

  @override
  String get cnStep1Title => '读信';

  @override
  String get cnStep1Body => '拍一张照片。我们会找出原因、下一步和日期。';

  @override
  String get cnStep2Title => '整理记录';

  @override
  String get cnStep2Body => '把信里要求的内容和您自己的记录对应起来。';

  @override
  String get cnStep3Title => '生成资料包';

  @override
  String get cnStep3Body => '得到一页纸的医生摘要和复核申请草稿。';

  @override
  String get cnRecentCases => '其他案件';

  @override
  String get cnNoCasesYet => '还没有案件';

  @override
  String get cnNoOtherCases => '没有其他案件。';

  @override
  String get cnSeeAllCases => '查看所有案件';

  @override
  String get cnNoCasesBody => '扫描一封保险信件就可以开始。';

  @override
  String get cnCasesSignInTitle => '登录后查看您的案件';

  @override
  String get cnCasesSignInBody => '或者打开示例，看看它是怎么用的。';

  @override
  String get cnCaseDeleted => '案件已删除。';

  @override
  String get cnCaseUntitled => '保险信件';

  @override
  String get cnStatusReading => '正在读信';

  @override
  String get cnStatusNeedsReview => '需要核对';

  @override
  String get cnStatusGatherRecords => '整理记录';

  @override
  String get cnStatusPacketReady => '资料包已备好';

  @override
  String get cnStatusNeedsAttention => '需要留意';

  @override
  String get cnStatusNotStarted => '未开始';

  @override
  String get cnNextWaitReading => '我们正在读这封信。';

  @override
  String get cnNextTryAgain => '读取已中断。请打开案件再试一次。';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 项信息待确认',
      one: '1 项信息待确认',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return '要求的 $total 项中已处理 $done 项';
  }

  @override
  String get cnNextSharePacket => '资料包已备好，可以分享';

  @override
  String get cnNextCreatePacket => '下一步：生成资料包';

  @override
  String cnDateToCheckShort(String date) {
    return '需要留意的日期：$date';
  }

  @override
  String cnDatePassedShort(String date) {
    return '日期已过：$date';
  }

  @override
  String get cnMoreActions => '更多操作';

  @override
  String get cnDeleteCase => '删除案件';

  @override
  String get cnDeleteCaseTitle => '要删除这个案件吗？';

  @override
  String get cnDeleteCaseBody => '这会删除信件页面、从中读取的信息、关联的记录摘要和资料包。您的用药和症状记录会保留。';

  @override
  String get cnCancel => '取消';

  @override
  String get cnDelete => '删除';

  @override
  String get cnDeleteFailed => '无法删除。请检查网络后再试。';

  @override
  String get cnKindInitialDenial => '药物承保拒绝（Denial）';

  @override
  String get cnKindInfoRequest => '要求补充信息';

  @override
  String get cnKindReauth => '续期（重新授权）通知';

  @override
  String get cnKindFinalDenial => '最终申诉决定（Appeal）';

  @override
  String get cnKindEob => '账单或福利说明（EOB）';

  @override
  String get cnKindOther => '其他信件';

  @override
  String get cnKindUncertain => '信件类型不明确';

  @override
  String get cnFieldPatientName => '患者姓名';

  @override
  String get cnFieldPlanName => '保险计划';

  @override
  String get cnFieldMemberId => '会员编号';

  @override
  String get cnFieldCaseReference => '案件或参考编号';

  @override
  String get cnFieldMedication => '药物（按原文）';

  @override
  String get cnFieldDose => '剂量（按原文）';

  @override
  String get cnFieldNoticeDate => '通知日期';

  @override
  String get cnFieldContact => '联系方式';

  @override
  String get cnFieldSubmissionRoute => '寄送方式';

  @override
  String get cnFactEdited => '您已修改';

  @override
  String get cnFactChecked => '已核对';

  @override
  String get cnFactNotInLetter => '信中没有';

  @override
  String get cnFactNeedsCheck => '需要核对';

  @override
  String get cnFactFromLetter => '来自信件';

  @override
  String get cnWhoYou => '您';

  @override
  String get cnWhoCareTeam => '医疗团队';

  @override
  String get cnWhoPlan => '保险计划';

  @override
  String get cnWhoUnknown => '不确定';

  @override
  String get cnReqLinked => '已关联';

  @override
  String get cnReqAskedCareTeam => '已询问医疗团队';

  @override
  String get cnReqNotAvailable => '没有';

  @override
  String get cnReqNotNeeded => '不需要';

  @override
  String get cnReqNeeded => '需要';

  @override
  String get cnReqReset => '标为需要';

  @override
  String get cnRecMedication => '用药史';

  @override
  String get cnRecSymptoms => '症状记录';

  @override
  String get cnRecLocalContext => '当地情况';

  @override
  String get cnRecPrn => '按需使用的吸入器';

  @override
  String get cnDemoTitle => '示例';

  @override
  String get cnDemoReset => '重置示例';

  @override
  String get cnDemoResetDone => '示例已重置。';

  @override
  String get cnDemoIntro => '三封虚构的信件，结果是固定的，方便您看清每一步。不会上传任何内容。';

  @override
  String get cnUpEmpty => '这个文件是空的。';

  @override
  String cnUpTooLarge(int mb) {
    return '每个文件不能超过 $mb MB。';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return '所有页面加起来不能超过 $mb MB。';
  }

  @override
  String cnUpTooManyPages(int max) {
    return '每封信最多 $max 页。';
  }

  @override
  String get cnUpUnsupported => '请使用 JPG、PNG 或 PDF。HEIC 照片请在这里重新拍一张。';

  @override
  String get cnUpBadFile => '无法读取这个文件。请换一张照片或 PDF 试试。';

  @override
  String get cnUpEncrypted => '这个 PDF 有密码保护。请保存一份未加密的副本，或者拍照。';

  @override
  String get cnCameraUnavailable => '无法使用相机。您可以改为上传照片或 PDF。';

  @override
  String get cnPhotosUnavailable => '无法打开照片。请在设置中允许访问照片，或上传 PDF。';

  @override
  String get cnFilesUnavailable => '现在无法打开文件。请再试一次。';

  @override
  String get cnUploadFailed => '上传没有完成。您的页面还在。请再试一次。';

  @override
  String get cnCaptureTitle => '添加信件页面';

  @override
  String get cnReplacePagesTitle => '替换信件页面';

  @override
  String get cnOpening => '正在打开…';

  @override
  String get cnCaptureEmptyTitle => '添加您信件的各页';

  @override
  String get cnCaptureTips => '把信纸平放在光线好的地方，让四个角都在取景框内。请按顺序添加每一页。';

  @override
  String get cnTakePhoto => '拍照';

  @override
  String get cnAddPage => '添加页面';

  @override
  String get cnAddPhoto => '照片';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages 页',
      one: '1 页',
    );
    return '$_temp0 · $size MB';
  }

  @override
  String get cnUploadConsent =>
      '上传会把这些页面发送到 CoverNote 服务器，由 AI 服务为您读取。您可以随时删除案件。';

  @override
  String get cnStageUploading => '上传中';

  @override
  String get cnUploadAndRead => '上传并读取';

  @override
  String cnPageN(int n) {
    return '第 $n 页';
  }

  @override
  String cnPdfPages(int n, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 页',
      one: '1 页',
    );
    return '文件 $n · PDF，$_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return '预览第 $n 页';
  }

  @override
  String get cnRotate => '旋转';

  @override
  String get cnRetake => '重拍';

  @override
  String get cnRemovePage => '移除';

  @override
  String get cnReorder => '拖动可调整顺序';

  @override
  String get cnServiceUnavailableBody => '信件读取功能现在还没有设置好。您的页面已保存，请稍后再试。';

  @override
  String get cnNeedNewPagesBody => '请拍更清楚的照片，或减少页数，然后重新上传。';

  @override
  String get cnPagesKept => '您的页面已保存，没有任何改动。';

  @override
  String get cnReplacePages => '替换页面';

  @override
  String get cnTryAgain => '再试一次';

  @override
  String get cnStageReading => '读取中';

  @override
  String get cnStageChecking => '检查中';

  @override
  String get cnStageReady => '已完成';

  @override
  String get cnReadingTitle => '正在读您的信';

  @override
  String get cnReadingBody => '读完后，请您把我们找到的内容和信件对照核对。';

  @override
  String get cnReadingLeaveOk => '您可以离开这个页面。读取会继续，您的案件已保存。';

  @override
  String get cnStartReading => '开始读取';

  @override
  String get cnStepLetter => '信件';

  @override
  String get cnStepReview => '核对';

  @override
  String get cnStepEvidence => '佐证记录';

  @override
  String get cnStepPacket => '资料包';

  @override
  String cnStepOf(int n, int total, String name) {
    return '第 $n 步，共 $total 步：$name';
  }

  @override
  String get cnSaving => '正在保存…';

  @override
  String get cnSaved => '已保存';

  @override
  String get cnNotSavedRetry => '未保存 · 重试';

  @override
  String get cnViewOriginal => '查看原始页面';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已读取 $count 页',
      one: '已读取 1 页',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return '难以辨认：第 $list 页。请仔细核对这些信息，或重拍这些页面。';
  }

  @override
  String get cnRetakePages => '重拍页面';

  @override
  String get cnHardToRead => '难以辨认';

  @override
  String get cnContinueToReview => '继续核对';

  @override
  String get cnOriginalPages => '原始页面';

  @override
  String get cnNoOriginal => '没有保存原始页面。';

  @override
  String get cnCheckDetails => '核对详细信息';

  @override
  String get cnCheckDetailsHint => '请把每一项和您的信件对照。点一下引用的文字，可以看到它出自哪里。';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '还要核对 $count 项才能继续',
      one: '还要核对 1 项才能继续',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => '继续整理佐证记录';

  @override
  String cnSeePage(int n) {
    return '查看第 $n 页';
  }

  @override
  String get cnWhatLetterIs => '这是一封什么信';

  @override
  String get cnLooksRight => '没错';

  @override
  String get cnChange => '更改';

  @override
  String get cnCardWhyDenied => '被拒绝的原因';

  @override
  String get cnCardWhatTheyNeed => '对方要求的内容';

  @override
  String get cnCardWhatItSays => '信里写了什么';

  @override
  String get cnNoReasonFound => '信中没有找到原因。';

  @override
  String get cnCardNextStep => '下一步';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '请医疗团队申请复核。信中列出了 $count 项需要寄送的内容。',
      one: '请医疗团队申请复核。信中列出了 1 项需要寄送的内容。',
      zero: '请医疗团队申请复核。信中没有列出具体项目。',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '请在下面的日期前，把保险计划要求的 $count 项内容寄给对方。',
      one: '请在下面的日期前，把保险计划要求的 1 项内容寄给对方。',
      zero: '请在下面的日期前，把保险计划要求的信息寄给对方。',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth => '请记下现有批准何时结束，并请医疗团队开始办理续期。';

  @override
  String get cnNextFinal =>
      '这是最终决定。CoverNote 不会为它起草首次复核申请。请向保险计划或您的医疗团队询问信中列出的其他选择。';

  @override
  String get cnNextEob => '这看起来是账单或福利说明，不是拒绝信。请向保险计划的会员服务部门核实。';

  @override
  String get cnNextUncertain => '请先在上方确认这是一封什么类型的信。';

  @override
  String cnWhereToSend(String route) {
    return '寄送方式：$route';
  }

  @override
  String cnWhoToCall(String contact) {
    return '联系方式：$contact';
  }

  @override
  String get cnCardDate => '需要留意的日期';

  @override
  String cnDateCalculated(String anchor, int days) {
    return '计算方式：$anchor + $days 个日历日';
  }

  @override
  String get cnReceivedDateWord => '您收到信件的日期';

  @override
  String get cnNoticeDateWord => '通知日期';

  @override
  String get cnDateEnteredByYou => '由您填写';

  @override
  String get cnDateFromLetter => '信中写明';

  @override
  String cnReceivedOn(String date) {
    return '您在 $date 收到';
  }

  @override
  String get cnDatePassed => '这个日期已经过了。请致电保险计划，询问您还能怎么做。';

  @override
  String cnNeedReceivedDate(int days) {
    return '信中写的是从您收到信的那天起 $days 个日历日。您是哪天收到的？';
  }

  @override
  String get cnEnterReceivedDate => '输入收到日期';

  @override
  String get cnDateConflict => '信中给出了不同的日期。请向保险计划询问以哪个为准，然后选择它。';

  @override
  String cnUseThisDate(String date) {
    return '使用 $date';
  }

  @override
  String get cnDateUnclear =>
      '信中的说法不清楚，或按工作日计算，所以 CoverNote 不做计算。请向保险计划询问确切日期。';

  @override
  String get cnNoDeadline => '信中没有找到复核期限。';

  @override
  String cnReplyBy(String date) {
    return '请在 $date 前回复信息要求（来自信件）';
  }

  @override
  String get cnEnterDatePlanGave => '输入日期';

  @override
  String get cnUseLetterDate => '使用信中的日期';

  @override
  String get cnLeaveUnknown => '暂时保持未知';

  @override
  String get cnDateUnknownChecked => '未知，已记下';

  @override
  String get cnTypeAsWritten => '请完全按信上写的输入。';

  @override
  String get cnCheckThisValue => '这个值看起来不太寻常。请和信件对照一下。';

  @override
  String get cnDone => '完成';

  @override
  String get cnEdit => '编辑';

  @override
  String get cnAdd => '添加';

  @override
  String get cnNoRecordsToLink => '最近 30 天没有可关联的记录。您仍然可以标记这一项在谁手上。';

  @override
  String cnLinkTitle(String label) {
    return '关联记录到：$label';
  }

  @override
  String get cnLinkNote => '您自己的记录可以支持这份申请，但不能代替诊所病历或检查结果。';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '计划用药 $scheduled 次：已用 $taken 次 / 未用 $notTaken 次 / 不确定 $unknown 次';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return '按需使用：$uses 次，$puffs 喷';
  }

  @override
  String get cnNoEntries => '没有记录';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return '$days 天有症状，$night 天夜里醒来（已记录的 $total 天中有 $entries 天有记录）';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return '$total 天中有 $days 天有 PM2.5 数据；$high 天 AQI 高于 100';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 条自述',
      one: '1 条自述',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => '模拟数据';

  @override
  String get cnLetterAsksFor => '信里要求的内容';

  @override
  String get cnNoItemsListed => '信中没有列出具体项目。您可以添加自己的项目。';

  @override
  String get cnAddItemLabel => '添加要跟进的项目';

  @override
  String cnYourRecords(String from, String to) {
    return '您的记录（$from – $to）';
  }

  @override
  String get cnLocalContextNote => '仅供参考。这不是在您家中测得的数据，也不是症状的原因。';

  @override
  String get cnContinueToPacket => '继续生成资料包';

  @override
  String get cnAddedByYou => '由您添加';

  @override
  String get cnFromLetter => '来自信件';

  @override
  String cnWhoHasIt(String who) {
    return '在谁手上：$who';
  }

  @override
  String cnLinkedTo(String record) {
    return '已关联：$record';
  }

  @override
  String get cnSeeInLetter => '在信中查看';

  @override
  String get cnLinkRecords => '关联我的记录';

  @override
  String get cnOtherStatus => '其他状态';

  @override
  String get cnInPacket => '已放入资料包';

  @override
  String get cnRemoveFromPacket => '从资料包移除';

  @override
  String get cnAddToPacket => '加入资料包';

  @override
  String get cnErrNotSavedYet => '您最近的更改还没有保存。请检查网络后再试。';

  @override
  String get cnPacketChangedMeanwhile => '生成资料包期间，信息或记录发生了变化。请重新生成。';

  @override
  String get cnPacketFailed => '无法生成资料包。请再试一次。';

  @override
  String get cnBeforeSharingTitle => '分享之前';

  @override
  String get cnBeforeSharingBody =>
      '这个文件包含您的姓名和健康信息。请只分享给您的医疗团队或您的保险计划。分享并不会替您提交任何东西。';

  @override
  String get cnShare => '分享';

  @override
  String get cnMethodFax => '传真';

  @override
  String get cnMethodMail => '邮寄';

  @override
  String get cnMethodPortal => '在线门户网站';

  @override
  String get cnMethodInPerson => '当面递交';

  @override
  String get cnMethodCareTeam => '医疗团队已发送';

  @override
  String get cnMethodOther => '其他';

  @override
  String get cnPacketNoDraftFinal => '对于最终决定，资料包只包含医生摘要，不会生成第一级复核申请草稿。';

  @override
  String get cnPacketNoDraftEob => '对于账单或福利说明，资料包只包含医生摘要。';

  @override
  String get cnPacketNoDraftReauth => '对于续期通知，资料包只包含医生摘要，以帮助您的医疗团队办理续期。';

  @override
  String get cnPacketNoDraftOther => '除非信件是拒绝信或信息要求，否则资料包只包含医生摘要。';

  @override
  String get cnPacketContains => '此资料包将包含';

  @override
  String get cnPartSummary => '医生摘要（1 页）';

  @override
  String get cnPartDraft => '复核申请草稿（由您的医疗团队完成）';

  @override
  String get cnPartLetterText => '附录：信件文字';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已添加 $count 份记录摘要',
      one: '已添加 1 份记录摘要',
      zero: '未添加记录摘要',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => '把信件文字作为附录加入';

  @override
  String get cnPacketStale => '自上次生成资料包后，信息或记录发生了变化。请重新生成以更新。';

  @override
  String get cnGenerating => '正在生成…';

  @override
  String get cnGeneratePacket => '生成复核资料包';

  @override
  String get cnSaveOrPrint => '保存或打印';

  @override
  String get cnISentIt => '我已寄出';

  @override
  String cnSharedOn(String date) {
    return '分享于 $date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return '您报告已于 $date 寄出（$method）';
  }

  @override
  String get cnTabDoctorSummary => '医生摘要';

  @override
  String get cnTabReviewDraft => '复核申请草稿';

  @override
  String get cnSentExplain => '请记录寄出的时间和方式。CoverNote 不会代您寄出，也不会跟踪结果。';

  @override
  String get cnSave => '保存';

  @override
  String get cnCtxPm25 => 'PM2.5（AQI）';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => '室外湿度';

  @override
  String cnObservedOn(String date) {
    return '观测日期 $date';
  }

  @override
  String get cnCtxIntro =>
      '来自明确来源的空气读数，和您自己注意到的情况，分开记录。只有在有助于说明您的记录时，才把它们加入案件。';

  @override
  String get cnCtxReadings => '空气读数';

  @override
  String get cnCtxReadingsNote => '这是观测当天的地区读数，不能反映您家附近的车辆尾气。';

  @override
  String get cnCtxAddReading => '添加读数';

  @override
  String get cnCtxReports => '您注意到的情况';

  @override
  String get cnCtxReportsNote => '这是您自己的报告，不是测量数据。';

  @override
  String get cnCtxAddReport => '添加您注意到的情况';

  @override
  String get cnReportExhaust => '附近有浓重的尾气';

  @override
  String get cnReportWater => '家里进水';

  @override
  String get cnReportDamp => '室内有潮湿或霉味的地方';

  @override
  String cnOnDate(String date) {
    return '日期：$date';
  }

  @override
  String get cnNoteOptional => '备注（可选）';

  @override
  String get cnCtxWhat => '读数类型';

  @override
  String get cnCtxHumidityNote => '室外湿度是天气数据，不能说明您家里是否潮湿或有霉菌。';

  @override
  String get cnCtxValue => '数值';

  @override
  String get cnCtxValueInvalid => '请输入有效的数字。';

  @override
  String get cnCtxSource => '来源';

  @override
  String get cnCtxSourceHelp => '数字的出处，例如 AirNow 或当地监测站';

  @override
  String get cnCtxSourceRequired => '请填写来源。';

  @override
  String get cnCtxPlace => '地点（邮编或城镇，可选）';

  @override
  String get cnRecordsSignInBody => '登录后可保存用药、症状和当地情况记录。';

  @override
  String get cnRecordsYourRecords => '您的记录';

  @override
  String get cnRecMedicationSub => '您使用的药物和剂量';

  @override
  String get cnRecDailyLog => '每日记录';

  @override
  String get cnRecDailyLogSub => '症状和吸入器使用';

  @override
  String get cnRecLocalContextSub => '空气读数和您注意到的情况';

  @override
  String get cnHelp => '帮助';

  @override
  String get cnUrgentHelp => '紧急求助';

  @override
  String get cnUrgentHelpSub => '呼吸紧急情况的处理步骤和拨打 911';

  @override
  String cnLast30Days(String from, String to) {
    return '最近 30 天（$from – $to）';
  }

  @override
  String get cnNoSchedule => '未设置固定用药时间';

  @override
  String get cnRecordsUnknownNote => '没有记录的日子保持“未知”，不会被算作漏用。';

  @override
  String get cnDeleteAccountTitle => '要删除您的账号吗？';

  @override
  String get cnDeleteAccountBody => '这会永久删除您的账号、案件、上传的信件、资料包和记录，并且无法恢复。';

  @override
  String get cnTypeDelete => '输入 DELETE 以确认';

  @override
  String get cnDeleteAccount => '删除账号';

  @override
  String get cnAccountDeleted => '您的账号已删除。';

  @override
  String get cnDeleteAccountFailed => '无法删除账号。请稍后再试。';

  @override
  String get cnAccountSignedOut => '您尚未登录。';

  @override
  String get cnLanguage => '语言';

  @override
  String get cnServiceStatus => '信件读取服务';

  @override
  String get cnServiceReady => '可用';

  @override
  String get cnServiceUnavailableShort => '暂时不可用';

  @override
  String get cnChecking => '检查中…';

  @override
  String get cnServiceUnknown => '尚未检查';

  @override
  String get cnCheck => '检查';

  @override
  String get cnAbout => '关于';

  @override
  String get cnAboutBody =>
      'CoverNote 帮您读懂有关药物的保险信件，并为您的医疗团队准备文件。它不会向您的保险计划提交任何东西，不会决定是否承保，也不是医疗建议。';

  @override
  String get cnDangerZone => '删除账号';

  @override
  String get cnErrServiceUnavailable => '信件读取功能暂时不可用。';

  @override
  String get cnErrBusy => '服务正忙。请等一分钟后再试。';

  @override
  String get cnErrSlow => '读取用时太长。请再试一次。';

  @override
  String get cnErrUnreadable => '无法读取这些页面。请在光线更好的地方重拍。';

  @override
  String get cnErrTooManyPages => '页数太多。最多上传 10 页。';

  @override
  String get cnErrTooLarge => '文件太大。请减少页数，或使用更小的页面。';

  @override
  String get cnErrStale => '这个案件已在另一台设备上更改。现在显示的是最新版本。';

  @override
  String get cnErrCaseGone => '这个案件已不存在。';

  @override
  String get cnErrAttempts => '读取多次失败。请替换页面，或稍后再试。';

  @override
  String get cnErrDemoUpload => '示例无法读取文件。请登录后扫描您自己的信件。';

  @override
  String cnErrGeneric(String code) {
    return '出了点问题（$code）。请再试一次。';
  }

  @override
  String get cnLanguageChoose => '选择您的语言';

  @override
  String get cnLanguageNote => '部分文字由软件翻译，可能有错误。药物名称、剂量、日期和信中的引文都不会被翻译。';

  @override
  String get cnLanguageButtonTooltip => '更改语言';

  @override
  String get cnPacketEnglishNote => '资料包用英文撰写，方便您的医疗团队阅读。';

  @override
  String get cnReasonMissingInformation => '保险计划说它没有收到所需的全部信息。';

  @override
  String get cnReasonStepTherapy => '保险计划要求您先试用其他药物。';

  @override
  String get cnReasonMedicalNecessity => '保险计划说无法确认这种药在医学上是必需的。';

  @override
  String get cnReasonFormulary => '保险计划说这种药不在它的承保药物清单上。';

  @override
  String get cnReasonQuantityLimit => '保险计划说您申请的数量超出了它承保的范围。';

  @override
  String get cnReasonEligibility => '保险计划说按其承保规则，这项不在承保范围内。';

  @override
  String get cnReasonOther => '信中给出了其他原因。请打开信件引文阅读。';

  @override
  String get cnReqHintMedHistory => '您过去和现在使用的药物';

  @override
  String get cnReqHintVisitNotes => '您看诊时医生的记录';

  @override
  String get cnReqHintTestResults => '检查或化验结果';

  @override
  String get cnReqHintDoctorStatement => '医生出具的说明';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginEmailLabel => '電子郵件';

  @override
  String get loginPasswordLabel => '密碼';

  @override
  String get loginButton => '登入';

  @override
  String get signUpButton => '註冊';

  @override
  String get medicationLogAddButton => '記錄吸入器／藥物使用';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguageLabel => '語言';

  @override
  String get mockContinue => '繼續';

  @override
  String get mockUnlock => '解鎖';

  @override
  String get mockUsePassword => '改用密碼';

  @override
  String get mockHomeLocation => '住家';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => '緊急聯絡人';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => '醫療人員邀請碼';

  @override
  String get mockAllScreens => '所有畫面';

  @override
  String get mockStateCalm => '平穩';

  @override
  String get mockStateWarning => '警示';

  @override
  String get mockForecast => '預報';

  @override
  String get mockShowWarningHome => '預覽警示首頁';

  @override
  String get mockBackToCalmHome => '返回';

  @override
  String get mockTrapAxis => 'TRAP／煤煙';

  @override
  String get mockFloodAxis => '暴洪';

  @override
  String get mockPollenAxis => '花粉';

  @override
  String get mockActSurvey => 'ACT 問卷';

  @override
  String get mockActHint => '5 個圖示問題（過去 4 週）';

  @override
  String get mockPdcCheck => '每日 PDC 檢查';

  @override
  String get mockPdcHint => '一鍵記錄用藥';

  @override
  String get mockInhalerEvent => '已記錄吸入器使用';

  @override
  String get mockQuestion => '問題';

  @override
  String get mockSubmit => '提交';

  @override
  String get mockPdcPrompt => '您今天有使用控制型藥物嗎？';

  @override
  String get mockTakenYes => '有，我用了';

  @override
  String get mockTakenNo => '今天沒有';

  @override
  String get mockActScore => '最近一次 ACT';

  @override
  String get mockPdcRate => 'PDC（30 天）';

  @override
  String get mockLocationsTitle => '已儲存的地點';

  @override
  String get mockLocationsHint => '住家與工作地點監測';

  @override
  String get mockWorkLocation => '工作';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => '新增地點';

  @override
  String get mockDraftBanner => '草稿——點數與兌換券僅供預覽';

  @override
  String get mockPointsBalance => '點數餘額';

  @override
  String get mockVoucherTitle => '食物銀行兌換券';

  @override
  String get mockDonateTitle => '捐款';

  @override
  String get mockDonateHint => '僅限透過第三方捐款';

  @override
  String get mockRewardHistory => '紀錄';

  @override
  String get mockRewardHistoryHint => '點數與捐款';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank（示範）';

  @override
  String get mockVoucherCost => '50 點 · 價值 \$10（草稿）';

  @override
  String get mockJoinWaitlist => '加入候補名單';

  @override
  String get mockDonateTransparency =>
      '捐款會透過經過驗證的第三方非營利平台處理。Howse Asthma 絕不會儲存您的信用卡資料。';

  @override
  String get mockDonateCta => '開啟捐款頁面（外部）';

  @override
  String get mockExternalOnly => '設計預覽中未連接外部捐款服務。';

  @override
  String get mockSignOutPreview => '登出（預覽）';

  @override
  String get mockDismiss => '關閉';

  @override
  String get mockPanicStep1Body => '步驟 1——請把吸入器帶在身邊。繼續以查看緊急聯絡人。';

  @override
  String get mockPanicStep2Title => '呼叫協助';

  @override
  String get mockPanicStep2Body => '設計預覽：按鈕不會真的撥出電話。在裝置版本上，步驟 2 會使用 tel: 連結。';

  @override
  String get mockCall911 => '撥打 911';

  @override
  String get mockCallGuardian => '撥打緊急聯絡人電話';

  @override
  String get mockFeelingBetter => '我覺得好多了';

  @override
  String get mockTabHome => '首頁';

  @override
  String get mockTabLog => '記錄';

  @override
  String get mockTabReport => '報告';

  @override
  String get mockTabReward => '獎勵';

  @override
  String get mockTabSettings => '設定';

  @override
  String get authChooseRole => '請選擇您的身分';

  @override
  String get authRolePatient => '患者';

  @override
  String get authRoleProvider => '醫療人員';

  @override
  String get authFullNameLabel => '全名';

  @override
  String get authNpiLabel => 'NPI 號碼';

  @override
  String get authNpiHelper => '10 位數的全國醫療人員識別碼';

  @override
  String get authOrContinueWith => '或使用以下方式繼續';

  @override
  String get authContinueGoogle => '使用 Google 繼續';

  @override
  String get authContinueApple => '使用 Apple 繼續';

  @override
  String get authSignOut => '登出';

  @override
  String get authRetry => '重試';

  @override
  String get authWorking => '處理中…';

  @override
  String get authErrorGeneric => '發生錯誤，請再試一次。';

  @override
  String get authBiometricTitle => '解鎖 Howse Asthma';

  @override
  String get authBiometricHint => '使用生物辨識繼續';

  @override
  String get authBiometricReason => '解鎖 Howse Asthma';

  @override
  String get authBiometricToggle => '生物辨識解鎖';

  @override
  String get authBiometricToggleHint => '開啟應用程式時需要生物辨識解鎖';

  @override
  String get authBiometricUnavailable => '此裝置無法使用生物辨識';

  @override
  String get authOnboardingTitle => '患者設定';

  @override
  String get authOnboardingSkip => '暫時略過';

  @override
  String get authInviteCodeLabel => '醫療人員邀請碼';

  @override
  String get authInviteCodeHelper => '8 個字母或數字，24 小時後失效';

  @override
  String get authInviteIssueFailed => '無法產生邀請碼';

  @override
  String get authConfirmLink => '確認';

  @override
  String get authRejectLink => '拒絕';

  @override
  String get authLinkStatusPending => '等待確認';

  @override
  String get providerHomeTab => '首頁';

  @override
  String get providerLinkTab => '連結';

  @override
  String get providerHomeTitle => '醫療人員首頁';

  @override
  String providerHomeWelcome(String email) {
    return '已登入帳號：$email';
  }

  @override
  String get providerHomePlaceholder => '患者臨床儀表板將在日後版本推出。請先從連結患者開始。';

  @override
  String get providerLinkPatientsCta => '連結患者';

  @override
  String get providerLinkTitle => '連結患者';

  @override
  String get providerLinkIntro => '產生一組 8 個字元的代碼（24 小時內有效）。患者輸入後，雙方再各自確認。';

  @override
  String get providerIssueInviteCta => '產生邀請碼';

  @override
  String get providerInviteTtlHint => '24 小時內有效';

  @override
  String get providerInviteCopied => '已複製邀請碼';

  @override
  String get providerPendingLinks => '待確認的連結';

  @override
  String get providerNoPendingLinks => '沒有待確認的連結';

  @override
  String providerPendingPatient(String idPrefix) {
    return '患者 $idPrefix…';
  }

  @override
  String get providerRecentInvites => '最近的邀請碼';

  @override
  String get providerNoInvites => '尚無邀請碼';

  @override
  String get providerInviteConsumed => '已使用';

  @override
  String get providerInviteActive => '有效';

  @override
  String get splashTagline => '您防範誘發因素的智慧防護罩';

  @override
  String get splashGetStarted => '開始使用';

  @override
  String get splashAlreadyHaveAccount => '已經有帳號了嗎？';

  @override
  String get splashSignIn => '登入';

  @override
  String get authForgotPassword => '忘記密碼？';

  @override
  String get authNoAccount => '還沒有帳號？';

  @override
  String get authUseBiometricHint => '使用 Face ID 或指紋解鎖';

  @override
  String get authTouchSensorHint => '請觸碰感應器或看向鏡頭';

  @override
  String get mockChooseLanguage => '選擇語言';

  @override
  String get mockYourLocation => '您的位置';

  @override
  String get mockUseCurrentLocation => '使用目前位置';

  @override
  String get mockLocationTrapOnly => '位置僅用於 TRAP 空氣品質資料';

  @override
  String get mockLabelYourPlace => '為此地點命名';

  @override
  String get mockSchool => '學校';

  @override
  String get mockWork => '工作';

  @override
  String get mockOther => '其他';

  @override
  String get mockEmergencyOnePerson => '緊急時可聯絡的一位聯絡人';

  @override
  String get mockContactName => '聯絡人姓名';

  @override
  String get mockPhoneNumber => '電話號碼';

  @override
  String get mockProviderPairing => '配對醫療人員';

  @override
  String get mockPairingOptional => '選填——您之後可以在「設定」中新增';

  @override
  String get mockNext => '下一步';

  @override
  String get mockProfessionalProfile => '專業資料';

  @override
  String get mockStep2Of4 => '第 2 步，共 4 步';

  @override
  String get mockTellPractice => '請告訴我們您的執業資料';

  @override
  String get mockSpecialtyLabel => '專科';

  @override
  String get mockClinicLabel => '診所／執業單位名稱';

  @override
  String get mockNpiFormatOnly => '僅檢查格式。NPI 會在提交後才進行驗證。';

  @override
  String get mockCredentialsSecure => '您的資格資料已加密並安全儲存。未經同意，我們不會分享醫療人員的資料。';

  @override
  String get actPast4Weeks => '過去 4 週';

  @override
  String get actQ1 => '您的氣喘在多少時間內，讓您無法在工作、學校或家中完成平常的事情？';

  @override
  String get actQ2 => '您多常感到呼吸急促？';

  @override
  String get actQ3 => '您的氣喘症狀多常讓您在夜間或比平常更早醒來？';

  @override
  String get actQ4 => '您多常使用急救吸入器或噴霧治療藥物？';

  @override
  String get actQ5 => '您會如何評價自己的氣喘控制情況？';

  @override
  String get actOpt1 => '所有時間';

  @override
  String get actOpt2 => '大部分時間';

  @override
  String get actOpt3 => '部分時間';

  @override
  String get actOpt4 => '少部分時間';

  @override
  String get actOpt5 => '完全沒有';

  @override
  String get actQ5Opt1 => '完全沒有控制';

  @override
  String get actQ5Opt2 => '控制不佳';

  @override
  String get actQ5Opt3 => '有些控制';

  @override
  String get actQ5Opt4 => '控制良好';

  @override
  String get actQ5Opt5 => '完全控制';

  @override
  String get panicNoAutoDial => '按鈕會開啟手機撥號畫面。不會自動撥出電話。';

  @override
  String panicCallNamed(String name) {
    return '撥打給 $name';
  }

  @override
  String get panicDialFailed => '無法在此裝置上開啟撥號畫面。';

  @override
  String get s5ActNotice =>
      '您的答案會被儲存，方便您與臨床醫師分享。此版本的問卷尚未對照官方計分方式檢查，因此應用程式不會顯示分數。';

  @override
  String get s5ActSaved => '您的答案已儲存。';

  @override
  String get s5ActSubtitle => '5 個關於過去 4 週的問題';

  @override
  String get s5ActTitle => '氣喘控制問卷';

  @override
  String get s5AddDetails => '新增詳細資料';

  @override
  String get s5AddRecord => '新增記錄';

  @override
  String get s5Back => '返回';

  @override
  String get s5Cancel => '取消';

  @override
  String get s5Change => '更改';

  @override
  String get s5Delete => '刪除';

  @override
  String get s5DeleteConfirm => '要刪除這筆記錄嗎？';

  @override
  String get s5DeleteFailed => '無法刪除，請再試一次。';

  @override
  String get s5Edit => '編輯';

  @override
  String get s5EntryRemoved => '記錄已移除。';

  @override
  String get s5FieldDate => '日期';

  @override
  String get s5FieldMedication => '藥物';

  @override
  String get s5FieldNote => '備註（選填）';

  @override
  String get s5FieldPuffs => '噴吸次數（選填）';

  @override
  String get s5FieldReason => '原因（選填）';

  @override
  String get s5FieldTime => '時間';

  @override
  String get s5FilterAll => '全部';

  @override
  String get s5FilterInhaler => '吸入器';

  @override
  String get s5FilterMedCheck => '用藥確認';

  @override
  String get s5FilterSymptoms => '症狀';

  @override
  String get s5FromUrgentHelp => '從「緊急求助」記錄';

  @override
  String get s5InhalerEditTitle => '吸入器使用詳細資料';

  @override
  String get s5InhalerEntry => '吸入器使用';

  @override
  String get s5InhalerLogged => '已記錄吸入器使用。';

  @override
  String get s5InhalerOneEntryHint => '每次儲存都是一筆吸入器使用記錄，不會被算作一次噴吸或一天。';

  @override
  String s5InhalerUnknownCount(int n) {
    return '未指明藥物：$n';
  }

  @override
  String get s5Last30Days => '最近 30 天';

  @override
  String get s5Last7Days => '最近 7 天';

  @override
  String get s5LogInhaler => '記錄吸入器使用';

  @override
  String get s5LogLegend => '每一行是一筆已儲存的記錄。沒有記錄的日子會顯示為“未記錄”，這與零不同。';

  @override
  String get s5LogSymptoms => '記錄症狀';

  @override
  String get s5MedAdd => '新增藥物';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return '使用天數：$a · 未使用：$b · 不記得：$c · 未記錄：$d';
  }

  @override
  String get s5MedCheckIntro => '由您自行回報是否有使用藥物的確認。並非根據藥局紀錄。';

  @override
  String get s5MedCheckQuestion => '您有依計畫使用藥物嗎？';

  @override
  String get s5MedCheckTitle => '今日用藥確認';

  @override
  String get s5MedChooseHint => '請選擇一種藥物，或選擇“我不知道藥物名稱”。';

  @override
  String get s5MedDailyCheck => '每日確認';

  @override
  String get s5MedDailyCheckHint => '在首頁顯示“今日用藥確認”。只有在臨床醫師要求您每天使用這種藥物時才開啟。';

  @override
  String get s5MedDefault => '快速記錄的預設值';

  @override
  String get s5MedDefaultHint => '當您在首頁點選“記錄吸入器使用”時會使用。';

  @override
  String get s5MedEdit => '編輯藥物';

  @override
  String get s5MedNameLabel => '藥物名稱（照藥品標籤上所寫）';

  @override
  String get s5MedNotApplicable => '今天不需要使用';

  @override
  String s5MedNotApplicableDays(int n) {
    return '不需要使用：$n 天';
  }

  @override
  String get s5MedNotRecorded => '未記錄藥物';

  @override
  String get s5MedNotSure => '我不記得';

  @override
  String get s5MedNotUsed => '我沒有使用';

  @override
  String get s5MedOther => '其他名稱';

  @override
  String get s5MedOtherHint => '請輸入藥物名稱';

  @override
  String get s5MedReasonCost => '費用';

  @override
  String get s5MedReasonForgot => '忘記了';

  @override
  String get s5MedReasonNoMedicine => '沒有藥物';

  @override
  String get s5MedReasonQuestion => '原因（選填）';

  @override
  String get s5MedUnknown => '我不知道藥物名稱';

  @override
  String get s5MedUnknownShort => '未指明藥物';

  @override
  String get s5MedUsed => '我有使用';

  @override
  String get s5MyLogTitle => '我的記錄';

  @override
  String get s5MyMedsEmpty => '尚未儲存任何藥物。';

  @override
  String get s5MyMedsHint => '您確認過的名稱，可讓記錄更快速。這不是用藥劑量建議。';

  @override
  String get s5MyMedsTitle => '我的藥物';

  @override
  String get s5NoAnswer => '不想回答';

  @override
  String get s5NoRecordsYet => '尚無記錄';

  @override
  String s5NoSymptomDays(int n) {
    return '標記為“無症狀”的天數：$n';
  }

  @override
  String get s5NotRecorded => '未記錄';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return '期間：$days 天 · 有記錄的天數：$n';
  }

  @override
  String s5PuffsValue(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 噴',
      one: '1 噴',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return '第 $n 題，共 $total 題';
  }

  @override
  String get s5ReasonBeforeActivity => '活動前';

  @override
  String get s5ReasonOther => '其他';

  @override
  String get s5ReasonSymptoms => '因為有症狀';

  @override
  String s5RecentInhaler(int n) {
    return '吸入器使用記錄：$n';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return '有症狀的天數：$n';
  }

  @override
  String get s5RecordsLoadFailed => '無法載入您的記錄，請再試一次。';

  @override
  String get s5Save => '儲存';

  @override
  String get s5Saved => '已儲存。';

  @override
  String get s5SaveFailed => '無法儲存。您輸入的內容仍保留在這裡。';

  @override
  String get s5SymActivityLimited => '活動受限';

  @override
  String get s5SymCough => '咳嗽';

  @override
  String get s5SymNightWaking => '夜間醒來';

  @override
  String get s5SymNone => '沒有症狀';

  @override
  String get s5SymOther => '其他情況';

  @override
  String get s5SymOtherHint => '請用您自己的話描述';

  @override
  String get s5SymShortBreath => '呼吸困難';

  @override
  String get s5SymWheeze => '喘鳴聲';

  @override
  String get s5SymptomEditTitle => '編輯症狀';

  @override
  String get s5SymptomEntry => '症狀';

  @override
  String get s5SymptomNoneHint => '您沒有記錄的日子會顯示為“未記錄”，而不是“無症狀”。';

  @override
  String get s5SymptomQuestion => '您注意到什麼？';

  @override
  String get s5Today => '今天';

  @override
  String get s5Undo => '復原';

  @override
  String get s5UrgentActionPlan => '如果臨床醫師給過您氣喘行動計畫，請依照計畫行動。';

  @override
  String get s5UrgentHelp => '緊急求助';

  @override
  String get s5UrgentIntro => '如果呼吸非常困難，或情況沒有好轉，請撥打 911。';

  @override
  String get s5UrgentLogHint => '選填：儲存一筆您使用過吸入器的記錄。';

  @override
  String get s5UrgentNoContact => '尚未設定緊急聯絡人。請到「設定」→「協助」新增。';

  @override
  String get s6AddTime => '新增時間';

  @override
  String get s6DoseLater => '稍後再確認';

  @override
  String get s6DoseNotUsed => '我無法使用';

  @override
  String get s6DoseUsed => '我有使用';

  @override
  String get s6HomeWaterNo => '否';

  @override
  String get s6HomeWaterQuestion => '家中有漏水或淹水嗎？';

  @override
  String get s6HomeWaterYes => '是';

  @override
  String get s6OccurredLabel => '發生時間';

  @override
  String get s6PuffsEach => '每次噴吸次數';

  @override
  String s6ReminderBodyNamed(String name) {
    return '該確認 $name 了';
  }

  @override
  String get s6ReminderBodyPrivate => '該確認您的藥物了';

  @override
  String get s6ReminderChannel => '在您儲存的用藥時間提醒。不是 30 分鐘提醒。';

  @override
  String get s6ReminderTitle => '用藥確認';

  @override
  String get s6RoleBoth => '每日使用及視需要使用';

  @override
  String get s6RoleController => '每日使用的藥物';

  @override
  String get s6RoleRescue => '視需要使用';

  @override
  String get s6ScheduleTimes => '您的用藥時間';

  @override
  String get cnTagline => '保險信件，清楚的下一步';

  @override
  String get cnDemoBadge => '範例';

  @override
  String get cnDemoBadgeLong => '使用虛構資料的範例。結果是固定的。';

  @override
  String get cnAuthSignInTitle => '登入';

  @override
  String get cnAuthCreateTitle => '建立帳號';

  @override
  String get cnAuthResetTitle => '重設密碼';

  @override
  String get cnAuthSignIn => '登入';

  @override
  String get cnAuthCreate => '建立帳號';

  @override
  String get cnAuthSendReset => '傳送重設連結';

  @override
  String cnAuthProfileError(String code) {
    return '您已登入，但無法載入您的帳號（$code）。';
  }

  @override
  String get cnRetry => '再試一次';

  @override
  String get cnSignOut => '登出';

  @override
  String get cnAuthPreparingAccount => '正在設定您的帳號…';

  @override
  String get cnAuthNameLabel => '姓名（選填）';

  @override
  String get cnAuthNameHelper => '會顯示在您的文件包上。之後可以更改。';

  @override
  String get cnAuthEmailLabel => '電子郵件';

  @override
  String get cnAuthPasswordLabel => '密碼';

  @override
  String get cnAuthPasswordHelper => '至少 8 個字元';

  @override
  String get cnAuthShowPassword => '顯示密碼';

  @override
  String get cnAuthHidePassword => '隱藏密碼';

  @override
  String get cnAuthPasswordRequired => '請輸入您的密碼';

  @override
  String cnAuthCheckEmail(String email) {
    return '我們已將確認連結寄到 $email。請在這支手機上開啟連結，然後登入。';
  }

  @override
  String cnAuthResetSent(String email) {
    return '如果 $email 有對應的帳號，重設連結正在寄出途中。請在這支手機上開啟。';
  }

  @override
  String get cnAuthResent => '已重新寄出。';

  @override
  String get cnAuthResend => '重新寄送電子郵件';

  @override
  String get cnAuthSignInInstead => '我已確認，前往登入';

  @override
  String get cnAuthForgot => '忘記密碼？';

  @override
  String get cnAuthNoAccount => '第一次使用？建立帳號';

  @override
  String get cnAuthHaveAccount => '已有帳號？登入';

  @override
  String get cnAuthResetHint => '請輸入您的電子郵件，我們會寄送連結讓您設定新密碼。';

  @override
  String get cnAuthBackToSignIn => '返回登入';

  @override
  String get cnAuthPrivacyLine => '您的信件和記錄只有您的帳號可以查看。';

  @override
  String get cnAuthPasswordUpdated => '密碼已更新。';

  @override
  String get cnAuthNewPasswordTitle => '設定新密碼';

  @override
  String get cnAuthNewPasswordLabel => '新密碼';

  @override
  String get cnAuthSavePassword => '儲存密碼';

  @override
  String get cnLater => '稍後';

  @override
  String get cnAuthErrInvalidCredentials => '電子郵件或密碼不正確。';

  @override
  String get cnAuthErrNotConfirmed => '請先確認您的電子郵件。請查看收件匣，或重新寄送連結。';

  @override
  String get cnAuthErrExists => '此電子郵件已有帳號。請直接登入。';

  @override
  String get cnAuthErrWeakPassword => '請設定更安全的密碼（至少 8 個字元）。';

  @override
  String get cnAuthErrSamePassword => '請使用與舊密碼不同的密碼。';

  @override
  String get cnAuthErrRateLimited => '嘗試次數過多。請等一分鐘後再試。';

  @override
  String get cnAuthErrInvalidEmail => '請檢查電子郵件地址。';

  @override
  String get cnAuthErrEmailNotAuthorized => '目前無法寄送電子郵件到此地址。請稍後再試。';

  @override
  String get cnAuthErrDisabled => '此登入方式已關閉。';

  @override
  String get cnAuthErrSessionExpired => '您的登入已結束。請重新登入。';

  @override
  String cnAuthErrUnknown(String code) {
    return '發生錯誤（$code）。請再試一次。';
  }

  @override
  String get cnErrNetwork => '沒有網路連線。請檢查網際網路後再試一次。';

  @override
  String get cnErrServiceDown => '服務沒有回應。請幾分鐘後再試。';

  @override
  String get cnTabHome => '首頁';

  @override
  String get cnTabCases => '案件';

  @override
  String get cnTabRecords => '記錄';

  @override
  String get cnTabAccount => '帳號';

  @override
  String get cnHomeHeadline => '看懂您的保險信件。';

  @override
  String get cnScanLetter => '掃描信件';

  @override
  String get cnUploadFile => '上傳 PDF／照片';

  @override
  String get cnTryDemo => '試用範例';

  @override
  String get cnHomeSignInLine => '要儲存您的案件，需要有帳號。';

  @override
  String get cnServiceNotConfigured => '此版本尚未連接伺服器。只能使用範例。';

  @override
  String get cnContinueCase => '繼續處理您的案件';

  @override
  String get cnHowItWorks => '使用方式';

  @override
  String get cnStep1Title => '讀取信件';

  @override
  String get cnStep1Body => '拍一張照片。我們會找出原因、下一步和日期。';

  @override
  String get cnStep2Title => '收集記錄';

  @override
  String get cnStep2Body => '把信件要求的資料，對照您自己的記錄。';

  @override
  String get cnStep3Title => '建立文件包';

  @override
  String get cnStep3Body => '取得一頁的醫師摘要，以及一份覆核申請草稿。';

  @override
  String get cnRecentCases => '其他案件';

  @override
  String get cnNoCasesYet => '還沒有案件';

  @override
  String get cnNoOtherCases => '沒有其他案件。';

  @override
  String get cnSeeAllCases => '查看所有案件';

  @override
  String get cnNoCasesBody => '掃描一封保險信件即可開始。';

  @override
  String get cnCasesSignInTitle => '登入以查看您的案件';

  @override
  String get cnCasesSignInBody => '或開啟範例，看看如何使用。';

  @override
  String get cnCaseDeleted => '案件已刪除。';

  @override
  String get cnCaseUntitled => '保險信件';

  @override
  String get cnStatusReading => '正在讀取信件';

  @override
  String get cnStatusNeedsReview => '需要檢查';

  @override
  String get cnStatusGatherRecords => '收集記錄';

  @override
  String get cnStatusPacketReady => '文件包已準備好';

  @override
  String get cnStatusNeedsAttention => '需要留意';

  @override
  String get cnStatusNotStarted => '尚未開始';

  @override
  String get cnNextWaitReading => '我們正在讀取信件。';

  @override
  String get cnNextTryAgain => '讀取已停止。請開啟案件再試一次。';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 項資料需要確認',
      one: '有 1 項資料需要確認',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return '$total 項要求的資料中，已處理 $done 項';
  }

  @override
  String get cnNextSharePacket => '文件包已準備好，可以分享';

  @override
  String get cnNextCreatePacket => '下一步：建立文件包';

  @override
  String cnDateToCheckShort(String date) {
    return '需確認的日期：$date';
  }

  @override
  String cnDatePassedShort(String date) {
    return '日期已過：$date';
  }

  @override
  String get cnMoreActions => '更多操作';

  @override
  String get cnDeleteCase => '刪除案件';

  @override
  String get cnDeleteCaseTitle => '要刪除這個案件嗎？';

  @override
  String get cnDeleteCaseBody => '這會移除信件頁面、從信件讀取的資料、已連結的記錄摘要和文件包。您的用藥和症狀記錄會保留。';

  @override
  String get cnCancel => '取消';

  @override
  String get cnDelete => '刪除';

  @override
  String get cnDeleteFailed => '無法刪除。請檢查網路連線後再試一次。';

  @override
  String get cnKindInitialDenial => '藥物拒絕給付（Denial）';

  @override
  String get cnKindInfoRequest => '要求提供更多資料';

  @override
  String get cnKindReauth => '續期（重新授權）通知';

  @override
  String get cnKindFinalDenial => '最終申訴（Appeal）決定';

  @override
  String get cnKindEob => '帳單或給付說明（EOB）';

  @override
  String get cnKindOther => '其他信件';

  @override
  String get cnKindUncertain => '信件類型不明確';

  @override
  String get cnFieldPatientName => '患者姓名';

  @override
  String get cnFieldPlanName => '保險計畫';

  @override
  String get cnFieldMemberId => '會員編號';

  @override
  String get cnFieldCaseReference => '案件或參考編號';

  @override
  String get cnFieldMedication => '藥物（照信件所寫）';

  @override
  String get cnFieldDose => '劑量（照信件所寫）';

  @override
  String get cnFieldNoticeDate => '通知日期';

  @override
  String get cnFieldContact => '聯絡方式';

  @override
  String get cnFieldSubmissionRoute => '寄送方式';

  @override
  String get cnFactEdited => '您已修改';

  @override
  String get cnFactChecked => '已確認';

  @override
  String get cnFactNotInLetter => '信件中沒有';

  @override
  String get cnFactNeedsCheck => '需要確認';

  @override
  String get cnFactFromLetter => '來自信件';

  @override
  String get cnWhoYou => '您';

  @override
  String get cnWhoCareTeam => '醫療團隊';

  @override
  String get cnWhoPlan => '保險計畫';

  @override
  String get cnWhoUnknown => '不確定';

  @override
  String get cnReqLinked => '已連結';

  @override
  String get cnReqAskedCareTeam => '已詢問醫療團隊';

  @override
  String get cnReqNotAvailable => '沒有';

  @override
  String get cnReqNotNeeded => '不需要';

  @override
  String get cnReqNeeded => '需要';

  @override
  String get cnReqReset => '標記為需要';

  @override
  String get cnRecMedication => '用藥史';

  @override
  String get cnRecSymptoms => '症狀記錄';

  @override
  String get cnRecLocalContext => '當地環境資料';

  @override
  String get cnRecPrn => '視需要使用的吸入器';

  @override
  String get cnDemoTitle => '範例';

  @override
  String get cnDemoReset => '重設範例';

  @override
  String get cnDemoResetDone => '範例已重設。';

  @override
  String get cnDemoIntro => '三封內容虛構、結果固定的信件，讓您看到每個步驟。不會上傳任何資料。';

  @override
  String get cnUpEmpty => '這個檔案是空的。';

  @override
  String cnUpTooLarge(int mb) {
    return '每個檔案必須在 $mb MB 以內。';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return '所有頁面合計必須在 $mb MB 以內。';
  }

  @override
  String cnUpTooManyPages(int max) {
    return '每封信件最多 $max 頁。';
  }

  @override
  String get cnUpUnsupported => '請使用 JPG、PNG 或 PDF。如果是 HEIC 照片，請在這裡重新拍照。';

  @override
  String get cnUpBadFile => '無法讀取這個檔案。請換一張照片或 PDF 再試。';

  @override
  String get cnUpEncrypted => '這個 PDF 有密碼保護。請儲存一份未加密的副本，或改用拍照。';

  @override
  String get cnCameraUnavailable => '無法使用相機。您可以改為上傳照片或 PDF。';

  @override
  String get cnPhotosUnavailable => '無法開啟照片。請在設定中允許存取照片，或上傳 PDF。';

  @override
  String get cnFilesUnavailable => '目前無法開啟檔案。請再試一次。';

  @override
  String get cnUploadFailed => '上傳未完成。您的頁面仍保留在這裡。請再試一次。';

  @override
  String get cnCaptureTitle => '新增信件頁面';

  @override
  String get cnReplacePagesTitle => '更換信件頁面';

  @override
  String get cnOpening => '開啟中…';

  @override
  String get cnCaptureEmptyTitle => '新增您信件的頁面';

  @override
  String get cnCaptureTips => '請把信件平放在光線充足的地方，讓四個角都在畫面內。請依順序加入每一頁。';

  @override
  String get cnTakePhoto => '拍照';

  @override
  String get cnAddPage => '新增頁面';

  @override
  String get cnAddPhoto => '照片';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages 頁',
      one: '1 頁',
    );
    return '$_temp0 · $size MB';
  }

  @override
  String get cnUploadConsent =>
      '上傳會將這些頁面傳送到 CoverNote 伺服器，由人工智慧服務為您讀取。您隨時可以刪除案件。';

  @override
  String get cnStageUploading => '上傳中';

  @override
  String get cnUploadAndRead => '上傳並讀取';

  @override
  String cnPageN(int n) {
    return '第 $n 頁';
  }

  @override
  String cnPdfPages(int n, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 頁',
      one: '1 頁',
    );
    return '檔案 $n · PDF，$_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return '預覽第 $n 頁';
  }

  @override
  String get cnRotate => '旋轉';

  @override
  String get cnRetake => '重拍';

  @override
  String get cnRemovePage => '移除';

  @override
  String get cnReorder => '拖曳以調整順序';

  @override
  String get cnServiceUnavailableBody => '信件讀取功能目前尚未設定好。您的頁面已儲存，請稍後再試。';

  @override
  String get cnNeedNewPagesBody => '請拍更清楚的照片或減少頁數，然後重新上傳。';

  @override
  String get cnPagesKept => '您的頁面已儲存。沒有任何變更。';

  @override
  String get cnReplacePages => '更換頁面';

  @override
  String get cnTryAgain => '再試一次';

  @override
  String get cnStageReading => '讀取中';

  @override
  String get cnStageChecking => '檢查中';

  @override
  String get cnStageReady => '完成';

  @override
  String get cnReadingTitle => '正在讀取您的信件';

  @override
  String get cnReadingBody => '完成後，請您對照信件，確認我們找到的內容。';

  @override
  String get cnReadingLeaveOk => '您可以離開此畫面。讀取會繼續進行，您的案件也已儲存。';

  @override
  String get cnStartReading => '開始讀取';

  @override
  String get cnStepLetter => '信件';

  @override
  String get cnStepReview => '檢查';

  @override
  String get cnStepEvidence => '佐證資料';

  @override
  String get cnStepPacket => '文件包';

  @override
  String cnStepOf(int n, int total, String name) {
    return '第 $n 步，共 $total 步：$name';
  }

  @override
  String get cnSaving => '儲存中…';

  @override
  String get cnSaved => '已儲存';

  @override
  String get cnNotSavedRetry => '未儲存 · 重試';

  @override
  String get cnViewOriginal => '查看原始頁面';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已讀取 $count 頁',
      one: '已讀取 1 頁',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return '難以閱讀：第 $list 頁。請仔細檢查這些資料，或重新拍攝該頁。';
  }

  @override
  String get cnRetakePages => '重拍頁面';

  @override
  String get cnHardToRead => '難以閱讀';

  @override
  String get cnContinueToReview => '繼續檢查';

  @override
  String get cnOriginalPages => '原始頁面';

  @override
  String get cnNoOriginal => '沒有儲存原始頁面。';

  @override
  String get cnCheckDetails => '檢查詳細資料';

  @override
  String get cnCheckDetailsHint => '請把每個數值與您的信件對照。點選引文可看到它出自哪裡。';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '再檢查 $count 項才能繼續',
      one: '再檢查 1 項才能繼續',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => '繼續到佐證資料';

  @override
  String cnSeePage(int n) {
    return '查看第 $n 頁';
  }

  @override
  String get cnWhatLetterIs => '這封信是什麼';

  @override
  String get cnLooksRight => '沒有錯';

  @override
  String get cnChange => '更改';

  @override
  String get cnCardWhyDenied => '為什麼被拒絕給付';

  @override
  String get cnCardWhatTheyNeed => '對方要求的資料';

  @override
  String get cnCardWhatItSays => '信件內容說明';

  @override
  String get cnNoReasonFound => '在信件中找不到原因。';

  @override
  String get cnCardNextStep => '下一步';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '請您的醫療團隊申請覆核。信件列出 $count 項需要寄送的資料。',
      one: '請您的醫療團隊申請覆核。信件列出 1 項需要寄送的資料。',
      zero: '請您的醫療團隊申請覆核。信件沒有列出具體項目。',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '保險計畫要求 $count 項資料，請在下方日期前寄出。',
      one: '請在下方日期前，寄出保險計畫要求的 1 項資料。',
      zero: '請在下方日期前，寄出保險計畫要求的資料。',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth => '請記下目前的核准何時到期，並請您的醫療團隊開始辦理續期。';

  @override
  String get cnNextFinal =>
      '這是最終決定。CoverNote 不會為此起草第一次覆核申請。請向保險計畫或您的醫療團隊詢問信件所列的選項。';

  @override
  String get cnNextEob => '這看起來是帳單或給付說明，不是拒絕給付通知。請向保險計畫的會員服務確認。';

  @override
  String get cnNextUncertain => '請先在上方確認這是哪一種信件。';

  @override
  String cnWhereToSend(String route) {
    return '寄送方式：$route';
  }

  @override
  String cnWhoToCall(String contact) {
    return '聯絡方式：$contact';
  }

  @override
  String get cnCardDate => '需確認的日期';

  @override
  String cnDateCalculated(String anchor, int days) {
    return '計算方式：$anchor + $days 個日曆天';
  }

  @override
  String get cnReceivedDateWord => '您收到信件的日期';

  @override
  String get cnNoticeDateWord => '通知日期';

  @override
  String get cnDateEnteredByYou => '由您輸入';

  @override
  String get cnDateFromLetter => '信件中載明';

  @override
  String cnReceivedOn(String date) {
    return '您在 $date 收到';
  }

  @override
  String get cnDatePassed => '這個日期已經過了。請致電保險計畫，詢問您還可以怎麼做。';

  @override
  String cnNeedReceivedDate(int days) {
    return '信件載明，從您收到信件當天起算 $days 個日曆天。信件是哪一天送達的？';
  }

  @override
  String get cnEnterReceivedDate => '輸入收到日期';

  @override
  String get cnDateConflict => '信件中出現不同的日期。請向保險計畫詢問適用哪一個，然後選擇該日期。';

  @override
  String cnUseThisDate(String date) {
    return '使用 $date';
  }

  @override
  String get cnDateUnclear => '文字說明不清楚，或以工作日計算，因此 CoverNote 不會計算。請向保險計畫詢問確切日期。';

  @override
  String get cnNoDeadline => '在信件中找不到覆核期限。';

  @override
  String cnReplyBy(String date) {
    return '請在 $date 前回覆資料要求（來自信件）';
  }

  @override
  String get cnEnterDatePlanGave => '輸入日期';

  @override
  String get cnUseLetterDate => '使用信件上的日期';

  @override
  String get cnLeaveUnknown => '暫時保留為不明';

  @override
  String get cnDateUnknownChecked => '不明，已記下';

  @override
  String get cnTypeAsWritten => '請照信件上的寫法原樣輸入。';

  @override
  String get cnCheckThisValue => '這個數值看起來不尋常。請與信件對照。';

  @override
  String get cnDone => '完成';

  @override
  String get cnEdit => '編輯';

  @override
  String get cnAdd => '新增';

  @override
  String get cnNoRecordsToLink => '最近 30 天沒有可連結的記錄。您仍可標記誰持有這項資料。';

  @override
  String cnLinkTitle(String label) {
    return '連結記錄至：$label';
  }

  @override
  String get cnLinkNote => '您自己的記錄可以支持這項申請，但不能取代診所的紀錄或檢驗結果。';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '排定的 $scheduled 次用藥中：已服用 $taken 次 / 未服用 $notTaken 次 / 不明 $unknown 次';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return '視需要使用：$uses 次，$puffs 噴';
  }

  @override
  String get cnNoEntries => '沒有記錄';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return '有症狀 $days 天，夜間醒來 $night 天（已記錄 $entries 天，共 $total 天）';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return '$total 天中有 $days 天的 PM2.5 資料；$high 天 AQI 高於 100';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 筆自行回報',
      one: '1 筆自行回報',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => '合成資料';

  @override
  String get cnLetterAsksFor => '信件要求的資料';

  @override
  String get cnNoItemsListed => '信件沒有列出具體項目。您可以自行新增。';

  @override
  String get cnAddItemLabel => '新增要追蹤的項目';

  @override
  String cnYourRecords(String from, String to) {
    return '您的記錄（$from – $to）';
  }

  @override
  String get cnLocalContextNote => '選用的背景資料。這不是在您家中測得的數值，也不是症狀的原因。';

  @override
  String get cnContinueToPacket => '繼續到文件包';

  @override
  String get cnAddedByYou => '由您新增';

  @override
  String get cnFromLetter => '來自信件';

  @override
  String cnWhoHasIt(String who) {
    return '由誰持有：$who';
  }

  @override
  String cnLinkedTo(String record) {
    return '已連結：$record';
  }

  @override
  String get cnSeeInLetter => '在信件中查看';

  @override
  String get cnLinkRecords => '連結我的記錄';

  @override
  String get cnOtherStatus => '其他狀態';

  @override
  String get cnInPacket => '已在文件包中';

  @override
  String get cnRemoveFromPacket => '從文件包移除';

  @override
  String get cnAddToPacket => '加入文件包';

  @override
  String get cnErrNotSavedYet => '您最新的變更尚未儲存。請檢查網路連線後再試一次。';

  @override
  String get cnPacketChangedMeanwhile => '文件包製作期間，資料或記錄有變動。請重新產生。';

  @override
  String get cnPacketFailed => '無法製作文件包。請再試一次。';

  @override
  String get cnBeforeSharingTitle => '分享之前';

  @override
  String get cnBeforeSharingBody =>
      '這個檔案包含您的姓名和健康資料。請只分享給您的醫療團隊或保險計畫。分享並不會為您提交任何東西。';

  @override
  String get cnShare => '分享';

  @override
  String get cnMethodFax => '傳真';

  @override
  String get cnMethodMail => '郵寄';

  @override
  String get cnMethodPortal => '線上入口網站';

  @override
  String get cnMethodInPerson => '親自送達';

  @override
  String get cnMethodCareTeam => '醫療團隊已寄出';

  @override
  String get cnMethodOther => '其他';

  @override
  String get cnPacketNoDraftFinal => '最終決定的文件包只有醫師摘要，不會製作第一階段覆核申請草稿。';

  @override
  String get cnPacketNoDraftEob => '帳單或給付說明的文件包只有醫師摘要。';

  @override
  String get cnPacketNoDraftReauth => '續期通知的文件包只有醫師摘要，以協助您的醫療團隊辦理續期。';

  @override
  String get cnPacketNoDraftOther => '除非信件是拒絕給付通知或資料要求，否則文件包只有醫師摘要。';

  @override
  String get cnPacketContains => '此文件包將包含';

  @override
  String get cnPartSummary => '醫師摘要（1 頁）';

  @override
  String get cnPartDraft => '覆核申請草稿（由您的醫療團隊完成）';

  @override
  String get cnPartLetterText => '附錄：信件文字';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已加入 $count 份記錄摘要',
      one: '已加入 1 份記錄摘要',
      zero: '尚未加入記錄摘要',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => '將信件文字加入附錄';

  @override
  String get cnPacketStale => '自上次製作文件包後，資料或記錄有變動。請重新產生以更新。';

  @override
  String get cnGenerating => '產生中…';

  @override
  String get cnGeneratePacket => '產生覆核文件包';

  @override
  String get cnSaveOrPrint => '儲存或列印';

  @override
  String get cnISentIt => '我已寄出';

  @override
  String cnSharedOn(String date) {
    return '分享日期：$date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return '您回報在 $date 寄出（$method）';
  }

  @override
  String get cnTabDoctorSummary => '醫師摘要';

  @override
  String get cnTabReviewDraft => '覆核申請草稿';

  @override
  String get cnSentExplain => '請記錄寄出的時間和方式。CoverNote 不會代為寄出，也不會追蹤決定結果。';

  @override
  String get cnSave => '儲存';

  @override
  String get cnCtxPm25 => 'PM2.5（AQI）';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => '戶外濕度';

  @override
  String cnObservedOn(String date) {
    return '觀測日期：$date';
  }

  @override
  String get cnCtxIntro =>
      '空氣監測數值來自有名稱的來源，與您注意到的情況分開記錄。只有在有助於說明您的記錄時，才將它們加入案件。';

  @override
  String get cnCtxReadings => '空氣監測數值';

  @override
  String get cnCtxReadingsNote => '觀測當天的區域性數值。它們並不是測量您家中的交通廢氣。';

  @override
  String get cnCtxAddReading => '新增監測數值';

  @override
  String get cnCtxReports => '您注意到的情況';

  @override
  String get cnCtxReportsNote => '這是您自己的回報，不是測量值。';

  @override
  String get cnCtxAddReport => '新增您注意到的情況';

  @override
  String get cnReportExhaust => '附近有濃烈的廢氣';

  @override
  String get cnReportWater => '家中有水滲入';

  @override
  String get cnReportDamp => '室內有潮濕或霉味的區域';

  @override
  String cnOnDate(String date) {
    return '日期：$date';
  }

  @override
  String get cnNoteOptional => '備註（選填）';

  @override
  String get cnCtxWhat => '監測項目';

  @override
  String get cnCtxHumidityNote => '戶外濕度是天氣資料。它不能顯示您家中是否潮濕或有黴菌。';

  @override
  String get cnCtxValue => '數值';

  @override
  String get cnCtxValueInvalid => '請輸入有效的數字。';

  @override
  String get cnCtxSource => '來源';

  @override
  String get cnCtxSourceHelp => '數字的出處，例如 AirNow 或當地的監測站';

  @override
  String get cnCtxSourceRequired => '請填寫來源。';

  @override
  String get cnCtxPlace => '地點（郵遞區號或城鎮，選填）';

  @override
  String get cnRecordsSignInBody => '請登入，以保存用藥、症狀和當地環境記錄。';

  @override
  String get cnRecordsYourRecords => '您的記錄';

  @override
  String get cnRecMedicationSub => '您使用的藥物和劑量';

  @override
  String get cnRecDailyLog => '每日記錄';

  @override
  String get cnRecDailyLogSub => '症狀和吸入器使用';

  @override
  String get cnRecLocalContextSub => '空氣監測數值和您注意到的情況';

  @override
  String get cnHelp => '協助';

  @override
  String get cnUrgentHelp => '緊急求助';

  @override
  String get cnUrgentHelpSub => '呼吸緊急狀況的處理步驟和撥打 911';

  @override
  String cnLast30Days(String from, String to) {
    return '最近 30 天（$from – $to）';
  }

  @override
  String get cnNoSchedule => '未設定固定時間表';

  @override
  String get cnRecordsUnknownNote => '沒有記錄的日子會保持為不明，不會被算作漏用。';

  @override
  String get cnDeleteAccountTitle => '要刪除您的帳號嗎？';

  @override
  String get cnDeleteAccountBody => '這會永久刪除您的帳號、案件、已上傳的信件、文件包和記錄。此操作無法復原。';

  @override
  String get cnTypeDelete => '請輸入 DELETE 以確認';

  @override
  String get cnDeleteAccount => '刪除帳號';

  @override
  String get cnAccountDeleted => '您的帳號已刪除。';

  @override
  String get cnDeleteAccountFailed => '無法刪除帳號。請稍後再試。';

  @override
  String get cnAccountSignedOut => '您尚未登入。';

  @override
  String get cnLanguage => '語言';

  @override
  String get cnServiceStatus => '信件讀取服務';

  @override
  String get cnServiceReady => '可使用';

  @override
  String get cnServiceUnavailableShort => '目前無法使用';

  @override
  String get cnChecking => '檢查中…';

  @override
  String get cnServiceUnknown => '尚未檢查';

  @override
  String get cnCheck => '檢查';

  @override
  String get cnAbout => '關於';

  @override
  String get cnAboutBody =>
      'CoverNote 協助您讀懂關於藥物的保險信件，並為您的醫療團隊準備文件。它不會向您的保險計畫提交任何東西，不會決定是否給付，也不是醫療建議。';

  @override
  String get cnDangerZone => '刪除帳號';

  @override
  String get cnErrServiceUnavailable => '信件讀取功能目前無法使用。';

  @override
  String get cnErrBusy => '服務忙碌中。請等一分鐘後再試。';

  @override
  String get cnErrSlow => '讀取花了太長時間。請再試一次。';

  @override
  String get cnErrUnreadable => '無法讀取這些頁面。請在光線更好的地方重拍。';

  @override
  String get cnErrTooManyPages => '頁數太多。最多上傳 10 頁。';

  @override
  String get cnErrTooLarge => '檔案太大。請減少頁數或使用較小的頁面。';

  @override
  String get cnErrStale => '這個案件已在另一台裝置上更改。目前顯示的是最新版本。';

  @override
  String get cnErrCaseGone => '這個案件已不存在。';

  @override
  String get cnErrAttempts => '讀取失敗多次。請更換頁面，或稍後再試。';

  @override
  String get cnErrDemoUpload => '範例無法讀取檔案。請登入後掃描您自己的信件。';

  @override
  String cnErrGeneric(String code) {
    return '發生錯誤（$code）。請再試一次。';
  }

  @override
  String get cnLanguageChoose => '選擇您的語言';

  @override
  String get cnLanguageNote => '部分文字由軟體翻譯，可能有錯誤。藥物名稱、劑量、日期和信件中的引文絕不會被翻譯。';

  @override
  String get cnLanguageButtonTooltip => '更改語言';

  @override
  String get cnPacketEnglishNote => '文件包以英文撰寫，方便您的醫療團隊閱讀。';

  @override
  String get cnReasonMissingInformation => '保險計畫表示沒有收到所需的全部資料。';

  @override
  String get cnReasonStepTherapy => '保險計畫希望您先嘗試其他藥物。';

  @override
  String get cnReasonMedicalNecessity => '保險計畫表示無法確認這種藥物在醫療上有其必要。';

  @override
  String get cnReasonFormulary => '保險計畫表示這種藥物不在其承保藥物清單上。';

  @override
  String get cnReasonQuantityLimit => '保險計畫表示申請的數量超過其承保範圍。';

  @override
  String get cnReasonEligibility => '保險計畫表示依其承保規則，這項不在承保範圍內。';

  @override
  String get cnReasonOther => '信件列出了其他原因。請開啟信件中的引文閱讀。';

  @override
  String get cnReqHintMedHistory => '您過去和目前使用的藥物';

  @override
  String get cnReqHintVisitNotes => '您看診時的醫師紀錄';

  @override
  String get cnReqHintTestResults => '檢查或檢驗結果';

  @override
  String get cnReqHintDoctorStatement => '醫師的聲明書';
}
