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
  /// **'Smarter asthma prevention for every family.'**
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
