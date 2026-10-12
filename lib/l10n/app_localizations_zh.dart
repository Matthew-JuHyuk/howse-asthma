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
  String get loginEmailLabel => '电子邮件';

  @override
  String get loginPasswordLabel => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get signUpButton => '注册';

  @override
  String get supabaseNotConfigured =>
      '尚未配置 Supabase。\n请在 .env 文件中添加 SUPABASE_URL 和 SUPABASE_ANON_KEY。';

  @override
  String get homeGreeting => '你好';

  @override
  String get homeAirQualityTitle => '附近空气质量';

  @override
  String get homeWeatherTitle => '附近天气';

  @override
  String get asthmaRiskLow => '哮喘风险较低';

  @override
  String get asthmaRiskModerate => '哮喘风险中等';

  @override
  String get asthmaRiskHigh => '哮喘风险较高 — 请采取防护措施';

  @override
  String get medicationLogTitle => '用药记录';

  @override
  String get medicationLogAddButton => '记录吸入器 / 用药';

  @override
  String get medicationNameLabel => '药物名称';

  @override
  String get medicationDoseLabel => '剂量';

  @override
  String get medicationTimeLabel => '用药时间';

  @override
  String get medicationEffectivenessLabel => '是否有效？';

  @override
  String get reportTitle => '保险报告';

  @override
  String get reportGenerateButton => '生成医生 / 保险报告';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguageLabel => '语言';

  @override
  String get settingsLocationLabel => '位置';

  @override
  String get notificationAttackWarningTitle => '哮喘发作风险警报';

  @override
  String get mockContinue => '继续';

  @override
  String get mockSignUpTitle => '创建账户';

  @override
  String get mockChooseRole => '选择你的角色';

  @override
  String get mockRolePatient => '患者';

  @override
  String get mockRolePatientHint => '追踪空气风险与吸入器使用';

  @override
  String get mockRoleProvider => '医护人员';

  @override
  String get mockRoleProviderHint => '不在此设计预览中';

  @override
  String get mockProviderNotInPreview => '医护人员界面不在此患者设计预览中。';

  @override
  String get mockBiometricTitle => '解锁';

  @override
  String get mockBiometricHint => '使用生物识别解锁 Howse Asthma（设计预览）。';

  @override
  String get mockUnlock => '解锁';

  @override
  String get mockUsePassword => '改用密码';

  @override
  String get mockOnboardingTitle => '患者设置';

  @override
  String get mockHomeLocation => '家';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => '紧急联系人';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => '医护邀请码';

  @override
  String get mockFinishOnboarding => '前往首页';

  @override
  String get mockAllScreens => '全部屏幕';

  @override
  String get mockAllScreensHint => '打开任意 Screen ID 进行设计审阅';

  @override
  String get mockStateCalm => 'CALM';

  @override
  String get mockStateWarning => 'WARNING';

  @override
  String get mockHomeCalmMessage => '附近空气尚可。可随时记录吸入器使用。';

  @override
  String get mockHomeWarnMessage => '附近风险升高。减少户外暴露，并准备好吸入器。';

  @override
  String get mockRiskScore => '风险评分';

  @override
  String get mockDummyLocation => '新泽西州纽瓦克附近';

  @override
  String get mockEnvDetail => '环境详情';

  @override
  String get mockForecast => '预报';

  @override
  String get mockForecastHint => '未来几天空气与花粉展望';

  @override
  String get mockAlertPreview => '警报页面';

  @override
  String get mockAlertPreviewHint => '预览风险警报屏幕';

  @override
  String get mockShowWarningHome => '预览 WARNING 首页';

  @override
  String get mockBackToCalmHome => '返回';

  @override
  String get mockPanicCta => '紧急模式';

  @override
  String get mockTrapAxis => 'TRAP / 烟尘';

  @override
  String get mockFloodAxis => '山洪';

  @override
  String get mockPollenAxis => '花粉';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · 花粉展望';

  @override
  String get mockActSurvey => 'ACT 问卷';

  @override
  String get mockActHint => '5 道图示题（4 周）';

  @override
  String get mockPdcCheck => '每日 PDC 检查';

  @override
  String get mockPdcHint => '一键依从性确认';

  @override
  String get mockInhalerEvent => '已记录吸入器';

  @override
  String get mockActIntro => '请根据过去 4 周作答。设计预览 — 答案不会保存。';

  @override
  String get mockQuestion => '问题';

  @override
  String get mockSubmit => '提交';

  @override
  String get mockPdcPrompt => '今天是否服用了控制药物？';

  @override
  String get mockTakenYes => '是的，已服用';

  @override
  String get mockTakenNo => '今天没有';

  @override
  String get mockEvidenceSummary => '你的证据摘要';

  @override
  String get mockEvidenceBody => '用于 PA/LMN 支持的示例摘要。仅设计预览。';

  @override
  String get mockInhalerEvents30d => '吸入器事件（30 天）';

  @override
  String get mockActScore => '最近 ACT';

  @override
  String get mockPdcRate => 'PDC（30 天）';

  @override
  String get mockLocationsTitle => '已保存地点';

  @override
  String get mockLocationsHint => '家庭与工作监测';

  @override
  String get mockWorkLocation => '工作';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => '添加地点';

  @override
  String get mockRewardTitle => '奖励';

  @override
  String get mockDraftBanner => '草稿 — 积分与代金券仅供预览';

  @override
  String get mockPointsBalance => '积分余额';

  @override
  String get mockVoucherTitle => '食品银行代金券';

  @override
  String get mockVoucherHint => '兑换积分（候补名单）';

  @override
  String get mockDonateTitle => '捐赠';

  @override
  String get mockDonateHint => '仅限第三方捐赠';

  @override
  String get mockRewardHistory => '历史';

  @override
  String get mockRewardHistoryHint => '积分与捐赠';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank（演示）';

  @override
  String get mockVoucherCost => '50 积分 · \$10 价值（草稿）';

  @override
  String get mockJoinWaitlist => '加入候补名单';

  @override
  String get mockDonateTransparency =>
      '捐赠通过经核实的第三方非营利平台进行。Howse Asthma 从不存储银行卡信息。';

  @override
  String get mockDonateCta => '打开捐赠（外部）';

  @override
  String get mockExternalOnly => '外部捐赠提供方未在设计预览中接入。';

  @override
  String get mockSignOutPreview => '退出登录（预览）';

  @override
  String get mockOpenAuthFlow => '打开认证流程';

  @override
  String get mockAlertBody => '你附近的风险升高。请查看环境详情。';

  @override
  String get mockDismiss => '关闭';

  @override
  String get mockPanicTitle => '现在需要帮助吗？';

  @override
  String get mockPanicStep1Body => '步骤 1 — 随身带着吸入器。继续查看紧急联系人。';

  @override
  String get mockPanicStep2Title => '呼叫帮助';

  @override
  String get mockPanicStep2Body => '设计预览：按钮不会真正拨号。真机版本中，步骤 2 使用 tel: 链接。';

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
  String get navHome => '首页';

  @override
  String get signUpTitle => '创建账户';

  @override
  String get authChooseRole => '选择你的角色';

  @override
  String get authRolePatient => '患者';

  @override
  String get authRolePatientHint => '追踪空气质量风险与吸入器使用';

  @override
  String get authRoleProvider => '医护人员';

  @override
  String get authRoleProviderHint => '关联患者并查看临床证据';

  @override
  String get authFullNameLabel => '全名';

  @override
  String get authNpiLabel => 'NPI 编号';

  @override
  String get authNpiHelper => '10 位国家医疗服务提供者识别号';

  @override
  String get authOrContinueWith => '或使用以下方式继续';

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
  String get authCompleteProfileBody => '告诉我们你的身份，以便打开正确的首页。';

  @override
  String get authSaveProfile => '保存资料';

  @override
  String get authSignOut => '退出登录';

  @override
  String get authRetry => '重试';

  @override
  String get authWorking => '处理中…';

  @override
  String get authValidationInvalidEmail => '请输入有效的电子邮件';

  @override
  String get authValidationPasswordMin => '密码至少需要 8 个字符';

  @override
  String get authValidationNameRequired => '姓名为必填项';

  @override
  String get authValidationInvalidNpi => '请输入有效的 10 位 NPI';

  @override
  String get authErrorGeneric => '出了点问题。请重试。';

  @override
  String get authErrorInvalidCredentials => '电子邮件或密码无效';

  @override
  String get authErrorEmailTaken => '该电子邮件已有账户';

  @override
  String get authErrorEmailNotConfirmed => '登录前请先确认电子邮件';

  @override
  String get authErrorWeakPassword => '密码太弱';

  @override
  String get authErrorRateLimited => '尝试次数过多。请稍后再试。';

  @override
  String get authBiometricTitle => '解锁 Howse Asthma';

  @override
  String get authBiometricHint => '使用生物识别继续';

  @override
  String get authBiometricReason => '解锁 Howse Asthma';

  @override
  String get authBiometricUnlock => '解锁';

  @override
  String get authBiometricFailed => '生物识别解锁失败。请重试。';

  @override
  String get authBiometricToggle => '生物识别解锁';

  @override
  String get authBiometricToggleHint => '打开应用时要求生物识别解锁';

  @override
  String get authBiometricUnavailable => '此设备不支持生物识别';

  @override
  String get authOnboardingTitle => '患者设置';

  @override
  String get authOnboardingBody => '如果医护人员分享了 8 位邀请码，请现在输入。也可以稍后在设置中完成。';

  @override
  String get authOnboardingSkip => '暂时跳过';

  @override
  String get authInviteCodeLabel => '医护邀请码';

  @override
  String get authInviteCodeHelper => '8 位字母/数字，24 小时后过期';

  @override
  String get authInviteRedeem => '兑换';

  @override
  String get authInviteRedeemAndContinue => '兑换并继续';

  @override
  String get authInviteInvalidFormat => '邀请码必须为 8 位字母或数字';

  @override
  String get authInviteRedeemedPending => '邀请已兑换。等待医护人员确认。';

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
    return '已以 $email 登录';
  }

  @override
  String get providerHomePlaceholder => '患者临床看板将在后续版本提供。请先关联患者。';

  @override
  String get providerLinkPatientsCta => '关联患者';

  @override
  String get providerLinkTitle => '关联患者';

  @override
  String get providerLinkIntro => '发放 8 位邀请码（24 小时有效）。患者输入后双方确认。';

  @override
  String get providerIssueInviteCta => '发放邀请码';

  @override
  String get providerInviteTtlHint => '24 小时有效';

  @override
  String get providerInviteCopied => '邀请码已复制';

  @override
  String get providerPendingLinks => '待处理关联';

  @override
  String get providerNoPendingLinks => '没有待处理关联';

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

  @override
  String get splashTagline => '抵御诱发因素的智能防护盾';

  @override
  String get splashGetStarted => '开始使用';

  @override
  String get splashAlreadyHaveAccount => '已有账户？';

  @override
  String get splashSignIn => '登录';

  @override
  String get authForgotPassword => '忘记密码？';

  @override
  String get authNoAccount => '没有账户？';

  @override
  String get authUseBiometricHint => '使用 Face ID 或指纹解锁';

  @override
  String get authTouchSensorHint => '触摸传感器或看向摄像头';

  @override
  String get navLog => '记录';

  @override
  String get navReport => '报告';

  @override
  String get navRewards => '奖励';

  @override
  String get mockChooseLanguage => '选择语言';

  @override
  String get mockYourLocation => '你的位置';

  @override
  String get mockUseCurrentLocation => '使用当前位置';

  @override
  String get mockLocationTrapOnly => '位置仅用于 TRAP 空气质量数据';

  @override
  String get mockLabelYourPlace => '为地点命名';

  @override
  String get mockSchool => '学校';

  @override
  String get mockWork => '工作';

  @override
  String get mockOther => '其他';

  @override
  String get mockEmergencyOnePerson => '紧急情况下可呼叫的一个人';

  @override
  String get mockContactName => '联系人姓名';

  @override
  String get mockPhoneNumber => '电话号码';

  @override
  String get mockProviderPairing => '医护配对';

  @override
  String get mockPairingOptional => '可选 — 可稍后在设置中添加';

  @override
  String get mockNext => '下一步';

  @override
  String get mockProfessionalProfile => '专业资料';

  @override
  String get mockStep2Of4 => '第 2 步，共 4 步';

  @override
  String get mockTellPractice => '告诉我们你的医疗机构信息';

  @override
  String get mockSpecialtyLabel => '专科';

  @override
  String get mockClinicLabel => '诊所 / 医疗机构名称';

  @override
  String get mockNpiFormatOnly => '仅校验格式。NPI 验证在提交后进行。';

  @override
  String get mockCredentialsSecure => '你的资质信息经加密安全存储。未经同意我们绝不共享医护数据。';

  @override
  String get oneTapFab => '1-Tap';

  @override
  String get oneTapLoggedSnack => '已记录吸入器使用（stub）';

  @override
  String get oneTapLoggedOk => '已记录吸入器使用';

  @override
  String get oneTapLoggedFailed => '无法记录吸入器使用。请重试。';

  @override
  String get homeDailySummary => '这是你的每日摘要';

  @override
  String get homeWarningBanner => '附近风险升高。减少户外暴露，并准备好吸入器。';

  @override
  String get homeEnvFactors => '环境因素';

  @override
  String get homeViewDetails => '查看详情';

  @override
  String get homeFloodActive => '有效警报';

  @override
  String get homeFloodNone => '无';

  @override
  String get homeLastInhalerNone => '尚未记录吸入器使用';

  @override
  String get homeLastInhalerToday => '上次吸入器使用：今天';

  @override
  String homeLastInhalerDays(int days) {
    return '上次吸入器使用：$days 天前';
  }

  @override
  String get locationServiceDisabled => '请开启定位服务以查看附近哮喘风险。';

  @override
  String get locationPermissionDenied => '查看附近空气质量需要位置权限。';

  @override
  String get locationPermissionDeniedForever => '位置权限已被阻止。请打开设置以允许。';

  @override
  String get locationUnavailable => '无法获取位置。下拉刷新或重试。';

  @override
  String get locationOutOfServiceArea => 'Howse Asthma 目前支持美国境内的位置。';

  @override
  String get locationOpenSettings => '打开设置';

  @override
  String get locationStatusGranted => '位置访问已开启';

  @override
  String get njOnlyDataNotice =>
      '仅限 NJ 的数据：货运 AADT 加权仅适用于新泽西。TRAP 仍使用全国空气质量传感器。';

  @override
  String get homeDegradedNotice => '部分空气质量来源不可用。风险可能不完整 — 请谨慎对待。';

  @override
  String logWeekSummary(int count) {
    return '过去 7 天有 $count 次吸入器事件';
  }

  @override
  String get logFilterAll => '全部';

  @override
  String get logFilterRescue => '急救';

  @override
  String get logFilterPanic => '紧急';

  @override
  String get logEmpty => '尚无吸入器事件。请在首页使用 1-Tap。';

  @override
  String get logEventRescue => '吸入器使用';

  @override
  String get logEventPanic => '紧急吸入器使用';

  @override
  String get actTitle => '哮喘检查';

  @override
  String get actPast4Weeks => '在过去 4 周内';

  @override
  String get actQ1 => '哮喘在多大程度上妨碍你在工作、学校或家中完成应有事项？';

  @override
  String get actQ2 => '你出现气短的频率如何？';

  @override
  String get actQ3 => '哮喘症状让你夜间醒来或比平时更早醒来的频率如何？';

  @override
  String get actQ4 => '你使用急救吸入器或雾化器的频率如何？';

  @override
  String get actQ5 => '你如何评价哮喘控制情况？';

  @override
  String get actOpt1 => '一直如此';

  @override
  String get actOpt2 => '大部分时间';

  @override
  String get actOpt3 => '有时';

  @override
  String get actOpt4 => '很少';

  @override
  String get actOpt5 => '从未';

  @override
  String get actQ5Opt1 => '完全未控制';

  @override
  String get actQ5Opt2 => '控制不佳';

  @override
  String get actQ5Opt3 => '有一定控制';

  @override
  String get actQ5Opt4 => '控制良好';

  @override
  String get actQ5Opt5 => '完全控制';

  @override
  String actSaved(int score) {
    return 'ACT 已保存。得分：$score';
  }

  @override
  String get pdcTitle => '每日用药检查';

  @override
  String get pdcSaved => '每日检查已保存';

  @override
  String get pdcAlreadyYes => '你已将今天标记为已服用。可以更新。';

  @override
  String get pdcAlreadyNo => '你已将今天标记为未服用。可以更新。';

  @override
  String pdcStreakHint(int taken, int total, String rate) {
    return '过去 30 天：$total 天中有 $taken 天已服用（$rate）';
  }

  @override
  String get panicEmergencyBadge => '紧急';

  @override
  String get panicBreatheTitle => '呼吸并使用吸入器';

  @override
  String get panicTakeInhalerNow => '立即使用吸入器';

  @override
  String get panicNeedHelp => '我需要更多帮助';

  @override
  String get panicNoAutoDial => '按钮会打开电话拨号盘。绝不会自动拨号。';

  @override
  String panicCallNamed(String name) {
    return '呼叫 $name';
  }

  @override
  String get panicDialFailed => '无法在此设备上打开电话拨号盘。';

  @override
  String get alertTitle => '风险警报';

  @override
  String get alertFcmPendingNote => '若此设备已启用推送，应用在后台时也会收到系统通知。';

  @override
  String get reportEvidenceBody => '供临床或保险审阅的吸入器使用、ACT 与 PDC 摘要。';

  @override
  String get reportShareTodo => '分享 / 导出会随医护人员 PA/LMN 流程一并提供。';

  @override
  String get settingsAlertsTitle => '警报偏好';

  @override
  String get settingsAlertRisk => '风险警报';

  @override
  String get settingsAlertRiskHint => '当综合风险评分达到 3 或更高时';

  @override
  String get settingsAlertHome => '已保存地点警报';

  @override
  String get settingsAlertHomeHint => '当你保存的地点（家、学校、工作）风险升高时';

  @override
  String get settingsAlertLocationEntry => '进入区域警报';

  @override
  String get settingsAlertLocationEntryHint => '当应用打开时你进入更高风险区域时';

  @override
  String get settingsSecurityTitle => '安全';

  @override
  String get emergencyContactRequired => '请输入联系人姓名和电话号码';

  @override
  String get emergencyContactInvalidPhone =>
      '请输入带国家代码的有效电话（E.164），例如 +15551234567';

  @override
  String get emergencyContactSaved => '紧急联系人已保存';

  @override
  String get emergencyContactSave => '保存联系人';

  @override
  String get emergencyContactPhoneHint => '请包含国家代码（E.164），例如 +15551234567';

  @override
  String get commonCancel => '取消';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '删除';

  @override
  String get envTitle => '环境';

  @override
  String get envThreeAxis => '三大风险轴';

  @override
  String get envTrapDetail => '交通相关空气污染代理指标（传感器 + 可选 NJ 货运权重）';

  @override
  String get envTrapTip => '当 TRAP 为高或危急时，请减少户外剧烈活动。';

  @override
  String get envFloodDetail => '附近的 NWS 山洪 / 溪流警报';

  @override
  String get envFloodTipClear => '该区域没有有效的山洪警报。';

  @override
  String get envPollenDetail => 'Google 花粉预报';

  @override
  String get envPollenTip => 'UPI 较高时请关闭窗户，户外活动后冲洗。';

  @override
  String envUsgsRate(String rate) {
    return 'USGS 溪流变化：$rate ft/hr';
  }

  @override
  String envUpdatedAt(String when) {
    return '更新时间：$when';
  }

  @override
  String get envSourcesLabel => '数据来源';

  @override
  String get envOverallCalm => '情况尚可应对。请将吸入器放在附近。';

  @override
  String get forecastIntro => '基于空气质量与花粉预报的下一时段展望。';

  @override
  String get forecastEmpty => '预报序列尚不可用。请下拉刷新。';

  @override
  String get forecastPollenNote =>
      '花粉使用 Google Pollen API（非 Open-Meteo）。MVP 不使用热图。';

  @override
  String forecastDayPollen(int upi, String type) {
    return '花粉 UPI $upi · $type';
  }

  @override
  String forecastDayAqi(int aqi) {
    return '最高美国 AQI $aqi';
  }

  @override
  String get forecastMorning => '上午';

  @override
  String get forecastAfternoon => '下午';

  @override
  String get forecastEvening => '晚上';

  @override
  String get locationsTitle => '我的位置';

  @override
  String get locationsIntro => '应用打开时会检查已保存地点的风险变化。后台系统推送需要 Firebase（下一步）。';

  @override
  String get locationsEmpty => '尚无已保存地点。请添加当前位置。';

  @override
  String get locationsAddTitle => '保存此地';

  @override
  String get locationsNameLabel => '标签';

  @override
  String get locationsAddCurrent => '添加当前位置';

  @override
  String get locationsSaveFailed => '无法更新已保存位置。请重试。';

  @override
  String get locationsCapReached => '最多可保存 10 个地点。请先删除一个再添加。';

  @override
  String get locationsDeleteTitle => '移除地点？';

  @override
  String locationsDeleteBody(String name) {
    return '将“$name”从监测中移除？';
  }

  @override
  String locationsCoords(String lat, String lon) {
    return '$lat, $lon';
  }

  @override
  String get locationsPrimaryBadge => '主要';

  @override
  String get stateOnlyNjApplied => '仅限 NJ：已应用货运 AADT 权重';

  @override
  String get stateOnlyNjNotApplied => '仅限 NJ：未应用货运 AADT 权重';

  @override
  String get stateOnlyNjAppliedHint =>
      '附近的 NJDOT 交通计数提高了 TRAP 权重。空气质量传感器仍在全国适用。';

  @override
  String get stateOnlyNjOutsideHint =>
      '你在新泽西州以外。货运 AADT 加权仅限 NJ；TRAP 仍使用空气传感器。';

  @override
  String get stateOnlyNjNoCountHint =>
      '附近没有 NJDOT 货运计数。TRAP 在无 NJ 货运权重的情况下使用空气质量传感器。';

  @override
  String get settingsDeveloperSection => '开发者';

  @override
  String get settingsApiConsole => 'API 控制台';

  @override
  String get debugApiConsoleBanner => 'DEBUG — 请勿截图用于公开分享';

  @override
  String get appTagline => '抵御诱发因素的智能防护盾';

  @override
  String get welcomeBenefit1 => '空气质量与花粉风险的主动预警';

  @override
  String get welcomeBenefit2 => '每日3秒呼吸自主检查';

  @override
  String get welcomeBenefit3 => '可与医生共享的可信数据报告';

  @override
  String get welcomeContinueEmail => '或使用邮箱继续';

  @override
  String get welcomeTermsAgree => '我同意服务条款与隐私政策';

  @override
  String get welcomeTermsPending => '法律文件链接将在发布后提供。';

  @override
  String get welcomeClinicianLink => '我是临床医护人员';

  @override
  String get checkInWelcomeHome => '欢迎回家！';

  @override
  String get checkInQuestion => '您现在的呼吸状况如何？';

  @override
  String get checkInBreathUsual => '与平时差不多';

  @override
  String get checkInBreathTight => '有点闷';

  @override
  String get checkInBreathSymptoms => '有症状';

  @override
  String get checkInAeroPoints => '首次签到完成！+5 AeroPoints';

  @override
  String get shieldLocationTitle => '启用您的预先防护盾';

  @override
  String get shieldLocationBody => '开启周围预先防护需要位置信息以获取附近空气与花粉。';

  @override
  String get shieldLocationAllow => '允许位置';

  @override
  String get shieldLocationNotNow => '暂不';

  @override
  String get settingsPushMaster => '推送通知';

  @override
  String get settingsPushMasterHint => '此设备上 Howse Asthma 通知总开关';

  @override
  String get pushConsentTitle => '提前了解哮喘诱因';

  @override
  String get pushConsentBody => '附近空气或洪水风险升高时可发送简单提醒，之后也可提示适合开窗的时间。可在设置中随时更改。';

  @override
  String get pushConsentAllow => '允许通知';

  @override
  String get pushConsentNotNow => '暂不';

  @override
  String homeNearPlace(String place) {
    return '靠近 $place';
  }

  @override
  String get homeStaleLocationNotice => '正在等待定位，先显示上次读数。';

  @override
  String get homeStaleRefreshNotice => '正在显示上次读数。有网络时下拉刷新。';

  @override
  String get homeStaleCacheNotice => '此读数可能稍旧，请谨慎参考。';

  @override
  String get homeNowDoThisHeading => '现在这样做可降低发作风险';

  @override
  String get homeDraftBadge => '草案';

  @override
  String get homeNowDoThisFloodTitle => '尽量留在室内';

  @override
  String get homeNowDoThisFloodBody => '洪水警报常意味着潮湿。把吸入器放在身边，避开积水区域。';

  @override
  String get homeNowDoThisTrapTitle => '减少户外活动';

  @override
  String get homeNowDoThisTrapBody => '附近交通相关空气污染偏高。非必要少出门、短时间即可。';

  @override
  String get homeNowDoThisPollenTitle => '暂时关闭窗户';

  @override
  String get homeNowDoThisPollenBody => '花粉偏高。户外归来后洗脸并更换衣物。';

  @override
  String get homeNowDoThisRiskTitle => '户外放慢节奏';

  @override
  String get homeNowDoThisRiskBody => '整体风险偏高。随身带吸入器，呼吸困难时休息。';

  @override
  String get homeNowDoThisCalmTitle => '较适合通风的时段';

  @override
  String get homeNowDoThisCalmBody => '室外空气尚可。短时通风或许有帮助——仍请备好吸入器。';

  @override
  String get homeAdherenceSection => '本周吸入器';

  @override
  String get adherenceWeekHint => '有颜色的日期表示已记录使用（1-Tap）。';

  @override
  String get homeMoldAxis => '霉菌风险';

  @override
  String get homeMoldElevatedDraft => '潮湿信号偏高';

  @override
  String get homeMoldPendingDraft => '湿度数据待定';

  @override
  String get homeFloodAsMoldFactor => '洪水/潮湿因素';

  @override
  String get homeForecastLink => '短期展望';

  @override
  String homeForecastHint(String date, String score) {
    return '次日 $date · 分数 $score';
  }

  @override
  String homeSensorDistance(
    String km,
    String mi,
    String radiusKm,
    String radiusMi,
  ) {
    return '最近传感器 $km km ($mi mi) · 搜索约 $radiusKm km ($radiusMi mi)';
  }

  @override
  String homeSensorNearestOnly(String km, String mi) {
    return '最近传感器 $km km ($mi mi)';
  }

  @override
  String homeSensorRadiusOnly(String km, String mi) {
    return '传感器搜索约 $km km ($mi mi)';
  }

  @override
  String get weekdayMonShort => '一';

  @override
  String get weekdayTueShort => '二';

  @override
  String get weekdayWedShort => '三';

  @override
  String get weekdayThuShort => '四';

  @override
  String get weekdayFriShort => '五';

  @override
  String get weekdaySatShort => '六';

  @override
  String get weekdaySunShort => '日';

  @override
  String get logAdherenceCalendarTitle => '用药日历';

  @override
  String get homeNowDoThisMoldTitle => '降低室内潮湿';

  @override
  String get homeNowDoThisMoldBody => '室外潮湿偏高。如有条件请使用风扇或除湿机，并避开潮湿地下室。';

  @override
  String get homeMoldDetail => '附近潮湿条件（室外估算 — 不是孢子计数）';

  @override
  String get homeMoldTip => '霉菌风险高时尽量保持房间更干。洪水警报会提高潮湿风险。';

  @override
  String homeMoldRh(String pct) {
    return '湿度 $pct%';
  }

  @override
  String homeMoldTempF(String temp) {
    return '$temp°F';
  }

  @override
  String homeMoldDewF(String temp) {
    return '露点 $temp°F';
  }

  @override
  String homeMoldWetHours(int hours) {
    return '潮湿 $hours 小时（24小时）';
  }

  @override
  String get homeMoldProxyDisclaimer => '仅室外估算';

  @override
  String get homeVentilationSnack => '室外空气较平稳 — 短时通风或许有帮助。';

  @override
  String get settingsAlertPositive => '通风提示';

  @override
  String get settingsAlertPositiveHint => '室外空气暂时较好时提示短时开窗（草案规则）';

  @override
  String get settingsBgTitle => '后台刷新';

  @override
  String get settingsBgBody => '使用应用时会刷新附近空气。本版本不请求始终定位。';

  @override
  String get settingsBgRefresh => '使用应用时刷新';

  @override
  String get settingsBgRefreshHint => '移动或保持应用打开时更新风险';

  @override
  String get s5AboutApp => '关于 Howse Asthma';

  @override
  String get s5AboutAppBody =>
      'Howse Asthma 帮你记录症状和吸入器使用情况，并准备就诊时给医生看的摘要。它不会诊断，也不会给出治疗建议。';

  @override
  String get s5ActNotice => '你的回答会保存下来，方便分享给医生。这份问卷没有按官方评分标准核验，所以应用不显示分数。';

  @override
  String get s5ActSaved => '回答已保存。';

  @override
  String get s5ActSubtitle => '关于过去 4 周的 5 个问题';

  @override
  String get s5ActTitle => '哮喘控制问卷';

  @override
  String get s5AddDetails => '添加详情';

  @override
  String get s5AddRecord => '添加记录';

  @override
  String get s5AlertArrive => '到达新地点时';

  @override
  String get s5AlertArriveHint => '当你到达的地方环境更差时。只在应用打开时有效。';

  @override
  String get s5AlertFreshAirHint => '当室外空气质量、花粉和洪水信息都比较平静时。这是一般信息，不是医疗建议。';

  @override
  String get s5AlertSavedPlaces => '已保存的地点';

  @override
  String get s5AlertSavedPlacesHint => '当你保存的地点环境变差时。';

  @override
  String get s5AlertWorse => '环境变差时';

  @override
  String get s5AlertWorseHint => '当你附近的空气质量、花粉或洪水信息变差时。同一条提醒在 1 小时内不会重复。';

  @override
  String get s5AqiGood => '优';

  @override
  String get s5AqiModerate => '良';

  @override
  String get s5AqiUsg => '对敏感人群不健康';

  @override
  String get s5AqiUnhealthy => '不健康';

  @override
  String get s5AqiVeryUnhealthy => '非常不健康';

  @override
  String get s5AqiHazardous => '危害';

  @override
  String s5AqiValue(String category, int aqi) {
    return '$category（AQI $aqi）';
  }

  @override
  String get s5Back => '返回';

  @override
  String get s5BarrierCost => '药费';

  @override
  String get s5BarrierHardToGet => '药不好买到';

  @override
  String get s5BarrierHardToUnderstand => '说明不好懂';

  @override
  String get s5BarrierHowToUse => '药怎么用';

  @override
  String get s5BarrierNone => '没有困难';

  @override
  String get s5BarrierOtherHint => '用自己的话写（可选）';

  @override
  String get s5Cancel => '取消';

  @override
  String get s5Change => '更改';

  @override
  String get s5ChoosePlace => '选择地区';

  @override
  String get s5Close => '关闭';

  @override
  String get s5DataSourcesTitle => '数据来源';

  @override
  String get s5DataSourcesBody =>
      '空气质量：美国 EPA AirNow、Open-Meteo，以及附近的 PurpleAir 传感器。\n花粉：Google Pollen API（Universal Pollen Index）。\n天气和湿度：Open-Meteo。\n洪水警报：美国国家气象局（NWS）。河流水位：美国地质调查局（USGS）。\n交通量（仅新泽西州）：新泽西州交通局（NJDOT）。\n数值可能延迟或缺失。它们描述的是室外环境，不是你的健康状况。';

  @override
  String get s5Delete => '删除';

  @override
  String get s5DeleteConfirm => '删除这条记录？';

  @override
  String get s5DeleteFailed => '无法删除。请再试一次。';

  @override
  String get s5Edit => '编辑';

  @override
  String get s5EnglishVersion => '英文（给医生）';

  @override
  String get s5EntryRemoved => '已撤销这条记录。';

  @override
  String get s5EnvAirDetail =>
      '来自公共监测站和附近传感器的美国 EPA 空气质量指数。它描述你所在地区的室外空气，并不只测量交通尾气。';

  @override
  String get s5EnvAirQuality => '空气质量';

  @override
  String get s5EnvAlertsHeading => '环境提醒';

  @override
  String get s5EnvCardTitle => '今天的周边环境';

  @override
  String get s5EnvFlood => '洪水警报';

  @override
  String get s5EnvFloodDetail => '美国国家气象局（NWS）的公开警报。';

  @override
  String get s5EnvForecast => '环境预报';

  @override
  String get s5EnvHumidity => '湿度';

  @override
  String get s5EnvHumidityDetail => '室外天气数据。不是室内湿度，也不是霉菌测量值。';

  @override
  String get s5EnvLoadFailed => '无法加载环境信息。';

  @override
  String get s5EnvNeedPlace => '选择一个地区后，就能查看周边环境。';

  @override
  String get s5EnvNotAvailable => '无法查看';

  @override
  String get s5EnvOlderNotice => '这是上次查到的信息。';

  @override
  String get s5EnvPollen => '花粉指数';

  @override
  String get s5EnvPollenDetail =>
      'Google 的 Universal Pollen Index，从 0（无）到 5（非常高）。数字低并不表示对每个人都安全。';

  @override
  String get s5EnvSeeDetails => '查看环境详情';

  @override
  String get s5EnvUnavailable => '目前无法查看环境信息。';

  @override
  String get s5FewRecordsNotice => '记录较少，摘要里有些部分可能是空的。';

  @override
  String get s5FgRefreshTitle => '使用应用时刷新环境';

  @override
  String get s5FgRefreshHint => '应用打开时查看你周边的环境。在后台不会运行。';

  @override
  String get s5FieldDate => '日期';

  @override
  String get s5FieldMedication => '药物';

  @override
  String get s5FieldNote => '备注（可选）';

  @override
  String get s5FieldPuffs => '吸入次数（可选）';

  @override
  String get s5FieldReason => '使用原因（可选）';

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
  String get s5FloodIssued => '已发布洪水警报';

  @override
  String get s5FloodNone => '没有发布中的洪水警报';

  @override
  String get s5FloodUnknown => '无法查看警报信息';

  @override
  String s5ForecastCheckedAt(String time) {
    return '查看时间 $time';
  }

  @override
  String s5ForecastValidFor(String date) {
    return '$date 的预报';
  }

  @override
  String get s5FromUrgentHelp => '从紧急帮助记录';

  @override
  String get s5HomeStateEmpty => '先记下第一条记录。之后可以一起整理就诊时要说的内容。';

  @override
  String s5HomeStateQuestions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '有 $n 个问题要告诉医生。',
    );
    return '$_temp0';
  }

  @override
  String s5HomeStateRecords(int n) {
    return '最近 7 天中有记录的天数：$n 天';
  }

  @override
  String get s5HomeSubtitle => '把记录整理好，就诊时可以给医生看。';

  @override
  String get s5HomeTitle => '记录今天的感觉';

  @override
  String s5HumidityValue(int rh) {
    return '室外湿度 $rh%';
  }

  @override
  String get s5IncludeEnvironment => '周边环境（可选）';

  @override
  String get s5IncludeEnvironmentHint => '加入今天的空气质量、花粉和洪水警报。不包含你的具体位置。';

  @override
  String get s5InhalerEditTitle => '吸入器使用详情';

  @override
  String get s5InhalerEntry => '吸入器使用';

  @override
  String get s5InhalerLogged => '已记录吸入器使用。';

  @override
  String get s5InhalerOneEntryHint => '每保存一次就是 1 条使用记录。不会按 1 次吸入或 1 天来计算。';

  @override
  String s5InhalerUnknownCount(int n) {
    return '不知道药名：$n 条';
  }

  @override
  String get s5InsCost => '费用方面的困难';

  @override
  String get s5InsDenial => '拒绝原因（如果有人告诉过你）';

  @override
  String get s5InsMedHistory => '用过的药';

  @override
  String get s5InsuranceIntro => '帮你整理信息，方便医生填写表格。';

  @override
  String get s5InsuranceLimits => '这里的内容都是可选的。本应用不会向保险公司提交任何内容，也不会判断能否获批。';

  @override
  String get s5InsuranceTitle => '准备保险表格';

  @override
  String s5LanguageName(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': '英语',
      'es': '西班牙语',
      'fr': '法语',
      'ko': '韩语',
      'ja': '日语',
      'zh': '中文',
      'other': '其他语言',
    });
    return '$_temp0';
  }

  @override
  String get s5Last30Days => '最近 30 天';

  @override
  String get s5Last7Days => '最近 7 天';

  @override
  String get s5LogInhaler => '记录吸入器';

  @override
  String get s5LogLegend => '每一行是 1 条已保存的记录。没有记录的日子显示为“未记录”，这和 0 不一样。';

  @override
  String get s5LogSymptoms => '记录症状';

  @override
  String get s5MedAdd => '添加药物';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return '用了 $a 天 · 没用 $b 天 · 不记得 $c 天 · 未记录 $d 天';
  }

  @override
  String get s5MedCheckIntro => '这是你自己确认是否用了药。不是根据药房配药数据。';

  @override
  String get s5MedCheckQuestion => '你有按计划用药吗？';

  @override
  String get s5MedCheckTitle => '今天的用药确认';

  @override
  String get s5MedChooseHint => '选择一种药，或选择“我不知道药名”。';

  @override
  String get s5MedDailyCheck => '每天确认';

  @override
  String get s5MedDailyCheckHint => '在首页显示“今天的用药确认”。只有医生让你每天使用这种药时才打开。';

  @override
  String get s5MedDefault => '快速记录时使用的药';

  @override
  String get s5MedDefaultHint => '在首页点“记录吸入器”时使用。';

  @override
  String get s5MedEdit => '编辑药物';

  @override
  String get s5MedNameLabel => '药名（按标签上的写法）';

  @override
  String get s5MedNotApplicable => '今天没有计划使用';

  @override
  String s5MedNotApplicableDays(int n) {
    return '没有计划：$n 天';
  }

  @override
  String get s5MedNotRecorded => '未填写药物';

  @override
  String get s5MedNotSure => '不记得了';

  @override
  String get s5MedNotUsed => '没有用';

  @override
  String get s5MedOther => '其他名称';

  @override
  String get s5MedOtherHint => '输入药名';

  @override
  String get s5MedReasonCost => '费用';

  @override
  String get s5MedReasonForgot => '忘了';

  @override
  String get s5MedReasonNoMedicine => '没有药';

  @override
  String get s5MedReasonQuestion => '原因（可选）';

  @override
  String get s5MedUnknown => '我不知道药名';

  @override
  String get s5MedUnknownShort => '不知道药名';

  @override
  String get s5MedUsed => '用了';

  @override
  String get s5MyLanguage => '我的语言';

  @override
  String get s5MyLogTitle => '我的记录';

  @override
  String get s5MyMedsEmpty => '还没有保存药物。';

  @override
  String get s5MyMedsHint => '用你确认过的药名，可以更快地记录。这不是剂量建议。';

  @override
  String get s5MyMedsOpen => '管理我的药物';

  @override
  String get s5MyMedsTitle => '我的药物';

  @override
  String get s5NavEnvironment => '环境';

  @override
  String get s5NavLog => '记录';

  @override
  String get s5NavVisitPrep => '就诊准备';

  @override
  String get s5NoAnswer => '不想回答';

  @override
  String get s5NoRecordsYet => '还没有记录';

  @override
  String s5NoSymptomDays(int n) {
    return '记为“无症状”的天数：$n 天';
  }

  @override
  String get s5NotRecorded => '未记录';

  @override
  String get s5NotRecordedToday => '今天未记录';

  @override
  String s5NotTranslatedLine(String language, String text) {
    return '[未翻译 · 原文为$language] $text';
  }

  @override
  String get s5OsNotificationsOff => '手机设置里已关闭 Howse Asthma 的通知，所以提醒不会出现。';

  @override
  String get s5PdfAboutMedCheck => '用药确认是患者自己报告的。不是药房配药数据，也不是 PDC（处方覆盖天数比例）。';

  @override
  String get s5PdfAboutNoScore => '不包含问卷分数，也不包含应用生成的风险分数。';

  @override
  String get s5PdfAboutPatientReported =>
      '所有记录都是患者在 Howse Asthma 应用中自行输入的，未经核实。';

  @override
  String get s5PdfAppendix => '附录：患者备注';

  @override
  String s5PdfDaysNotRecorded(int n) {
    return '没有症状记录的天数（未记录）：$n 天';
  }

  @override
  String get s5PdfDisclaimer => '本摘要是供医生查看的患者自述信息。不是诊断，也不是事先授权决定。';

  @override
  String get s5PdfEnvNote => '生成摘要时的一般室外环境。不包含位置。';

  @override
  String get s5PdfFailed => '无法创建 PDF。你输入的内容已保留。请再试一次。';

  @override
  String get s5PdfFontFailed => '无法准备 PDF 字体。请检查网络连接后再试。';

  @override
  String s5PdfGeneratedAt(String time) {
    return '生成时间：$time';
  }

  @override
  String s5PdfInhalerByMed(String name, int n) {
    return '$name：$n 条';
  }

  @override
  String s5PdfInhalerMedNotRecorded(int n) {
    return '未填写药物：$n 条';
  }

  @override
  String s5PdfInhalerUnknown(int n) {
    return '患者不知道药名：$n 条';
  }

  @override
  String s5PdfInhalerUses(int n, int days) {
    return '吸入器使用记录：$n 条（$days 天）';
  }

  @override
  String get s5PdfIsEnglish => 'PDF 用英语生成。你自己输入的文字会原样保留。';

  @override
  String get s5PdfMedNamesAsEntered => '药名按患者输入的原文显示。';

  @override
  String get s5PdfNotRecorded => '未记录';

  @override
  String s5PdfNotUsedReason(String label, int n) {
    return '未用药原因（患者自述）— $label：$n 天';
  }

  @override
  String get s5PdfOutdated => '上次生成 PDF 之后，记录或回答有变化。请重新生成 PDF，才能包含这些更改。';

  @override
  String s5PdfPeriod(String start, String end, int days) {
    return '摘要期间：$start – $end（$days 天）';
  }

  @override
  String s5PdfReasonCount(String label, int n) {
    return '使用原因 — $label：$n 条';
  }

  @override
  String s5PdfRecordedDays(int n) {
    return '有患者记录的天数：$n 天';
  }

  @override
  String get s5PdfSectionAboutData => '关于这些数据';

  @override
  String get s5PdfSectionBarriers => '接受治疗时的困难（患者自述）';

  @override
  String get s5PdfSectionEnvironment => '周边环境（参考）';

  @override
  String get s5PdfSectionInhaler => '吸入器使用';

  @override
  String get s5PdfSectionInsurance => '表格用备注（患者提供）';

  @override
  String get s5PdfSectionMedChecks => '患者自述的用药情况';

  @override
  String get s5PdfSectionQuestions => '患者的问题';

  @override
  String get s5PdfSectionSymptoms => '症状';

  @override
  String s5PdfSymptomCodeDays(String label, int n) {
    return '$label：$n 天';
  }

  @override
  String s5PdfSymptomDays(int n, int days) {
    return '有症状的天数：$days 天中的 $n 天';
  }

  @override
  String s5PdfSymptomOtherDays(int n) {
    return '患者自己写下的其他症状：$n 天';
  }

  @override
  String get s5PdfTitle => '患者自述的哮喘就诊摘要';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return '期间 $days 天 · 有记录的天数 $n 天';
  }

  @override
  String get s5PhoneHint => '请包含国家代码，例如 +1 201 555 0123';

  @override
  String get s5PhoneInvalid => '请输入姓名，以及带国家代码的电话号码，例如 +1 201 555 0123。';

  @override
  String get s5PollenGrass => '草类';

  @override
  String s5PollenMainType(String type) {
    return '主要类型：$type';
  }

  @override
  String get s5PollenTree => '树木';

  @override
  String get s5PollenWeed => '杂草';

  @override
  String get s5PrepareVisit => '准备就诊';

  @override
  String get s5PreviewEditHint => '问题和备注可以回到上一页修改。要改数字，请在“我的记录”里修改原来的记录。';

  @override
  String get s5PreviewSummary => '查看就诊摘要';

  @override
  String get s5PreviewTitle => '就诊摘要预览';

  @override
  String s5PuffsValue(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n 次吸入',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return '问题 $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return '问题 $n/$total';
  }

  @override
  String get s5ReasonBeforeActivity => '活动之前';

  @override
  String get s5ReasonOther => '其他';

  @override
  String get s5ReasonSymptoms => '因为有症状';

  @override
  String s5RecentInhaler(int n) {
    return '吸入器使用记录 $n 条';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return '有症状的天数 $n 天';
  }

  @override
  String get s5RecentTitle => '最近 7 天';

  @override
  String get s5RecordsLoadFailed => '无法加载记录。请再试一次。';

  @override
  String get s5RecordsManageHint => '可以在“我的记录”里编辑或删除。删除前总会请你确认。';

  @override
  String get s5Refresh => '刷新';

  @override
  String get s5Reload => '重新加载';

  @override
  String get s5Save => '保存';

  @override
  String get s5Saved => '已保存。';

  @override
  String get s5SavedPlacesHint => '已保存的地点，例如家、学校或工作地点';

  @override
  String get s5SaveFailed => '无法保存。你输入的内容还在。';

  @override
  String get s5SavePdf => '保存 PDF';

  @override
  String get s5SettingsAlerts => '提醒';

  @override
  String get s5SettingsArea => '地区';

  @override
  String get s5SettingsHelp => '帮助';

  @override
  String get s5SettingsLanguageNote => '就诊摘要会用英语生成。分享之前，可以和你自己的语言对照查看。';

  @override
  String get s5SettingsSecurityData => '安全与数据';

  @override
  String get s5Share => '分享';

  @override
  String get s5SourcesAir => '空气质量：EPA AirNow、Open-Meteo、PurpleAir';

  @override
  String get s5SourcesFlood => '洪水警报：美国国家气象局';

  @override
  String get s5SourcesNjTraffic => '交通量数据只在新泽西州使用。';

  @override
  String get s5SourcesNoRiskScore => '应用内部的综合分数不是哮喘发作风险，也不会显示。';

  @override
  String get s5SourcesPollen => '花粉：Google Pollen API';

  @override
  String get s5SourcesTitle => '来源与限制';

  @override
  String get s5SourcesWeather => '天气和湿度：Open-Meteo';

  @override
  String get s5StatusLatest => '最新';

  @override
  String get s5StatusOlder => '较早的数据';

  @override
  String get s5StatusUnavailable => '现在无法查看';

  @override
  String get s5SymActivityLimited => '活动受限';

  @override
  String get s5SymCough => '咳嗽';

  @override
  String get s5SymNightWaking => '夜里醒来';

  @override
  String get s5SymNone => '无症状';

  @override
  String get s5SymOther => '自己填写';

  @override
  String get s5SymOtherHint => '用自己的话描述';

  @override
  String get s5SymShortBreath => '呼吸困难';

  @override
  String get s5SymWheeze => '喘鸣';

  @override
  String get s5SymptomEditTitle => '编辑症状';

  @override
  String get s5SymptomEntry => '症状';

  @override
  String get s5SymptomNoneHint => '你没有记录的日子会显示为“未记录”，而不是“无症状”。';

  @override
  String get s5SymptomQuestion => '你有哪些症状？';

  @override
  String get s5Today => '今天';

  @override
  String get s5Undo => '撤销';

  @override
  String s5UntranslatedNotice(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '有 $n 项没有翻译。它们会以原文出现在英文 PDF 中，并标有 “Not translated”。请核对原文。',
    );
    return '$_temp0';
  }

  @override
  String s5UpdatedAt(String time) {
    return '更新于 $time';
  }

  @override
  String get s5UpiHigh => '高';

  @override
  String get s5UpiLow => '低';

  @override
  String get s5UpiModerate => '中等';

  @override
  String get s5UpiNone => '无';

  @override
  String s5UpiValue(int upi, String category) {
    return '5 分中的 $upi · $category';
  }

  @override
  String get s5UpiVeryHigh => '非常高';

  @override
  String get s5UpiVeryLow => '非常低';

  @override
  String get s5UrgentActionPlan => '如果医生给过你哮喘行动计划，请按那个计划做。';

  @override
  String get s5UrgentCall911Locked => '紧急帮助：拨打 911';

  @override
  String get s5UrgentHelp => '紧急帮助';

  @override
  String get s5UrgentIntro => '如果呼吸非常困难，或没有好转，请拨打 911。';

  @override
  String get s5UrgentLogHint => '可选：可以记下你使用了吸入器。';

  @override
  String get s5UrgentNoContact => '还没有紧急联系人。请在设置 → 帮助里添加。';

  @override
  String s5UsingMedication(String name) {
    return '将记录为：$name';
  }

  @override
  String get s5ViewMyLog => '查看我的记录';

  @override
  String get s5VisitBarriers => '接受治疗时有没有遇到困难？';

  @override
  String s5VisitCardDetail(int days, int recorded, int questions) {
    return '最近 $days 天 · 有记录 $recorded 天 · 问题 $questions 个';
  }

  @override
  String get s5VisitCardTitle => '就诊时要给医生看的内容';

  @override
  String get s5VisitInclude => '要包含的记录';

  @override
  String get s5VisitIntro => '整理你的症状和想问的问题，给医生看。';

  @override
  String get s5VisitPeriod => '摘要期间';

  @override
  String get s5VisitPrepTitle => '就诊准备';

  @override
  String get s5VisitQuestions => '想问医生的问题';

  @override
  String get s5VisitQuestionsHint => '用你自己的语言写。可以留空。';

  @override
  String get s6AddTime => '添加时间';

  @override
  String get s6AddVisit => '添加我报告的就诊';

  @override
  String get s6BringPaper => '我会带上文件';

  @override
  String get s6BringPaperHint => '有文件并不表示医生已经确认。';

  @override
  String s6DaySummary(
    String date,
    int used,
    int scheduled,
    int open,
    int symptoms,
    String env,
  ) {
    return '$date · 已确认 $used/$scheduled · 未回复 $open · 症状 $symptoms · $env';
  }

  @override
  String get s6DoseLater => '稍后确认';

  @override
  String get s6DoseNotUsed => '没能使用';

  @override
  String get s6DoseUnconfirmed => '还没有回复';

  @override
  String get s6DoseUsed => '我用了';

  @override
  String get s6EnvLinked => '已连接环境资料';

  @override
  String get s6EnvNoData => '该时间没有环境资料';

  @override
  String get s6EvidenceBody => '整理给医生查看的记录，以及还需要补充的信息。';

  @override
  String get s6EvidenceNotOfficial => '这是一份一般资料清单。不是某一保险的正式要求清单。';

  @override
  String get s6EvidenceTitle => '就诊与保险审核资料准备';

  @override
  String get s6HideMedName => '在锁屏上隐藏药名';

  @override
  String get s6HideMedNameHint => '提醒只在你保存的服药时间出现。不是每 30 分钟一次的提醒。';

  @override
  String get s6HomeWaterNo => '没有';

  @override
  String get s6HomeWaterQuestion => '家里有漏水或进水吗？';

  @override
  String get s6HomeWaterYes => '有';

  @override
  String get s6ItemClinician => '医生确认，或要带去的资料';

  @override
  String get s6ItemEnvironment => '事件当时的当地环境参考';

  @override
  String get s6ItemMedication => '药名和处方内容';

  @override
  String get s6ItemSymptoms => '持续的症状和对日常生活的影响';

  @override
  String get s6ItemUse => '使用期间和你确认过的使用记录';

  @override
  String get s6ItemVisits => '你报告的就诊和急诊';

  @override
  String get s6NoSchedule => '还没有保存服药时间。请在“我的药物”里添加。';

  @override
  String get s6OccurredLabel => '发生时间';

  @override
  String get s6PdfEnvLimit =>
      '这只是地区参考。不能说明个人暴露，也不能说明症状原因。单个 AQI 不会同时指出臭氧和颗粒物，也不包含花粉。';

  @override
  String get s6PdfEnvTitle => '环境参考（附录）';

  @override
  String get s6PuffsEach => '每次吸入次数';

  @override
  String s6ReminderBodyNamed(String name) {
    return '请确认 $name';
  }

  @override
  String get s6ReminderBodyPrivate => '请确认用药';

  @override
  String get s6ReminderChannel => '按你保存的服药时间提醒。不是每 30 分钟一次的提醒。';

  @override
  String get s6ReminderTitle => '用药确认';

  @override
  String get s6RoleBoth => '每天以及需要时';

  @override
  String get s6RoleController => '每天使用的药';

  @override
  String get s6RoleRescue => '需要时使用';

  @override
  String get s6ScheduleTimes => '服药时间';

  @override
  String get s6StatusClinician => '需要医生确认';

  @override
  String get s6StatusNeedInfo => '需要补充信息';

  @override
  String get s6StatusRecorded => '已有记录';

  @override
  String get s6TimelineTitle => '治疗与环境';

  @override
  String get s6TodayDoses => '今天要确认的药';

  @override
  String get s6VisitKindEr => '急诊（我报告的）';

  @override
  String get s6VisitKindOffice => '门诊（我报告的）';

  @override
  String get s6VisitKindOther => '其他就诊（我报告的）';

  @override
  String get s6VisitKindUrgent => '紧急诊疗（我报告的）';
}
