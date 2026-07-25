import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Howse Asthma'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginTitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginButton;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signUpButton;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get homeGreeting;

  /// No description provided for @homeAirQualityTitle.
  ///
  /// In en, this message translates to:
  /// **'Air Quality Near You'**
  String get homeAirQualityTitle;

  /// No description provided for @homeWeatherTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather Near You'**
  String get homeWeatherTitle;

  /// No description provided for @asthmaRiskLow.
  ///
  /// In en, this message translates to:
  /// **'Low asthma risk'**
  String get asthmaRiskLow;

  /// No description provided for @asthmaRiskModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate asthma risk'**
  String get asthmaRiskModerate;

  /// No description provided for @asthmaRiskHigh.
  ///
  /// In en, this message translates to:
  /// **'High asthma risk - take precautions'**
  String get asthmaRiskHigh;

  /// No description provided for @medicationLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Medication Log'**
  String get medicationLogTitle;

  /// No description provided for @medicationLogAddButton.
  ///
  /// In en, this message translates to:
  /// **'Log Inhaler / Medication Use'**
  String get medicationLogAddButton;

  /// No description provided for @medicationNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Medication Name'**
  String get medicationNameLabel;

  /// No description provided for @medicationDoseLabel.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get medicationDoseLabel;

  /// No description provided for @medicationTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time Taken'**
  String get medicationTimeLabel;

  /// No description provided for @medicationEffectivenessLabel.
  ///
  /// In en, this message translates to:
  /// **'Did it help?'**
  String get medicationEffectivenessLabel;

  /// No description provided for @reportTitle.
  ///
  /// In en, this message translates to:
  /// **'Insurance Report'**
  String get reportTitle;

  /// No description provided for @reportGenerateButton.
  ///
  /// In en, this message translates to:
  /// **'Generate Report for Doctor / Insurance'**
  String get reportGenerateButton;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageLabel;

  /// No description provided for @settingsLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get settingsLocationLabel;

  /// No description provided for @notificationAttackWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Asthma Attack Risk Alert'**
  String get notificationAttackWarningTitle;

  /// No description provided for @mockContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get mockContinue;

  /// No description provided for @mockSignUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get mockSignUpTitle;

  /// No description provided for @mockChooseRole.
  ///
  /// In en, this message translates to:
  /// **'Choose your role'**
  String get mockChooseRole;

  /// No description provided for @mockRolePatient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get mockRolePatient;

  /// No description provided for @mockRolePatientHint.
  ///
  /// In en, this message translates to:
  /// **'Track air risk and inhaler use'**
  String get mockRolePatientHint;

  /// No description provided for @mockRoleProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get mockRoleProvider;

  /// No description provided for @mockRoleProviderHint.
  ///
  /// In en, this message translates to:
  /// **'Not in this design preview'**
  String get mockRoleProviderHint;

  /// No description provided for @mockProviderNotInPreview.
  ///
  /// In en, this message translates to:
  /// **'Provider screens are not in this patient design preview.'**
  String get mockProviderNotInPreview;

  /// No description provided for @mockBiometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get mockBiometricTitle;

  /// No description provided for @mockBiometricHint.
  ///
  /// In en, this message translates to:
  /// **'Use biometrics to unlock Howse Asthma (design preview).'**
  String get mockBiometricHint;

  /// No description provided for @mockUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get mockUnlock;

  /// No description provided for @mockUsePassword.
  ///
  /// In en, this message translates to:
  /// **'Use password instead'**
  String get mockUsePassword;

  /// No description provided for @mockOnboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient setup'**
  String get mockOnboardingTitle;

  /// No description provided for @mockHomeLocation.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get mockHomeLocation;

  /// No description provided for @mockDummyAddress.
  ///
  /// In en, this message translates to:
  /// **'123 Main St, Newark, NJ'**
  String get mockDummyAddress;

  /// No description provided for @mockEmergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact'**
  String get mockEmergencyContact;

  /// No description provided for @mockDummyContact.
  ///
  /// In en, this message translates to:
  /// **'Alex Guardian · +1 555 0100'**
  String get mockDummyContact;

  /// No description provided for @mockInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Provider invite code'**
  String get mockInviteCode;

  /// No description provided for @mockFinishOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Go to home'**
  String get mockFinishOnboarding;

  /// No description provided for @mockAllScreens.
  ///
  /// In en, this message translates to:
  /// **'All screens'**
  String get mockAllScreens;

  /// No description provided for @mockAllScreensHint.
  ///
  /// In en, this message translates to:
  /// **'Open any Screen ID for design review'**
  String get mockAllScreensHint;

  /// No description provided for @mockStateCalm.
  ///
  /// In en, this message translates to:
  /// **'CALM'**
  String get mockStateCalm;

  /// No description provided for @mockStateWarning.
  ///
  /// In en, this message translates to:
  /// **'WARNING'**
  String get mockStateWarning;

  /// No description provided for @mockHomeCalmMessage.
  ///
  /// In en, this message translates to:
  /// **'Air looks manageable nearby. Log inhaler use anytime.'**
  String get mockHomeCalmMessage;

  /// No description provided for @mockHomeWarnMessage.
  ///
  /// In en, this message translates to:
  /// **'Elevated risk nearby. Limit outdoor exposure and keep your inhaler ready.'**
  String get mockHomeWarnMessage;

  /// No description provided for @mockRiskScore.
  ///
  /// In en, this message translates to:
  /// **'Risk score'**
  String get mockRiskScore;

  /// No description provided for @mockDummyLocation.
  ///
  /// In en, this message translates to:
  /// **'Near Newark, NJ'**
  String get mockDummyLocation;

  /// No description provided for @mockEnvDetail.
  ///
  /// In en, this message translates to:
  /// **'Environment detail'**
  String get mockEnvDetail;

  /// No description provided for @mockForecast.
  ///
  /// In en, this message translates to:
  /// **'Forecast'**
  String get mockForecast;

  /// No description provided for @mockForecastHint.
  ///
  /// In en, this message translates to:
  /// **'Next days air & pollen outlook'**
  String get mockForecastHint;

  /// No description provided for @mockAlertPreview.
  ///
  /// In en, this message translates to:
  /// **'Alert landing'**
  String get mockAlertPreview;

  /// No description provided for @mockAlertPreviewHint.
  ///
  /// In en, this message translates to:
  /// **'Preview risk alert screen'**
  String get mockAlertPreviewHint;

  /// No description provided for @mockShowWarningHome.
  ///
  /// In en, this message translates to:
  /// **'Preview WARNING home'**
  String get mockShowWarningHome;

  /// No description provided for @mockBackToCalmHome.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get mockBackToCalmHome;

  /// No description provided for @mockPanicCta.
  ///
  /// In en, this message translates to:
  /// **'Panic mode'**
  String get mockPanicCta;

  /// No description provided for @mockTrapAxis.
  ///
  /// In en, this message translates to:
  /// **'TRAP / soot'**
  String get mockTrapAxis;

  /// No description provided for @mockFloodAxis.
  ///
  /// In en, this message translates to:
  /// **'Flash flood'**
  String get mockFloodAxis;

  /// No description provided for @mockPollenAxis.
  ///
  /// In en, this message translates to:
  /// **'Pollen'**
  String get mockPollenAxis;

  /// No description provided for @mockForecastDayHint.
  ///
  /// In en, this message translates to:
  /// **'AQI · TRAP · Pollen outlook'**
  String get mockForecastDayHint;

  /// No description provided for @mockActSurvey.
  ///
  /// In en, this message translates to:
  /// **'ACT survey'**
  String get mockActSurvey;

  /// No description provided for @mockActHint.
  ///
  /// In en, this message translates to:
  /// **'5 pictogram questions (4 weeks)'**
  String get mockActHint;

  /// No description provided for @mockPdcCheck.
  ///
  /// In en, this message translates to:
  /// **'Daily PDC check'**
  String get mockPdcCheck;

  /// No description provided for @mockPdcHint.
  ///
  /// In en, this message translates to:
  /// **'One-tap adherence'**
  String get mockPdcHint;

  /// No description provided for @mockInhalerEvent.
  ///
  /// In en, this message translates to:
  /// **'Inhaler logged'**
  String get mockInhalerEvent;

  /// No description provided for @mockActIntro.
  ///
  /// In en, this message translates to:
  /// **'Answer based on the last 4 weeks. Design preview — answers are not saved.'**
  String get mockActIntro;

  /// No description provided for @mockQuestion.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get mockQuestion;

  /// No description provided for @mockSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get mockSubmit;

  /// No description provided for @mockPdcPrompt.
  ///
  /// In en, this message translates to:
  /// **'Did you take your controller medicine today?'**
  String get mockPdcPrompt;

  /// No description provided for @mockTakenYes.
  ///
  /// In en, this message translates to:
  /// **'Yes, I took it'**
  String get mockTakenYes;

  /// No description provided for @mockTakenNo.
  ///
  /// In en, this message translates to:
  /// **'Not today'**
  String get mockTakenNo;

  /// No description provided for @mockEvidenceSummary.
  ///
  /// In en, this message translates to:
  /// **'Your evidence summary'**
  String get mockEvidenceSummary;

  /// No description provided for @mockEvidenceBody.
  ///
  /// In en, this message translates to:
  /// **'Dummy summary for PA/LMN support. Design preview only.'**
  String get mockEvidenceBody;

  /// No description provided for @mockInhalerEvents30d.
  ///
  /// In en, this message translates to:
  /// **'Inhaler events (30d)'**
  String get mockInhalerEvents30d;

  /// No description provided for @mockActScore.
  ///
  /// In en, this message translates to:
  /// **'Latest ACT'**
  String get mockActScore;

  /// No description provided for @mockPdcRate.
  ///
  /// In en, this message translates to:
  /// **'PDC (30d)'**
  String get mockPdcRate;

  /// No description provided for @mockLocationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved places'**
  String get mockLocationsTitle;

  /// No description provided for @mockLocationsHint.
  ///
  /// In en, this message translates to:
  /// **'Home and work monitoring'**
  String get mockLocationsHint;

  /// No description provided for @mockWorkLocation.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get mockWorkLocation;

  /// No description provided for @mockDummyWorkAddress.
  ///
  /// In en, this message translates to:
  /// **'1 Market St, Jersey City, NJ'**
  String get mockDummyWorkAddress;

  /// No description provided for @mockAddLocation.
  ///
  /// In en, this message translates to:
  /// **'Add place'**
  String get mockAddLocation;

  /// No description provided for @mockRewardTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get mockRewardTitle;

  /// No description provided for @mockDraftBanner.
  ///
  /// In en, this message translates to:
  /// **'DRAFT — points & vouchers are preview only'**
  String get mockDraftBanner;

  /// No description provided for @mockPointsBalance.
  ///
  /// In en, this message translates to:
  /// **'Points balance'**
  String get mockPointsBalance;

  /// No description provided for @mockVoucherTitle.
  ///
  /// In en, this message translates to:
  /// **'Food bank voucher'**
  String get mockVoucherTitle;

  /// No description provided for @mockVoucherHint.
  ///
  /// In en, this message translates to:
  /// **'Exchange points (waitlist)'**
  String get mockVoucherHint;

  /// No description provided for @mockDonateTitle.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get mockDonateTitle;

  /// No description provided for @mockDonateHint.
  ///
  /// In en, this message translates to:
  /// **'Third-party giving only'**
  String get mockDonateHint;

  /// No description provided for @mockRewardHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get mockRewardHistory;

  /// No description provided for @mockRewardHistoryHint.
  ///
  /// In en, this message translates to:
  /// **'Points and donations'**
  String get mockRewardHistoryHint;

  /// No description provided for @mockDummyFoodBank.
  ///
  /// In en, this message translates to:
  /// **'NJ Community Food Bank (demo)'**
  String get mockDummyFoodBank;

  /// No description provided for @mockVoucherCost.
  ///
  /// In en, this message translates to:
  /// **'50 points · \$10 value (draft)'**
  String get mockVoucherCost;

  /// No description provided for @mockJoinWaitlist.
  ///
  /// In en, this message translates to:
  /// **'Join waitlist'**
  String get mockJoinWaitlist;

  /// No description provided for @mockDonateTransparency.
  ///
  /// In en, this message translates to:
  /// **'Donations go through a verified third-party nonprofit platform. Howse Asthma never stores card details.'**
  String get mockDonateTransparency;

  /// No description provided for @mockDonateCta.
  ///
  /// In en, this message translates to:
  /// **'Open donate (external)'**
  String get mockDonateCta;

  /// No description provided for @mockExternalOnly.
  ///
  /// In en, this message translates to:
  /// **'External donation provider is not wired in design preview.'**
  String get mockExternalOnly;

  /// No description provided for @mockSignOutPreview.
  ///
  /// In en, this message translates to:
  /// **'Sign out (preview)'**
  String get mockSignOutPreview;

  /// No description provided for @mockOpenAuthFlow.
  ///
  /// In en, this message translates to:
  /// **'Open auth flow'**
  String get mockOpenAuthFlow;

  /// No description provided for @mockAlertBody.
  ///
  /// In en, this message translates to:
  /// **'Risk rose near your location. Review environment details.'**
  String get mockAlertBody;

  /// No description provided for @mockDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get mockDismiss;

  /// No description provided for @mockPanicTitle.
  ///
  /// In en, this message translates to:
  /// **'Need help now?'**
  String get mockPanicTitle;

  /// No description provided for @mockPanicStep1Body.
  ///
  /// In en, this message translates to:
  /// **'Step 1 — Stay with your inhaler. Continue for emergency contacts.'**
  String get mockPanicStep1Body;

  /// No description provided for @mockPanicStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Call for help'**
  String get mockPanicStep2Title;

  /// No description provided for @mockPanicStep2Body.
  ///
  /// In en, this message translates to:
  /// **'Design preview: buttons do not place a real call. On device builds, Step 2 uses tel: links.'**
  String get mockPanicStep2Body;

  /// No description provided for @mockCall911.
  ///
  /// In en, this message translates to:
  /// **'Call 911'**
  String get mockCall911;

  /// No description provided for @mockCallGuardian.
  ///
  /// In en, this message translates to:
  /// **'Call emergency contact'**
  String get mockCallGuardian;

  /// No description provided for @mockFeelingBetter.
  ///
  /// In en, this message translates to:
  /// **'I am feeling better'**
  String get mockFeelingBetter;

  /// No description provided for @mockTabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get mockTabHome;

  /// No description provided for @mockTabLog.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get mockTabLog;

  /// No description provided for @mockTabReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get mockTabReport;

  /// No description provided for @mockTabReward.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get mockTabReward;

  /// No description provided for @mockTabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get mockTabSettings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'es',
    'fr',
    'ja',
    'ko',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
