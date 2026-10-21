// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Haitian Haitian Creole (`ht`).
class AppLocalizationsHt extends AppLocalizations {
  AppLocalizationsHt([String locale = 'ht']) : super(locale);

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginEmailLabel => 'Imèl';

  @override
  String get loginPasswordLabel => 'Modpas';

  @override
  String get loginButton => 'Konekte';

  @override
  String get signUpButton => 'Enskri';

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
  String get medicationLogAddButton =>
      'Anrejistre itilizasyon inalatè / medikaman';

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
  String get settingsTitle => 'Paramèt';

  @override
  String get settingsLanguageLabel => 'Lang';

  @override
  String get settingsLocationLabel => 'Location';

  @override
  String get notificationAttackWarningTitle => 'Asthma Attack Risk Alert';

  @override
  String get mockContinue => 'Kontinye';

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
  String get mockUnlock => 'Debloke';

  @override
  String get mockUsePassword => 'Itilize modpas la olye';

  @override
  String get mockOnboardingTitle => 'Patient setup';

  @override
  String get mockHomeLocation => 'Kay';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => 'Kontak ijans';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => 'Kòd envitasyon founisè';

  @override
  String get mockFinishOnboarding => 'Go to home';

  @override
  String get mockAllScreens => 'Tout ekran';

  @override
  String get mockAllScreensHint => 'Open any Screen ID for design review';

  @override
  String get mockStateCalm => 'KALM';

  @override
  String get mockStateWarning => 'AVÈTISMAN';

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
  String get mockForecast => 'Previzyon';

  @override
  String get mockForecastHint => 'Next days air & pollen outlook';

  @override
  String get mockAlertPreview => 'Alert landing';

  @override
  String get mockAlertPreviewHint => 'Preview risk alert screen';

  @override
  String get mockShowWarningHome => 'Gade paj akèy AVÈTISMAN';

  @override
  String get mockBackToCalmHome => 'Retounen';

  @override
  String get mockPanicCta => 'Panic mode';

  @override
  String get mockTrapAxis => 'TRAP / swi';

  @override
  String get mockFloodAxis => 'Inondasyon toudenkou';

  @override
  String get mockPollenAxis => 'Polèn';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · Pollen outlook';

  @override
  String get mockActSurvey => 'Sondaj ACT';

  @override
  String get mockActHint => '5 kesyon ak imaj (4 semèn)';

  @override
  String get mockPdcCheck => 'Verifikasyon PDC chak jou';

  @override
  String get mockPdcHint => 'Swiv tretman ak yon sèl tap';

  @override
  String get mockInhalerEvent => 'Inalatè anrejistre';

  @override
  String get mockActIntro =>
      'Answer based on the last 4 weeks. Design preview — answers are not saved.';

  @override
  String get mockQuestion => 'Kesyon';

  @override
  String get mockSubmit => 'Voye';

  @override
  String get mockPdcPrompt => 'Èske ou te pran medikaman kontwòl ou jodi a?';

  @override
  String get mockTakenYes => 'Wi, mwen te pran l';

  @override
  String get mockTakenNo => 'Pa jodi a';

  @override
  String get mockEvidenceSummary => 'Your evidence summary';

  @override
  String get mockEvidenceBody =>
      'Dummy summary for PA/LMN support. Design preview only.';

  @override
  String get mockInhalerEvents30d => 'Inhaler events (30d)';

  @override
  String get mockActScore => 'Dènye ACT';

  @override
  String get mockPdcRate => 'PDC (30 jou)';

  @override
  String get mockLocationsTitle => 'Kote ou sove';

  @override
  String get mockLocationsHint => 'Siveyans kay ak travay';

  @override
  String get mockWorkLocation => 'Travay';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => 'Ajoute yon kote';

  @override
  String get mockRewardTitle => 'Rewards';

  @override
  String get mockDraftBanner =>
      'BWOUYON — pwen ak bon yo se sèlman yon previzyon';

  @override
  String get mockPointsBalance => 'Balans pwen';

  @override
  String get mockVoucherTitle => 'Bon labank manje';

  @override
  String get mockVoucherHint => 'Exchange points (waitlist)';

  @override
  String get mockDonateTitle => 'Fè yon don';

  @override
  String get mockDonateHint => 'Don atravè yon twazyèm pati sèlman';

  @override
  String get mockRewardHistory => 'Istwa';

  @override
  String get mockRewardHistoryHint => 'Pwen ak don';

  @override
  String get mockDummyFoodBank => 'Bank Manje Kominote NJ (demo)';

  @override
  String get mockVoucherCost => '50 pwen · valè \$10 (bwouyon)';

  @override
  String get mockJoinWaitlist => 'Antre sou lis datant';

  @override
  String get mockDonateTransparency =>
      'Don yo pase atravè yon platfòm òganizasyon san bi likratif ki verifye, ki se yon twazyèm pati. Howse Asthma pa janm kenbe detay kat.';

  @override
  String get mockDonateCta => 'Louvri paj don (ekstèn)';

  @override
  String get mockExternalOnly =>
      'Founisè don ekstèn lan pa konekte nan previzyon konsepsyon an.';

  @override
  String get mockSignOutPreview => 'Dekonekte (previzyon)';

  @override
  String get mockOpenAuthFlow => 'Open auth flow';

  @override
  String get mockAlertBody =>
      'Risk rose near your location. Review environment details.';

  @override
  String get mockDismiss => 'Fèmen';

  @override
  String get mockPanicTitle => 'Need help now?';

  @override
  String get mockPanicStep1Body =>
      'Etap 1 — Rete ak inalatè ou. Kontinye pou wè kontak ijans yo.';

  @override
  String get mockPanicStep2Title => 'Rele pou jwenn èd';

  @override
  String get mockPanicStep2Body =>
      'Previzyon konsepsyon: bouton yo pa fè yon vrè apèl. Sou vèsyon ki enstale sou aparèy la, Etap 2 itilize lyen tel:.';

  @override
  String get mockCall911 => 'Rele 911';

  @override
  String get mockCallGuardian => 'Rele kontak ijans';

  @override
  String get mockFeelingBetter => 'Mwen santi mwen pi byen';

  @override
  String get mockTabHome => 'Akèy';

  @override
  String get mockTabLog => 'Jounal';

  @override
  String get mockTabReport => 'Rapò';

  @override
  String get mockTabReward => 'Rekonpans';

  @override
  String get mockTabSettings => 'Paramèt';

  @override
  String get navHome => 'Home';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get authChooseRole => 'Chwazi wòl ou';

  @override
  String get authRolePatient => 'Pasyan';

  @override
  String get authRolePatientHint => 'Track air quality risk and inhaler use';

  @override
  String get authRoleProvider => 'Founisè';

  @override
  String get authRoleProviderHint =>
      'Link patients and review clinical evidence';

  @override
  String get authFullNameLabel => 'Non konplè';

  @override
  String get authNpiLabel => 'Nimewo NPI';

  @override
  String get authNpiHelper => 'Idantifyan Nasyonal Founisè ki gen 10 chif';

  @override
  String get authOrContinueWith => 'oswa kontinye ak';

  @override
  String get authContinueGoogle => 'Kontinye ak Google';

  @override
  String get authContinueApple => 'Kontinye ak Apple';

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
  String get authSignOut => 'Dekonekte';

  @override
  String get authRetry => 'Eseye ankò';

  @override
  String get authWorking => 'Ap travay…';

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
  String get authErrorGeneric =>
      'Gen yon bagay ki pa mache. Tanpri eseye ankò.';

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
  String get authBiometricTitle => 'Debloke Howse Asthma';

  @override
  String get authBiometricHint => 'Itilize byometri pou kontinye';

  @override
  String get authBiometricReason => 'Debloke Howse Asthma';

  @override
  String get authBiometricUnlock => 'Unlock';

