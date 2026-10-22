import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_ht.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
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
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('gu'),
    Locale('ht'),
    Locale('ko'),
    Locale('pt'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'CoverNote'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
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
  /// **'Log in'**
  String get loginButton;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUpButton;

  /// Shown when Supabase env vars are missing
  ///
  /// In en, this message translates to:
  /// **'Supabase is not configured yet.\nAdd SUPABASE_URL and SUPABASE_ANON_KEY to your .env file.'**
  String get supabaseNotConfigured;

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

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @signUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get signUpTitle;

  /// No description provided for @authChooseRole.
  ///
  /// In en, this message translates to:
  /// **'Choose your role'**
  String get authChooseRole;

  /// No description provided for @authRolePatient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get authRolePatient;

  /// No description provided for @authRolePatientHint.
  ///
  /// In en, this message translates to:
  /// **'Track air quality risk and inhaler use'**
  String get authRolePatientHint;

  /// No description provided for @authRoleProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get authRoleProvider;

  /// No description provided for @authRoleProviderHint.
  ///
  /// In en, this message translates to:
  /// **'Link patients and review clinical evidence'**
  String get authRoleProviderHint;

  /// No description provided for @authFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get authFullNameLabel;

  /// No description provided for @authNpiLabel.
  ///
  /// In en, this message translates to:
  /// **'NPI number'**
  String get authNpiLabel;

  /// No description provided for @authNpiHelper.
  ///
  /// In en, this message translates to:
  /// **'10-digit National Provider Identifier'**
  String get authNpiHelper;

  /// No description provided for @authOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get authOrContinueWith;

  /// No description provided for @authContinueGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authContinueGoogle;

  /// No description provided for @authContinueApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authContinueApple;

  /// No description provided for @authCheckEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get authCheckEmailTitle;

  /// No description provided for @authCheckEmailBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a confirmation link to {email}. Open it, then sign in.'**
  String authCheckEmailBody(String email);

  /// No description provided for @authBackToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get authBackToSignIn;

  /// No description provided for @authCompleteProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get authCompleteProfileTitle;

  /// No description provided for @authCompleteProfileBody.
  ///
  /// In en, this message translates to:
  /// **'Tell us who you are so we can open the right home screen.'**
  String get authCompleteProfileBody;

  /// No description provided for @authSaveProfile.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get authSaveProfile;

  /// No description provided for @authSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get authSignOut;

  /// No description provided for @authRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get authRetry;

  /// No description provided for @authWorking.
  ///
  /// In en, this message translates to:
  /// **'Working…'**
  String get authWorking;

  /// No description provided for @authValidationInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get authValidationInvalidEmail;

  /// No description provided for @authValidationPasswordMin.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get authValidationPasswordMin;

  /// No description provided for @authValidationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get authValidationNameRequired;

  /// No description provided for @authValidationInvalidNpi.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 10-digit NPI'**
  String get authValidationInvalidNpi;

  /// No description provided for @authErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authErrorGeneric;

  /// No description provided for @authErrorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get authErrorInvalidCredentials;

  /// No description provided for @authErrorEmailTaken.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists'**
  String get authErrorEmailTaken;

  /// No description provided for @authErrorEmailNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirm your email before signing in'**
  String get authErrorEmailNotConfirmed;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Try again later.'**
  String get authErrorRateLimited;

  /// No description provided for @authBiometricTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Howse Asthma'**
  String get authBiometricTitle;

  /// No description provided for @authBiometricHint.
  ///
  /// In en, this message translates to:
  /// **'Use biometrics to continue'**
  String get authBiometricHint;

  /// No description provided for @authBiometricReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Howse Asthma'**
  String get authBiometricReason;

  /// No description provided for @authBiometricUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get authBiometricUnlock;

  /// No description provided for @authBiometricFailed.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock failed. Try again.'**
  String get authBiometricFailed;

  /// No description provided for @authBiometricToggle.
  ///
  /// In en, this message translates to:
  /// **'Biometric unlock'**
  String get authBiometricToggle;

  /// No description provided for @authBiometricToggleHint.
  ///
  /// In en, this message translates to:
  /// **'Require biometric unlock when opening the app'**
  String get authBiometricToggleHint;

  /// No description provided for @authBiometricUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Biometrics are not available on this device'**
  String get authBiometricUnavailable;

  /// No description provided for @authOnboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient setup'**
  String get authOnboardingTitle;

  /// No description provided for @authOnboardingBody.
  ///
  /// In en, this message translates to:
  /// **'If your clinician shared an 8-character invite code, enter it now. You can also do this later in Settings.'**
  String get authOnboardingBody;

  /// No description provided for @authOnboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get authOnboardingSkip;

  /// No description provided for @authInviteCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Provider invite code'**
  String get authInviteCodeLabel;

  /// No description provided for @authInviteCodeHelper.
  ///
  /// In en, this message translates to:
  /// **'8 letters/numbers, expires in 24 hours'**
  String get authInviteCodeHelper;

  /// No description provided for @authInviteRedeem.
  ///
  /// In en, this message translates to:
  /// **'Redeem'**
  String get authInviteRedeem;

  /// No description provided for @authInviteRedeemAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Redeem and continue'**
  String get authInviteRedeemAndContinue;

  /// No description provided for @authInviteInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Invite code must be 8 letters or numbers'**
  String get authInviteInvalidFormat;

  /// No description provided for @authInviteRedeemedPending.
  ///
  /// In en, this message translates to:
  /// **'Invite redeemed. Waiting for provider confirmation.'**
  String get authInviteRedeemedPending;

  /// No description provided for @authInviteRedeemFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not redeem invite code'**
  String get authInviteRedeemFailed;

  /// No description provided for @authInviteIssueFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not issue invite code'**
  String get authInviteIssueFailed;

  /// No description provided for @authConfirmLink.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get authConfirmLink;

  /// No description provided for @authRejectLink.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get authRejectLink;

  /// No description provided for @authLinkStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending confirmation'**
  String get authLinkStatusPending;

  /// No description provided for @settingsSystemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsSystemDefault;

  /// No description provided for @settingsLocationTodo.
  ///
  /// In en, this message translates to:
  /// **'Location permission will be requested in a later update'**
  String get settingsLocationTodo;

  /// No description provided for @providerHomeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get providerHomeTab;

  /// No description provided for @providerLinkTab.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get providerLinkTab;

  /// No description provided for @providerHomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Provider home'**
  String get providerHomeTitle;

  /// No description provided for @providerHomeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String providerHomeWelcome(String email);

  /// No description provided for @providerHomePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Patient clinical dashboards arrive in a later release. Start by linking patients.'**
  String get providerHomePlaceholder;

  /// No description provided for @providerLinkPatientsCta.
  ///
  /// In en, this message translates to:
  /// **'Link patients'**
  String get providerLinkPatientsCta;

  /// No description provided for @providerLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Link patients'**
  String get providerLinkTitle;

  /// No description provided for @providerLinkIntro.
  ///
  /// In en, this message translates to:
  /// **'Issue an 8-character code (valid 24 hours). The patient enters it, then both sides confirm.'**
  String get providerLinkIntro;

  /// No description provided for @providerIssueInviteCta.
  ///
  /// In en, this message translates to:
  /// **'Issue invite code'**
  String get providerIssueInviteCta;

  /// No description provided for @providerInviteTtlHint.
  ///
  /// In en, this message translates to:
  /// **'Valid for 24 hours'**
  String get providerInviteTtlHint;

  /// No description provided for @providerInviteCopied.
  ///
  /// In en, this message translates to:
  /// **'Invite code copied'**
  String get providerInviteCopied;

  /// No description provided for @providerPendingLinks.
  ///
  /// In en, this message translates to:
  /// **'Pending links'**
  String get providerPendingLinks;

  /// No description provided for @providerNoPendingLinks.
  ///
  /// In en, this message translates to:
  /// **'No pending links'**
  String get providerNoPendingLinks;

  /// No description provided for @providerPendingPatient.
  ///
  /// In en, this message translates to:
  /// **'Patient {idPrefix}…'**
  String providerPendingPatient(String idPrefix);

  /// No description provided for @providerRecentInvites.
  ///
  /// In en, this message translates to:
  /// **'Recent invite codes'**
  String get providerRecentInvites;

  /// No description provided for @providerNoInvites.
  ///
  /// In en, this message translates to:
  /// **'No invite codes yet'**
  String get providerNoInvites;

  /// No description provided for @providerInviteConsumed.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get providerInviteConsumed;

  /// No description provided for @providerInviteActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get providerInviteActive;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'Your smart shield against triggers'**
  String get splashTagline;

  /// No description provided for @splashGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get splashGetStarted;

  /// No description provided for @splashAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get splashAlreadyHaveAccount;

  /// No description provided for @splashSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get splashSignIn;

  /// No description provided for @authForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPassword;

  /// No description provided for @authNoAccount.
  ///
  /// In en, this message translates to:
  /// **'No account?'**
  String get authNoAccount;

  /// No description provided for @authUseBiometricHint.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID or fingerprint to unlock'**
  String get authUseBiometricHint;

  /// No description provided for @authTouchSensorHint.
  ///
  /// In en, this message translates to:
  /// **'Touch sensor or look at camera'**
  String get authTouchSensorHint;

  /// No description provided for @navLog.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get navLog;

  /// No description provided for @navReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get navReport;

  /// No description provided for @navRewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get navRewards;

  /// No description provided for @mockChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get mockChooseLanguage;

  /// No description provided for @mockYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get mockYourLocation;

  /// No description provided for @mockUseCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use Current Location'**
  String get mockUseCurrentLocation;

  /// No description provided for @mockLocationTrapOnly.
  ///
  /// In en, this message translates to:
  /// **'Location is used for TRAP air quality data only'**
  String get mockLocationTrapOnly;

  /// No description provided for @mockLabelYourPlace.
  ///
  /// In en, this message translates to:
  /// **'Label Your Place'**
  String get mockLabelYourPlace;

  /// No description provided for @mockSchool.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get mockSchool;

  /// No description provided for @mockWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get mockWork;

  /// No description provided for @mockOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get mockOther;

  /// No description provided for @mockEmergencyOnePerson.
  ///
  /// In en, this message translates to:
  /// **'One person to call in an emergency'**
  String get mockEmergencyOnePerson;

  /// No description provided for @mockContactName.
  ///
  /// In en, this message translates to:
  /// **'Contact Name'**
  String get mockContactName;

  /// No description provided for @mockPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get mockPhoneNumber;

  /// No description provided for @mockProviderPairing.
  ///
  /// In en, this message translates to:
  /// **'Provider Pairing'**
  String get mockProviderPairing;

  /// No description provided for @mockPairingOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional — you can add this later in Settings'**
  String get mockPairingOptional;

  /// No description provided for @mockNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get mockNext;

  /// No description provided for @mockProfessionalProfile.
  ///
  /// In en, this message translates to:
  /// **'Professional Profile'**
  String get mockProfessionalProfile;

  /// No description provided for @mockStep2Of4.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 4'**
  String get mockStep2Of4;

  /// No description provided for @mockTellPractice.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your medical practice'**
  String get mockTellPractice;

  /// No description provided for @mockSpecialtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get mockSpecialtyLabel;

  /// No description provided for @mockClinicLabel.
  ///
  /// In en, this message translates to:
  /// **'Practice / Clinic Name'**
  String get mockClinicLabel;

  /// No description provided for @mockNpiFormatOnly.
  ///
  /// In en, this message translates to:
  /// **'Format check only. NPI verification occurs after submission.'**
  String get mockNpiFormatOnly;

  /// No description provided for @mockCredentialsSecure.
  ///
  /// In en, this message translates to:
  /// **'Your credentials are encrypted and stored securely. We never share provider data without consent.'**
  String get mockCredentialsSecure;

  /// No description provided for @oneTapFab.
  ///
  /// In en, this message translates to:
  /// **'1-Tap'**
  String get oneTapFab;

  /// No description provided for @oneTapLoggedSnack.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use logged (stub)'**
  String get oneTapLoggedSnack;

  /// No description provided for @oneTapLoggedOk.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use logged'**
  String get oneTapLoggedOk;

  /// No description provided for @oneTapLoggedFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not log inhaler use. Try again.'**
  String get oneTapLoggedFailed;

  /// No description provided for @homeDailySummary.
  ///
  /// In en, this message translates to:
  /// **'Here is your daily summary'**
  String get homeDailySummary;

  /// No description provided for @homeWarningBanner.
  ///
  /// In en, this message translates to:
  /// **'Elevated risk nearby. Limit outdoor exposure and keep your inhaler ready.'**
  String get homeWarningBanner;

  /// No description provided for @homeEnvFactors.
  ///
  /// In en, this message translates to:
  /// **'Environmental Factors'**
  String get homeEnvFactors;

  /// No description provided for @homeViewDetails.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get homeViewDetails;

  /// No description provided for @homeFloodActive.
  ///
  /// In en, this message translates to:
  /// **'Active warning'**
  String get homeFloodActive;

  /// No description provided for @homeFloodNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get homeFloodNone;

  /// No description provided for @homeLastInhalerNone.
  ///
  /// In en, this message translates to:
  /// **'No inhaler use logged yet'**
  String get homeLastInhalerNone;

  /// No description provided for @homeLastInhalerToday.
  ///
  /// In en, this message translates to:
  /// **'Last inhaler use: today'**
  String get homeLastInhalerToday;

  /// No description provided for @homeLastInhalerDays.
  ///
  /// In en, this message translates to:
  /// **'Last inhaler use: {days} days ago'**
  String homeLastInhalerDays(int days);

  /// No description provided for @locationServiceDisabled.
  ///
  /// In en, this message translates to:
  /// **'Turn on location services to see nearby asthma risk.'**
  String get locationServiceDisabled;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission is needed for air quality near you.'**
  String get locationPermissionDenied;

  /// No description provided for @locationPermissionDeniedForever.
  ///
  /// In en, this message translates to:
  /// **'Location permission is blocked. Open settings to allow it.'**
  String get locationPermissionDeniedForever;

  /// No description provided for @locationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not get your location. Pull to refresh or try again.'**
  String get locationUnavailable;

  /// No description provided for @locationOutOfServiceArea.
  ///
  /// In en, this message translates to:
  /// **'Howse Asthma currently supports locations in the United States.'**
  String get locationOutOfServiceArea;

  /// No description provided for @locationOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get locationOpenSettings;

  /// No description provided for @locationStatusGranted.
  ///
  /// In en, this message translates to:
  /// **'Location access is on'**
  String get locationStatusGranted;

  /// No description provided for @njOnlyDataNotice.
  ///
  /// In en, this message translates to:
  /// **'NJ-only data: freight AADT weighting applies in New Jersey only. TRAP still uses air-quality sensors nationwide.'**
  String get njOnlyDataNotice;

  /// No description provided for @homeDegradedNotice.
  ///
  /// In en, this message translates to:
  /// **'Some air-quality sources are unavailable. Risk may be incomplete — treat with caution.'**
  String get homeDegradedNotice;

  /// No description provided for @logWeekSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} inhaler events in the last 7 days'**
  String logWeekSummary(int count);

  /// No description provided for @logFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get logFilterAll;

  /// No description provided for @logFilterRescue.
  ///
  /// In en, this message translates to:
  /// **'Rescue'**
  String get logFilterRescue;

  /// No description provided for @logFilterPanic.
  ///
  /// In en, this message translates to:
  /// **'Panic'**
  String get logFilterPanic;

  /// No description provided for @logEmpty.
  ///
  /// In en, this message translates to:
  /// **'No inhaler events yet. Use 1-Tap on Home.'**
  String get logEmpty;

  /// No description provided for @logEventRescue.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use'**
  String get logEventRescue;

  /// No description provided for @logEventPanic.
  ///
  /// In en, this message translates to:
  /// **'Panic inhaler use'**
  String get logEventPanic;

  /// No description provided for @actTitle.
  ///
  /// In en, this message translates to:
  /// **'Asthma Check'**
  String get actTitle;

  /// No description provided for @actPast4Weeks.
  ///
  /// In en, this message translates to:
  /// **'In the past 4 weeks'**
  String get actPast4Weeks;

  /// No description provided for @actQ1.
  ///
  /// In en, this message translates to:
  /// **'How much of the time did your asthma keep you from getting as much done at work, school or home?'**
  String get actQ1;

  /// No description provided for @actQ2.
  ///
  /// In en, this message translates to:
  /// **'How often have you had shortness of breath?'**
  String get actQ2;

  /// No description provided for @actQ3.
  ///
  /// In en, this message translates to:
  /// **'How often did your asthma symptoms wake you up at night or earlier than usual?'**
  String get actQ3;

  /// No description provided for @actQ4.
  ///
  /// In en, this message translates to:
  /// **'How often have you used your rescue inhaler or nebulizer medication?'**
  String get actQ4;

  /// No description provided for @actQ5.
  ///
  /// In en, this message translates to:
  /// **'How would you rate your asthma control?'**
  String get actQ5;

  /// No description provided for @actOpt1.
  ///
  /// In en, this message translates to:
  /// **'All of the time'**
  String get actOpt1;

  /// No description provided for @actOpt2.
  ///
  /// In en, this message translates to:
  /// **'Most of the time'**
  String get actOpt2;

  /// No description provided for @actOpt3.
  ///
  /// In en, this message translates to:
  /// **'Some of the time'**
  String get actOpt3;

  /// No description provided for @actOpt4.
  ///
  /// In en, this message translates to:
  /// **'A little of the time'**
  String get actOpt4;

  /// No description provided for @actOpt5.
  ///
  /// In en, this message translates to:
  /// **'None of the time'**
  String get actOpt5;

  /// No description provided for @actQ5Opt1.
  ///
  /// In en, this message translates to:
  /// **'Not controlled at all'**
  String get actQ5Opt1;

  /// No description provided for @actQ5Opt2.
  ///
  /// In en, this message translates to:
  /// **'Poorly controlled'**
  String get actQ5Opt2;

  /// No description provided for @actQ5Opt3.
  ///
  /// In en, this message translates to:
  /// **'Somewhat controlled'**
  String get actQ5Opt3;

  /// No description provided for @actQ5Opt4.
  ///
  /// In en, this message translates to:
  /// **'Well controlled'**
  String get actQ5Opt4;

  /// No description provided for @actQ5Opt5.
  ///
  /// In en, this message translates to:
  /// **'Completely controlled'**
  String get actQ5Opt5;

  /// No description provided for @actSaved.
  ///
  /// In en, this message translates to:
  /// **'ACT saved. Score: {score}'**
  String actSaved(int score);

  /// No description provided for @pdcTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily medicine check'**
  String get pdcTitle;

  /// No description provided for @pdcSaved.
  ///
  /// In en, this message translates to:
  /// **'Daily check saved'**
  String get pdcSaved;

  /// No description provided for @pdcAlreadyYes.
  ///
  /// In en, this message translates to:
  /// **'You already marked today as taken. You can update it.'**
  String get pdcAlreadyYes;

  /// No description provided for @pdcAlreadyNo.
  ///
  /// In en, this message translates to:
  /// **'You already marked today as not taken. You can update it.'**
  String get pdcAlreadyNo;

  /// No description provided for @pdcStreakHint.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days: {taken} of {total} days taken ({rate})'**
  String pdcStreakHint(int taken, int total, String rate);

  /// No description provided for @panicEmergencyBadge.
  ///
  /// In en, this message translates to:
  /// **'EMERGENCY'**
  String get panicEmergencyBadge;

  /// No description provided for @panicBreatheTitle.
  ///
  /// In en, this message translates to:
  /// **'Breathe & Use Inhaler'**
  String get panicBreatheTitle;

  /// No description provided for @panicTakeInhalerNow.
  ///
  /// In en, this message translates to:
  /// **'Take Inhaler Now'**
  String get panicTakeInhalerNow;

  /// No description provided for @panicNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'I need more help'**
  String get panicNeedHelp;

  /// No description provided for @panicNoAutoDial.
  ///
  /// In en, this message translates to:
  /// **'Buttons open the phone dialer. Calls are never placed automatically.'**
  String get panicNoAutoDial;

  /// No description provided for @panicCallNamed.
  ///
  /// In en, this message translates to:
  /// **'Call {name}'**
  String panicCallNamed(String name);

  /// No description provided for @panicDialFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the phone dialer on this device.'**
  String get panicDialFailed;

  /// No description provided for @alertTitle.
  ///
  /// In en, this message translates to:
  /// **'Risk alert'**
  String get alertTitle;

  /// No description provided for @alertFcmPendingNote.
  ///
  /// In en, this message translates to:
  /// **'If push is enabled on this device, you also get an OS notification when the app is in the background.'**
  String get alertFcmPendingNote;

  /// No description provided for @reportEvidenceBody.
  ///
  /// In en, this message translates to:
  /// **'Summary of inhaler use, ACT, and PDC for clinician or insurance review.'**
  String get reportEvidenceBody;

  /// No description provided for @reportShareTodo.
  ///
  /// In en, this message translates to:
  /// **'Share / export will arrive with provider PA/LMN flow.'**
  String get reportShareTodo;

  /// No description provided for @settingsAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Alert Preferences'**
  String get settingsAlertsTitle;

  /// No description provided for @settingsAlertRisk.
  ///
  /// In en, this message translates to:
  /// **'Risk Alerts'**
  String get settingsAlertRisk;

  /// No description provided for @settingsAlertRiskHint.
  ///
  /// In en, this message translates to:
  /// **'When your composite risk score reaches 3 or higher'**
  String get settingsAlertRiskHint;

  /// No description provided for @settingsAlertHome.
  ///
  /// In en, this message translates to:
  /// **'Saved place alerts'**
  String get settingsAlertHome;

  /// No description provided for @settingsAlertHomeHint.
  ///
  /// In en, this message translates to:
  /// **'When risk rises at places you saved (home, school, work)'**
  String get settingsAlertHomeHint;

  /// No description provided for @settingsAlertLocationEntry.
  ///
  /// In en, this message translates to:
  /// **'Location entry alerts'**
  String get settingsAlertLocationEntry;

  /// No description provided for @settingsAlertLocationEntryHint.
  ///
  /// In en, this message translates to:
  /// **'When you move into a higher-risk area while the app is open'**
  String get settingsAlertLocationEntryHint;

  /// No description provided for @settingsSecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settingsSecurityTitle;

  /// No description provided for @emergencyContactRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a contact name and phone number'**
  String get emergencyContactRequired;

  /// No description provided for @emergencyContactInvalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone with country code (E.164), e.g. +15551234567'**
  String get emergencyContactInvalidPhone;

  /// No description provided for @emergencyContactSaved.
  ///
  /// In en, this message translates to:
  /// **'Emergency contact saved'**
  String get emergencyContactSaved;

  /// No description provided for @emergencyContactSave.
  ///
  /// In en, this message translates to:
  /// **'Save contact'**
  String get emergencyContactSave;

  /// No description provided for @emergencyContactPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Include country code (E.164), e.g. +15551234567'**
  String get emergencyContactPhoneHint;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @envTitle.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get envTitle;

  /// No description provided for @envThreeAxis.
  ///
  /// In en, this message translates to:
  /// **'Three risk axes'**
  String get envThreeAxis;

  /// No description provided for @envTrapDetail.
  ///
  /// In en, this message translates to:
  /// **'Traffic-related air pollution proxy (sensors + optional NJ freight weight)'**
  String get envTrapDetail;

  /// No description provided for @envTrapTip.
  ///
  /// In en, this message translates to:
  /// **'Limit outdoor exertion when TRAP is HIGH or CRITICAL.'**
  String get envTrapTip;

  /// No description provided for @envFloodDetail.
  ///
  /// In en, this message translates to:
  /// **'NWS flash-flood / stream warnings near you'**
  String get envFloodDetail;

  /// No description provided for @envFloodTipClear.
  ///
  /// In en, this message translates to:
  /// **'No active flash-flood warning for this area.'**
  String get envFloodTipClear;

  /// No description provided for @envPollenDetail.
  ///
  /// In en, this message translates to:
  /// **'Google Pollen forecast'**
  String get envPollenDetail;

  /// No description provided for @envPollenTip.
  ///
  /// In en, this message translates to:
  /// **'Keep windows closed and rinse after outdoor time when UPI is high.'**
  String get envPollenTip;

  /// No description provided for @envUsgsRate.
  ///
  /// In en, this message translates to:
  /// **'USGS stream change: {rate} ft/hr'**
  String envUsgsRate(String rate);

  /// No description provided for @envUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated: {when}'**
  String envUpdatedAt(String when);

  /// No description provided for @envSourcesLabel.
  ///
  /// In en, this message translates to:
  /// **'Data sources'**
  String get envSourcesLabel;

  /// No description provided for @envOverallCalm.
  ///
  /// In en, this message translates to:
  /// **'Conditions look manageable. Keep your inhaler nearby.'**
  String get envOverallCalm;

  /// No description provided for @forecastIntro.
  ///
  /// In en, this message translates to:
  /// **'Outlook for the next periods using air quality and pollen forecasts.'**
  String get forecastIntro;

  /// No description provided for @forecastEmpty.
  ///
  /// In en, this message translates to:
  /// **'Forecast series is not available yet. Pull to refresh.'**
  String get forecastEmpty;

  /// No description provided for @forecastPollenNote.
  ///
  /// In en, this message translates to:
  /// **'Pollen uses Google Pollen API (not Open-Meteo). Heatmaps are not used in MVP.'**
  String get forecastPollenNote;

  /// No description provided for @forecastDayPollen.
  ///
  /// In en, this message translates to:
  /// **'Pollen UPI {upi} · {type}'**
  String forecastDayPollen(int upi, String type);

  /// No description provided for @forecastDayAqi.
  ///
  /// In en, this message translates to:
  /// **'Max US AQI {aqi}'**
  String forecastDayAqi(int aqi);

  /// No description provided for @forecastMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get forecastMorning;

  /// No description provided for @forecastAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get forecastAfternoon;

  /// No description provided for @forecastEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get forecastEvening;

  /// No description provided for @locationsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Locations'**
  String get locationsTitle;

  /// No description provided for @locationsIntro.
  ///
  /// In en, this message translates to:
  /// **'Saved places are checked for risk changes while the app is open. Background OS push needs Firebase (next).'**
  String get locationsIntro;

  /// No description provided for @locationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No saved places yet. Add your current location.'**
  String get locationsEmpty;

  /// No description provided for @locationsAddTitle.
  ///
  /// In en, this message translates to:
  /// **'Save this place'**
  String get locationsAddTitle;

  /// No description provided for @locationsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get locationsNameLabel;

  /// No description provided for @locationsAddCurrent.
  ///
  /// In en, this message translates to:
  /// **'Add current location'**
  String get locationsAddCurrent;

  /// No description provided for @locationsSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not update saved locations. Try again.'**
  String get locationsSaveFailed;

  /// No description provided for @locationsCapReached.
  ///
  /// In en, this message translates to:
  /// **'You can save up to 10 places. Remove one to add another.'**
  String get locationsCapReached;

  /// No description provided for @locationsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove place?'**
  String get locationsDeleteTitle;

  /// No description provided for @locationsDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Remove “{name}” from monitoring?'**
  String locationsDeleteBody(String name);

  /// No description provided for @locationsCoords.
  ///
  /// In en, this message translates to:
  /// **'{lat}, {lon}'**
  String locationsCoords(String lat, String lon);

  /// No description provided for @locationsPrimaryBadge.
  ///
  /// In en, this message translates to:
  /// **'Primary'**
  String get locationsPrimaryBadge;

  /// No description provided for @stateOnlyNjApplied.
  ///
  /// In en, this message translates to:
  /// **'NJ-only: freight AADT weight applied'**
  String get stateOnlyNjApplied;

  /// No description provided for @stateOnlyNjNotApplied.
  ///
  /// In en, this message translates to:
  /// **'NJ-only: freight AADT weight not applied'**
  String get stateOnlyNjNotApplied;

  /// No description provided for @stateOnlyNjAppliedHint.
  ///
  /// In en, this message translates to:
  /// **'Nearby NJDOT traffic counts raised the TRAP weight. Air quality sensors still apply nationwide.'**
  String get stateOnlyNjAppliedHint;

  /// No description provided for @stateOnlyNjOutsideHint.
  ///
  /// In en, this message translates to:
  /// **'You are outside New Jersey. Freight AADT weighting is NJ-only; TRAP still uses air sensors.'**
  String get stateOnlyNjOutsideHint;

  /// No description provided for @stateOnlyNjNoCountHint.
  ///
  /// In en, this message translates to:
  /// **'No nearby NJDOT freight count. TRAP uses air-quality sensors without the NJ freight weight.'**
  String get stateOnlyNjNoCountHint;

  /// No description provided for @settingsDeveloperSection.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get settingsDeveloperSection;

  /// No description provided for @settingsApiConsole.
  ///
  /// In en, this message translates to:
  /// **'API Console'**
  String get settingsApiConsole;

  /// No description provided for @debugApiConsoleBanner.
  ///
  /// In en, this message translates to:
  /// **'DEBUG — do not screenshot for public share'**
  String get debugApiConsoleBanner;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your smart shield against triggers'**
  String get appTagline;

  /// No description provided for @welcomeBenefit1.
  ///
  /// In en, this message translates to:
  /// **'Proactive alerts for air quality & pollen risk'**
  String get welcomeBenefit1;

  /// No description provided for @welcomeBenefit2.
  ///
  /// In en, this message translates to:
  /// **'A 3-second daily check-in for breathing control'**
  String get welcomeBenefit2;

  /// No description provided for @welcomeBenefit3.
  ///
  /// In en, this message translates to:
  /// **'Trusted data reports you can share with your clinician'**
  String get welcomeBenefit3;

  /// No description provided for @welcomeContinueEmail.
  ///
  /// In en, this message translates to:
  /// **'or continue with email'**
  String get welcomeContinueEmail;

  /// No description provided for @welcomeTermsAgree.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy'**
  String get welcomeTermsAgree;

  /// No description provided for @welcomeTermsPending.
  ///
  /// In en, this message translates to:
  /// **'Legal document links will be available once published.'**
  String get welcomeTermsPending;

  /// No description provided for @welcomeClinicianLink.
  ///
  /// In en, this message translates to:
  /// **'I\'m a clinician'**
  String get welcomeClinicianLink;

  /// No description provided for @checkInWelcomeHome.
  ///
  /// In en, this message translates to:
  /// **'Welcome Home!'**
  String get checkInWelcomeHome;

  /// No description provided for @checkInQuestion.
  ///
  /// In en, this message translates to:
  /// **'How is your breathing right now?'**
  String get checkInQuestion;

  /// No description provided for @checkInBreathUsual.
  ///
  /// In en, this message translates to:
  /// **'About the same as usual'**
  String get checkInBreathUsual;

  /// No description provided for @checkInBreathTight.
  ///
  /// In en, this message translates to:
  /// **'A bit tight'**
  String get checkInBreathTight;

  /// No description provided for @checkInBreathSymptoms.
  ///
  /// In en, this message translates to:
  /// **'I have symptoms'**
  String get checkInBreathSymptoms;

  /// No description provided for @checkInAeroPoints.
  ///
  /// In en, this message translates to:
  /// **'First check-in done! +5 AeroPoints'**
  String get checkInAeroPoints;

  /// No description provided for @shieldLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Activate your preemptive shield'**
  String get shieldLocationTitle;

  /// No description provided for @shieldLocationBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on your preemptive shield around you — we need location for nearby air & pollen.'**
  String get shieldLocationBody;

  /// No description provided for @shieldLocationAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow location'**
  String get shieldLocationAllow;

  /// No description provided for @shieldLocationNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get shieldLocationNotNow;

  /// No description provided for @settingsPushMaster.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get settingsPushMaster;

  /// No description provided for @settingsPushMasterHint.
  ///
  /// In en, this message translates to:
  /// **'Master switch for all Howse Asthma alerts on this device'**
  String get settingsPushMasterHint;

  /// No description provided for @pushConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay ahead of asthma triggers'**
  String get pushConsentTitle;

  /// No description provided for @pushConsentBody.
  ///
  /// In en, this message translates to:
  /// **'We can send simple alerts when nearby air or flood risk rises, and later tips for safer times to open windows. You can change this anytime in Settings.'**
  String get pushConsentBody;

  /// No description provided for @pushConsentAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications'**
  String get pushConsentAllow;

  /// No description provided for @pushConsentNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get pushConsentNotNow;

  /// No description provided for @homeNearPlace.
  ///
  /// In en, this message translates to:
  /// **'Near {place}'**
  String homeNearPlace(String place);

  /// No description provided for @homeStaleLocationNotice.
  ///
  /// In en, this message translates to:
  /// **'Showing your last saved reading while we wait for location.'**
  String get homeStaleLocationNotice;

  /// No description provided for @homeStaleRefreshNotice.
  ///
  /// In en, this message translates to:
  /// **'Showing your last saved reading. Pull to refresh when you have a connection.'**
  String get homeStaleRefreshNotice;

  /// No description provided for @homeStaleCacheNotice.
  ///
  /// In en, this message translates to:
  /// **'This reading may be a little old. Treat with care.'**
  String get homeStaleCacheNotice;

  /// No description provided for @homeNowDoThisHeading.
  ///
  /// In en, this message translates to:
  /// **'Do this now to lower your chance of an attack'**
  String get homeNowDoThisHeading;

  /// No description provided for @homeDraftBadge.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get homeDraftBadge;

  /// No description provided for @homeNowDoThisFloodTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay inside if you can'**
  String get homeNowDoThisFloodTitle;

  /// No description provided for @homeNowDoThisFloodBody.
  ///
  /// In en, this message translates to:
  /// **'Flood alerts often mean damp rooms. Keep your inhaler close and avoid flooded areas.'**
  String get homeNowDoThisFloodBody;

  /// No description provided for @homeNowDoThisTrapTitle.
  ///
  /// In en, this message translates to:
  /// **'Ease up on outdoor activity'**
  String get homeNowDoThisTrapTitle;

  /// No description provided for @homeNowDoThisTrapBody.
  ///
  /// In en, this message translates to:
  /// **'Traffic-related air pollution nearby looks high. Short outdoor trips only if needed.'**
  String get homeNowDoThisTrapBody;

  /// No description provided for @homeNowDoThisPollenTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep windows closed for now'**
  String get homeNowDoThisPollenTitle;

  /// No description provided for @homeNowDoThisPollenBody.
  ///
  /// In en, this message translates to:
  /// **'Pollen is high. Rinse face and change clothes after being outside.'**
  String get homeNowDoThisPollenBody;

  /// No description provided for @homeNowDoThisRiskTitle.
  ///
  /// In en, this message translates to:
  /// **'Slow down outdoors'**
  String get homeNowDoThisRiskTitle;

  /// No description provided for @homeNowDoThisRiskBody.
  ///
  /// In en, this message translates to:
  /// **'Overall risk is elevated. Keep your inhaler with you and rest if breathing feels hard.'**
  String get homeNowDoThisRiskBody;

  /// No description provided for @homeNowDoThisCalmTitle.
  ///
  /// In en, this message translates to:
  /// **'A calmer window for fresh air'**
  String get homeNowDoThisCalmTitle;

  /// No description provided for @homeNowDoThisCalmBody.
  ///
  /// In en, this message translates to:
  /// **'Outside air looks manageable. A short air-out may help — still keep your inhaler nearby.'**
  String get homeNowDoThisCalmBody;

  /// No description provided for @homeAdherenceSection.
  ///
  /// In en, this message translates to:
  /// **'Your inhaler week'**
  String get homeAdherenceSection;

  /// No description provided for @adherenceWeekHint.
  ///
  /// In en, this message translates to:
  /// **'Filled days show logged inhaler uses (1-Tap).'**
  String get adherenceWeekHint;

  /// No description provided for @homeMoldAxis.
  ///
  /// In en, this message translates to:
  /// **'Mold risk'**
  String get homeMoldAxis;

  /// No description provided for @homeMoldElevatedDraft.
  ///
  /// In en, this message translates to:
  /// **'Higher dampness signal'**
  String get homeMoldElevatedDraft;

  /// No description provided for @homeMoldPendingDraft.
  ///
  /// In en, this message translates to:
  /// **'Humidity data pending'**
  String get homeMoldPendingDraft;

  /// No description provided for @homeFloodAsMoldFactor.
  ///
  /// In en, this message translates to:
  /// **'Flood / damp factor'**
  String get homeFloodAsMoldFactor;

  /// No description provided for @homeForecastLink.
  ///
  /// In en, this message translates to:
  /// **'Short outlook'**
  String get homeForecastLink;

  /// No description provided for @homeForecastHint.
  ///
  /// In en, this message translates to:
  /// **'Next day {date} · score {score}'**
  String homeForecastHint(String date, String score);

  /// No description provided for @homeSensorDistance.
  ///
  /// In en, this message translates to:
  /// **'Nearest air sensor {km} km ({mi} mi) · search ~{radiusKm} km ({radiusMi} mi)'**
  String homeSensorDistance(
    String km,
    String mi,
    String radiusKm,
    String radiusMi,
  );

  /// No description provided for @homeSensorNearestOnly.
  ///
  /// In en, this message translates to:
  /// **'Nearest air sensor {km} km ({mi} mi)'**
  String homeSensorNearestOnly(String km, String mi);

  /// No description provided for @homeSensorRadiusOnly.
  ///
  /// In en, this message translates to:
  /// **'Sensor search ~{km} km ({mi} mi)'**
  String homeSensorRadiusOnly(String km, String mi);

  /// No description provided for @weekdayMonShort.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get weekdayMonShort;

  /// No description provided for @weekdayTueShort.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get weekdayTueShort;

  /// No description provided for @weekdayWedShort.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get weekdayWedShort;

  /// No description provided for @weekdayThuShort.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get weekdayThuShort;

  /// No description provided for @weekdayFriShort.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get weekdayFriShort;

  /// No description provided for @weekdaySatShort.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get weekdaySatShort;

  /// No description provided for @weekdaySunShort.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get weekdaySunShort;

  /// No description provided for @logAdherenceCalendarTitle.
  ///
  /// In en, this message translates to:
  /// **'Adherence calendar'**
  String get logAdherenceCalendarTitle;

  /// No description provided for @homeNowDoThisMoldTitle.
  ///
  /// In en, this message translates to:
  /// **'Cut down indoor dampness'**
  String get homeNowDoThisMoldTitle;

  /// No description provided for @homeNowDoThisMoldBody.
  ///
  /// In en, this message translates to:
  /// **'Outdoor dampness looks high. Run a fan or dehumidifier if you have one, and avoid wet basements.'**
  String get homeNowDoThisMoldBody;

  /// No description provided for @homeMoldDetail.
  ///
  /// In en, this message translates to:
  /// **'Dampness conditions near you (outdoor proxy — not a spore count)'**
  String get homeMoldDetail;

  /// No description provided for @homeMoldTip.
  ///
  /// In en, this message translates to:
  /// **'High mold risk means keep rooms drier when you can. Flood warnings raise dampness risk.'**
  String get homeMoldTip;

  /// No description provided for @homeMoldRh.
  ///
  /// In en, this message translates to:
  /// **'Humidity {pct}%'**
  String homeMoldRh(String pct);

  /// No description provided for @homeMoldTempF.
  ///
  /// In en, this message translates to:
  /// **'{temp}°F'**
  String homeMoldTempF(String temp);

  /// No description provided for @homeMoldDewF.
  ///
  /// In en, this message translates to:
  /// **'Dew {temp}°F'**
  String homeMoldDewF(String temp);

  /// No description provided for @homeMoldWetHours.
  ///
  /// In en, this message translates to:
  /// **'{hours} wet hours (24h)'**
  String homeMoldWetHours(int hours);

  /// No description provided for @homeMoldProxyDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Outdoor estimate only'**
  String get homeMoldProxyDisclaimer;

  /// No description provided for @homeVentilationSnack.
  ///
  /// In en, this message translates to:
  /// **'Outside air looks calmer — a short air-out may help.'**
  String get homeVentilationSnack;

  /// No description provided for @settingsAlertPositive.
  ///
  /// In en, this message translates to:
  /// **'Fresh-air tips'**
  String get settingsAlertPositive;

  /// No description provided for @settingsAlertPositiveHint.
  ///
  /// In en, this message translates to:
  /// **'When outdoor air looks safer for a short window open (draft rules)'**
  String get settingsAlertPositiveHint;

  /// No description provided for @settingsBgTitle.
  ///
  /// In en, this message translates to:
  /// **'Background refresh'**
  String get settingsBgTitle;

  /// No description provided for @settingsBgBody.
  ///
  /// In en, this message translates to:
  /// **'Howse Asthma refreshes nearby air while you use the app. We do not request Always location in this version.'**
  String get settingsBgBody;

  /// No description provided for @settingsBgRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh while using the app'**
  String get settingsBgRefresh;

  /// No description provided for @settingsBgRefreshHint.
  ///
  /// In en, this message translates to:
  /// **'Update risk when you move or keep the app open'**
  String get settingsBgRefreshHint;

  /// No description provided for @s5AboutApp.
  ///
  /// In en, this message translates to:
  /// **'About Howse Asthma'**
  String get s5AboutApp;

  /// No description provided for @s5AboutAppBody.
  ///
  /// In en, this message translates to:
  /// **'Howse Asthma helps you keep a record of symptoms and inhaler use and prepare a summary for your clinician. It does not diagnose or give treatment advice.'**
  String get s5AboutAppBody;

  /// No description provided for @s5ActNotice.
  ///
  /// In en, this message translates to:
  /// **'Your answers are saved so you can share them with your clinician. This version of the questionnaire has not been checked against the official scoring, so the app does not show a score.'**
  String get s5ActNotice;

  /// No description provided for @s5ActSaved.
  ///
  /// In en, this message translates to:
  /// **'Your answers were saved.'**
  String get s5ActSaved;

  /// No description provided for @s5ActSubtitle.
  ///
  /// In en, this message translates to:
  /// **'5 questions about the past 4 weeks'**
  String get s5ActSubtitle;

  /// No description provided for @s5ActTitle.
  ///
  /// In en, this message translates to:
  /// **'Asthma control questionnaire'**
  String get s5ActTitle;

  /// No description provided for @s5AddDetails.
  ///
  /// In en, this message translates to:
  /// **'Add details'**
  String get s5AddDetails;

  /// No description provided for @s5AddRecord.
  ///
  /// In en, this message translates to:
  /// **'Add record'**
  String get s5AddRecord;

  /// No description provided for @s5AlertArrive.
  ///
  /// In en, this message translates to:
  /// **'When you arrive somewhere'**
  String get s5AlertArrive;

  /// No description provided for @s5AlertArriveHint.
  ///
  /// In en, this message translates to:
  /// **'When local conditions are worse where you arrive. Only while the app is open.'**
  String get s5AlertArriveHint;

  /// No description provided for @s5AlertFreshAirHint.
  ///
  /// In en, this message translates to:
  /// **'When outdoor air quality, pollen, and flood information all look calm. General information, not medical advice.'**
  String get s5AlertFreshAirHint;

  /// No description provided for @s5AlertSavedPlaces.
  ///
  /// In en, this message translates to:
  /// **'Saved places'**
  String get s5AlertSavedPlaces;

  /// No description provided for @s5AlertSavedPlacesHint.
  ///
  /// In en, this message translates to:
  /// **'When local conditions get worse at a place you saved.'**
  String get s5AlertSavedPlacesHint;

  /// No description provided for @s5AlertWorse.
  ///
  /// In en, this message translates to:
  /// **'When conditions get worse'**
  String get s5AlertWorse;

  /// No description provided for @s5AlertWorseHint.
  ///
  /// In en, this message translates to:
  /// **'When air quality, pollen, or flood information near you gets worse. The same alert is not repeated within an hour.'**
  String get s5AlertWorseHint;

  /// No description provided for @s5AqiGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get s5AqiGood;

  /// No description provided for @s5AqiModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get s5AqiModerate;

  /// No description provided for @s5AqiUsg.
  ///
  /// In en, this message translates to:
  /// **'Unhealthy for sensitive groups'**
  String get s5AqiUsg;

  /// No description provided for @s5AqiUnhealthy.
  ///
  /// In en, this message translates to:
  /// **'Unhealthy'**
  String get s5AqiUnhealthy;

  /// No description provided for @s5AqiVeryUnhealthy.
  ///
  /// In en, this message translates to:
  /// **'Very unhealthy'**
  String get s5AqiVeryUnhealthy;

  /// No description provided for @s5AqiHazardous.
  ///
  /// In en, this message translates to:
  /// **'Hazardous'**
  String get s5AqiHazardous;

  /// No description provided for @s5AqiValue.
  ///
  /// In en, this message translates to:
  /// **'{category} (AQI {aqi})'**
  String s5AqiValue(String category, int aqi);

  /// No description provided for @s5Back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get s5Back;

  /// No description provided for @s5BarrierCost.
  ///
  /// In en, this message translates to:
  /// **'Cost of medicine'**
  String get s5BarrierCost;

  /// No description provided for @s5BarrierHardToGet.
  ///
  /// In en, this message translates to:
  /// **'Hard to get medicine'**
  String get s5BarrierHardToGet;

  /// No description provided for @s5BarrierHardToUnderstand.
  ///
  /// In en, this message translates to:
  /// **'Hard to understand instructions'**
  String get s5BarrierHardToUnderstand;

  /// No description provided for @s5BarrierHowToUse.
  ///
  /// In en, this message translates to:
  /// **'How to use my medicine'**
  String get s5BarrierHowToUse;

  /// No description provided for @s5BarrierNone.
  ///
  /// In en, this message translates to:
  /// **'No difficulties'**
  String get s5BarrierNone;

  /// No description provided for @s5BarrierOtherHint.
  ///
  /// In en, this message translates to:
  /// **'Describe in your own words (optional)'**
  String get s5BarrierOtherHint;

  /// No description provided for @s5Cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get s5Cancel;

  /// No description provided for @s5Change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get s5Change;

  /// No description provided for @s5ChoosePlace.
  ///
  /// In en, this message translates to:
  /// **'Choose a place'**
  String get s5ChoosePlace;

  /// No description provided for @s5Close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get s5Close;

  /// No description provided for @s5DataSourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Data sources'**
  String get s5DataSourcesTitle;

  /// No description provided for @s5DataSourcesBody.
  ///
  /// In en, this message translates to:
  /// **'Air quality: U.S. EPA AirNow, Open-Meteo, and nearby PurpleAir sensors.\nPollen: Google Pollen API (Universal Pollen Index).\nWeather and humidity: Open-Meteo.\nFlood alerts: U.S. National Weather Service. Stream levels: U.S. Geological Survey.\nTraffic counts (New Jersey only): NJ Department of Transportation.\nValues can be delayed or missing. They describe outdoor conditions, not your health.'**
  String get s5DataSourcesBody;

  /// No description provided for @s5Delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get s5Delete;

  /// No description provided for @s5DeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this entry?'**
  String get s5DeleteConfirm;

  /// No description provided for @s5DeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not delete. Please try again.'**
  String get s5DeleteFailed;

  /// No description provided for @s5Edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get s5Edit;

  /// No description provided for @s5EnglishVersion.
  ///
  /// In en, this message translates to:
  /// **'English (for clinician)'**
  String get s5EnglishVersion;

  /// No description provided for @s5EntryRemoved.
  ///
  /// In en, this message translates to:
  /// **'Entry removed.'**
  String get s5EntryRemoved;

  /// No description provided for @s5EnvAirDetail.
  ///
  /// In en, this message translates to:
  /// **'U.S. EPA Air Quality Index from public monitors and nearby sensors. It describes outdoor air in your area, not traffic exhaust specifically.'**
  String get s5EnvAirDetail;

  /// No description provided for @s5EnvAirQuality.
  ///
  /// In en, this message translates to:
  /// **'Air quality'**
  String get s5EnvAirQuality;

  /// No description provided for @s5EnvAlertsHeading.
  ///
  /// In en, this message translates to:
  /// **'Environment alerts'**
  String get s5EnvAlertsHeading;

  /// No description provided for @s5EnvCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s local environment'**
  String get s5EnvCardTitle;

  /// No description provided for @s5EnvFlood.
  ///
  /// In en, this message translates to:
  /// **'Flood alerts'**
  String get s5EnvFlood;

  /// No description provided for @s5EnvFloodDetail.
  ///
  /// In en, this message translates to:
  /// **'Public alerts from the U.S. National Weather Service.'**
  String get s5EnvFloodDetail;

  /// No description provided for @s5EnvForecast.
  ///
  /// In en, this message translates to:
  /// **'Environmental forecast'**
  String get s5EnvForecast;

  /// No description provided for @s5EnvHumidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity conditions'**
  String get s5EnvHumidity;

  /// No description provided for @s5EnvHumidityDetail.
  ///
  /// In en, this message translates to:
  /// **'Outdoor weather data. It is not an indoor humidity or mold measurement.'**
  String get s5EnvHumidityDetail;

  /// No description provided for @s5EnvLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load environmental information.'**
  String get s5EnvLoadFailed;

  /// No description provided for @s5EnvNeedPlace.
  ///
  /// In en, this message translates to:
  /// **'Choose a place to see your local environment.'**
  String get s5EnvNeedPlace;

  /// No description provided for @s5EnvNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get s5EnvNotAvailable;

  /// No description provided for @s5EnvOlderNotice.
  ///
  /// In en, this message translates to:
  /// **'This is the last information we checked.'**
  String get s5EnvOlderNotice;

  /// No description provided for @s5EnvPollen.
  ///
  /// In en, this message translates to:
  /// **'Pollen index'**
  String get s5EnvPollen;

  /// No description provided for @s5EnvPollenDetail.
  ///
  /// In en, this message translates to:
  /// **'Universal Pollen Index from Google, from 0 (none) to 5 (very high). A low number does not mean it is safe for everyone.'**
  String get s5EnvPollenDetail;

  /// No description provided for @s5EnvSeeDetails.
  ///
  /// In en, this message translates to:
  /// **'See environment details'**
  String get s5EnvSeeDetails;

  /// No description provided for @s5EnvUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Environmental data is currently unavailable.'**
  String get s5EnvUnavailable;

  /// No description provided for @s5FewRecordsNotice.
  ///
  /// In en, this message translates to:
  /// **'Some sections may be empty because few records are available.'**
  String get s5FewRecordsNotice;

  /// No description provided for @s5FgRefreshTitle.
  ///
  /// In en, this message translates to:
  /// **'Refresh environment while using the app'**
  String get s5FgRefreshTitle;

  /// No description provided for @s5FgRefreshHint.
  ///
  /// In en, this message translates to:
  /// **'Checks your area while the app is open. It does not run in the background.'**
  String get s5FgRefreshHint;

  /// No description provided for @s5FieldDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get s5FieldDate;

  /// No description provided for @s5FieldMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get s5FieldMedication;

  /// No description provided for @s5FieldNote.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get s5FieldNote;

  /// No description provided for @s5FieldPuffs.
  ///
  /// In en, this message translates to:
  /// **'Number of puffs (optional)'**
  String get s5FieldPuffs;

  /// No description provided for @s5FieldReason.
  ///
  /// In en, this message translates to:
  /// **'Reason (optional)'**
  String get s5FieldReason;

  /// No description provided for @s5FieldTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get s5FieldTime;

  /// No description provided for @s5FilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get s5FilterAll;

  /// No description provided for @s5FilterInhaler.
  ///
  /// In en, this message translates to:
  /// **'Inhaler'**
  String get s5FilterInhaler;

  /// No description provided for @s5FilterMedCheck.
  ///
  /// In en, this message translates to:
  /// **'Medication check-in'**
  String get s5FilterMedCheck;

  /// No description provided for @s5FilterSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get s5FilterSymptoms;

  /// No description provided for @s5FloodIssued.
  ///
  /// In en, this message translates to:
  /// **'Flood warning issued'**
  String get s5FloodIssued;

  /// No description provided for @s5FloodNone.
  ///
  /// In en, this message translates to:
  /// **'No flood warnings issued'**
  String get s5FloodNone;

  /// No description provided for @s5FloodUnknown.
  ///
  /// In en, this message translates to:
  /// **'Can\'t check alert information'**
  String get s5FloodUnknown;

  /// No description provided for @s5ForecastCheckedAt.
  ///
  /// In en, this message translates to:
  /// **'Checked {time}'**
  String s5ForecastCheckedAt(String time);

  /// No description provided for @s5ForecastValidFor.
  ///
  /// In en, this message translates to:
  /// **'Forecast for {date}'**
  String s5ForecastValidFor(String date);

  /// No description provided for @s5FromUrgentHelp.
  ///
  /// In en, this message translates to:
  /// **'Logged from Urgent help'**
  String get s5FromUrgentHelp;

  /// No description provided for @s5HomeStateEmpty.
  ///
  /// In en, this message translates to:
  /// **'Make your first record. You can organize what to share at your visit along the way.'**
  String get s5HomeStateEmpty;

  /// No description provided for @s5HomeStateQuestions.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{You have 1 question for your doctor.} other{You have {n} questions for your doctor.}}'**
  String s5HomeStateQuestions(int n);

  /// No description provided for @s5HomeStateRecords.
  ///
  /// In en, this message translates to:
  /// **'Days with records in the last 7 days: {n}'**
  String s5HomeStateRecords(int n);

  /// No description provided for @s5HomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bring your records to your next visit.'**
  String get s5HomeSubtitle;

  /// No description provided for @s5HomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Record how you\'re doing today'**
  String get s5HomeTitle;

  /// No description provided for @s5HumidityValue.
  ///
  /// In en, this message translates to:
  /// **'Outdoor humidity {rh}%'**
  String s5HumidityValue(int rh);

  /// No description provided for @s5IncludeEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Local environment (optional)'**
  String get s5IncludeEnvironment;

  /// No description provided for @s5IncludeEnvironmentHint.
  ///
  /// In en, this message translates to:
  /// **'Adds today\'s air quality, pollen, and flood alerts. Your exact location is not included.'**
  String get s5IncludeEnvironmentHint;

  /// No description provided for @s5InhalerEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use details'**
  String get s5InhalerEditTitle;

  /// No description provided for @s5InhalerEntry.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use'**
  String get s5InhalerEntry;

  /// No description provided for @s5InhalerLogged.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use logged.'**
  String get s5InhalerLogged;

  /// No description provided for @s5InhalerOneEntryHint.
  ///
  /// In en, this message translates to:
  /// **'Each save is one inhaler-use entry. It is not counted as one puff or one day.'**
  String get s5InhalerOneEntryHint;

  /// No description provided for @s5InhalerUnknownCount.
  ///
  /// In en, this message translates to:
  /// **'Medication not identified: {n}'**
  String s5InhalerUnknownCount(int n);

  /// No description provided for @s5InsCost.
  ///
  /// In en, this message translates to:
  /// **'Cost difficulties'**
  String get s5InsCost;

  /// No description provided for @s5InsDenial.
  ///
  /// In en, this message translates to:
  /// **'Reason given for a denial, if any'**
  String get s5InsDenial;

  /// No description provided for @s5InsMedHistory.
  ///
  /// In en, this message translates to:
  /// **'Medicines I have tried'**
  String get s5InsMedHistory;

  /// No description provided for @s5InsuranceIntro.
  ///
  /// In en, this message translates to:
  /// **'Organize information for your clinician\'s paperwork.'**
  String get s5InsuranceIntro;

  /// No description provided for @s5InsuranceLimits.
  ///
  /// In en, this message translates to:
  /// **'Everything here is optional. This app does not submit anything to insurers and does not decide approvals.'**
  String get s5InsuranceLimits;

  /// No description provided for @s5InsuranceTitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare insurance paperwork'**
  String get s5InsuranceTitle;

  /// No description provided for @s5LanguageName.
  ///
  /// In en, this message translates to:
  /// **'{lang, select, en{English} es{Spanish} fr{French} ko{Korean} ja{Japanese} zh{Chinese} other{another language}}'**
  String s5LanguageName(String lang);

  /// No description provided for @s5Last30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get s5Last30Days;

  /// No description provided for @s5Last7Days.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get s5Last7Days;

  /// No description provided for @s5LogInhaler.
  ///
  /// In en, this message translates to:
  /// **'Log inhaler use'**
  String get s5LogInhaler;

  /// No description provided for @s5LogLegend.
  ///
  /// In en, this message translates to:
  /// **'Each line is one saved entry. Days without entries are “not recorded”, which is different from zero.'**
  String get s5LogLegend;

  /// No description provided for @s5LogSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Log symptoms'**
  String get s5LogSymptoms;

  /// No description provided for @s5MedAdd.
  ///
  /// In en, this message translates to:
  /// **'Add medication'**
  String get s5MedAdd;

  /// No description provided for @s5MedCheckCounts.
  ///
  /// In en, this message translates to:
  /// **'Days used: {a} · not used: {b} · don\'t remember: {c} · not recorded: {d}'**
  String s5MedCheckCounts(int a, int b, int c, int d);

  /// No description provided for @s5MedCheckIntro.
  ///
  /// In en, this message translates to:
  /// **'A self-reported check of whether you used your medicine. It is not based on pharmacy records.'**
  String get s5MedCheckIntro;

  /// No description provided for @s5MedCheckQuestion.
  ///
  /// In en, this message translates to:
  /// **'Did you use your medicine as planned?'**
  String get s5MedCheckQuestion;

  /// No description provided for @s5MedCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s medication check-in'**
  String get s5MedCheckTitle;

  /// No description provided for @s5MedChooseHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a medication, or “I don\'t know the medication name”.'**
  String get s5MedChooseHint;

  /// No description provided for @s5MedDailyCheck.
  ///
  /// In en, this message translates to:
  /// **'Daily check-in'**
  String get s5MedDailyCheck;

  /// No description provided for @s5MedDailyCheckHint.
  ///
  /// In en, this message translates to:
  /// **'Show “Today\'s medication check-in” on Home. Turn on only if your clinician asked you to use this medicine every day.'**
  String get s5MedDailyCheckHint;

  /// No description provided for @s5MedDefault.
  ///
  /// In en, this message translates to:
  /// **'Default for quick logging'**
  String get s5MedDefault;

  /// No description provided for @s5MedDefaultHint.
  ///
  /// In en, this message translates to:
  /// **'Used when you tap “Log inhaler use” on Home.'**
  String get s5MedDefaultHint;

  /// No description provided for @s5MedEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit medication'**
  String get s5MedEdit;

  /// No description provided for @s5MedNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Medication name (as on your label)'**
  String get s5MedNameLabel;

  /// No description provided for @s5MedNotApplicable.
  ///
  /// In en, this message translates to:
  /// **'Not scheduled for today'**
  String get s5MedNotApplicable;

  /// No description provided for @s5MedNotApplicableDays.
  ///
  /// In en, this message translates to:
  /// **'Not scheduled: {n} days'**
  String s5MedNotApplicableDays(int n);

  /// No description provided for @s5MedNotRecorded.
  ///
  /// In en, this message translates to:
  /// **'Medication not recorded'**
  String get s5MedNotRecorded;

  /// No description provided for @s5MedNotSure.
  ///
  /// In en, this message translates to:
  /// **'I don\'t remember'**
  String get s5MedNotSure;

  /// No description provided for @s5MedNotUsed.
  ///
  /// In en, this message translates to:
  /// **'I did not use it'**
  String get s5MedNotUsed;

  /// No description provided for @s5MedOther.
  ///
  /// In en, this message translates to:
  /// **'Another name'**
  String get s5MedOther;

  /// No description provided for @s5MedOtherHint.
  ///
  /// In en, this message translates to:
  /// **'Type the medication name'**
  String get s5MedOtherHint;

  /// No description provided for @s5MedReasonCost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get s5MedReasonCost;

  /// No description provided for @s5MedReasonForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot'**
  String get s5MedReasonForgot;

  /// No description provided for @s5MedReasonNoMedicine.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t have the medicine'**
  String get s5MedReasonNoMedicine;

  /// No description provided for @s5MedReasonQuestion.
  ///
  /// In en, this message translates to:
  /// **'Reason (optional)'**
  String get s5MedReasonQuestion;

  /// No description provided for @s5MedUnknown.
  ///
  /// In en, this message translates to:
  /// **'I don\'t know the medication name'**
  String get s5MedUnknown;

  /// No description provided for @s5MedUnknownShort.
  ///
  /// In en, this message translates to:
  /// **'Medication not identified'**
  String get s5MedUnknownShort;

  /// No description provided for @s5MedUsed.
  ///
  /// In en, this message translates to:
  /// **'I used it'**
  String get s5MedUsed;

  /// No description provided for @s5MyLanguage.
  ///
  /// In en, this message translates to:
  /// **'My language'**
  String get s5MyLanguage;

  /// No description provided for @s5MyLogTitle.
  ///
  /// In en, this message translates to:
  /// **'My log'**
  String get s5MyLogTitle;

  /// No description provided for @s5MyMedsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No medications saved yet.'**
  String get s5MyMedsEmpty;

  /// No description provided for @s5MyMedsHint.
  ///
  /// In en, this message translates to:
  /// **'Names you confirmed, to make logging faster. This is not a dosing recommendation.'**
  String get s5MyMedsHint;

  /// No description provided for @s5MyMedsOpen.
  ///
  /// In en, this message translates to:
  /// **'Manage my medications'**
  String get s5MyMedsOpen;

  /// No description provided for @s5MyMedsTitle.
  ///
  /// In en, this message translates to:
  /// **'My medications'**
  String get s5MyMedsTitle;

  /// No description provided for @s5NavEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get s5NavEnvironment;

  /// No description provided for @s5NavLog.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get s5NavLog;

  /// No description provided for @s5NavVisitPrep.
  ///
  /// In en, this message translates to:
  /// **'Visit prep'**
  String get s5NavVisitPrep;

  /// No description provided for @s5NoAnswer.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to answer'**
  String get s5NoAnswer;

  /// No description provided for @s5NoRecordsYet.
  ///
  /// In en, this message translates to:
  /// **'No records yet'**
  String get s5NoRecordsYet;

  /// No description provided for @s5NoSymptomDays.
  ///
  /// In en, this message translates to:
  /// **'Days marked “no symptoms”: {n}'**
  String s5NoSymptomDays(int n);

  /// No description provided for @s5NotRecorded.
  ///
  /// In en, this message translates to:
  /// **'Not recorded'**
  String get s5NotRecorded;

  /// No description provided for @s5NotRecordedToday.
  ///
  /// In en, this message translates to:
  /// **'Not recorded today'**
  String get s5NotRecordedToday;

  /// No description provided for @s5NotTranslatedLine.
  ///
  /// In en, this message translates to:
  /// **'[Not translated · original in {language}] {text}'**
  String s5NotTranslatedLine(String language, String text);

  /// No description provided for @s5OsNotificationsOff.
  ///
  /// In en, this message translates to:
  /// **'Notifications are turned off for Howse Asthma in your phone settings, so alerts can\'t appear.'**
  String get s5OsNotificationsOff;

  /// No description provided for @s5PdfAboutMedCheck.
  ///
  /// In en, this message translates to:
  /// **'Medication check-ins are self-reported by the patient. They are not pharmacy refill data and are not a proportion of days covered (PDC).'**
  String get s5PdfAboutMedCheck;

  /// No description provided for @s5PdfAboutNoScore.
  ///
  /// In en, this message translates to:
  /// **'No questionnaire score or app-generated risk score is included.'**
  String get s5PdfAboutNoScore;

  /// No description provided for @s5PdfAboutPatientReported.
  ///
  /// In en, this message translates to:
  /// **'All entries were recorded by the patient in the Howse Asthma app and have not been verified.'**
  String get s5PdfAboutPatientReported;

  /// No description provided for @s5PdfAppendix.
  ///
  /// In en, this message translates to:
  /// **'Appendix: patient notes'**
  String get s5PdfAppendix;

  /// No description provided for @s5PdfDaysNotRecorded.
  ///
  /// In en, this message translates to:
  /// **'Days with no symptom entry (not recorded): {n}'**
  String s5PdfDaysNotRecorded(int n);

  /// No description provided for @s5PdfDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This summary contains patient-reported information for clinician review. It is not a diagnosis or a prior authorization decision.'**
  String get s5PdfDisclaimer;

  /// No description provided for @s5PdfEnvNote.
  ///
  /// In en, this message translates to:
  /// **'General outdoor conditions when this summary was created. Location is not included.'**
  String get s5PdfEnvNote;

  /// No description provided for @s5PdfFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t create the PDF. Your entries are kept. Please try again.'**
  String get s5PdfFailed;

  /// No description provided for @s5PdfFontFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t prepare the PDF fonts. Check your internet connection and try again.'**
  String get s5PdfFontFailed;

  /// No description provided for @s5PdfGeneratedAt.
  ///
  /// In en, this message translates to:
  /// **'Created: {time}'**
  String s5PdfGeneratedAt(String time);

  /// No description provided for @s5PdfInhalerByMed.
  ///
  /// In en, this message translates to:
  /// **'{name}: {n} entries'**
  String s5PdfInhalerByMed(String name, int n);

  /// No description provided for @s5PdfInhalerMedNotRecorded.
  ///
  /// In en, this message translates to:
  /// **'Medication not recorded: {n} entries'**
  String s5PdfInhalerMedNotRecorded(int n);

  /// No description provided for @s5PdfInhalerUnknown.
  ///
  /// In en, this message translates to:
  /// **'Medication not identified by patient: {n} entries'**
  String s5PdfInhalerUnknown(int n);

  /// No description provided for @s5PdfInhalerUses.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use entries: {n} (on {days} days)'**
  String s5PdfInhalerUses(int n, int days);

  /// No description provided for @s5PdfIsEnglish.
  ///
  /// In en, this message translates to:
  /// **'The PDF is created in English. Free text you typed stays in your language.'**
  String get s5PdfIsEnglish;

  /// No description provided for @s5PdfMedNamesAsEntered.
  ///
  /// In en, this message translates to:
  /// **'Medication names are shown as entered by the patient.'**
  String get s5PdfMedNamesAsEntered;

  /// No description provided for @s5PdfNotRecorded.
  ///
  /// In en, this message translates to:
  /// **'Not recorded'**
  String get s5PdfNotRecorded;

  /// No description provided for @s5PdfNotUsedReason.
  ///
  /// In en, this message translates to:
  /// **'Reason for not using (self-reported) — {label}: {n} days'**
  String s5PdfNotUsedReason(String label, int n);

  /// No description provided for @s5PdfOutdated.
  ///
  /// In en, this message translates to:
  /// **'Your records or answers changed after the last PDF. Create a new PDF to include the changes.'**
  String get s5PdfOutdated;

  /// No description provided for @s5PdfPeriod.
  ///
  /// In en, this message translates to:
  /// **'Summary period: {start} – {end} ({days} days)'**
  String s5PdfPeriod(String start, String end, int days);

  /// No description provided for @s5PdfReasonCount.
  ///
  /// In en, this message translates to:
  /// **'Reason — {label}: {n} entries'**
  String s5PdfReasonCount(String label, int n);

  /// No description provided for @s5PdfRecordedDays.
  ///
  /// In en, this message translates to:
  /// **'Days with any patient entry: {n}'**
  String s5PdfRecordedDays(int n);

  /// No description provided for @s5PdfSectionAboutData.
  ///
  /// In en, this message translates to:
  /// **'About this information'**
  String get s5PdfSectionAboutData;

  /// No description provided for @s5PdfSectionBarriers.
  ///
  /// In en, this message translates to:
  /// **'Difficulties getting care (self-reported)'**
  String get s5PdfSectionBarriers;

  /// No description provided for @s5PdfSectionEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Local environment (reference)'**
  String get s5PdfSectionEnvironment;

  /// No description provided for @s5PdfSectionInhaler.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use'**
  String get s5PdfSectionInhaler;

  /// No description provided for @s5PdfSectionInsurance.
  ///
  /// In en, this message translates to:
  /// **'Notes for paperwork (patient-provided)'**
  String get s5PdfSectionInsurance;

  /// No description provided for @s5PdfSectionMedChecks.
  ///
  /// In en, this message translates to:
  /// **'Self-reported medication use'**
  String get s5PdfSectionMedChecks;

  /// No description provided for @s5PdfSectionQuestions.
  ///
  /// In en, this message translates to:
  /// **'Patient questions'**
  String get s5PdfSectionQuestions;

  /// No description provided for @s5PdfSectionSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get s5PdfSectionSymptoms;

  /// No description provided for @s5PdfSymptomCodeDays.
  ///
  /// In en, this message translates to:
  /// **'{label}: {n} days'**
  String s5PdfSymptomCodeDays(String label, int n);

  /// No description provided for @s5PdfSymptomDays.
  ///
  /// In en, this message translates to:
  /// **'Days with any symptom: {n} of {days}'**
  String s5PdfSymptomDays(int n, int days);

  /// No description provided for @s5PdfSymptomOtherDays.
  ///
  /// In en, this message translates to:
  /// **'Other symptoms described by patient: {n} days'**
  String s5PdfSymptomOtherDays(int n);

  /// No description provided for @s5PdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Patient-reported asthma visit summary'**
  String get s5PdfTitle;

  /// No description provided for @s5PeriodAndRecordedDays.
  ///
  /// In en, this message translates to:
  /// **'Period: {days} days · Days with records: {n}'**
  String s5PeriodAndRecordedDays(int days, int n);

  /// No description provided for @s5PhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Include the country code. Example: +1 201 555 0123'**
  String get s5PhoneHint;

  /// No description provided for @s5PhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a name and a phone number with the country code, for example +1 201 555 0123.'**
  String get s5PhoneInvalid;

  /// No description provided for @s5PollenGrass.
  ///
  /// In en, this message translates to:
  /// **'Grass'**
  String get s5PollenGrass;

  /// No description provided for @s5PollenMainType.
  ///
  /// In en, this message translates to:
  /// **'Main type: {type}'**
  String s5PollenMainType(String type);

  /// No description provided for @s5PollenTree.
  ///
  /// In en, this message translates to:
  /// **'Tree'**
  String get s5PollenTree;

  /// No description provided for @s5PollenWeed.
  ///
  /// In en, this message translates to:
  /// **'Weed'**
  String get s5PollenWeed;

  /// No description provided for @s5PrepareVisit.
  ///
  /// In en, this message translates to:
  /// **'Prepare for visit'**
  String get s5PrepareVisit;

  /// No description provided for @s5PreviewEditHint.
  ///
  /// In en, this message translates to:
  /// **'To change a question or note, go back and edit it. To change numbers, edit the entries in My log.'**
  String get s5PreviewEditHint;

  /// No description provided for @s5PreviewSummary.
  ///
  /// In en, this message translates to:
  /// **'Preview visit summary'**
  String get s5PreviewSummary;

  /// No description provided for @s5PreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Visit summary preview'**
  String get s5PreviewTitle;

  /// No description provided for @s5PuffsValue.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 puff} other{{n} puffs}}'**
  String s5PuffsValue(int n);

  /// No description provided for @s5QuestionN.
  ///
  /// In en, this message translates to:
  /// **'Question {n}'**
  String s5QuestionN(int n);

  /// No description provided for @s5QuestionOf.
  ///
  /// In en, this message translates to:
  /// **'Question {n} of {total}'**
  String s5QuestionOf(int n, int total);

  /// No description provided for @s5ReasonBeforeActivity.
  ///
  /// In en, this message translates to:
  /// **'Before activity'**
  String get s5ReasonBeforeActivity;

  /// No description provided for @s5ReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get s5ReasonOther;

  /// No description provided for @s5ReasonSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Because of symptoms'**
  String get s5ReasonSymptoms;

  /// No description provided for @s5RecentInhaler.
  ///
  /// In en, this message translates to:
  /// **'Inhaler use entries: {n}'**
  String s5RecentInhaler(int n);

  /// No description provided for @s5RecentSymptomDays.
  ///
  /// In en, this message translates to:
  /// **'Days with symptoms: {n}'**
  String s5RecentSymptomDays(int n);

  /// No description provided for @s5RecentTitle.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get s5RecentTitle;

  /// No description provided for @s5RecordsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load your records. Please try again.'**
  String get s5RecordsLoadFailed;

  /// No description provided for @s5RecordsManageHint.
  ///
  /// In en, this message translates to:
  /// **'You can edit or delete entries in My log. Deleting always asks you to confirm.'**
  String get s5RecordsManageHint;

  /// No description provided for @s5Refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get s5Refresh;

  /// No description provided for @s5Reload.
  ///
  /// In en, this message translates to:
  /// **'Load again'**
  String get s5Reload;

  /// No description provided for @s5Save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get s5Save;

  /// No description provided for @s5Saved.
  ///
  /// In en, this message translates to:
  /// **'Saved.'**
  String get s5Saved;

  /// No description provided for @s5SavedPlacesHint.
  ///
  /// In en, this message translates to:
  /// **'Saved places such as home, school, or work'**
  String get s5SavedPlacesHint;

  /// No description provided for @s5SaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save. Your entries are still here.'**
  String get s5SaveFailed;

  /// No description provided for @s5SavePdf.
  ///
  /// In en, this message translates to:
  /// **'Save PDF'**
  String get s5SavePdf;

  /// No description provided for @s5SettingsAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get s5SettingsAlerts;

  /// No description provided for @s5SettingsArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get s5SettingsArea;

  /// No description provided for @s5SettingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get s5SettingsHelp;

  /// No description provided for @s5SettingsLanguageNote.
  ///
  /// In en, this message translates to:
  /// **'Your visit summary is created in English. You can compare it with your own language before sharing.'**
  String get s5SettingsLanguageNote;

  /// No description provided for @s5SettingsSecurityData.
  ///
  /// In en, this message translates to:
  /// **'Security and data'**
  String get s5SettingsSecurityData;

  /// No description provided for @s5Share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get s5Share;

  /// No description provided for @s5SourcesAir.
  ///
  /// In en, this message translates to:
  /// **'Air quality: EPA AirNow, Open-Meteo, PurpleAir'**
  String get s5SourcesAir;

  /// No description provided for @s5SourcesFlood.
  ///
  /// In en, this message translates to:
  /// **'Flood alerts: National Weather Service'**
  String get s5SourcesFlood;

  /// No description provided for @s5SourcesNjTraffic.
  ///
  /// In en, this message translates to:
  /// **'Traffic count data is used only in New Jersey.'**
  String get s5SourcesNjTraffic;

  /// No description provided for @s5SourcesNoRiskScore.
  ///
  /// In en, this message translates to:
  /// **'The app\'s internal combined score is not an asthma attack risk and is not shown.'**
  String get s5SourcesNoRiskScore;

  /// No description provided for @s5SourcesPollen.
  ///
  /// In en, this message translates to:
  /// **'Pollen: Google Pollen API'**
  String get s5SourcesPollen;

  /// No description provided for @s5SourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Sources and limits'**
  String get s5SourcesTitle;

  /// No description provided for @s5SourcesWeather.
  ///
  /// In en, this message translates to:
  /// **'Weather and humidity: Open-Meteo'**
  String get s5SourcesWeather;

  /// No description provided for @s5StatusLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get s5StatusLatest;

  /// No description provided for @s5StatusOlder.
  ///
  /// In en, this message translates to:
  /// **'Older data'**
  String get s5StatusOlder;

  /// No description provided for @s5StatusUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Can\'t check right now'**
  String get s5StatusUnavailable;

  /// No description provided for @s5SymActivityLimited.
  ///
  /// In en, this message translates to:
  /// **'Activities limited'**
  String get s5SymActivityLimited;

  /// No description provided for @s5SymCough.
  ///
  /// In en, this message translates to:
  /// **'Cough'**
  String get s5SymCough;

  /// No description provided for @s5SymNightWaking.
  ///
  /// In en, this message translates to:
  /// **'Woke up at night'**
  String get s5SymNightWaking;

  /// No description provided for @s5SymNone.
  ///
  /// In en, this message translates to:
  /// **'No symptoms'**
  String get s5SymNone;

  /// No description provided for @s5SymOther.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get s5SymOther;

  /// No description provided for @s5SymOtherHint.
  ///
  /// In en, this message translates to:
  /// **'Describe in your own words'**
  String get s5SymOtherHint;

  /// No description provided for @s5SymShortBreath.
  ///
  /// In en, this message translates to:
  /// **'Hard to breathe'**
  String get s5SymShortBreath;

  /// No description provided for @s5SymWheeze.
  ///
  /// In en, this message translates to:
  /// **'Wheezing'**
  String get s5SymWheeze;

  /// No description provided for @s5SymptomEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit symptoms'**
  String get s5SymptomEditTitle;

  /// No description provided for @s5SymptomEntry.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get s5SymptomEntry;

  /// No description provided for @s5SymptomNoneHint.
  ///
  /// In en, this message translates to:
  /// **'Days you don\'t record are shown as “not recorded”, not as “no symptoms”.'**
  String get s5SymptomNoneHint;

  /// No description provided for @s5SymptomQuestion.
  ///
  /// In en, this message translates to:
  /// **'What did you notice?'**
  String get s5SymptomQuestion;

  /// No description provided for @s5Today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get s5Today;

  /// No description provided for @s5Undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get s5Undo;

  /// No description provided for @s5UntranslatedNotice.
  ///
  /// In en, this message translates to:
  /// **'{n, plural, =1{1 entry is not translated. It appears in the English PDF in your language, marked “Not translated”.} other{{n} entries are not translated. They appear in the English PDF in your language, marked “Not translated”.}}'**
  String s5UntranslatedNotice(int n);

  /// No description provided for @s5UpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated {time}'**
  String s5UpdatedAt(String time);

  /// No description provided for @s5UpiHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get s5UpiHigh;

  /// No description provided for @s5UpiLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get s5UpiLow;

  /// No description provided for @s5UpiModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get s5UpiModerate;

  /// No description provided for @s5UpiNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get s5UpiNone;

  /// No description provided for @s5UpiValue.
  ///
  /// In en, this message translates to:
  /// **'{upi} of 5 · {category}'**
  String s5UpiValue(int upi, String category);

  /// No description provided for @s5UpiVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very high'**
  String get s5UpiVeryHigh;

  /// No description provided for @s5UpiVeryLow.
  ///
  /// In en, this message translates to:
  /// **'Very low'**
  String get s5UpiVeryLow;

  /// No description provided for @s5UrgentActionPlan.
  ///
  /// In en, this message translates to:
  /// **'If your clinician gave you an asthma action plan, follow it.'**
  String get s5UrgentActionPlan;

  /// No description provided for @s5UrgentCall911Locked.
  ///
  /// In en, this message translates to:
  /// **'Urgent help: call 911'**
  String get s5UrgentCall911Locked;

  /// No description provided for @s5UrgentHelp.
  ///
  /// In en, this message translates to:
  /// **'Urgent help'**
  String get s5UrgentHelp;

  /// No description provided for @s5UrgentIntro.
  ///
  /// In en, this message translates to:
  /// **'If breathing is very hard or not getting better, call 911.'**
  String get s5UrgentIntro;

  /// No description provided for @s5UrgentLogHint.
  ///
  /// In en, this message translates to:
  /// **'Optional: save a record that you used your inhaler.'**
  String get s5UrgentLogHint;

  /// No description provided for @s5UrgentNoContact.
  ///
  /// In en, this message translates to:
  /// **'No emergency contact yet. Add one in Settings → Help.'**
  String get s5UrgentNoContact;

  /// No description provided for @s5UsingMedication.
  ///
  /// In en, this message translates to:
  /// **'Logs as: {name}'**
  String s5UsingMedication(String name);

  /// No description provided for @s5ViewMyLog.
  ///
  /// In en, this message translates to:
  /// **'View my log'**
  String get s5ViewMyLog;

  /// No description provided for @s5VisitBarriers.
  ///
  /// In en, this message translates to:
  /// **'Did you have trouble getting care?'**
  String get s5VisitBarriers;

  /// No description provided for @s5VisitCardDetail.
  ///
  /// In en, this message translates to:
  /// **'Last {days} days · Days with records: {recorded} · Questions: {questions}'**
  String s5VisitCardDetail(int days, int recorded, int questions);

  /// No description provided for @s5VisitCardTitle.
  ///
  /// In en, this message translates to:
  /// **'What to share at your visit'**
  String get s5VisitCardTitle;

  /// No description provided for @s5VisitInclude.
  ///
  /// In en, this message translates to:
  /// **'Records to include'**
  String get s5VisitInclude;

  /// No description provided for @s5VisitIntro.
  ///
  /// In en, this message translates to:
  /// **'Organize your symptoms and questions to show your clinician.'**
  String get s5VisitIntro;

  /// No description provided for @s5VisitPeriod.
  ///
  /// In en, this message translates to:
  /// **'Summary period'**
  String get s5VisitPeriod;

  /// No description provided for @s5VisitPrepTitle.
  ///
  /// In en, this message translates to:
  /// **'Visit prep'**
  String get s5VisitPrepTitle;

  /// No description provided for @s5VisitQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions for your doctor'**
  String get s5VisitQuestions;

  /// No description provided for @s5VisitQuestionsHint.
  ///
  /// In en, this message translates to:
  /// **'Write in your own language. You can leave these empty.'**
  String get s5VisitQuestionsHint;

  /// No description provided for @s6AddTime.
  ///
  /// In en, this message translates to:
  /// **'Add a time'**
  String get s6AddTime;

  /// No description provided for @s6AddVisit.
  ///
  /// In en, this message translates to:
  /// **'Add a visit I reported'**
  String get s6AddVisit;

  /// No description provided for @s6BringPaper.
  ///
  /// In en, this message translates to:
  /// **'I will bring a paper'**
  String get s6BringPaper;

  /// No description provided for @s6BringPaperHint.
  ///
  /// In en, this message translates to:
  /// **'Bringing a paper does not mean a clinician has confirmed it.'**
  String get s6BringPaperHint;

  /// No description provided for @s6DaySummary.
  ///
  /// In en, this message translates to:
  /// **'{date} · confirmed {used}/{scheduled} · unconfirmed {open} · symptoms {symptoms} · {env}'**
  String s6DaySummary(
    String date,
    int used,
    int scheduled,
    int open,
    int symptoms,
    String env,
  );

  /// No description provided for @s6DoseLater.
  ///
  /// In en, this message translates to:
  /// **'Check later'**
  String get s6DoseLater;

  /// No description provided for @s6DoseNotUsed.
  ///
  /// In en, this message translates to:
  /// **'I could not use it'**
  String get s6DoseNotUsed;

  /// No description provided for @s6DoseUnconfirmed.
  ///
  /// In en, this message translates to:
  /// **'No answer yet'**
  String get s6DoseUnconfirmed;

  /// No description provided for @s6DoseUsed.
  ///
  /// In en, this message translates to:
  /// **'I used it'**
  String get s6DoseUsed;

  /// No description provided for @s6EnvLinked.
  ///
  /// In en, this message translates to:
  /// **'Environment linked'**
  String get s6EnvLinked;

  /// No description provided for @s6EnvNoData.
  ///
  /// In en, this message translates to:
  /// **'No environment data for that time'**
  String get s6EnvNoData;

  /// No description provided for @s6EvidenceBody.
  ///
  /// In en, this message translates to:
  /// **'Organizes records for your clinician and what still needs to be added.'**
  String get s6EvidenceBody;

  /// No description provided for @s6EvidenceNotOfficial.
  ///
  /// In en, this message translates to:
  /// **'This is a general list. It is not an official list of requirements from a specific insurance plan.'**
  String get s6EvidenceNotOfficial;

  /// No description provided for @s6EvidenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare records for a visit or insurance review'**
  String get s6EvidenceTitle;

  /// No description provided for @s6HideMedName.
  ///
  /// In en, this message translates to:
  /// **'Hide the medicine name on the lock screen'**
  String get s6HideMedName;

  /// No description provided for @s6HideMedNameHint.
  ///
  /// In en, this message translates to:
  /// **'The reminder still arrives at the times you saved. It is not a repeating background alert.'**
  String get s6HideMedNameHint;

  /// No description provided for @s6HomeWaterNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get s6HomeWaterNo;

  /// No description provided for @s6HomeWaterQuestion.
  ///
  /// In en, this message translates to:
  /// **'Was there a leak or flooding at home?'**
  String get s6HomeWaterQuestion;

  /// No description provided for @s6HomeWaterYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get s6HomeWaterYes;

  /// No description provided for @s6ItemClinician.
  ///
  /// In en, this message translates to:
  /// **'Clinician confirmation or papers to bring'**
  String get s6ItemClinician;

  /// No description provided for @s6ItemEnvironment.
  ///
  /// In en, this message translates to:
  /// **'Local environment reference at the time of an event'**
  String get s6ItemEnvironment;

  /// No description provided for @s6ItemMedication.
  ///
  /// In en, this message translates to:
  /// **'Medicine name and prescription'**
  String get s6ItemMedication;

  /// No description provided for @s6ItemSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Ongoing symptoms and limits on daily life'**
  String get s6ItemSymptoms;

  /// No description provided for @s6ItemUse.
  ///
  /// In en, this message translates to:
  /// **'Time period and use you confirmed'**
  String get s6ItemUse;

  /// No description provided for @s6ItemVisits.
  ///
  /// In en, this message translates to:
  /// **'Visits and emergency visits you reported'**
  String get s6ItemVisits;

  /// No description provided for @s6NoSchedule.
  ///
  /// In en, this message translates to:
  /// **'No saved dose times yet. Add them under My medications.'**
  String get s6NoSchedule;

  /// No description provided for @s6OccurredLabel.
  ///
  /// In en, this message translates to:
  /// **'When it happened'**
  String get s6OccurredLabel;

  /// No description provided for @s6PdfEnvLimit.
  ///
  /// In en, this message translates to:
  /// **'Regional reference only. It does not show personal exposure or the cause of symptoms. A single AQI does not name ozone and particles together, and it does not include pollen.'**
  String get s6PdfEnvLimit;

  /// No description provided for @s6PdfEnvTitle.
  ///
  /// In en, this message translates to:
  /// **'Environment reference (appendix)'**
  String get s6PdfEnvTitle;

  /// No description provided for @s6PuffsEach.
  ///
  /// In en, this message translates to:
  /// **'Puffs each time'**
  String get s6PuffsEach;

  /// No description provided for @s6ReminderBodyNamed.
  ///
  /// In en, this message translates to:
  /// **'Time to confirm {name}'**
  String s6ReminderBodyNamed(String name);

  /// No description provided for @s6ReminderBodyPrivate.
  ///
  /// In en, this message translates to:
  /// **'Time to confirm your medicine'**
  String get s6ReminderBodyPrivate;

  /// No description provided for @s6ReminderChannel.
  ///
  /// In en, this message translates to:
  /// **'Reminders at the dose times you saved. This is not the 30-minute air and weather alert.'**
  String get s6ReminderChannel;

  /// No description provided for @s6ReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Medicine check'**
  String get s6ReminderTitle;

  /// No description provided for @s6RoleBoth.
  ///
  /// In en, this message translates to:
  /// **'Daily and as needed'**
  String get s6RoleBoth;

  /// No description provided for @s6RoleController.
  ///
  /// In en, this message translates to:
  /// **'Daily medicine'**
  String get s6RoleController;

  /// No description provided for @s6RoleRescue.
  ///
  /// In en, this message translates to:
  /// **'As needed'**
  String get s6RoleRescue;

  /// No description provided for @s6ScheduleTimes.
  ///
  /// In en, this message translates to:
  /// **'Times you take it'**
  String get s6ScheduleTimes;

  /// No description provided for @s6StatusClinician.
  ///
  /// In en, this message translates to:
  /// **'Clinician confirmation needed'**
  String get s6StatusClinician;

  /// No description provided for @s6StatusNeedInfo.
  ///
  /// In en, this message translates to:
  /// **'More information needed'**
  String get s6StatusNeedInfo;

  /// No description provided for @s6StatusRecorded.
  ///
  /// In en, this message translates to:
  /// **'Recorded'**
  String get s6StatusRecorded;

  /// No description provided for @s6TimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'Treatment and environment'**
  String get s6TimelineTitle;

  /// No description provided for @s6TodayDoses.
  ///
  /// In en, this message translates to:
  /// **'Medicines to confirm today'**
  String get s6TodayDoses;

  /// No description provided for @s6VisitKindEr.
  ///
  /// In en, this message translates to:
  /// **'Emergency room (I reported this)'**
  String get s6VisitKindEr;

  /// No description provided for @s6VisitKindOffice.
  ///
  /// In en, this message translates to:
  /// **'Clinic visit (I reported this)'**
  String get s6VisitKindOffice;

  /// No description provided for @s6VisitKindOther.
  ///
  /// In en, this message translates to:
  /// **'Other visit (I reported this)'**
  String get s6VisitKindOther;

  /// No description provided for @s6VisitKindUrgent.
  ///
  /// In en, this message translates to:
  /// **'Urgent care (I reported this)'**
  String get s6VisitKindUrgent;

  /// No description provided for @v2SettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Coverage letters'**
  String get v2SettingsTitle;

  /// No description provided for @v2NavToggle.
  ///
  /// In en, this message translates to:
  /// **'Show coverage-letter home'**
  String get v2NavToggle;

  /// No description provided for @v2NavToggleHint.
  ///
  /// In en, this message translates to:
  /// **'A preview for reading a denial notice and preparing visit materials. Your records stay available. Live document reading stays off.'**
  String get v2NavToggleHint;

  /// No description provided for @v2HomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Understand a coverage denial letter and prepare materials for a visit.'**
  String get v2HomeHeadline;

  /// No description provided for @v2HomeBody.
  ///
  /// In en, this message translates to:
  /// **'The app does not send an appeal and does not decide whether a plan will approve it.'**
  String get v2HomeBody;

  /// No description provided for @v2AddLetter.
  ///
  /// In en, this message translates to:
  /// **'Add a denial letter'**
  String get v2AddLetter;

  /// No description provided for @v2TrySample.
  ///
  /// In en, this message translates to:
  /// **'Try a sample'**
  String get v2TrySample;

  /// No description provided for @v2SampleBanner.
  ///
  /// In en, this message translates to:
  /// **'Sample. Not a real notice and not a live reading.'**
  String get v2SampleBanner;

  /// No description provided for @v2LiveOffTitle.
  ///
  /// In en, this message translates to:
  /// **'Live reading is off'**
  String get v2LiveOffTitle;

  /// No description provided for @v2LiveOffBody.
  ///
  /// In en, this message translates to:
  /// **'Photos and files are not analyzed in this build. You can open the labeled sample and walk through the steps.'**
  String get v2LiveOffBody;

  /// No description provided for @v2Close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get v2Close;

  /// No description provided for @v2MyRecords.
  ///
  /// In en, this message translates to:
  /// **'My records'**
  String get v2MyRecords;

  /// No description provided for @v2EmptyCases.
  ///
  /// In en, this message translates to:
  /// **'No letters yet.'**
  String get v2EmptyCases;

  /// No description provided for @v2MedNeedsReview.
  ///
  /// In en, this message translates to:
  /// **'Medication needs review'**
  String get v2MedNeedsReview;

  /// No description provided for @v2NextCheck.
  ///
  /// In en, this message translates to:
  /// **'Next: review the facts'**
  String get v2NextCheck;

  /// No description provided for @v2NextDraft.
  ///
  /// In en, this message translates to:
  /// **'Next: make a draft'**
  String get v2NextDraft;

  /// No description provided for @v2Created.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get v2Created;

  /// No description provided for @v2StatusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft ready'**
  String get v2StatusDraft;

  /// No description provided for @v2StatusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready for a draft'**
  String get v2StatusReady;

  /// No description provided for @v2StatusReview.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get v2StatusReview;

  /// No description provided for @v2DeadlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get v2DeadlineLabel;

  /// No description provided for @v2ExplainTitle.
  ///
  /// In en, this message translates to:
  /// **'Plain explanation'**
  String get v2ExplainTitle;

  /// No description provided for @v2CheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Things to check'**
  String get v2CheckTitle;

  /// No description provided for @v2RecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'My records'**
  String get v2RecordsTitle;

  /// No description provided for @v2DocsTitle.
  ///
  /// In en, this message translates to:
  /// **'Make documents'**
  String get v2DocsTitle;

  /// No description provided for @v2Original.
  ///
  /// In en, this message translates to:
  /// **'Original text'**
  String get v2Original;

  /// No description provided for @v2Patient.
  ///
  /// In en, this message translates to:
  /// **'Name on the notice'**
  String get v2Patient;

  /// No description provided for @v2EditMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication text'**
  String get v2EditMedication;

  /// No description provided for @v2Dose.
  ///
  /// In en, this message translates to:
  /// **'Dose as written'**
  String get v2Dose;

  /// No description provided for @v2ReasonMissing.
  ///
  /// In en, this message translates to:
  /// **'The reason could not be confirmed.'**
  String get v2ReasonMissing;

  /// No description provided for @v2ConfirmDate.
  ///
  /// In en, this message translates to:
  /// **'I confirm the date printed on the notice'**
  String get v2ConfirmDate;

  /// No description provided for @v2SaveEdit.
  ///
  /// In en, this message translates to:
  /// **'Save correction'**
  String get v2SaveEdit;

  /// No description provided for @v2ConfirmFacts.
  ///
  /// In en, this message translates to:
  /// **'I reviewed these facts'**
  String get v2ConfirmFacts;

  /// No description provided for @v2Confirmed.
  ///
  /// In en, this message translates to:
  /// **'Reviewed'**
  String get v2Confirmed;

  /// No description provided for @v2NoRecords.
  ///
  /// In en, this message translates to:
  /// **'No records linked. You can still make a draft. No adherence figure is added.'**
  String get v2NoRecords;

  /// No description provided for @v2SelfReportLabel.
  ///
  /// In en, this message translates to:
  /// **'Optional note (patient self-report)'**
  String get v2SelfReportLabel;

  /// No description provided for @v2EnglishDraft.
  ///
  /// In en, this message translates to:
  /// **'English draft for review. This is the draft to check, not a filed translation.'**
  String get v2EnglishDraft;

  /// No description provided for @v2DraftBannerNote.
  ///
  /// In en, this message translates to:
  /// **'Every page says clinician review is required.'**
  String get v2DraftBannerNote;

  /// No description provided for @v2StaleDraft.
  ///
  /// In en, this message translates to:
  /// **'Facts changed. Make the draft again before sharing.'**
  String get v2StaleDraft;

  /// No description provided for @v2GenerateReview.
  ///
  /// In en, this message translates to:
  /// **'Make a review draft'**
  String get v2GenerateReview;

  /// No description provided for @v2GeneratePrepared.
  ///
  /// In en, this message translates to:
  /// **'Make a prepared draft'**
  String get v2GeneratePrepared;

  /// No description provided for @v2PreparedBlocked.
  ///
  /// In en, this message translates to:
  /// **'A prepared draft needs a confirmed name, medication, and denial reason.'**
  String get v2PreparedBlocked;

  /// No description provided for @v2NotInitial.
  ///
  /// In en, this message translates to:
  /// **'This document is not an initial drug denial. An appeal draft is not created.'**
  String get v2NotInitial;

  /// No description provided for @v2GenericError.
  ///
  /// In en, this message translates to:
  /// **'That step did not finish. You can try again.'**
  String get v2GenericError;

  /// No description provided for @v2Share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get v2Share;

  /// No description provided for @v2ClinicianPdf.
  ///
  /// In en, this message translates to:
  /// **'Clinician one-page PDF'**
  String get v2ClinicianPdf;

  /// No description provided for @v2ShareNotSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Sharing does not mean the plan received this file.'**
  String get v2ShareNotSubmitted;

  /// No description provided for @v2DeleteCase.
  ///
  /// In en, this message translates to:
  /// **'Delete this sample'**
  String get v2DeleteCase;

  /// No description provided for @v2Deleted.
  ///
  /// In en, this message translates to:
  /// **'Removed from this preview.'**
  String get v2Deleted;

  /// No description provided for @v2FontUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The PDF font could not be loaded. Try again when you are online.'**
  String get v2FontUnavailable;

  /// No description provided for @v2NotEntered.
  ///
  /// In en, this message translates to:
  /// **'[not entered]'**
  String get v2NotEntered;

  /// No description provided for @v2DocDeadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline written on the document'**
  String get v2DocDeadline;

  /// No description provided for @v2CalcDeadline.
  ///
  /// In en, this message translates to:
  /// **'Calculated from the received date you entered'**
  String get v2CalcDeadline;

  /// No description provided for @v2NeedReceived.
  ///
  /// In en, this message translates to:
  /// **'The notice counts days after you receive it. Enter that date before a date can be calculated.'**
  String get v2NeedReceived;

  /// No description provided for @v2UnclearDeadline.
  ///
  /// In en, this message translates to:
  /// **'The deadline wording is unclear. No date was calculated.'**
  String get v2UnclearDeadline;

  /// No description provided for @v2AskPlan.
  ///
  /// In en, this message translates to:
  /// **'A deadline was not found in the document. Ask the plan.'**
  String get v2AskPlan;

  /// No description provided for @cnTagline.
  ///
  /// In en, this message translates to:
  /// **'Insurance letters, clear next steps'**
  String get cnTagline;

  /// No description provided for @cnDemoBadge.
  ///
  /// In en, this message translates to:
  /// **'Sample'**
  String get cnDemoBadge;

  /// No description provided for @cnDemoBadgeLong.
  ///
  /// In en, this message translates to:
  /// **'Sample with made-up data. Results are fixed.'**
  String get cnDemoBadgeLong;

  /// No description provided for @cnAuthSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get cnAuthSignInTitle;

  /// No description provided for @cnAuthCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get cnAuthCreateTitle;

  /// No description provided for @cnAuthResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get cnAuthResetTitle;

  /// No description provided for @cnAuthSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get cnAuthSignIn;

  /// No description provided for @cnAuthCreate.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get cnAuthCreate;

  /// No description provided for @cnAuthSendReset.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get cnAuthSendReset;

  /// No description provided for @cnAuthProfileError.
  ///
  /// In en, this message translates to:
  /// **'You are signed in, but your account could not be loaded ({code}).'**
  String cnAuthProfileError(String code);

  /// No description provided for @cnRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get cnRetry;

  /// No description provided for @cnSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get cnSignOut;

  /// No description provided for @cnAuthPreparingAccount.
  ///
  /// In en, this message translates to:
  /// **'Setting up your account…'**
  String get cnAuthPreparingAccount;

  /// No description provided for @cnAuthNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name (optional)'**
  String get cnAuthNameLabel;

  /// No description provided for @cnAuthNameHelper.
  ///
  /// In en, this message translates to:
  /// **'Shown on your packets. You can change it later.'**
  String get cnAuthNameHelper;

  /// No description provided for @cnAuthEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get cnAuthEmailLabel;

  /// No description provided for @cnAuthPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get cnAuthPasswordLabel;

  /// No description provided for @cnAuthPasswordHelper.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get cnAuthPasswordHelper;

  /// No description provided for @cnAuthShowPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get cnAuthShowPassword;

  /// No description provided for @cnAuthHidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get cnAuthHidePassword;

  /// No description provided for @cnAuthPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get cnAuthPasswordRequired;

  /// No description provided for @cnAuthCheckEmail.
  ///
  /// In en, this message translates to:
  /// **'We sent a confirmation link to {email}. Open it on this phone, then sign in.'**
  String cnAuthCheckEmail(String email);

  /// No description provided for @cnAuthResetSent.
  ///
  /// In en, this message translates to:
  /// **'If an account exists for {email}, a reset link is on its way. Open it on this phone.'**
  String cnAuthResetSent(String email);

  /// No description provided for @cnAuthResent.
  ///
  /// In en, this message translates to:
  /// **'Sent again.'**
  String get cnAuthResent;

  /// No description provided for @cnAuthResend.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get cnAuthResend;

  /// No description provided for @cnAuthSignInInstead.
  ///
  /// In en, this message translates to:
  /// **'I confirmed. Sign in'**
  String get cnAuthSignInInstead;

  /// No description provided for @cnAuthForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get cnAuthForgot;

  /// No description provided for @cnAuthNoAccount.
  ///
  /// In en, this message translates to:
  /// **'New here? Create an account'**
  String get cnAuthNoAccount;

  /// No description provided for @cnAuthHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account? Sign in'**
  String get cnAuthHaveAccount;

  /// No description provided for @cnAuthResetHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and we will send a link to set a new password.'**
  String get cnAuthResetHint;

  /// No description provided for @cnAuthBackToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get cnAuthBackToSignIn;

  /// No description provided for @cnAuthPrivacyLine.
  ///
  /// In en, this message translates to:
  /// **'Your letters and records are private to your account.'**
  String get cnAuthPrivacyLine;

  /// No description provided for @cnAuthPasswordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated.'**
  String get cnAuthPasswordUpdated;

  /// No description provided for @cnAuthNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set a new password'**
  String get cnAuthNewPasswordTitle;

  /// No description provided for @cnAuthNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get cnAuthNewPasswordLabel;

  /// No description provided for @cnAuthSavePassword.
  ///
  /// In en, this message translates to:
  /// **'Save password'**
  String get cnAuthSavePassword;

  /// No description provided for @cnLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get cnLater;

  /// No description provided for @cnAuthErrInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is not correct.'**
  String get cnAuthErrInvalidCredentials;

  /// No description provided for @cnAuthErrNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your email first. Check your inbox or resend the link.'**
  String get cnAuthErrNotConfirmed;

  /// No description provided for @cnAuthErrExists.
  ///
  /// In en, this message translates to:
  /// **'An account with this email already exists. Sign in instead.'**
  String get cnAuthErrExists;

  /// No description provided for @cnAuthErrWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Choose a stronger password (at least 8 characters).'**
  String get cnAuthErrWeakPassword;

  /// No description provided for @cnAuthErrSamePassword.
  ///
  /// In en, this message translates to:
  /// **'Use a password different from your old one.'**
  String get cnAuthErrSamePassword;

  /// No description provided for @cnAuthErrRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Too many tries. Wait a minute and try again.'**
  String get cnAuthErrRateLimited;

  /// No description provided for @cnAuthErrInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Check the email address.'**
  String get cnAuthErrInvalidEmail;

  /// No description provided for @cnAuthErrEmailNotAuthorized.
  ///
  /// In en, this message translates to:
  /// **'We could not send email to this address right now. Try again later.'**
  String get cnAuthErrEmailNotAuthorized;

  /// No description provided for @cnAuthErrDisabled.
  ///
  /// In en, this message translates to:
  /// **'This sign-in method is turned off.'**
  String get cnAuthErrDisabled;

  /// No description provided for @cnAuthErrSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Your session ended. Please sign in again.'**
  String get cnAuthErrSessionExpired;

  /// No description provided for @cnAuthErrUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong ({code}). Try again.'**
  String cnAuthErrUnknown(String code);

  /// No description provided for @cnErrNetwork.
  ///
  /// In en, this message translates to:
  /// **'No connection. Check your internet and try again.'**
  String get cnErrNetwork;

  /// No description provided for @cnErrServiceDown.
  ///
  /// In en, this message translates to:
  /// **'The service is not responding. Try again in a few minutes.'**
  String get cnErrServiceDown;

  /// No description provided for @cnTabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get cnTabHome;

  /// No description provided for @cnTabCases.
  ///
  /// In en, this message translates to:
  /// **'Cases'**
  String get cnTabCases;

  /// No description provided for @cnTabRecords.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get cnTabRecords;

  /// No description provided for @cnTabAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get cnTabAccount;

  /// No description provided for @cnHomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Make sense of your insurance letter.'**
  String get cnHomeHeadline;

  /// No description provided for @cnScanLetter.
  ///
  /// In en, this message translates to:
  /// **'Scan a letter'**
  String get cnScanLetter;

  /// No description provided for @cnUploadFile.
  ///
  /// In en, this message translates to:
  /// **'Upload PDF / photo'**
  String get cnUploadFile;

  /// No description provided for @cnTryDemo.
  ///
  /// In en, this message translates to:
  /// **'Try demo'**
  String get cnTryDemo;

  /// No description provided for @cnHomeSignInLine.
  ///
  /// In en, this message translates to:
  /// **'Saving your cases needs an account.'**
  String get cnHomeSignInLine;

  /// No description provided for @cnServiceNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'This build is not connected to the server. Only the demo works.'**
  String get cnServiceNotConfigured;

  /// No description provided for @cnContinueCase.
  ///
  /// In en, this message translates to:
  /// **'Continue your case'**
  String get cnContinueCase;

  /// No description provided for @cnHowItWorks.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get cnHowItWorks;

  /// No description provided for @cnStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Read the letter'**
  String get cnStep1Title;

  /// No description provided for @cnStep1Body.
  ///
  /// In en, this message translates to:
  /// **'Take a photo. We find the reason, the next step and the date.'**
  String get cnStep1Body;

  /// No description provided for @cnStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Gather records'**
  String get cnStep2Title;

  /// No description provided for @cnStep2Body.
  ///
  /// In en, this message translates to:
  /// **'Match what the letter asks for to your own records.'**
  String get cnStep2Body;

  /// No description provided for @cnStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Create a packet'**
  String get cnStep3Title;

  /// No description provided for @cnStep3Body.
  ///
  /// In en, this message translates to:
  /// **'Get a one-page doctor summary and a draft review request.'**
  String get cnStep3Body;

  /// No description provided for @cnRecentCases.
  ///
  /// In en, this message translates to:
  /// **'Other cases'**
  String get cnRecentCases;

  /// No description provided for @cnNoCasesYet.
  ///
  /// In en, this message translates to:
  /// **'No cases yet'**
  String get cnNoCasesYet;

  /// No description provided for @cnNoOtherCases.
  ///
  /// In en, this message translates to:
  /// **'No other cases.'**
  String get cnNoOtherCases;

  /// No description provided for @cnSeeAllCases.
  ///
  /// In en, this message translates to:
  /// **'See all cases'**
  String get cnSeeAllCases;

  /// No description provided for @cnNoCasesBody.
  ///
  /// In en, this message translates to:
  /// **'Scan an insurance letter to start.'**
  String get cnNoCasesBody;

  /// No description provided for @cnCasesSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to see your cases'**
  String get cnCasesSignInTitle;

  /// No description provided for @cnCasesSignInBody.
  ///
  /// In en, this message translates to:
  /// **'Or open the demo to see how it works.'**
  String get cnCasesSignInBody;

  /// No description provided for @cnCaseDeleted.
  ///
  /// In en, this message translates to:
  /// **'Case deleted.'**
  String get cnCaseDeleted;

  /// No description provided for @cnCaseUntitled.
  ///
  /// In en, this message translates to:
  /// **'Insurance letter'**
  String get cnCaseUntitled;

  /// No description provided for @cnStatusReading.
  ///
  /// In en, this message translates to:
  /// **'Reading letter'**
  String get cnStatusReading;

  /// No description provided for @cnStatusNeedsReview.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get cnStatusNeedsReview;

  /// No description provided for @cnStatusGatherRecords.
  ///
  /// In en, this message translates to:
  /// **'Gather records'**
  String get cnStatusGatherRecords;

  /// No description provided for @cnStatusPacketReady.
  ///
  /// In en, this message translates to:
  /// **'Packet ready'**
  String get cnStatusPacketReady;

  /// No description provided for @cnStatusNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get cnStatusNeedsAttention;

  /// No description provided for @cnStatusNotStarted.
  ///
  /// In en, this message translates to:
  /// **'Not started'**
  String get cnStatusNotStarted;

  /// No description provided for @cnNextWaitReading.
  ///
  /// In en, this message translates to:
  /// **'We are reading the letter.'**
  String get cnNextWaitReading;

  /// No description provided for @cnNextTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Reading stopped. Open the case to try again.'**
  String get cnNextTryAgain;

  /// No description provided for @cnNextFactsToConfirm.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 fact to confirm} other{{count} facts to confirm}}'**
  String cnNextFactsToConfirm(int count);

  /// No description provided for @cnNextItemsAttached.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} requested items handled'**
  String cnNextItemsAttached(int done, int total);

  /// No description provided for @cnNextSharePacket.
  ///
  /// In en, this message translates to:
  /// **'Packet ready to share'**
  String get cnNextSharePacket;

  /// No description provided for @cnNextCreatePacket.
  ///
  /// In en, this message translates to:
  /// **'Next: create the packet'**
  String get cnNextCreatePacket;

  /// No description provided for @cnDateToCheckShort.
  ///
  /// In en, this message translates to:
  /// **'Date to check: {date}'**
  String cnDateToCheckShort(String date);

  /// No description provided for @cnDatePassedShort.
  ///
  /// In en, this message translates to:
  /// **'Date passed: {date}'**
  String cnDatePassedShort(String date);

  /// No description provided for @cnMoreActions.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get cnMoreActions;

  /// No description provided for @cnDeleteCase.
  ///
  /// In en, this message translates to:
  /// **'Delete case'**
  String get cnDeleteCase;

  /// No description provided for @cnDeleteCaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this case?'**
  String get cnDeleteCaseTitle;

  /// No description provided for @cnDeleteCaseBody.
  ///
  /// In en, this message translates to:
  /// **'This removes the letter pages, the facts read from them, linked record summaries and packets. Your medication and symptom records stay.'**
  String get cnDeleteCaseBody;

  /// No description provided for @cnCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cnCancel;

  /// No description provided for @cnDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get cnDelete;

  /// No description provided for @cnDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not delete. Check your connection and try again.'**
  String get cnDeleteFailed;

  /// No description provided for @cnKindInitialDenial.
  ///
  /// In en, this message translates to:
  /// **'Drug coverage denial'**
  String get cnKindInitialDenial;

  /// No description provided for @cnKindInfoRequest.
  ///
  /// In en, this message translates to:
  /// **'Request for more information'**
  String get cnKindInfoRequest;

  /// No description provided for @cnKindReauth.
  ///
  /// In en, this message translates to:
  /// **'Renewal (reauthorization) notice'**
  String get cnKindReauth;

  /// No description provided for @cnKindFinalDenial.
  ///
  /// In en, this message translates to:
  /// **'Final appeal decision'**
  String get cnKindFinalDenial;

  /// No description provided for @cnKindEob.
  ///
  /// In en, this message translates to:
  /// **'Bill or explanation of benefits'**
  String get cnKindEob;

  /// No description provided for @cnKindOther.
  ///
  /// In en, this message translates to:
  /// **'Other letter'**
  String get cnKindOther;

  /// No description provided for @cnKindUncertain.
  ///
  /// In en, this message translates to:
  /// **'Letter type not clear'**
  String get cnKindUncertain;

  /// No description provided for @cnFieldPatientName.
  ///
  /// In en, this message translates to:
  /// **'Patient name'**
  String get cnFieldPatientName;

  /// No description provided for @cnFieldPlanName.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get cnFieldPlanName;

  /// No description provided for @cnFieldMemberId.
  ///
  /// In en, this message translates to:
  /// **'Member ID'**
  String get cnFieldMemberId;

  /// No description provided for @cnFieldCaseReference.
  ///
  /// In en, this message translates to:
  /// **'Case or reference number'**
  String get cnFieldCaseReference;

  /// No description provided for @cnFieldMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication (as written)'**
  String get cnFieldMedication;

  /// No description provided for @cnFieldDose.
  ///
  /// In en, this message translates to:
  /// **'Dose (as written)'**
  String get cnFieldDose;

  /// No description provided for @cnFieldNoticeDate.
  ///
  /// In en, this message translates to:
  /// **'Notice date'**
  String get cnFieldNoticeDate;

  /// No description provided for @cnFieldContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get cnFieldContact;

  /// No description provided for @cnFieldSubmissionRoute.
  ///
  /// In en, this message translates to:
  /// **'Where to send'**
  String get cnFieldSubmissionRoute;

  /// No description provided for @cnFactEdited.
  ///
  /// In en, this message translates to:
  /// **'Edited by you'**
  String get cnFactEdited;

  /// No description provided for @cnFactChecked.
  ///
  /// In en, this message translates to:
  /// **'Checked'**
  String get cnFactChecked;

  /// No description provided for @cnFactNotInLetter.
  ///
  /// In en, this message translates to:
  /// **'Not in letter'**
  String get cnFactNotInLetter;

  /// No description provided for @cnFactNeedsCheck.
  ///
  /// In en, this message translates to:
  /// **'Needs check'**
  String get cnFactNeedsCheck;

  /// No description provided for @cnFactFromLetter.
  ///
  /// In en, this message translates to:
  /// **'From letter'**
  String get cnFactFromLetter;

  /// No description provided for @cnWhoYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get cnWhoYou;

  /// No description provided for @cnWhoCareTeam.
  ///
  /// In en, this message translates to:
  /// **'Care team'**
  String get cnWhoCareTeam;

  /// No description provided for @cnWhoPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get cnWhoPlan;

  /// No description provided for @cnWhoUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not sure'**
  String get cnWhoUnknown;

  /// No description provided for @cnReqLinked.
  ///
  /// In en, this message translates to:
  /// **'Linked'**
  String get cnReqLinked;

  /// No description provided for @cnReqAskedCareTeam.
  ///
  /// In en, this message translates to:
  /// **'Asked care team'**
  String get cnReqAskedCareTeam;

  /// No description provided for @cnReqNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get cnReqNotAvailable;

  /// No description provided for @cnReqNotNeeded.
  ///
  /// In en, this message translates to:
  /// **'Not needed'**
  String get cnReqNotNeeded;

  /// No description provided for @cnReqNeeded.
  ///
  /// In en, this message translates to:
  /// **'Needed'**
  String get cnReqNeeded;

  /// No description provided for @cnReqReset.
  ///
  /// In en, this message translates to:
  /// **'Mark as needed'**
  String get cnReqReset;

  /// No description provided for @cnRecMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication history'**
  String get cnRecMedication;

  /// No description provided for @cnRecSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Symptom log'**
  String get cnRecSymptoms;

  /// No description provided for @cnRecLocalContext.
  ///
  /// In en, this message translates to:
  /// **'Environmental factors'**
  String get cnRecLocalContext;

  /// No description provided for @cnRecPrn.
  ///
  /// In en, this message translates to:
  /// **'As-needed inhaler'**
  String get cnRecPrn;

  /// No description provided for @cnDemoTitle.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get cnDemoTitle;

  /// No description provided for @cnDemoReset.
  ///
  /// In en, this message translates to:
  /// **'Reset demo'**
  String get cnDemoReset;

  /// No description provided for @cnDemoResetDone.
  ///
  /// In en, this message translates to:
  /// **'Demo reset.'**
  String get cnDemoResetDone;

  /// No description provided for @cnDemoIntro.
  ///
  /// In en, this message translates to:
  /// **'Three made-up letters with fixed results, so you can see each step. Nothing is uploaded.'**
  String get cnDemoIntro;

  /// No description provided for @cnUpEmpty.
  ///
  /// In en, this message translates to:
  /// **'That file is empty.'**
  String get cnUpEmpty;

  /// No description provided for @cnUpTooLarge.
  ///
  /// In en, this message translates to:
  /// **'Each file must be {mb} MB or smaller.'**
  String cnUpTooLarge(int mb);

  /// No description provided for @cnUpCaseTooLarge.
  ///
  /// In en, this message translates to:
  /// **'All pages together must be {mb} MB or smaller.'**
  String cnUpCaseTooLarge(int mb);

  /// No description provided for @cnUpTooManyPages.
  ///
  /// In en, this message translates to:
  /// **'Up to {max} pages per letter.'**
  String cnUpTooManyPages(int max);

  /// No description provided for @cnUpUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Use JPG, PNG or PDF. For HEIC photos, take a new photo here.'**
  String get cnUpUnsupported;

  /// No description provided for @cnUpBadFile.
  ///
  /// In en, this message translates to:
  /// **'This file cannot be read. Try another photo or PDF.'**
  String get cnUpBadFile;

  /// No description provided for @cnUpEncrypted.
  ///
  /// In en, this message translates to:
  /// **'This PDF is password-protected. Save an unlocked copy or take photos.'**
  String get cnUpEncrypted;

  /// No description provided for @cnCameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The camera is not available. You can upload a photo or PDF instead.'**
  String get cnCameraUnavailable;

  /// No description provided for @cnPhotosUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Photos cannot be opened. Allow photo access in settings, or upload a PDF.'**
  String get cnPhotosUnavailable;

  /// No description provided for @cnFilesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Files cannot be opened right now. Try again.'**
  String get cnFilesUnavailable;

  /// No description provided for @cnUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload did not finish. Your pages are still here. Try again.'**
  String get cnUploadFailed;

  /// No description provided for @cnCaptureTitle.
  ///
  /// In en, this message translates to:
  /// **'Add letter pages'**
  String get cnCaptureTitle;

  /// No description provided for @cnReplacePagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace letter pages'**
  String get cnReplacePagesTitle;

  /// No description provided for @cnOpening.
  ///
  /// In en, this message translates to:
  /// **'Opening…'**
  String get cnOpening;

  /// No description provided for @cnCaptureEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Add the pages of your letter'**
  String get cnCaptureEmptyTitle;

  /// No description provided for @cnCaptureTips.
  ///
  /// In en, this message translates to:
  /// **'Lay the page flat in good light and fit all four corners in the frame. Add every page, in order.'**
  String get cnCaptureTips;

  /// No description provided for @cnTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get cnTakePhoto;

  /// No description provided for @cnAddPage.
  ///
  /// In en, this message translates to:
  /// **'Add page'**
  String get cnAddPage;

  /// No description provided for @cnAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get cnAddPhoto;

  /// No description provided for @cnPickGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from photos'**
  String get cnPickGallery;

  /// No description provided for @cnLabelForm.
  ///
  /// In en, this message translates to:
  /// **'Form (as written)'**
  String get cnLabelForm;

  /// No description provided for @cnAddPdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get cnAddPdf;

  /// No description provided for @cnPagesSummary.
  ///
  /// In en, this message translates to:
  /// **'{pages, plural, =1{1 page} other{{pages} pages}} · {size} MB'**
  String cnPagesSummary(int pages, String size);

  /// No description provided for @cnUploadConsent.
  ///
  /// In en, this message translates to:
  /// **'Uploading sends these pages to the CoverNote server, where an AI service reads them for you. You can delete the case at any time.'**
  String get cnUploadConsent;

  /// No description provided for @cnStageUploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading'**
  String get cnStageUploading;

  /// No description provided for @cnUploadAndRead.
  ///
  /// In en, this message translates to:
  /// **'Upload and read'**
  String get cnUploadAndRead;

  /// No description provided for @cnPageN.
  ///
  /// In en, this message translates to:
  /// **'Page {n}'**
  String cnPageN(int n);

  /// No description provided for @cnPdfPages.
  ///
  /// In en, this message translates to:
  /// **'File {n} · PDF, {count, plural, =1{1 page} other{{count} pages}}'**
  String cnPdfPages(int n, int count);

  /// No description provided for @cnPreviewPage.
  ///
  /// In en, this message translates to:
  /// **'Preview page {n}'**
  String cnPreviewPage(int n);

  /// No description provided for @cnRotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get cnRotate;

  /// No description provided for @cnRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get cnRetake;

  /// No description provided for @cnRemovePage.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get cnRemovePage;

  /// No description provided for @cnReorder.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder'**
  String get cnReorder;

  /// No description provided for @cnServiceUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'The letter reader is not set up right now. Your pages are saved; try again later.'**
  String get cnServiceUnavailableBody;

  /// No description provided for @cnNeedNewPagesBody.
  ///
  /// In en, this message translates to:
  /// **'Take clearer photos or use fewer pages, then upload again.'**
  String get cnNeedNewPagesBody;

  /// No description provided for @cnPagesKept.
  ///
  /// In en, this message translates to:
  /// **'Your pages are saved. Nothing was changed.'**
  String get cnPagesKept;

  /// No description provided for @cnReplacePages.
  ///
  /// In en, this message translates to:
  /// **'Replace pages'**
  String get cnReplacePages;

  /// No description provided for @cnTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get cnTryAgain;

  /// No description provided for @cnStageReading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get cnStageReading;

  /// No description provided for @cnStageChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking'**
  String get cnStageChecking;

  /// No description provided for @cnStageReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get cnStageReady;

  /// No description provided for @cnReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Reading your letter'**
  String get cnReadingTitle;

  /// No description provided for @cnReadingBody.
  ///
  /// In en, this message translates to:
  /// **'When it is done, you check what we found against the letter.'**
  String get cnReadingBody;

  /// No description provided for @cnReadingLeaveOk.
  ///
  /// In en, this message translates to:
  /// **'You can leave this screen. Reading continues and your case is saved.'**
  String get cnReadingLeaveOk;

  /// No description provided for @cnStartReading.
  ///
  /// In en, this message translates to:
  /// **'Start reading'**
  String get cnStartReading;

  /// No description provided for @cnStepLetter.
  ///
  /// In en, this message translates to:
  /// **'Letter'**
  String get cnStepLetter;

  /// No description provided for @cnStepReview.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get cnStepReview;

  /// No description provided for @cnStepEvidence.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get cnStepEvidence;

  /// No description provided for @cnStepPacket.
  ///
  /// In en, this message translates to:
  /// **'Packet'**
  String get cnStepPacket;

  /// No description provided for @cnStepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {n} of {total}: {name}'**
  String cnStepOf(int n, int total, String name);

  /// No description provided for @cnSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get cnSaving;

  /// No description provided for @cnSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get cnSaved;

  /// No description provided for @cnNotSavedRetry.
  ///
  /// In en, this message translates to:
  /// **'Not saved · Retry'**
  String get cnNotSavedRetry;

  /// No description provided for @cnViewOriginal.
  ///
  /// In en, this message translates to:
  /// **'View original pages'**
  String get cnViewOriginal;

  /// No description provided for @cnLetterPagesRead.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 page read} other{{count} pages read}}'**
  String cnLetterPagesRead(int count);

  /// No description provided for @cnPagesHardToRead.
  ///
  /// In en, this message translates to:
  /// **'Hard to read: page {list}. Check these facts carefully or retake the page.'**
  String cnPagesHardToRead(String list);

  /// No description provided for @cnRetakePages.
  ///
  /// In en, this message translates to:
  /// **'Retake pages'**
  String get cnRetakePages;

  /// No description provided for @cnHardToRead.
  ///
  /// In en, this message translates to:
  /// **'Hard to read'**
  String get cnHardToRead;

  /// No description provided for @cnContinueToReview.
  ///
  /// In en, this message translates to:
  /// **'Continue to review'**
  String get cnContinueToReview;

  /// No description provided for @cnOriginalPages.
  ///
  /// In en, this message translates to:
  /// **'Original pages'**
  String get cnOriginalPages;

  /// No description provided for @cnNoOriginal.
  ///
  /// In en, this message translates to:
  /// **'No original pages are stored.'**
  String get cnNoOriginal;

  /// No description provided for @cnCheckDetails.
  ///
  /// In en, this message translates to:
  /// **'Check the details'**
  String get cnCheckDetails;

  /// No description provided for @cnCheckDetailsHint.
  ///
  /// In en, this message translates to:
  /// **'Compare each value with your letter. Tap a quote to see where it came from.'**
  String get cnCheckDetailsHint;

  /// No description provided for @cnItemsLeftToCheck.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Check 1 more item to continue} other{Check {count} more items to continue}}'**
  String cnItemsLeftToCheck(int count);

  /// No description provided for @cnContinueToEvidence.
  ///
  /// In en, this message translates to:
  /// **'Continue to evidence'**
  String get cnContinueToEvidence;

  /// No description provided for @cnSeePage.
  ///
  /// In en, this message translates to:
  /// **'See page {n}'**
  String cnSeePage(int n);

  /// No description provided for @cnWhatLetterIs.
  ///
  /// In en, this message translates to:
  /// **'What this letter is'**
  String get cnWhatLetterIs;

  /// No description provided for @cnLooksRight.
  ///
  /// In en, this message translates to:
  /// **'Looks right'**
  String get cnLooksRight;

  /// No description provided for @cnChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get cnChange;

  /// No description provided for @cnCardWhyDenied.
  ///
  /// In en, this message translates to:
  /// **'Why it was denied'**
  String get cnCardWhyDenied;

  /// No description provided for @cnCardWhatTheyNeed.
  ///
  /// In en, this message translates to:
  /// **'What they asked for'**
  String get cnCardWhatTheyNeed;

  /// No description provided for @cnCardWhatItSays.
  ///
  /// In en, this message translates to:
  /// **'What the letter says'**
  String get cnCardWhatItSays;

  /// No description provided for @cnNoReasonFound.
  ///
  /// In en, this message translates to:
  /// **'No reason was found in the letter.'**
  String get cnNoReasonFound;

  /// No description provided for @cnCardNextStep.
  ///
  /// In en, this message translates to:
  /// **'Next step'**
  String get cnCardNextStep;

  /// No description provided for @cnNextDenial.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Ask your care team to request a review. The letter does not list specific items.} =1{Ask your care team to request a review. The letter lists 1 item to send.} other{Ask your care team to request a review. The letter lists {count} items to send.}}'**
  String cnNextDenial(int count);

  /// No description provided for @cnNextInfoRequest.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Send the information the plan asked for by the date below.} =1{Send the 1 item the plan asked for by the date below.} other{Send the {count} items the plan asked for by the date below.}}'**
  String cnNextInfoRequest(int count);

  /// No description provided for @cnNextReauth.
  ///
  /// In en, this message translates to:
  /// **'Note when the current approval ends and ask your care team to start the renewal.'**
  String get cnNextReauth;

  /// No description provided for @cnNextFinal.
  ///
  /// In en, this message translates to:
  /// **'This is a final decision. CoverNote does not draft a first review request for it. Ask the plan or your care team about the options the letter lists.'**
  String get cnNextFinal;

  /// No description provided for @cnNextEob.
  ///
  /// In en, this message translates to:
  /// **'This looks like a bill or benefits statement, not a denial. Check it with the plan\'s member services.'**
  String get cnNextEob;

  /// No description provided for @cnNextUncertain.
  ///
  /// In en, this message translates to:
  /// **'First confirm what kind of letter this is, above.'**
  String get cnNextUncertain;

  /// No description provided for @cnWhereToSend.
  ///
  /// In en, this message translates to:
  /// **'Where to send: {route}'**
  String cnWhereToSend(String route);

  /// No description provided for @cnWhoToCall.
  ///
  /// In en, this message translates to:
  /// **'Contact: {contact}'**
  String cnWhoToCall(String contact);

  /// No description provided for @cnCardDate.
  ///
  /// In en, this message translates to:
  /// **'Date to check'**
  String get cnCardDate;

  /// No description provided for @cnDateCalculated.
  ///
  /// In en, this message translates to:
  /// **'Calculated: {anchor} + {days} calendar days'**
  String cnDateCalculated(String anchor, int days);

  /// No description provided for @cnReceivedDateWord.
  ///
  /// In en, this message translates to:
  /// **'date you received it'**
  String get cnReceivedDateWord;

  /// No description provided for @cnNoticeDateWord.
  ///
  /// In en, this message translates to:
  /// **'notice date'**
  String get cnNoticeDateWord;

  /// No description provided for @cnDateEnteredByYou.
  ///
  /// In en, this message translates to:
  /// **'Entered by you'**
  String get cnDateEnteredByYou;

  /// No description provided for @cnDateFromLetter.
  ///
  /// In en, this message translates to:
  /// **'Stated in the letter'**
  String get cnDateFromLetter;

  /// No description provided for @cnReceivedOn.
  ///
  /// In en, this message translates to:
  /// **'You received it on {date}'**
  String cnReceivedOn(String date);

  /// No description provided for @cnDatePassed.
  ///
  /// In en, this message translates to:
  /// **'This date has passed. Call the plan to ask what you can still do.'**
  String get cnDatePassed;

  /// No description provided for @cnNeedReceivedDate.
  ///
  /// In en, this message translates to:
  /// **'The letter gives {days} calendar days from the day you received it. When did it arrive?'**
  String cnNeedReceivedDate(int days);

  /// No description provided for @cnEnterReceivedDate.
  ///
  /// In en, this message translates to:
  /// **'Enter date received'**
  String get cnEnterReceivedDate;

  /// No description provided for @cnDateConflict.
  ///
  /// In en, this message translates to:
  /// **'The letter gives different dates. Ask the plan which one applies, then pick it.'**
  String get cnDateConflict;

  /// No description provided for @cnUseThisDate.
  ///
  /// In en, this message translates to:
  /// **'Use {date}'**
  String cnUseThisDate(String date);

  /// No description provided for @cnDateUnclear.
  ///
  /// In en, this message translates to:
  /// **'The wording is unclear or counts business days, so CoverNote does not calculate it. Ask the plan for the exact date.'**
  String get cnDateUnclear;

  /// No description provided for @cnNoDeadline.
  ///
  /// In en, this message translates to:
  /// **'No review deadline was found in the letter.'**
  String get cnNoDeadline;

  /// No description provided for @cnReplyBy.
  ///
  /// In en, this message translates to:
  /// **'Reply to the information request by {date} (from the letter)'**
  String cnReplyBy(String date);

  /// No description provided for @cnEnterDatePlanGave.
  ///
  /// In en, this message translates to:
  /// **'Enter a date'**
  String get cnEnterDatePlanGave;

  /// No description provided for @cnUseLetterDate.
  ///
  /// In en, this message translates to:
  /// **'Use the letter\'s date'**
  String get cnUseLetterDate;

  /// No description provided for @cnLeaveUnknown.
  ///
  /// In en, this message translates to:
  /// **'Leave as unknown for now'**
  String get cnLeaveUnknown;

  /// No description provided for @cnDateUnknownChecked.
  ///
  /// In en, this message translates to:
  /// **'Unknown, noted'**
  String get cnDateUnknownChecked;

  /// No description provided for @cnTypeAsWritten.
  ///
  /// In en, this message translates to:
  /// **'Type it exactly as the letter shows.'**
  String get cnTypeAsWritten;

  /// No description provided for @cnCheckThisValue.
  ///
  /// In en, this message translates to:
  /// **'This value looks unusual. Compare it with the letter.'**
  String get cnCheckThisValue;

  /// No description provided for @cnDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get cnDone;

  /// No description provided for @cnEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get cnEdit;

  /// No description provided for @cnAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get cnAdd;

  /// No description provided for @cnNoRecordsToLink.
  ///
  /// In en, this message translates to:
  /// **'No records from the last 30 days to link. You can still mark who has this item.'**
  String get cnNoRecordsToLink;

  /// No description provided for @cnLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Link a record to: {label}'**
  String cnLinkTitle(String label);

  /// No description provided for @cnLinkNote.
  ///
  /// In en, this message translates to:
  /// **'Your own records support the request. They do not replace clinic notes or test results.'**
  String get cnLinkNote;

  /// No description provided for @cnMedLine.
  ///
  /// In en, this message translates to:
  /// **'{taken} taken / {notTaken} not taken / {unknown} unknown of {scheduled} scheduled doses'**
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled);

  /// No description provided for @cnPrnLine.
  ///
  /// In en, this message translates to:
  /// **'As-needed: {uses} uses, {puffs} puffs'**
  String cnPrnLine(int uses, int puffs);

  /// No description provided for @cnNoEntries.
  ///
  /// In en, this message translates to:
  /// **'No entries'**
  String get cnNoEntries;

  /// No description provided for @cnSymptomLine.
  ///
  /// In en, this message translates to:
  /// **'Symptoms on {days} days, night waking on {night} days ({entries} of {total} days logged)'**
  String cnSymptomLine(int days, int night, int entries, int total);

  /// No description provided for @cnPmLine.
  ///
  /// In en, this message translates to:
  /// **'PM2.5 data for {days} of {total} days; {high} days above AQI 100'**
  String cnPmLine(int days, int total, int high);

  /// No description provided for @cnReportsLine.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 self-report} other{{count} self-reports}}'**
  String cnReportsLine(int count);

  /// No description provided for @cnSyntheticData.
  ///
  /// In en, this message translates to:
  /// **'Synthetic data'**
  String get cnSyntheticData;

  /// No description provided for @cnLetterAsksFor.
  ///
  /// In en, this message translates to:
  /// **'What the letter asks for'**
  String get cnLetterAsksFor;

  /// No description provided for @cnNoItemsListed.
  ///
  /// In en, this message translates to:
  /// **'The letter does not list specific items. You can add your own.'**
  String get cnNoItemsListed;

  /// No description provided for @cnAddItemLabel.
  ///
  /// In en, this message translates to:
  /// **'Add an item to track'**
  String get cnAddItemLabel;

  /// No description provided for @cnYourRecords.
  ///
  /// In en, this message translates to:
  /// **'Your records ({from} – {to})'**
  String cnYourRecords(String from, String to);

  /// No description provided for @cnLocalContextNote.
  ///
  /// In en, this message translates to:
  /// **'Optional. These are outdoor factors, not a measurement inside your home and not a cause of symptoms.'**
  String get cnLocalContextNote;

  /// No description provided for @cnContinueToPacket.
  ///
  /// In en, this message translates to:
  /// **'Continue to packet'**
  String get cnContinueToPacket;

  /// No description provided for @cnAddedByYou.
  ///
  /// In en, this message translates to:
  /// **'Added by you'**
  String get cnAddedByYou;

  /// No description provided for @cnFromLetter.
  ///
  /// In en, this message translates to:
  /// **'From letter'**
  String get cnFromLetter;

  /// No description provided for @cnWhoHasIt.
  ///
  /// In en, this message translates to:
  /// **'Who has it: {who}'**
  String cnWhoHasIt(String who);

  /// No description provided for @cnLinkedTo.
  ///
  /// In en, this message translates to:
  /// **'Linked: {record}'**
  String cnLinkedTo(String record);

  /// No description provided for @cnSeeInLetter.
  ///
  /// In en, this message translates to:
  /// **'See in letter'**
  String get cnSeeInLetter;

  /// No description provided for @cnLinkRecords.
  ///
  /// In en, this message translates to:
  /// **'Link my records'**
  String get cnLinkRecords;

  /// No description provided for @cnOtherStatus.
  ///
  /// In en, this message translates to:
  /// **'Other status'**
  String get cnOtherStatus;

  /// No description provided for @cnInPacket.
  ///
  /// In en, this message translates to:
  /// **'In packet'**
  String get cnInPacket;

  /// No description provided for @cnRemoveFromPacket.
  ///
  /// In en, this message translates to:
  /// **'Remove from packet'**
  String get cnRemoveFromPacket;

  /// No description provided for @cnAddToPacket.
  ///
  /// In en, this message translates to:
  /// **'Add to packet'**
  String get cnAddToPacket;

  /// No description provided for @cnErrNotSavedYet.
  ///
  /// In en, this message translates to:
  /// **'Your latest changes are not saved yet. Check your connection and try again.'**
  String get cnErrNotSavedYet;

  /// No description provided for @cnPacketChangedMeanwhile.
  ///
  /// In en, this message translates to:
  /// **'Facts or records changed while the packet was being made. Generate it again.'**
  String get cnPacketChangedMeanwhile;

  /// No description provided for @cnPacketFailed.
  ///
  /// In en, this message translates to:
  /// **'The packet could not be made. Try again.'**
  String get cnPacketFailed;

  /// No description provided for @cnBeforeSharingTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you share'**
  String get cnBeforeSharingTitle;

  /// No description provided for @cnBeforeSharingBody.
  ///
  /// In en, this message translates to:
  /// **'This file has your name and health details. Share it only with your care team or your plan. Sharing does not submit anything for you.'**
  String get cnBeforeSharingBody;

  /// No description provided for @cnShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get cnShare;

  /// No description provided for @cnMethodFax.
  ///
  /// In en, this message translates to:
  /// **'Fax'**
  String get cnMethodFax;

  /// No description provided for @cnMethodMail.
  ///
  /// In en, this message translates to:
  /// **'Mail'**
  String get cnMethodMail;

  /// No description provided for @cnMethodPortal.
  ///
  /// In en, this message translates to:
  /// **'Online portal'**
  String get cnMethodPortal;

  /// No description provided for @cnMethodInPerson.
  ///
  /// In en, this message translates to:
  /// **'In person'**
  String get cnMethodInPerson;

  /// No description provided for @cnMethodCareTeam.
  ///
  /// In en, this message translates to:
  /// **'Care team sent it'**
  String get cnMethodCareTeam;

  /// No description provided for @cnMethodOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get cnMethodOther;

  /// No description provided for @cnPacketNoDraftFinal.
  ///
  /// In en, this message translates to:
  /// **'For a final decision, the packet has the doctor summary only. No first-level review draft is made.'**
  String get cnPacketNoDraftFinal;

  /// No description provided for @cnPacketNoDraftEob.
  ///
  /// In en, this message translates to:
  /// **'For a bill or benefits statement, the packet has the doctor summary only.'**
  String get cnPacketNoDraftEob;

  /// No description provided for @cnPacketNoDraftReauth.
  ///
  /// In en, this message translates to:
  /// **'For a renewal notice, the packet has the doctor summary only, to help your care team renew.'**
  String get cnPacketNoDraftReauth;

  /// No description provided for @cnPacketNoDraftOther.
  ///
  /// In en, this message translates to:
  /// **'Unless the letter is a denial or an information request, the packet has the doctor summary only.'**
  String get cnPacketNoDraftOther;

  /// No description provided for @cnPacketContains.
  ///
  /// In en, this message translates to:
  /// **'This packet will include'**
  String get cnPacketContains;

  /// No description provided for @cnPartSummary.
  ///
  /// In en, this message translates to:
  /// **'Doctor summary (1 page)'**
  String get cnPartSummary;

  /// No description provided for @cnPartDraft.
  ///
  /// In en, this message translates to:
  /// **'Review request draft (for your care team to complete)'**
  String get cnPartDraft;

  /// No description provided for @cnPartLetterText.
  ///
  /// In en, this message translates to:
  /// **'Appendix: the letter text'**
  String get cnPartLetterText;

  /// No description provided for @cnPacketEvidenceCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No record summaries added} =1{1 record summary added} other{{count} record summaries added}}'**
  String cnPacketEvidenceCount(int count);

  /// No description provided for @cnIncludeLetterText.
  ///
  /// In en, this message translates to:
  /// **'Add the letter text as an appendix'**
  String get cnIncludeLetterText;

  /// No description provided for @cnPacketStale.
  ///
  /// In en, this message translates to:
  /// **'Facts or records changed since the last packet. Generate it again to update.'**
  String get cnPacketStale;

  /// No description provided for @cnGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating…'**
  String get cnGenerating;

  /// No description provided for @cnGeneratePacket.
  ///
  /// In en, this message translates to:
  /// **'Generate review packet'**
  String get cnGeneratePacket;

  /// No description provided for @cnSaveOrPrint.
  ///
  /// In en, this message translates to:
  /// **'Save or print'**
  String get cnSaveOrPrint;

  /// No description provided for @cnISentIt.
  ///
  /// In en, this message translates to:
  /// **'I sent it'**
  String get cnISentIt;

  /// No description provided for @cnSharedOn.
  ///
  /// In en, this message translates to:
  /// **'Shared on {date}'**
  String cnSharedOn(String date);

  /// No description provided for @cnUserReportedSent.
  ///
  /// In en, this message translates to:
  /// **'You reported sending it on {date} ({method})'**
  String cnUserReportedSent(String date, String method);

  /// No description provided for @cnTabDoctorSummary.
  ///
  /// In en, this message translates to:
  /// **'Doctor summary'**
  String get cnTabDoctorSummary;

  /// No description provided for @cnTabReviewDraft.
  ///
  /// In en, this message translates to:
  /// **'Review request draft'**
  String get cnTabReviewDraft;

  /// No description provided for @cnSentExplain.
  ///
  /// In en, this message translates to:
  /// **'Record when and how it was sent. CoverNote does not send it or track a decision.'**
  String get cnSentExplain;

  /// No description provided for @cnSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get cnSave;

  /// No description provided for @cnCtxPm25.
  ///
  /// In en, this message translates to:
  /// **'PM2.5 (AQI)'**
  String get cnCtxPm25;

  /// No description provided for @cnCtxNo2.
  ///
  /// In en, this message translates to:
  /// **'NO₂'**
  String get cnCtxNo2;

  /// No description provided for @cnCtxOutdoorHumidity.
  ///
  /// In en, this message translates to:
  /// **'Outdoor humidity'**
  String get cnCtxOutdoorHumidity;

  /// No description provided for @cnObservedOn.
  ///
  /// In en, this message translates to:
  /// **'Observed {date}'**
  String cnObservedOn(String date);

  /// No description provided for @cnCtxIntro.
  ///
  /// In en, this message translates to:
  /// **'Air readings from a named source and things you noticed, kept separate. Add them to a case only if they help explain your records.'**
  String get cnCtxIntro;

  /// No description provided for @cnCtxReadings.
  ///
  /// In en, this message translates to:
  /// **'Air readings'**
  String get cnCtxReadings;

  /// No description provided for @cnCtxReadingsNote.
  ///
  /// In en, this message translates to:
  /// **'Regional readings for the day they were observed. They do not measure traffic exhaust at your home.'**
  String get cnCtxReadingsNote;

  /// No description provided for @cnCtxAddReading.
  ///
  /// In en, this message translates to:
  /// **'Add a reading'**
  String get cnCtxAddReading;

  /// No description provided for @cnCtxReports.
  ///
  /// In en, this message translates to:
  /// **'What you noticed'**
  String get cnCtxReports;

  /// No description provided for @cnCtxReportsNote.
  ///
  /// In en, this message translates to:
  /// **'Your own reports. They are not measurements.'**
  String get cnCtxReportsNote;

  /// No description provided for @cnCtxAddReport.
  ///
  /// In en, this message translates to:
  /// **'Add what you noticed'**
  String get cnCtxAddReport;

  /// No description provided for @cnReportExhaust.
  ///
  /// In en, this message translates to:
  /// **'Strong exhaust nearby'**
  String get cnReportExhaust;

  /// No description provided for @cnReportWater.
  ///
  /// In en, this message translates to:
  /// **'Water intrusion at home'**
  String get cnReportWater;

  /// No description provided for @cnReportDamp.
  ///
  /// In en, this message translates to:
  /// **'Damp or musty indoor area'**
  String get cnReportDamp;

  /// No description provided for @cnOnDate.
  ///
  /// In en, this message translates to:
  /// **'Date: {date}'**
  String cnOnDate(String date);

  /// No description provided for @cnNoteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get cnNoteOptional;

  /// No description provided for @cnCtxWhat.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get cnCtxWhat;

  /// No description provided for @cnCtxHumidityNote.
  ///
  /// In en, this message translates to:
  /// **'Outdoor humidity is weather data. It does not show dampness or mold inside your home.'**
  String get cnCtxHumidityNote;

  /// No description provided for @cnCtxValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get cnCtxValue;

  /// No description provided for @cnCtxValueInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number.'**
  String get cnCtxValueInvalid;

  /// No description provided for @cnCtxSource.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get cnCtxSource;

  /// No description provided for @cnCtxSourceHelp.
  ///
  /// In en, this message translates to:
  /// **'Where the number came from, for example AirNow or a local monitor'**
  String get cnCtxSourceHelp;

  /// No description provided for @cnCtxSourceRequired.
  ///
  /// In en, this message translates to:
  /// **'Add the source.'**
  String get cnCtxSourceRequired;

  /// No description provided for @cnCtxPlace.
  ///
  /// In en, this message translates to:
  /// **'Place (optional)'**
  String get cnCtxPlace;

  /// No description provided for @cnRecordsSignInBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in to keep medication, symptom, and environmental-factor records.'**
  String get cnRecordsSignInBody;

  /// No description provided for @cnRecordsYourRecords.
  ///
  /// In en, this message translates to:
  /// **'Your records'**
  String get cnRecordsYourRecords;

  /// No description provided for @cnRecMedicationSub.
  ///
  /// In en, this message translates to:
  /// **'Medicines and doses you take'**
  String get cnRecMedicationSub;

  /// No description provided for @cnRecDailyLog.
  ///
  /// In en, this message translates to:
  /// **'Daily log'**
  String get cnRecDailyLog;

  /// No description provided for @cnRecDailyLogSub.
  ///
  /// In en, this message translates to:
  /// **'Symptoms and inhaler use'**
  String get cnRecDailyLogSub;

  /// No description provided for @cnRecLocalContextSub.
  ///
  /// In en, this message translates to:
  /// **'Air readings and what you noticed'**
  String get cnRecLocalContextSub;

  /// No description provided for @cnHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get cnHelp;

  /// No description provided for @cnUrgentHelp.
  ///
  /// In en, this message translates to:
  /// **'Urgent help'**
  String get cnUrgentHelp;

  /// No description provided for @cnUrgentHelpSub.
  ///
  /// In en, this message translates to:
  /// **'Steps for a breathing emergency and calling 911'**
  String get cnUrgentHelpSub;

  /// No description provided for @cnLast30Days.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days ({from} – {to})'**
  String cnLast30Days(String from, String to);

  /// No description provided for @cnNoSchedule.
  ///
  /// In en, this message translates to:
  /// **'No regular schedule set'**
  String get cnNoSchedule;

  /// No description provided for @cnRecordsUnknownNote.
  ///
  /// In en, this message translates to:
  /// **'Days without an entry stay unknown. They are not counted as missed.'**
  String get cnRecordsUnknownNote;

  /// No description provided for @cnDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get cnDeleteAccountTitle;

  /// No description provided for @cnDeleteAccountBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your account, cases, uploaded letters, packets and records. It cannot be undone.'**
  String get cnDeleteAccountBody;

  /// No description provided for @cnTypeDelete.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE to confirm'**
  String get cnTypeDelete;

  /// No description provided for @cnDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get cnDeleteAccount;

  /// No description provided for @cnAccountDeleted.
  ///
  /// In en, this message translates to:
  /// **'Your account was deleted.'**
  String get cnAccountDeleted;

  /// No description provided for @cnDeleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'The account could not be deleted. Try again later.'**
  String get cnDeleteAccountFailed;

  /// No description provided for @cnAccountSignedOut.
  ///
  /// In en, this message translates to:
  /// **'You are not signed in.'**
  String get cnAccountSignedOut;

  /// No description provided for @cnLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get cnLanguage;

  /// No description provided for @cnServiceStatus.
  ///
  /// In en, this message translates to:
  /// **'Letter reading service'**
  String get cnServiceStatus;

  /// No description provided for @cnServiceReady.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get cnServiceReady;

  /// No description provided for @cnServiceUnavailableShort.
  ///
  /// In en, this message translates to:
  /// **'Not available right now'**
  String get cnServiceUnavailableShort;

  /// No description provided for @cnChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get cnChecking;

  /// No description provided for @cnServiceUnknown.
  ///
  /// In en, this message translates to:
  /// **'Not checked'**
  String get cnServiceUnknown;

  /// No description provided for @cnCheck.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get cnCheck;

  /// No description provided for @cnAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get cnAbout;

  /// No description provided for @cnAboutBody.
  ///
  /// In en, this message translates to:
  /// **'CoverNote helps you read insurance letters about medicines and prepare papers for your care team. It does not submit anything to your plan, does not decide coverage, and is not medical advice.'**
  String get cnAboutBody;

  /// No description provided for @cnDangerZone.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get cnDangerZone;

  /// No description provided for @cnErrServiceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The letter reader is not available right now.'**
  String get cnErrServiceUnavailable;

  /// No description provided for @cnErrBusy.
  ///
  /// In en, this message translates to:
  /// **'The service is busy. Wait a minute and try again.'**
  String get cnErrBusy;

  /// No description provided for @cnErrSlow.
  ///
  /// In en, this message translates to:
  /// **'Reading took too long. Try again.'**
  String get cnErrSlow;

  /// No description provided for @cnErrUnreadable.
  ///
  /// In en, this message translates to:
  /// **'The pages could not be read. Retake them in better light.'**
  String get cnErrUnreadable;

  /// No description provided for @cnErrTooManyPages.
  ///
  /// In en, this message translates to:
  /// **'Too many pages. Upload up to 10.'**
  String get cnErrTooManyPages;

  /// No description provided for @cnErrTooLarge.
  ///
  /// In en, this message translates to:
  /// **'The files are too large. Use fewer or smaller pages.'**
  String get cnErrTooLarge;

  /// No description provided for @cnErrStale.
  ///
  /// In en, this message translates to:
  /// **'This case changed on another device. Showing the latest version.'**
  String get cnErrStale;

  /// No description provided for @cnErrCaseGone.
  ///
  /// In en, this message translates to:
  /// **'This case no longer exists.'**
  String get cnErrCaseGone;

  /// No description provided for @cnErrAttempts.
  ///
  /// In en, this message translates to:
  /// **'Reading failed several times. Replace the pages or try again later.'**
  String get cnErrAttempts;

  /// No description provided for @cnErrDemoUpload.
  ///
  /// In en, this message translates to:
  /// **'The demo cannot read files. Sign in to scan your own letter.'**
  String get cnErrDemoUpload;

  /// No description provided for @cnErrGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong ({code}). Try again.'**
  String cnErrGeneric(String code);

  /// No description provided for @cnLanguageChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get cnLanguageChoose;

  /// No description provided for @cnLanguageNote.
  ///
  /// In en, this message translates to:
  /// **'Some text was translated by software and may have mistakes. Medicine names and doses stay as printed. The rest of the letter is translated for you.'**
  String get cnLanguageNote;

  /// No description provided for @cnLanguageButtonTooltip.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get cnLanguageButtonTooltip;

  /// No description provided for @cnPacketEnglishNote.
  ///
  /// In en, this message translates to:
  /// **'The packet is written in English so your care team can read it.'**
  String get cnPacketEnglishNote;

  /// No description provided for @cnReasonMissingInformation.
  ///
  /// In en, this message translates to:
  /// **'The plan says it did not get all the information it needed.'**
  String get cnReasonMissingInformation;

  /// No description provided for @cnReasonStepTherapy.
  ///
  /// In en, this message translates to:
  /// **'The plan wants you to try other medicines first.'**
  String get cnReasonStepTherapy;

  /// No description provided for @cnReasonMedicalNecessity.
  ///
  /// In en, this message translates to:
  /// **'The plan says it could not confirm that this medicine is medically needed.'**
  String get cnReasonMedicalNecessity;

  /// No description provided for @cnReasonFormulary.
  ///
  /// In en, this message translates to:
  /// **'The plan says this medicine is not on its list of covered medicines.'**
  String get cnReasonFormulary;

  /// No description provided for @cnReasonQuantityLimit.
  ///
  /// In en, this message translates to:
  /// **'The plan says the amount asked for is more than it covers.'**
  String get cnReasonQuantityLimit;

  /// No description provided for @cnReasonEligibility.
  ///
  /// In en, this message translates to:
  /// **'The plan says this is not covered under its coverage rules.'**
  String get cnReasonEligibility;

  /// No description provided for @cnReasonOther.
  ///
  /// In en, this message translates to:
  /// **'The letter gives another reason. Open the quote from the letter to read it.'**
  String get cnReasonOther;

  /// No description provided for @cnReqHintMedHistory.
  ///
  /// In en, this message translates to:
  /// **'Your past and current medicines'**
  String get cnReqHintMedHistory;

  /// No description provided for @cnReqHintVisitNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes from your doctor visits'**
  String get cnReqHintVisitNotes;

  /// No description provided for @cnReqHintTestResults.
  ///
  /// In en, this message translates to:
  /// **'Test or lab results'**
  String get cnReqHintTestResults;

  /// No description provided for @cnReqHintDoctorStatement.
  ///
  /// In en, this message translates to:
  /// **'A statement from your doctor'**
  String get cnReqHintDoctorStatement;

  /// No description provided for @cnTabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get cnTabSettings;

  /// No description provided for @cnCasesList.
  ///
  /// In en, this message translates to:
  /// **'Case list'**
  String get cnCasesList;

  /// No description provided for @cnGoHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get cnGoHome;

  /// No description provided for @cnAnalyzingTitle.
  ///
  /// In en, this message translates to:
  /// **'Insurance letter · analyzing'**
  String get cnAnalyzingTitle;

  /// No description provided for @cnCaseNumber.
  ///
  /// In en, this message translates to:
  /// **'Case #{n}'**
  String cnCaseNumber(String n);

  /// No description provided for @cnAddedAt.
  ///
  /// In en, this message translates to:
  /// **'Added {when}'**
  String cnAddedAt(String when);

  /// No description provided for @cnAliasHint.
  ///
  /// In en, this message translates to:
  /// **'Nickname (optional)'**
  String get cnAliasHint;

  /// No description provided for @cnShareDocuments.
  ///
  /// In en, this message translates to:
  /// **'Share documents'**
  String get cnShareDocuments;

  /// No description provided for @cnRecordDelivery.
  ///
  /// In en, this message translates to:
  /// **'Record delivery'**
  String get cnRecordDelivery;

  /// No description provided for @cnShareAsk.
  ///
  /// In en, this message translates to:
  /// **'Did you send these documents?'**
  String get cnShareAsk;

  /// No description provided for @cnDeliveryRecipient.
  ///
  /// In en, this message translates to:
  /// **'Sent to'**
  String get cnDeliveryRecipient;

  /// No description provided for @cnRecipientClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic or clinician'**
  String get cnRecipientClinic;

  /// No description provided for @cnRecipientInsurer.
  ///
  /// In en, this message translates to:
  /// **'Insurance plan'**
  String get cnRecipientInsurer;

  /// No description provided for @cnRecipientSelf.
  ///
  /// In en, this message translates to:
  /// **'Kept for myself'**
  String get cnRecipientSelf;

  /// No description provided for @cnRecipientOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get cnRecipientOther;

  /// No description provided for @cnDeliveryMethod.
  ///
  /// In en, this message translates to:
  /// **'How'**
  String get cnDeliveryMethod;

  /// No description provided for @cnMethodEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get cnMethodEmail;

  /// No description provided for @cnMethodMessage.
  ///
  /// In en, this message translates to:
  /// **'Text or messenger'**
  String get cnMethodMessage;

  /// No description provided for @cnMethodUnknown.
  ///
  /// In en, this message translates to:
  /// **'I do not remember'**
  String get cnMethodUnknown;

  /// No description provided for @cnDeliveryUserReport.
  ///
  /// In en, this message translates to:
  /// **'This is what you reported. The app cannot confirm that the other side received it.'**
  String get cnDeliveryUserReport;

  /// No description provided for @cnShareCancelled.
  ///
  /// In en, this message translates to:
  /// **'Share was cancelled. Nothing was marked as sent.'**
  String get cnShareCancelled;

  /// No description provided for @cnRecordsLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading records…'**
  String get cnRecordsLoading;

  /// No description provided for @cnRecordsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No records in this period'**
  String get cnRecordsEmpty;

  /// No description provided for @cnRecordsError.
  ///
  /// In en, this message translates to:
  /// **'Could not load records'**
  String get cnRecordsError;

  /// No description provided for @cnRecordsPermission.
  ///
  /// In en, this message translates to:
  /// **'You do not have access to these records'**
  String get cnRecordsPermission;

  /// No description provided for @cnRecordsPending.
  ///
  /// In en, this message translates to:
  /// **'Saved on this device · waiting to sync'**
  String get cnRecordsPending;

  /// No description provided for @cnRecordsFiltered.
  ///
  /// In en, this message translates to:
  /// **'Some records are hidden by your filters'**
  String get cnRecordsFiltered;

  /// No description provided for @cnRecordsOutside.
  ///
  /// In en, this message translates to:
  /// **'{n} records outside this period'**
  String cnRecordsOutside(int n);

  /// No description provided for @cnWidenRange.
  ///
  /// In en, this message translates to:
  /// **'Show a longer period'**
  String get cnWidenRange;

  /// No description provided for @cnLinkedSummary.
  ///
  /// In en, this message translates to:
  /// **'{days} day(s) · {med} medication uses · {sym} symptom entries'**
  String cnLinkedSummary(int days, int med, int sym);

  /// No description provided for @cnOneDayPacket.
  ///
  /// In en, this message translates to:
  /// **'This packet covers one day.'**
  String get cnOneDayPacket;

  /// No description provided for @cnMyMedications.
  ///
  /// In en, this message translates to:
  /// **'My medications'**
  String get cnMyMedications;

  /// No description provided for @cnScanLabel.
  ///
  /// In en, this message translates to:
  /// **'Scan medication label'**
  String get cnScanLabel;

  /// No description provided for @cnMedManageHint.
  ///
  /// In en, this message translates to:
  /// **'Register medicines you use. Change them when a prescription changes. Daily use is logged on Records.'**
  String get cnMedManageHint;

  /// No description provided for @cnLabelNeedLabel.
  ///
  /// In en, this message translates to:
  /// **'Photograph the pharmacy label or box text. The app does not identify a pill by its shape.'**
  String get cnLabelNeedLabel;

  /// No description provided for @cnLabelUnclear.
  ///
  /// In en, this message translates to:
  /// **'This value was not clear. Check it before saving.'**
  String get cnLabelUnclear;

  /// No description provided for @cnConsentLabel.
  ///
  /// In en, this message translates to:
  /// **'Allow AI to read a medication label'**
  String get cnConsentLabel;

  /// No description provided for @cnManualMed.
  ///
  /// In en, this message translates to:
  /// **'Enter manually'**
  String get cnManualMed;

  /// No description provided for @cnAirWeather.
  ///
  /// In en, this message translates to:
  /// **'Environmental factors near you'**
  String get cnAirWeather;

  /// No description provided for @cnAirAutoNote.
  ///
  /// In en, this message translates to:
  /// **'Air quality, traffic-related air, pollen, flood alerts, and outdoor humidity come from your current location. This phone does not measure the air. Outdoor humidity is not indoor mold.'**
  String get cnAirAutoNote;

  /// No description provided for @cnHomeRecords.
  ///
  /// In en, this message translates to:
  /// **'Related medication records'**
  String get cnHomeRecords;

  /// No description provided for @cnEnvTrap.
  ///
  /// In en, this message translates to:
  /// **'Traffic-related air'**
  String get cnEnvTrap;

  /// No description provided for @cnItemMemo.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get cnItemMemo;

  /// No description provided for @cnSaveNote.
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get cnSaveNote;

  /// No description provided for @cnLocationNeed.
  ///
  /// In en, this message translates to:
  /// **'Allow location to show environmental factors near you.'**
  String get cnLocationNeed;

  /// No description provided for @cnLocationOff.
  ///
  /// In en, this message translates to:
  /// **'Location services are off. Turn them on and try again.'**
  String get cnLocationOff;

  /// No description provided for @cnLocationBlocked.
  ///
  /// In en, this message translates to:
  /// **'Location is blocked. Allow it in settings.'**
  String get cnLocationBlocked;

  /// No description provided for @cnOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get cnOpenSettings;

  /// No description provided for @cnAirNone.
  ///
  /// In en, this message translates to:
  /// **'No air or weather data'**
  String get cnAirNone;

  /// No description provided for @cnAirRetry.
  ///
  /// In en, this message translates to:
  /// **'Try air and weather again'**
  String get cnAirRetry;

  /// No description provided for @cnSetRegion.
  ///
  /// In en, this message translates to:
  /// **'Set your area (ZIP or city)'**
  String get cnSetRegion;

  /// No description provided for @cnConfiguredArea.
  ///
  /// In en, this message translates to:
  /// **'Area you set'**
  String get cnConfiguredArea;

  /// No description provided for @cnRecordPlace.
  ///
  /// In en, this message translates to:
  /// **'Place of this record'**
  String get cnRecordPlace;

  /// No description provided for @cnClosestObservation.
  ///
  /// In en, this message translates to:
  /// **'Closest observation to the record time'**
  String get cnClosestObservation;

  /// No description provided for @cnEnvUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No matching observation for that time'**
  String get cnEnvUnavailable;

  /// No description provided for @cnLogMedication.
  ///
  /// In en, this message translates to:
  /// **'Log {name}'**
  String cnLogMedication(String name);

  /// No description provided for @cnAsNeededUse.
  ///
  /// In en, this message translates to:
  /// **'As-needed use'**
  String get cnAsNeededUse;

  /// No description provided for @cnAsNeededInhaler.
  ///
  /// In en, this message translates to:
  /// **'As-needed inhaler use'**
  String get cnAsNeededInhaler;

  /// No description provided for @cnScheduledUse.
  ///
  /// In en, this message translates to:
  /// **'Scheduled use'**
  String get cnScheduledUse;

  /// No description provided for @cnExtraUse.
  ///
  /// In en, this message translates to:
  /// **'Extra use'**
  String get cnExtraUse;

  /// No description provided for @cnUndoUse.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get cnUndoUse;

  /// No description provided for @cnLoggedLocal.
  ///
  /// In en, this message translates to:
  /// **'Saved on this device'**
  String get cnLoggedLocal;

  /// No description provided for @cnLoggedPending.
  ///
  /// In en, this message translates to:
  /// **'Waiting to sync'**
  String get cnLoggedPending;

  /// No description provided for @cnLoggedSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get cnLoggedSynced;

  /// No description provided for @cnDaysLogged.
  ///
  /// In en, this message translates to:
  /// **'Logged on {n} days this week'**
  String cnDaysLogged(int n);

  /// No description provided for @cnManageMedsLink.
  ///
  /// In en, this message translates to:
  /// **'Manage my medications'**
  String get cnManageMedsLink;

  /// No description provided for @cnViewAirWeather.
  ///
  /// In en, this message translates to:
  /// **'View environmental factors near you'**
  String get cnViewAirWeather;

  /// No description provided for @cnConsentAi.
  ///
  /// In en, this message translates to:
  /// **'Allow AI document analysis'**
  String get cnConsentAi;

  /// No description provided for @cnConsentAiBody.
  ///
  /// In en, this message translates to:
  /// **'The letter image is sent to a reading service so CoverNote can show what it says. You can turn this off later in Settings.'**
  String get cnConsentAiBody;

  /// No description provided for @cnConsentAndAnalyze.
  ///
  /// In en, this message translates to:
  /// **'Agree and analyze'**
  String get cnConsentAndAnalyze;

  /// No description provided for @cnConsentLater.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get cnConsentLater;

  /// No description provided for @cnConsentViewLocal.
  ///
  /// In en, this message translates to:
  /// **'View the original here'**
  String get cnConsentViewLocal;

  /// No description provided for @cnConsentDetails.
  ///
  /// In en, this message translates to:
  /// **'More about data use'**
  String get cnConsentDetails;

  /// No description provided for @cnConsentLabelPurpose.
  ///
  /// In en, this message translates to:
  /// **'Read a medication label'**
  String get cnConsentLabelPurpose;

  /// No description provided for @cnConsentLetterPurpose.
  ///
  /// In en, this message translates to:
  /// **'Read an insurance letter'**
  String get cnConsentLetterPurpose;

  /// No description provided for @cnConsentTranslatePurpose.
  ///
  /// In en, this message translates to:
  /// **'Translate a letter'**
  String get cnConsentTranslatePurpose;

  /// No description provided for @cnToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get cnToday;

  /// No description provided for @cnLast7.
  ///
  /// In en, this message translates to:
  /// **'Last 7 days'**
  String get cnLast7;

  /// No description provided for @cnLast30.
  ///
  /// In en, this message translates to:
  /// **'Last 30 days'**
  String get cnLast30;

  /// No description provided for @cnCustomRange.
  ///
  /// In en, this message translates to:
  /// **'Choose dates'**
  String get cnCustomRange;

  /// No description provided for @cnRangeSummary.
  ///
  /// In en, this message translates to:
  /// **'{from}–{to} · {days} day(s) · {count} records'**
  String cnRangeSummary(String from, String to, int days, int count);

  /// No description provided for @cnNoRecordThatDay.
  ///
  /// In en, this message translates to:
  /// **'No record this day'**
  String get cnNoRecordThatDay;

  /// No description provided for @cnNotLogged.
  ///
  /// In en, this message translates to:
  /// **'Not logged'**
  String get cnNotLogged;

  /// No description provided for @cnNotTaken.
  ///
  /// In en, this message translates to:
  /// **'Marked as not taken'**
  String get cnNotTaken;

  /// No description provided for @cnOriginalFile.
  ///
  /// In en, this message translates to:
  /// **'Original file'**
  String get cnOriginalFile;

  /// No description provided for @cnFullTranslation.
  ///
  /// In en, this message translates to:
  /// **'Full translation'**
  String get cnFullTranslation;

  /// No description provided for @cnRecognizedText.
  ///
  /// In en, this message translates to:
  /// **'Recognized text'**
  String get cnRecognizedText;

  /// No description provided for @cnSameLanguage.
  ///
  /// In en, this message translates to:
  /// **'Same language as the original'**
  String get cnSameLanguage;

  /// No description provided for @cnTranslationPartial.
  ///
  /// In en, this message translates to:
  /// **'Some pages are not translated yet'**
  String get cnTranslationPartial;

  /// No description provided for @cnTranslationFailed.
  ///
  /// In en, this message translates to:
  /// **'This page could not be translated'**
  String get cnTranslationFailed;

  /// No description provided for @cnOriginalMissing.
  ///
  /// In en, this message translates to:
  /// **'The original file could not be found. You can upload it again.'**
  String get cnOriginalMissing;

  /// No description provided for @cnTranslateRetry.
  ///
  /// In en, this message translates to:
  /// **'Continue translation'**
  String get cnTranslateRetry;

  /// No description provided for @cnKeyDetails.
  ///
  /// In en, this message translates to:
  /// **'Key details'**
  String get cnKeyDetails;

  /// No description provided for @cnWhatAbout.
  ///
  /// In en, this message translates to:
  /// **'What is this about?'**
  String get cnWhatAbout;

  /// No description provided for @cnWhatToDo.
  ///
  /// In en, this message translates to:
  /// **'What to do now'**
  String get cnWhatToDo;

  /// No description provided for @cnByWhen.
  ///
  /// In en, this message translates to:
  /// **'By when?'**
  String get cnByWhen;

  /// No description provided for @cnPreparePacket.
  ///
  /// In en, this message translates to:
  /// **'Prepare documents'**
  String get cnPreparePacket;

  /// No description provided for @cnCorrectReading.
  ///
  /// In en, this message translates to:
  /// **'Correct a reading error'**
  String get cnCorrectReading;

  /// No description provided for @cnCorrectReadingNote.
  ///
  /// In en, this message translates to:
  /// **'The original letter does not change. Only the automatic reading is corrected.'**
  String get cnCorrectReadingNote;

  /// No description provided for @cnReviewImportant.
  ///
  /// In en, this message translates to:
  /// **'Check these important values before creating documents'**
  String get cnReviewImportant;

  /// No description provided for @cnPacketReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your documents are ready'**
  String get cnPacketReadyTitle;

  /// No description provided for @cnNextSendClinic.
  ///
  /// In en, this message translates to:
  /// **'Send the documents to your clinician and ask them to review'**
  String get cnNextSendClinic;

  /// No description provided for @cnNextWaitReply.
  ///
  /// In en, this message translates to:
  /// **'When you get a reply, record the result'**
  String get cnNextWaitReply;

  /// No description provided for @cnExistingSentNewReady.
  ///
  /// In en, this message translates to:
  /// **'Earlier documents were sent · you can make a new set'**
  String get cnExistingSentNewReady;

  /// No description provided for @cnWhyRecords.
  ///
  /// In en, this message translates to:
  /// **'Medication and symptom records can help a clinician see how treatment is going. You can still make documents from the letter if you have no records yet.'**
  String get cnWhyRecords;

  /// No description provided for @cnLetterAskedRecords.
  ///
  /// In en, this message translates to:
  /// **'The letter asked for recent treatment records'**
  String get cnLetterAskedRecords;

  /// No description provided for @cnOptionalReference.
  ///
  /// In en, this message translates to:
  /// **'Optional reference'**
  String get cnOptionalReference;

  /// No description provided for @cnAsthmaContext.
  ///
  /// In en, this message translates to:
  /// **'Asthma treatment records — scheduled use, as-needed use, and breathing symptoms.'**
  String get cnAsthmaContext;

  /// No description provided for @cnGeneralContext.
  ///
  /// In en, this message translates to:
  /// **'Treatment records — medication use and symptoms or notes.'**
  String get cnGeneralContext;

  /// No description provided for @cnTreatmentQuestion.
  ///
  /// In en, this message translates to:
  /// **'What treatment is this letter about?'**
  String get cnTreatmentQuestion;

  /// No description provided for @cnTreatmentAsthma.
  ///
  /// In en, this message translates to:
  /// **'Asthma'**
  String get cnTreatmentAsthma;

  /// No description provided for @cnTreatmentOther.
  ///
  /// In en, this message translates to:
  /// **'Another treatment'**
  String get cnTreatmentOther;

  /// No description provided for @cnTreatmentUnknown.
  ///
  /// In en, this message translates to:
  /// **'I am not sure yet'**
  String get cnTreatmentUnknown;

  /// No description provided for @cnStatusWaitingClinic.
  ///
  /// In en, this message translates to:
  /// **'Sent to the clinic · waiting for review'**
  String get cnStatusWaitingClinic;

  /// No description provided for @cnStatusWaitingInsurer.
  ///
  /// In en, this message translates to:
  /// **'Reported as submitted to the plan · waiting for a reply'**
  String get cnStatusWaitingInsurer;

  /// No description provided for @cnFollowUpNeeded.
  ///
  /// In en, this message translates to:
  /// **'Follow-up needed'**
  String get cnFollowUpNeeded;

  /// No description provided for @cnOutcomeRecorded.
  ///
  /// In en, this message translates to:
  /// **'Result recorded'**
  String get cnOutcomeRecorded;

  /// No description provided for @cnActiveCases.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get cnActiveCases;

  /// No description provided for @cnCompletedArchived.
  ///
  /// In en, this message translates to:
  /// **'Completed & archived'**
  String get cnCompletedArchived;

  /// No description provided for @cnCompleteCase.
  ///
  /// In en, this message translates to:
  /// **'Complete this case'**
  String get cnCompleteCase;

  /// No description provided for @cnArchiveCase.
  ///
  /// In en, this message translates to:
  /// **'Archive'**
  String get cnArchiveCase;

  /// No description provided for @cnReopenCase.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get cnReopenCase;

  /// No description provided for @cnOutcomeApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get cnOutcomeApproved;

  /// No description provided for @cnOutcomeDenied.
  ///
  /// In en, this message translates to:
  /// **'Denied'**
  String get cnOutcomeDenied;

  /// No description provided for @cnOutcomeStopped.
  ///
  /// In en, this message translates to:
  /// **'Not continuing'**
  String get cnOutcomeStopped;

  /// No description provided for @cnOutcomeOther.
  ///
  /// In en, this message translates to:
  /// **'Other / not recorded'**
  String get cnOutcomeOther;

  /// No description provided for @cnSentIsNotComplete.
  ///
  /// In en, this message translates to:
  /// **'Sending is not the same as completing the case.'**
  String get cnSentIsNotComplete;

  /// No description provided for @cnArchivedCase.
  ///
  /// In en, this message translates to:
  /// **'Archived'**
  String get cnArchivedCase;

  /// No description provided for @cnStepKeyDetails.
  ///
  /// In en, this message translates to:
  /// **'Key details'**
  String get cnStepKeyDetails;

  /// No description provided for @cnStepAddRecords.
  ///
  /// In en, this message translates to:
  /// **'Add my records'**
  String get cnStepAddRecords;

  /// No description provided for @cnStepReviewPacket.
  ///
  /// In en, this message translates to:
  /// **'Review packet'**
  String get cnStepReviewPacket;

  /// No description provided for @cnDataConsent.
  ///
  /// In en, this message translates to:
  /// **'Data processing'**
  String get cnDataConsent;

  /// No description provided for @cnZipOrCity.
  ///
  /// In en, this message translates to:
  /// **'ZIP or city'**
  String get cnZipOrCity;

  /// No description provided for @cnSaveArea.
  ///
  /// In en, this message translates to:
  /// **'Save area'**
  String get cnSaveArea;

  /// No description provided for @cnWeekCalendar.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get cnWeekCalendar;

  /// No description provided for @cnMonthCalendar.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get cnMonthCalendar;

  /// No description provided for @cnUsedShort.
  ///
  /// In en, this message translates to:
  /// **'I used it'**
  String get cnUsedShort;

  /// No description provided for @cnCalendarLegend.
  ///
  /// In en, this message translates to:
  /// **'A dot means you logged something that day. An empty day is not a missed dose.'**
  String get cnCalendarLegend;
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
    'ar',
    'en',
    'es',
    'gu',
    'ht',
    'ko',
    'pt',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hans':
            return AppLocalizationsZhHans();
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'gu':
      return AppLocalizationsGu();
    case 'ht':
      return AppLocalizationsHt();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
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
