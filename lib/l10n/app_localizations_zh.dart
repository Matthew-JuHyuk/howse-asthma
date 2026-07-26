// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Howse Asthma';

  @override
  String get loginTitle => '登录';

  @override
  String get loginEmailLabel => '电子邮箱';

  @override
  String get loginPasswordLabel => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get signUpButton => '创建账户';

  @override
  String get supabaseNotConfigured =>
      '尚未配置 Supabase。\n请在 .env 文件中设置 SUPABASE_URL 和 SUPABASE_ANON_KEY。';

  @override
  String get homeGreeting => '你好';

  @override
  String get homeAirQualityTitle => '您所在地的空气质量';

  @override
  String get homeWeatherTitle => '您所在地的天气';

  @override
  String get asthmaRiskLow => '哮喘风险：低';

  @override
  String get asthmaRiskModerate => '哮喘风险：中等';

  @override
  String get asthmaRiskHigh => '哮喘风险：高 - 请注意防范';

  @override
  String get medicationLogTitle => '用药记录';

  @override
  String get medicationLogAddButton => '记录吸入器/药物使用情况';

  @override
  String get medicationNameLabel => '药物名称';

  @override
  String get medicationDoseLabel => '剂量';

  @override
  String get medicationTimeLabel => '用药时间';

  @override
  String get medicationEffectivenessLabel => '是否有效？';

  @override
  String get reportTitle => '保险提交报告';

  @override
  String get reportGenerateButton => '生成医生/保险公司提交报告';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguageLabel => '语言';

  @override
  String get settingsLocationLabel => '位置';

  @override
  String get notificationAttackWarningTitle => '哮喘发作风险提醒';

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
  String get navHome => '首页';

  @override
  String get signUpTitle => '创建账户';

  @override
  String get authChooseRole => '选择您的角色';

  @override
  String get authRolePatient => '患者';

  @override
  String get authRolePatientHint => '跟踪空气风险与吸入器使用';

  @override
  String get authRoleProvider => '医护人员';

  @override
  String get authRoleProviderHint => '关联患者并查看临床证据';

  @override
  String get authFullNameLabel => '姓名';

  @override
  String get authNpiLabel => 'NPI 号码';

  @override
  String get authNpiHelper => '10 位国家提供者识别号';

  @override
  String get authOrContinueWith => '或通过以下方式继续';

  @override
  String get authContinueGoogle => '使用 Google 继续';

  @override
  String get authContinueApple => '使用 Apple 继续';

  @override
  String get authCheckEmailTitle => '请查收邮件';

  @override
  String authCheckEmailBody(String email) {
    return '我们已向 $email 发送确认链接。打开后即可登录。';
  }

  @override
  String get authBackToSignIn => '返回登录';

  @override
  String get authCompleteProfileTitle => '完善个人资料';

  @override
  String get authCompleteProfileBody => '告诉我们您的身份，以便打开正确的主页。';

  @override
  String get authSaveProfile => '保存资料';

  @override
  String get authSignOut => '退出登录';

  @override
  String get authRetry => '重试';

  @override
  String get authWorking => '处理中…';

  @override
  String get authValidationInvalidEmail => '请输入有效邮箱';

  @override
  String get authValidationPasswordMin => '密码至少 8 个字符';

  @override
  String get authValidationNameRequired => '姓名为必填项';

  @override
  String get authValidationInvalidNpi => '请输入有效的 10 位 NPI';

  @override
  String get authErrorGeneric => '出错了，请重试。';

  @override
  String get authErrorInvalidCredentials => '邮箱或密码无效';

  @override
  String get authErrorEmailTaken => '该邮箱已注册账户';

  @override
  String get authErrorEmailNotConfirmed => '登录前请先确认邮箱';

  @override
  String get authErrorWeakPassword => '密码过于简单';

  @override
  String get authErrorRateLimited => '尝试次数过多，请稍后再试。';

  @override
  String get authBiometricTitle => '解锁 Howse Asthma';

  @override
  String get authBiometricHint => '使用指纹或面容继续。';

  @override
  String get authBiometricReason => '解锁 Howse Asthma';

  @override
  String get authBiometricUnlock => '解锁';

  @override
  String get authBiometricFailed => '生物识别解锁失败，请重试。';

  @override
  String get authBiometricToggle => '生物识别解锁';

  @override
  String get authBiometricToggleHint => '打开应用时要求生物识别';

  @override
  String get authBiometricUnavailable => '此设备不支持生物识别';

  @override
  String get authOnboardingTitle => '患者设置';

  @override
  String get authOnboardingBody => '如医护人员分享了 6 位邀请码，请现在输入。也可稍后在设置中完成。';

  @override
  String get authOnboardingSkip => '暂时跳过';

  @override
  String get authInviteCodeLabel => '医护邀请码';

  @override
  String get authInviteCodeHelper => '6 位数字，24 小时后过期';

  @override
  String get authInviteRedeem => '兑换';

  @override
  String get authInviteRedeemAndContinue => '兑换并继续';

  @override
  String get authInviteInvalidFormat => '邀请码必须为 6 位数字';

  @override
  String get authInviteRedeemedPending => '邀请已兑换，等待医护确认。';

  @override
  String get authInviteRedeemFailed => '无法兑换邀请码';

  @override
  String get authInviteIssueFailed => '无法发放邀请码';

  @override
  String get authConfirmLink => '确认';

  @override
  String get authRejectLink => '拒绝';

  @override
  String get authLinkStatusPending => '待确认';

  @override
  String get settingsSystemDefault => '系统默认';

  @override
  String get settingsLocationTodo => '位置权限将在后续更新中请求';

  @override
  String get providerHomeTab => '首页';

  @override
  String get providerLinkTab => '关联';

  @override
  String get providerHomeTitle => '医护首页';

  @override
  String providerHomeWelcome(String email) {
    return '已登录为 $email';
  }

  @override
  String get providerHomePlaceholder => '临床看板将在后续版本提供。请先关联患者。';

  @override
  String get providerLinkPatientsCta => '关联患者';

  @override
  String get providerLinkTitle => '关联患者';

  @override
  String get providerLinkIntro => '发放 6 位邀请码（24 小时有效）。患者输入后双方确认。';

  @override
  String get providerIssueInviteCta => '发放邀请码';

  @override
  String get providerInviteTtlHint => '24 小时有效';

  @override
  String get providerInviteCopied => '邀请码已复制';

  @override
  String get providerPendingLinks => '待处理关联';

  @override
  String get providerNoPendingLinks => '暂无待处理关联';

  @override
  String providerPendingPatient(String idPrefix) {
    return '患者 $idPrefix…';
  }

  @override
  String get providerRecentInvites => '最近的邀请码';

  @override
  String get providerNoInvites => '尚无邀请码';

  @override
  String get providerInviteConsumed => '已使用';

  @override
  String get providerInviteActive => '有效';
}
