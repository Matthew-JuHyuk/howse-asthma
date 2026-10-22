// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginEmailLabel => 'ઇમેઇલ';

  @override
  String get loginPasswordLabel => 'પાસવર્ડ';

  @override
  String get loginButton => 'લૉગ ઇન કરો';

  @override
  String get signUpButton => 'સાઇન અપ કરો';

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
  String get medicationLogAddButton => 'ઇન્હેલર / દવાનો ઉપયોગ નોંધો';

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
  String get settingsTitle => 'સેટિંગ્સ';

  @override
  String get settingsLanguageLabel => 'ભાષા';

  @override
  String get settingsLocationLabel => 'Location';

  @override
  String get notificationAttackWarningTitle => 'Asthma Attack Risk Alert';

  @override
  String get mockContinue => 'ચાલુ રાખો';

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
  String get mockUnlock => 'અનલૉક કરો';

  @override
  String get mockUsePassword => 'તેના બદલે પાસવર્ડ વાપરો';

  @override
  String get mockOnboardingTitle => 'Patient setup';

  @override
  String get mockHomeLocation => 'ઘર';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => 'કટોકટીનો સંપર્ક';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => 'પ્રોવાઇડરનો આમંત્રણ કોડ';

  @override
  String get mockFinishOnboarding => 'Go to home';

  @override
  String get mockAllScreens => 'બધી સ્ક્રીન';

  @override
  String get mockAllScreensHint => 'Open any Screen ID for design review';

  @override
  String get mockStateCalm => 'શાંત';

  @override
  String get mockStateWarning => 'ચેતવણી';

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
  String get mockForecast => 'આગાહી';

  @override
  String get mockForecastHint => 'Next days air & pollen outlook';

  @override
  String get mockAlertPreview => 'Alert landing';

  @override
  String get mockAlertPreviewHint => 'Preview risk alert screen';

  @override
  String get mockShowWarningHome => 'ચેતવણી હોમનો પ્રિવ્યૂ';

  @override
  String get mockBackToCalmHome => 'પાછા';

  @override
  String get mockPanicCta => 'Panic mode';

  @override
  String get mockTrapAxis => 'TRAP / કાજળ';

  @override
  String get mockFloodAxis => 'અચાનક પૂર';

  @override
  String get mockPollenAxis => 'પરાગરજ';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · Pollen outlook';

  @override
  String get mockActSurvey => 'ACT સર્વે';

  @override
  String get mockActHint => 'ચિત્રો સાથેના 5 પ્રશ્નો (4 અઠવાડિયા)';

  @override
  String get mockPdcCheck => 'રોજની PDC તપાસ';

  @override
  String get mockPdcHint => 'એક ટૅપમાં નિયમિતતા';

  @override
  String get mockInhalerEvent => 'ઇન્હેલર નોંધાયું';

  @override
  String get mockActIntro =>
      'Answer based on the last 4 weeks. Design preview — answers are not saved.';

  @override
  String get mockQuestion => 'પ્રશ્ન';

  @override
  String get mockSubmit => 'સબમિટ કરો';

  @override
  String get mockPdcPrompt => 'શું આજે તમે તમારી કન્ટ્રોલર દવા લીધી?';

  @override
  String get mockTakenYes => 'હા, મેં લીધી';

  @override
  String get mockTakenNo => 'આજે નહીં';

  @override
  String get mockEvidenceSummary => 'Your evidence summary';

  @override
  String get mockEvidenceBody =>
      'Dummy summary for PA/LMN support. Design preview only.';

  @override
  String get mockInhalerEvents30d => 'Inhaler events (30d)';

  @override
  String get mockActScore => 'છેલ્લો ACT';

  @override
  String get mockPdcRate => 'PDC (30 દિવસ)';

  @override
  String get mockLocationsTitle => 'સાચવેલી જગ્યાઓ';

  @override
  String get mockLocationsHint => 'ઘર અને કામની જગ્યાનું નિરીક્ષણ';

  @override
  String get mockWorkLocation => 'કામ';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => 'જગ્યા ઉમેરો';

  @override
  String get mockRewardTitle => 'Rewards';

  @override
  String get mockDraftBanner => 'ડ્રાફ્ટ — પૉઇન્ટ અને વાઉચર ફક્ત પ્રિવ્યૂ છે';

  @override
  String get mockPointsBalance => 'પૉઇન્ટ બાકી';

  @override
  String get mockVoucherTitle => 'ફૂડ બેંક વાઉચર';

  @override
  String get mockVoucherHint => 'Exchange points (waitlist)';

  @override
  String get mockDonateTitle => 'દાન કરો';

  @override
  String get mockDonateHint => 'ફક્ત બીજી સંસ્થા મારફતે દાન';

  @override
  String get mockRewardHistory => 'ઇતિહાસ';

  @override
  String get mockRewardHistoryHint => 'પૉઇન્ટ અને દાન';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank (ડેમો)';

  @override
  String get mockVoucherCost => '50 પૉઇન્ટ · \$10 મૂલ્ય (ડ્રાફ્ટ)';

  @override
  String get mockJoinWaitlist => 'વેઇટલિસ્ટમાં જોડાઓ';

  @override
  String get mockDonateTransparency =>
      'દાન ચકાસાયેલા બીજી સંસ્થાના બિન-નફાકારક પ્લેટફોર્મ મારફતે થાય છે. Howse Asthma ક્યારેય કાર્ડની વિગતો સંગ્રહિત કરતું નથી.';

  @override
  String get mockDonateCta => 'દાન ખોલો (બાહ્ય)';

  @override
  String get mockExternalOnly =>
      'ડિઝાઇન પ્રિવ્યૂમાં બાહ્ય દાન પ્રદાતા જોડાયેલ નથી.';

  @override
  String get mockSignOutPreview => 'સાઇન આઉટ (પ્રિવ્યૂ)';

  @override
  String get mockOpenAuthFlow => 'Open auth flow';

  @override
  String get mockAlertBody =>
      'Risk rose near your location. Review environment details.';

  @override
  String get mockDismiss => 'બંધ કરો';

  @override
  String get mockPanicTitle => 'Need help now?';

  @override
  String get mockPanicStep1Body =>
      'સ્ટેપ 1 — તમારા ઇન્હેલર સાથે રહો. કટોકટીના સંપર્કો માટે આગળ વધો.';

  @override
  String get mockPanicStep2Title => 'મદદ માટે ફોન કરો';

  @override
  String get mockPanicStep2Body =>
      'ડિઝાઇન પ્રિવ્યૂ: બટનો વાસ્તવિક કૉલ કરતા નથી. ડિવાઇસ બિલ્ડમાં સ્ટેપ 2 tel: લિંકનો ઉપયોગ કરે છે.';

  @override
  String get mockCall911 => '911 પર કૉલ કરો';

  @override
  String get mockCallGuardian => 'કટોકટીના સંપર્કને કૉલ કરો';

  @override
  String get mockFeelingBetter => 'મને સારું લાગે છે';

  @override
  String get mockTabHome => 'હોમ';

  @override
  String get mockTabLog => 'નોંધ';

  @override
  String get mockTabReport => 'રિપોર્ટ';

  @override
  String get mockTabReward => 'રિવૉર્ડ';

  @override
  String get mockTabSettings => 'સેટિંગ્સ';

  @override
  String get navHome => 'Home';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get authChooseRole => 'તમારી ભૂમિકા પસંદ કરો';

  @override
  String get authRolePatient => 'દર્દી';

  @override
  String get authRolePatientHint => 'Track air quality risk and inhaler use';

  @override
  String get authRoleProvider => 'પ્રોવાઇડર';

  @override
  String get authRoleProviderHint =>
      'Link patients and review clinical evidence';

  @override
  String get authFullNameLabel => 'પૂરું નામ';

  @override
  String get authNpiLabel => 'NPI નંબર';

  @override
  String get authNpiHelper => '10 અંકનો નૅશનલ પ્રોવાઇડર આઇડેન્ટિફાયર';

  @override
  String get authOrContinueWith => 'અથવા આનાથી ચાલુ રાખો';

  @override
  String get authContinueGoogle => 'Google સાથે ચાલુ રાખો';

  @override
  String get authContinueApple => 'Apple સાથે ચાલુ રાખો';

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
  String get authSignOut => 'સાઇન આઉટ';

  @override
  String get authRetry => 'ફરી પ્રયાસ કરો';

  @override
  String get authWorking => 'કામ ચાલુ છે…';

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
  String get authErrorGeneric => 'કંઈક ખોટું થયું. કૃપા કરી ફરી પ્રયાસ કરો.';

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
  String get authBiometricTitle => 'Howse Asthma અનલૉક કરો';

  @override
  String get authBiometricHint => 'ચાલુ રાખવા બાયોમેટ્રિકનો ઉપયોગ કરો';

  @override
  String get authBiometricReason => 'Howse Asthma અનલૉક કરો';

  @override
  String get authBiometricUnlock => 'Unlock';

  @override
  String get authBiometricFailed => 'Biometric unlock failed. Try again.';

  @override
  String get authBiometricToggle => 'બાયોમેટ્રિક અનલૉક';

  @override
  String get authBiometricToggleHint =>
      'ઍપ ખોલતી વખતે બાયોમેટ્રિક અનલૉક જરૂરી બનાવો';

  @override
  String get authBiometricUnavailable => 'આ ડિવાઇસ પર બાયોમેટ્રિક ઉપલબ્ધ નથી';

  @override
  String get authOnboardingTitle => 'દર્દીનું સેટઅપ';

  @override
  String get authOnboardingBody =>
      'If your clinician shared an 8-character invite code, enter it now. You can also do this later in Settings.';

  @override
  String get authOnboardingSkip => 'હમણાં છોડી દો';

  @override
  String get authInviteCodeLabel => 'પ્રોવાઇડરનો આમંત્રણ કોડ';

  @override
  String get authInviteCodeHelper => '8 અક્ષર/અંક, 24 કલાકમાં સમાપ્ત થાય છે';

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
  String get authInviteIssueFailed => 'આમંત્રણ કોડ બનાવી શકાયો નથી';

  @override
  String get authConfirmLink => 'પુષ્ટિ કરો';

  @override
  String get authRejectLink => 'નકારો';

  @override
  String get authLinkStatusPending => 'પુષ્ટિ બાકી';

  @override
  String get settingsSystemDefault => 'System default';

  @override
  String get settingsLocationTodo =>
      'Location permission will be requested in a later update';

  @override
  String get providerHomeTab => 'હોમ';

  @override
  String get providerLinkTab => 'લિંક';

  @override
  String get providerHomeTitle => 'પ્રોવાઇડર હોમ';

  @override
  String providerHomeWelcome(String email) {
    return '$email તરીકે સાઇન ઇન કર્યું';
  }

  @override
  String get providerHomePlaceholder =>
      'દર્દીઓના ક્લિનિકલ ડૅશબોર્ડ પછીના વર્ઝનમાં આવશે. દર્દીઓને લિંક કરીને શરૂઆત કરો.';

  @override
  String get providerLinkPatientsCta => 'દર્દીઓને લિંક કરો';

  @override
  String get providerLinkTitle => 'દર્દીઓને લિંક કરો';

  @override
  String get providerLinkIntro =>
      '8 અક્ષરનો કોડ બનાવો (24 કલાક માન્ય). દર્દી તે દાખલ કરે છે, પછી બંને પક્ષ પુષ્ટિ કરે છે.';

  @override
  String get providerIssueInviteCta => 'આમંત્રણ કોડ બનાવો';

  @override
  String get providerInviteTtlHint => '24 કલાક માન્ય';

  @override
  String get providerInviteCopied => 'આમંત્રણ કોડ કૉપિ થયો';

  @override
  String get providerPendingLinks => 'બાકી લિંક';

  @override
  String get providerNoPendingLinks => 'કોઈ બાકી લિંક નથી';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'દર્દી $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'તાજેતરના આમંત્રણ કોડ';

  @override
  String get providerNoInvites => 'હજી કોઈ આમંત્રણ કોડ નથી';

  @override
  String get providerInviteConsumed => 'વપરાયેલ';

  @override
  String get providerInviteActive => 'ચાલુ';

  @override
  String get splashTagline => 'ટ્રિગર સામે તમારી સ્માર્ટ ઢાલ';

  @override
  String get splashGetStarted => 'શરૂ કરો';

  @override
  String get splashAlreadyHaveAccount => 'પહેલેથી એકાઉન્ટ છે?';

  @override
  String get splashSignIn => 'સાઇન ઇન કરો';

  @override
  String get authForgotPassword => 'પાસવર્ડ ભૂલી ગયા?';

  @override
  String get authNoAccount => 'એકાઉન્ટ નથી?';

  @override
  String get authUseBiometricHint =>
      'અનલૉક કરવા Face ID અથવા ફિંગરપ્રિન્ટ વાપરો';

  @override
  String get authTouchSensorHint => 'સેન્સરને સ્પર્શ કરો અથવા કૅમેરા તરફ જુઓ';

  @override
  String get navLog => 'Log';

  @override
  String get navReport => 'Report';

  @override
  String get navRewards => 'Rewards';

  @override
  String get mockChooseLanguage => 'ભાષા પસંદ કરો';

  @override
  String get mockYourLocation => 'તમારું સ્થાન';

  @override
  String get mockUseCurrentLocation => 'હાલનું સ્થાન વાપરો';

  @override
  String get mockLocationTrapOnly =>
      'સ્થાનનો ઉપયોગ ફક્ત TRAP હવાની ગુણવત્તાના ડેટા માટે થાય છે';

  @override
  String get mockLabelYourPlace => 'તમારી જગ્યાને નામ આપો';

  @override
  String get mockSchool => 'શાળા';

  @override
  String get mockWork => 'કામ';

  @override
  String get mockOther => 'અન્ય';

  @override
  String get mockEmergencyOnePerson => 'કટોકટીમાં ફોન કરવા માટે એક વ્યક્તિ';

  @override
  String get mockContactName => 'સંપર્કનું નામ';

  @override
  String get mockPhoneNumber => 'ફોન નંબર';

  @override
  String get mockProviderPairing => 'પ્રોવાઇડર સાથે જોડાણ';

  @override
  String get mockPairingOptional =>
      'વૈકલ્પિક — તમે આ પછી સેટિંગ્સમાં ઉમેરી શકો છો';

  @override
  String get mockNext => 'આગળ';

  @override
  String get mockProfessionalProfile => 'વ્યાવસાયિક પ્રોફાઇલ';

  @override
  String get mockStep2Of4 => '4 માંથી સ્ટેપ 2';

  @override
  String get mockTellPractice => 'અમને તમારી મેડિકલ પ્રૅક્ટિસ વિશે જણાવો';

  @override
  String get mockSpecialtyLabel => 'વિશેષતા';

  @override
  String get mockClinicLabel => 'પ્રૅક્ટિસ / ક્લિનિકનું નામ';

  @override
  String get mockNpiFormatOnly =>
      'ફક્ત ફૉર્મેટની તપાસ. NPI ની ચકાસણી સબમિટ કર્યા પછી થાય છે.';

  @override
  String get mockCredentialsSecure =>
      'તમારી ઓળખપત્ર વિગતો એન્ક્રિપ્ટ થઈને સુરક્ષિત રીતે સંગ્રહાય છે. સંમતિ વિના અમે પ્રોવાઇડરનો ડેટા ક્યારેય શેર કરતા નથી.';

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
  String get actPast4Weeks => 'છેલ્લા 4 અઠવાડિયામાં';

  @override
  String get actQ1 =>
      'કેટલા સમય સુધી તમારા અસ્થમાને કારણે તમે કામ, શાળા કે ઘરમાં ધાર્યું તેટલું કામ કરી શક્યા નહીં?';

  @override
  String get actQ2 => 'તમને કેટલી વાર શ્વાસ ચડ્યો છે?';

  @override
  String get actQ3 =>
      'તમારા અસ્થમાના લક્ષણોને કારણે તમે કેટલી વાર રાત્રે અથવા રોજ કરતાં વહેલા જાગી ગયા?';

  @override
  String get actQ4 =>
      'તમે કેટલી વાર તમારું જરૂર પડે ત્યારે વાપરવાનું ઇન્હેલર (rescue inhaler) અથવા નેબ્યુલાઇઝરની દવા વાપરી છે?';

  @override
  String get actQ5 => 'તમે તમારા અસ્થમાના નિયંત્રણને કેવું ગણશો?';

  @override
  String get actOpt1 => 'દરેક સમયે';

  @override
  String get actOpt2 => 'મોટા ભાગના સમયે';

  @override
  String get actOpt3 => 'અમુક સમયે';

  @override
  String get actOpt4 => 'થોડા સમયે';

  @override
  String get actOpt5 => 'એક પણ સમયે નહીં';

  @override
  String get actQ5Opt1 => 'બિલકુલ નિયંત્રણમાં નથી';

  @override
  String get actQ5Opt2 => 'નબળા નિયંત્રણમાં';

  @override
  String get actQ5Opt3 => 'થોડું નિયંત્રણમાં';

  @override
  String get actQ5Opt4 => 'સારી રીતે નિયંત્રણમાં';

  @override
  String get actQ5Opt5 => 'સંપૂર્ણ નિયંત્રણમાં';

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
      'બટન ફોન ડાયલર ખોલે છે. કૉલ ક્યારેય આપમેળે થતો નથી.';

  @override
  String panicCallNamed(String name) {
    return '$name ને કૉલ કરો';
  }

  @override
  String get panicDialFailed => 'આ ડિવાઇસ પર ફોન ડાયલર ખોલી શકાયું નથી.';

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
      'ટ્રાફિક સાથે જોડાયેલી હવાનો સૂચક (સેન્સર અને, ન્યૂ જર્સીમાં, માલવાહકનું વૈકલ્પિક વજન).';

  @override
  String get envTrapTip =>
      'Limit outdoor exertion when TRAP is HIGH or CRITICAL.';

  @override
  String get envFloodDetail => 'તમારી નજીક NWSના અચાનક પૂર અને નદીના એલર્ટ.';

  @override
  String get envFloodTipClear => 'No active flash-flood warning for this area.';

  @override
  String get envPollenDetail => 'Googleનો પરાગ અંદાજ.';

  @override
  String get envPollenTip =>
      'Keep windows closed and rinse after outdoor time when UPI is high.';

  @override
  String envUsgsRate(String rate) {
    return 'USGS stream change: $rate ft/hr';
  }

  @override
  String envUpdatedAt(String when) {
    return 'અપડેટ: $when';
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
      'તમારા જવાબો સાચવવામાં આવ્યા છે, જેથી તમે તેને તમારા ડૉક્ટર અથવા સારવાર આપનાર સાથે શેર કરી શકો. પ્રશ્નાવલીના આ વર્ઝનને સત્તાવાર ગણતરી સાથે તપાસવામાં આવ્યું નથી, તેથી ઍપ સ્કોર બતાવતી નથી.';

  @override
  String get s5ActSaved => 'તમારા જવાબો સાચવાયા.';

  @override
  String get s5ActSubtitle => 'છેલ્લા 4 અઠવાડિયા વિશે 5 પ્રશ્નો';

  @override
  String get s5ActTitle => 'અસ્થમા નિયંત્રણની પ્રશ્નાવલી';

  @override
  String get s5AddDetails => 'વિગતો ઉમેરો';

  @override
  String get s5AddRecord => 'રેકોર્ડ ઉમેરો';

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
  String get s5AqiGood => 'સારી';

  @override
  String get s5AqiModerate => 'મધ્યમ';

  @override
  String get s5AqiUsg => 'સંવેદનશીલ જૂથો માટે અસ્વસ્થ';

  @override
  String get s5AqiUnhealthy => 'અસ્વસ્થ';

  @override
  String get s5AqiVeryUnhealthy => 'ખૂબ અસ્વસ્થ';

  @override
  String get s5AqiHazardous => 'જોખમી';

  @override
  String s5AqiValue(String category, int aqi) {
    return '$category (AQI $aqi)';
  }

  @override
  String get s5Back => 'પાછા';

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
  String get s5Cancel => 'રદ કરો';

  @override
  String get s5Change => 'બદલો';

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
  String get s5Delete => 'કાઢી નાખો';

  @override
  String get s5DeleteConfirm => 'આ નોંધ કાઢી નાખવી છે?';

  @override
  String get s5DeleteFailed => 'કાઢી શકાયું નથી. કૃપા કરી ફરી પ્રયાસ કરો.';

  @override
  String get s5Edit => 'ફેરફાર કરો';

  @override
  String get s5EnglishVersion => 'English (for clinician)';

  @override
  String get s5EntryRemoved => 'નોંધ કાઢી નાખી.';

  @override
  String get s5EnvAirDetail =>
      'જાહેર મોનિટર અને નજીકના સેન્સરમાંથી યુ.એસ. EPA હવા ગુણવત્તા સૂચક. તે વિસ્તારની બહારની હવા બતાવે છે, અલગ ટ્રાફિક ધુમાડો નહીં.';

  @override
  String get s5EnvAirQuality => 'હવાની ગુણવત્તા';

  @override
  String get s5EnvAlertsHeading => 'Environment alerts';

  @override
  String get s5EnvCardTitle => 'Today\'s local environment';

  @override
  String get s5EnvFlood => 'પૂરની ચેતવણી';

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
  String get s5EnvPollen => 'પરાગ સૂચક';

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
  String get s5FieldDate => 'તારીખ';

  @override
  String get s5FieldMedication => 'દવા';

  @override
  String get s5FieldNote => 'નોંધ (વૈકલ્પિક)';

  @override
  String get s5FieldPuffs => 'પફ (puff)ની સંખ્યા (વૈકલ્પિક)';

  @override
  String get s5FieldReason => 'કારણ (વૈકલ્પિક)';

  @override
  String get s5FieldTime => 'સમય';

  @override
  String get s5FilterAll => 'બધું';

  @override
  String get s5FilterInhaler => 'ઇન્હેલર';

  @override
  String get s5FilterMedCheck => 'દવાની પુષ્ટિ';

  @override
  String get s5FilterSymptoms => 'લક્ષણો';

  @override
  String get s5FloodIssued => 'પૂરની ચેતવણી બહાર પડી છે';

  @override
  String get s5FloodNone => 'પૂરની ચેતવણી નથી';

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
  String get s5FromUrgentHelp => 'તાત્કાલિક મદદમાંથી નોંધ્યું';

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
  String get s5InhalerEditTitle => 'ઇન્હેલરના ઉપયોગની વિગતો';

  @override
  String get s5InhalerEntry => 'ઇન્હેલરનો ઉપયોગ';

  @override
  String get s5InhalerLogged => 'ઇન્હેલરનો ઉપયોગ નોંધાયો.';

  @override
  String get s5InhalerOneEntryHint =>
      'દરેક વાર સાચવો ત્યારે એક ઇન્હેલર-ઉપયોગની નોંધ થાય છે. તેને એક પફ (puff) કે એક દિવસ ગણવામાં આવતો નથી.';

  @override
  String s5InhalerUnknownCount(int n) {
    return 'દવા ઓળખાઈ નથી: $n';
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
  String get s5Last30Days => 'છેલ્લા 30 દિવસ';

  @override
  String get s5Last7Days => 'છેલ્લા 7 દિવસ';

  @override
  String get s5LogInhaler => 'ઇન્હેલરનો ઉપયોગ નોંધો';

  @override
  String get s5LogLegend =>
      'દરેક લીટી એક સાચવેલી નોંધ છે. નોંધ વગરના દિવસો “નોંધાયું નથી” છે, જે શૂન્ય કરતાં અલગ છે.';

  @override
  String get s5LogSymptoms => 'લક્ષણો નોંધો';

  @override
  String get s5MedAdd => 'દવા ઉમેરો';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return 'વાપરેલા દિવસ: $a · ન વાપર્યા: $b · યાદ નથી: $c · નોંધાયું નથી: $d';
  }

  @override
  String get s5MedCheckIntro =>
      'તમે તમારી દવા વાપરી કે નહીં તેની આ જાતે જણાવેલી પુષ્ટિ છે. તે દવાની દુકાનના રેકોર્ડ પર આધારિત નથી.';

  @override
  String get s5MedCheckQuestion => 'શું તમે તમારી દવા નક્કી કર્યા મુજબ વાપરી?';

  @override
  String get s5MedCheckTitle => 'આજની દવાની પુષ્ટિ';

  @override
  String get s5MedChooseHint =>
      'દવા પસંદ કરો, અથવા “મને દવાનું નામ ખબર નથી” પસંદ કરો.';

  @override
  String get s5MedDailyCheck => 'રોજની પુષ્ટિ';

  @override
  String get s5MedDailyCheckHint =>
      'હોમ પર “આજની દવાની પુષ્ટિ” બતાવો. તમારા ડૉક્ટર અથવા સારવાર આપનારે આ દવા દરરોજ વાપરવાનું કહ્યું હોય તો જ ચાલુ કરો.';

  @override
  String get s5MedDefault => 'ઝડપી નોંધ માટે ડિફૉલ્ટ';

  @override
  String get s5MedDefaultHint =>
      'હોમ પર “ઇન્હેલરનો ઉપયોગ નોંધો” ટૅપ કરો ત્યારે આનો ઉપયોગ થાય છે.';

  @override
  String get s5MedEdit => 'દવામાં ફેરફાર કરો';

  @override
  String get s5MedNameLabel => 'દવાનું નામ (તમારા લેબલ પર છે તેમ)';

  @override
  String get s5MedNotApplicable => 'આજ માટે નક્કી નથી';

  @override
  String s5MedNotApplicableDays(int n) {
    return 'નક્કી નથી: $n દિવસ';
  }

  @override
  String get s5MedNotRecorded => 'દવા નોંધાઈ નથી';

  @override
  String get s5MedNotSure => 'મને યાદ નથી';

  @override
  String get s5MedNotUsed => 'મેં ઉપયોગ કર્યો નથી';

  @override
  String get s5MedOther => 'બીજું નામ';

  @override
  String get s5MedOtherHint => 'દવાનું નામ લખો';

  @override
  String get s5MedReasonCost => 'ખર્ચ';

  @override
  String get s5MedReasonForgot => 'ભૂલાઈ ગયું';

  @override
  String get s5MedReasonNoMedicine => 'દવા પાસે નહોતી';

  @override
  String get s5MedReasonQuestion => 'કારણ (વૈકલ્પિક)';

  @override
  String get s5MedUnknown => 'મને દવાનું નામ ખબર નથી';

  @override
  String get s5MedUnknownShort => 'દવા ઓળખાઈ નથી';

  @override
  String get s5MedUsed => 'મેં ઉપયોગ કર્યો';

  @override
  String get s5MyLanguage => 'My language';

  @override
  String get s5MyLogTitle => 'મારી નોંધ';

  @override
  String get s5MyMedsEmpty => 'હજી કોઈ દવા સાચવી નથી.';

  @override
  String get s5MyMedsHint =>
      'તમે ખાતરી કરેલા નામ, જેથી નોંધ ઝડપથી થાય. આ ડોઝની ભલામણ નથી.';

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
  String get s5NoAnswer => 'જવાબ આપવો નથી';

  @override
  String get s5NoRecordsYet => 'હજી કોઈ રેકોર્ડ નથી';

  @override
  String s5NoSymptomDays(int n) {
    return '“કોઈ લક્ષણ નથી” તરીકે ચિહ્નિત દિવસો: $n';
  }

  @override
  String get s5NotRecorded => 'નોંધાયું નથી';

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
    return 'સમયગાળો: $days દિવસ · રેકોર્ડવાળા દિવસ: $n';
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
      other: '$n પફ',
      one: '1 પફ',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return 'Question $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return '$total માંથી પ્રશ્ન $n';
  }

  @override
  String get s5ReasonBeforeActivity => 'પ્રવૃત્તિ પહેલાં';

  @override
  String get s5ReasonOther => 'અન્ય';

  @override
  String get s5ReasonSymptoms => 'લક્ષણોને કારણે';

  @override
  String s5RecentInhaler(int n) {
    return 'ઇન્હેલર ઉપયોગની નોંધો: $n';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return 'લક્ષણોવાળા દિવસ: $n';
  }

  @override
  String get s5RecentTitle => 'Last 7 days';

  @override
  String get s5RecordsLoadFailed =>
      'તમારા રેકોર્ડ લોડ થઈ શક્યા નથી. કૃપા કરી ફરી પ્રયાસ કરો.';

  @override
  String get s5RecordsManageHint =>
      'You can edit or delete entries in My log. Deleting always asks you to confirm.';

  @override
  String get s5Refresh => 'Refresh';

  @override
  String get s5Reload => 'Load again';

  @override
  String get s5Save => 'સાચવો';

  @override
  String get s5Saved => 'સાચવ્યું.';

  @override
  String get s5SavedPlacesHint => 'Saved places such as home, school, or work';

  @override
  String get s5SaveFailed => 'સાચવી શકાયું નથી. તમારી નોંધો હજી અહીં જ છે.';

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
  String get s5SymActivityLimited => 'પ્રવૃત્તિઓ મર્યાદિત થઈ';

  @override
  String get s5SymCough => 'ખાંસી';

  @override
  String get s5SymNightWaking => 'રાત્રે જાગી ગયા';

  @override
  String get s5SymNone => 'કોઈ લક્ષણ નથી';

  @override
  String get s5SymOther => 'બીજું કંઈક';

  @override
  String get s5SymOtherHint => 'તમારા પોતાના શબ્દોમાં લખો';

  @override
  String get s5SymShortBreath => 'શ્વાસ લેવામાં તકલીફ';

  @override
  String get s5SymWheeze => 'સીટી જેવો શ્વાસ (wheezing)';

  @override
  String get s5SymptomEditTitle => 'લક્ષણોમાં ફેરફાર કરો';

  @override
  String get s5SymptomEntry => 'લક્ષણો';

  @override
  String get s5SymptomNoneHint =>
      'જે દિવસો તમે નોંધતા નથી તે “નોંધાયું નથી” તરીકે દેખાય છે, “કોઈ લક્ષણ નથી” તરીકે નહીં.';

  @override
  String get s5SymptomQuestion => 'તમે શું નોંધ્યું?';

  @override
  String get s5Today => 'આજે';

  @override
  String get s5Undo => 'પાછું લો';

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
      'જો તમારા ડૉક્ટર અથવા સારવાર આપનારે તમને અસ્થમા ઍક્શન પ્લાન (asthma action plan) આપ્યો હોય, તો તેને અનુસરો.';

  @override
  String get s5UrgentCall911Locked => 'Urgent help: call 911';

  @override
  String get s5UrgentHelp => 'તાત્કાલિક મદદ';

  @override
  String get s5UrgentIntro =>
      'જો શ્વાસ લેવો ખૂબ મુશ્કેલ હોય અથવા સારું ન થતું હોય, તો 911 પર કૉલ કરો.';

  @override
  String get s5UrgentLogHint =>
      'વૈકલ્પિક: તમે ઇન્હેલર વાપર્યું તેની નોંધ સાચવો.';

  @override
  String get s5UrgentNoContact =>
      'હજી કટોકટીનો સંપર્ક નથી. સેટિંગ્સ → મદદમાં ઉમેરો.';

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
  String get s6AddTime => 'સમય ઉમેરો';

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
  String get s6DoseLater => 'પછી તપાસો';

  @override
  String get s6DoseNotUsed => 'મેં ઉપયોગ કરી શક્યું નથી';

  @override
  String get s6DoseUnconfirmed => 'No answer yet';

  @override
  String get s6DoseUsed => 'મેં ઉપયોગ કર્યો';

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
  String get s6HomeWaterNo => 'ના';

  @override
  String get s6HomeWaterQuestion => 'ઘરમાં પાણી ચૂયું કે પૂર આવ્યું હતું?';

  @override
  String get s6HomeWaterYes => 'હા';

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
  String get s6OccurredLabel => 'ક્યારે બન્યું';

  @override
  String get s6PdfEnvLimit =>
      'Regional reference only. It does not show personal exposure or the cause of symptoms. A single AQI does not name ozone and particles together, and it does not include pollen.';

  @override
  String get s6PdfEnvTitle => 'Environment reference (appendix)';

  @override
  String get s6PuffsEach => 'દર વખતે પફ (puff)';

  @override
  String s6ReminderBodyNamed(String name) {
    return '$name ની પુષ્ટિ કરવાનો સમય';
  }

  @override
  String get s6ReminderBodyPrivate => 'તમારી દવાની પુષ્ટિ કરવાનો સમય';

  @override
  String get s6ReminderChannel =>
      'તમે સાચવેલા દવાના સમયે યાદ અપાવે છે. આ દર 30 મિનિટે આવતી હવા-હવામાનની ચેતવણી નથી.';

  @override
  String get s6ReminderTitle => 'દવાની પુષ્ટિ';

  @override
  String get s6RoleBoth => 'રોજની અને જરૂર પડે ત્યારે';

  @override
  String get s6RoleController => 'રોજની દવા';

  @override
  String get s6RoleRescue => 'જરૂર પડે ત્યારે';

  @override
  String get s6ScheduleTimes => 'તમે જે સમયે લો છો';

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
  String get cnTagline => 'ઇન્સ્યોરન્સના પત્રો, આગળનાં સ્પષ્ટ પગલાં';

  @override
  String get cnDemoBadge => 'નમૂનો';

  @override
  String get cnDemoBadgeLong =>
      'બનાવટી ડેટા સાથેનો નમૂનો. પરિણામો નક્કી કરેલા છે.';

  @override
  String get cnAuthSignInTitle => 'સાઇન ઇન કરો';

  @override
  String get cnAuthCreateTitle => 'એકાઉન્ટ બનાવો';

  @override
  String get cnAuthResetTitle => 'પાસવર્ડ રીસેટ કરો';

  @override
  String get cnAuthSignIn => 'સાઇન ઇન કરો';

  @override
  String get cnAuthCreate => 'એકાઉન્ટ બનાવો';

  @override
  String get cnAuthSendReset => 'રીસેટ લિંક મોકલો';

  @override
  String cnAuthProfileError(String code) {
    return 'તમે સાઇન ઇન છો, પણ તમારું એકાઉન્ટ લોડ થઈ શક્યું નથી ($code).';
  }

  @override
  String get cnRetry => 'ફરી પ્રયાસ કરો';

  @override
  String get cnSignOut => 'સાઇન આઉટ';

  @override
  String get cnAuthPreparingAccount => 'તમારું એકાઉન્ટ તૈયાર થઈ રહ્યું છે…';

  @override
  String get cnAuthNameLabel => 'નામ (વૈકલ્પિક)';

  @override
  String get cnAuthNameHelper =>
      'તમારા કાગળોના સેટ પર દેખાશે. તમે તેને પછી બદલી શકો છો.';

  @override
  String get cnAuthEmailLabel => 'ઇમેઇલ';

  @override
  String get cnAuthPasswordLabel => 'પાસવર્ડ';

  @override
  String get cnAuthPasswordHelper => 'ઓછામાં ઓછા 8 અક્ષર';

  @override
  String get cnAuthShowPassword => 'પાસવર્ડ બતાવો';

  @override
  String get cnAuthHidePassword => 'પાસવર્ડ છુપાવો';

  @override
  String get cnAuthPasswordRequired => 'તમારો પાસવર્ડ દાખલ કરો';

  @override
  String cnAuthCheckEmail(String email) {
    return 'અમે $email પર પુષ્ટિની લિંક મોકલી છે. તેને આ ફોન પર ખોલો, પછી સાઇન ઇન કરો.';
  }

  @override
  String cnAuthResetSent(String email) {
    return 'જો $email માટે એકાઉન્ટ હોય, તો રીસેટ લિંક મોકલાઈ છે. તેને આ ફોન પર ખોલો.';
  }

  @override
  String get cnAuthResent => 'ફરી મોકલ્યું.';

  @override
  String get cnAuthResend => 'ઇમેઇલ ફરી મોકલો';

  @override
  String get cnAuthSignInInstead => 'મેં પુષ્ટિ કરી. સાઇન ઇન કરો';

  @override
  String get cnAuthForgot => 'પાસવર્ડ ભૂલી ગયા?';

  @override
  String get cnAuthNoAccount => 'નવા છો? એકાઉન્ટ બનાવો';

  @override
  String get cnAuthHaveAccount => 'એકાઉન્ટ છે? સાઇન ઇન કરો';

  @override
  String get cnAuthResetHint =>
      'તમારો ઇમેઇલ દાખલ કરો, અમે નવો પાસવર્ડ સેટ કરવા માટે લિંક મોકલીશું.';

  @override
  String get cnAuthBackToSignIn => 'સાઇન ઇન પર પાછા જાઓ';

  @override
  String get cnAuthPrivacyLine =>
      'તમારા પત્રો અને રેકોર્ડ ફક્ત તમારા એકાઉન્ટ માટે ખાનગી છે.';

  @override
  String get cnAuthPasswordUpdated => 'પાસવર્ડ બદલાઈ ગયો.';

  @override
  String get cnAuthNewPasswordTitle => 'નવો પાસવર્ડ સેટ કરો';

  @override
  String get cnAuthNewPasswordLabel => 'નવો પાસવર્ડ';

  @override
  String get cnAuthSavePassword => 'પાસવર્ડ સાચવો';

  @override
  String get cnLater => 'પછી';

  @override
  String get cnAuthErrInvalidCredentials => 'ઇમેઇલ અથવા પાસવર્ડ સાચો નથી.';

  @override
  String get cnAuthErrNotConfirmed =>
      'કૃપા કરી પહેલા તમારા ઇમેઇલની પુષ્ટિ કરો. ઇનબૉક્સ જુઓ અથવા લિંક ફરી મોકલો.';

  @override
  String get cnAuthErrExists =>
      'આ ઇમેઇલથી એકાઉન્ટ પહેલેથી છે. તેના બદલે સાઇન ઇન કરો.';

  @override
  String get cnAuthErrWeakPassword =>
      'વધુ મજબૂત પાસવર્ડ પસંદ કરો (ઓછામાં ઓછા 8 અક્ષર).';

  @override
  String get cnAuthErrSamePassword => 'તમારા જૂના પાસવર્ડથી અલગ પાસવર્ડ વાપરો.';

  @override
  String get cnAuthErrRateLimited =>
      'ઘણા બધા પ્રયાસ થયા. એક મિનિટ રાહ જુઓ અને ફરી પ્રયાસ કરો.';

  @override
  String get cnAuthErrInvalidEmail => 'ઇમેઇલ ઍડ્રેસ તપાસો.';

  @override
  String get cnAuthErrEmailNotAuthorized =>
      'હમણાં આ ઍડ્રેસ પર ઇમેઇલ મોકલી શકાયો નથી. પછી ફરી પ્રયાસ કરો.';

  @override
  String get cnAuthErrDisabled => 'આ સાઇન ઇન પદ્ધતિ બંધ છે.';

  @override
  String get cnAuthErrSessionExpired =>
      'તમારું સત્ર પૂરું થયું. કૃપા કરી ફરી સાઇન ઇન કરો.';

  @override
  String cnAuthErrUnknown(String code) {
    return 'કંઈક ખોટું થયું ($code). ફરી પ્રયાસ કરો.';
  }

  @override
  String get cnErrNetwork =>
      'કનેક્શન નથી. તમારું ઇન્ટરનેટ તપાસો અને ફરી પ્રયાસ કરો.';

  @override
  String get cnErrServiceDown =>
      'સેવા જવાબ આપતી નથી. થોડી મિનિટ પછી ફરી પ્રયાસ કરો.';

  @override
  String get cnTabHome => 'મુખ્ય';

  @override
  String get cnTabCases => 'કેસ';

  @override
  String get cnTabRecords => 'રેકોર્ડ';

  @override
  String get cnTabAccount => 'એકાઉન્ટ';

  @override
  String get cnHomeHeadline => 'તમારા ઇન્સ્યોરન્સના પત્રને સમજો.';

  @override
  String get cnScanLetter => 'પત્ર સ્કૅન કરો';

  @override
  String get cnUploadFile => 'PDF / ફોટો અપલોડ કરો';

  @override
  String get cnTryDemo => 'ડેમો અજમાવો';

  @override
  String get cnHomeSignInLine => 'તમારા કેસ સાચવવા માટે એકાઉન્ટ જોઈએ.';

  @override
  String get cnServiceNotConfigured =>
      'આ બિલ્ડ સર્વર સાથે જોડાયેલું નથી. ફક્ત ડેમો ચાલે છે.';

  @override
  String get cnContinueCase => 'તમારો કેસ ચાલુ રાખો';

  @override
  String get cnHowItWorks => 'તે કેવી રીતે કામ કરે છે';

  @override
  String get cnStep1Title => 'પત્ર વાંચો';

  @override
  String get cnStep1Body =>
      'ફોટો લો. અમે કારણ, આગળનું પગલું અને તારીખ શોધીએ છીએ.';

  @override
  String get cnStep2Title => 'રેકોર્ડ ભેગા કરો';

  @override
  String get cnStep2Body =>
      'પત્રમાં જે માગ્યું છે તેને તમારા પોતાના રેકોર્ડ સાથે મેળવો.';

  @override
  String get cnStep3Title => 'કાગળોનું સેટ બનાવો';

  @override
  String get cnStep3Body =>
      'ડૉક્ટર માટે એક પાનાનો સારાંશ અને સમીક્ષા વિનંતીનો અધૂરો લખાણ મેળવો.';

  @override
  String get cnRecentCases => 'અન્ય કેસ';

  @override
  String get cnNoCasesYet => 'હજી કોઈ કેસ નથી';

  @override
  String get cnNoOtherCases => 'બીજા કોઈ કેસ નથી.';

  @override
  String get cnSeeAllCases => 'બધા કેસ જુઓ';

  @override
  String get cnNoCasesBody => 'શરૂ કરવા માટે ઇન્સ્યોરન્સનો પત્ર સ્કૅન કરો.';

  @override
  String get cnCasesSignInTitle => 'તમારા કેસ જોવા સાઇન ઇન કરો';

  @override
  String get cnCasesSignInBody =>
      'અથવા તે કેવી રીતે કામ કરે છે તે જોવા ડેમો ખોલો.';

  @override
  String get cnCaseDeleted => 'કેસ કાઢી નાખ્યો.';

  @override
  String get cnCaseUntitled => 'ઇન્સ્યોરન્સનો પત્ર';

  @override
  String get cnStatusReading => 'પત્ર વંચાય છે';

  @override
  String get cnStatusNeedsReview => 'તપાસ જરૂરી';

  @override
  String get cnStatusGatherRecords => 'રેકોર્ડ ભેગા કરો';

  @override
  String get cnStatusPacketReady => 'કાગળોનું સેટ તૈયાર';

  @override
  String get cnStatusNeedsAttention => 'ધ્યાન જરૂરી';

  @override
  String get cnStatusNotStarted => 'શરૂ થયું નથી';

  @override
  String get cnNextWaitReading => 'અમે પત્ર વાંચી રહ્યા છીએ.';

  @override
  String get cnNextTryAgain => 'વાંચવાનું અટકી ગયું. ફરી પ્રયાસ કરવા કેસ ખોલો.';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'પુષ્ટિ કરવાની $count વિગતો',
      one: 'પુષ્ટિ કરવાની 1 વિગત',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return 'માગેલી $total વસ્તુઓમાંથી $done સંભાળી';
  }

  @override
  String get cnNextSharePacket => 'કાગળોનું સેટ શેર કરવા તૈયાર';

  @override
  String get cnNextCreatePacket => 'આગળ: કાગળોનું સેટ બનાવો';

  @override
  String cnDateToCheckShort(String date) {
    return 'તપાસવાની તારીખ: $date';
  }

  @override
  String cnDatePassedShort(String date) {
    return 'તારીખ વીતી ગઈ: $date';
  }

  @override
  String get cnMoreActions => 'વધુ વિકલ્પો';

  @override
  String get cnDeleteCase => 'કેસ કાઢી નાખો';

  @override
  String get cnDeleteCaseTitle => 'આ કેસ કાઢી નાખવો છે?';

  @override
  String get cnDeleteCaseBody =>
      'આનાથી પત્રના પાના, તેમાંથી વાંચેલી વિગતો, જોડેલા રેકોર્ડના સારાંશ અને કાગળોના સેટ કાઢી નંખાશે. તમારી દવા અને લક્ષણોના રેકોર્ડ રહેશે.';

  @override
  String get cnCancel => 'રદ કરો';

  @override
  String get cnDelete => 'કાઢી નાખો';

  @override
  String get cnDeleteFailed =>
      'કાઢી શકાયું નથી. તમારું કનેક્શન તપાસો અને ફરી પ્રયાસ કરો.';

  @override
  String get cnKindInitialDenial => 'દવાના કવરેજ પર ના (Drug coverage denial)';

  @override
  String get cnKindInfoRequest => 'વધુ માહિતી માટેની વિનંતી';

  @override
  String get cnKindReauth => 'ફરી મંજૂરીની નોટિસ (Reauthorization)';

  @override
  String get cnKindFinalDenial =>
      'ફરી અરજીનો અંતિમ નિર્ણય (Final appeal decision)';

  @override
  String get cnKindEob => 'બિલ અથવા લાભોની સમજૂતી (Explanation of Benefits)';

  @override
  String get cnKindOther => 'અન્ય પત્ર';

  @override
  String get cnKindUncertain => 'પત્રનો પ્રકાર સ્પષ્ટ નથી';

  @override
  String get cnFieldPatientName => 'દર્દીનું નામ';

  @override
  String get cnFieldPlanName => 'પ્લાન';

  @override
  String get cnFieldMemberId => 'સભ્ય ID (Member ID)';

  @override
  String get cnFieldCaseReference => 'કેસ અથવા સંદર્ભ નંબર';

  @override
  String get cnFieldMedication => 'દવા (જેમ લખ્યું છે તેમ)';

  @override
  String get cnFieldDose => 'ડોઝ (જેમ લખ્યું છે તેમ)';

  @override
  String get cnFieldNoticeDate => 'નોટિસની તારીખ';

  @override
  String get cnFieldContact => 'સંપર્ક';

  @override
  String get cnFieldSubmissionRoute => 'ક્યાં મોકલવું';

  @override
  String get cnFactEdited => 'તમે બદલ્યું';

  @override
  String get cnFactChecked => 'તપાસ્યું';

  @override
  String get cnFactNotInLetter => 'પત્રમાં નથી';

  @override
  String get cnFactNeedsCheck => 'તપાસ જરૂરી';

  @override
  String get cnFactFromLetter => 'પત્રમાંથી';

  @override
  String get cnWhoYou => 'તમે';

  @override
  String get cnWhoCareTeam => 'સારવાર કરનાર ટીમ';

  @override
  String get cnWhoPlan => 'પ્લાન';

  @override
  String get cnWhoUnknown => 'ખાતરી નથી';

  @override
  String get cnReqLinked => 'જોડ્યું';

  @override
  String get cnReqAskedCareTeam => 'સારવાર કરનાર ટીમને પૂછ્યું';

  @override
  String get cnReqNotAvailable => 'ઉપલબ્ધ નથી';

  @override
  String get cnReqNotNeeded => 'જરૂર નથી';

  @override
  String get cnReqNeeded => 'જરૂરી';

  @override
  String get cnReqReset => 'જરૂરી તરીકે ચિહ્નિત કરો';

  @override
  String get cnRecMedication => 'દવાનો ઇતિહાસ';

  @override
  String get cnRecSymptoms => 'લક્ષણોની નોંધ';

  @override
  String get cnRecLocalContext => 'પર્યાવરણના પરિબળો';

  @override
  String get cnRecPrn => 'જરૂર પડે ત્યારે વાપરવાનું ઇન્હેલર';

  @override
  String get cnDemoTitle => 'ડેમો';

  @override
  String get cnDemoReset => 'ડેમો રીસેટ કરો';

  @override
  String get cnDemoResetDone => 'ડેમો રીસેટ થયો.';

  @override
  String get cnDemoIntro =>
      'નક્કી કરેલા પરિણામો સાથેના ત્રણ બનાવટી પત્રો, જેથી તમે દરેક પગલું જોઈ શકો. કશું અપલોડ થતું નથી.';

  @override
  String get cnUpEmpty => 'તે ફાઇલ ખાલી છે.';

  @override
  String cnUpTooLarge(int mb) {
    return 'દરેક ફાઇલ $mb MB કે તેથી નાની હોવી જોઈએ.';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return 'બધા પાના મળીને $mb MB કે તેથી નાના હોવા જોઈએ.';
  }

  @override
  String cnUpTooManyPages(int max) {
    return 'દરેક પત્ર માટે વધુમાં વધુ $max પાના.';
  }

  @override
  String get cnUpUnsupported =>
      'JPG, PNG અથવા PDF વાપરો. HEIC ફોટા માટે, અહીં નવો ફોટો લો.';

  @override
  String get cnUpBadFile =>
      'આ ફાઇલ વાંચી શકાતી નથી. બીજો ફોટો અથવા PDF અજમાવો.';

  @override
  String get cnUpEncrypted =>
      'આ PDF પાસવર્ડથી સુરક્ષિત છે. અનલૉક કરેલી કૉપિ સાચવો અથવા ફોટા લો.';

  @override
  String get cnCameraUnavailable =>
      'કૅમેરા ઉપલબ્ધ નથી. તેના બદલે તમે ફોટો અથવા PDF અપલોડ કરી શકો છો.';

  @override
  String get cnPhotosUnavailable =>
      'ફોટા ખોલી શકાતા નથી. સેટિંગ્સમાં ફોટાની પરવાનગી આપો, અથવા PDF અપલોડ કરો.';

  @override
  String get cnFilesUnavailable =>
      'હમણાં ફાઇલો ખોલી શકાતી નથી. ફરી પ્રયાસ કરો.';

  @override
  String get cnUploadFailed =>
      'અપલોડ પૂરું થયું નથી. તમારા પાના હજી અહીં છે. ફરી પ્રયાસ કરો.';

  @override
  String get cnCaptureTitle => 'પત્રના પાના ઉમેરો';

  @override
  String get cnReplacePagesTitle => 'પત્રના પાના બદલો';

  @override
  String get cnOpening => 'ખૂલી રહ્યું છે…';

  @override
  String get cnCaptureEmptyTitle => 'તમારા પત્રના પાના ઉમેરો';

  @override
  String get cnCaptureTips =>
      'પાનાને સમતલ મૂકો, સારા અજવાળામાં, ચારેય ખૂણા ફ્રેમમાં આવે તેમ. દરેક પાનું ક્રમ પ્રમાણે ઉમેરો.';

  @override
  String get cnTakePhoto => 'ફોટો લો';

  @override
  String get cnAddPage => 'પાનું ઉમેરો';

  @override
  String get cnAddPhoto => 'ફોટો';

  @override
  String get cnPickGallery => 'ફોટામાંથી પસંદ કરો';

  @override
  String get cnLabelForm => 'સ્વરૂપ (લખ્યું હોય તેમ)';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages પાના',
      one: '1 પાનું',
    );
    return '$_temp0 · $size MB';
  }

  @override
  String get cnUploadConsent =>
      'અપલોડ કરવાથી આ પાના CoverNote સર્વર પર મોકલાય છે, જ્યાં એક AI સેવા તમારા માટે તેને વાંચે છે. તમે ગમે ત્યારે કેસ કાઢી નાખી શકો છો.';

  @override
  String get cnStageUploading => 'અપલોડ થઈ રહ્યું છે';

  @override
  String get cnUploadAndRead => 'અપલોડ કરો અને વાંચો';

  @override
  String cnPageN(int n) {
    return 'પાનું $n';
  }

  @override
  String cnPdfPages(int n, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count પાના',
      one: '1 પાનું',
    );
    return 'ફાઇલ $n · PDF, $_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return 'પાનું $n નો પ્રિવ્યૂ';
  }

  @override
  String get cnRotate => 'ફેરવો';

  @override
  String get cnRetake => 'ફરી લો';

  @override
  String get cnRemovePage => 'કાઢો';

  @override
  String get cnReorder => 'ક્રમ બદલવા ખેંચો';

  @override
  String get cnServiceUnavailableBody =>
      'પત્ર વાંચવાની સેવા હમણાં તૈયાર નથી. તમારા પાના સાચવ્યા છે; પછી ફરી પ્રયાસ કરો.';

  @override
  String get cnNeedNewPagesBody =>
      'વધુ સ્પષ્ટ ફોટા લો અથવા ઓછા પાના વાપરો, પછી ફરી અપલોડ કરો.';

  @override
  String get cnPagesKept => 'તમારા પાના સાચવ્યા છે. કશું બદલાયું નથી.';

  @override
  String get cnReplacePages => 'પાના બદલો';

  @override
  String get cnTryAgain => 'ફરી પ્રયાસ કરો';

  @override
  String get cnStageReading => 'વાંચી રહ્યા છીએ';

  @override
  String get cnStageChecking => 'તપાસી રહ્યા છીએ';

  @override
  String get cnStageReady => 'તૈયાર';

  @override
  String get cnReadingTitle => 'તમારો પત્ર વંચાઈ રહ્યો છે';

  @override
  String get cnReadingBody =>
      'પૂરું થાય ત્યારે, અમે જે શોધ્યું તેને તમે પત્ર સાથે મેળવીને તપાસો.';

  @override
  String get cnReadingLeaveOk =>
      'તમે આ સ્ક્રીન છોડી શકો છો. વાંચવાનું ચાલુ રહેશે અને તમારો કેસ સાચવ્યો છે.';

  @override
  String get cnStartReading => 'વાંચવાનું શરૂ કરો';

  @override
  String get cnStepLetter => 'પત્ર';

  @override
  String get cnStepReview => 'તપાસ';

  @override
  String get cnStepEvidence => 'રેકોર્ડ';

  @override
  String get cnStepPacket => 'કાગળોનું સેટ';

  @override
  String cnStepOf(int n, int total, String name) {
    return '$total માંથી પગલું $n: $name';
  }

  @override
  String get cnSaving => 'સાચવી રહ્યા છીએ…';

  @override
  String get cnSaved => 'સાચવ્યું';

  @override
  String get cnNotSavedRetry => 'સાચવ્યું નથી · ફરી પ્રયાસ';

  @override
  String get cnViewOriginal => 'મૂળ પાના જુઓ';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count પાના વંચાયા',
      one: '1 પાનું વંચાયું',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return 'વાંચવામાં મુશ્કેલ: પાનું $list. આ વિગતો ધ્યાનથી તપાસો અથવા પાનું ફરી લો.';
  }

  @override
  String get cnRetakePages => 'પાના ફરી લો';

  @override
  String get cnHardToRead => 'વાંચવામાં મુશ્કેલ';

  @override
  String get cnContinueToReview => 'તપાસ પર આગળ વધો';

  @override
  String get cnOriginalPages => 'મૂળ પાના';

  @override
  String get cnNoOriginal => 'મૂળ પાના સંગ્રહિત નથી.';

  @override
  String get cnCheckDetails => 'વિગતો તપાસો';

  @override
  String get cnCheckDetailsHint =>
      'દરેક વિગતને તમારા પત્ર સાથે સરખાવો. તે ક્યાંથી લીધી છે તે જોવા અવતરણ ટૅપ કરો.';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'આગળ વધવા વધુ $count વિગતો તપાસો',
      one: 'આગળ વધવા વધુ 1 વિગત તપાસો',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => 'રેકોર્ડ તરફ આગળ વધો';

  @override
  String cnSeePage(int n) {
    return 'પાનું $n જુઓ';
  }

  @override
  String get cnWhatLetterIs => 'આ પત્ર શું છે';

  @override
  String get cnLooksRight => 'બરાબર લાગે છે';

  @override
  String get cnChange => 'બદલો';

  @override
  String get cnCardWhyDenied => 'શા માટે નામંજૂર થયું';

  @override
  String get cnCardWhatTheyNeed => 'તેમણે શું માગ્યું';

  @override
  String get cnCardWhatItSays => 'પત્રમાં શું લખ્યું છે';

  @override
  String get cnNoReasonFound => 'પત્રમાં કોઈ કારણ મળ્યું નથી.';

  @override
  String get cnCardNextStep => 'આગળનું પગલું';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'તમારી સારવાર કરનાર ટીમને સમીક્ષા માટે વિનંતી કરવા કહો. પત્રમાં મોકલવાની $count વસ્તુઓ જણાવી છે.',
      one:
          'તમારી સારવાર કરનાર ટીમને સમીક્ષા માટે વિનંતી કરવા કહો. પત્રમાં મોકલવાની 1 વસ્તુ જણાવી છે.',
      zero:
          'તમારી સારવાર કરનાર ટીમને સમીક્ષા માટે વિનંતી કરવા કહો. પત્રમાં ચોક્કસ વસ્તુઓની યાદી નથી.',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'પ્લાને માગેલી $count વસ્તુઓ નીચેની તારીખ સુધીમાં મોકલો.',
      one: 'પ્લાને માગેલી 1 વસ્તુ નીચેની તારીખ સુધીમાં મોકલો.',
      zero: 'પ્લાને માગેલી માહિતી નીચેની તારીખ સુધીમાં મોકલો.',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth =>
      'હાલની મંજૂરી ક્યારે પૂરી થાય છે તે નોંધો અને તમારી સારવાર કરનાર ટીમને ફરી મંજૂરી (Reauthorization) શરૂ કરવા કહો.';

  @override
  String get cnNextFinal =>
      'આ અંતિમ નિર્ણય છે. CoverNote તેના માટે પહેલી સમીક્ષા વિનંતીનો અધૂરો લખાણ બનાવતું નથી. પત્રમાં જણાવેલા વિકલ્પો વિશે પ્લાન અથવા તમારી સારવાર કરનાર ટીમને પૂછો.';

  @override
  String get cnNextEob =>
      'આ બિલ અથવા લાભોની વિગત લાગે છે, નામંજૂરી (Denial) નહીં. તેને પ્લાનની સભ્ય સેવા (member services) સાથે તપાસો.';

  @override
  String get cnNextUncertain =>
      'પહેલા ઉપર, આ કયા પ્રકારનો પત્ર છે તેની પુષ્ટિ કરો.';

  @override
  String cnWhereToSend(String route) {
    return 'ક્યાં મોકલવું: $route';
  }

  @override
  String cnWhoToCall(String contact) {
    return 'સંપર્ક: $contact';
  }

  @override
  String get cnCardDate => 'તપાસવાની તારીખ';

  @override
  String cnDateCalculated(String anchor, int days) {
    return 'ગણતરી: $anchor + $days કૅલેન્ડર દિવસ (calendar days)';
  }

  @override
  String get cnReceivedDateWord => 'તમને મળ્યાની તારીખ';

  @override
  String get cnNoticeDateWord => 'નોટિસની તારીખ';

  @override
  String get cnDateEnteredByYou => 'તમે દાખલ કર્યું';

  @override
  String get cnDateFromLetter => 'પત્રમાં જણાવેલ';

  @override
  String cnReceivedOn(String date) {
    return 'તમને તે $date ના રોજ મળ્યો';
  }

  @override
  String get cnDatePassed =>
      'આ તારીખ વીતી ગઈ છે. તમે હજી શું કરી શકો તે પૂછવા પ્લાનને ફોન કરો.';

  @override
  String cnNeedReceivedDate(int days) {
    return 'પત્રમાં તમને મળ્યાના દિવસથી $days કૅલેન્ડર દિવસ (calendar days) આપ્યા છે. તે ક્યારે આવ્યો હતો?';
  }

  @override
  String get cnEnterReceivedDate => 'મળ્યાની તારીખ દાખલ કરો';

  @override
  String get cnDateConflict =>
      'પત્રમાં જુદી જુદી તારીખો આપી છે. કઈ લાગુ પડે છે તે પ્લાનને પૂછો, પછી તે પસંદ કરો.';

  @override
  String cnUseThisDate(String date) {
    return '$date વાપરો';
  }

  @override
  String get cnDateUnclear =>
      'શબ્દો સ્પષ્ટ નથી અથવા કામના દિવસ (business days) ગણે છે, તેથી CoverNote તેની ગણતરી કરતું નથી. ચોક્કસ તારીખ માટે પ્લાનને પૂછો.';

  @override
  String get cnNoDeadline =>
      'પત્રમાં સમીક્ષાની કોઈ છેલ્લી તારીખ (deadline) મળી નથી.';

  @override
  String cnReplyBy(String date) {
    return 'માહિતીની વિનંતીનો જવાબ $date સુધીમાં આપો (પત્રમાંથી)';
  }

  @override
  String get cnEnterDatePlanGave => 'તારીખ દાખલ કરો';

  @override
  String get cnUseLetterDate => 'પત્રની તારીખ વાપરો';

  @override
  String get cnLeaveUnknown => 'હમણાં અજાણી રાખો';

  @override
  String get cnDateUnknownChecked => 'અજાણી, નોંધ કરી';

  @override
  String get cnTypeAsWritten => 'પત્રમાં બતાવ્યું છે તેમ જ લખો.';

  @override
  String get cnCheckThisValue =>
      'આ કિંમત અસામાન્ય લાગે છે. તેને પત્ર સાથે સરખાવો.';

  @override
  String get cnDone => 'પૂરું';

  @override
  String get cnEdit => 'ફેરફાર કરો';

  @override
  String get cnAdd => 'ઉમેરો';

  @override
  String get cnNoRecordsToLink =>
      'જોડવા માટે છેલ્લા 30 દિવસનો કોઈ રેકોર્ડ નથી. આ વસ્તુ કોની પાસે છે તે તમે હજી ચિહ્નિત કરી શકો છો.';

  @override
  String cnLinkTitle(String label) {
    return 'આની સાથે રેકોર્ડ જોડો: $label';
  }

  @override
  String get cnLinkNote =>
      'તમારા પોતાના રેકોર્ડ વિનંતીને ટેકો આપે છે. તે દવાખાનાની નોંધો કે ટેસ્ટના પરિણામોની જગ્યા લેતા નથી.';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '$scheduled નક્કી કરેલા ડોઝમાંથી $taken લીધા / $notTaken ન લીધા / $unknown અજાણ્યા';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return 'જરૂર પડે ત્યારે: $uses ઉપયોગ, $puffs પફ (puff)';
  }

  @override
  String get cnNoEntries => 'કોઈ નોંધ નથી';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return '$days દિવસ લક્ષણો, $night દિવસ રાત્રે જાગવું ($total માંથી $entries દિવસની નોંધ)';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return '$total માંથી $days દિવસના PM2.5 આંકડા; $high દિવસ AQI 100 થી વધુ';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count જાતે જણાવેલી નોંધ',
      one: '1 જાતે જણાવેલી નોંધ',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => 'બનાવટી માહિતી';

  @override
  String get cnLetterAsksFor => 'પત્રમાં શું માગ્યું છે';

  @override
  String get cnNoItemsListed =>
      'પત્રમાં ચોક્કસ વસ્તુઓની યાદી નથી. તમે તમારી પોતાની ઉમેરી શકો છો.';

  @override
  String get cnAddItemLabel => 'ટ્રૅક કરવા માટે વસ્તુ ઉમેરો';

  @override
  String cnYourRecords(String from, String to) {
    return 'તમારા રેકોર્ડ ($from – $to)';
  }

  @override
  String get cnLocalContextNote =>
      'વૈકલ્પિક. આ બહારના પરિબળો છે. ઘરની અંદરનું માપ કે લક્ષણોનું કારણ નથી.';

  @override
  String get cnContinueToPacket => 'કાગળોના સેટ પર આગળ વધો';

  @override
  String get cnAddedByYou => 'તમે ઉમેર્યું';

  @override
  String get cnFromLetter => 'પત્રમાંથી';

  @override
  String cnWhoHasIt(String who) {
    return 'તે કોની પાસે છે: $who';
  }

  @override
  String cnLinkedTo(String record) {
    return 'જોડ્યું: $record';
  }

  @override
  String get cnSeeInLetter => 'પત્રમાં જુઓ';

  @override
  String get cnLinkRecords => 'મારા રેકોર્ડ જોડો';

  @override
  String get cnOtherStatus => 'અન્ય સ્થિતિ';

  @override
  String get cnInPacket => 'કાગળોના સેટમાં';

  @override
  String get cnRemoveFromPacket => 'કાગળોના સેટમાંથી કાઢો';

  @override
  String get cnAddToPacket => 'કાગળોના સેટમાં ઉમેરો';

  @override
  String get cnErrNotSavedYet =>
      'તમારા તાજેતરના ફેરફાર હજી સાચવ્યા નથી. તમારું કનેક્શન તપાસો અને ફરી પ્રયાસ કરો.';

  @override
  String get cnPacketChangedMeanwhile =>
      'કાગળોનું સેટ બનતું હતું ત્યારે વિગતો અથવા રેકોર્ડ બદલાયા. તેને ફરી બનાવો.';

  @override
  String get cnPacketFailed => 'કાગળોનું સેટ બનાવી શકાયું નથી. ફરી પ્રયાસ કરો.';

  @override
  String get cnBeforeSharingTitle => 'શેર કરતા પહેલાં';

  @override
  String get cnBeforeSharingBody =>
      'આ ફાઇલમાં તમારું નામ અને સ્વાસ્થ્યની વિગતો છે. તેને ફક્ત તમારી સારવાર કરનાર ટીમ અથવા તમારા પ્લાન સાથે જ શેર કરો. શેર કરવાથી તમારા વતી કશું જમા થતું નથી.';

  @override
  String get cnShare => 'શેર કરો';

  @override
  String get cnMethodFax => 'ફૅક્સ';

  @override
  String get cnMethodMail => 'ટપાલ';

  @override
  String get cnMethodPortal => 'ઑનલાઇન પોર્ટલ';

  @override
  String get cnMethodInPerson => 'રૂબરૂ';

  @override
  String get cnMethodCareTeam => 'સારવાર કરનાર ટીમે મોકલ્યું';

  @override
  String get cnMethodOther => 'અન્ય';

  @override
  String get cnPacketNoDraftFinal =>
      'અંતિમ નિર્ણય માટે, કાગળોના સેટમાં ફક્ત ડૉક્ટર માટેનો સારાંશ હોય છે. પહેલા સ્તરની સમીક્ષાનો અધૂરો લખાણ બનતો નથી.';

  @override
  String get cnPacketNoDraftEob =>
      'બિલ અથવા લાભોની વિગત (Explanation of Benefits) માટે, કાગળોના સેટમાં ફક્ત ડૉક્ટર માટેનો સારાંશ હોય છે.';

  @override
  String get cnPacketNoDraftReauth =>
      'ફરી મંજૂરીની નોટિસ (Reauthorization) માટે, કાગળોના સેટમાં ફક્ત ડૉક્ટર માટેનો સારાંશ હોય છે, જે તમારી સારવાર કરનાર ટીમને ફરી મંજૂરીમાં મદદ કરે.';

  @override
  String get cnPacketNoDraftOther =>
      'જ્યાં સુધી પત્ર નામંજૂરી (Denial) અથવા માહિતીની વિનંતી ન હોય, ત્યાં સુધી કાગળોના સેટમાં ફક્ત ડૉક્ટર માટેનો સારાંશ હોય છે.';

  @override
  String get cnPacketContains => 'આ કાગળોના સેટમાં શામેલ હશે';

  @override
  String get cnPartSummary => 'ડૉક્ટર માટે સારાંશ (1 પાનું)';

  @override
  String get cnPartDraft =>
      'સમીક્ષા વિનંતીનો ડ્રાફ્ટ (તમારી સારવાર કરનાર ટીમ પૂરો કરશે)';

  @override
  String get cnPartLetterText => 'પરિશિષ્ટ: પત્રનું લખાણ';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count રેકોર્ડ સારાંશ ઉમેર્યા',
      one: '1 રેકોર્ડ સારાંશ ઉમેર્યો',
      zero: 'કોઈ રેકોર્ડ સારાંશ ઉમેર્યો નથી',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => 'પત્રનું લખાણ પરિશિષ્ટ તરીકે ઉમેરો';

  @override
  String get cnPacketStale =>
      'છેલ્લા કાગળોના સેટ પછી વિગતો અથવા રેકોર્ડ બદલાયા. અપડેટ કરવા તેને ફરી બનાવો.';

  @override
  String get cnGenerating => 'બનાવી રહ્યા છીએ…';

  @override
  String get cnGeneratePacket => 'સમીક્ષા માટે કાગળોનું સેટ બનાવો';

  @override
  String get cnSaveOrPrint => 'સાચવો અથવા પ્રિન્ટ કરો';

  @override
  String get cnISentIt => 'મેં મોકલ્યું';

  @override
  String cnSharedOn(String date) {
    return '$date ના રોજ શેર કર્યું';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return 'તમે $date ના રોજ ($method) મોકલ્યાનું જણાવ્યું';
  }

  @override
  String get cnTabDoctorSummary => 'ડૉક્ટર માટે સારાંશ';

  @override
  String get cnTabReviewDraft => 'સમીક્ષા વિનંતીનો અધૂરો લખાણ';

  @override
  String get cnSentExplain =>
      'ક્યારે અને કેવી રીતે મોકલ્યું તે નોંધો. CoverNote તેને મોકલતું નથી અને નિર્ણય શું થયો તે જોતું નથી.';

  @override
  String get cnSave => 'સાચવો';

  @override
  String get cnCtxPm25 => 'PM2.5 (AQI)';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => 'બહારનો ભેજ';

  @override
  String cnObservedOn(String date) {
    return '$date ના રોજ નોંધ્યું';
  }

  @override
  String get cnCtxIntro =>
      'કોઈ નામવાળા સ્ત્રોતના હવાના માપ અને તમે જે નોંધ્યું તે, અલગ રાખેલા. તે તમારા રેકોર્ડ સમજાવવામાં મદદ કરે તો જ કેસમાં ઉમેરો.';

  @override
  String get cnCtxReadings => 'હવાના માપ';

  @override
  String get cnCtxReadingsNote =>
      'જે દિવસે નોંધાયા તે દિવસના પ્રાદેશિક માપ. તે તમારા ઘરે વાહનોના ધુમાડાનું માપ નથી.';

  @override
  String get cnCtxAddReading => 'માપ ઉમેરો';

  @override
  String get cnCtxReports => 'તમે જે નોંધ્યું';

  @override
  String get cnCtxReportsNote => 'તમારી પોતાની નોંધ. તે માપણી નથી.';

  @override
  String get cnCtxAddReport => 'તમે જે નોંધ્યું તે ઉમેરો';

  @override
  String get cnReportExhaust => 'નજીકમાં વાહનોનો ધુમાડો ખૂબ';

  @override
  String get cnReportWater => 'ઘરમાં પાણી ઘૂસ્યું';

  @override
  String get cnReportDamp => 'ઘરના અંદરનો ભાગ ભીનો કે વાસવાળો';

  @override
  String cnOnDate(String date) {
    return 'તારીખ: $date';
  }

  @override
  String get cnNoteOptional => 'નોંધ (વૈકલ્પિક)';

  @override
  String get cnCtxWhat => 'માપ';

  @override
  String get cnCtxHumidityNote =>
      'બહારનો ભેજ હવામાનનો ડેટા છે. તે તમારા ઘરની અંદરની ભીનાશ કે ફૂગ બતાવતો નથી.';

  @override
  String get cnCtxValue => 'કિંમત';

  @override
  String get cnCtxValueInvalid => 'માન્ય નંબર દાખલ કરો.';

  @override
  String get cnCtxSource => 'સ્ત્રોત';

  @override
  String get cnCtxSourceHelp =>
      'નંબર ક્યાંથી આવ્યો, ઉદાહરણ તરીકે AirNow અથવા સ્થાનિક મોનિટર';

  @override
  String get cnCtxSourceRequired => 'સ્ત્રોત ઉમેરો.';

  @override
  String get cnCtxPlace => 'જગ્યા (વૈકલ્પિક)';

  @override
  String get cnRecordsSignInBody =>
      'દવા, લક્ષણો અને પર્યાવરણના પરિબળોની નોંધ રાખવા સાઇન ઇન કરો.';

  @override
  String get cnRecordsYourRecords => 'તમારા રેકોર્ડ';

  @override
  String get cnRecMedicationSub => 'તમે લો છો તે દવાઓ અને ડોઝ';

  @override
  String get cnRecDailyLog => 'રોજની નોંધ';

  @override
  String get cnRecDailyLogSub => 'લક્ષણો અને ઇન્હેલરનો ઉપયોગ';

  @override
  String get cnRecLocalContextSub => 'હવાના માપ અને તમે જે નોંધ્યું';

  @override
  String get cnHelp => 'મદદ';

  @override
  String get cnUrgentHelp => 'તાત્કાલિક મદદ';

  @override
  String get cnUrgentHelpSub => 'શ્વાસની કટોકટી માટેના પગલાં અને 911 પર કૉલ';

  @override
  String cnLast30Days(String from, String to) {
    return 'Last 30 days ($from – $to)';
  }

  @override
  String get cnNoSchedule => 'કોઈ નિયમિત સમયપત્રક નક્કી નથી';

  @override
  String get cnRecordsUnknownNote =>
      'નોંધ વગરના દિવસો અજાણ્યા રહે છે. તેમને ચૂકી ગયેલા ગણવામાં આવતા નથી.';

  @override
  String get cnDeleteAccountTitle => 'તમારું એકાઉન્ટ કાઢી નાખવું છે?';

  @override
  String get cnDeleteAccountBody =>
      'આનાથી તમારું એકાઉન્ટ, કેસ, અપલોડ કરેલા પત્રો, કાગળોના સેટ અને રેકોર્ડ કાયમ માટે કાઢી નંખાશે. તેને પાછું લાવી શકાતું નથી.';

  @override
  String get cnTypeDelete => 'પુષ્ટિ માટે DELETE લખો';

  @override
  String get cnDeleteAccount => 'એકાઉન્ટ કાઢી નાખો';

  @override
  String get cnAccountDeleted => 'તમારું એકાઉન્ટ કાઢી નાખ્યું.';

  @override
  String get cnDeleteAccountFailed =>
      'એકાઉન્ટ કાઢી શકાયું નથી. પછી ફરી પ્રયાસ કરો.';

  @override
  String get cnAccountSignedOut => 'તમે સાઇન ઇન નથી.';

  @override
  String get cnLanguage => 'ભાષા';

  @override
  String get cnServiceStatus => 'પત્ર વાંચવાની સેવા';

  @override
  String get cnServiceReady => 'ઉપલબ્ધ';

  @override
  String get cnServiceUnavailableShort => 'હમણાં ઉપલબ્ધ નથી';

  @override
  String get cnChecking => 'તપાસી રહ્યા છીએ…';

  @override
  String get cnServiceUnknown => 'તપાસ્યું નથી';

  @override
  String get cnCheck => 'તપાસો';

  @override
  String get cnAbout => 'વિશે';

  @override
  String get cnAboutBody =>
      'CoverNote તમને દવાઓ વિશેના ઇન્સ્યોરન્સના પત્રો વાંચવામાં અને તમારી સારવાર કરનાર ટીમ માટે કાગળો તૈયાર કરવામાં મદદ કરે છે. તે તમારા પ્લાન પાસે કશું જમા કરતું નથી, કવરેજનો નિર્ણય કરતું નથી, અને તબીબી સલાહ નથી.';

  @override
  String get cnDangerZone => 'એકાઉન્ટ કાઢી નાખો';

  @override
  String get cnErrServiceUnavailable => 'પત્ર વાંચવાની સેવા હમણાં ઉપલબ્ધ નથી.';

  @override
  String get cnErrBusy =>
      'સેવા વ્યસ્ત છે. એક મિનિટ રાહ જુઓ અને ફરી પ્રયાસ કરો.';

  @override
  String get cnErrSlow => 'વાંચવામાં ખૂબ સમય લાગ્યો. ફરી પ્રયાસ કરો.';

  @override
  String get cnErrUnreadable =>
      'પાના વાંચી શકાયા નથી. વધુ સારા અજવાળામાં ફરી લો.';

  @override
  String get cnErrTooManyPages => 'ઘણા બધા પાના. વધુમાં વધુ 10 અપલોડ કરો.';

  @override
  String get cnErrTooLarge => 'ફાઇલો ખૂબ મોટી છે. ઓછા અથવા નાના પાના વાપરો.';

  @override
  String get cnErrStale =>
      'આ કેસ બીજા ડિવાઇસ પર બદલાયો. નવીનતમ વર્ઝન બતાવી રહ્યા છીએ.';

  @override
  String get cnErrCaseGone => 'આ કેસ હવે અસ્તિત્વમાં નથી.';

  @override
  String get cnErrAttempts =>
      'વાંચવાનું ઘણી વાર નિષ્ફળ ગયું. પાના બદલો અથવા પછી ફરી પ્રયાસ કરો.';

  @override
  String get cnErrDemoUpload =>
      'ડેમો ફાઇલો વાંચી શકતો નથી. તમારો પોતાનો પત્ર સ્કૅન કરવા સાઇન ઇન કરો.';

  @override
  String cnErrGeneric(String code) {
    return 'કંઈક ખોટું થયું ($code). ફરી પ્રયાસ કરો.';
  }

  @override
  String get cnLanguageChoose => 'તમારી ભાષા પસંદ કરો';

  @override
  String get cnLanguageNote =>
      'કેટલાક શબ્દો સોફ્ટવેરે અનુવાદ કર્યા છે અને તેમાં ભૂલ હોઈ શકે છે. દવાનું નામ અને ડોઝ લખ્યા મુજબ રહે છે. પત્રની બાકીની વિગતો અનુવાદમાં બતાવાય છે.';

  @override
  String get cnLanguageButtonTooltip => 'ભાષા બદલો';

  @override
  String get cnPacketEnglishNote =>
      'કાગળોનું સેટ અંગ્રેજીમાં લખેલું છે, જેથી તમારી સારવાર કરનાર ટીમ તેને વાંચી શકે.';

  @override
  String get cnReasonMissingInformation =>
      'પ્લાન કહે છે કે તેને જરૂરી બધી માહિતી મળી નથી.';

  @override
  String get cnReasonStepTherapy =>
      'પ્લાન ઇચ્છે છે કે તમે પહેલા બીજી દવાઓ અજમાવો (Step therapy).';

  @override
  String get cnReasonMedicalNecessity =>
      'પ્લાન કહે છે કે આ દવા તબીબી રીતે જરૂરી છે, એવી પુષ્ટિ તે કરી શક્યું નથી (Medical necessity).';

  @override
  String get cnReasonFormulary =>
      'પ્લાન કહે છે કે આ દવા, જે દવાઓ કવર થાય છે તે યાદીમાં નથી (Formulary).';

  @override
  String get cnReasonQuantityLimit =>
      'પ્લાન કહે છે કે જેટલી દવા માગી છે તે, પ્લાન જેટલું કવર કરે છે તેનાથી વધુ છે.';

  @override
  String get cnReasonEligibility =>
      'પ્લાન કહે છે કે તેના કવરેજના નિયમો પ્રમાણે આ કવર થતું નથી.';

  @override
  String get cnReasonOther =>
      'પત્રમાં બીજું કારણ આપ્યું છે. તે વાંચવા પત્રમાંથી અવતરણ ખોલો.';

  @override
  String get cnReqHintMedHistory => 'તમારી ભૂતકાળની અને હાલની દવાઓ';

  @override
  String get cnReqHintVisitNotes => 'તમારા ડૉક્ટરની મુલાકાતની નોંધો';

  @override
  String get cnReqHintTestResults => 'ટેસ્ટ અથવા લૅબના પરિણામો';

  @override
  String get cnReqHintDoctorStatement => 'તમારા ડૉક્ટરનું નિવેદન';

  @override
  String get cnTabSettings => 'ગોઠવણીઓ';

  @override
  String get cnCasesList => 'કેસની યાદી';

  @override
  String get cnGoHome => 'મુખ્ય';

  @override
  String get cnAnalyzingTitle => 'વીમાનો પત્ર · વાંચી રહ્યા છીએ';

  @override
  String cnCaseNumber(String n) {
    return 'કેસ #$n';
  }

  @override
  String cnAddedAt(String when) {
    return '$when ઉમેર્યું';
  }

  @override
  String get cnAliasHint => 'ટૂંકું નામ (વૈકલ્પિક)';

  @override
  String get cnShareDocuments => 'કાગળો મોકલો';

  @override
  String get cnRecordDelivery => 'મોકલ્યાની નોંધ કરો';

  @override
  String get cnShareAsk => 'શું તમે આ કાગળો મોકલ્યા?';

  @override
  String get cnDeliveryRecipient => 'કોને મોકલ્યા';

  @override
  String get cnRecipientClinic => 'ક્લિનિક અથવા ડૉક્ટર';

  @override
  String get cnRecipientInsurer => 'વીમા પ્લાન';

  @override
  String get cnRecipientSelf => 'મારી પાસે રાખ્યા';

  @override
  String get cnRecipientOther => 'અન્ય';

  @override
  String get cnDeliveryMethod => 'કેવી રીતે';

  @override
  String get cnMethodEmail => 'ઈમેઇલ';

  @override
  String get cnMethodMessage => 'મેસેજ અથવા ચેટ';

  @override
  String get cnMethodUnknown => 'યાદ નથી';

  @override
  String get cnDeliveryUserReport =>
      'આ તમે જણાવ્યું તે છે. બીજી બાજુએ મળ્યું કે નહીં, એ એપ ચકાસી શકતી નથી.';

  @override
  String get cnShareCancelled =>
      'મોકલવાનું રદ થયું. મોકલ્યું તેમ નોંધાયું નથી.';

  @override
  String get cnRecordsLoading => 'રેકોર્ડ લાવી રહ્યા છીએ…';

  @override
  String get cnRecordsEmpty => 'આ સમયગાળામાં રેકોર્ડ નથી';

  @override
  String get cnRecordsError => 'રેકોર્ડ લાવી શક્યા નહીં';

  @override
  String get cnRecordsPermission => 'આ રેકોર્ડ જોવાની તમને પરવાનગી નથી';

  @override
  String get cnRecordsPending => 'આ ફોનમાં સેવ થયું · સિંકની રાહ';

  @override
  String get cnRecordsFiltered =>
      'તમારા ફિલ્ટરને કારણે કેટલાક રેકોર્ડ છુપાયેલા છે';

  @override
  String cnRecordsOutside(int n) {
    return 'આ સમયગાળા બહારના $n રેકોર્ડ';
  }

  @override
  String get cnWidenRange => 'વધુ લાંબો સમય બતાવો';

  @override
  String cnLinkedSummary(int days, int med, int sym) {
    return '$days દિવસ · દવા $med વાર · લક્ષણ $sym નોંધ';
  }

  @override
  String get cnOneDayPacket => 'આ કાગળો એક જ દિવસના છે.';

  @override
  String get cnMyMedications => 'મારી દવાઓ';

  @override
  String get cnScanLabel => 'દવાનું લેબલ સ્કૅન કરો';

  @override
  String get cnMedManageHint =>
      'તમે વાપરો છો તે દવાઓ નોંધાવો. પ્રિસ્ક્રિપ્શન બદલાય તો સુધારો. રોજની વપરાશ રેકોર્ડમાં લખાય છે.';

  @override
  String get cnLabelNeedLabel =>
      'ફાર્મસીના લેબલ અથવા ડબ્બા પરનું લખાણ ફોટો કરો. ગોળીના આકારથી એપ દવા ઓળખતી નથી.';

  @override
  String get cnLabelUnclear => 'આ વિગત સ્પષ્ટ ન હતી. સેવ કરતાં પહેલાં તપાસો.';

  @override
  String get cnConsentLabel => 'દવાનું લેબલ AI વાંચે તેની મંજૂરી આપો';

  @override
  String get cnManualMed => 'જાતે લખો';

  @override
  String get cnAirWeather => 'તમારી આસપાસના પર્યાવરણના પરિબળો';

  @override
  String get cnAirAutoNote =>
      'હવાની ગુણવત્તા, ટ્રાફિક સાથે જોડાયેલી હવા, પરાગ, પૂરની ચેતવણી અને બહારની ભેજ તમારા સ્થાન પરથી આવે છે. ફોન હવા માપતો નથી. બહારની ભેજ ઘરની અંદરનો ફૂગ નથી.';

  @override
  String get cnHomeRecords => 'સંબંધિત દવાની નોંધ';

  @override
  String get cnEnvTrap => 'ટ્રાફિક સાથે જોડાયેલી હવા';

  @override
  String get cnItemMemo => 'નોંધ';

  @override
  String get cnSaveNote => 'નોંધ સાચવો';

  @override
  String get cnLocationNeed =>
      'આસપાસના પર્યાવરણના પરિબળો જોવા સ્થાનની પરવાનગી આપો.';

  @override
  String get cnLocationOff => 'સ્થાન સેવા બંધ છે. ચાલુ કરીને ફરી પ્રયાસ કરો.';

  @override
  String get cnLocationBlocked => 'સ્થાન અટકાવેલું છે. સેટિંગમાં પરવાનગી આપો.';

  @override
  String get cnOpenSettings => 'સેટિંગ ખોલો';

  @override
  String get cnAirNone => 'હવા કે હવામાનની માહિતી નથી';

  @override
  String get cnAirRetry => 'હવા અને હવામાન ફરી અજમાવો';

  @override
  String get cnSetRegion => 'Set your area (ZIP or city)';

  @override
  String get cnConfiguredArea => 'Area you set';

  @override
  String get cnRecordPlace => 'આ રેકોર્ડનું સ્થળ';

  @override
  String get cnClosestObservation => 'Closest observation to the record time';

  @override
  String get cnEnvUnavailable => 'એ સમયે મળતું માપ નથી';

  @override
  String cnLogMedication(String name) {
    return '$name નોંધો';
  }

  @override
  String get cnAsNeededUse => 'જરૂર પડે ત્યારે';

  @override
  String get cnAsNeededInhaler => 'As-needed inhaler use';

  @override
  String get cnScheduledUse => 'નિયમિત સમયે';

  @override
  String get cnExtraUse => 'વધારાનો ઉપયોગ';

  @override
  String get cnUndoUse => 'પાછું લો';

  @override
  String get cnLoggedLocal => 'આ ફોનમાં સેવ થયું';

  @override
  String get cnLoggedPending => 'સિંકની રાહ';

  @override
  String get cnLoggedSynced => 'સિંક થયું';

  @override
  String cnDaysLogged(int n) {
    return 'આ અઠવાડિયે $n દિવસ નોંધાયું';
  }

  @override
  String get cnManageMedsLink => 'મારી દવાઓ સંભાળો';

  @override
  String get cnViewAirWeather => 'View environmental factors near you';

  @override
  String get cnConsentAi => 'દસ્તાવેજ AI વાંચે તેની મંજૂરી આપો';

  @override
  String get cnConsentAiBody =>
      'પત્રની છબી વાંચવાની સેવા પર જાય છે, જેથી CoverNote તમને લખાણ બતાવી શકે. પછીથી ગોઠવણીઓમાં બંધ કરી શકો છો.';

  @override
  String get cnConsentAndAnalyze => 'સંમત થાઓ અને વાંચો';

  @override
  String get cnConsentLater => 'હમણાં નહીં';

  @override
  String get cnConsentViewLocal => 'મૂળ અહીં જુઓ';

  @override
  String get cnConsentDetails => 'ડેટાના ઉપયોગ વિશે વધુ';

  @override
  String get cnConsentLabelPurpose => 'દવાનું લેબલ વાંચવું';

  @override
  String get cnConsentLetterPurpose => 'વીમાનો પત્ર વાંચવો';

  @override
  String get cnConsentTranslatePurpose => 'પત્રનો અનુવાદ';

  @override
  String get cnToday => 'આજે';

  @override
  String get cnLast7 => 'છેલ્લા 7 દિવસ';

  @override
  String get cnLast30 => 'છેલ્લા 30 દિવસ';

  @override
  String get cnCustomRange => 'તારીખ પસંદ કરો';

  @override
  String cnRangeSummary(String from, String to, int days, int count) {
    return '$from–$to · $days દિવસ · $count રેકોર્ડ';
  }

  @override
  String get cnNoRecordThatDay => 'આ દિવસે રેકોર્ડ નથી';

  @override
  String get cnNotLogged => 'નોંધાયું નથી';

  @override
  String get cnNotTaken => 'લીધી નહીં તેમ નોંધ્યું';

  @override
  String get cnOriginalFile => 'મૂળ ફાઇલ';

  @override
  String get cnFullTranslation => 'આખો અનુવાદ';

  @override
  String get cnRecognizedText => 'ઓળખાયેલું લખાણ';

  @override
  String get cnSameLanguage => 'મૂળ જેવી જ ભાષા';

  @override
  String get cnTranslationPartial => 'કેટલાક પાનાં હજુ અનુવાદિત નથી';

  @override
  String get cnTranslationFailed => 'આ પાનું અનુવાદ થઈ શક્યું નહીં';

  @override
  String get cnOriginalMissing => 'મૂળ ફાઇલ મળી નથી. તમે ફરી અપલોડ કરી શકો છો.';

  @override
  String get cnTranslateRetry => 'અનુવાદ ચાલુ રાખો';

  @override
  String get cnKeyDetails => 'મુખ્ય વિગતો';

  @override
  String get cnWhatAbout => 'આ શેના વિશે છે?';

  @override
  String get cnWhatToDo => 'હવે શું કરવું';

  @override
  String get cnByWhen => 'ક્યાં સુધીમાં?';

  @override
  String get cnPreparePacket => 'કાગળો તૈયાર કરો';

  @override
  String get cnCorrectReading => 'વાંચવામાં ભૂલ સુધારો';

  @override
  String get cnCorrectReadingNote =>
      'મૂળ પત્ર બદલાતો નથી. ફક્ત આપમેળે વંચાયેલું સુધરે છે.';

  @override
  String get cnReviewImportant =>
      'કાગળો બનાવતાં પહેલાં આ મહત્ત્વની વિગતો તપાસો';

  @override
  String get cnPacketReadyTitle => 'તમારા કાગળો તૈયાર છે';

  @override
  String get cnNextSendClinic => 'કાગળો તમારા ડૉક્ટરને મોકલીને તપાસવા કહો';

  @override
  String get cnNextWaitReply => 'જવાબ આવે ત્યારે પરિણામ નોંધો';

  @override
  String get cnExistingSentNewReady =>
      'પહેલાંના કાગળો મોકલાયા · નવું સેટ બનાવી શકો છો';

  @override
  String get cnWhyRecords =>
      'દવા અને લક્ષણની નોંધ ડૉક્ટરને સારવાર કેવી ચાલે છે તે જોવામાં મદદ કરે. રેકોર્ડ ન હોય તો પણ પત્ર પરથી કાગળો બનાવી શકો છો.';

  @override
  String get cnLetterAskedRecords => 'પત્રમાં તાજેતરની સારવારની નોંધ માગી છે';

  @override
  String get cnOptionalReference => 'વૈકલ્પિક સંદર્ભ';

  @override
  String get cnAsthmaContext =>
      'અસ્થમાની સારવારની નોંધ — નિયમિત વખતે, જરૂર પડે ત્યારે, અને શ્વાસના લક્ષણો.';

  @override
  String get cnGeneralContext =>
      'સારવારની નોંધ — દવાનો ઉપયોગ અને લક્ષણો અથવા નોંધ.';

  @override
  String get cnTreatmentQuestion => 'આ પત્ર કઈ સારવાર વિશે છે?';

  @override
  String get cnTreatmentAsthma => 'અસ્થમા';

  @override
  String get cnTreatmentOther => 'બીજી સારવાર';

  @override
  String get cnTreatmentUnknown => 'હજુ ખબર નથી';

  @override
  String get cnStatusWaitingClinic => 'ક્લિનિકને મોકલ્યું · તપાસની રાહ';

  @override
  String get cnStatusWaitingInsurer =>
      'પ્લાનને આપ્યું તેમ નોંધ્યું · જવાબની રાહ';

  @override
  String get cnFollowUpNeeded => 'આગળની કામગીરી બાકી';

  @override
  String get cnOutcomeRecorded => 'પરિણામ નોંધાયું';

  @override
  String get cnActiveCases => 'ચાલુ છે';

  @override
  String get cnCompletedArchived => 'પૂરા અને સંગ્રહિત';

  @override
  String get cnCompleteCase => 'આ કેસ પૂરો કરો';

  @override
  String get cnArchiveCase => 'સંગ્રહ કરો';

  @override
  String get cnReopenCase => 'ફરી ચાલુ કરો';

  @override
  String get cnOutcomeApproved => 'મંજૂર';

  @override
  String get cnOutcomeDenied => 'નામંજૂર';

  @override
  String get cnOutcomeStopped => 'આગળ નહીં';

  @override
  String get cnOutcomeOther => 'અન્ય / નોંધાયું નથી';

  @override
  String get cnSentIsNotComplete => 'મોકલવું એ કેસ પૂરો થવું નથી.';

  @override
  String get cnArchivedCase => 'સંગ્રહિત';

  @override
  String get cnStepKeyDetails => 'મુખ્ય વિગતો';

  @override
  String get cnStepAddRecords => 'મારા રેકોર્ડ ઉમેરો';

  @override
  String get cnStepReviewPacket => 'કાગળો તપાસો';

  @override
  String get cnDataConsent => 'ડેટાની પ્રક્રિયા';

  @override
  String get cnZipOrCity => 'ZIP or city';

  @override
  String get cnSaveArea => 'Save area';

  @override
  String get cnWeekCalendar => 'આ અઠવાડિયું';

  @override
  String get cnMonthCalendar => 'આ મહિનો';

  @override
  String get cnUsedShort => 'વાપર્યું';

  @override
  String get cnCalendarLegend =>
      'બિંદુ એટલે એ દિવસે નોંધ છે. ખાલી દિવસ એ ચૂકી ગયેલી દવા નથી.';
}
