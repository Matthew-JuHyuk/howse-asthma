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
}