  @override
  String get authBiometricFailed => 'Biometric unlock failed. Try again.';

  @override
  String get authBiometricToggle => 'Debloke ak byometri';

  @override
  String get authBiometricToggleHint =>
      'Mande byometri chak fwa w ap louvri aplikasyon an';

  @override
  String get authBiometricUnavailable => 'Byometri pa disponib sou aparèy sa a';

  @override
  String get authOnboardingTitle => 'Konfigirasyon pasyan';

  @override
  String get authOnboardingBody =>
      'If your clinician shared an 8-character invite code, enter it now. You can also do this later in Settings.';

  @override
  String get authOnboardingSkip => 'Sote pou kounye a';

  @override
  String get authInviteCodeLabel => 'Kòd envitasyon founisè';

  @override
  String get authInviteCodeHelper => '8 lèt/chif, ekspire nan 24 è';

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
  String get authInviteIssueFailed => 'Pa t kapab bay kòd envitasyon an';

  @override
  String get authConfirmLink => 'Konfime';

  @override
  String get authRejectLink => 'Refize';

  @override
  String get authLinkStatusPending => 'Ap tann konfimasyon';

  @override
  String get settingsSystemDefault => 'System default';

  @override
  String get settingsLocationTodo =>
      'Location permission will be requested in a later update';

  @override
  String get providerHomeTab => 'Akèy';

  @override
  String get providerLinkTab => 'Lyen';

  @override
  String get providerHomeTitle => 'Akèy founisè';

  @override
  String providerHomeWelcome(String email) {
    return 'Konekte kòm $email';
  }

  @override
  String get providerHomePlaceholder =>
      'Tablo klinik pou pasyan yo ap vini nan yon vèsyon pita. Kòmanse lè w konekte ak pasyan yo.';

  @override
  String get providerLinkPatientsCta => 'Konekte ak pasyan';

  @override
  String get providerLinkTitle => 'Konekte ak pasyan';

  @override
  String get providerLinkIntro =>
      'Bay yon kòd 8 karaktè (valab pou 24 è). Pasyan an antre l, epi apre sa toulède konfime.';

  @override
  String get providerIssueInviteCta => 'Bay kòd envitasyon';

  @override
  String get providerInviteTtlHint => 'Valab pou 24 è';

  @override
  String get providerInviteCopied => 'Kòd envitasyon an kopye';

  @override
  String get providerPendingLinks => 'Lyen k ap tann';

  @override
  String get providerNoPendingLinks => 'Pa gen lyen k ap tann';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'Pasyan $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'Kòd envitasyon resan';

  @override
  String get providerNoInvites => 'Poko gen kòd envitasyon';

  @override
  String get providerInviteConsumed => 'Itilize';

  @override
  String get providerInviteActive => 'Aktif';

  @override
  String get splashTagline => 'Pwoteksyon entèlijan ou kont deklanchè yo';

  @override
  String get splashGetStarted => 'Kòmanse';

  @override
  String get splashAlreadyHaveAccount => 'Ou gen yon kont deja?';

  @override
  String get splashSignIn => 'Konekte';

  @override
  String get authForgotPassword => 'Ou bliye modpas ou?';

  @override
  String get authNoAccount => 'Ou pa gen kont?';

  @override
  String get authUseBiometricHint =>
      'Itilize Face ID oswa anprent dwèt pou debloke';

  @override
  String get authTouchSensorHint => 'Touche kapteur la oswa gade kamera a';

  @override
  String get navLog => 'Log';

  @override
  String get navReport => 'Report';

  @override
  String get navRewards => 'Rewards';

  @override
  String get mockChooseLanguage => 'Chwazi lang';

  @override
  String get mockYourLocation => 'Kote ou ye';

  @override
  String get mockUseCurrentLocation => 'Itilize kote ou ye kounye a';

  @override
  String get mockLocationTrapOnly =>
      'Yo itilize kote ou ye a sèlman pou done kalite lè TRAP';

  @override
  String get mockLabelYourPlace => 'Make kote ou';

  @override
  String get mockSchool => 'Lekòl';

  @override
  String get mockWork => 'Travay';

  @override
  String get mockOther => 'Lòt';

  @override
  String get mockEmergencyOnePerson => 'Yon moun pou rele nan ijans';

  @override
  String get mockContactName => 'Non kontak la';

  @override
  String get mockPhoneNumber => 'Nimewo telefòn';

  @override
  String get mockProviderPairing => 'Koneksyon ak founisè';

  @override
  String get mockPairingOptional =>
      'Opsyonèl — ou ka ajoute sa pita nan Paramèt';

  @override
  String get mockNext => 'Pwochen';

  @override
  String get mockProfessionalProfile => 'Pwofil pwofesyonèl';

  @override
  String get mockStep2Of4 => 'Etap 2 sou 4';

  @override
  String get mockTellPractice => 'Pale nou de pratik medikal ou';

  @override
  String get mockSpecialtyLabel => 'Espesyalite';

  @override
  String get mockClinicLabel => 'Non pratik / klinik';

  @override
  String get mockNpiFormatOnly =>
      'Se fòma a sèlman nou tcheke. Verifikasyon NPI fèt apre ou fin voye l.';

  @override
  String get mockCredentialsSecure =>
      'Kredansyèl ou yo chifre epi estoke an sekirite. Nou pa janm pataje done founisè yo san konsantman.';

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
  String get actPast4Weeks => 'Pandan 4 dènye semèn yo';

  @override
  String get actQ1 =>
      'Konbyen tan opresyon (asm) ou anpeche ou fè otan bagay nan travay, nan lekòl oswa lakay ou?';

  @override
  String get actQ2 => 'Konbyen fwa ou te gen souf kout?';

  @override
  String get actQ3 =>
      'Konbyen fwa sentòm asm ou yo reveye ou lannwit oswa pi bonè pase dabitid?';

  @override
  String get actQ4 =>
      'Konbyen fwa ou te itilize inalatè sekou ou oswa medikaman nebilizatè ou?';

  @override
  String get actQ5 => 'Kijan ou ta evalye kontwòl asm ou?';

  @override
  String get actOpt1 => 'Tout tan';

  @override
  String get actOpt2 => 'Pifò tan';

  @override
  String get actOpt3 => 'Yon pati nan tan an';

  @override
  String get actOpt4 => 'Yon ti tan';

  @override
  String get actOpt5 => 'Pa janm';

  @override
  String get actQ5Opt1 => 'Pa kontwole ditou';

  @override
  String get actQ5Opt2 => 'Mal kontwole';

  @override
  String get actQ5Opt3 => 'Kontwole yon ti jan';

  @override
  String get actQ5Opt4 => 'Byen kontwole';

  @override
  String get actQ5Opt5 => 'Kontwole nèt';

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
      'Bouton yo louvri aplikasyon telefòn lan. Yo pa janm fè apèl otomatikman.';

  @override
  String panicCallNamed(String name) {
    return 'Rele $name';
  }

  @override
  String get panicDialFailed =>
      'Pa t kapab louvri aplikasyon telefòn lan sou aparèy sa a.';

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
      'Repons ou yo sove pou ou ka pataje yo ak pwofesyonèl sante ou. Vèsyon kesyonè sa a pa t verifye ak sistèm nòt ofisyèl la, kidonk aplikasyon an pa montre okenn nòt.';

  @override
  String get s5ActSaved => 'Repons ou yo sove.';

  @override
  String get s5ActSubtitle => '5 kesyon sou 4 dènye semèn yo';

  @override
  String get s5ActTitle => 'Kesyonè kontwòl asm';

  @override
  String get s5AddDetails => 'Ajoute detay';

  @override
  String get s5AddRecord => 'Ajoute yon nòt';

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
  String get s5Back => 'Retounen';

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
  String get s5Cancel => 'Anile';

  @override
  String get s5Change => 'Chanje';

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
  String get s5Delete => 'Efase';

