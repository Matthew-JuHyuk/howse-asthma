// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginEmailLabel => 'E-mail';

  @override
  String get loginPasswordLabel => 'Senha';

  @override
  String get loginButton => 'Entrar';

  @override
  String get signUpButton => 'Cadastrar';

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
      'Registrar uso de bombinha / medicamento';

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
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguageLabel => 'Idioma';

  @override
  String get settingsLocationLabel => 'Location';

  @override
  String get notificationAttackWarningTitle => 'Asthma Attack Risk Alert';

  @override
  String get mockContinue => 'Continuar';

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
  String get mockUnlock => 'Desbloquear';

  @override
  String get mockUsePassword => 'Usar senha';

  @override
  String get mockOnboardingTitle => 'Patient setup';

  @override
  String get mockHomeLocation => 'Casa';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => 'Contato de emergência';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => 'Código de convite do profissional';

  @override
  String get mockFinishOnboarding => 'Go to home';

  @override
  String get mockAllScreens => 'Todas as telas';

  @override
  String get mockAllScreensHint => 'Open any Screen ID for design review';

  @override
  String get mockStateCalm => 'CALMO';

  @override
  String get mockStateWarning => 'ALERTA';

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
  String get mockForecast => 'Previsão';

  @override
  String get mockForecastHint => 'Next days air & pollen outlook';

  @override
  String get mockAlertPreview => 'Alert landing';

  @override
  String get mockAlertPreviewHint => 'Preview risk alert screen';

  @override
  String get mockShowWarningHome => 'Ver tela inicial em ALERTA';

  @override
  String get mockBackToCalmHome => 'Voltar';

  @override
  String get mockPanicCta => 'Panic mode';

  @override
  String get mockTrapAxis => 'TRAP / fuligem';

  @override
  String get mockFloodAxis => 'Enchente repentina';

  @override
  String get mockPollenAxis => 'Pólen';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · Pollen outlook';

  @override
  String get mockActSurvey => 'Questionário ACT';

  @override
  String get mockActHint => '5 perguntas com figuras (4 semanas)';

  @override
  String get mockPdcCheck => 'Verificação diária PDC';

  @override
  String get mockPdcHint => 'Adesão com um toque';

  @override
  String get mockInhalerEvent => 'Bombinha registrada';

  @override
  String get mockActIntro =>
      'Answer based on the last 4 weeks. Design preview — answers are not saved.';

  @override
  String get mockQuestion => 'Pergunta';

  @override
  String get mockSubmit => 'Enviar';

  @override
  String get mockPdcPrompt => 'Você tomou hoje o seu remédio de controle?';

  @override
  String get mockTakenYes => 'Sim, tomei';

  @override
  String get mockTakenNo => 'Hoje não';

  @override
  String get mockEvidenceSummary => 'Your evidence summary';

  @override
  String get mockEvidenceBody =>
      'Dummy summary for PA/LMN support. Design preview only.';

  @override
  String get mockInhalerEvents30d => 'Inhaler events (30d)';

  @override
  String get mockActScore => 'Último ACT';

  @override
  String get mockPdcRate => 'PDC (30 dias)';

  @override
  String get mockLocationsTitle => 'Lugares salvos';

  @override
  String get mockLocationsHint => 'Monitoramento de casa e trabalho';

  @override
  String get mockWorkLocation => 'Trabalho';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => 'Adicionar lugar';

  @override
  String get mockRewardTitle => 'Rewards';

  @override
  String get mockDraftBanner =>
      'RASCUNHO — pontos e vales são apenas uma prévia';

  @override
  String get mockPointsBalance => 'Saldo de pontos';

  @override
  String get mockVoucherTitle => 'Vale do banco de alimentos';

  @override
  String get mockVoucherHint => 'Exchange points (waitlist)';

  @override
  String get mockDonateTitle => 'Doar';

  @override
  String get mockDonateHint => 'Apenas doações por terceiros';

  @override
  String get mockRewardHistory => 'Histórico';

  @override
  String get mockRewardHistoryHint => 'Pontos e doações';

  @override
  String get mockDummyFoodBank =>
      'Banco de Alimentos Comunitário de NJ (demonstração)';

  @override
  String get mockVoucherCost => '50 pontos · valor de \$10 (rascunho)';

  @override
  String get mockJoinWaitlist => 'Entrar na lista de espera';

  @override
  String get mockDonateTransparency =>
      'As doações passam por uma plataforma verificada de organização sem fins lucrativos de terceiros. O Howse Asthma nunca guarda dados de cartão.';

  @override
  String get mockDonateCta => 'Abrir doação (externo)';

  @override
  String get mockExternalOnly =>
      'O provedor externo de doações não está conectado na prévia do design.';

  @override
  String get mockSignOutPreview => 'Sair (prévia)';

  @override
  String get mockOpenAuthFlow => 'Open auth flow';

  @override
  String get mockAlertBody =>
      'Risk rose near your location. Review environment details.';

  @override
  String get mockDismiss => 'Dispensar';

  @override
  String get mockPanicTitle => 'Need help now?';

  @override
  String get mockPanicStep1Body =>
      'Passo 1 — Fique com a sua bombinha. Continue para ver os contatos de emergência.';

  @override
  String get mockPanicStep2Title => 'Peça ajuda';

  @override
  String get mockPanicStep2Body =>
      'Prévia do design: os botões não fazem ligação de verdade. Nos aparelhos, o Passo 2 usa links tel:.';

  @override
  String get mockCall911 => 'Ligar para o 911';

  @override
  String get mockCallGuardian => 'Ligar para o contato de emergência';

  @override
  String get mockFeelingBetter => 'Estou me sentindo melhor';

  @override
  String get mockTabHome => 'Início';

  @override
  String get mockTabLog => 'Registro';

  @override
  String get mockTabReport => 'Relatório';

  @override
  String get mockTabReward => 'Recompensa';

  @override
  String get mockTabSettings => 'Configurações';

  @override
  String get navHome => 'Home';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get authChooseRole => 'Escolha o seu perfil';

  @override
  String get authRolePatient => 'Paciente';

  @override
  String get authRolePatientHint => 'Track air quality risk and inhaler use';

  @override
  String get authRoleProvider => 'Profissional de saúde';

  @override
  String get authRoleProviderHint =>
      'Link patients and review clinical evidence';

  @override
  String get authFullNameLabel => 'Nome completo';

  @override
  String get authNpiLabel => 'Número NPI';

  @override
  String get authNpiHelper => 'National Provider Identifier de 10 dígitos';

  @override
  String get authOrContinueWith => 'ou continue com';

  @override
  String get authContinueGoogle => 'Continuar com o Google';

  @override
  String get authContinueApple => 'Continuar com a Apple';

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
  String get authSignOut => 'Sair';

  @override
  String get authRetry => 'Tentar de novo';

  @override
  String get authWorking => 'Processando…';

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
  String get authErrorGeneric => 'Algo deu errado. Tente de novo.';

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
  String get authBiometricTitle => 'Desbloquear o Howse Asthma';

  @override
  String get authBiometricHint => 'Use a biometria para continuar';

  @override
  String get authBiometricReason => 'Desbloquear o Howse Asthma';

  @override
  String get authBiometricUnlock => 'Unlock';

  @override
  String get authBiometricFailed => 'Biometric unlock failed. Try again.';

  @override
  String get authBiometricToggle => 'Desbloqueio por biometria';

  @override
  String get authBiometricToggleHint => 'Exigir biometria ao abrir o app';

  @override
  String get authBiometricUnavailable =>
      'A biometria não está disponível neste aparelho';

  @override
  String get authOnboardingTitle => 'Cadastro do paciente';

  @override
  String get authOnboardingBody =>
      'If your clinician shared an 8-character invite code, enter it now. You can also do this later in Settings.';

  @override
  String get authOnboardingSkip => 'Pular por enquanto';

  @override
  String get authInviteCodeLabel => 'Código de convite do profissional';

  @override
  String get authInviteCodeHelper => '8 letras/números, vale por 24 horas';

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
  String get authInviteIssueFailed =>
      'Não foi possível gerar o código de convite';

  @override
  String get authConfirmLink => 'Confirmar';

  @override
  String get authRejectLink => 'Recusar';

  @override
  String get authLinkStatusPending => 'Aguardando confirmação';

  @override
  String get settingsSystemDefault => 'System default';

  @override
  String get settingsLocationTodo =>
      'Location permission will be requested in a later update';

  @override
  String get providerHomeTab => 'Início';

  @override
  String get providerLinkTab => 'Vincular';

  @override
  String get providerHomeTitle => 'Início do profissional';

  @override
  String providerHomeWelcome(String email) {
    return 'Conectado como $email';
  }

  @override
  String get providerHomePlaceholder =>
      'Os painéis clínicos dos pacientes chegam em uma versão futura. Comece vinculando pacientes.';

  @override
  String get providerLinkPatientsCta => 'Vincular pacientes';

  @override
  String get providerLinkTitle => 'Vincular pacientes';

  @override
  String get providerLinkIntro =>
      'Gere um código de 8 caracteres (válido por 24 horas). O paciente digita o código e depois os dois lados confirmam.';

  @override
  String get providerIssueInviteCta => 'Gerar código de convite';

  @override
  String get providerInviteTtlHint => 'Válido por 24 horas';

  @override
  String get providerInviteCopied => 'Código de convite copiado';

  @override
  String get providerPendingLinks => 'Vínculos pendentes';

  @override
  String get providerNoPendingLinks => 'Nenhum vínculo pendente';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'Paciente $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'Códigos de convite recentes';

  @override
  String get providerNoInvites => 'Nenhum código de convite ainda';

  @override
  String get providerInviteConsumed => 'Usado';

  @override
  String get providerInviteActive => 'Ativo';

  @override
  String get splashTagline => 'Seu escudo inteligente contra gatilhos';

  @override
  String get splashGetStarted => 'Começar';

  @override
  String get splashAlreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get splashSignIn => 'Entrar';

  @override
  String get authForgotPassword => 'Esqueceu a senha?';

  @override
  String get authNoAccount => 'Não tem conta?';

  @override
  String get authUseBiometricHint =>
      'Use o Face ID ou a digital para desbloquear';

  @override
  String get authTouchSensorHint => 'Toque no sensor ou olhe para a câmera';

  @override
  String get navLog => 'Log';

  @override
  String get navReport => 'Report';

  @override
  String get navRewards => 'Rewards';

  @override
  String get mockChooseLanguage => 'Escolha o idioma';

  @override
  String get mockYourLocation => 'Sua localização';

  @override
  String get mockUseCurrentLocation => 'Usar localização atual';

  @override
  String get mockLocationTrapOnly =>
      'A localização é usada apenas para dados de qualidade do ar TRAP';

  @override
  String get mockLabelYourPlace => 'Dê um nome ao lugar';

  @override
  String get mockSchool => 'Escola';

  @override
  String get mockWork => 'Trabalho';

  @override
  String get mockOther => 'Outro';

  @override
  String get mockEmergencyOnePerson =>
      'Uma pessoa para ligar em caso de emergência';

  @override
  String get mockContactName => 'Nome do contato';

  @override
  String get mockPhoneNumber => 'Número de telefone';

  @override
  String get mockProviderPairing => 'Vínculo com o profissional';

  @override
  String get mockPairingOptional =>
      'Opcional — você pode adicionar depois em Configurações';

  @override
  String get mockNext => 'Avançar';

  @override
  String get mockProfessionalProfile => 'Perfil profissional';

  @override
  String get mockStep2Of4 => 'Passo 2 de 4';

  @override
  String get mockTellPractice => 'Fale sobre o seu consultório';

  @override
  String get mockSpecialtyLabel => 'Especialidade';

  @override
  String get mockClinicLabel => 'Nome do consultório / clínica';

  @override
  String get mockNpiFormatOnly =>
      'Só verificamos o formato. A verificação do NPI acontece após o envio.';

  @override
  String get mockCredentialsSecure =>
      'Suas credenciais são criptografadas e guardadas com segurança. Nunca compartilhamos dados de profissionais sem consentimento.';

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
  String get actPast4Weeks => 'Nas últimas 4 semanas';

  @override
  String get actQ1 =>
      'Por quanto tempo a asma impediu você de fazer o que queria no trabalho, na escola ou em casa?';

  @override
  String get actQ2 => 'Com que frequência você sentiu falta de ar?';

  @override
  String get actQ3 =>
      'Com que frequência os sintomas da asma acordaram você à noite ou mais cedo do que o normal?';

  @override
  String get actQ4 =>
      'Com que frequência você usou a bombinha de resgate ou o remédio de nebulização?';

  @override
  String get actQ5 => 'Como você avalia o controle da sua asma?';

  @override
  String get actOpt1 => 'O tempo todo';

  @override
  String get actOpt2 => 'Quase o tempo todo';

  @override
  String get actOpt3 => 'Parte do tempo';

  @override
  String get actOpt4 => 'Pouco do tempo';

  @override
  String get actOpt5 => 'Nunca';

  @override
  String get actQ5Opt1 => 'Nada controlada';

  @override
  String get actQ5Opt2 => 'Mal controlada';

  @override
  String get actQ5Opt3 => 'Um pouco controlada';

  @override
  String get actQ5Opt4 => 'Bem controlada';

  @override
  String get actQ5Opt5 => 'Totalmente controlada';

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
      'Os botões abrem o discador do telefone. As ligações nunca são feitas automaticamente.';

  @override
  String panicCallNamed(String name) {
    return 'Ligar para $name';
  }

  @override
  String get panicDialFailed =>
      'Não foi possível abrir o discador neste aparelho.';

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
      'Suas respostas são salvas para você compartilhar com o seu profissional de saúde. Esta versão do questionário não foi conferida com a pontuação oficial, por isso o app não mostra uma pontuação.';

  @override
  String get s5ActSaved => 'Suas respostas foram salvas.';

  @override
  String get s5ActSubtitle => '5 perguntas sobre as últimas 4 semanas';

  @override
  String get s5ActTitle => 'Questionário de controle da asma';

  @override
  String get s5AddDetails => 'Adicionar detalhes';

  @override
  String get s5AddRecord => 'Adicionar registro';

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
  String get s5Back => 'Voltar';

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
  String get s5Cancel => 'Cancelar';

  @override
  String get s5Change => 'Alterar';

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
  String get s5Delete => 'Excluir';

  @override
  String get s5DeleteConfirm => 'Excluir este registro?';

  @override
  String get s5DeleteFailed => 'Não foi possível excluir. Tente de novo.';

  @override
  String get s5Edit => 'Editar';

  @override
  String get s5EnglishVersion => 'English (for clinician)';

  @override
  String get s5EntryRemoved => 'Registro removido.';

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
  String get s5FieldDate => 'Data';

  @override
  String get s5FieldMedication => 'Medicamento';

  @override
  String get s5FieldNote => 'Observação (opcional)';

  @override
  String get s5FieldPuffs => 'Número de jatos (opcional)';

  @override
  String get s5FieldReason => 'Motivo (opcional)';

  @override
  String get s5FieldTime => 'Hora';

  @override
  String get s5FilterAll => 'Todos';

  @override
  String get s5FilterInhaler => 'Bombinha';

  @override
  String get s5FilterMedCheck => 'Verificação do medicamento';

  @override
  String get s5FilterSymptoms => 'Sintomas';

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
  String get s5FromUrgentHelp => 'Registrado em Ajuda urgente';

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
  String get s5InhalerEditTitle => 'Detalhes do uso da bombinha';

  @override
  String get s5InhalerEntry => 'Uso da bombinha';

  @override
  String get s5InhalerLogged => 'Uso da bombinha registrado.';

  @override
  String get s5InhalerOneEntryHint =>
      'Cada vez que você salva, é um registro de uso da bombinha. Não conta como um jato nem como um dia.';

  @override
  String s5InhalerUnknownCount(int n) {
    return 'Medicamento não identificado: $n';
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
  String get s5Last30Days => 'Últimos 30 dias';

  @override
  String get s5Last7Days => 'Últimos 7 dias';

  @override
  String get s5LogInhaler => 'Registrar uso da bombinha';

  @override
  String get s5LogLegend =>
      'Cada linha é um registro salvo. Dias sem registro aparecem como “não registrado”, o que é diferente de zero.';

  @override
  String get s5LogSymptoms => 'Registrar sintomas';

  @override
  String get s5MedAdd => 'Adicionar medicamento';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return 'Dias de uso: $a · sem uso: $b · não lembro: $c · não registrado: $d';
  }

  @override
  String get s5MedCheckIntro =>
      'Uma verificação feita por você mesmo para saber se usou o seu remédio. Não se baseia em registros da farmácia.';

  @override
  String get s5MedCheckQuestion => 'Você usou o seu remédio como planejado?';

  @override
  String get s5MedCheckTitle => 'Verificação do medicamento de hoje';

  @override
  String get s5MedChooseHint =>
      'Escolha um medicamento ou “Não sei o nome do medicamento”.';

  @override
  String get s5MedDailyCheck => 'Verificação diária';

  @override
  String get s5MedDailyCheckHint =>
      'Mostrar “Verificação do medicamento de hoje” no Início. Ative só se o seu profissional de saúde pediu para você usar este remédio todos os dias.';

  @override
  String get s5MedDefault => 'Padrão para registro rápido';

  @override
  String get s5MedDefaultHint =>
      'Usado quando você toca em “Registrar uso da bombinha” no Início.';

  @override
  String get s5MedEdit => 'Editar medicamento';

  @override
  String get s5MedNameLabel => 'Nome do medicamento (como está no rótulo)';

  @override
  String get s5MedNotApplicable => 'Sem horário previsto para hoje';

  @override
  String s5MedNotApplicableDays(int n) {
    return 'Sem horário previsto: $n dias';
  }

  @override
  String get s5MedNotRecorded => 'Medicamento não registrado';

  @override
  String get s5MedNotSure => 'Não lembro';

  @override
  String get s5MedNotUsed => 'Não usei';

  @override
  String get s5MedOther => 'Outro nome';

  @override
  String get s5MedOtherHint => 'Digite o nome do medicamento';

  @override
  String get s5MedReasonCost => 'Custo';

  @override
  String get s5MedReasonForgot => 'Esqueci';

  @override
  String get s5MedReasonNoMedicine => 'Não tinha o remédio';

  @override
  String get s5MedReasonQuestion => 'Motivo (opcional)';

  @override
  String get s5MedUnknown => 'Não sei o nome do medicamento';

  @override
  String get s5MedUnknownShort => 'Medicamento não identificado';

  @override
  String get s5MedUsed => 'Usei';

  @override
  String get s5MyLanguage => 'My language';

  @override
  String get s5MyLogTitle => 'Meu registro';

  @override
  String get s5MyMedsEmpty => 'Nenhum medicamento salvo ainda.';

  @override
  String get s5MyMedsHint =>
      'Nomes que você confirmou, para registrar mais rápido. Não é uma recomendação de dose.';

  @override
  String get s5MyMedsOpen => 'Manage my medications';

  @override
  String get s5MyMedsTitle => 'Meus medicamentos';

  @override
  String get s5NavEnvironment => 'Environment';

  @override
  String get s5NavLog => 'Log';

  @override
  String get s5NavVisitPrep => 'Visit prep';

  @override
  String get s5NoAnswer => 'Prefiro não responder';

  @override
  String get s5NoRecordsYet => 'Nenhum registro ainda';

  @override
  String s5NoSymptomDays(int n) {
    return 'Dias marcados como “sem sintomas”: $n';
  }

  @override
  String get s5NotRecorded => 'Não registrado';

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
    return 'Período: $days dias · Dias com registro: $n';
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
      other: '$n jatos',
      one: '1 jato',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return 'Question $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return 'Pergunta $n de $total';
  }

  @override
  String get s5ReasonBeforeActivity => 'Antes de uma atividade';

  @override
  String get s5ReasonOther => 'Outro';

  @override
  String get s5ReasonSymptoms => 'Por causa de sintomas';

  @override
  String s5RecentInhaler(int n) {
    return 'Registros de uso da bombinha: $n';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return 'Dias com sintomas: $n';
  }

  @override
  String get s5RecentTitle => 'Last 7 days';

  @override
  String get s5RecordsLoadFailed =>
      'Não foi possível carregar seus registros. Tente de novo.';

  @override
  String get s5RecordsManageHint =>
      'You can edit or delete entries in My log. Deleting always asks you to confirm.';

  @override
  String get s5Refresh => 'Refresh';

  @override
  String get s5Reload => 'Load again';

  @override
  String get s5Save => 'Salvar';

  @override
  String get s5Saved => 'Salvo.';

  @override
  String get s5SavedPlacesHint => 'Saved places such as home, school, or work';

  @override
  String get s5SaveFailed =>
      'Não foi possível salvar. Suas anotações continuam aqui.';

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
  String get s5SymActivityLimited => 'Atividades limitadas';

  @override
  String get s5SymCough => 'Tosse';

  @override
  String get s5SymNightWaking => 'Acordei à noite';

  @override
  String get s5SymNone => 'Sem sintomas';

  @override
  String get s5SymOther => 'Outra coisa';

  @override
  String get s5SymOtherHint => 'Descreva com as suas palavras';

  @override
  String get s5SymShortBreath => 'Dificuldade para respirar';

  @override
  String get s5SymWheeze => 'Chiado no peito';

  @override
  String get s5SymptomEditTitle => 'Editar sintomas';

  @override
  String get s5SymptomEntry => 'Sintomas';

  @override
  String get s5SymptomNoneHint =>
      'Dias que você não registra aparecem como “não registrado”, e não como “sem sintomas”.';

  @override
  String get s5SymptomQuestion => 'O que você notou?';

  @override
  String get s5Today => 'Hoje';

  @override
  String get s5Undo => 'Desfazer';

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
      'Se o seu profissional de saúde deu a você um plano de ação para asma, siga o plano.';

  @override
  String get s5UrgentCall911Locked => 'Urgent help: call 911';

  @override
  String get s5UrgentHelp => 'Ajuda urgente';

  @override
  String get s5UrgentIntro =>
      'Se respirar estiver muito difícil ou não melhorar, ligue para o 911.';

  @override
  String get s5UrgentLogHint =>
      'Opcional: salvar um registro de que você usou a bombinha.';

  @override
  String get s5UrgentNoContact =>
      'Ainda não há contato de emergência. Adicione em Configurações → Ajuda.';

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
  String get s6AddTime => 'Adicionar um horário';

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
  String get s6DoseLater => 'Ver depois';

  @override
  String get s6DoseNotUsed => 'Não consegui usar';

  @override
  String get s6DoseUnconfirmed => 'No answer yet';

  @override
  String get s6DoseUsed => 'Usei';

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
  String get s6HomeWaterNo => 'Não';

  @override
  String get s6HomeWaterQuestion => 'Houve vazamento ou inundação em casa?';

  @override
  String get s6HomeWaterYes => 'Sim';

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
  String get s6OccurredLabel => 'Quando aconteceu';

  @override
  String get s6PdfEnvLimit =>
      'Regional reference only. It does not show personal exposure or the cause of symptoms. A single AQI does not name ozone and particles together, and it does not include pollen.';

  @override
  String get s6PdfEnvTitle => 'Environment reference (appendix)';

  @override
  String get s6PuffsEach => 'Jatos a cada vez';

  @override
  String s6ReminderBodyNamed(String name) {
    return 'Hora de confirmar $name';
  }

  @override
  String get s6ReminderBodyPrivate => 'Hora de confirmar o seu remédio';

  @override
  String get s6ReminderChannel =>
      'Lembretes nos horários de dose que você salvou. Não é um alerta de 30 minutos.';

  @override
  String get s6ReminderTitle => 'Verificação do remédio';

  @override
  String get s6RoleBoth => 'Diário e quando precisar';

  @override
  String get s6RoleController => 'Remédio de uso diário';

  @override
  String get s6RoleRescue => 'Quando precisar';

  @override
  String get s6ScheduleTimes => 'Horários em que você toma';

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
  String get cnTagline => 'Cartas do plano de saúde, próximos passos claros';

  @override
  String get cnDemoBadge => 'Exemplo';

  @override
  String get cnDemoBadgeLong =>
      'Exemplo com dados inventados. Os resultados são fixos.';

  @override
  String get cnAuthSignInTitle => 'Entrar';

  @override
  String get cnAuthCreateTitle => 'Criar conta';

  @override
  String get cnAuthResetTitle => 'Redefinir senha';

  @override
  String get cnAuthSignIn => 'Entrar';

  @override
  String get cnAuthCreate => 'Criar conta';

  @override
  String get cnAuthSendReset => 'Enviar link de redefinição';

  @override
  String cnAuthProfileError(String code) {
    return 'Você entrou, mas não foi possível carregar a sua conta ($code).';
  }

  @override
  String get cnRetry => 'Tentar de novo';

  @override
  String get cnSignOut => 'Sair';

  @override
  String get cnAuthPreparingAccount => 'Preparando a sua conta…';

  @override
  String get cnAuthNameLabel => 'Nome (opcional)';

  @override
  String get cnAuthNameHelper =>
      'Aparece nos seus pacotes. Você pode mudar depois.';

  @override
  String get cnAuthEmailLabel => 'E-mail';

  @override
  String get cnAuthPasswordLabel => 'Senha';

  @override
  String get cnAuthPasswordHelper => 'Pelo menos 8 caracteres';

  @override
  String get cnAuthShowPassword => 'Mostrar senha';

  @override
  String get cnAuthHidePassword => 'Ocultar senha';

  @override
  String get cnAuthPasswordRequired => 'Digite a sua senha';

  @override
  String cnAuthCheckEmail(String email) {
    return 'Enviamos um link de confirmação para $email. Abra o link neste celular e depois entre.';
  }

  @override
  String cnAuthResetSent(String email) {
    return 'Se existir uma conta para $email, um link de redefinição está a caminho. Abra o link neste celular.';
  }

  @override
  String get cnAuthResent => 'Enviado de novo.';

  @override
  String get cnAuthResend => 'Reenviar e-mail';

  @override
  String get cnAuthSignInInstead => 'Já confirmei. Entrar';

  @override
  String get cnAuthForgot => 'Esqueceu a senha?';

  @override
  String get cnAuthNoAccount => 'É novo aqui? Crie uma conta';

  @override
  String get cnAuthHaveAccount => 'Já tem conta? Entre';

  @override
  String get cnAuthResetHint =>
      'Digite o seu e-mail e enviaremos um link para criar uma nova senha.';

  @override
  String get cnAuthBackToSignIn => 'Voltar para entrar';

  @override
  String get cnAuthPrivacyLine =>
      'Suas cartas e registros são privados da sua conta.';

  @override
  String get cnAuthPasswordUpdated => 'Senha atualizada.';

  @override
  String get cnAuthNewPasswordTitle => 'Crie uma nova senha';

  @override
  String get cnAuthNewPasswordLabel => 'Nova senha';

  @override
  String get cnAuthSavePassword => 'Salvar senha';

  @override
  String get cnLater => 'Depois';

  @override
  String get cnAuthErrInvalidCredentials => 'E-mail ou senha incorretos.';

  @override
  String get cnAuthErrNotConfirmed =>
      'Confirme o seu e-mail primeiro. Veja a caixa de entrada ou reenvie o link.';

  @override
  String get cnAuthErrExists =>
      'Já existe uma conta com este e-mail. Entre nela.';

  @override
  String get cnAuthErrWeakPassword =>
      'Escolha uma senha mais forte (pelo menos 8 caracteres).';

  @override
  String get cnAuthErrSamePassword => 'Use uma senha diferente da antiga.';

  @override
  String get cnAuthErrRateLimited =>
      'Muitas tentativas. Espere um minuto e tente de novo.';

  @override
  String get cnAuthErrInvalidEmail => 'Confira o endereço de e-mail.';

  @override
  String get cnAuthErrEmailNotAuthorized =>
      'Não foi possível enviar e-mail para este endereço agora. Tente mais tarde.';

  @override
  String get cnAuthErrDisabled => 'Este modo de entrar está desativado.';

  @override
  String get cnAuthErrSessionExpired => 'Sua sessão terminou. Entre de novo.';

  @override
  String cnAuthErrUnknown(String code) {
    return 'Algo deu errado ($code). Tente de novo.';
  }

  @override
  String get cnErrNetwork =>
      'Sem conexão. Verifique a sua internet e tente de novo.';

  @override
  String get cnErrServiceDown =>
      'O serviço não está respondendo. Tente de novo em alguns minutos.';

  @override
  String get cnTabHome => 'Início';

  @override
  String get cnTabCases => 'Casos';

  @override
  String get cnTabRecords => 'Registros';

  @override
  String get cnTabAccount => 'Conta';

  @override
  String get cnHomeHeadline => 'Entenda a carta do seu plano de saúde.';

  @override
  String get cnScanLetter => 'Escanear uma carta';

  @override
  String get cnUploadFile => 'Enviar PDF / foto';

  @override
  String get cnTryDemo => 'Ver demonstração';

  @override
  String get cnHomeSignInLine =>
      'Para salvar seus casos, é preciso ter uma conta.';

  @override
  String get cnServiceNotConfigured =>
      'Esta versão não está conectada ao servidor. Só a demonstração funciona.';

  @override
  String get cnContinueCase => 'Continuar o seu caso';

  @override
  String get cnHowItWorks => 'Como funciona';

  @override
  String get cnStep1Title => 'Ler a carta';

  @override
  String get cnStep1Body =>
      'Tire uma foto. Encontramos o motivo, o próximo passo e a data.';

  @override
  String get cnStep2Title => 'Reunir registros';

  @override
  String get cnStep2Body =>
      'Compare o que a carta pede com os seus próprios registros.';

  @override
  String get cnStep3Title => 'Criar um pacote';

  @override
  String get cnStep3Body =>
      'Receba um resumo de uma página para o médico e um rascunho de pedido de revisão.';

  @override
  String get cnRecentCases => 'Outros casos';

  @override
  String get cnNoCasesYet => 'Nenhum caso ainda';

  @override
  String get cnNoOtherCases => 'Nenhum outro caso.';

  @override
  String get cnSeeAllCases => 'Ver todos os casos';

  @override
  String get cnNoCasesBody =>
      'Escaneie uma carta do plano de saúde para começar.';

  @override
  String get cnCasesSignInTitle => 'Entre para ver os seus casos';

  @override
  String get cnCasesSignInBody =>
      'Ou abra a demonstração para ver como funciona.';

  @override
  String get cnCaseDeleted => 'Caso excluído.';

  @override
  String get cnCaseUntitled => 'Carta do plano de saúde';

  @override
  String get cnStatusReading => 'Lendo a carta';

  @override
  String get cnStatusNeedsReview => 'Precisa de revisão';

  @override
  String get cnStatusGatherRecords => 'Reunir registros';

  @override
  String get cnStatusPacketReady => 'Pacote pronto';

  @override
  String get cnStatusNeedsAttention => 'Precisa de atenção';

  @override
  String get cnStatusNotStarted => 'Não iniciado';

  @override
  String get cnNextWaitReading => 'Estamos lendo a carta.';

  @override
  String get cnNextTryAgain =>
      'A leitura parou. Abra o caso para tentar de novo.';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count informações para confirmar',
      one: '1 informação para confirmar',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return '$done de $total itens pedidos resolvidos';
  }

  @override
  String get cnNextSharePacket => 'Pacote pronto para compartilhar';

  @override
  String get cnNextCreatePacket => 'Próximo: criar o pacote';

  @override
  String cnDateToCheckShort(String date) {
    return 'Data para conferir: $date';
  }

  @override
  String cnDatePassedShort(String date) {
    return 'Data já passou: $date';
  }

  @override
  String get cnMoreActions => 'Mais ações';

  @override
  String get cnDeleteCase => 'Excluir caso';

  @override
  String get cnDeleteCaseTitle => 'Excluir este caso?';

  @override
  String get cnDeleteCaseBody =>
      'Isso remove as páginas da carta, as informações lidas nelas, os resumos de registros vinculados e os pacotes. Seus registros de medicamentos e sintomas continuam.';

  @override
  String get cnCancel => 'Cancelar';

  @override
  String get cnDelete => 'Excluir';

  @override
  String get cnDeleteFailed =>
      'Não foi possível excluir. Verifique a conexão e tente de novo.';

  @override
  String get cnKindInitialDenial =>
      'Negativa de cobertura de medicamento (Drug coverage denial)';

  @override
  String get cnKindInfoRequest => 'Pedido de mais informações';

  @override
  String get cnKindReauth => 'Aviso de renovação (reautorização)';

  @override
  String get cnKindFinalDenial =>
      'Decisão final do recurso (Final appeal decision)';

  @override
  String get cnKindEob =>
      'Cobrança ou explicação de benefícios (Explanation of Benefits)';

  @override
  String get cnKindOther => 'Outro tipo de carta';

  @override
  String get cnKindUncertain => 'Tipo de carta não está claro';

  @override
  String get cnFieldPatientName => 'Nome do paciente';

  @override
  String get cnFieldPlanName => 'Plano';

  @override
  String get cnFieldMemberId => 'ID de membro';

  @override
  String get cnFieldCaseReference => 'Número do caso ou de referência';

  @override
  String get cnFieldMedication => 'Medicamento (como está escrito)';

  @override
  String get cnFieldDose => 'Dose (como está escrita)';

  @override
  String get cnFieldNoticeDate => 'Data do aviso';

  @override
  String get cnFieldContact => 'Contato';

  @override
  String get cnFieldSubmissionRoute => 'Para onde enviar';

  @override
  String get cnFactEdited => 'Editado por você';

  @override
  String get cnFactChecked => 'Conferido';

  @override
  String get cnFactNotInLetter => 'Não consta na carta';

  @override
  String get cnFactNeedsCheck => 'Precisa conferir';

  @override
  String get cnFactFromLetter => 'Da carta';

  @override
  String get cnWhoYou => 'Você';

  @override
  String get cnWhoCareTeam => 'Equipe de saúde';

  @override
  String get cnWhoPlan => 'Plano';

  @override
  String get cnWhoUnknown => 'Não tenho certeza';

  @override
  String get cnReqLinked => 'Vinculado';

  @override
  String get cnReqAskedCareTeam => 'Pedido à equipe de saúde';

  @override
  String get cnReqNotAvailable => 'Indisponível';

  @override
  String get cnReqNotNeeded => 'Não é necessário';

  @override
  String get cnReqNeeded => 'Necessário';

  @override
  String get cnReqReset => 'Marcar como necessário';

  @override
  String get cnRecMedication => 'Histórico de medicamentos';

  @override
  String get cnRecSymptoms => 'Registro de sintomas';

  @override
  String get cnRecLocalContext => 'Contexto local';

  @override
  String get cnRecPrn => 'Bombinha usada quando precisa';

  @override
  String get cnDemoTitle => 'Demonstração';

  @override
  String get cnDemoReset => 'Reiniciar demonstração';

  @override
  String get cnDemoResetDone => 'Demonstração reiniciada.';

  @override
  String get cnDemoIntro =>
      'Três cartas inventadas com resultados fixos, para você ver cada passo. Nada é enviado.';

  @override
  String get cnUpEmpty => 'Este arquivo está vazio.';

  @override
  String cnUpTooLarge(int mb) {
    return 'Cada arquivo deve ter $mb MB ou menos.';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return 'Todas as páginas juntas devem ter $mb MB ou menos.';
  }

  @override
  String cnUpTooManyPages(int max) {
    return 'Até $max páginas por carta.';
  }

  @override
  String get cnUpUnsupported =>
      'Use JPG, PNG ou PDF. Para fotos HEIC, tire uma nova foto aqui.';

  @override
  String get cnUpBadFile =>
      'Não foi possível ler este arquivo. Tente outra foto ou outro PDF.';

  @override
  String get cnUpEncrypted =>
      'Este PDF tem senha. Salve uma cópia sem senha ou tire fotos.';

  @override
  String get cnCameraUnavailable =>
      'A câmera não está disponível. Você pode enviar uma foto ou um PDF.';

  @override
  String get cnPhotosUnavailable =>
      'Não foi possível abrir as fotos. Permita o acesso às fotos nas configurações ou envie um PDF.';

  @override
  String get cnFilesUnavailable =>
      'Não foi possível abrir os arquivos agora. Tente de novo.';

  @override
  String get cnUploadFailed =>
      'O envio não terminou. Suas páginas continuam aqui. Tente de novo.';

  @override
  String get cnCaptureTitle => 'Adicionar páginas da carta';

  @override
  String get cnReplacePagesTitle => 'Trocar páginas da carta';

  @override
  String get cnOpening => 'Abrindo…';

  @override
  String get cnCaptureEmptyTitle => 'Adicione as páginas da sua carta';

  @override
  String get cnCaptureTips =>
      'Deixe a página reta, com boa luz, e enquadre os quatro cantos. Adicione todas as páginas, em ordem.';

  @override
  String get cnTakePhoto => 'Tirar foto';

  @override
  String get cnAddPage => 'Adicionar página';

  @override
  String get cnAddPhoto => 'Foto';

  @override
  String get cnAddPdf => 'PDF';

  @override
  String cnPagesSummary(int pages, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      pages,
      locale: localeName,
      other: '$pages páginas',
      one: '1 página',
    );
    return '$_temp0 · $size MB';
  }

  @override
  String get cnUploadConsent =>
      'Ao enviar, estas páginas vão para o servidor do CoverNote, onde um serviço de IA as lê para você. Você pode excluir o caso a qualquer momento.';

  @override
  String get cnStageUploading => 'Enviando';

  @override
  String get cnUploadAndRead => 'Enviar e ler';

  @override
  String cnPageN(int n) {
    return 'Página $n';
  }

  @override
  String cnPdfPages(int n, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas',
      one: '1 página',
    );
    return 'Arquivo $n · PDF, $_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return 'Ver página $n';
  }

  @override
  String get cnRotate => 'Girar';

  @override
  String get cnRetake => 'Tirar de novo';

  @override
  String get cnRemovePage => 'Remover';

  @override
  String get cnReorder => 'Arraste para reordenar';

  @override
  String get cnServiceUnavailableBody =>
      'O leitor de cartas não está configurado agora. Suas páginas estão salvas; tente de novo mais tarde.';

  @override
  String get cnNeedNewPagesBody =>
      'Tire fotos mais nítidas ou use menos páginas e envie de novo.';

  @override
  String get cnPagesKept => 'Suas páginas estão salvas. Nada foi alterado.';

  @override
  String get cnReplacePages => 'Trocar páginas';

  @override
  String get cnTryAgain => 'Tentar de novo';

  @override
  String get cnStageReading => 'Lendo';

  @override
  String get cnStageChecking => 'Conferindo';

  @override
  String get cnStageReady => 'Pronto';

  @override
  String get cnReadingTitle => 'Lendo a sua carta';

  @override
  String get cnReadingBody =>
      'Quando terminar, você confere o que encontramos com a carta.';

  @override
  String get cnReadingLeaveOk =>
      'Você pode sair desta tela. A leitura continua e o seu caso fica salvo.';

  @override
  String get cnStartReading => 'Começar a leitura';

  @override
  String get cnStepLetter => 'Carta';

  @override
  String get cnStepReview => 'Revisão';

  @override
  String get cnStepEvidence => 'Evidências';

  @override
  String get cnStepPacket => 'Pacote';

  @override
  String cnStepOf(int n, int total, String name) {
    return 'Passo $n de $total: $name';
  }

  @override
  String get cnSaving => 'Salvando…';

  @override
  String get cnSaved => 'Salvo';

  @override
  String get cnNotSavedRetry => 'Não salvo · Tentar de novo';

  @override
  String get cnViewOriginal => 'Ver páginas originais';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas lidas',
      one: '1 página lida',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return 'Difícil de ler: página $list. Confira estas informações com atenção ou tire a foto de novo.';
  }

  @override
  String get cnRetakePages => 'Tirar fotos de novo';

  @override
  String get cnHardToRead => 'Difícil de ler';

  @override
  String get cnContinueToReview => 'Continuar para a revisão';

  @override
  String get cnOriginalPages => 'Páginas originais';

  @override
  String get cnNoOriginal => 'Nenhuma página original está guardada.';

  @override
  String get cnCheckDetails => 'Confira os detalhes';

  @override
  String get cnCheckDetailsHint =>
      'Compare cada valor com a sua carta. Toque em uma citação para ver de onde ela veio.';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Confira mais $count itens para continuar',
      one: 'Confira mais 1 item para continuar',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => 'Continuar para as evidências';

  @override
  String cnSeePage(int n) {
    return 'Ver página $n';
  }

  @override
  String get cnWhatLetterIs => 'O que é esta carta';

  @override
  String get cnLooksRight => 'Está certo';

  @override
  String get cnChange => 'Alterar';

  @override
  String get cnCardWhyDenied => 'Por que foi negado';

  @override
  String get cnCardWhatTheyNeed => 'O que eles pediram';

  @override
  String get cnCardWhatItSays => 'O que a carta diz';

  @override
  String get cnNoReasonFound => 'Nenhum motivo foi encontrado na carta.';

  @override
  String get cnCardNextStep => 'Próximo passo';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Peça à sua equipe de saúde para solicitar uma revisão. A carta lista $count itens para enviar.',
      one:
          'Peça à sua equipe de saúde para solicitar uma revisão. A carta lista 1 item para enviar.',
      zero:
          'Peça à sua equipe de saúde para solicitar uma revisão. A carta não lista itens específicos.',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Envie os $count itens que o plano pediu até a data abaixo.',
      one: 'Envie o 1 item que o plano pediu até a data abaixo.',
      zero: 'Envie as informações que o plano pediu até a data abaixo.',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth =>
      'Anote quando a aprovação atual termina e peça à sua equipe de saúde para iniciar a renovação.';

  @override
  String get cnNextFinal =>
      'Esta é uma decisão final. O CoverNote não prepara um primeiro pedido de revisão para ela. Pergunte ao plano ou à sua equipe de saúde sobre as opções que a carta lista.';

  @override
  String get cnNextEob =>
      'Isto parece uma cobrança ou um extrato de benefícios, não uma negativa. Confira com o atendimento ao associado do plano.';

  @override
  String get cnNextUncertain =>
      'Primeiro confirme, acima, que tipo de carta é esta.';

  @override
  String cnWhereToSend(String route) {
    return 'Para onde enviar: $route';
  }

  @override
  String cnWhoToCall(String contact) {
    return 'Contato: $contact';
  }

  @override
  String get cnCardDate => 'Data para conferir';

  @override
  String cnDateCalculated(String anchor, int days) {
    return 'Calculado: $anchor + $days dias corridos';
  }

  @override
  String get cnReceivedDateWord => 'data em que você recebeu';

  @override
  String get cnNoticeDateWord => 'data do aviso';

  @override
  String get cnDateEnteredByYou => 'Informada por você';

  @override
  String get cnDateFromLetter => 'Informada na carta';

  @override
  String cnReceivedOn(String date) {
    return 'Você recebeu em $date';
  }

  @override
  String get cnDatePassed =>
      'Esta data já passou. Ligue para o plano e pergunte o que ainda é possível fazer.';

  @override
  String cnNeedReceivedDate(int days) {
    return 'A carta dá $days dias corridos a partir do dia em que você a recebeu. Quando ela chegou?';
  }

  @override
  String get cnEnterReceivedDate => 'Informar a data de recebimento';

  @override
  String get cnDateConflict =>
      'A carta traz datas diferentes. Pergunte ao plano qual vale e depois escolha essa.';

  @override
  String cnUseThisDate(String date) {
    return 'Usar $date';
  }

  @override
  String get cnDateUnclear =>
      'O texto não está claro ou conta dias úteis, por isso o CoverNote não calcula a data. Peça ao plano a data exata.';

  @override
  String get cnNoDeadline =>
      'Nenhum prazo para revisão foi encontrado na carta.';

  @override
  String cnReplyBy(String date) {
    return 'Responda ao pedido de informações até $date (conforme a carta)';
  }

  @override
  String get cnEnterDatePlanGave => 'Informar uma data';

  @override
  String get cnUseLetterDate => 'Usar a data da carta';

  @override
  String get cnLeaveUnknown => 'Deixar como desconhecida por enquanto';

  @override
  String get cnDateUnknownChecked => 'Desconhecida, anotado';

  @override
  String get cnTypeAsWritten => 'Digite exatamente como aparece na carta.';

  @override
  String get cnCheckThisValue =>
      'Este valor parece incomum. Compare com a carta.';

  @override
  String get cnDone => 'Pronto';

  @override
  String get cnEdit => 'Editar';

  @override
  String get cnAdd => 'Adicionar';

  @override
  String get cnNoRecordsToLink =>
      'Nenhum registro dos últimos 30 dias para vincular. Você ainda pode marcar quem tem este item.';

  @override
  String cnLinkTitle(String label) {
    return 'Vincular um registro a: $label';
  }

  @override
  String get cnLinkNote =>
      'Seus próprios registros apoiam o pedido. Eles não substituem anotações da clínica nem resultados de exames.';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '$taken tomadas / $notTaken não tomadas / $unknown desconhecidas de $scheduled doses previstas';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return 'Quando precisa: $uses usos, $puffs jatos';
  }

  @override
  String get cnNoEntries => 'Sem registros';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return 'Sintomas em $days dias, despertar à noite em $night dias ($entries de $total dias registrados)';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return 'Dados de PM2.5 de $days de $total dias; $high dias acima de AQI 100';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count relatos seus',
      one: '1 relato seu',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => 'Dados fictícios';

  @override
  String get cnLetterAsksFor => 'O que a carta pede';

  @override
  String get cnNoItemsListed =>
      'A carta não lista itens específicos. Você pode adicionar os seus.';

  @override
  String get cnAddItemLabel => 'Adicionar um item para acompanhar';

  @override
  String cnYourRecords(String from, String to) {
    return 'Seus registros ($from – $to)';
  }

  @override
  String get cnLocalContextNote =>
      'Contexto opcional. Não é uma medição na sua casa nem a causa dos sintomas.';

  @override
  String get cnContinueToPacket => 'Continuar para o pacote';

  @override
  String get cnAddedByYou => 'Adicionado por você';

  @override
  String get cnFromLetter => 'Da carta';

  @override
  String cnWhoHasIt(String who) {
    return 'Quem tem: $who';
  }

  @override
  String cnLinkedTo(String record) {
    return 'Vinculado: $record';
  }

  @override
  String get cnSeeInLetter => 'Ver na carta';

  @override
  String get cnLinkRecords => 'Vincular meus registros';

  @override
  String get cnOtherStatus => 'Outro status';

  @override
  String get cnInPacket => 'No pacote';

  @override
  String get cnRemoveFromPacket => 'Tirar do pacote';

  @override
  String get cnAddToPacket => 'Colocar no pacote';

  @override
  String get cnErrNotSavedYet =>
      'Suas últimas alterações ainda não foram salvas. Verifique a conexão e tente de novo.';

  @override
  String get cnPacketChangedMeanwhile =>
      'Informações ou registros mudaram enquanto o pacote era feito. Gere o pacote de novo.';

  @override
  String get cnPacketFailed =>
      'Não foi possível fazer o pacote. Tente de novo.';

  @override
  String get cnBeforeSharingTitle => 'Antes de compartilhar';

  @override
  String get cnBeforeSharingBody =>
      'Este arquivo tem o seu nome e dados de saúde. Compartilhe só com a sua equipe de saúde ou com o seu plano. Compartilhar não envia nada por você.';

  @override
  String get cnShare => 'Compartilhar';

  @override
  String get cnMethodFax => 'Fax';

  @override
  String get cnMethodMail => 'Correio';

  @override
  String get cnMethodPortal => 'Portal online';

  @override
  String get cnMethodInPerson => 'Pessoalmente';

  @override
  String get cnMethodCareTeam => 'A equipe de saúde enviou';

  @override
  String get cnMethodOther => 'Outro';

  @override
  String get cnPacketNoDraftFinal =>
      'Para uma decisão final, o pacote tem só o resumo para o médico. Nenhum rascunho de revisão de primeiro nível é feito.';

  @override
  String get cnPacketNoDraftEob =>
      'Para uma cobrança ou um extrato de benefícios, o pacote tem só o resumo para o médico.';

  @override
  String get cnPacketNoDraftReauth =>
      'Para um aviso de renovação, o pacote tem só o resumo para o médico, para ajudar a sua equipe de saúde a renovar.';

  @override
  String get cnPacketNoDraftOther =>
      'A menos que a carta seja uma negativa ou um pedido de informações, o pacote tem só o resumo para o médico.';

  @override
  String get cnPacketContains => 'Este pacote vai incluir';

  @override
  String get cnPartSummary => 'Resumo para o médico (1 página)';

  @override
  String get cnPartDraft =>
      'Rascunho do pedido de revisão (para a sua equipe de saúde completar)';

  @override
  String get cnPartLetterText => 'Anexo: o texto da carta';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resumos de registros adicionados',
      one: '1 resumo de registros adicionado',
      zero: 'Nenhum resumo de registros adicionado',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => 'Adicionar o texto da carta como anexo';

  @override
  String get cnPacketStale =>
      'Informações ou registros mudaram desde o último pacote. Gere de novo para atualizar.';

  @override
  String get cnGenerating => 'Gerando…';

  @override
  String get cnGeneratePacket => 'Gerar pacote de revisão';

  @override
  String get cnSaveOrPrint => 'Salvar ou imprimir';

  @override
  String get cnISentIt => 'Eu enviei';

  @override
  String cnSharedOn(String date) {
    return 'Compartilhado em $date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return 'Você informou que enviou em $date ($method)';
  }

  @override
  String get cnTabDoctorSummary => 'Resumo para o médico';

  @override
  String get cnTabReviewDraft => 'Rascunho do pedido de revisão';

  @override
  String get cnSentExplain =>
      'Anote quando e como foi enviado. O CoverNote não envia nada nem acompanha decisões.';

  @override
  String get cnSave => 'Salvar';

  @override
  String get cnCtxPm25 => 'PM2.5 (AQI)';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => 'Umidade externa';

  @override
  String cnObservedOn(String date) {
    return 'Observado em $date';
  }

  @override
  String get cnCtxIntro =>
      'Medições do ar de uma fonte indicada e coisas que você notou, mantidas separadas. Adicione ao caso só se ajudarem a explicar os seus registros.';

  @override
  String get cnCtxReadings => 'Medições do ar';

  @override
  String get cnCtxReadingsNote =>
      'Medições regionais do dia em que foram observadas. Elas não medem a fumaça de veículos na sua casa.';

  @override
  String get cnCtxAddReading => 'Adicionar uma medição';

  @override
  String get cnCtxReports => 'O que você notou';

  @override
  String get cnCtxReportsNote => 'Seus próprios relatos. Não são medições.';

  @override
  String get cnCtxAddReport => 'Adicionar o que você notou';

  @override
  String get cnReportExhaust => 'Muita fumaça de veículos por perto';

  @override
  String get cnReportWater => 'Entrada de água em casa';

  @override
  String get cnReportDamp => 'Área interna úmida ou com cheiro de mofo';

  @override
  String cnOnDate(String date) {
    return 'Data: $date';
  }

  @override
  String get cnNoteOptional => 'Observação (opcional)';

  @override
  String get cnCtxWhat => 'Medição';

  @override
  String get cnCtxHumidityNote =>
      'A umidade externa é um dado do tempo. Ela não mostra umidade nem mofo dentro da sua casa.';

  @override
  String get cnCtxValue => 'Valor';

  @override
  String get cnCtxValueInvalid => 'Digite um número válido.';

  @override
  String get cnCtxSource => 'Fonte';

  @override
  String get cnCtxSourceHelp =>
      'De onde veio o número, por exemplo AirNow ou um monitor local';

  @override
  String get cnCtxSourceRequired => 'Informe a fonte.';

  @override
  String get cnCtxPlace => 'Local (ZIP code ou cidade, opcional)';

  @override
  String get cnRecordsSignInBody =>
      'Entre para guardar registros de medicamentos, sintomas e contexto local.';

  @override
  String get cnRecordsYourRecords => 'Seus registros';

  @override
  String get cnRecMedicationSub => 'Remédios e doses que você toma';

  @override
  String get cnRecDailyLog => 'Registro diário';

  @override
  String get cnRecDailyLogSub => 'Sintomas e uso da bombinha';

  @override
  String get cnRecLocalContextSub => 'Medições do ar e o que você notou';

  @override
  String get cnHelp => 'Ajuda';

  @override
  String get cnUrgentHelp => 'Ajuda urgente';

  @override
  String get cnUrgentHelpSub =>
      'Passos para uma emergência respiratória e para ligar para o 911';

  @override
  String cnLast30Days(String from, String to) {
    return 'Últimos 30 dias ($from – $to)';
  }

  @override
  String get cnNoSchedule => 'Nenhum horário regular definido';

  @override
  String get cnRecordsUnknownNote =>
      'Dias sem registro continuam desconhecidos. Não contam como doses perdidas.';

  @override
  String get cnDeleteAccountTitle => 'Excluir a sua conta?';

  @override
  String get cnDeleteAccountBody =>
      'Isso exclui para sempre a sua conta, casos, cartas enviadas, pacotes e registros. Não é possível desfazer.';

  @override
  String get cnTypeDelete => 'Digite DELETE para confirmar';

  @override
  String get cnDeleteAccount => 'Excluir conta';

  @override
  String get cnAccountDeleted => 'Sua conta foi excluída.';

  @override
  String get cnDeleteAccountFailed =>
      'Não foi possível excluir a conta. Tente mais tarde.';

  @override
  String get cnAccountSignedOut => 'Você não está conectado.';

  @override
  String get cnLanguage => 'Idioma';

  @override
  String get cnServiceStatus => 'Serviço de leitura de cartas';

  @override
  String get cnServiceReady => 'Disponível';

  @override
  String get cnServiceUnavailableShort => 'Indisponível no momento';

  @override
  String get cnChecking => 'Verificando…';

  @override
  String get cnServiceUnknown => 'Não verificado';

  @override
  String get cnCheck => 'Verificar';

  @override
  String get cnAbout => 'Sobre';

  @override
  String get cnAboutBody =>
      'O CoverNote ajuda você a ler cartas do plano de saúde sobre remédios e a preparar papéis para a sua equipe de saúde. Ele não envia nada ao seu plano, não decide cobertura e não é aconselhamento médico.';

  @override
  String get cnDangerZone => 'Excluir conta';

  @override
  String get cnErrServiceUnavailable =>
      'O leitor de cartas não está disponível agora.';

  @override
  String get cnErrBusy =>
      'O serviço está ocupado. Espere um minuto e tente de novo.';

  @override
  String get cnErrSlow => 'A leitura demorou demais. Tente de novo.';

  @override
  String get cnErrUnreadable =>
      'Não foi possível ler as páginas. Tire as fotos de novo com mais luz.';

  @override
  String get cnErrTooManyPages => 'Páginas demais. Envie até 10.';

  @override
  String get cnErrTooLarge =>
      'Os arquivos são grandes demais. Use menos páginas ou páginas menores.';

  @override
  String get cnErrStale =>
      'Este caso mudou em outro aparelho. Mostrando a versão mais recente.';

  @override
  String get cnErrCaseGone => 'Este caso não existe mais.';

  @override
  String get cnErrAttempts =>
      'A leitura falhou várias vezes. Troque as páginas ou tente mais tarde.';

  @override
  String get cnErrDemoUpload =>
      'A demonstração não lê arquivos. Entre para escanear a sua própria carta.';

  @override
  String cnErrGeneric(String code) {
    return 'Algo deu errado ($code). Tente de novo.';
  }

  @override
  String get cnLanguageChoose => 'Escolha o seu idioma';

  @override
  String get cnLanguageNote =>
      'Parte do texto foi traduzida por software e pode ter erros. Nomes de remédios, doses, datas e citações da sua carta nunca são traduzidos.';

  @override
  String get cnLanguageButtonTooltip => 'Mudar idioma';

  @override
  String get cnPacketEnglishNote =>
      'O pacote é escrito em inglês para que a sua equipe de saúde possa ler.';

  @override
  String get cnReasonMissingInformation =>
      'O plano diz que não recebeu todas as informações de que precisava.';

  @override
  String get cnReasonStepTherapy =>
      'O plano quer que você tente outros remédios primeiro.';

  @override
  String get cnReasonMedicalNecessity =>
      'O plano diz que não conseguiu confirmar que este remédio é necessário do ponto de vista médico.';

  @override
  String get cnReasonFormulary =>
      'O plano diz que este remédio não está na lista de remédios cobertos.';

  @override
  String get cnReasonQuantityLimit =>
      'O plano diz que a quantidade pedida é maior do que ele cobre.';

  @override
  String get cnReasonEligibility =>
      'O plano diz que isto não é coberto pelas regras de cobertura dele.';

  @override
  String get cnReasonOther =>
      'A carta dá outro motivo. Abra a citação da carta para ler.';

  @override
  String get cnReqHintMedHistory => 'Seus remédios de antes e de agora';

  @override
  String get cnReqHintVisitNotes => 'Anotações das suas consultas médicas';

  @override
  String get cnReqHintTestResults => 'Resultados de exames';

  @override
  String get cnReqHintDoctorStatement => 'Uma declaração do seu médico';
}
