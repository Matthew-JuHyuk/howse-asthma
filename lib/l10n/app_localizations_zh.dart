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
}
