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
}