  @override
  String get s5DeleteConfirm => 'Efase antre sa a?';

  @override
  String get s5DeleteFailed => 'Pa t kapab efase l. Tanpri eseye ankò.';

  @override
  String get s5Edit => 'Modifye';

  @override
  String get s5EnglishVersion => 'English (for clinician)';

  @override
  String get s5EntryRemoved => 'Antre a efase.';

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
  String get s5FieldDate => 'Dat';

  @override
  String get s5FieldMedication => 'Medikaman';

  @override
  String get s5FieldNote => 'Nòt (opsyonèl)';

  @override
  String get s5FieldPuffs => 'Kantite pouf (opsyonèl)';

  @override
  String get s5FieldReason => 'Rezon (opsyonèl)';

  @override
  String get s5FieldTime => 'Lè';

  @override
  String get s5FilterAll => 'Tout';

  @override
  String get s5FilterInhaler => 'Inalatè';

  @override
  String get s5FilterMedCheck => 'Verifikasyon medikaman';

  @override
  String get s5FilterSymptoms => 'Sentòm';

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
  String get s5FromUrgentHelp => 'Anrejistre depi Èd ijan';

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
  String get s5InhalerEditTitle => 'Detay itilizasyon inalatè';

  @override
  String get s5InhalerEntry => 'Itilizasyon inalatè';

  @override
  String get s5InhalerLogged => 'Itilizasyon inalatè anrejistre.';

  @override
  String get s5InhalerOneEntryHint =>
      'Chak fwa ou sove se yon antre itilizasyon inalatè. Yo pa konte l kòm yon pouf oswa yon jou.';

  @override
  String s5InhalerUnknownCount(int n) {
    return 'Medikaman pa idantifye: $n';
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
  String get s5Last30Days => '30 dènye jou yo';

  @override
  String get s5Last7Days => '7 dènye jou yo';

  @override
  String get s5LogInhaler => 'Anrejistre itilizasyon inalatè';

  @override
  String get s5LogLegend =>
      'Chak liy se yon antre ki sove. Jou ki pa gen antre yo make “pa anrejistre”, sa ki pa menm bagay ak zewo.';

  @override
  String get s5LogSymptoms => 'Anrejistre sentòm';

  @override
  String get s5MedAdd => 'Ajoute yon medikaman';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return 'Jou ou te itilize l: $a · pa t itilize l: $b · pa sonje: $c · pa anrejistre: $d';
  }

  @override
  String get s5MedCheckIntro =>
      'Yon verifikasyon ou fè poukont ou pou wè si ou te itilize medikaman ou. Li pa baze sou dosye famasi.';

  @override
  String get s5MedCheckQuestion =>
      'Èske ou te itilize medikaman ou jan sa te planifye?';

  @override
  String get s5MedCheckTitle => 'Verifikasyon medikaman jodi a';

  @override
  String get s5MedChooseHint =>
      'Chwazi yon medikaman, oswa “Mwen pa konnen non medikaman an”.';

  @override
  String get s5MedDailyCheck => 'Verifikasyon chak jou';

  @override
  String get s5MedDailyCheckHint =>
      'Montre “Verifikasyon medikaman jodi a” sou paj Akèy la. Aktive l sèlman si pwofesyonèl sante ou mande ou itilize medikaman sa a chak jou.';

  @override
  String get s5MedDefault => 'Default pou anrejistreman rapid';

  @override
  String get s5MedDefaultHint =>
      'Yo itilize l lè ou tape “Anrejistre itilizasyon inalatè” sou paj Akèy la.';

  @override
  String get s5MedEdit => 'Modifye medikaman';

  @override
  String get s5MedNameLabel => 'Non medikaman (jan li ekri sou etikèt ou)';

  @override
  String get s5MedNotApplicable => 'Pa pwograme pou jodi a';

  @override
  String s5MedNotApplicableDays(int n) {
    return 'Pa pwograme: $n jou';
  }

  @override
  String get s5MedNotRecorded => 'Medikaman pa anrejistre';

  @override
  String get s5MedNotSure => 'Mwen pa sonje';

  @override
  String get s5MedNotUsed => 'Mwen pa t itilize l';

  @override
  String get s5MedOther => 'Yon lòt non';

  @override
  String get s5MedOtherHint => 'Tape non medikaman an';

  @override
  String get s5MedReasonCost => 'Pri';

  @override
  String get s5MedReasonForgot => 'Mwen bliye';

  @override
  String get s5MedReasonNoMedicine => 'Mwen pa t gen medikaman an';

  @override
  String get s5MedReasonQuestion => 'Rezon (opsyonèl)';

  @override
  String get s5MedUnknown => 'Mwen pa konnen non medikaman an';

  @override
  String get s5MedUnknownShort => 'Medikaman pa idantifye';

  @override
  String get s5MedUsed => 'Mwen te itilize l';

  @override
  String get s5MyLanguage => 'My language';

  @override
  String get s5MyLogTitle => 'Jounal mwen';

  @override
  String get s5MyMedsEmpty => 'Poko gen medikaman ki sove.';

  @override
  String get s5MyMedsHint =>
      'Non ou te konfime yo, pou fè anrejistreman pi rapid. Sa pa se yon rekòmandasyon dòz.';

  @override
  String get s5MyMedsOpen => 'Manage my medications';

  @override
  String get s5MyMedsTitle => 'Medikaman mwen yo';

  @override
  String get s5NavEnvironment => 'Environment';

  @override
  String get s5NavLog => 'Log';

  @override
  String get s5NavVisitPrep => 'Visit prep';

  @override
  String get s5NoAnswer => 'Mwen prefere pa reponn';

  @override
  String get s5NoRecordsYet => 'Poko gen nòt';

  @override
  String s5NoSymptomDays(int n) {
    return 'Jou ou make “pa gen sentòm”: $n';
  }

