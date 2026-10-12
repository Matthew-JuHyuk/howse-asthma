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

  @override
  String get settingsPushMaster => 'Notifications push';

  @override
  String get settingsPushMasterHint =>
      'Interrupteur general des alertes Howse Asthma sur cet appareil';

  @override
  String get pushConsentTitle => 'Anticipez les declencheurs d asthme';

  @override
  String get pushConsentBody =>
      'Nous pouvons envoyer des alertes simples si le risque air ou inondation monte. Modifiable dans Reglages.';

  @override
  String get pushConsentAllow => 'Autoriser les notifications';

  @override
  String get pushConsentNotNow => 'Pas maintenant';

  @override
  String homeNearPlace(String place) {
    return 'Pres de $place';
  }

  @override
  String get homeStaleLocationNotice =>
      'Derniere lecture affichee en attendant la localisation.';

  @override
  String get homeStaleRefreshNotice =>
      'Derniere lecture affichee. Tirez pour actualiser quand vous etes en ligne.';

  @override
  String get homeStaleCacheNotice =>
      'Cette lecture peut etre un peu ancienne. Prudence.';

  @override
  String get homeNowDoThisHeading =>
      'Faites ceci maintenant pour reduire le risque de crise';

  @override
  String get homeDraftBadge => 'Brouillon';

  @override
  String get homeNowDoThisFloodTitle => 'Restez a l interieur si possible';

  @override
  String get homeNowDoThisFloodBody =>
      'Les alertes d inondation signalent souvent l humidite. Gardez l inhalateur a portee.';

  @override
  String get homeNowDoThisTrapTitle => 'Reduisez l activite en exterieur';

  @override
  String get homeNowDoThisTrapBody =>
      'La pollution liee au trafic semble elevee. Sorties courtes seulement si besoin.';

  @override
  String get homeNowDoThisPollenTitle =>
      'Gardez les fenetres fermees pour l instant';

  @override
  String get homeNowDoThisPollenBody =>
      'Le pollen est eleve. Rincez le visage et changez de vetements apres l exterieur.';

  @override
  String get homeNowDoThisRiskTitle => 'Allez doucement dehors';

  @override
  String get homeNowDoThisRiskBody =>
      'Le risque global est eleve. Gardez l inhalateur et reposez-vous si la respiration est dure.';

  @override
  String get homeNowDoThisCalmTitle => 'Fenetre plus calme pour aerer';

  @override
  String get homeNowDoThisCalmBody =>
      'L air exterieur semble gerable. Une courte aeration peut aider — inhalateur a portee.';

  @override
  String get homeAdherenceSection => 'Votre semaine d inhalateur';

  @override
  String get adherenceWeekHint =>
      'Les jours colores ont des usages enregistres (1-Tap).';

  @override
  String get homeMoldAxis => 'Risque moisissure';

  @override
  String get homeMoldElevatedDraft => 'Signal d humidite eleve';

  @override
  String get homeMoldPendingDraft => 'Humidite en attente';

  @override
  String get homeFloodAsMoldFactor => 'Facteur inondation / humidite';

  @override
  String get homeForecastLink => 'Apercu court';

  @override
  String homeForecastHint(String date, String score) {
    return 'Jour suivant $date · score $score';
  }

  @override
  String homeSensorDistance(
    String km,
    String mi,
    String radiusKm,
    String radiusMi,
  ) {
    return 'Capteur le plus proche $km km ($mi mi) · recherche ~$radiusKm km ($radiusMi mi)';
  }

  @override
  String homeSensorNearestOnly(String km, String mi) {
    return 'Capteur le plus proche $km km ($mi mi)';
  }

  @override
  String homeSensorRadiusOnly(String km, String mi) {
    return 'Recherche capteurs ~$km km ($mi mi)';
  }

  @override
  String get weekdayMonShort => 'L';

  @override
  String get weekdayTueShort => 'M';

  @override
  String get weekdayWedShort => 'M';

  @override
  String get weekdayThuShort => 'J';

  @override
  String get weekdayFriShort => 'V';

  @override
  String get weekdaySatShort => 'S';

  @override
  String get weekdaySunShort => 'D';

  @override
  String get logAdherenceCalendarTitle => 'Calendrier d adherence';

  @override
  String get homeNowDoThisMoldTitle => 'Reduisez l humidite interieure';

  @override
  String get homeNowDoThisMoldBody =>
      'L humidite exterieure semble elevee. Utilisez un ventilateur ou un deshumidificateur si possible.';

  @override
  String get homeMoldDetail =>
      'Conditions d humidite a proximite (proxy exterieur — pas un compte de spores)';

  @override
  String get homeMoldTip =>
      'Risque moisissure eleve : gardez les pieces plus seches. Les inondations augmentent le risque.';

  @override
  String homeMoldRh(String pct) {
    return 'Humidite $pct%';
  }

  @override
  String homeMoldTempF(String temp) {
    return '$temp°F';
  }

  @override
  String homeMoldDewF(String temp) {
    return 'Point de rosee $temp°F';
  }

  @override
  String homeMoldWetHours(int hours) {
    return '$hours heures humides (24h)';
  }

  @override
  String get homeMoldProxyDisclaimer => 'Estimation exterieure seulement';

  @override
  String get homeVentilationSnack =>
      'L air exterieur semble plus calme — une courte aeration peut aider.';

  @override
  String get settingsAlertPositive => 'Conseils d air frais';

  @override
  String get settingsAlertPositiveHint =>
      'Quand l air exterieur semble plus sur pour ouvrir un peu (regles brouillon)';

  @override
  String get settingsBgTitle => 'Actualisation en arriere-plan';

  @override
  String get settingsBgBody =>
      'Howse Asthma actualise l air proche pendant l utilisation. Pas de localisation Toujours dans cette version.';

  @override
  String get settingsBgRefresh => 'Actualiser pendant l utilisation';

  @override
  String get settingsBgRefreshHint =>
      'Mettre a jour le risque en bougeant ou en gardant l app ouverte';

  @override
  String get s5AboutApp => 'À propos de Howse Asthma';

  @override
  String get s5AboutAppBody =>
      'Howse Asthma vous aide à noter vos symptômes et l’usage de votre inhalateur, et à préparer un résumé pour votre médecin. L’app ne pose pas de diagnostic et ne conseille pas de traitement.';

  @override
  String get s5ActNotice =>
      'Vos réponses sont enregistrées pour les partager avec votre médecin. Ce questionnaire n’a pas été vérifié avec le barème officiel, donc l’app n’affiche pas de score.';

  @override
  String get s5ActSaved => 'Vos réponses ont été enregistrées.';

  @override
  String get s5ActSubtitle => '5 questions sur les 4 dernières semaines';

  @override
  String get s5ActTitle => 'Questionnaire de contrôle de l’asthme';

  @override
  String get s5AddDetails => 'Ajouter des détails';

  @override
  String get s5AddRecord => 'Ajouter une entrée';

  @override
  String get s5AlertArrive => 'À l’arrivée dans un lieu';

  @override
  String get s5AlertArriveHint =>
      'Quand les conditions sont plus mauvaises là où vous arrivez. Seulement lorsque l’app est ouverte.';

  @override
  String get s5AlertFreshAirHint =>
      'Quand la qualité de l’air, le pollen et les informations d’inondation semblent calmes dehors. Information générale, pas un conseil médical.';

  @override
  String get s5AlertSavedPlaces => 'Lieux enregistrés';

  @override
  String get s5AlertSavedPlacesHint =>
      'Quand les conditions se dégradent dans un lieu que vous avez enregistré.';

  @override
  String get s5AlertWorse => 'Quand les conditions se dégradent';

  @override
  String get s5AlertWorseHint =>
      'Quand la qualité de l’air, le pollen ou les informations d’inondation près de vous se dégradent. La même alerte n’est pas répétée dans l’heure.';

  @override
  String get s5AqiGood => 'Bonne';

  @override
  String get s5AqiModerate => 'Modérée';

  @override
  String get s5AqiUsg => 'Mauvaise pour les groupes sensibles';

  @override
  String get s5AqiUnhealthy => 'Mauvaise';

  @override
  String get s5AqiVeryUnhealthy => 'Très mauvaise';

  @override
  String get s5AqiHazardous => 'Dangereuse';

  @override
  String s5AqiValue(String category, int aqi) {
    return '$category (AQI $aqi)';
  }

  @override
  String get s5Back => 'Retour';

  @override
  String get s5BarrierCost => 'Coût des médicaments';

  @override
  String get s5BarrierHardToGet => 'Difficile d’obtenir les médicaments';

  @override
  String get s5BarrierHardToUnderstand =>
      'Instructions difficiles à comprendre';

  @override
  String get s5BarrierHowToUse => 'Comment utiliser mes médicaments';

  @override
  String get s5BarrierNone => 'Aucune difficulté';

  @override
  String get s5BarrierOtherHint => 'Décrivez avec vos mots (facultatif)';

  @override
  String get s5Cancel => 'Annuler';

  @override
  String get s5Change => 'Changer';

  @override
  String get s5ChoosePlace => 'Choisir un lieu';

  @override
  String get s5Close => 'Fermer';

  @override
  String get s5DataSourcesTitle => 'Sources des données';

  @override
  String get s5DataSourcesBody =>
      'Qualité de l’air : EPA AirNow (États-Unis), Open-Meteo et capteurs PurpleAir à proximité.\nPollen : Google Pollen API (Universal Pollen Index).\nMétéo et humidité : Open-Meteo.\nAlertes d’inondation : National Weather Service (NWS). Niveau des cours d’eau : U.S. Geological Survey (USGS).\nComptages de trafic (New Jersey seulement) : New Jersey Department of Transportation (NJDOT).\nLes valeurs peuvent arriver en retard ou manquer. Elles décrivent l’extérieur, pas votre santé.';

  @override
  String get s5Delete => 'Supprimer';

  @override
  String get s5DeleteConfirm => 'Supprimer cette entrée ?';

  @override
  String get s5DeleteFailed => 'Impossible de supprimer. Veuillez réessayer.';

  @override
  String get s5Edit => 'Modifier';

  @override
  String get s5EnglishVersion => 'Anglais (pour le médecin)';

  @override
  String get s5EntryRemoved => 'Entrée annulée.';

  @override
  String get s5EnvAirDetail =>
      'Indice de qualité de l’air de l’EPA des États-Unis, à partir de stations publiques et de capteurs proches. Il décrit l’air extérieur de votre zone, pas seulement les gaz d’échappement.';

  @override
  String get s5EnvAirQuality => 'Qualité de l’air';

  @override
  String get s5EnvAlertsHeading => 'Alertes d’environnement';

  @override
  String get s5EnvCardTitle => 'Votre environnement aujourd’hui';

  @override
  String get s5EnvFlood => 'Alertes d’inondation';

  @override
  String get s5EnvFloodDetail =>
      'Alertes publiques du National Weather Service (NWS).';

  @override
  String get s5EnvForecast => 'Prévision de l’environnement';

  @override
  String get s5EnvHumidity => 'Humidité';

  @override
  String get s5EnvHumidityDetail =>
      'Donnée météo extérieure. Ce n’est pas une mesure d’humidité intérieure ni de moisissure.';

  @override
  String get s5EnvLoadFailed =>
      'Impossible de charger les informations d’environnement.';

  @override
  String get s5EnvNeedPlace =>
      'Choisissez un lieu pour voir votre environnement.';

  @override
  String get s5EnvNotAvailable => 'Indisponible';

  @override
  String get s5EnvOlderNotice => 'Voici la dernière information vérifiée.';

  @override
  String get s5EnvPollen => 'Indice de pollen';

  @override
  String get s5EnvPollenDetail =>
      'Universal Pollen Index de Google, de 0 (aucun) à 5 (très élevé). Un chiffre bas ne signifie pas que c’est sans risque pour tout le monde.';

  @override
  String get s5EnvSeeDetails => 'Voir le détail de l’environnement';

  @override
  String get s5EnvUnavailable =>
      'Les informations d’environnement ne sont pas disponibles pour le moment.';

  @override
  String get s5FewRecordsNotice =>
      'Il y a peu d’entrées, donc certaines parties du résumé peuvent être vides.';

  @override
  String get s5FgRefreshTitle =>
      'Actualiser l’environnement pendant l’utilisation';

  @override
  String get s5FgRefreshHint =>
      'Vérifie votre zone tant que l’app est ouverte. Cela ne fonctionne pas en arrière-plan.';

  @override
  String get s5FieldDate => 'Date';

  @override
  String get s5FieldMedication => 'Médicament';

  @override
  String get s5FieldNote => 'Note (facultatif)';

  @override
  String get s5FieldPuffs => 'Nombre de bouffées (facultatif)';

  @override
  String get s5FieldReason => 'Motif (facultatif)';

  @override
  String get s5FieldTime => 'Heure';

  @override
  String get s5FilterAll => 'Tout';

  @override
  String get s5FilterInhaler => 'Inhalateur';

  @override
  String get s5FilterMedCheck => 'Prise de médicament';

  @override
  String get s5FilterSymptoms => 'Symptômes';

  @override
  String get s5FloodIssued => 'Alerte d’inondation émise';

  @override
  String get s5FloodNone => 'Aucune alerte d’inondation';

  @override
  String get s5FloodUnknown => 'Impossible de vérifier les alertes';

  @override
  String s5ForecastCheckedAt(String time) {
    return 'Vérifié à $time';
  }

  @override
  String s5ForecastValidFor(String date) {
    return 'Prévision pour le $date';
  }

  @override
  String get s5FromUrgentHelp => 'Noté depuis Aide urgente';

  @override
  String get s5HomeStateEmpty =>
      'Faites votre première entrée. Vous pourrez ainsi préparer ce que vous voulez dire à votre consultation.';

  @override
  String s5HomeStateQuestions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Vous avez $n questions pour votre médecin.',
      one: 'Vous avez 1 question pour votre médecin.',
    );
    return '$_temp0';
  }

  @override
  String s5HomeStateRecords(int n) {
    return 'Jours avec des entrées sur les 7 derniers jours : $n';
  }

  @override
  String get s5HomeSubtitle =>
      'Rassemblez vos entrées pour les montrer à votre consultation.';

  @override
  String get s5HomeTitle => 'Notez comment vous vous sentez aujourd’hui';

  @override
  String s5HumidityValue(int rh) {
    return 'Humidité extérieure $rh %';
  }

  @override
  String get s5IncludeEnvironment => 'Environnement (facultatif)';

  @override
  String get s5IncludeEnvironmentHint =>
      'Ajoute la qualité de l’air, le pollen et les alertes d’inondation d’aujourd’hui. Votre position exacte n’est pas incluse.';

  @override
  String get s5InhalerEditTitle => 'Détails de l’usage de l’inhalateur';

  @override
  String get s5InhalerEntry => 'Usage de l’inhalateur';

  @override
  String get s5InhalerLogged => 'Usage de l’inhalateur enregistré.';

  @override
  String get s5InhalerOneEntryHint =>
      'Chaque enregistrement compte pour 1 entrée. Il n’est pas compté comme 1 bouffée ni comme 1 jour.';

  @override
  String s5InhalerUnknownCount(int n) {
    return 'Médicament non identifié : $n';
  }

  @override
  String get s5InsCost => 'Difficultés de coût';

  @override
  String get s5InsDenial => 'Motif de refus (s’il vous a été indiqué)';

  @override
  String get s5InsMedHistory => 'Médicaments déjà essayés';

  @override
  String get s5InsuranceIntro =>
      'Regroupez des informations pour les formulaires de votre médecin.';

  @override
  String get s5InsuranceLimits =>
      'Tout est facultatif. Cette app n’envoie rien à votre assurance et ne décide aucune approbation.';

  @override
  String get s5InsuranceTitle => 'Préparer les formulaires d’assurance';

  @override
  String s5LanguageName(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'anglais',
      'es': 'espagnol',
      'fr': 'français',
      'ko': 'coréen',
      'ja': 'japonais',
      'zh': 'chinois',
      'other': 'une autre langue',
    });
    return '$_temp0';
  }

  @override
  String get s5Last30Days => '30 derniers jours';

  @override
  String get s5Last7Days => '7 derniers jours';

  @override
  String get s5LogInhaler => 'Noter l’inhalateur';

  @override
  String get s5LogLegend =>
      'Chaque ligne est 1 entrée enregistrée. Les jours sans entrée indiquent « Non enregistré », ce qui n’est pas zéro.';

  @override
  String get s5LogSymptoms => 'Noter les symptômes';

  @override
  String get s5MedAdd => 'Ajouter un médicament';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return 'Utilisé $a · Non utilisé $b · Je ne sais plus $c · Non enregistré $d (jours)';
  }

  @override
  String get s5MedCheckIntro =>
      'Vous indiquez vous-même si vous avez pris votre médicament. Ce n’est pas basé sur les données de la pharmacie.';

  @override
  String get s5MedCheckQuestion =>
      'Avez-vous pris votre médicament comme prévu ?';

  @override
  String get s5MedCheckTitle => 'Prise de médicament d’aujourd’hui';

  @override
  String get s5MedChooseHint =>
      'Choisissez un médicament, ou « Je ne connais pas le nom ».';

  @override
  String get s5MedDailyCheck => 'Vérification quotidienne';

  @override
  String get s5MedDailyCheckHint =>
      'Affiche « Prise de médicament d’aujourd’hui » sur l’accueil. Activez seulement si votre médecin vous a demandé de le prendre chaque jour.';

  @override
  String get s5MedDefault => 'Médicament par défaut';

  @override
  String get s5MedDefaultHint =>
      'Utilisé quand vous appuyez sur « Noter l’inhalateur » à l’accueil.';

  @override
  String get s5MedEdit => 'Modifier le médicament';

  @override
  String get s5MedNameLabel => 'Nom du médicament (comme sur l’étiquette)';

  @override
  String get s5MedNotApplicable => 'Pas prévu aujourd’hui';

  @override
  String s5MedNotApplicableDays(int n) {
    return 'Non prévu : $n jours';
  }

  @override
  String get s5MedNotRecorded => 'Médicament non renseigné';

  @override
  String get s5MedNotSure => 'Je ne me souviens pas';

  @override
  String get s5MedNotUsed => 'Je ne l’ai pas pris';

  @override
  String get s5MedOther => 'Un autre nom';

  @override
  String get s5MedOtherHint => 'Saisissez le nom du médicament';

  @override
  String get s5MedReasonCost => 'Coût';

  @override
  String get s5MedReasonForgot => 'Oubli';

  @override
  String get s5MedReasonNoMedicine => 'Je n’avais pas le médicament';

  @override
  String get s5MedReasonQuestion => 'Motif (facultatif)';

  @override
  String get s5MedUnknown => 'Je ne connais pas le nom';

  @override
  String get s5MedUnknownShort => 'Médicament non identifié';

  @override
  String get s5MedUsed => 'Je l’ai pris';

  @override
  String get s5MyLanguage => 'Ma langue';

  @override
  String get s5MyLogTitle => 'Mon journal';

  @override
  String get s5MyMedsEmpty => 'Aucun médicament enregistré pour le moment.';

  @override
  String get s5MyMedsHint =>
      'Utilisez les noms que vous avez confirmés pour noter plus vite. Ce n’est pas une recommandation de dose.';

  @override
  String get s5MyMedsOpen => 'Gérer mes médicaments';

  @override
  String get s5MyMedsTitle => 'Mes médicaments';

  @override
  String get s5NavEnvironment => 'Environnement';

  @override
  String get s5NavLog => 'Journal';

  @override
  String get s5NavVisitPrep => 'Consultation';

  @override
  String get s5NoAnswer => 'Je préfère ne pas répondre';

  @override
  String get s5NoRecordsYet => 'Aucune entrée pour le moment';

  @override
  String s5NoSymptomDays(int n) {
    return 'Jours notés « aucun symptôme » : $n';
  }

  @override
  String get s5NotRecorded => 'Non enregistré';

  @override
  String get s5NotRecordedToday => 'Non enregistré aujourd’hui';

  @override
  String s5NotTranslatedLine(String language, String text) {
    return '[Non traduit · original en $language] $text';
  }

  @override
  String get s5OsNotificationsOff =>
      'Les notifications de Howse Asthma sont désactivées dans les réglages du téléphone, donc les alertes ne s’afficheront pas.';

  @override
  String get s5PdfAboutMedCheck =>
      'Les prises de médicament sont déclarées par le patient. Ce ne sont pas des données de pharmacie ni un PDC (proportion de jours couverts).';

  @override
  String get s5PdfAboutNoScore =>
      'Aucun score de questionnaire ni score de risque de l’app n’est inclus.';

  @override
  String get s5PdfAboutPatientReported =>
      'Toutes les entrées ont été saisies par le patient dans l’app Howse Asthma et n’ont pas été vérifiées.';

  @override
  String get s5PdfAppendix => 'Annexe : notes du patient';

  @override
  String s5PdfDaysNotRecorded(int n) {
    return 'Jours sans entrée de symptômes (non enregistré) : $n';
  }

  @override
  String get s5PdfDisclaimer =>
      'Ce résumé contient des informations déclarées par le patient, pour lecture par le médecin. Ce n’est ni un diagnostic ni une décision d’autorisation préalable.';

  @override
  String get s5PdfEnvNote =>
      'Conditions extérieures générales au moment de la création du résumé. La position n’est pas incluse.';

  @override
  String get s5PdfFailed =>
      'Impossible de créer le PDF. Vos entrées sont conservées. Veuillez réessayer.';

  @override
  String get s5PdfFontFailed =>
      'Impossible de préparer les polices du PDF. Vérifiez votre connexion internet et réessayez.';

  @override
  String s5PdfGeneratedAt(String time) {
    return 'Créé : $time';
  }

  @override
  String s5PdfInhalerByMed(String name, int n) {
    return '$name : $n';
  }

  @override
  String s5PdfInhalerMedNotRecorded(int n) {
    return 'Médicament non renseigné : $n';
  }

  @override
  String s5PdfInhalerUnknown(int n) {
    return 'Médicament non identifié par le patient : $n';
  }

  @override
  String s5PdfInhalerUses(int n, int days) {
    return 'Entrées d’usage de l’inhalateur : $n (sur $days jours)';
  }

  @override
  String get s5PdfIsEnglish =>
      'Le PDF est créé en anglais. Le texte que vous avez saisi reste dans votre langue.';

  @override
  String get s5PdfMedNamesAsEntered =>
      'Les noms de médicaments apparaissent tels que le patient les a saisis.';

  @override
  String get s5PdfNotRecorded => 'Non enregistré';

  @override
  String s5PdfNotUsedReason(String label, int n) {
    return 'Motif de non-prise (déclaré) — $label : $n jours';
  }

  @override
  String get s5PdfOutdated =>
      'Vos entrées ou réponses ont changé depuis le dernier PDF. Créez un nouveau PDF pour inclure les changements.';

  @override
  String s5PdfPeriod(String start, String end, int days) {
    return 'Période : $start – $end ($days jours)';
  }

  @override
  String s5PdfReasonCount(String label, int n) {
    return 'Motif — $label : $n';
  }

  @override
  String s5PdfRecordedDays(int n) {
    return 'Jours avec une entrée du patient : $n';
  }

  @override
  String get s5PdfSectionAboutData => 'À propos de ces données';

  @override
  String get s5PdfSectionBarriers =>
      'Difficultés pour recevoir des soins (déclarées)';

  @override
  String get s5PdfSectionEnvironment => 'Environnement (référence)';

  @override
  String get s5PdfSectionInhaler => 'Usage de l’inhalateur';

  @override
  String get s5PdfSectionInsurance =>
      'Notes pour les formulaires (fournies par le patient)';

  @override
  String get s5PdfSectionMedChecks =>
      'Prise de médicament déclarée par le patient';

  @override
  String get s5PdfSectionQuestions => 'Questions du patient';

  @override
  String get s5PdfSectionSymptoms => 'Symptômes';

  @override
  String s5PdfSymptomCodeDays(String label, int n) {
    return '$label : $n jours';
  }

  @override
  String s5PdfSymptomDays(int n, int days) {
    return 'Jours avec des symptômes : $n sur $days';
  }

  @override
  String s5PdfSymptomOtherDays(int n) {
    return 'Autres symptômes décrits par le patient : $n jours';
  }

  @override
  String get s5PdfTitle => 'Résumé d’asthme déclaré par le patient';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return 'Période : $days jours · Jours avec des entrées : $n';
  }

  @override
  String get s5PhoneHint =>
      'Indiquez l’indicatif du pays, par exemple +1 201 555 0123';

  @override
  String get s5PhoneInvalid =>
      'Saisissez un nom et un numéro avec l’indicatif du pays, par exemple +1 201 555 0123.';

  @override
  String get s5PollenGrass => 'Graminées';

  @override
  String s5PollenMainType(String type) {
    return 'Type principal : $type';
  }

  @override
  String get s5PollenTree => 'Arbres';

  @override
  String get s5PollenWeed => 'Herbacées';

  @override
  String get s5PrepareVisit => 'Préparer ma consultation';

  @override
  String get s5PreviewEditHint =>
      'Pour modifier une question ou une note, revenez à l’écran précédent. Pour corriger les chiffres, modifiez l’entrée dans Mon journal.';

  @override
  String get s5PreviewSummary => 'Voir le résumé de consultation';

  @override
  String get s5PreviewTitle => 'Aperçu du résumé';

  @override
  String s5PuffsValue(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n bouffées',
      one: '1 bouffée',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return 'Question $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return 'Question $n sur $total';
  }

  @override
  String get s5ReasonBeforeActivity => 'Avant une activité';

  @override
  String get s5ReasonOther => 'Autre';

  @override
  String get s5ReasonSymptoms => 'À cause de symptômes';

  @override
  String s5RecentInhaler(int n) {
    return 'Entrées d’inhalateur : $n';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return 'Jours avec des symptômes : $n';
  }

  @override
  String get s5RecentTitle => '7 derniers jours';

  @override
  String get s5RecordsLoadFailed =>
      'Impossible de charger vos entrées. Veuillez réessayer.';

  @override
  String get s5RecordsManageHint =>
      'Vous pouvez modifier ou supprimer des entrées dans Mon journal. La suppression demande toujours une confirmation.';

  @override
  String get s5Refresh => 'Actualiser';

  @override
  String get s5Reload => 'Recharger';

  @override
  String get s5Save => 'Enregistrer';

  @override
  String get s5Saved => 'Enregistré.';

  @override
  String get s5SavedPlacesHint =>
      'Lieux enregistrés, comme le domicile, l’école ou le travail';

  @override
  String get s5SaveFailed =>
      'Impossible d’enregistrer. Vos saisies sont conservées.';

  @override
  String get s5SavePdf => 'Enregistrer le PDF';

  @override
  String get s5SettingsAlerts => 'Alertes';

  @override
  String get s5SettingsArea => 'Zone';

  @override
  String get s5SettingsHelp => 'Aide';

  @override
  String get s5SettingsLanguageNote =>
      'Le résumé de consultation est créé en anglais. Vous pouvez le comparer avec votre langue avant de le partager.';

  @override
  String get s5SettingsSecurityData => 'Sécurité et données';

  @override
  String get s5Share => 'Partager';

  @override
  String get s5SourcesAir =>
      'Qualité de l’air : EPA AirNow, Open-Meteo, PurpleAir';

  @override
  String get s5SourcesFlood =>
      'Alertes d’inondation : National Weather Service';

  @override
  String get s5SourcesNjTraffic =>
      'Les données de trafic ne sont utilisées qu’au New Jersey.';

  @override
  String get s5SourcesNoRiskScore =>
      'Le score interne de l’app n’est pas un risque de crise d’asthme et n’est pas affiché.';

  @override
  String get s5SourcesPollen => 'Pollen : Google Pollen API';

  @override
  String get s5SourcesTitle => 'Sources et limites';

  @override
  String get s5SourcesWeather => 'Météo et humidité : Open-Meteo';

  @override
  String get s5StatusLatest => 'À jour';

  @override
  String get s5StatusOlder => 'Donnée plus ancienne';

  @override
  String get s5StatusUnavailable => 'Impossible de vérifier pour le moment';

  @override
  String get s5SymActivityLimited => 'Activités limitées';

  @override
  String get s5SymCough => 'Toux';

  @override
  String get s5SymNightWaking => 'Réveil la nuit';

  @override
  String get s5SymNone => 'Aucun symptôme';

  @override
  String get s5SymOther => 'Autre chose';

  @override
  String get s5SymOtherHint => 'Décrivez avec vos mots';

  @override
  String get s5SymShortBreath => 'Difficulté à respirer';

  @override
  String get s5SymWheeze => 'Sifflement';

  @override
  String get s5SymptomEditTitle => 'Modifier les symptômes';

  @override
  String get s5SymptomEntry => 'Symptômes';

  @override
  String get s5SymptomNoneHint =>
      'Les jours que vous ne notez pas apparaissent comme « Non enregistré », et non comme « Aucun symptôme ».';

  @override
  String get s5SymptomQuestion => 'Qu’avez-vous ressenti ?';

  @override
  String get s5Today => 'Aujourd’hui';

  @override
  String get s5Undo => 'Annuler';

  @override
  String s5UntranslatedNotice(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other:
          '$n éléments ne sont pas traduits. Ils apparaissent dans le PDF anglais dans votre langue, avec la mention « Not translated ». Vérifiez-les.',
      one:
          '1 élément n’est pas traduit. Il apparaît dans le PDF anglais dans votre langue, avec la mention « Not translated ». Vérifiez-le.',
    );
    return '$_temp0';
  }

  @override
  String s5UpdatedAt(String time) {
    return 'Mis à jour $time';
  }

  @override
  String get s5UpiHigh => 'Élevé';

  @override
  String get s5UpiLow => 'Bas';

  @override
  String get s5UpiModerate => 'Modéré';

  @override
  String get s5UpiNone => 'Aucun';

  @override
  String s5UpiValue(int upi, String category) {
    return '$upi sur 5 · $category';
  }

  @override
  String get s5UpiVeryHigh => 'Très élevé';

  @override
  String get s5UpiVeryLow => 'Très bas';

  @override
  String get s5UrgentActionPlan =>
      'Si votre médecin vous a remis un plan d’action pour l’asthme, suivez-le.';

  @override
  String get s5UrgentCall911Locked => 'Aide urgente : appeler le 911';

  @override
  String get s5UrgentHelp => 'Aide urgente';

  @override
  String get s5UrgentIntro =>
      'Si respirer est très difficile ou ne s’améliore pas, appelez le 911.';

  @override
  String get s5UrgentLogHint =>
      'Facultatif : vous pouvez noter que vous avez utilisé votre inhalateur.';

  @override
  String get s5UrgentNoContact =>
      'Aucun contact d’urgence pour le moment. Ajoutez-en un dans Paramètres → Aide.';

  @override
  String s5UsingMedication(String name) {
    return 'Sera noté : $name';
  }

  @override
  String get s5ViewMyLog => 'Voir mon journal';

  @override
  String get s5VisitBarriers =>
      'Avez-vous eu des difficultés à recevoir vos soins ?';

  @override
  String s5VisitCardDetail(int days, int recorded, int questions) {
    return '$days derniers jours · Jours avec des entrées : $recorded · Questions : $questions';
  }

  @override
  String get s5VisitCardTitle => 'À montrer lors de votre consultation';

  @override
  String get s5VisitInclude => 'Entrées à inclure';

  @override
  String get s5VisitIntro =>
      'Organisez vos symptômes et vos questions pour les montrer à votre médecin.';

  @override
  String get s5VisitPeriod => 'Période du résumé';

  @override
  String get s5VisitPrepTitle => 'Préparer la consultation';

  @override
  String get s5VisitQuestions => 'Questions pour votre médecin';

  @override
  String get s5VisitQuestionsHint =>
      'Écrivez dans votre langue. Vous pouvez laisser vide.';

  @override
  String get s6AddTime => 'Ajouter une heure';

  @override
  String get s6AddVisit => 'Ajouter une visite que j’ai signalée';

  @override
  String get s6BringPaper => 'J’apporterai un document';

  @override
  String get s6BringPaperHint =>
      'Avoir un document ne signifie pas qu’un médecin l’a confirmé.';

  @override
  String s6DaySummary(
    String date,
    int used,
    int scheduled,
    int open,
    int symptoms,
    String env,
  ) {
    return '$date · confirmé $used/$scheduled · sans réponse $open · symptômes $symptoms · $env';
  }

  @override
  String get s6DoseLater => 'Vérifier plus tard';

  @override
  String get s6DoseNotUsed => 'Je n’ai pas pu le prendre';

  @override
  String get s6DoseUnconfirmed => 'Pas encore de réponse';

  @override
  String get s6DoseUsed => 'Je l’ai pris';

  @override
  String get s6EnvLinked => 'Environnement lié';

  @override
  String get s6EnvNoData => 'Pas de donnée d’environnement pour cette heure';

  @override
  String get s6EvidenceBody =>
      'Rassemble les notes pour votre médecin et ce qu’il reste à ajouter.';

  @override
  String get s6EvidenceNotOfficial =>
      'Liste générale. Ce n’est pas la liste officielle des exigences d’une assurance précise.';

  @override
  String get s6EvidenceTitle =>
      'Préparer les informations pour la consultation ou l’assurance';

  @override
  String get s6HideMedName =>
      'Masquer le nom du médicament sur l’écran verrouillé';

  @override
  String get s6HideMedNameHint =>
      'Le rappel arrive seulement aux heures enregistrées. Ce n’est pas une alerte toutes les 30 minutes.';

  @override
  String get s6HomeWaterNo => 'Non';

  @override
  String get s6HomeWaterQuestion =>
      'Y a-t-il eu une fuite ou une inondation à la maison ?';

  @override
  String get s6HomeWaterYes => 'Oui';

  @override
  String get s6ItemClinician =>
      'Confirmation du médecin ou documents à apporter';

  @override
  String get s6ItemEnvironment =>
      'Référence d’environnement local au moment de l’événement';

  @override
  String get s6ItemMedication => 'Nom du médicament et prescription';

  @override
  String get s6ItemSymptoms =>
      'Symptômes durables et limites dans la vie quotidienne';

  @override
  String get s6ItemUse => 'Période et prises que vous avez confirmées';

  @override
  String get s6ItemVisits =>
      'Consultations et urgences que vous avez signalées';

  @override
  String get s6NoSchedule =>
      'Aucune heure enregistrée. Ajoutez-les dans Mes médicaments.';

  @override
  String get s6OccurredLabel => 'Quand c’est arrivé';

  @override
  String get s6PdfEnvLimit =>
      'Référence régionale seulement. Cela ne montre pas l’exposition personnelle ni la cause des symptômes. Un seul AQI ne nomme pas à la fois l’ozone et les particules, et n’inclut pas le pollen.';

  @override
  String get s6PdfEnvTitle => 'Référence d’environnement (annexe)';

  @override
  String get s6PuffsEach => 'Bouffées à chaque fois';

  @override
  String s6ReminderBodyNamed(String name) {
    return 'Confirmez $name';
  }

  @override
  String get s6ReminderBodyPrivate => 'Confirmez votre médicament';

  @override
  String get s6ReminderChannel =>
      'Rappels aux heures de prise enregistrées. Pas une alerte toutes les 30 minutes.';

  @override
  String get s6ReminderTitle => 'Confirmation du médicament';

  @override
  String get s6RoleBoth => 'Chaque jour et au besoin';

  @override
  String get s6RoleController => 'Médicament quotidien';

  @override
  String get s6RoleRescue => 'Au besoin';

  @override
  String get s6ScheduleTimes => 'Heures de prise';

  @override
  String get s6StatusClinician => 'Confirmation du médecin nécessaire';

  @override
  String get s6StatusNeedInfo => 'Information à ajouter';

  @override
  String get s6StatusRecorded => 'Noté';

  @override
  String get s6TimelineTitle => 'Traitement et environnement';

  @override
  String get s6TodayDoses => 'Médicaments à confirmer aujourd’hui';

  @override
  String get s6VisitKindEr => 'Urgences (signalé par moi)';

  @override
  String get s6VisitKindOffice => 'Consultation (signalée par moi)';

  @override
  String get s6VisitKindOther => 'Autre visite (signalée par moi)';

  @override
  String get s6VisitKindUrgent => 'Soins urgents (signalés par moi)';
}
