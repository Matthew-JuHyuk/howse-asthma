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
}
