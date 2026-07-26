// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Howse Asthma';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginEmailLabel => 'E-mail';

  @override
  String get loginPasswordLabel => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get signUpButton => 'Créer un compte';

  @override
  String get supabaseNotConfigured =>
      'Supabase n\'est pas encore configuré.\nAjoutez SUPABASE_URL et SUPABASE_ANON_KEY dans votre fichier .env.';

  @override
  String get homeGreeting => 'Bonjour';

  @override
  String get homeAirQualityTitle => 'Qualité de l\'air près de vous';

  @override
  String get homeWeatherTitle => 'Météo près de vous';

  @override
  String get asthmaRiskLow => 'Risque d\'asthme faible';

  @override
  String get asthmaRiskModerate => 'Risque d\'asthme modéré';

  @override
  String get asthmaRiskHigh =>
      'Risque d\'asthme élevé - prenez des précautions';

  @override
  String get medicationLogTitle => 'Journal des médicaments';

  @override
  String get medicationLogAddButton =>
      'Enregistrer l\'utilisation d\'un inhalateur / médicament';

  @override
  String get medicationNameLabel => 'Nom du médicament';

  @override
  String get medicationDoseLabel => 'Dose';

  @override
  String get medicationTimeLabel => 'Heure de prise';

  @override
  String get medicationEffectivenessLabel => 'Est-ce que cela a aidé ?';

  @override
  String get reportTitle => 'Rapport pour l\'assurance';

  @override
  String get reportGenerateButton =>
      'Générer un rapport pour le médecin / l\'assurance';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguageLabel => 'Langue';

  @override
  String get settingsLocationLabel => 'Localisation';

  @override
  String get notificationAttackWarningTitle =>
      'Alerte de risque de crise d\'asthme';

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
  String get navHome => 'Accueil';

  @override
  String get signUpTitle => 'Créer un compte';

  @override
  String get authChooseRole => 'Choisissez votre rôle';

  @override
  String get authRolePatient => 'Patient';

  @override
  String get authRolePatientHint =>
      'Suivre le risque air et l\'usage de l\'inhalateur';

  @override
  String get authRoleProvider => 'Professionnel';

  @override
  String get authRoleProviderHint =>
      'Lier des patients et revoir les preuves cliniques';

  @override
  String get authFullNameLabel => 'Nom complet';

  @override
  String get authNpiLabel => 'Numéro NPI';

  @override
  String get authNpiHelper => 'Identifiant national à 10 chiffres';

  @override
  String get authOrContinueWith => 'ou continuer avec';

  @override
  String get authContinueGoogle => 'Continuer avec Google';

  @override
  String get authContinueApple => 'Continuer avec Apple';

  @override
  String get authCheckEmailTitle => 'Vérifiez votre e-mail';

  @override
  String authCheckEmailBody(String email) {
    return 'Nous avons envoyé un lien de confirmation à $email. Ouvrez-le, puis connectez-vous.';
  }

  @override
  String get authBackToSignIn => 'Retour à la connexion';

  @override
  String get authCompleteProfileTitle => 'Complétez votre profil';

  @override
  String get authCompleteProfileBody =>
      'Indiquez qui vous êtes pour ouvrir le bon écran d\'accueil.';

  @override
  String get authSaveProfile => 'Enregistrer le profil';

  @override
  String get authSignOut => 'Se déconnecter';

  @override
  String get authRetry => 'Réessayer';

  @override
  String get authWorking => 'Traitement…';

  @override
  String get authValidationInvalidEmail => 'Saisissez un e-mail valide';

  @override
  String get authValidationPasswordMin =>
      'Le mot de passe doit contenir au moins 8 caractères';

  @override
  String get authValidationNameRequired => 'Le nom est obligatoire';

  @override
  String get authValidationInvalidNpi =>
      'Saisissez un NPI valide à 10 chiffres';

  @override
  String get authErrorGeneric => 'Une erreur s\'est produite. Réessayez.';

  @override
  String get authErrorInvalidCredentials => 'E-mail ou mot de passe incorrect';

  @override
  String get authErrorEmailTaken => 'Un compte existe déjà avec cet e-mail';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirmez votre e-mail avant de vous connecter';

  @override
  String get authErrorWeakPassword => 'Mot de passe trop faible';

  @override
  String get authErrorRateLimited => 'Trop de tentatives. Réessayez plus tard.';

  @override
  String get authBiometricTitle => 'Déverrouiller Howse Asthma';

  @override
  String get authBiometricHint =>
      'Utilisez votre empreinte ou votre visage pour continuer.';

  @override
  String get authBiometricReason => 'Déverrouiller Howse Asthma';

  @override
  String get authBiometricUnlock => 'Déverrouiller';

  @override
  String get authBiometricFailed =>
      'Échec du déverrouillage biométrique. Réessayez.';

  @override
  String get authBiometricToggle => 'Déverrouillage biométrique';

  @override
  String get authBiometricToggleHint =>
      'Exiger la biométrie à l\'ouverture de l\'application';

  @override
  String get authBiometricUnavailable =>
      'La biométrie n\'est pas disponible sur cet appareil';

  @override
  String get authOnboardingTitle => 'Configuration patient';

  @override
  String get authOnboardingBody =>
      'Si votre clinicien a partagé un code à 6 chiffres, saisissez-le maintenant. Vous pourrez aussi le faire plus tard dans Réglages.';

  @override
  String get authOnboardingSkip => 'Passer pour l\'instant';

  @override
  String get authInviteCodeLabel => 'Code d\'invitation';

  @override
  String get authInviteCodeHelper => '6 chiffres, expire en 24 heures';

  @override
  String get authInviteRedeem => 'Utiliser';

  @override
  String get authInviteRedeemAndContinue => 'Utiliser et continuer';

  @override
  String get authInviteInvalidFormat => 'Le code doit comporter 6 chiffres';

  @override
  String get authInviteRedeemedPending =>
      'Code utilisé. En attente de confirmation du professionnel.';

  @override
  String get authInviteRedeemFailed => 'Impossible d\'utiliser le code';

  @override
  String get authInviteIssueFailed => 'Impossible d\'émettre le code';

  @override
  String get authConfirmLink => 'Confirmer';

  @override
  String get authRejectLink => 'Refuser';

  @override
  String get authLinkStatusPending => 'En attente de confirmation';

  @override
  String get settingsSystemDefault => 'Par défaut du système';

  @override
  String get settingsLocationTodo =>
      'L\'autorisation de localisation sera demandée plus tard';

  @override
  String get providerHomeTab => 'Accueil';

  @override
  String get providerLinkTab => 'Lien';

  @override
  String get providerHomeTitle => 'Accueil professionnel';

  @override
  String providerHomeWelcome(String email) {
    return 'Connecté en tant que $email';
  }

  @override
  String get providerHomePlaceholder =>
      'Les tableaux de bord cliniques arriveront plus tard. Commencez par lier des patients.';

  @override
  String get providerLinkPatientsCta => 'Lier des patients';

  @override
  String get providerLinkTitle => 'Lier des patients';

  @override
  String get providerLinkIntro =>
      'Émettez un code à 6 chiffres (valide 24 h). Le patient le saisit, puis les deux confirment.';

  @override
  String get providerIssueInviteCta => 'Émettre un code';

  @override
  String get providerInviteTtlHint => 'Valable 24 heures';

  @override
  String get providerInviteCopied => 'Code copié';

  @override
  String get providerPendingLinks => 'Liens en attente';

  @override
  String get providerNoPendingLinks => 'Aucun lien en attente';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'Patient $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'Codes récents';

  @override
  String get providerNoInvites => 'Aucun code pour l\'instant';

  @override
  String get providerInviteConsumed => 'Utilisé';

  @override
  String get providerInviteActive => 'Actif';

  @override
  String get splashTagline => 'Smarter asthma prevention for every family.';

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
      'Push delivery needs Firebase setup (coming next). This screen is the in-app alert.';

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
  String get settingsAlertHome => 'Home Alerts';

  @override
  String get settingsAlertHomeHint =>
      'When air quality changes at saved places (Phase 5)';

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
}