  @override
  String get s5NotRecorded => 'Pa anrejistre';

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
    return 'Peryòd: $days jou · Jou ki gen nòt: $n';
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
      other: '$n pouf',
      one: '1 pouf',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return 'Question $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return 'Kesyon $n sou $total';
  }

  @override
  String get s5ReasonBeforeActivity => 'Anvan yon aktivite';

  @override
  String get s5ReasonOther => 'Lòt';

  @override
  String get s5ReasonSymptoms => 'Akòz sentòm';

  @override
  String s5RecentInhaler(int n) {
    return 'Antre itilizasyon inalatè: $n';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return 'Jou ki gen sentòm: $n';
  }

  @override
  String get s5RecentTitle => 'Last 7 days';

  @override
  String get s5RecordsLoadFailed =>
      'Pa t kapab chaje nòt ou yo. Tanpri eseye ankò.';

  @override
  String get s5RecordsManageHint =>
      'You can edit or delete entries in My log. Deleting always asks you to confirm.';

  @override
  String get s5Refresh => 'Refresh';

  @override
  String get s5Reload => 'Load again';

  @override
  String get s5Save => 'Sove';

  @override
  String get s5Saved => 'Sove.';

  @override
  String get s5SavedPlacesHint => 'Saved places such as home, school, or work';

  @override
  String get s5SaveFailed => 'Pa t kapab sove l. Antre ou yo toujou la.';

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
  String get s5SymActivityLimited => 'Aktivite limite';

  @override
  String get s5SymCough => 'Tous';

  @override
  String get s5SymNightWaking => 'Mwen reveye lannwit';

  @override
  String get s5SymNone => 'Pa gen sentòm';

  @override
  String get s5SymOther => 'Yon lòt bagay';

  @override
  String get s5SymOtherHint => 'Eksplike ak pwòp mo ou';

  @override
  String get s5SymShortBreath => 'Difikilte pou respire';

  @override
  String get s5SymWheeze => 'Souf k ap sifle';

  @override
  String get s5SymptomEditTitle => 'Modifye sentòm';

  @override
  String get s5SymptomEntry => 'Sentòm';

  @override
  String get s5SymptomNoneHint =>
      'Jou ou pa anrejistre yo parèt kòm “pa anrejistre”, pa kòm “pa gen sentòm”.';

  @override
  String get s5SymptomQuestion => 'Kisa ou remake?';

  @override
  String get s5Today => 'Jodi a';

  @override
  String get s5Undo => 'Defèt';

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
      'Si pwofesyonèl sante ou ban ou yon plan aksyon pou asm, swiv li.';

  @override
  String get s5UrgentCall911Locked => 'Urgent help: call 911';

  @override
  String get s5UrgentHelp => 'Èd ijan';

  @override
  String get s5UrgentIntro =>
      'Si respire a two difisil oswa li pa amelyore, rele 911.';

  @override
  String get s5UrgentLogHint =>
      'Opsyonèl: sove yon nòt ki di ou te itilize inalatè ou.';

  @override
  String get s5UrgentNoContact =>
      'Poko gen kontak ijans. Ajoute youn nan Paramèt → Èd.';

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
  String get s6AddTime => 'Ajoute yon lè';

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
  String get s6DoseLater => 'Verifye pita';

  @override
  String get s6DoseNotUsed => 'Mwen pa t kapab itilize l';

  @override
  String get s6DoseUnconfirmed => 'No answer yet';

  @override
  String get s6DoseUsed => 'Mwen te itilize l';

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
  String get s6HomeWaterNo => 'Non';

  @override
  String get s6HomeWaterQuestion =>
      'Èske te gen yon fwit dlo oswa inondasyon lakay ou?';

  @override
  String get s6HomeWaterYes => 'Wi';

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
  String get s6OccurredLabel => 'Kilè sa te rive';

  @override
  String get s6PdfEnvLimit =>
      'Regional reference only. It does not show personal exposure or the cause of symptoms. A single AQI does not name ozone and particles together, and it does not include pollen.';

  @override
  String get s6PdfEnvTitle => 'Environment reference (appendix)';

  @override
  String get s6PuffsEach => 'Kantite pouf chak fwa';

  @override
  String s6ReminderBodyNamed(String name) {
    return 'Li lè pou konfime $name';
  }

  @override
  String get s6ReminderBodyPrivate => 'Li lè pou konfime medikaman ou';

  @override
  String get s6ReminderChannel =>
      'Rapèl nan lè dòz ou te sove yo. Se pa yon alèt 30 minit.';

  @override
  String get s6ReminderTitle => 'Verifikasyon medikaman';

  @override
  String get s6RoleBoth => 'Chak jou ak lè bezwen';

  @override
  String get s6RoleController => 'Medikaman chak jou';

  @override
  String get s6RoleRescue => 'Lè bezwen';

  @override
  String get s6ScheduleTimes => 'Lè ou pran l';

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
  String get cnTagline => 'Lèt asirans, pwochen etap yo klè';

  @override
  String get cnDemoBadge => 'Egzanp';

  @override
  String get cnDemoBadgeLong => 'Egzanp ak done envante. Rezilta yo fiks.';

  @override
  String get cnAuthSignInTitle => 'Konekte';

  @override
  String get cnAuthCreateTitle => 'Kreye yon kont';

  @override
  String get cnAuthResetTitle => 'Reyinisyalize modpas';

  @override
  String get cnAuthSignIn => 'Konekte';

  @override
  String get cnAuthCreate => 'Kreye yon kont';

  @override
  String get cnAuthSendReset => 'Voye lyen reyinisyalizasyon';

  @override
  String cnAuthProfileError(String code) {
    return 'Ou konekte, men pa t kapab chaje kont ou ($code).';
  }

  @override
  String get cnRetry => 'Eseye ankò';

  @override
  String get cnSignOut => 'Dekonekte';

  @override
  String get cnAuthPreparingAccount => 'Ap prepare kont ou…';

  @override
  String get cnAuthNameLabel => 'Non (opsyonèl)';

  @override
  String get cnAuthNameHelper =>
      'Li parèt sou pakè ou yo. Ou ka chanje l pita.';

  @override
  String get cnAuthEmailLabel => 'Imèl';

  @override
  String get cnAuthPasswordLabel => 'Modpas';

  @override
  String get cnAuthPasswordHelper => 'Omwen 8 karaktè';

  @override
  String get cnAuthShowPassword => 'Montre modpas la';

  @override
  String get cnAuthHidePassword => 'Kache modpas la';

  @override
  String get cnAuthPasswordRequired => 'Antre modpas ou';

  @override
  String cnAuthCheckEmail(String email) {
    return 'Nou voye yon lyen konfimasyon bay $email. Louvri l sou telefòn sa a, epi apre sa konekte.';
  }

  @override
  String cnAuthResetSent(String email) {
    return 'Si gen yon kont pou $email, yon lyen reyinisyalizasyon ap vini. Louvri l sou telefòn sa a.';
  }

  @override
  String get cnAuthResent => 'Voye ankò.';

  @override
  String get cnAuthResend => 'Revoye imèl la';

  @override
  String get cnAuthSignInInstead => 'Mwen konfime. Konekte';

  @override
  String get cnAuthForgot => 'Ou bliye modpas ou?';

  @override
  String get cnAuthNoAccount => 'Ou nouvo isit la? Kreye yon kont';

  @override
  String get cnAuthHaveAccount => 'Ou gen yon kont? Konekte';

  @override
  String get cnAuthResetHint =>
      'Antre imèl ou epi nou pral voye yon lyen pou mete yon nouvo modpas.';

  @override
  String get cnAuthBackToSignIn => 'Retounen nan koneksyon';

  @override
  String get cnAuthPrivacyLine =>
      'Lèt ou yo ak nòt ou yo prive, se sèlman kont ou ki ka wè yo.';

  @override
  String get cnAuthPasswordUpdated => 'Modpas la mete ajou.';

  @override
  String get cnAuthNewPasswordTitle => 'Mete yon nouvo modpas';

  @override
  String get cnAuthNewPasswordLabel => 'Nouvo modpas';

  @override
  String get cnAuthSavePassword => 'Sove modpas la';

  @override
  String get cnLater => 'Pita';

  @override
  String get cnAuthErrInvalidCredentials => 'Imèl la oswa modpas la pa kòrèk.';

  @override
  String get cnAuthErrNotConfirmed =>
      'Tanpri konfime imèl ou anvan. Gade nan bwat resepsyon ou oswa revoye lyen an.';

  @override
  String get cnAuthErrExists => 'Gen yon kont ak imèl sa a deja. Konekte olye.';

  @override
  String get cnAuthErrWeakPassword =>
      'Chwazi yon modpas ki pi fò (omwen 8 karaktè).';

  @override
  String get cnAuthErrSamePassword =>
      'Itilize yon modpas ki diferan de ansyen an.';

  @override
  String get cnAuthErrRateLimited => 'Twòp esè. Tann yon minit epi eseye ankò.';

  @override
  String get cnAuthErrInvalidEmail => 'Verifye adrès imèl la.';

  @override
  String get cnAuthErrEmailNotAuthorized =>
      'Nou pa t kapab voye imèl nan adrès sa a kounye a. Eseye ankò pita.';

  @override
  String get cnAuthErrDisabled => 'Metòd koneksyon sa a fèmen.';

  @override
  String get cnAuthErrSessionExpired => 'Sesyon ou fini. Tanpri konekte ankò.';

  @override
  String cnAuthErrUnknown(String code) {
    return 'Gen yon bagay ki pa mache ($code). Eseye ankò.';
  }

  @override
  String get cnErrNetwork =>
      'Pa gen koneksyon. Verifye entènèt ou epi eseye ankò.';

  @override
  String get cnErrServiceDown =>
      'Sèvis la pa reponn. Eseye ankò nan kèk minit.';

  @override
  String get cnTabHome => 'Akèy';

  @override
  String get cnTabCases => 'Dosye';

  @override
  String get cnTabRecords => 'Rejis';

  @override
  String get cnTabAccount => 'Kont';

  @override
  String get cnHomeHeadline => 'Konprann lèt asirans ou a.';

  @override
  String get cnScanLetter => 'Eskane yon lèt';

  @override
  String get cnUploadFile => 'Voye PDF / foto';

  @override
  String get cnTryDemo => 'Eseye demo a';

  @override
  String get cnHomeSignInLine => 'Pou sove dosye ou yo, ou bezwen yon kont.';

  @override
  String get cnServiceNotConfigured =>
      'Vèsyon sa a pa konekte ak sèvè a. Se demo a sèlman ki mache.';

  @override
  String get cnContinueCase => 'Kontinye dosye ou a';

  @override
  String get cnHowItWorks => 'Kijan li mache';

  @override
  String get cnStep1Title => 'Li lèt la';

  @override
  String get cnStep1Body =>
      'Pran yon foto. Nou jwenn rezon an, pwochen etap la ak dat la.';

  @override
  String get cnStep2Title => 'Rasanble rejis yo';

  @override
  String get cnStep2Body => 'Konpare sa lèt la mande a ak pwòp rejis ou yo.';

  @override
  String get cnStep3Title => 'Kreye yon pakè';

  @override
  String get cnStep3Body =>
      'Resevwa yon rezime yon paj pou doktè a ak yon bwouyon demann revizyon.';

  @override
  String get cnRecentCases => 'Lòt dosye';

  @override
  String get cnNoCasesYet => 'Poko gen dosye';

  @override
  String get cnNoOtherCases => 'Pa gen lòt dosye.';

  @override
  String get cnSeeAllCases => 'Wè tout dosye';

  @override
  String get cnNoCasesBody => 'Eskane yon lèt asirans pou kòmanse.';

  @override
  String get cnCasesSignInTitle => 'Konekte pou wè dosye ou yo';

  @override
  String get cnCasesSignInBody => 'Oswa louvri demo a pou wè kijan li mache.';

  @override
  String get cnCaseDeleted => 'Dosye a efase.';

  @override
  String get cnCaseUntitled => 'Lèt asirans';

  @override
  String get cnStatusReading => 'Ap li lèt la';

  @override
  String get cnStatusNeedsReview => 'Bezwen verifye';

  @override
  String get cnStatusGatherRecords => 'Rasanble rejis yo';

  @override
  String get cnStatusPacketReady => 'Pakè a pare';

  @override
  String get cnStatusNeedsAttention => 'Bezwen atansyon';

  @override
  String get cnStatusNotStarted => 'Poko kòmanse';

  @override
  String get cnNextWaitReading => 'N ap li lèt la.';

  @override
  String get cnNextTryAgain =>
      'Lekti a sispann. Louvri dosye a pou eseye ankò.';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count enfòmasyon pou konfime',
      one: '1 enfòmasyon pou konfime',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return '$done sou $total atik yo mande ki fin okipe';
  }

  @override
  String get cnNextSharePacket => 'Pakè a pare pou pataje';

  @override
  String get cnNextCreatePacket => 'Pwochen: kreye pakè a';

  @override
  String cnDateToCheckShort(String date) {
    return 'Dat pou verifye: $date';
  }

  @override
  String cnDatePassedShort(String date) {
    return 'Dat la pase: $date';
  }

  @override
  String get cnMoreActions => 'Plis aksyon';

  @override
  String get cnDeleteCase => 'Efase dosye a';

  @override
  String get cnDeleteCaseTitle => 'Efase dosye sa a?';

  @override
  String get cnDeleteCaseBody =>
      'Sa efase paj lèt yo, enfòmasyon yo te li ladan yo, rezime rejis ki lye yo ak pakè yo. Rejis medikaman ak sentòm ou yo rete.';

  @override
  String get cnCancel => 'Anile';

  @override
  String get cnDelete => 'Efase';

  @override
  String get cnDeleteFailed =>
      'Pa t kapab efase l. Verifye koneksyon ou epi eseye ankò.';

  @override
  String get cnKindInitialDenial =>
      'Refi kouvèti medikaman (Drug coverage denial)';

  @override
  String get cnKindInfoRequest => 'Demann pou plis enfòmasyon';

  @override
  String get cnKindReauth => 'Avi renouvèlman (reauthorization)';

  @override
  String get cnKindFinalDenial => 'Desizyon final apèl (Final appeal decision)';

  @override
  String get cnKindEob =>
      'Faktirasyon oswa eksplikasyon avantaj (Explanation of Benefits)';

  @override
  String get cnKindOther => 'Lòt lèt';

  @override
  String get cnKindUncertain => 'Tip lèt la pa klè';

  @override
  String get cnFieldPatientName => 'Non pasyan';

  @override
  String get cnFieldPlanName => 'Plan';

  @override
  String get cnFieldMemberId => 'ID manm';

  @override
  String get cnFieldCaseReference => 'Nimewo dosye oswa referans';

  @override
  String get cnFieldMedication => 'Medikaman (jan li ekri)';

  @override
  String get cnFieldDose => 'Dòz (jan li ekri)';

  @override
  String get cnFieldNoticeDate => 'Dat avi a';

  @override
  String get cnFieldContact => 'Kontak';

  @override
  String get cnFieldSubmissionRoute => 'Kote pou voye l';

  @override
  String get cnFactEdited => 'Ou modifye l';

  @override
  String get cnFactChecked => 'Verifye';

  @override
  String get cnFactNotInLetter => 'Pa nan lèt la';

  @override
  String get cnFactNeedsCheck => 'Bezwen verifye';

  @override
  String get cnFactFromLetter => 'Soti nan lèt la';

  @override
  String get cnWhoYou => 'Ou menm';

  @override
  String get cnWhoCareTeam => 'Ekip swen';

  @override
  String get cnWhoPlan => 'Plan';

  @override
  String get cnWhoUnknown => 'Pa sèten';

  @override
  String get cnReqLinked => 'Lye';

  @override
  String get cnReqAskedCareTeam => 'Mande ekip swen';

  @override
  String get cnReqNotAvailable => 'Pa disponib';

  @override
  String get cnReqNotNeeded => 'Pa nesesè';

  @override
  String get cnReqNeeded => 'Nesesè';

  @override
  String get cnReqReset => 'Make kòm nesesè';

  @override
  String get cnRecMedication => 'Istwa medikaman';

  @override
  String get cnRecSymptoms => 'Jounal sentòm';

  @override
  String get cnRecLocalContext => 'Kontèks lokal';

  @override
  String get cnRecPrn => 'Inalatè lè bezwen';

  @override
  String get cnDemoTitle => 'Demo';

  @override
  String get cnDemoReset => 'Reyinisyalize demo a';

  @override
  String get cnDemoResetDone => 'Demo a reyinisyalize.';

  @override
  String get cnDemoIntro =>
      'Twa lèt envante ak rezilta fiks, pou ou ka wè chak etap. Anyen pa voye.';

  @override
  String get cnUpEmpty => 'Fichye sa a vid.';

  @override
  String cnUpTooLarge(int mb) {
    return 'Chak fichye dwe $mb MB oswa mwens.';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return 'Tout paj yo ansanm dwe $mb MB oswa mwens.';
  }

  @override
  String cnUpTooManyPages(int max) {
    return 'Jiska $max paj pou chak lèt.';
  }

  @override
  String get cnUpUnsupported =>
      'Itilize JPG, PNG oswa PDF. Pou foto HEIC, pran yon nouvo foto isit la.';

  @override
  String get cnUpBadFile =>
      'Pa ka li fichye sa a. Eseye yon lòt foto oswa PDF.';

  @override
  String get cnUpEncrypted =>
      'PDF sa a gen yon modpas. Sove yon kopi san modpas oswa pran foto.';

  @override
  String get cnCameraUnavailable =>
      'Kamera a pa disponib. Ou ka voye yon foto oswa yon PDF olye.';

  @override
  String get cnPhotosUnavailable =>
      'Pa ka louvri foto yo. Pèmèt aksè nan foto nan paramèt yo, oswa voye yon PDF.';

  @override
  String get cnFilesUnavailable =>
      'Pa ka louvri fichye yo kounye a. Eseye ankò.';

  @override
  String get cnUploadFailed =>
      'Voye a pa fini. Paj ou yo toujou la. Eseye ankò.';

  @override
  String get cnCaptureTitle => 'Ajoute paj lèt la';

  @override
  String get cnReplacePagesTitle => 'Ranplase paj lèt la';

  @override
  String get cnOpening => 'Ap louvri…';

  @override
  String get cnCaptureEmptyTitle => 'Ajoute paj lèt ou a';

  @override
  String get cnCaptureTips =>
      'Mete paj la plat nan bon limyè epi mete tout kat kwen yo nan kad la. Ajoute chak paj, youn apre lòt.';

  @override
  String get cnTakePhoto => 'Pran foto';

  @override
  String get cnAddPage => 'Ajoute paj';

  @override
  String get cnAddPhoto => 'Foto';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages paj',
      one: '1 paj',
    );
    return '$_temp0 · $size MB';
  }

  @override
  String get cnUploadConsent =>
      'Lè w voye paj sa yo, yo ale sou sèvè CoverNote, kote yon sèvis AI li yo pou ou. Ou ka efase dosye a nenpòt ki lè.';

  @override
  String get cnStageUploading => 'Ap voye';

  @override
  String get cnUploadAndRead => 'Voye epi li';

  @override
  String cnPageN(int n) {
    return 'Paj $n';
  }

  @override
  String cnPdfPages(int n, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paj',
      one: '1 paj',
    );
    return 'Fichye $n · PDF, $_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return 'Gade paj $n';
  }

  @override
  String get cnRotate => 'Vire';

  @override
  String get cnRetake => 'Refè foto a';

  @override
  String get cnRemovePage => 'Retire';

  @override
  String get cnReorder => 'Trennen pou chanje lòd';

  @override
  String get cnServiceUnavailableBody =>
      'Lektè lèt la pa disponib kounye a. Paj ou yo sove; eseye ankò pita.';

  @override
  String get cnNeedNewPagesBody =>
      'Pran foto ki pi klè oswa itilize mwens paj, epi voye yo ankò.';

  @override
  String get cnPagesKept => 'Paj ou yo sove. Anyen pa chanje.';

  @override
  String get cnReplacePages => 'Ranplase paj yo';

  @override
  String get cnTryAgain => 'Eseye ankò';

  @override
  String get cnStageReading => 'Ap li';

  @override
  String get cnStageChecking => 'Ap verifye';

  @override
  String get cnStageReady => 'Pare';

  @override
  String get cnReadingTitle => 'Ap li lèt ou a';

  @override
  String get cnReadingBody =>
      'Lè sa a fini, ou verifye sa nou jwenn yo ak lèt la.';

  @override
  String get cnReadingLeaveOk =>
      'Ou ka kite ekran sa a. Lekti a kontinye epi dosye ou a sove.';

  @override
  String get cnStartReading => 'Kòmanse li';

  @override
  String get cnStepLetter => 'Lèt';

  @override
  String get cnStepReview => 'Verifikasyon';

  @override
  String get cnStepEvidence => 'Prèv';

  @override
  String get cnStepPacket => 'Pakè';

  @override
  String cnStepOf(int n, int total, String name) {
    return 'Etap $n sou $total: $name';
  }

  @override
  String get cnSaving => 'Ap sove…';

  @override
  String get cnSaved => 'Sove';

  @override
  String get cnNotSavedRetry => 'Pa sove · Eseye ankò';

  @override
  String get cnViewOriginal => 'Gade paj orijinal yo';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paj li',
      one: '1 paj li',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return 'Difisil pou li: paj $list. Verifye enfòmasyon sa yo ak anpil swen oswa refè foto paj la.';
  }

  @override
  String get cnRetakePages => 'Refè foto paj yo';

  @override
  String get cnHardToRead => 'Difisil pou li';

  @override
  String get cnContinueToReview => 'Kontinye nan verifikasyon';

  @override
  String get cnOriginalPages => 'Paj orijinal yo';

  @override
  String get cnNoOriginal => 'Pa gen paj orijinal ki sove.';

  @override
  String get cnCheckDetails => 'Verifye detay yo';

  @override
  String get cnCheckDetailsHint =>
      'Konpare chak valè ak lèt ou a. Tape sou yon sitasyon pou wè kote li soti.';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Verifye $count lòt atik pou kontinye',
      one: 'Verifye 1 lòt atik pou kontinye',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => 'Kontinye nan prèv';

  @override
  String cnSeePage(int n) {
    return 'Gade paj $n';
  }

  @override
  String get cnWhatLetterIs => 'Ki kalite lèt sa a ye';

  @override
  String get cnLooksRight => 'Sa sanble kòrèk';

  @override
  String get cnChange => 'Chanje';

  @override
  String get cnCardWhyDenied => 'Poukisa yo refize l (Denial)';

  @override
  String get cnCardWhatTheyNeed => 'Sa yo mande';

  @override
  String get cnCardWhatItSays => 'Sa lèt la di';

  @override
  String get cnNoReasonFound => 'Pa gen rezon ki jwenn nan lèt la.';

  @override
  String get cnCardNextStep => 'Pwochen etap';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Mande ekip swen ou pou mande yon revizyon. Lèt la site $count atik pou voye.',
      one:
          'Mande ekip swen ou pou mande yon revizyon. Lèt la site 1 atik pou voye.',
      zero:
          'Mande ekip swen ou pou mande yon revizyon. Lèt la pa site okenn atik espesifik.',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Voye $count atik plan an mande yo anvan dat ki anba a.',
      one: 'Voye 1 atik plan an mande anvan dat ki anba a.',
      zero: 'Voye enfòmasyon plan an mande yo anvan dat ki anba a.',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth =>
      'Note ki lè apwobasyon aktyèl la fini epi mande ekip swen ou pou kòmanse renouvèlman an.';

  @override
  String get cnNextFinal =>
      'Sa a se yon desizyon final. CoverNote pa ekri yon premye demann revizyon pou li. Mande plan an oswa ekip swen ou sou opsyon lèt la site yo.';

  @override
  String get cnNextEob =>
      'Sa sanble yon faktirasyon oswa yon relve avantaj, se pa yon refi. Verifye l ak sèvis manm plan an.';

  @override
  String get cnNextUncertain =>
      'Premyèman konfime ki kalite lèt sa a ye, anlè a.';

  @override
  String cnWhereToSend(String route) {
    return 'Kote pou voye l: $route';
  }

  @override
  String cnWhoToCall(String contact) {
    return 'Kontak: $contact';
  }

  @override
  String get cnCardDate => 'Dat pou verifye';

  @override
  String cnDateCalculated(String anchor, int days) {
    return 'Kalkile: $anchor + $days jou kalandriye';
  }

  @override
  String get cnReceivedDateWord => 'dat ou resevwa l';

  @override
  String get cnNoticeDateWord => 'dat avi a';

  @override
  String get cnDateEnteredByYou => 'Ou antre l';

  @override
  String get cnDateFromLetter => 'Endike nan lèt la';

  @override
  String cnReceivedOn(String date) {
    return 'Ou resevwa l le $date';
  }

  @override
  String get cnDatePassed =>
      'Dat sa a pase. Rele plan an pou mande kisa ou ka toujou fè.';

  @override
  String cnNeedReceivedDate(int days) {
    return 'Lèt la bay $days jou kalandriye apati jou ou resevwa l. Ki lè li rive?';
  }

  @override
  String get cnEnterReceivedDate => 'Antre dat ou resevwa l';

  @override
  String get cnDateConflict =>
      'Lèt la bay plizyè dat diferan. Mande plan an kilès ki aplike, epi chwazi l.';

  @override
  String cnUseThisDate(String date) {
    return 'Itilize $date';
  }

  @override
  String get cnDateUnclear =>
      'Fason li ekri a pa klè oswa li konte jou ouvrab, kidonk CoverNote pa kalkile l. Mande plan an dat egzak la.';

  @override
  String get cnNoDeadline =>
      'Pa gen dat limit pou revizyon ki jwenn nan lèt la.';

  @override
  String cnReplyBy(String date) {
    return 'Reponn a demann enfòmasyon an anvan $date (dapre lèt la)';
  }

  @override
  String get cnEnterDatePlanGave => 'Antre yon dat';

  @override
  String get cnUseLetterDate => 'Itilize dat lèt la';

  @override
  String get cnLeaveUnknown => 'Kite l enkonu pou kounye a';

  @override
  String get cnDateUnknownChecked => 'Enkonu, nòte';

  @override
  String get cnTypeAsWritten => 'Tape l egzakteman jan lèt la montre l.';

  @override
  String get cnCheckThisValue => 'Valè sa a parèt etranj. Konpare l ak lèt la.';

  @override
  String get cnDone => 'Fini';

  @override
  String get cnEdit => 'Modifye';

  @override
  String get cnAdd => 'Ajoute';

  @override
  String get cnNoRecordsToLink =>
      'Pa gen rejis nan 30 dènye jou yo pou lye. Ou ka toujou make ki moun ki gen atik sa a.';

  @override
  String cnLinkTitle(String label) {
    return 'Lye yon rejis ak: $label';
  }

  @override
  String get cnLinkNote =>
      'Pwòp rejis ou yo sipòte demann lan. Yo pa ranplase nòt klinik oswa rezilta tès.';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '$taken pran / $notTaken pa pran / $unknown enkonu sou $scheduled dòz pwograme';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return 'Lè bezwen: $uses itilizasyon, $puffs pouf';
  }

  @override
  String get cnNoEntries => 'Pa gen antre';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return 'Sentòm pandan $days jou, reveye lannwit pandan $night jou ($entries sou $total jou anrejistre)';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return 'Done PM2.5 pou $days sou $total jou; $high jou pi wo pase AQI 100';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rapò pèsonèl',
      one: '1 rapò pèsonèl',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => 'Done sentetik';

  @override
  String get cnLetterAsksFor => 'Sa lèt la mande';

  @override
  String get cnNoItemsListed =>
      'Lèt la pa site okenn atik espesifik. Ou ka ajoute pwòp ou.';

  @override
  String get cnAddItemLabel => 'Ajoute yon atik pou swiv';

  @override
  String cnYourRecords(String from, String to) {
    return 'Rejis ou yo ($from – $to)';
  }

  @override
  String get cnLocalContextNote =>
      'Kontèks opsyonèl. Se pa yon mezi lakay ou epi se pa yon kòz sentòm yo.';

  @override
  String get cnContinueToPacket => 'Kontinye nan pakè a';

  @override
  String get cnAddedByYou => 'Ou ajoute l';

  @override
  String get cnFromLetter => 'Soti nan lèt la';

  @override
  String cnWhoHasIt(String who) {
    return 'Ki moun ki genyen l: $who';
  }

  @override
  String cnLinkedTo(String record) {
    return 'Lye: $record';
  }

  @override
  String get cnSeeInLetter => 'Gade nan lèt la';

  @override
  String get cnLinkRecords => 'Lye rejis mwen yo';

  @override
  String get cnOtherStatus => 'Lòt estati';

  @override
  String get cnInPacket => 'Nan pakè a';

  @override
  String get cnRemoveFromPacket => 'Retire nan pakè a';

  @override
  String get cnAddToPacket => 'Mete nan pakè a';

  @override
  String get cnErrNotSavedYet =>
      'Dènye chanjman ou yo poko sove. Verifye koneksyon ou epi eseye ankò.';

  @override
  String get cnPacketChangedMeanwhile =>
      'Enfòmasyon oswa rejis yo chanje pandan yo t ap fè pakè a. Kreye l ankò.';

  @override
  String get cnPacketFailed => 'Pa t kapab fè pakè a. Eseye ankò.';

  @override
  String get cnBeforeSharingTitle => 'Anvan ou pataje';

  @override
  String get cnBeforeSharingBody =>
      'Fichye sa a gen non ou ak detay sante ou. Pataje l sèlman ak ekip swen ou oswa plan ou. Pataje a pa voye anyen pou ou.';

  @override
  String get cnShare => 'Pataje';

  @override
  String get cnMethodFax => 'Faks';

  @override
  String get cnMethodMail => 'Lapòs';

  @override
  String get cnMethodPortal => 'Pòtal sou entènèt';

  @override
  String get cnMethodInPerson => 'An pèsòn';

  @override
  String get cnMethodCareTeam => 'Ekip swen an voye l';

  @override
  String get cnMethodOther => 'Lòt';

  @override
  String get cnPacketNoDraftFinal =>
      'Pou yon desizyon final, pakè a gen sèlman rezime pou doktè a. Pa gen bwouyon revizyon premye nivo ki fèt.';

  @override
  String get cnPacketNoDraftEob =>
      'Pou yon faktirasyon oswa yon relve avantaj, pakè a gen sèlman rezime pou doktè a.';

  @override
  String get cnPacketNoDraftReauth =>
      'Pou yon avi renouvèlman, pakè a gen sèlman rezime pou doktè a, pou ede ekip swen ou fè renouvèlman an.';

  @override
  String get cnPacketNoDraftOther =>
      'Sof si lèt la se yon refi oswa yon demann enfòmasyon, pakè a gen sèlman rezime pou doktè a.';

  @override
  String get cnPacketContains => 'Pakè sa a pral gen';

  @override
  String get cnPartSummary => 'Rezime pou doktè a (1 paj)';

  @override
  String get cnPartDraft =>
      'Bwouyon demann revizyon (pou ekip swen ou konplete)';

  @override
  String get cnPartLetterText => 'Anèks: tèks lèt la';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rezime rejis ajoute',
      one: '1 rezime rejis ajoute',
      zero: 'Pa gen rezime rejis ki ajoute',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => 'Ajoute tèks lèt la kòm anèks';

  @override
  String get cnPacketStale =>
      'Enfòmasyon oswa rejis yo chanje depi dènye pakè a. Kreye l ankò pou mete l ajou.';

  @override
  String get cnGenerating => 'Ap kreye…';

  @override
  String get cnGeneratePacket => 'Kreye pakè revizyon';

  @override
  String get cnSaveOrPrint => 'Sove oswa enprime';

  @override
  String get cnISentIt => 'Mwen voye l';

  @override
  String cnSharedOn(String date) {
    return 'Pataje le $date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return 'Ou di ou voye l le $date ($method)';
  }

  @override
  String get cnTabDoctorSummary => 'Rezime pou doktè a';

  @override
  String get cnTabReviewDraft => 'Bwouyon demann revizyon';

  @override
  String get cnSentExplain =>
      'Note ki lè ak kijan ou voye l. CoverNote pa voye l epi li pa swiv okenn desizyon.';

  @override
  String get cnSave => 'Sove';

  @override
  String get cnCtxPm25 => 'PM2.5 (AQI)';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => 'Imidite deyò';

  @override
  String cnObservedOn(String date) {
    return 'Obsève le $date';
  }

  @override
  String get cnCtxIntro =>
      'Mezi lè ki soti nan yon sous ki gen non ak bagay ou remake yo, kenbe separe. Ajoute yo nan yon dosye sèlman si yo ede eksplike rejis ou yo.';

  @override
  String get cnCtxReadings => 'Mezi lè';

  @override
  String get cnCtxReadingsNote =>
      'Mezi rejyonal pou jou yo te obsève yo. Yo pa mezire gaz echapman trafik lakay ou.';

  @override
  String get cnCtxAddReading => 'Ajoute yon mezi';

  @override
  String get cnCtxReports => 'Sa ou remake';

  @override
  String get cnCtxReportsNote => 'Pwòp rapò ou yo. Yo pa mezi.';

  @override
  String get cnCtxAddReport => 'Ajoute sa ou remake';

  @override
  String get cnReportExhaust => 'Gaz echapman fò tou pre';

  @override
  String get cnReportWater => 'Dlo antre lakay';

  @override
  String get cnReportDamp => 'Yon kote anndan ki mouye oswa ki santi moufin';

  @override
  String cnOnDate(String date) {
    return 'Dat: $date';
  }

  @override
  String get cnNoteOptional => 'Nòt (opsyonèl)';

  @override
  String get cnCtxWhat => 'Mezi';

  @override
  String get cnCtxHumidityNote =>
      'Imidite deyò se done move tan. Li pa montre imidite oswa mwazi anndan kay ou.';

  @override
  String get cnCtxValue => 'Valè';

  @override
  String get cnCtxValueInvalid => 'Antre yon nimewo valab.';

  @override
  String get cnCtxSource => 'Sous';

  @override
  String get cnCtxSourceHelp =>
      'Kote nimewo a soti, pa egzanp AirNow oswa yon moniteur lokal';

  @override
  String get cnCtxSourceRequired => 'Ajoute sous la.';

  @override
  String get cnCtxPlace => 'Kote (kòd postal oswa vil, opsyonèl)';

  @override
  String get cnRecordsSignInBody =>
      'Konekte pou kenbe rejis medikaman, sentòm ak kontèks lokal.';

  @override
  String get cnRecordsYourRecords => 'Rejis ou yo';

  @override
  String get cnRecMedicationSub => 'Medikaman ak dòz ou pran';

  @override
  String get cnRecDailyLog => 'Jounal chak jou';

  @override
  String get cnRecDailyLogSub => 'Sentòm ak itilizasyon inalatè';

  @override
  String get cnRecLocalContextSub => 'Mezi lè ak sa ou remake';

  @override
  String get cnHelp => 'Èd';

  @override
  String get cnUrgentHelp => 'Èd ijan';

  @override
  String get cnUrgentHelpSub => 'Etap pou yon ijans respiratwa ak pou rele 911';

  @override
  String cnLast30Days(String from, String to) {
    return '30 dènye jou yo ($from – $to)';
  }

  @override
  String get cnNoSchedule => 'Pa gen orè regilye ki mete';

  @override
  String get cnRecordsUnknownNote =>
      'Jou ki pa gen antre rete enkonu. Yo pa konte yo kòm rate.';

  @override
  String get cnDeleteAccountTitle => 'Efase kont ou?';

  @override
  String get cnDeleteAccountBody =>
      'Sa efase kont ou, dosye ou yo, lèt ou te voye yo, pakè yo ak rejis yo pou toutan. Pa gen mwayen pou defèt sa.';

  @override
  String get cnTypeDelete => 'Tape DELETE pou konfime';

  @override
  String get cnDeleteAccount => 'Efase kont';

  @override
  String get cnAccountDeleted => 'Kont ou efase.';

  @override
  String get cnDeleteAccountFailed =>
      'Pa t kapab efase kont lan. Eseye ankò pita.';

  @override
  String get cnAccountSignedOut => 'Ou pa konekte.';

  @override
  String get cnLanguage => 'Lang';

  @override
  String get cnServiceStatus => 'Sèvis lekti lèt';

  @override
  String get cnServiceReady => 'Disponib';

  @override
  String get cnServiceUnavailableShort => 'Pa disponib kounye a';

  @override
  String get cnChecking => 'Ap verifye…';

  @override
  String get cnServiceUnknown => 'Pa verifye';

  @override
  String get cnCheck => 'Verifye';

  @override
  String get cnAbout => 'Sou aplikasyon an';

  @override
  String get cnAboutBody =>
      'CoverNote ede ou li lèt asirans sou medikaman epi prepare dokiman pou ekip swen ou. Li pa voye anyen bay plan ou, li pa deside si yo kouvri l, epi li pa konsèy medikal.';

  @override
  String get cnDangerZone => 'Efase kont';

  @override
  String get cnErrServiceUnavailable => 'Lektè lèt la pa disponib kounye a.';

  @override
  String get cnErrBusy => 'Sèvis la okipe. Tann yon minit epi eseye ankò.';

  @override
  String get cnErrSlow => 'Lekti a pran twòp tan. Eseye ankò.';

  @override
  String get cnErrUnreadable =>
      'Pa t kapab li paj yo. Refè foto yo nan pi bon limyè.';

  @override
  String get cnErrTooManyPages => 'Twòp paj. Voye jiska 10.';

  @override
  String get cnErrTooLarge =>
      'Fichye yo two gwo. Itilize mwens paj oswa paj ki pi piti.';

  @override
  String get cnErrStale =>
      'Dosye sa a chanje sou yon lòt aparèy. N ap montre dènye vèsyon an.';

  @override
  String get cnErrCaseGone => 'Dosye sa a pa egziste ankò.';

  @override
  String get cnErrAttempts =>
      'Lekti a echwe plizyè fwa. Ranplase paj yo oswa eseye ankò pita.';

  @override
  String get cnErrDemoUpload =>
      'Demo a pa ka li fichye. Konekte pou eskane pwòp lèt ou.';

  @override
  String cnErrGeneric(String code) {
    return 'Gen yon bagay ki pa mache ($code). Eseye ankò.';
  }

  @override
  String get cnLanguageChoose => 'Chwazi lang ou';

  @override
  String get cnLanguageNote =>
      'Yon lojisyèl te tradui kèk tèks, kidonk yo ka gen erè. Non medikaman, dòz, dat ak sitasyon ki soti nan lèt ou yo pa janm tradui.';

  @override
  String get cnLanguageButtonTooltip => 'Chanje lang';

  @override
  String get cnPacketEnglishNote =>
      'Pakè a ekri an Anglè pou ekip swen ou ka li l.';

  @override
  String get cnReasonMissingInformation =>
      'Plan an di li pa t resevwa tout enfòmasyon li te bezwen.';

  @override
  String get cnReasonStepTherapy =>
      'Plan an vle ou eseye lòt medikaman anvan (Step therapy).';

  @override
  String get cnReasonMedicalNecessity =>
      'Plan an di li pa t kapab konfime ke medikaman sa a nesesè pou rezon medikal.';

  @override
  String get cnReasonFormulary =>
      'Plan an di medikaman sa a pa sou lis medikaman li kouvri yo (Formulary).';

  @override
  String get cnReasonQuantityLimit =>
      'Plan an di kantite yo mande a depase sa li kouvri.';

  @override
  String get cnReasonEligibility =>
      'Plan an di sa a pa kouvri dapre règ kouvèti li yo.';

  @override
  String get cnReasonOther =>
      'Lèt la bay yon lòt rezon. Louvri sitasyon ki soti nan lèt la pou li l.';

  @override
  String get cnReqHintMedHistory =>
      'Medikaman ou te pran avan yo ak sa w ap pran kounye a';

  @override
  String get cnReqHintVisitNotes => 'Nòt ki soti nan vizit doktè ou yo';

  @override
  String get cnReqHintTestResults => 'Rezilta tès oswa laboratwa';

  @override
  String get cnReqHintDoctorStatement => 'Yon deklarasyon ki soti nan doktè ou';
}
