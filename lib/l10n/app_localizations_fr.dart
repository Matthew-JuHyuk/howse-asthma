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
      'Supabase n’est pas encore configuré.\nAjoutez SUPABASE_URL et SUPABASE_ANON_KEY dans votre fichier .env.';

  @override
  String get homeGreeting => 'Bonjour';

  @override
  String get homeAirQualityTitle => 'Qualité de l’air près de vous';

  @override
  String get homeWeatherTitle => 'Météo près de vous';

  @override
  String get asthmaRiskLow => 'Risque d’asthme faible';

  @override
  String get asthmaRiskModerate => 'Risque d’asthme modéré';

  @override
  String get asthmaRiskHigh => 'Risque d’asthme élevé — prenez des précautions';

  @override
  String get medicationLogTitle => 'Journal des médicaments';

  @override
  String get medicationLogAddButton =>
      'Enregistrer l’utilisation d’inhalateur / médicament';

  @override
  String get medicationNameLabel => 'Nom du médicament';

  @override
  String get medicationDoseLabel => 'Dose';

  @override
  String get medicationTimeLabel => 'Heure de prise';

  @override
  String get medicationEffectivenessLabel => 'Cela a-t-il aidé ?';

  @override
  String get reportTitle => 'Rapport d’assurance';

  @override
  String get reportGenerateButton =>
      'Générer un rapport pour le médecin / l’assurance';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguageLabel => 'Langue';

  @override
  String get settingsLocationLabel => 'Localisation';

  @override
  String get notificationAttackWarningTitle =>
      'Alerte de risque de crise d’asthme';

  @override
  String get mockContinue => 'Continuer';

  @override
  String get mockSignUpTitle => 'Créer un compte';

  @override
  String get mockChooseRole => 'Choisissez votre rôle';

  @override
  String get mockRolePatient => 'Patient';

  @override
  String get mockRolePatientHint =>
      'Suivre le risque aérien et l’usage de l’inhalateur';

  @override
  String get mockRoleProvider => 'Professionnel';

  @override
  String get mockRoleProviderHint => 'Absent de cet aperçu de design';

  @override
  String get mockProviderNotInPreview =>
      'Les écrans professionnel ne sont pas dans cet aperçu patient.';

  @override
  String get mockBiometricTitle => 'Déverrouiller';

  @override
  String get mockBiometricHint =>
      'Utilisez la biométrie pour déverrouiller Howse Asthma (aperçu design).';

  @override
  String get mockUnlock => 'Déverrouiller';

  @override
  String get mockUsePassword => 'Utiliser le mot de passe à la place';

  @override
  String get mockOnboardingTitle => 'Configuration patient';

  @override
  String get mockHomeLocation => 'Domicile';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => 'Contact d’urgence';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => 'Code d’invitation du professionnel';

  @override
  String get mockFinishOnboarding => 'Aller à l’accueil';

  @override
  String get mockAllScreens => 'Tous les écrans';

  @override
  String get mockAllScreensHint =>
      'Ouvrir n’importe quel Screen ID pour revue de design';

  @override
  String get mockStateCalm => 'CALM';

  @override
  String get mockStateWarning => 'WARNING';

  @override
  String get mockHomeCalmMessage =>
      'L’air semble gérable à proximité. Enregistrez l’inhalateur à tout moment.';

  @override
  String get mockHomeWarnMessage =>
      'Risque élevé à proximité. Limitez l’exposition outdoor et gardez votre inhalateur prêt.';

  @override
  String get mockRiskScore => 'Score de risque';

  @override
  String get mockDummyLocation => 'Près de Newark, NJ';

  @override
  String get mockEnvDetail => 'Détail environnement';

  @override
  String get mockForecast => 'Prévisions';

  @override
  String get mockForecastHint =>
      'Perspectives air et pollen des prochains jours';

  @override
  String get mockAlertPreview => 'Écran d’alerte';

  @override
  String get mockAlertPreviewHint => 'Aperçu de l’écran d’alerte de risque';

  @override
  String get mockShowWarningHome => 'Aperçu accueil WARNING';

  @override
  String get mockBackToCalmHome => 'Retour';

  @override
  String get mockPanicCta => 'Mode panique';

  @override
  String get mockTrapAxis => 'TRAP / suie';

  @override
  String get mockFloodAxis => 'Crue soudaine';

  @override
  String get mockPollenAxis => 'Pollen';

  @override
  String get mockForecastDayHint => 'Perspectives AQI · TRAP · Pollen';

  @override
  String get mockActSurvey => 'Questionnaire ACT';

  @override
  String get mockActHint => '5 questions en pictogrammes (4 semaines)';

  @override
  String get mockPdcCheck => 'Contrôle PDC quotidien';

  @override
  String get mockPdcHint => 'Observance en un toucher';

  @override
  String get mockInhalerEvent => 'Inhalateur enregistré';

  @override
  String get mockActIntro =>
      'Répondez sur les 4 dernières semaines. Aperçu design — les réponses ne sont pas enregistrées.';

  @override
  String get mockQuestion => 'Question';

  @override
  String get mockSubmit => 'Envoyer';

  @override
  String get mockPdcPrompt =>
      'Avez-vous pris votre médicament de fond aujourd’hui ?';

  @override
  String get mockTakenYes => 'Oui, je l’ai pris';

  @override
  String get mockTakenNo => 'Pas aujourd’hui';

  @override
  String get mockEvidenceSummary => 'Votre résumé de preuves';

  @override
  String get mockEvidenceBody =>
      'Résumé factice pour le support PA/LMN. Aperçu design uniquement.';

  @override
  String get mockInhalerEvents30d => 'Événements inhalateur (30 j)';

  @override
  String get mockActScore => 'Dernier ACT';

  @override
  String get mockPdcRate => 'PDC (30 j)';

  @override
  String get mockLocationsTitle => 'Lieux enregistrés';

  @override
  String get mockLocationsHint => 'Surveillance domicile et travail';

  @override
  String get mockWorkLocation => 'Travail';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => 'Ajouter un lieu';

  @override
  String get mockRewardTitle => 'Récompenses';

  @override
  String get mockDraftBanner =>
      'BROUILLON — points et bons en aperçu uniquement';

  @override
  String get mockPointsBalance => 'Solde de points';

  @override
  String get mockVoucherTitle => 'Bon banque alimentaire';

  @override
  String get mockVoucherHint => 'Échanger des points (liste d’attente)';

  @override
  String get mockDonateTitle => 'Faire un don';

  @override
  String get mockDonateHint => 'Dons tiers uniquement';

  @override
  String get mockRewardHistory => 'Historique';

  @override
  String get mockRewardHistoryHint => 'Points et dons';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank (démo)';

  @override
  String get mockVoucherCost => '50 points · valeur 10 \$ (brouillon)';

  @override
  String get mockJoinWaitlist => 'Rejoindre la liste d’attente';

  @override
  String get mockDonateTransparency =>
      'Les dons passent par une plateforme associative vérifiée. Howse Asthma ne stocke jamais les données de carte.';

  @override
  String get mockDonateCta => 'Ouvrir le don (externe)';

  @override
  String get mockExternalOnly =>
      'Le fournisseur de dons externe n’est pas branché dans l’aperçu design.';

  @override
  String get mockSignOutPreview => 'Se déconnecter (aperçu)';

  @override
  String get mockOpenAuthFlow => 'Ouvrir le flux d’auth';

  @override
  String get mockAlertBody =>
      'Le risque a augmenté près de votre position. Consultez les détails environnementaux.';

  @override
  String get mockDismiss => 'Ignorer';

  @override
  String get mockPanicTitle => 'Besoin d’aide maintenant ?';

  @override
  String get mockPanicStep1Body =>
      'Étape 1 — Restez avec votre inhalateur. Continuez pour les contacts d’urgence.';

  @override
  String get mockPanicStep2Title => 'Appeler à l’aide';

  @override
  String get mockPanicStep2Body =>
      'Aperçu design : les boutons n’émettent pas d’appel réel. Sur appareil, l’étape 2 utilise des liens tel:.';

  @override
  String get mockCall911 => 'Appeler le 911';

  @override
  String get mockCallGuardian => 'Appeler le contact d’urgence';

  @override
  String get mockFeelingBetter => 'Je me sens mieux';

  @override
  String get mockTabHome => 'Accueil';

  @override
  String get mockTabLog => 'Journal';

  @override
  String get mockTabReport => 'Rapport';

  @override
  String get mockTabReward => 'Récompenses';

  @override
  String get mockTabSettings => 'Paramètres';

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
      'Suivre le risque de qualité de l’air et l’usage de l’inhalateur';

  @override
  String get authRoleProvider => 'Professionnel';

  @override
  String get authRoleProviderHint =>
      'Lier des patients et examiner les preuves cliniques';

  @override
  String get authFullNameLabel => 'Nom complet';

  @override
  String get authNpiLabel => 'Numéro NPI';

  @override
  String get authNpiHelper =>
      'Identifiant national de prestataire à 10 chiffres';

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
      'Indiquez qui vous êtes pour ouvrir le bon écran d’accueil.';

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
  String get authErrorGeneric =>
      'Une erreur s’est produite. Veuillez réessayer.';

  @override
  String get authErrorInvalidCredentials => 'E-mail ou mot de passe incorrect';

  @override
  String get authErrorEmailTaken => 'Un compte existe déjà avec cet e-mail';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirmez votre e-mail avant de vous connecter';

  @override
  String get authErrorWeakPassword => 'Le mot de passe est trop faible';

  @override
  String get authErrorRateLimited => 'Trop de tentatives. Réessayez plus tard.';

  @override
  String get authBiometricTitle => 'Déverrouiller Howse Asthma';

  @override
  String get authBiometricHint => 'Utilisez la biométrie pour continuer';

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
      'Exiger la biométrie à l’ouverture de l’app';

  @override
  String get authBiometricUnavailable =>
      'La biométrie n’est pas disponible sur cet appareil';

  @override
  String get authOnboardingTitle => 'Configuration patient';

  @override
  String get authOnboardingBody =>
      'Si votre clinicien a partagé un code d’invitation de 8 caractères, saisissez-le maintenant. Vous pourrez aussi le faire plus tard dans Paramètres.';

  @override
  String get authOnboardingSkip => 'Passer pour l’instant';

  @override
  String get authInviteCodeLabel => 'Code d’invitation du professionnel';

  @override
  String get authInviteCodeHelper => '8 lettres/chiffres, expire en 24 heures';

  @override
  String get authInviteRedeem => 'Utiliser';

  @override
  String get authInviteRedeemAndContinue => 'Utiliser et continuer';

  @override
  String get authInviteInvalidFormat =>
      'Le code d’invitation doit comporter 8 lettres ou chiffres';

  @override
  String get authInviteRedeemedPending =>
      'Invitation utilisée. En attente de confirmation du professionnel.';

  @override
  String get authInviteRedeemFailed =>
      'Impossible d’utiliser le code d’invitation';

  @override
  String get authInviteIssueFailed =>
      'Impossible d’émettre le code d’invitation';

  @override
  String get authConfirmLink => 'Confirmer';

  @override
  String get authRejectLink => 'Refuser';

  @override
  String get authLinkStatusPending => 'Confirmation en attente';

  @override
  String get settingsSystemDefault => 'Par défaut du système';

  @override
  String get settingsLocationTodo =>
      'L’autorisation de localisation sera demandée dans une mise à jour ultérieure';

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
      'Les tableaux de bord cliniques patients arriveront dans une version ultérieure. Commencez par lier des patients.';

  @override
  String get providerLinkPatientsCta => 'Lier des patients';

  @override
  String get providerLinkTitle => 'Lier des patients';

  @override
  String get providerLinkIntro =>
      'Émettez un code de 8 caractères (valable 24 heures). Le patient le saisit, puis les deux côtés confirment.';

  @override
  String get providerIssueInviteCta => 'Émettre un code d’invitation';

  @override
  String get providerInviteTtlHint => 'Valable 24 heures';

  @override
  String get providerInviteCopied => 'Code d’invitation copié';

  @override
  String get providerPendingLinks => 'Liens en attente';

  @override
  String get providerNoPendingLinks => 'Aucun lien en attente';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'Patient $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'Codes d’invitation récents';

  @override
  String get providerNoInvites => 'Aucun code d’invitation pour l’instant';

  @override
  String get providerInviteConsumed => 'Utilisé';

  @override
  String get providerInviteActive => 'Actif';

  @override
  String get splashTagline =>
      'Votre bouclier intelligent contre les declencheurs';

  @override
  String get splashGetStarted => 'Commencer';

  @override
  String get splashAlreadyHaveAccount => 'Vous avez déjà un compte ?';

  @override
  String get splashSignIn => 'Se connecter';

  @override
  String get authForgotPassword => 'Mot de passe oublié ?';

  @override
  String get authNoAccount => 'Pas de compte ?';

  @override
  String get authUseBiometricHint =>
      'Utilisez Face ID ou l’empreinte pour déverrouiller';

  @override
  String get authTouchSensorHint => 'Touchez le capteur ou regardez la caméra';

  @override
  String get navLog => 'Journal';

  @override
  String get navReport => 'Rapport';

  @override
  String get navRewards => 'Récompenses';

  @override
  String get mockChooseLanguage => 'Choisir la langue';

  @override
  String get mockYourLocation => 'Votre localisation';

  @override
  String get mockUseCurrentLocation => 'Utiliser la position actuelle';

  @override
  String get mockLocationTrapOnly =>
      'La localisation sert uniquement aux données de qualité de l’air TRAP';

  @override
  String get mockLabelYourPlace => 'Étiqueter votre lieu';

  @override
  String get mockSchool => 'École';

  @override
  String get mockWork => 'Travail';

  @override
  String get mockOther => 'Autre';

  @override
  String get mockEmergencyOnePerson =>
      'Une personne à appeler en cas d’urgence';

  @override
  String get mockContactName => 'Nom du contact';

  @override
  String get mockPhoneNumber => 'Numéro de téléphone';

  @override
  String get mockProviderPairing => 'Appariement professionnel';

  @override
  String get mockPairingOptional =>
      'Facultatif — vous pourrez l’ajouter plus tard dans Paramètres';

  @override
  String get mockNext => 'Suivant';

  @override
  String get mockProfessionalProfile => 'Profil professionnel';

  @override
  String get mockStep2Of4 => 'Étape 2 sur 4';

  @override
  String get mockTellPractice => 'Parlez-nous de votre cabinet médical';

  @override
  String get mockSpecialtyLabel => 'Spécialité';

  @override
  String get mockClinicLabel => 'Nom du cabinet / clinique';

  @override
  String get mockNpiFormatOnly =>
      'Vérification de format uniquement. La vérification NPI a lieu après l’envoi.';

  @override
  String get mockCredentialsSecure =>
      'Vos identifiants sont chiffrés et stockés en sécurité. Nous ne partageons jamais les données du professionnel sans consentement.';

  @override
  String get oneTapFab => '1-Tap';

  @override
  String get oneTapLoggedSnack => 'Utilisation d’inhalateur enregistrée (stub)';

  @override
  String get oneTapLoggedOk => 'Utilisation d’inhalateur enregistrée';

  @override
  String get oneTapLoggedFailed =>
      'Impossible d’enregistrer l’utilisation. Réessayez.';

  @override
  String get homeDailySummary => 'Voici votre résumé quotidien';

  @override
  String get homeWarningBanner =>
      'Risque élevé à proximité. Limitez l’exposition outdoor et gardez votre inhalateur prêt.';

  @override
  String get homeEnvFactors => 'Facteurs environnementaux';

  @override
  String get homeViewDetails => 'Voir les détails';

  @override
  String get homeFloodActive => 'Alerte active';

  @override
  String get homeFloodNone => 'Aucune';

  @override
  String get homeLastInhalerNone =>
      'Aucune utilisation d’inhalateur enregistrée';

  @override
  String get homeLastInhalerToday =>
      'Dernière utilisation d’inhalateur : aujourd’hui';

  @override
  String homeLastInhalerDays(int days) {
    return 'Dernière utilisation d’inhalateur : il y a $days jours';
  }

  @override
  String get locationServiceDisabled =>
      'Activez les services de localisation pour voir le risque d’asthme à proximité.';

  @override
  String get locationPermissionDenied =>
      'L’autorisation de localisation est nécessaire pour la qualité de l’air près de vous.';

  @override
  String get locationPermissionDeniedForever =>
      'L’autorisation de localisation est bloquée. Ouvrez les paramètres pour l’autoriser.';

  @override
  String get locationUnavailable =>
      'Impossible d’obtenir votre position. Tirez pour actualiser ou réessayez.';

  @override
  String get locationOutOfServiceArea =>
      'Howse Asthma prend actuellement en charge les localisations aux États-Unis.';

  @override
  String get locationOpenSettings => 'Ouvrir les paramètres';

  @override
  String get locationStatusGranted => 'L’accès à la localisation est activé';

  @override
  String get njOnlyDataNotice =>
      'Données NJ uniquement : la pondération AADT fret s’applique seulement au New Jersey. TRAP utilise toujours les capteurs de qualité de l’air à l’échelle nationale.';

  @override
  String get homeDegradedNotice =>
      'Certaines sources de qualité de l’air sont indisponibles. Le risque peut être incomplet — à traiter avec prudence.';

  @override
  String logWeekSummary(int count) {
    return '$count événements inhalateur sur les 7 derniers jours';
  }

  @override
  String get logFilterAll => 'Tous';

  @override
  String get logFilterRescue => 'Secours';

  @override
  String get logFilterPanic => 'Panique';

  @override
  String get logEmpty =>
      'Aucun événement inhalateur. Utilisez 1-Tap sur Accueil.';

  @override
  String get logEventRescue => 'Utilisation d’inhalateur';

  @override
  String get logEventPanic => 'Utilisation d’inhalateur en panique';

  @override
  String get actTitle => 'Contrôle de l’asthme';

  @override
  String get actPast4Weeks => 'Au cours des 4 dernières semaines';

  @override
  String get actQ1 =>
      'Combien de temps votre asthme vous a-t-il empêché d’en faire autant au travail, à l’école ou à la maison ?';

  @override
  String get actQ2 => 'À quelle fréquence avez-vous eu un essoufflement ?';

  @override
  String get actQ3 =>
      'À quelle fréquence vos symptômes d’asthme vous ont-ils réveillé la nuit ou plus tôt que d’habitude ?';

  @override
  String get actQ4 =>
      'À quelle fréquence avez-vous utilisé votre inhalateur de secours ou un nébuliseur ?';

  @override
  String get actQ5 => 'Comment évalueriez-vous le contrôle de votre asthme ?';

  @override
  String get actOpt1 => 'Tout le temps';

  @override
  String get actOpt2 => 'La plupart du temps';

  @override
  String get actOpt3 => 'Parfois';

  @override
  String get actOpt4 => 'Rarement';

  @override
  String get actOpt5 => 'Jamais';

  @override
  String get actQ5Opt1 => 'Pas contrôlé du tout';

  @override
  String get actQ5Opt2 => 'Mal contrôlé';

  @override
  String get actQ5Opt3 => 'Assez contrôlé';

  @override
  String get actQ5Opt4 => 'Bien contrôlé';

  @override
  String get actQ5Opt5 => 'Parfaitement contrôlé';

  @override
  String actSaved(int score) {
    return 'ACT enregistré. Score : $score';
  }

  @override
  String get pdcTitle => 'Contrôle quotidien du médicament';

  @override
  String get pdcSaved => 'Contrôle quotidien enregistré';

  @override
  String get pdcAlreadyYes =>
      'Vous avez déjà marqué aujourd’hui comme pris. Vous pouvez le modifier.';

  @override
  String get pdcAlreadyNo =>
      'Vous avez déjà marqué aujourd’hui comme non pris. Vous pouvez le modifier.';

  @override
  String pdcStreakHint(int taken, int total, String rate) {
    return '30 derniers jours : $taken sur $total jours pris ($rate)';
  }

  @override
  String get panicEmergencyBadge => 'URGENCE';

  @override
  String get panicBreatheTitle => 'Respirez et utilisez l’inhalateur';

  @override
  String get panicTakeInhalerNow => 'Prendre l’inhalateur maintenant';

  @override
  String get panicNeedHelp => 'J’ai besoin de plus d’aide';

  @override
  String get panicNoAutoDial =>
      'Les boutons ouvrent le composeur. Les appels ne sont jamais passés automatiquement.';

  @override
  String panicCallNamed(String name) {
    return 'Appeler $name';
  }

  @override
  String get panicDialFailed =>
      'Impossible d’ouvrir le composeur sur cet appareil.';

  @override
  String get alertTitle => 'Alerte de risque';

  @override
  String get alertFcmPendingNote =>
      'Si les notifications push sont activées sur cet appareil, vous recevez aussi une notification système lorsque l’app est en arrière-plan.';

  @override
  String get reportEvidenceBody =>
      'Résumé de l’usage d’inhalateur, ACT et PDC pour revue clinique ou d’assurance.';

  @override
  String get reportShareTodo =>
      'Partage / export arrivera avec le flux PA/LMN du professionnel.';

  @override
  String get settingsAlertsTitle => 'Préférences d’alertes';

  @override
  String get settingsAlertRisk => 'Alertes de risque';

  @override
  String get settingsAlertRiskHint =>
      'Lorsque votre score de risque composite atteint 3 ou plus';

  @override
  String get settingsAlertHome => 'Alertes des lieux enregistrés';

  @override
  String get settingsAlertHomeHint =>
      'Lorsque le risque augmente aux lieux enregistrés (domicile, école, travail)';

  @override
  String get settingsAlertLocationEntry => 'Alertes d’entrée dans une zone';

  @override
  String get settingsAlertLocationEntryHint =>
      'Lorsque vous entrez dans une zone à risque plus élevé pendant que l’app est ouverte';

  @override
  String get settingsSecurityTitle => 'Sécurité';

  @override
  String get emergencyContactRequired =>
      'Saisissez un nom de contact et un numéro de téléphone';

  @override
  String get emergencyContactInvalidPhone =>
      'Saisissez un téléphone valide avec indicatif pays (E.164), ex. +15551234567';

  @override
  String get emergencyContactSaved => 'Contact d’urgence enregistré';

  @override
  String get emergencyContactSave => 'Enregistrer le contact';

  @override
  String get emergencyContactPhoneHint =>
      'Incluez l’indicatif pays (E.164), ex. +15551234567';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get envTitle => 'Environnement';

  @override
  String get envThreeAxis => 'Trois axes de risque';

  @override
  String get envTrapDetail =>
      'Indicateur de pollution de l’air liée au trafic (capteurs + poids fret NJ optionnel)';

  @override
  String get envTrapTip =>
      'Limitez l’effort outdoor lorsque TRAP est ÉLEVÉ ou CRITIQUE.';

  @override
  String get envFloodDetail =>
      'Alertes NWS de crue soudaine / cours d’eau près de vous';

  @override
  String get envFloodTipClear =>
      'Aucune alerte active de crue soudaine pour cette zone.';

  @override
  String get envPollenDetail => 'Prévisions pollen Google';

  @override
  String get envPollenTip =>
      'Gardez les fenêtres fermées et rincez-vous après l’extérieur lorsque l’UPI est élevé.';

  @override
  String envUsgsRate(String rate) {
    return 'Variation de débit USGS : $rate ft/h';
  }

  @override
  String envUpdatedAt(String when) {
    return 'Mis à jour : $when';
  }

  @override
  String get envSourcesLabel => 'Sources de données';

  @override
  String get envOverallCalm =>
      'Les conditions semblent gérables. Gardez votre inhalateur à proximité.';

  @override
  String get forecastIntro =>
      'Perspectives pour les prochaines périodes via les prévisions air et pollen.';

  @override
  String get forecastEmpty =>
      'La série de prévisions n’est pas encore disponible. Tirez pour actualiser.';

  @override
  String get forecastPollenNote =>
      'Le pollen utilise l’API Google Pollen (pas Open-Meteo). Les cartes de chaleur ne sont pas utilisées dans le MVP.';

  @override
  String forecastDayPollen(int upi, String type) {
    return 'Pollen UPI $upi · $type';
  }

  @override
  String forecastDayAqi(int aqi) {
    return 'AQI US max $aqi';
  }

  @override
  String get forecastMorning => 'Matin';

  @override
  String get forecastAfternoon => 'Après-midi';

  @override
  String get forecastEvening => 'Soir';

  @override
  String get locationsTitle => 'Mes lieux';

  @override
  String get locationsIntro =>
      'Les lieux enregistrés sont surveillés pour les changements de risque pendant que l’app est ouverte. Le push OS en arrière-plan nécessite Firebase (prochainement).';

  @override
  String get locationsEmpty =>
      'Aucun lieu enregistré. Ajoutez votre position actuelle.';

  @override
  String get locationsAddTitle => 'Enregistrer ce lieu';

  @override
  String get locationsNameLabel => 'Étiquette';

  @override
  String get locationsAddCurrent => 'Ajouter la position actuelle';

  @override
  String get locationsSaveFailed =>
      'Impossible de mettre à jour les lieux. Réessayez.';

  @override
  String get locationsCapReached =>
      'Vous pouvez enregistrer jusqu’à 10 lieux. Supprimez-en un pour en ajouter un autre.';

  @override
  String get locationsDeleteTitle => 'Retirer le lieu ?';

  @override
  String locationsDeleteBody(String name) {
    return 'Retirer « $name » de la surveillance ?';
  }

  @override
  String locationsCoords(String lat, String lon) {
    return '$lat, $lon';
  }

  @override
  String get locationsPrimaryBadge => 'Principal';

  @override
  String get stateOnlyNjApplied => 'NJ uniquement : poids AADT fret appliqué';

  @override
  String get stateOnlyNjNotApplied =>
      'NJ uniquement : poids AADT fret non appliqué';

  @override
  String get stateOnlyNjAppliedHint =>
      'Les comptages trafic NJDOT proches ont augmenté le poids TRAP. Les capteurs de qualité de l’air s’appliquent toujours à l’échelle nationale.';

  @override
  String get stateOnlyNjOutsideHint =>
      'Vous êtes hors du New Jersey. La pondération AADT fret est NJ uniquement ; TRAP utilise toujours les capteurs d’air.';

  @override
  String get stateOnlyNjNoCountHint =>
      'Aucun comptage fret NJDOT à proximité. TRAP utilise les capteurs de qualité de l’air sans le poids fret NJ.';

  @override
  String get settingsDeveloperSection => 'Développeur';

  @override
  String get settingsApiConsole => 'Console API';

  @override
  String get debugApiConsoleBanner =>
      'DEBUG — ne pas capturer d’écran pour un partage public';

  @override
  String get appTagline => 'Votre bouclier intelligent contre les declencheurs';

  @override
  String get welcomeBenefit1 => 'Alertes proactives qualite de l air et pollen';

  @override
  String get welcomeBenefit2 => 'Un check-in quotidien de 3 secondes';

  @override
  String get welcomeBenefit3 =>
      'Rapports fiables a partager avec votre clinicien';

  @override
  String get welcomeContinueEmail => 'ou continuer avec e-mail';

  @override
  String get welcomeTermsAgree =>
      'J accepte les Conditions et la Politique de confidentialite';

  @override
  String get welcomeTermsPending =>
      'Les liens juridiques seront disponibles une fois publies.';

  @override
  String get welcomeClinicianLink => 'Je suis clinicien';

  @override
  String get checkInWelcomeHome => 'Bienvenue chez vous !';

  @override
  String get checkInQuestion => 'Comment respirez-vous en ce moment ?';

  @override
  String get checkInBreathUsual => 'Comme d habitude';

  @override
  String get checkInBreathTight => 'Un peu serree';

  @override
  String get checkInBreathSymptoms => 'J ai des symptomes';

  @override
  String get checkInAeroPoints => 'Premier check-in termine ! +5 AeroPoints';

  @override
  String get shieldLocationTitle => 'Activez votre bouclier preventif';

  @override
  String get shieldLocationBody =>
      'Activez le bouclier autour de vous — la localisation est necessaire pour l air et le pollen.';

  @override
  String get shieldLocationAllow => 'Autoriser la localisation';

  @override
  String get shieldLocationNotNow => 'Pas maintenant';
}
