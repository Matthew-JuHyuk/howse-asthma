// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginButton => 'Log in';

  @override
  String get signUpButton => 'Sign up';

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
  String get medicationLogAddButton => 'Log Inhaler / Medication Use';

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
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguageLabel => 'Language';

  @override
  String get settingsLocationLabel => 'Location';

  @override
  String get notificationAttackWarningTitle => 'Asthma Attack Risk Alert';

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
  String get navHome => 'Home';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get authChooseRole => 'Choose your role';

  @override
  String get authRolePatient => 'Patient';

  @override
  String get authRolePatientHint => 'Track air quality risk and inhaler use';

  @override
  String get authRoleProvider => 'Provider';

  @override
  String get authRoleProviderHint =>
      'Link patients and review clinical evidence';

  @override
  String get authFullNameLabel => 'Full name';

  @override
  String get authNpiLabel => 'NPI number';

  @override
  String get authNpiHelper => '10-digit National Provider Identifier';

  @override
  String get authOrContinueWith => 'or continue with';

  @override
  String get authContinueGoogle => 'Continue with Google';

  @override
  String get authContinueApple => 'Continue with Apple';

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
  String get authSignOut => 'Sign out';

  @override
  String get authRetry => 'Retry';

  @override
  String get authWorking => 'Working…';

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
  String get authErrorGeneric => 'Something went wrong. Please try again.';

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
  String get authBiometricTitle => 'Unlock Howse Asthma';

  @override
  String get authBiometricHint => 'Use biometrics to continue';

  @override
  String get authBiometricReason => 'Unlock Howse Asthma';

  @override
  String get authBiometricUnlock => 'Unlock';

  @override
  String get authBiometricFailed => 'Biometric unlock failed. Try again.';

  @override
  String get authBiometricToggle => 'Biometric unlock';

  @override
  String get authBiometricToggleHint =>
      'Require biometric unlock when opening the app';

  @override
  String get authBiometricUnavailable =>
      'Biometrics are not available on this device';

  @override
  String get authOnboardingTitle => 'Patient setup';

  @override
  String get authOnboardingBody =>
      'If your clinician shared an 8-character invite code, enter it now. You can also do this later in Settings.';

  @override
  String get authOnboardingSkip => 'Skip for now';

  @override
  String get authInviteCodeLabel => 'Provider invite code';

  @override
  String get authInviteCodeHelper => '8 letters/numbers, expires in 24 hours';

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
  String get authInviteIssueFailed => 'Could not issue invite code';

  @override
  String get authConfirmLink => 'Confirm';

  @override
  String get authRejectLink => 'Reject';

  @override
  String get authLinkStatusPending => 'Pending confirmation';

  @override
  String get settingsSystemDefault => 'System default';

  @override
  String get settingsLocationTodo =>
      'Location permission will be requested in a later update';

  @override
  String get providerHomeTab => 'Home';

  @override
  String get providerLinkTab => 'Link';

  @override
  String get providerHomeTitle => 'Provider home';

  @override
  String providerHomeWelcome(String email) {
    return 'Signed in as $email';
  }

  @override
  String get providerHomePlaceholder =>
      'Patient clinical dashboards arrive in a later release. Start by linking patients.';

  @override
  String get providerLinkPatientsCta => 'Link patients';

  @override
  String get providerLinkTitle => 'Link patients';

  @override
  String get providerLinkIntro =>
      'Issue an 8-character code (valid 24 hours). The patient enters it, then both sides confirm.';

  @override
  String get providerIssueInviteCta => 'Issue invite code';

  @override
  String get providerInviteTtlHint => 'Valid for 24 hours';

  @override
  String get providerInviteCopied => 'Invite code copied';

  @override
  String get providerPendingLinks => 'Pending links';

  @override
  String get providerNoPendingLinks => 'No pending links';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'Patient $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'Recent invite codes';

  @override
  String get providerNoInvites => 'No invite codes yet';

  @override
  String get providerInviteConsumed => 'Used';

  @override
  String get providerInviteActive => 'Active';

  @override
  String get splashTagline => 'Your smart shield against triggers';

  @override
  String get splashGetStarted => 'Get Started';

  @override
  String get splashAlreadyHaveAccount => 'Already have an account?';

  @override
  String get splashSignIn => 'Sign in';

  @override
  String get authForgotPassword => 'Forgot password?';

  @override
  String get authNoAccount => 'No account?';

  @override
  String get authUseBiometricHint => 'Use Face ID or fingerprint to unlock';

  @override
  String get authTouchSensorHint => 'Touch sensor or look at camera';

  @override
  String get navLog => 'Log';

  @override
  String get navReport => 'Report';

  @override
  String get navRewards => 'Rewards';

  @override
  String get mockChooseLanguage => 'Choose Language';

  @override
  String get mockYourLocation => 'Your Location';

  @override
  String get mockUseCurrentLocation => 'Use Current Location';

  @override
  String get mockLocationTrapOnly =>
      'Location is used for TRAP air quality data only';

  @override
  String get mockLabelYourPlace => 'Label Your Place';

  @override
  String get mockSchool => 'School';

  @override
  String get mockWork => 'Work';

  @override
  String get mockOther => 'Other';

  @override
  String get mockEmergencyOnePerson => 'One person to call in an emergency';

  @override
  String get mockContactName => 'Contact Name';

  @override
  String get mockPhoneNumber => 'Phone Number';

  @override
  String get mockProviderPairing => 'Provider Pairing';

  @override
  String get mockPairingOptional =>
      'Optional — you can add this later in Settings';

  @override
  String get mockNext => 'Next';

  @override
  String get mockProfessionalProfile => 'Professional Profile';

  @override
  String get mockStep2Of4 => 'Step 2 of 4';

  @override
  String get mockTellPractice => 'Tell us about your medical practice';

  @override
  String get mockSpecialtyLabel => 'Specialty';

  @override
  String get mockClinicLabel => 'Practice / Clinic Name';

  @override
  String get mockNpiFormatOnly =>
      'Format check only. NPI verification occurs after submission.';

  @override
  String get mockCredentialsSecure =>
      'Your credentials are encrypted and stored securely. We never share provider data without consent.';

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
  String get actPast4Weeks => 'In the past 4 weeks';

  @override
  String get actQ1 =>
      'How much of the time did your asthma keep you from getting as much done at work, school or home?';

  @override
  String get actQ2 => 'How often have you had shortness of breath?';

  @override
  String get actQ3 =>
      'How often did your asthma symptoms wake you up at night or earlier than usual?';

  @override
  String get actQ4 =>
      'How often have you used your rescue inhaler or nebulizer medication?';

  @override
  String get actQ5 => 'How would you rate your asthma control?';

  @override
  String get actOpt1 => 'All of the time';

  @override
  String get actOpt2 => 'Most of the time';

  @override
  String get actOpt3 => 'Some of the time';

  @override
  String get actOpt4 => 'A little of the time';

  @override
  String get actOpt5 => 'None of the time';

  @override
  String get actQ5Opt1 => 'Not controlled at all';

  @override
  String get actQ5Opt2 => 'Poorly controlled';

  @override
  String get actQ5Opt3 => 'Somewhat controlled';

  @override
  String get actQ5Opt4 => 'Well controlled';

  @override
  String get actQ5Opt5 => 'Completely controlled';

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
  String get panicNoAutoDial =>
      'Buttons open the phone dialer. Calls are never placed automatically.';

  @override
  String panicCallNamed(String name) {
    return 'Call $name';
  }

  @override
  String get panicDialFailed =>
      'Could not open the phone dialer on this device.';

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
  String get s5ActNotice =>
      'Your answers are saved so you can share them with your clinician. This version of the questionnaire has not been checked against the official scoring, so the app does not show a score.';

  @override
  String get s5ActSaved => 'Your answers were saved.';

  @override
  String get s5ActSubtitle => '5 questions about the past 4 weeks';

  @override
  String get s5ActTitle => 'Asthma control questionnaire';

  @override
  String get s5AddDetails => 'Add details';

  @override
  String get s5AddRecord => 'Add record';

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
  String get s5Back => 'Back';

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
  String get s5Cancel => 'Cancel';

  @override
  String get s5Change => 'Change';

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
  String get s5Delete => 'Delete';

  @override
  String get s5DeleteConfirm => 'Delete this entry?';

  @override
  String get s5DeleteFailed => 'Could not delete. Please try again.';

  @override
  String get s5Edit => 'Edit';

  @override
  String get s5EnglishVersion => 'English (for clinician)';

  @override
  String get s5EntryRemoved => 'Entry removed.';

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
  String get s5FieldDate => 'Date';

  @override
  String get s5FieldMedication => 'Medication';

  @override
  String get s5FieldNote => 'Note (optional)';

  @override
  String get s5FieldPuffs => 'Number of puffs (optional)';

  @override
  String get s5FieldReason => 'Reason (optional)';

  @override
  String get s5FieldTime => 'Time';

  @override
  String get s5FilterAll => 'All';

  @override
  String get s5FilterInhaler => 'Inhaler';

  @override
  String get s5FilterMedCheck => 'Medication check-in';

  @override
  String get s5FilterSymptoms => 'Symptoms';

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
  String get s5FromUrgentHelp => 'Logged from Urgent help';

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
  String get s5InhalerEditTitle => 'Inhaler use details';

  @override
  String get s5InhalerEntry => 'Inhaler use';

  @override
  String get s5InhalerLogged => 'Inhaler use logged.';

  @override
  String get s5InhalerOneEntryHint =>
      'Each save is one inhaler-use entry. It is not counted as one puff or one day.';

  @override
  String s5InhalerUnknownCount(int n) {
    return 'Medication not identified: $n';
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
  String get s5Last30Days => 'Last 30 days';

  @override
  String get s5Last7Days => 'Last 7 days';

  @override
  String get s5LogInhaler => 'Log inhaler use';

  @override
  String get s5LogLegend =>
      'Each line is one saved entry. Days without entries are “not recorded”, which is different from zero.';

  @override
  String get s5LogSymptoms => 'Log symptoms';

  @override
  String get s5MedAdd => 'Add medication';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return 'Days used: $a · not used: $b · don\'t remember: $c · not recorded: $d';
  }

  @override
  String get s5MedCheckIntro =>
      'A self-reported check of whether you used your medicine. It is not based on pharmacy records.';

  @override
  String get s5MedCheckQuestion => 'Did you use your medicine as planned?';

  @override
  String get s5MedCheckTitle => 'Today\'s medication check-in';

  @override
  String get s5MedChooseHint =>
      'Choose a medication, or “I don\'t know the medication name”.';

  @override
  String get s5MedDailyCheck => 'Daily check-in';

  @override
  String get s5MedDailyCheckHint =>
      'Show “Today\'s medication check-in” on Home. Turn on only if your clinician asked you to use this medicine every day.';

  @override
  String get s5MedDefault => 'Default for quick logging';

  @override
  String get s5MedDefaultHint => 'Used when you tap “Log inhaler use” on Home.';

  @override
  String get s5MedEdit => 'Edit medication';

  @override
  String get s5MedNameLabel => 'Medication name (as on your label)';

  @override
  String get s5MedNotApplicable => 'Not scheduled for today';

  @override
  String s5MedNotApplicableDays(int n) {
    return 'Not scheduled: $n days';
  }

  @override
  String get s5MedNotRecorded => 'Medication not recorded';

  @override
  String get s5MedNotSure => 'I don\'t remember';

  @override
  String get s5MedNotUsed => 'I did not use it';

  @override
  String get s5MedOther => 'Another name';

  @override
  String get s5MedOtherHint => 'Type the medication name';

  @override
  String get s5MedReasonCost => 'Cost';

  @override
  String get s5MedReasonForgot => 'Forgot';

  @override
  String get s5MedReasonNoMedicine => 'Didn\'t have the medicine';

  @override
  String get s5MedReasonQuestion => 'Reason (optional)';

  @override
  String get s5MedUnknown => 'I don\'t know the medication name';

  @override
  String get s5MedUnknownShort => 'Medication not identified';

  @override
  String get s5MedUsed => 'I used it';

  @override
  String get s5MyLanguage => 'My language';

  @override
  String get s5MyLogTitle => 'My log';

  @override
  String get s5MyMedsEmpty => 'No medications saved yet.';

  @override
  String get s5MyMedsHint =>
      'Names you confirmed, to make logging faster. This is not a dosing recommendation.';

  @override
  String get s5MyMedsOpen => 'Manage my medications';

  @override
  String get s5MyMedsTitle => 'My medications';

  @override
  String get s5NavEnvironment => 'Environment';

  @override
  String get s5NavLog => 'Log';

  @override
  String get s5NavVisitPrep => 'Visit prep';

  @override
  String get s5NoAnswer => 'Prefer not to answer';

  @override
  String get s5NoRecordsYet => 'No records yet';

  @override
  String s5NoSymptomDays(int n) {
    return 'Days marked “no symptoms”: $n';
  }

  @override
  String get s5NotRecorded => 'Not recorded';

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
    return 'Period: $days days · Days with records: $n';
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
      other: '$n puffs',
      one: '1 puff',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return 'Question $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return 'Question $n of $total';
  }

  @override
  String get s5ReasonBeforeActivity => 'Before activity';

  @override
  String get s5ReasonOther => 'Other';

  @override
  String get s5ReasonSymptoms => 'Because of symptoms';

  @override
  String s5RecentInhaler(int n) {
    return 'Inhaler use entries: $n';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return 'Days with symptoms: $n';
  }

  @override
  String get s5RecentTitle => 'Last 7 days';

  @override
  String get s5RecordsLoadFailed =>
      'Couldn\'t load your records. Please try again.';

  @override
  String get s5RecordsManageHint =>
      'You can edit or delete entries in My log. Deleting always asks you to confirm.';

  @override
  String get s5Refresh => 'Refresh';

  @override
  String get s5Reload => 'Load again';

  @override
  String get s5Save => 'Save';

  @override
  String get s5Saved => 'Saved.';

  @override
  String get s5SavedPlacesHint => 'Saved places such as home, school, or work';

  @override
  String get s5SaveFailed => 'Could not save. Your entries are still here.';

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
  String get s5SymActivityLimited => 'Activities limited';

  @override
  String get s5SymCough => 'Cough';

  @override
  String get s5SymNightWaking => 'Woke up at night';

  @override
  String get s5SymNone => 'No symptoms';

  @override
  String get s5SymOther => 'Something else';

  @override
  String get s5SymOtherHint => 'Describe in your own words';

  @override
  String get s5SymShortBreath => 'Hard to breathe';

  @override
  String get s5SymWheeze => 'Wheezing';

  @override
  String get s5SymptomEditTitle => 'Edit symptoms';

  @override
  String get s5SymptomEntry => 'Symptoms';

  @override
  String get s5SymptomNoneHint =>
      'Days you don\'t record are shown as “not recorded”, not as “no symptoms”.';

  @override
  String get s5SymptomQuestion => 'What did you notice?';

  @override
  String get s5Today => 'Today';

  @override
  String get s5Undo => 'Undo';

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
  String get s5UrgentActionPlan =>
      'If your clinician gave you an asthma action plan, follow it.';

  @override
  String get s5UrgentCall911Locked => 'Urgent help: call 911';

  @override
  String get s5UrgentHelp => 'Urgent help';

  @override
  String get s5UrgentIntro =>
      'If breathing is very hard or not getting better, call 911.';

  @override
  String get s5UrgentLogHint =>
      'Optional: save a record that you used your inhaler.';

  @override
  String get s5UrgentNoContact =>
      'No emergency contact yet. Add one in Settings → Help.';

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
  String get s6AddTime => 'Add a time';

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
  String get s6DoseLater => 'Check later';

  @override
  String get s6DoseNotUsed => 'I could not use it';

  @override
  String get s6DoseUnconfirmed => 'No answer yet';

  @override
  String get s6DoseUsed => 'I used it';

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
  String get s6HomeWaterNo => 'No';

  @override
  String get s6HomeWaterQuestion => 'Was there a leak or flooding at home?';

  @override
  String get s6HomeWaterYes => 'Yes';

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
  String get s6OccurredLabel => 'When it happened';

  @override
  String get s6PdfEnvLimit =>
      'Regional reference only. It does not show personal exposure or the cause of symptoms. A single AQI does not name ozone and particles together, and it does not include pollen.';

  @override
  String get s6PdfEnvTitle => 'Environment reference (appendix)';

  @override
  String get s6PuffsEach => 'Puffs each time';

  @override
  String s6ReminderBodyNamed(String name) {
    return 'Time to confirm $name';
  }

  @override
  String get s6ReminderBodyPrivate => 'Time to confirm your medicine';

  @override
  String get s6ReminderChannel =>
      'Reminders at the dose times you saved. This is not the 30-minute air and weather alert.';

  @override
  String get s6ReminderTitle => 'Medicine check';

  @override
  String get s6RoleBoth => 'Daily and as needed';

  @override
  String get s6RoleController => 'Daily medicine';

  @override
  String get s6RoleRescue => 'As needed';

  @override
  String get s6ScheduleTimes => 'Times you take it';

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
  String get cnTagline => 'Insurance letters, clear next steps';

  @override
  String get cnDemoBadge => 'Sample';

  @override
  String get cnDemoBadgeLong => 'Sample with made-up data. Results are fixed.';

  @override
  String get cnAuthSignInTitle => 'Sign in';

  @override
  String get cnAuthCreateTitle => 'Create account';

  @override
  String get cnAuthResetTitle => 'Reset password';

  @override
  String get cnAuthSignIn => 'Sign in';

  @override
  String get cnAuthCreate => 'Create account';

  @override
  String get cnAuthSendReset => 'Send reset link';

  @override
  String cnAuthProfileError(String code) {
    return 'You are signed in, but your account could not be loaded ($code).';
  }

  @override
  String get cnRetry => 'Try again';

  @override
  String get cnSignOut => 'Sign out';

  @override
  String get cnAuthPreparingAccount => 'Setting up your account…';

  @override
  String get cnAuthNameLabel => 'Name (optional)';

  @override
  String get cnAuthNameHelper =>
      'Shown on your packets. You can change it later.';

  @override
  String get cnAuthEmailLabel => 'Email';

  @override
  String get cnAuthPasswordLabel => 'Password';

  @override
  String get cnAuthPasswordHelper => 'At least 8 characters';

  @override
  String get cnAuthShowPassword => 'Show password';

  @override
  String get cnAuthHidePassword => 'Hide password';

  @override
  String get cnAuthPasswordRequired => 'Enter your password';

  @override
  String cnAuthCheckEmail(String email) {
    return 'We sent a confirmation link to $email. Open it on this phone, then sign in.';
  }

  @override
  String cnAuthResetSent(String email) {
    return 'If an account exists for $email, a reset link is on its way. Open it on this phone.';
  }

  @override
  String get cnAuthResent => 'Sent again.';

  @override
  String get cnAuthResend => 'Resend email';

  @override
  String get cnAuthSignInInstead => 'I confirmed. Sign in';

  @override
  String get cnAuthForgot => 'Forgot password?';

  @override
  String get cnAuthNoAccount => 'New here? Create an account';

  @override
  String get cnAuthHaveAccount => 'Have an account? Sign in';

  @override
  String get cnAuthResetHint =>
      'Enter your email and we will send a link to set a new password.';

  @override
  String get cnAuthBackToSignIn => 'Back to sign in';

  @override
  String get cnAuthPrivacyLine =>
      'Your letters and records are private to your account.';

  @override
  String get cnAuthPasswordUpdated => 'Password updated.';

  @override
  String get cnAuthNewPasswordTitle => 'Set a new password';

  @override
  String get cnAuthNewPasswordLabel => 'New password';

  @override
  String get cnAuthSavePassword => 'Save password';

  @override
  String get cnLater => 'Later';

  @override
  String get cnAuthErrInvalidCredentials => 'Email or password is not correct.';

  @override
  String get cnAuthErrNotConfirmed =>
      'Please confirm your email first. Check your inbox or resend the link.';

  @override
  String get cnAuthErrExists =>
      'An account with this email already exists. Sign in instead.';

  @override
  String get cnAuthErrWeakPassword =>
      'Choose a stronger password (at least 8 characters).';

  @override
  String get cnAuthErrSamePassword =>
      'Use a password different from your old one.';

  @override
  String get cnAuthErrRateLimited =>
      'Too many tries. Wait a minute and try again.';

  @override
  String get cnAuthErrInvalidEmail => 'Check the email address.';

  @override
  String get cnAuthErrEmailNotAuthorized =>
      'We could not send email to this address right now. Try again later.';

  @override
  String get cnAuthErrDisabled => 'This sign-in method is turned off.';

  @override
  String get cnAuthErrSessionExpired =>
      'Your session ended. Please sign in again.';

  @override
  String cnAuthErrUnknown(String code) {
    return 'Something went wrong ($code). Try again.';
  }

  @override
  String get cnErrNetwork =>
      'No connection. Check your internet and try again.';

  @override
  String get cnErrServiceDown =>
      'The service is not responding. Try again in a few minutes.';

  @override
  String get cnTabHome => 'Home';

  @override
  String get cnTabCases => 'Cases';

  @override
  String get cnTabRecords => 'Records';

  @override
  String get cnTabAccount => 'Account';

  @override
  String get cnHomeHeadline => 'Make sense of your insurance letter.';

  @override
  String get cnScanLetter => 'Scan a letter';

  @override
  String get cnUploadFile => 'Upload PDF / photo';

  @override
  String get cnTryDemo => 'Try demo';

  @override
  String get cnHomeSignInLine => 'Saving your cases needs an account.';

  @override
  String get cnServiceNotConfigured =>
      'This build is not connected to the server. Only the demo works.';

  @override
  String get cnContinueCase => 'Continue your case';

  @override
  String get cnHowItWorks => 'How it works';

  @override
  String get cnStep1Title => 'Read the letter';

  @override
  String get cnStep1Body =>
      'Take a photo. We find the reason, the next step and the date.';

  @override
  String get cnStep2Title => 'Gather records';

  @override
  String get cnStep2Body =>
      'Match what the letter asks for to your own records.';

  @override
  String get cnStep3Title => 'Create a packet';

  @override
  String get cnStep3Body =>
      'Get a one-page doctor summary and a draft review request.';

  @override
  String get cnRecentCases => 'Other cases';

  @override
  String get cnNoCasesYet => 'No cases yet';

  @override
  String get cnNoOtherCases => 'No other cases.';

  @override
  String get cnSeeAllCases => 'See all cases';

  @override
  String get cnNoCasesBody => 'Scan an insurance letter to start.';

  @override
  String get cnCasesSignInTitle => 'Sign in to see your cases';

  @override
  String get cnCasesSignInBody => 'Or open the demo to see how it works.';

  @override
  String get cnCaseDeleted => 'Case deleted.';

  @override
  String get cnCaseUntitled => 'Insurance letter';

  @override
  String get cnStatusReading => 'Reading letter';

  @override
  String get cnStatusNeedsReview => 'Needs review';

  @override
  String get cnStatusGatherRecords => 'Gather records';

  @override
  String get cnStatusPacketReady => 'Packet ready';

  @override
  String get cnStatusNeedsAttention => 'Needs attention';

  @override
  String get cnStatusNotStarted => 'Not started';

  @override
  String get cnNextWaitReading => 'We are reading the letter.';

  @override
  String get cnNextTryAgain => 'Reading stopped. Open the case to try again.';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count facts to confirm',
      one: '1 fact to confirm',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return '$done of $total requested items handled';
  }

  @override
  String get cnNextSharePacket => 'Packet ready to share';

  @override
  String get cnNextCreatePacket => 'Next: create the packet';

  @override
  String cnDateToCheckShort(String date) {
    return 'Date to check: $date';
  }

  @override
  String cnDatePassedShort(String date) {
    return 'Date passed: $date';
  }

  @override
  String get cnMoreActions => 'More actions';

  @override
  String get cnDeleteCase => 'Delete case';

  @override
  String get cnDeleteCaseTitle => 'Delete this case?';

  @override
  String get cnDeleteCaseBody =>
      'This removes the letter pages, the facts read from them, linked record summaries and packets. Your medication and symptom records stay.';

  @override
  String get cnCancel => 'Cancel';

  @override
  String get cnDelete => 'Delete';

  @override
  String get cnDeleteFailed =>
      'Could not delete. Check your connection and try again.';

  @override
  String get cnKindInitialDenial => 'Drug coverage denial';

  @override
  String get cnKindInfoRequest => 'Request for more information';

  @override
  String get cnKindReauth => 'Renewal (reauthorization) notice';

  @override
  String get cnKindFinalDenial => 'Final appeal decision';

  @override
  String get cnKindEob => 'Bill or explanation of benefits';

  @override
  String get cnKindOther => 'Other letter';

  @override
  String get cnKindUncertain => 'Letter type not clear';

  @override
  String get cnFieldPatientName => 'Patient name';

  @override
  String get cnFieldPlanName => 'Plan';

  @override
  String get cnFieldMemberId => 'Member ID';

  @override
  String get cnFieldCaseReference => 'Case or reference number';

  @override
  String get cnFieldMedication => 'Medication (as written)';

  @override
  String get cnFieldDose => 'Dose (as written)';

  @override
  String get cnFieldNoticeDate => 'Notice date';

  @override
  String get cnFieldContact => 'Contact';

  @override
  String get cnFieldSubmissionRoute => 'Where to send';

  @override
  String get cnFactEdited => 'Edited by you';

  @override
  String get cnFactChecked => 'Checked';

  @override
  String get cnFactNotInLetter => 'Not in letter';

  @override
  String get cnFactNeedsCheck => 'Needs check';

  @override
  String get cnFactFromLetter => 'From letter';

  @override
  String get cnWhoYou => 'You';

  @override
  String get cnWhoCareTeam => 'Care team';

  @override
  String get cnWhoPlan => 'Plan';

  @override
  String get cnWhoUnknown => 'Not sure';

  @override
  String get cnReqLinked => 'Linked';

  @override
  String get cnReqAskedCareTeam => 'Asked care team';

  @override
  String get cnReqNotAvailable => 'Not available';

  @override
  String get cnReqNotNeeded => 'Not needed';

  @override
  String get cnReqNeeded => 'Needed';

  @override
  String get cnReqReset => 'Mark as needed';

  @override
  String get cnRecMedication => 'Medication history';

  @override
  String get cnRecSymptoms => 'Symptom log';

  @override
  String get cnRecLocalContext => 'Environmental factors';

  @override
  String get cnRecPrn => 'As-needed inhaler';

  @override
  String get cnDemoTitle => 'Demo';

  @override
  String get cnDemoReset => 'Reset demo';

  @override
  String get cnDemoResetDone => 'Demo reset.';

  @override
  String get cnDemoIntro =>
      'Three made-up letters with fixed results, so you can see each step. Nothing is uploaded.';

  @override
  String get cnUpEmpty => 'That file is empty.';

  @override
  String cnUpTooLarge(int mb) {
    return 'Each file must be $mb MB or smaller.';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return 'All pages together must be $mb MB or smaller.';
  }

  @override
  String cnUpTooManyPages(int max) {
    return 'Up to $max pages per letter.';
  }

  @override
  String get cnUpUnsupported =>
      'Use JPG, PNG or PDF. For HEIC photos, take a new photo here.';

  @override
  String get cnUpBadFile =>
      'This file cannot be read. Try another photo or PDF.';

  @override
  String get cnUpEncrypted =>
      'This PDF is password-protected. Save an unlocked copy or take photos.';

  @override
  String get cnCameraUnavailable =>
      'The camera is not available. You can upload a photo or PDF instead.';

  @override
  String get cnPhotosUnavailable =>
      'Photos cannot be opened. Allow photo access in settings, or upload a PDF.';

  @override
  String get cnFilesUnavailable =>
      'Files cannot be opened right now. Try again.';

  @override
  String get cnUploadFailed =>
      'Upload did not finish. Your pages are still here. Try again.';

  @override
  String get cnCaptureTitle => 'Add letter pages';

  @override
  String get cnReplacePagesTitle => 'Replace letter pages';

  @override
  String get cnOpening => 'Opening…';

  @override
  String get cnCaptureEmptyTitle => 'Add the pages of your letter';

  @override
  String get cnCaptureTips =>
      'Lay the page flat in good light and fit all four corners in the frame. Add every page, in order.';

  @override
  String get cnTakePhoto => 'Take photo';

  @override
  String get cnAddPage => 'Add page';

  @override
  String get cnAddPhoto => 'Photo';

  @override
  String get cnPickGallery => 'Choose from photos';

  @override
  String get cnLabelForm => 'Form (as written)';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages pages',
      one: '1 page',
    );
    return '$_temp0 · $size MB';
  }

  @override
  String get cnUploadConsent =>
      'Uploading sends these pages to the CoverNote server, where an AI service reads them for you. You can delete the case at any time.';

  @override
  String get cnStageUploading => 'Uploading';

  @override
  String get cnUploadAndRead => 'Upload and read';

  @override
  String cnPageN(int n) {
    return 'Page $n';
  }

  @override
  String cnPdfPages(int n, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
    );
    return 'File $n · PDF, $_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return 'Preview page $n';
  }

  @override
  String get cnRotate => 'Rotate';

  @override
  String get cnRetake => 'Retake';

  @override
  String get cnRemovePage => 'Remove';

  @override
  String get cnReorder => 'Drag to reorder';

  @override
  String get cnServiceUnavailableBody =>
      'The letter reader is not set up right now. Your pages are saved; try again later.';

  @override
  String get cnNeedNewPagesBody =>
      'Take clearer photos or use fewer pages, then upload again.';

  @override
  String get cnPagesKept => 'Your pages are saved. Nothing was changed.';

  @override
  String get cnReplacePages => 'Replace pages';

  @override
  String get cnTryAgain => 'Try again';

  @override
  String get cnStageReading => 'Reading';

  @override
  String get cnStageChecking => 'Checking';

  @override
  String get cnStageReady => 'Ready';

  @override
  String get cnReadingTitle => 'Reading your letter';

  @override
  String get cnReadingBody =>
      'When it is done, you check what we found against the letter.';

  @override
  String get cnReadingLeaveOk =>
      'You can leave this screen. Reading continues and your case is saved.';

  @override
  String get cnStartReading => 'Start reading';

  @override
  String get cnStepLetter => 'Letter';

  @override
  String get cnStepReview => 'Review';

  @override
  String get cnStepEvidence => 'Records';

  @override
  String get cnStepPacket => 'Packet';

  @override
  String cnStepOf(int n, int total, String name) {
    return 'Step $n of $total: $name';
  }

  @override
  String get cnSaving => 'Saving…';

  @override
  String get cnSaved => 'Saved';

  @override
  String get cnNotSavedRetry => 'Not saved · Retry';

  @override
  String get cnViewOriginal => 'View original pages';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages read',
      one: '1 page read',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return 'Hard to read: page $list. Check these facts carefully or retake the page.';
  }

  @override
  String get cnRetakePages => 'Retake pages';

  @override
  String get cnHardToRead => 'Hard to read';

  @override
  String get cnContinueToReview => 'Continue to review';

  @override
  String get cnOriginalPages => 'Original pages';

  @override
  String get cnNoOriginal => 'No original pages are stored.';

  @override
  String get cnCheckDetails => 'Check the details';

  @override
  String get cnCheckDetailsHint =>
      'Compare each value with your letter. Tap a quote to see where it came from.';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Check $count more items to continue',
      one: 'Check 1 more item to continue',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => 'Continue to evidence';

  @override
  String cnSeePage(int n) {
    return 'See page $n';
  }

  @override
  String get cnWhatLetterIs => 'What this letter is';

  @override
  String get cnLooksRight => 'Looks right';

  @override
  String get cnChange => 'Change';

  @override
  String get cnCardWhyDenied => 'Why it was denied';

  @override
  String get cnCardWhatTheyNeed => 'What they asked for';

  @override
  String get cnCardWhatItSays => 'What the letter says';

  @override
  String get cnNoReasonFound => 'No reason was found in the letter.';

  @override
  String get cnCardNextStep => 'Next step';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Ask your care team to request a review. The letter lists $count items to send.',
      one:
          'Ask your care team to request a review. The letter lists 1 item to send.',
      zero:
          'Ask your care team to request a review. The letter does not list specific items.',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Send the $count items the plan asked for by the date below.',
      one: 'Send the 1 item the plan asked for by the date below.',
      zero: 'Send the information the plan asked for by the date below.',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth =>
      'Note when the current approval ends and ask your care team to start the renewal.';

  @override
  String get cnNextFinal =>
      'This is a final decision. CoverNote does not draft a first review request for it. Ask the plan or your care team about the options the letter lists.';

  @override
  String get cnNextEob =>
      'This looks like a bill or benefits statement, not a denial. Check it with the plan\'s member services.';

  @override
  String get cnNextUncertain =>
      'First confirm what kind of letter this is, above.';

  @override
  String cnWhereToSend(String route) {
    return 'Where to send: $route';
  }

  @override
  String cnWhoToCall(String contact) {
    return 'Contact: $contact';
  }

  @override
  String get cnCardDate => 'Date to check';

  @override
  String cnDateCalculated(String anchor, int days) {
    return 'Calculated: $anchor + $days calendar days';
  }

  @override
  String get cnReceivedDateWord => 'date you received it';

  @override
  String get cnNoticeDateWord => 'notice date';

  @override
  String get cnDateEnteredByYou => 'Entered by you';

  @override
  String get cnDateFromLetter => 'Stated in the letter';

  @override
  String cnReceivedOn(String date) {
    return 'You received it on $date';
  }

  @override
  String get cnDatePassed =>
      'This date has passed. Call the plan to ask what you can still do.';

  @override
  String cnNeedReceivedDate(int days) {
    return 'The letter gives $days calendar days from the day you received it. When did it arrive?';
  }

  @override
  String get cnEnterReceivedDate => 'Enter date received';

  @override
  String get cnDateConflict =>
      'The letter gives different dates. Ask the plan which one applies, then pick it.';

  @override
  String cnUseThisDate(String date) {
    return 'Use $date';
  }

  @override
  String get cnDateUnclear =>
      'The wording is unclear or counts business days, so CoverNote does not calculate it. Ask the plan for the exact date.';

  @override
  String get cnNoDeadline => 'No review deadline was found in the letter.';

  @override
  String cnReplyBy(String date) {
    return 'Reply to the information request by $date (from the letter)';
  }

  @override
  String get cnEnterDatePlanGave => 'Enter a date';

  @override
  String get cnUseLetterDate => 'Use the letter\'s date';

  @override
  String get cnLeaveUnknown => 'Leave as unknown for now';

  @override
  String get cnDateUnknownChecked => 'Unknown, noted';

  @override
  String get cnTypeAsWritten => 'Type it exactly as the letter shows.';

  @override
  String get cnCheckThisValue =>
      'This value looks unusual. Compare it with the letter.';

  @override
  String get cnDone => 'Done';

  @override
  String get cnEdit => 'Edit';

  @override
  String get cnAdd => 'Add';

  @override
  String get cnNoRecordsToLink =>
      'No records from the last 30 days to link. You can still mark who has this item.';

  @override
  String cnLinkTitle(String label) {
    return 'Link a record to: $label';
  }

  @override
  String get cnLinkNote =>
      'Your own records support the request. They do not replace clinic notes or test results.';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '$taken taken / $notTaken not taken / $unknown unknown of $scheduled scheduled doses';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return 'As-needed: $uses uses, $puffs puffs';
  }

  @override
  String get cnNoEntries => 'No entries';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return 'Symptoms on $days days, night waking on $night days ($entries of $total days logged)';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return 'PM2.5 data for $days of $total days; $high days above AQI 100';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count self-reports',
      one: '1 self-report',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => 'Synthetic data';

  @override
  String get cnLetterAsksFor => 'What the letter asks for';

  @override
  String get cnNoItemsListed =>
      'The letter does not list specific items. You can add your own.';

  @override
  String get cnAddItemLabel => 'Add an item to track';

  @override
  String cnYourRecords(String from, String to) {
    return 'Your records ($from – $to)';
  }

  @override
  String get cnLocalContextNote =>
      'Optional. These are outdoor factors, not a measurement inside your home and not a cause of symptoms.';

  @override
  String get cnContinueToPacket => 'Continue to packet';

  @override
  String get cnAddedByYou => 'Added by you';

  @override
  String get cnFromLetter => 'From letter';

  @override
  String cnWhoHasIt(String who) {
    return 'Who has it: $who';
  }

  @override
  String cnLinkedTo(String record) {
    return 'Linked: $record';
  }

  @override
  String get cnSeeInLetter => 'See in letter';

  @override
  String get cnLinkRecords => 'Link my records';

  @override
  String get cnOtherStatus => 'Other status';

  @override
  String get cnInPacket => 'In packet';

  @override
  String get cnRemoveFromPacket => 'Remove from packet';

  @override
  String get cnAddToPacket => 'Add to packet';

  @override
  String get cnErrNotSavedYet =>
      'Your latest changes are not saved yet. Check your connection and try again.';

  @override
  String get cnPacketChangedMeanwhile =>
      'Facts or records changed while the packet was being made. Generate it again.';

  @override
  String get cnPacketFailed => 'The packet could not be made. Try again.';

  @override
  String get cnBeforeSharingTitle => 'Before you share';

  @override
  String get cnBeforeSharingBody =>
      'This file has your name and health details. Share it only with your care team or your plan. Sharing does not submit anything for you.';

  @override
  String get cnShare => 'Share';

  @override
  String get cnMethodFax => 'Fax';

  @override
  String get cnMethodMail => 'Mail';

  @override
  String get cnMethodPortal => 'Online portal';

  @override
  String get cnMethodInPerson => 'In person';

  @override
  String get cnMethodCareTeam => 'Care team sent it';

  @override
  String get cnMethodOther => 'Other';

  @override
  String get cnPacketNoDraftFinal =>
      'For a final decision, the packet has the doctor summary only. No first-level review draft is made.';

  @override
  String get cnPacketNoDraftEob =>
      'For a bill or benefits statement, the packet has the doctor summary only.';

  @override
  String get cnPacketNoDraftReauth =>
      'For a renewal notice, the packet has the doctor summary only, to help your care team renew.';

  @override
  String get cnPacketNoDraftOther =>
      'Unless the letter is a denial or an information request, the packet has the doctor summary only.';

  @override
  String get cnPacketContains => 'This packet will include';

  @override
  String get cnPartSummary => 'Doctor summary (1 page)';

  @override
  String get cnPartDraft =>
      'Review request draft (for your care team to complete)';

  @override
  String get cnPartLetterText => 'Appendix: the letter text';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count record summaries added',
      one: '1 record summary added',
      zero: 'No record summaries added',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => 'Add the letter text as an appendix';

  @override
  String get cnPacketStale =>
      'Facts or records changed since the last packet. Generate it again to update.';

  @override
  String get cnGenerating => 'Generating…';

  @override
  String get cnGeneratePacket => 'Generate review packet';

  @override
  String get cnSaveOrPrint => 'Save or print';

  @override
  String get cnISentIt => 'I sent it';

  @override
  String cnSharedOn(String date) {
    return 'Shared on $date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return 'You reported sending it on $date ($method)';
  }

  @override
  String get cnTabDoctorSummary => 'Doctor summary';

  @override
  String get cnTabReviewDraft => 'Review request draft';

  @override
  String get cnSentExplain =>
      'Record when and how it was sent. CoverNote does not send it or track a decision.';

  @override
  String get cnSave => 'Save';

  @override
  String get cnCtxPm25 => 'PM2.5 (AQI)';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => 'Outdoor humidity';

  @override
  String cnObservedOn(String date) {
    return 'Observed $date';
  }

  @override
  String get cnCtxIntro =>
      'Air readings from a named source and things you noticed, kept separate. Add them to a case only if they help explain your records.';

  @override
  String get cnCtxReadings => 'Air readings';

  @override
  String get cnCtxReadingsNote =>
      'Regional readings for the day they were observed. They do not measure traffic exhaust at your home.';

  @override
  String get cnCtxAddReading => 'Add a reading';

  @override
  String get cnCtxReports => 'What you noticed';

  @override
  String get cnCtxReportsNote => 'Your own reports. They are not measurements.';

  @override
  String get cnCtxAddReport => 'Add what you noticed';

  @override
  String get cnReportExhaust => 'Strong exhaust nearby';

  @override
  String get cnReportWater => 'Water intrusion at home';

  @override
  String get cnReportDamp => 'Damp or musty indoor area';

  @override
  String cnOnDate(String date) {
    return 'Date: $date';
  }

  @override
  String get cnNoteOptional => 'Note (optional)';

  @override
  String get cnCtxWhat => 'Reading';

  @override
  String get cnCtxHumidityNote =>
      'Outdoor humidity is weather data. It does not show dampness or mold inside your home.';

  @override
  String get cnCtxValue => 'Value';

  @override
  String get cnCtxValueInvalid => 'Enter a valid number.';

  @override
  String get cnCtxSource => 'Source';

  @override
  String get cnCtxSourceHelp =>
      'Where the number came from, for example AirNow or a local monitor';

  @override
  String get cnCtxSourceRequired => 'Add the source.';

  @override
  String get cnCtxPlace => 'Place (optional)';

  @override
  String get cnRecordsSignInBody =>
      'Sign in to keep medication, symptom, and environmental-factor records.';

  @override
  String get cnRecordsYourRecords => 'Your records';

  @override
  String get cnRecMedicationSub => 'Medicines and doses you take';

  @override
  String get cnRecDailyLog => 'Daily log';

  @override
  String get cnRecDailyLogSub => 'Symptoms and inhaler use';

  @override
  String get cnRecLocalContextSub => 'Air readings and what you noticed';

  @override
  String get cnHelp => 'Help';

  @override
  String get cnUrgentHelp => 'Urgent help';

  @override
  String get cnUrgentHelpSub =>
      'Steps for a breathing emergency and calling 911';

  @override
  String cnLast30Days(String from, String to) {
    return 'Last 30 days ($from – $to)';
  }

  @override
  String get cnNoSchedule => 'No regular schedule set';

  @override
  String get cnRecordsUnknownNote =>
      'Days without an entry stay unknown. They are not counted as missed.';

  @override
  String get cnDeleteAccountTitle => 'Delete your account?';

  @override
  String get cnDeleteAccountBody =>
      'This permanently deletes your account, cases, uploaded letters, packets and records. It cannot be undone.';

  @override
  String get cnTypeDelete => 'Type DELETE to confirm';

  @override
  String get cnDeleteAccount => 'Delete account';

  @override
  String get cnAccountDeleted => 'Your account was deleted.';

  @override
  String get cnDeleteAccountFailed =>
      'The account could not be deleted. Try again later.';

  @override
  String get cnAccountSignedOut => 'You are not signed in.';

  @override
  String get cnLanguage => 'Language';

  @override
  String get cnServiceStatus => 'Letter reading service';

  @override
  String get cnServiceReady => 'Available';

  @override
  String get cnServiceUnavailableShort => 'Not available right now';

  @override
  String get cnChecking => 'Checking…';

  @override
  String get cnServiceUnknown => 'Not checked';

  @override
  String get cnCheck => 'Check';

  @override
  String get cnAbout => 'About';

  @override
  String get cnAboutBody =>
      'CoverNote helps you read insurance letters about medicines and prepare papers for your care team. It does not submit anything to your plan, does not decide coverage, and is not medical advice.';

  @override
  String get cnDangerZone => 'Delete account';

  @override
  String get cnErrServiceUnavailable =>
      'The letter reader is not available right now.';

  @override
  String get cnErrBusy => 'The service is busy. Wait a minute and try again.';

  @override
  String get cnErrSlow => 'Reading took too long. Try again.';

  @override
  String get cnErrUnreadable =>
      'The pages could not be read. Retake them in better light.';

  @override
  String get cnErrTooManyPages => 'Too many pages. Upload up to 10.';

  @override
  String get cnErrTooLarge =>
      'The files are too large. Use fewer or smaller pages.';

  @override
  String get cnErrStale =>
      'This case changed on another device. Showing the latest version.';

  @override
  String get cnErrCaseGone => 'This case no longer exists.';

  @override
  String get cnErrAttempts =>
      'Reading failed several times. Replace the pages or try again later.';

  @override
  String get cnErrDemoUpload =>
      'The demo cannot read files. Sign in to scan your own letter.';

  @override
  String cnErrGeneric(String code) {
    return 'Something went wrong ($code). Try again.';
  }

  @override
  String get cnLanguageChoose => 'Choose your language';

  @override
  String get cnLanguageNote =>
      'Some text was translated by software and may have mistakes. Medicine names and doses stay as printed. The rest of the letter is translated for you.';

  @override
  String get cnLanguageButtonTooltip => 'Change language';

  @override
  String get cnPacketEnglishNote =>
      'The packet is written in English so your care team can read it.';

  @override
  String get cnReasonMissingInformation =>
      'The plan says it did not get all the information it needed.';

  @override
  String get cnReasonStepTherapy =>
      'The plan wants you to try other medicines first.';

  @override
  String get cnReasonMedicalNecessity =>
      'The plan says it could not confirm that this medicine is medically needed.';

  @override
  String get cnReasonFormulary =>
      'The plan says this medicine is not on its list of covered medicines.';

  @override
  String get cnReasonQuantityLimit =>
      'The plan says the amount asked for is more than it covers.';

  @override
  String get cnReasonEligibility =>
      'The plan says this is not covered under its coverage rules.';

  @override
  String get cnReasonOther =>
      'The letter gives another reason. Open the quote from the letter to read it.';

  @override
  String get cnReqHintMedHistory => 'Your past and current medicines';

  @override
  String get cnReqHintVisitNotes => 'Notes from your doctor visits';

  @override
  String get cnReqHintTestResults => 'Test or lab results';

  @override
  String get cnReqHintDoctorStatement => 'A statement from your doctor';

  @override
  String get cnTabSettings => 'Settings';

  @override
  String get cnCasesList => 'Case list';

  @override
  String get cnGoHome => 'Home';

  @override
  String get cnAnalyzingTitle => 'Insurance letter · analyzing';

  @override
  String cnCaseNumber(String n) {
    return 'Case #$n';
  }

  @override
  String cnAddedAt(String when) {
    return 'Added $when';
  }

  @override
  String get cnAliasHint => 'Nickname (optional)';

  @override
  String get cnShareDocuments => 'Share documents';

  @override
  String get cnRecordDelivery => 'Record delivery';

  @override
  String get cnShareAsk => 'Did you send these documents?';

  @override
  String get cnDeliveryRecipient => 'Sent to';

  @override
  String get cnRecipientClinic => 'Clinic or clinician';

  @override
  String get cnRecipientInsurer => 'Insurance plan';

  @override
  String get cnRecipientSelf => 'Kept for myself';

  @override
  String get cnRecipientOther => 'Other';

  @override
  String get cnDeliveryMethod => 'How';

  @override
  String get cnMethodEmail => 'Email';

  @override
  String get cnMethodMessage => 'Text or messenger';

  @override
  String get cnMethodUnknown => 'I do not remember';

  @override
  String get cnDeliveryUserReport =>
      'This is what you reported. The app cannot confirm that the other side received it.';

  @override
  String get cnShareCancelled =>
      'Share was cancelled. Nothing was marked as sent.';

  @override
  String get cnRecordsLoading => 'Loading records…';

  @override
  String get cnRecordsEmpty => 'No records in this period';

  @override
  String get cnRecordsError => 'Could not load records';

  @override
  String get cnRecordsPermission => 'You do not have access to these records';

  @override
  String get cnRecordsPending => 'Saved on this device · waiting to sync';

  @override
  String get cnRecordsFiltered => 'Some records are hidden by your filters';

  @override
  String cnRecordsOutside(int n) {
    return '$n records outside this period';
  }

  @override
  String get cnWidenRange => 'Show a longer period';

  @override
  String cnLinkedSummary(int days, int med, int sym) {
    return '$days day(s) · $med medication uses · $sym symptom entries';
  }

  @override
  String get cnOneDayPacket => 'This packet covers one day.';

  @override
  String get cnMyMedications => 'My medications';

  @override
  String get cnScanLabel => 'Scan medication label';

  @override
  String get cnMedManageHint =>
      'Register medicines you use. Change them when a prescription changes. Daily use is logged on Records.';

  @override
  String get cnLabelNeedLabel =>
      'Photograph the pharmacy label or box text. The app does not identify a pill by its shape.';

  @override
  String get cnLabelUnclear =>
      'This value was not clear. Check it before saving.';

  @override
  String get cnConsentLabel => 'Allow AI to read a medication label';

  @override
  String get cnManualMed => 'Enter manually';

  @override
  String get cnAirWeather => 'Environmental factors near you';

  @override
  String get cnAirAutoNote =>
      'Air quality, traffic-related air, pollen, flood alerts, and outdoor humidity come from your current location. This phone does not measure the air. Outdoor humidity is not indoor mold.';

  @override
  String get cnHomeRecords => 'Related medication records';

  @override
  String get cnEnvTrap => 'Traffic-related air';

  @override
  String get cnItemMemo => 'Note';

  @override
  String get cnSaveNote => 'Save note';

  @override
  String get cnLocationNeed =>
      'Allow location to show environmental factors near you.';

  @override
  String get cnLocationOff =>
      'Location services are off. Turn them on and try again.';

  @override
  String get cnLocationBlocked => 'Location is blocked. Allow it in settings.';

  @override
  String get cnOpenSettings => 'Open settings';

  @override
  String get cnAirNone => 'No air or weather data';

  @override
  String get cnAirRetry => 'Try air and weather again';

  @override
  String get cnSetRegion => 'Set your area (ZIP or city)';

  @override
  String get cnConfiguredArea => 'Area you set';

  @override
  String get cnRecordPlace => 'Place of this record';

  @override
  String get cnClosestObservation => 'Closest observation to the record time';

  @override
  String get cnEnvUnavailable => 'No matching observation for that time';

  @override
  String cnLogMedication(String name) {
    return 'Log $name';
  }

  @override
  String get cnAsNeededUse => 'As-needed use';

  @override
  String get cnAsNeededInhaler => 'As-needed inhaler use';

  @override
  String get cnScheduledUse => 'Scheduled use';

  @override
  String get cnExtraUse => 'Extra use';

  @override
  String get cnUndoUse => 'Undo';

  @override
  String get cnLoggedLocal => 'Saved on this device';

  @override
  String get cnLoggedPending => 'Waiting to sync';

  @override
  String get cnLoggedSynced => 'Synced';

  @override
  String cnDaysLogged(int n) {
    return 'Logged on $n days this week';
  }

  @override
  String get cnManageMedsLink => 'Manage my medications';

  @override
  String get cnViewAirWeather => 'View environmental factors near you';

  @override
  String get cnConsentAi => 'Allow AI document analysis';

  @override
  String get cnConsentAiBody =>
      'The letter image is sent to a reading service so CoverNote can show what it says. You can turn this off later in Settings.';

  @override
  String get cnConsentAndAnalyze => 'Agree and analyze';

  @override
  String get cnConsentLater => 'Not now';

  @override
  String get cnConsentViewLocal => 'View the original here';

  @override
  String get cnConsentDetails => 'More about data use';

  @override
  String get cnConsentLabelPurpose => 'Read a medication label';

  @override
  String get cnConsentLetterPurpose => 'Read an insurance letter';

  @override
  String get cnConsentTranslatePurpose => 'Translate a letter';

  @override
  String get cnToday => 'Today';

  @override
  String get cnLast7 => 'Last 7 days';

  @override
  String get cnLast30 => 'Last 30 days';

  @override
  String get cnCustomRange => 'Choose dates';

  @override
  String cnRangeSummary(String from, String to, int days, int count) {
    return '$from–$to · $days day(s) · $count records';
  }

  @override
  String get cnNoRecordThatDay => 'No record this day';

  @override
  String get cnNotLogged => 'Not logged';

  @override
  String get cnNotTaken => 'Marked as not taken';

  @override
  String get cnOriginalFile => 'Original file';

  @override
  String get cnFullTranslation => 'Full translation';

  @override
  String get cnRecognizedText => 'Recognized text';

  @override
  String get cnSameLanguage => 'Same language as the original';

  @override
  String get cnTranslationPartial => 'Some pages are not translated yet';

  @override
  String get cnTranslationFailed => 'This page could not be translated';

  @override
  String get cnOriginalMissing =>
      'The original file could not be found. You can upload it again.';

  @override
  String get cnTranslateRetry => 'Continue translation';

  @override
  String get cnKeyDetails => 'Key details';

  @override
  String get cnWhatAbout => 'What is this about?';

  @override
  String get cnWhatToDo => 'What to do now';

  @override
  String get cnByWhen => 'By when?';

  @override
  String get cnPreparePacket => 'Prepare documents';

  @override
  String get cnCorrectReading => 'Correct a reading error';

  @override
  String get cnCorrectReadingNote =>
      'The original letter does not change. Only the automatic reading is corrected.';

  @override
  String get cnReviewImportant =>
      'Check these important values before creating documents';

  @override
  String get cnPacketReadyTitle => 'Your documents are ready';

  @override
  String get cnNextSendClinic =>
      'Send the documents to your clinician and ask them to review';

  @override
  String get cnNextWaitReply => 'When you get a reply, record the result';

  @override
  String get cnExistingSentNewReady =>
      'Earlier documents were sent · you can make a new set';

  @override
  String get cnWhyRecords =>
      'Medication and symptom records can help a clinician see how treatment is going. You can still make documents from the letter if you have no records yet.';

  @override
  String get cnLetterAskedRecords =>
      'The letter asked for recent treatment records';

  @override
  String get cnOptionalReference => 'Optional reference';

  @override
  String get cnAsthmaContext =>
      'Asthma treatment records — scheduled use, as-needed use, and breathing symptoms.';

  @override
  String get cnGeneralContext =>
      'Treatment records — medication use and symptoms or notes.';

  @override
  String get cnTreatmentQuestion => 'What treatment is this letter about?';

  @override
  String get cnTreatmentAsthma => 'Asthma';

  @override
  String get cnTreatmentOther => 'Another treatment';

  @override
  String get cnTreatmentUnknown => 'I am not sure yet';

  @override
  String get cnStatusWaitingClinic => 'Sent to the clinic · waiting for review';

  @override
  String get cnStatusWaitingInsurer =>
      'Reported as submitted to the plan · waiting for a reply';

  @override
  String get cnFollowUpNeeded => 'Follow-up needed';

  @override
  String get cnOutcomeRecorded => 'Result recorded';

  @override
  String get cnActiveCases => 'In progress';

  @override
  String get cnCompletedArchived => 'Completed & archived';

  @override
  String get cnCompleteCase => 'Complete this case';

  @override
  String get cnArchiveCase => 'Archive';

  @override
  String get cnReopenCase => 'Resume';

  @override
  String get cnOutcomeApproved => 'Approved';

  @override
  String get cnOutcomeDenied => 'Denied';

  @override
  String get cnOutcomeStopped => 'Not continuing';

  @override
  String get cnOutcomeOther => 'Other / not recorded';

  @override
  String get cnSentIsNotComplete =>
      'Sending is not the same as completing the case.';

  @override
  String get cnArchivedCase => 'Archived';

  @override
  String get cnStepKeyDetails => 'Key details';

  @override
  String get cnStepAddRecords => 'Add my records';

  @override
  String get cnStepReviewPacket => 'Review packet';

  @override
  String get cnDataConsent => 'Data processing';

  @override
  String get cnZipOrCity => 'ZIP or city';

  @override
  String get cnSaveArea => 'Save area';

  @override
  String get cnWeekCalendar => 'This week';

  @override
  String get cnMonthCalendar => 'This month';

  @override
  String get cnUsedShort => 'I used it';

  @override
  String get cnCalendarLegend =>
      'A dot means you logged something that day. An empty day is not a missed dose.';
}
