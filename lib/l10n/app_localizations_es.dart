// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'CoverNote';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginEmailLabel => 'Correo electrónico';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get signUpButton => 'Registrarse';

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
      'Registrar uso de inhalador o medicamento';

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
  String get settingsTitle => 'Configuración';

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
  String get mockUsePassword => 'Usar contraseña';

  @override
  String get mockOnboardingTitle => 'Patient setup';

  @override
  String get mockHomeLocation => 'Casa';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => 'Contacto de emergencia';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => 'Código de invitación del profesional de salud';

  @override
  String get mockFinishOnboarding => 'Go to home';

  @override
  String get mockAllScreens => 'Todas las pantallas';

  @override
  String get mockAllScreensHint => 'Open any Screen ID for design review';

  @override
  String get mockStateCalm => 'CALMA';

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
  String get mockForecast => 'Pronóstico';

  @override
  String get mockForecastHint => 'Next days air & pollen outlook';

  @override
  String get mockAlertPreview => 'Alert landing';

  @override
  String get mockAlertPreviewHint => 'Preview risk alert screen';

  @override
  String get mockShowWarningHome => 'Ver inicio en ALERTA';

  @override
  String get mockBackToCalmHome => 'Atrás';

  @override
  String get mockPanicCta => 'Panic mode';

  @override
  String get mockTrapAxis => 'TRAP / hollín';

  @override
  String get mockFloodAxis => 'Inundación repentina';

  @override
  String get mockPollenAxis => 'Polen';

  @override
  String get mockForecastDayHint => 'AQI · TRAP · Pollen outlook';

  @override
  String get mockActSurvey => 'Cuestionario ACT';

  @override
  String get mockActHint => '5 preguntas con imágenes (4 semanas)';

  @override
  String get mockPdcCheck => 'Control diario PDC';

  @override
  String get mockPdcHint => 'Un toque para confirmar';

  @override
  String get mockInhalerEvent => 'Inhalador registrado';

  @override
  String get mockActIntro =>
      'Answer based on the last 4 weeks. Design preview — answers are not saved.';

  @override
  String get mockQuestion => 'Pregunta';

  @override
  String get mockSubmit => 'Enviar';

  @override
  String get mockPdcPrompt => '¿Tomó hoy su medicina de control?';

  @override
  String get mockTakenYes => 'Sí, la tomé';

  @override
  String get mockTakenNo => 'Hoy no';

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
  String get mockPdcRate => 'PDC (30 días)';

  @override
  String get mockLocationsTitle => 'Lugares guardados';

  @override
  String get mockLocationsHint => 'Monitoreo de casa y trabajo';

  @override
  String get mockWorkLocation => 'Trabajo';

  @override
  String get mockDummyWorkAddress => '1 Market St, Jersey City, NJ';

  @override
  String get mockAddLocation => 'Agregar lugar';

  @override
  String get mockRewardTitle => 'Rewards';

  @override
  String get mockDraftBanner =>
      'BORRADOR — los puntos y vales son solo una vista previa';

  @override
  String get mockPointsBalance => 'Saldo de puntos';

  @override
  String get mockVoucherTitle => 'Vale del banco de alimentos';

  @override
  String get mockVoucherHint => 'Exchange points (waitlist)';

  @override
  String get mockDonateTitle => 'Donar';

  @override
  String get mockDonateHint => 'Solo donaciones a terceros';

  @override
  String get mockRewardHistory => 'Historial';

  @override
  String get mockRewardHistoryHint => 'Puntos y donaciones';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank (demostración)';

  @override
  String get mockVoucherCost => '50 puntos · valor de \$10 (borrador)';

  @override
  String get mockJoinWaitlist => 'Unirse a la lista de espera';

  @override
  String get mockDonateTransparency =>
      'Las donaciones se hacen por una plataforma sin fines de lucro verificada, de un tercero. Howse Asthma nunca guarda los datos de su tarjeta.';

  @override
  String get mockDonateCta => 'Abrir donación (externo)';

  @override
  String get mockExternalOnly =>
      'El proveedor externo de donaciones no está conectado en la vista previa de diseño.';

  @override
  String get mockSignOutPreview => 'Cerrar sesión (vista previa)';

  @override
  String get mockOpenAuthFlow => 'Open auth flow';

  @override
  String get mockAlertBody =>
      'Risk rose near your location. Review environment details.';

  @override
  String get mockDismiss => 'Cerrar';

  @override
  String get mockPanicTitle => 'Need help now?';

  @override
  String get mockPanicStep1Body =>
      'Paso 1 — Quédese con su inhalador. Continúe para ver los contactos de emergencia.';

  @override
  String get mockPanicStep2Title => 'Llame para pedir ayuda';

  @override
  String get mockPanicStep2Body =>
      'Vista previa de diseño: los botones no hacen una llamada real. En los teléfonos, el Paso 2 usa enlaces tel:.';

  @override
  String get mockCall911 => 'Llamar al 911';

  @override
  String get mockCallGuardian => 'Llamar al contacto de emergencia';

  @override
  String get mockFeelingBetter => 'Me siento mejor';

  @override
  String get mockTabHome => 'Inicio';

  @override
  String get mockTabLog => 'Registro';

  @override
  String get mockTabReport => 'Informe';

  @override
  String get mockTabReward => 'Premios';

  @override
  String get mockTabSettings => 'Configuración';

  @override
  String get navHome => 'Home';

  @override
  String get signUpTitle => 'Create account';

  @override
  String get authChooseRole => 'Elija su función';

  @override
  String get authRolePatient => 'Paciente';

  @override
  String get authRolePatientHint => 'Track air quality risk and inhaler use';

  @override
  String get authRoleProvider => 'Profesional de salud';

  @override
  String get authRoleProviderHint =>
      'Link patients and review clinical evidence';

  @override
  String get authFullNameLabel => 'Nombre completo';

  @override
  String get authNpiLabel => 'Número NPI';

  @override
  String get authNpiHelper =>
      'Identificador Nacional de Proveedor de 10 dígitos';

  @override
  String get authOrContinueWith => 'o continúe con';

  @override
  String get authContinueGoogle => 'Continuar con Google';

  @override
  String get authContinueApple => 'Continuar con Apple';

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
  String get authSignOut => 'Cerrar sesión';

  @override
  String get authRetry => 'Reintentar';

  @override
  String get authWorking => 'Procesando…';

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
  String get authErrorGeneric => 'Algo salió mal. Inténtelo de nuevo.';

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
  String get authBiometricTitle => 'Desbloquear Howse Asthma';

  @override
  String get authBiometricHint => 'Use su huella o rostro para continuar';

  @override
  String get authBiometricReason => 'Desbloquear Howse Asthma';

  @override
  String get authBiometricUnlock => 'Unlock';

  @override
  String get authBiometricFailed => 'Biometric unlock failed. Try again.';

  @override
  String get authBiometricToggle => 'Desbloqueo biométrico';

  @override
  String get authBiometricToggleHint =>
      'Pedir desbloqueo biométrico al abrir la app';

  @override
  String get authBiometricUnavailable =>
      'Este dispositivo no tiene biometría disponible';

  @override
  String get authOnboardingTitle => 'Configuración del paciente';

  @override
  String get authOnboardingBody =>
      'If your clinician shared an 8-character invite code, enter it now. You can also do this later in Settings.';

  @override
  String get authOnboardingSkip => 'Omitir por ahora';

  @override
  String get authInviteCodeLabel =>
      'Código de invitación del profesional de salud';

  @override
  String get authInviteCodeHelper => '8 letras o números, vence en 24 horas';

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
      'No se pudo generar el código de invitación';

  @override
  String get authConfirmLink => 'Confirmar';

  @override
  String get authRejectLink => 'Rechazar';

  @override
  String get authLinkStatusPending => 'Confirmación pendiente';

  @override
  String get settingsSystemDefault => 'System default';

  @override
  String get settingsLocationTodo =>
      'Location permission will be requested in a later update';

  @override
  String get providerHomeTab => 'Inicio';

  @override
  String get providerLinkTab => 'Vincular';

  @override
  String get providerHomeTitle => 'Inicio del profesional';

  @override
  String providerHomeWelcome(String email) {
    return 'Sesión iniciada como $email';
  }

  @override
  String get providerHomePlaceholder =>
      'Los paneles clínicos de los pacientes llegarán en una versión futura. Empiece vinculando pacientes.';

  @override
  String get providerLinkPatientsCta => 'Vincular pacientes';

  @override
  String get providerLinkTitle => 'Vincular pacientes';

  @override
  String get providerLinkIntro =>
      'Genere un código de 8 caracteres (válido por 24 horas). El paciente lo escribe y luego ambas partes confirman.';

  @override
  String get providerIssueInviteCta => 'Generar código de invitación';

  @override
  String get providerInviteTtlHint => 'Válido por 24 horas';

  @override
  String get providerInviteCopied => 'Código de invitación copiado';

  @override
  String get providerPendingLinks => 'Vínculos pendientes';

  @override
  String get providerNoPendingLinks => 'No hay vínculos pendientes';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'Paciente $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'Códigos de invitación recientes';

  @override
  String get providerNoInvites => 'Aún no hay códigos de invitación';

  @override
  String get providerInviteConsumed => 'Usado';

  @override
  String get providerInviteActive => 'Activo';

  @override
  String get splashTagline =>
      'Su escudo inteligente contra los desencadenantes';

  @override
  String get splashGetStarted => 'Comenzar';

  @override
  String get splashAlreadyHaveAccount => '¿Ya tiene una cuenta?';

  @override
  String get splashSignIn => 'Iniciar sesión';

  @override
  String get authForgotPassword => '¿Olvidó su contraseña?';

  @override
  String get authNoAccount => '¿No tiene cuenta?';

  @override
  String get authUseBiometricHint => 'Use Face ID o su huella para desbloquear';

  @override
  String get authTouchSensorHint => 'Toque el sensor o mire la cámara';

  @override
  String get navLog => 'Log';

  @override
  String get navReport => 'Report';

  @override
  String get navRewards => 'Rewards';

  @override
  String get mockChooseLanguage => 'Elegir idioma';

  @override
  String get mockYourLocation => 'Su ubicación';

  @override
  String get mockUseCurrentLocation => 'Usar ubicación actual';

  @override
  String get mockLocationTrapOnly =>
      'La ubicación se usa solo para datos de calidad del aire TRAP';

  @override
  String get mockLabelYourPlace => 'Ponga nombre a su lugar';

  @override
  String get mockSchool => 'Escuela';

  @override
  String get mockWork => 'Trabajo';

  @override
  String get mockOther => 'Otro';

  @override
  String get mockEmergencyOnePerson =>
      'Una persona a quien llamar en una emergencia';

  @override
  String get mockContactName => 'Nombre del contacto';

  @override
  String get mockPhoneNumber => 'Número de teléfono';

  @override
  String get mockProviderPairing => 'Vincular profesional de salud';

  @override
  String get mockPairingOptional =>
      'Opcional — puede agregarlo después en Configuración';

  @override
  String get mockNext => 'Siguiente';

  @override
  String get mockProfessionalProfile => 'Perfil profesional';

  @override
  String get mockStep2Of4 => 'Paso 2 de 4';

  @override
  String get mockTellPractice => 'Cuéntenos sobre su consultorio médico';

  @override
  String get mockSpecialtyLabel => 'Especialidad';

  @override
  String get mockClinicLabel => 'Nombre del consultorio o clínica';

  @override
  String get mockNpiFormatOnly =>
      'Solo se revisa el formato. El NPI se verifica después de enviar.';

  @override
  String get mockCredentialsSecure =>
      'Sus credenciales se cifran y se guardan de forma segura. Nunca compartimos datos del profesional sin su consentimiento.';

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
  String get actPast4Weeks => 'En las últimas 4 semanas';

  @override
  String get actQ1 =>
      '¿Durante cuánto tiempo el asma le impidió hacer todo lo que quería en el trabajo, la escuela o la casa?';

  @override
  String get actQ2 => '¿Con qué frecuencia le faltó el aire?';

  @override
  String get actQ3 =>
      '¿Con qué frecuencia los síntomas del asma lo despertaron de noche o más temprano de lo normal?';

  @override
  String get actQ4 =>
      '¿Con qué frecuencia usó su inhalador de rescate o su medicamento de nebulizador?';

  @override
  String get actQ5 => '¿Cómo calificaría el control de su asma?';

  @override
  String get actOpt1 => 'Todo el tiempo';

  @override
  String get actOpt2 => 'Casi todo el tiempo';

  @override
  String get actOpt3 => 'Parte del tiempo';

  @override
  String get actOpt4 => 'Muy poco tiempo';

  @override
  String get actOpt5 => 'Nunca';

  @override
  String get actQ5Opt1 => 'Nada controlada';

  @override
  String get actQ5Opt2 => 'Mal controlada';

  @override
  String get actQ5Opt3 => 'Algo controlada';

  @override
  String get actQ5Opt4 => 'Bien controlada';

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
      'Los botones abren el marcador del teléfono. Nunca se hacen llamadas de forma automática.';

  @override
  String panicCallNamed(String name) {
    return 'Llamar a $name';
  }

  @override
  String get panicDialFailed =>
      'No se pudo abrir el marcador del teléfono en este dispositivo.';

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
      'Sus respuestas se guardan para que pueda compartirlas con su profesional de salud. Esta versión del cuestionario no se ha comparado con la puntuación oficial, por eso la app no muestra un puntaje.';

  @override
  String get s5ActSaved => 'Sus respuestas se guardaron.';

  @override
  String get s5ActSubtitle => '5 preguntas sobre las últimas 4 semanas';

  @override
  String get s5ActTitle => 'Cuestionario de control del asma';

  @override
  String get s5AddDetails => 'Agregar detalles';

  @override
  String get s5AddRecord => 'Agregar registro';

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
  String get s5Back => 'Atrás';

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
  String get s5Change => 'Cambiar';

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
  String get s5Delete => 'Eliminar';

  @override
  String get s5DeleteConfirm => '¿Eliminar este registro?';

  @override
  String get s5DeleteFailed => 'No se pudo eliminar. Inténtelo de nuevo.';

  @override
  String get s5Edit => 'Editar';

  @override
  String get s5EnglishVersion => 'English (for clinician)';

  @override
  String get s5EntryRemoved => 'Registro eliminado.';

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
  String get s5FieldDate => 'Fecha';

  @override
  String get s5FieldMedication => 'Medicamento';

  @override
  String get s5FieldNote => 'Nota (opcional)';

  @override
  String get s5FieldPuffs => 'Número de inhalaciones (opcional)';

  @override
  String get s5FieldReason => 'Motivo (opcional)';

  @override
  String get s5FieldTime => 'Hora';

  @override
  String get s5FilterAll => 'Todo';

  @override
  String get s5FilterInhaler => 'Inhalador';

  @override
  String get s5FilterMedCheck => 'Control de medicamento';

  @override
  String get s5FilterSymptoms => 'Síntomas';

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
  String get s5FromUrgentHelp => 'Registrado desde Ayuda urgente';

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
  String get s5InhalerEditTitle => 'Detalles del uso del inhalador';

  @override
  String get s5InhalerEntry => 'Uso del inhalador';

  @override
  String get s5InhalerLogged => 'Uso del inhalador registrado.';

  @override
  String get s5InhalerOneEntryHint =>
      'Cada vez que guarda, se crea un registro de uso del inhalador. No cuenta como una inhalación ni como un día.';

  @override
  String s5InhalerUnknownCount(int n) {
    return 'Medicamento sin identificar: $n';
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
  String get s5Last30Days => 'Últimos 30 días';

  @override
  String get s5Last7Days => 'Últimos 7 días';

  @override
  String get s5LogInhaler => 'Registrar uso del inhalador';

  @override
  String get s5LogLegend =>
      'Cada línea es un registro guardado. Los días sin registros aparecen como “sin registrar”, que no es lo mismo que cero.';

  @override
  String get s5LogSymptoms => 'Registrar síntomas';

  @override
  String get s5MedAdd => 'Agregar medicamento';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return 'Días que lo usó: $a · no lo usó: $b · no recuerda: $c · sin registrar: $d';
  }

  @override
  String get s5MedCheckIntro =>
      'Una revisión que usted mismo informa sobre si usó su medicina. No se basa en registros de la farmacia.';

  @override
  String get s5MedCheckQuestion => '¿Usó su medicina como estaba planeado?';

  @override
  String get s5MedCheckTitle => 'Control de medicamento de hoy';

  @override
  String get s5MedChooseHint =>
      'Elija un medicamento, o “No sé el nombre del medicamento”.';

  @override
  String get s5MedDailyCheck => 'Control diario';

  @override
  String get s5MedDailyCheckHint =>
      'Mostrar “Control de medicamento de hoy” en Inicio. Actívelo solo si su profesional de salud le pidió usar esta medicina todos los días.';

  @override
  String get s5MedDefault => 'Predeterminado para registro rápido';

  @override
  String get s5MedDefaultHint =>
      'Se usa cuando toca “Registrar uso del inhalador” en Inicio.';

  @override
  String get s5MedEdit => 'Editar medicamento';

  @override
  String get s5MedNameLabel =>
      'Nombre del medicamento (como aparece en su etiqueta)';

  @override
  String get s5MedNotApplicable => 'No programado para hoy';

  @override
  String s5MedNotApplicableDays(int n) {
    return 'No programado: $n días';
  }

  @override
  String get s5MedNotRecorded => 'Medicamento sin registrar';

  @override
  String get s5MedNotSure => 'No recuerdo';

  @override
  String get s5MedNotUsed => 'No lo usé';

  @override
  String get s5MedOther => 'Otro nombre';

  @override
  String get s5MedOtherHint => 'Escriba el nombre del medicamento';

  @override
  String get s5MedReasonCost => 'Costo';

  @override
  String get s5MedReasonForgot => 'Se me olvidó';

  @override
  String get s5MedReasonNoMedicine => 'No tenía la medicina';

  @override
  String get s5MedReasonQuestion => 'Motivo (opcional)';

  @override
  String get s5MedUnknown => 'No sé el nombre del medicamento';

  @override
  String get s5MedUnknownShort => 'Medicamento sin identificar';

  @override
  String get s5MedUsed => 'Lo usé';

  @override
  String get s5MyLanguage => 'My language';

  @override
  String get s5MyLogTitle => 'Mi registro';

  @override
  String get s5MyMedsEmpty => 'Aún no hay medicamentos guardados.';

  @override
  String get s5MyMedsHint =>
      'Nombres que usted confirmó, para registrar más rápido. No es una recomendación de dosis.';

  @override
  String get s5MyMedsOpen => 'Manage my medications';

  @override
  String get s5MyMedsTitle => 'Mis medicamentos';

  @override
  String get s5NavEnvironment => 'Environment';

  @override
  String get s5NavLog => 'Log';

  @override
  String get s5NavVisitPrep => 'Visit prep';

  @override
  String get s5NoAnswer => 'Prefiero no responder';

  @override
  String get s5NoRecordsYet => 'Aún no hay registros';

  @override
  String s5NoSymptomDays(int n) {
    return 'Días marcados como “sin síntomas”: $n';
  }

  @override
  String get s5NotRecorded => 'Sin registrar';

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
    return 'Período: $days días · Días con registros: $n';
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
      other: '$n inhalaciones',
      one: '1 inhalación',
    );
    return '$_temp0';
  }

  @override
  String s5QuestionN(int n) {
    return 'Question $n';
  }

  @override
  String s5QuestionOf(int n, int total) {
    return 'Pregunta $n de $total';
  }

  @override
  String get s5ReasonBeforeActivity => 'Antes de una actividad';

  @override
  String get s5ReasonOther => 'Otro';

  @override
  String get s5ReasonSymptoms => 'Por síntomas';

  @override
  String s5RecentInhaler(int n) {
    return 'Registros de uso del inhalador: $n';
  }

  @override
  String s5RecentSymptomDays(int n) {
    return 'Días con síntomas: $n';
  }

  @override
  String get s5RecentTitle => 'Last 7 days';

  @override
  String get s5RecordsLoadFailed =>
      'No se pudieron cargar sus registros. Inténtelo de nuevo.';

  @override
  String get s5RecordsManageHint =>
      'You can edit or delete entries in My log. Deleting always asks you to confirm.';

  @override
  String get s5Refresh => 'Refresh';

  @override
  String get s5Reload => 'Load again';

  @override
  String get s5Save => 'Guardar';

  @override
  String get s5Saved => 'Guardado.';

  @override
  String get s5SavedPlacesHint => 'Saved places such as home, school, or work';

  @override
  String get s5SaveFailed => 'No se pudo guardar. Sus datos siguen aquí.';

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
  String get s5SymActivityLimited => 'Actividades limitadas';

  @override
  String get s5SymCough => 'Tos';

  @override
  String get s5SymNightWaking => 'Se despertó de noche';

  @override
  String get s5SymNone => 'Sin síntomas';

  @override
  String get s5SymOther => 'Otra cosa';

  @override
  String get s5SymOtherHint => 'Descríbalo con sus propias palabras';

  @override
  String get s5SymShortBreath => 'Dificultad para respirar';

  @override
  String get s5SymWheeze => 'Silbidos en el pecho';

  @override
  String get s5SymptomEditTitle => 'Editar síntomas';

  @override
  String get s5SymptomEntry => 'Síntomas';

  @override
  String get s5SymptomNoneHint =>
      'Los días que no registra aparecen como “sin registrar”, no como “sin síntomas”.';

  @override
  String get s5SymptomQuestion => '¿Qué notó?';

  @override
  String get s5Today => 'Hoy';

  @override
  String get s5Undo => 'Deshacer';

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
      'Si su profesional de salud le dio un plan de acción para el asma, sígalo.';

  @override
  String get s5UrgentCall911Locked => 'Urgent help: call 911';

  @override
  String get s5UrgentHelp => 'Ayuda urgente';

  @override
  String get s5UrgentIntro =>
      'Si le cuesta mucho respirar o no mejora, llame al 911.';

  @override
  String get s5UrgentLogHint =>
      'Opcional: guarde un registro de que usó su inhalador.';

  @override
  String get s5UrgentNoContact =>
      'Aún no hay contacto de emergencia. Agregue uno en Configuración → Ayuda.';

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
  String get s6AddTime => 'Agregar una hora';

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
  String get s6DoseLater => 'Revisar después';

  @override
  String get s6DoseNotUsed => 'No pude usarlo';

  @override
  String get s6DoseUnconfirmed => 'No answer yet';

  @override
  String get s6DoseUsed => 'Lo usé';

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
  String get s6HomeWaterQuestion => '¿Hubo una gotera o inundación en su casa?';

  @override
  String get s6HomeWaterYes => 'Sí';

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
  String get s6OccurredLabel => 'Cuándo ocurrió';

  @override
  String get s6PdfEnvLimit =>
      'Regional reference only. It does not show personal exposure or the cause of symptoms. A single AQI does not name ozone and particles together, and it does not include pollen.';

  @override
  String get s6PdfEnvTitle => 'Environment reference (appendix)';

  @override
  String get s6PuffsEach => 'Inhalaciones cada vez';

  @override
  String s6ReminderBodyNamed(String name) {
    return 'Es hora de confirmar $name';
  }

  @override
  String get s6ReminderBodyPrivate => 'Es hora de confirmar su medicina';

  @override
  String get s6ReminderChannel =>
      'Recordatorios a las horas de dosis que guardó. No es una alerta de 30 minutos.';

  @override
  String get s6ReminderTitle => 'Control de medicina';

  @override
  String get s6RoleBoth => 'Diaria y cuando la necesite';

  @override
  String get s6RoleController => 'Medicina diaria';

  @override
  String get s6RoleRescue => 'Cuando la necesite';

  @override
  String get s6ScheduleTimes => 'Horas en que la toma';

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
  String get cnTagline => 'Cartas del seguro, pasos claros';

  @override
  String get cnDemoBadge => 'Ejemplo';

  @override
  String get cnDemoBadgeLong =>
      'Ejemplo con datos inventados. Los resultados son fijos.';

  @override
  String get cnAuthSignInTitle => 'Iniciar sesión';

  @override
  String get cnAuthCreateTitle => 'Crear cuenta';

  @override
  String get cnAuthResetTitle => 'Restablecer contraseña';

  @override
  String get cnAuthSignIn => 'Iniciar sesión';

  @override
  String get cnAuthCreate => 'Crear cuenta';

  @override
  String get cnAuthSendReset => 'Enviar enlace';

  @override
  String cnAuthProfileError(String code) {
    return 'Inició sesión, pero no se pudo cargar su cuenta ($code).';
  }

  @override
  String get cnRetry => 'Intentar de nuevo';

  @override
  String get cnSignOut => 'Cerrar sesión';

  @override
  String get cnAuthPreparingAccount => 'Preparando su cuenta…';

  @override
  String get cnAuthNameLabel => 'Nombre (opcional)';

  @override
  String get cnAuthNameHelper =>
      'Aparece en sus paquetes. Puede cambiarlo después.';

  @override
  String get cnAuthEmailLabel => 'Correo electrónico';

  @override
  String get cnAuthPasswordLabel => 'Contraseña';

  @override
  String get cnAuthPasswordHelper => 'Al menos 8 caracteres';

  @override
  String get cnAuthShowPassword => 'Mostrar contraseña';

  @override
  String get cnAuthHidePassword => 'Ocultar contraseña';

  @override
  String get cnAuthPasswordRequired => 'Escriba su contraseña';

  @override
  String cnAuthCheckEmail(String email) {
    return 'Enviamos un enlace de confirmación a $email. Ábralo en este teléfono y luego inicie sesión.';
  }

  @override
  String cnAuthResetSent(String email) {
    return 'Si existe una cuenta para $email, le enviaremos un enlace. Ábralo en este teléfono.';
  }

  @override
  String get cnAuthResent => 'Enviado de nuevo.';

  @override
  String get cnAuthResend => 'Reenviar correo';

  @override
  String get cnAuthSignInInstead => 'Ya confirmé. Iniciar sesión';

  @override
  String get cnAuthForgot => '¿Olvidó su contraseña?';

  @override
  String get cnAuthNoAccount => '¿Es nuevo? Cree una cuenta';

  @override
  String get cnAuthHaveAccount => '¿Ya tiene cuenta? Inicie sesión';

  @override
  String get cnAuthResetHint =>
      'Escriba su correo electrónico y le enviaremos un enlace para crear una contraseña nueva.';

  @override
  String get cnAuthBackToSignIn => 'Volver a iniciar sesión';

  @override
  String get cnAuthPrivacyLine =>
      'Sus cartas y registros son privados y solo están en su cuenta.';

  @override
  String get cnAuthPasswordUpdated => 'Contraseña actualizada.';

  @override
  String get cnAuthNewPasswordTitle => 'Cree una contraseña nueva';

  @override
  String get cnAuthNewPasswordLabel => 'Contraseña nueva';

  @override
  String get cnAuthSavePassword => 'Guardar contraseña';

  @override
  String get cnLater => 'Después';

  @override
  String get cnAuthErrInvalidCredentials =>
      'El correo electrónico o la contraseña no son correctos.';

  @override
  String get cnAuthErrNotConfirmed =>
      'Primero confirme su correo electrónico. Revise su bandeja de entrada o reenvíe el enlace.';

  @override
  String get cnAuthErrExists =>
      'Ya existe una cuenta con este correo electrónico. Inicie sesión.';

  @override
  String get cnAuthErrWeakPassword =>
      'Elija una contraseña más segura (al menos 8 caracteres).';

  @override
  String get cnAuthErrSamePassword =>
      'Use una contraseña diferente a la anterior.';

  @override
  String get cnAuthErrRateLimited =>
      'Demasiados intentos. Espere un minuto e inténtelo de nuevo.';

  @override
  String get cnAuthErrInvalidEmail => 'Revise el correo electrónico.';

  @override
  String get cnAuthErrEmailNotAuthorized =>
      'Ahora no podemos enviar correos a esta dirección. Inténtelo más tarde.';

  @override
  String get cnAuthErrDisabled =>
      'Este método para iniciar sesión está desactivado.';

  @override
  String get cnAuthErrSessionExpired =>
      'Su sesión terminó. Inicie sesión de nuevo.';

  @override
  String cnAuthErrUnknown(String code) {
    return 'Algo salió mal ($code). Inténtelo de nuevo.';
  }

  @override
  String get cnErrNetwork =>
      'Sin conexión. Revise su internet e inténtelo de nuevo.';

  @override
  String get cnErrServiceDown =>
      'El servicio no responde. Inténtelo de nuevo en unos minutos.';

  @override
  String get cnTabHome => 'Inicio';

  @override
  String get cnTabCases => 'Casos';

  @override
  String get cnTabRecords => 'Registros';

  @override
  String get cnTabAccount => 'Cuenta';

  @override
  String get cnHomeHeadline => 'Entienda la carta de su seguro médico.';

  @override
  String get cnScanLetter => 'Escanear una carta';

  @override
  String get cnUploadFile => 'Subir PDF o foto';

  @override
  String get cnTryDemo => 'Probar ejemplo';

  @override
  String get cnHomeSignInLine => 'Para guardar sus casos necesita una cuenta.';

  @override
  String get cnServiceNotConfigured =>
      'Esta versión no está conectada al servidor. Solo funciona el ejemplo.';

  @override
  String get cnContinueCase => 'Continuar su caso';

  @override
  String get cnHowItWorks => 'Cómo funciona';

  @override
  String get cnStep1Title => 'Leer la carta';

  @override
  String get cnStep1Body =>
      'Tome una foto. Buscamos el motivo, el siguiente paso y la fecha.';

  @override
  String get cnStep2Title => 'Reunir registros';

  @override
  String get cnStep2Body =>
      'Compare lo que pide la carta con sus propios registros.';

  @override
  String get cnStep3Title => 'Crear un paquete';

  @override
  String get cnStep3Body =>
      'Obtenga un resumen de una página para su médico y un borrador de solicitud de revisión.';

  @override
  String get cnRecentCases => 'Otros casos';

  @override
  String get cnNoCasesYet => 'Aún no hay casos';

  @override
  String get cnNoOtherCases => 'No hay otros casos.';

  @override
  String get cnSeeAllCases => 'Ver todos los casos';

  @override
  String get cnNoCasesBody => 'Escanee una carta del seguro para empezar.';

  @override
  String get cnCasesSignInTitle => 'Inicie sesión para ver sus casos';

  @override
  String get cnCasesSignInBody => 'O abra el ejemplo para ver cómo funciona.';

  @override
  String get cnCaseDeleted => 'Caso eliminado.';

  @override
  String get cnCaseUntitled => 'Carta del seguro';

  @override
  String get cnStatusReading => 'Leyendo la carta';

  @override
  String get cnStatusNeedsReview => 'Necesita revisión';

  @override
  String get cnStatusGatherRecords => 'Reunir registros';

  @override
  String get cnStatusPacketReady => 'Paquete listo';

  @override
  String get cnStatusNeedsAttention => 'Necesita atención';

  @override
  String get cnStatusNotStarted => 'Sin comenzar';

  @override
  String get cnNextWaitReading => 'Estamos leyendo la carta.';

  @override
  String get cnNextTryAgain =>
      'La lectura se detuvo. Abra el caso para intentarlo de nuevo.';

  @override
  String cnNextFactsToConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count datos por confirmar',
      one: '1 dato por confirmar',
    );
    return '$_temp0';
  }

  @override
  String cnNextItemsAttached(int done, int total) {
    return '$done de $total documentos pedidos ya atendidos';
  }

  @override
  String get cnNextSharePacket => 'Paquete listo para compartir';

  @override
  String get cnNextCreatePacket => 'Siguiente: crear el paquete';

  @override
  String cnDateToCheckShort(String date) {
    return 'Fecha para revisar: $date';
  }

  @override
  String cnDatePassedShort(String date) {
    return 'Fecha vencida: $date';
  }

  @override
  String get cnMoreActions => 'Más acciones';

  @override
  String get cnDeleteCase => 'Eliminar caso';

  @override
  String get cnDeleteCaseTitle => '¿Eliminar este caso?';

  @override
  String get cnDeleteCaseBody =>
      'Esto elimina las páginas de la carta, los datos leídos de ellas, los resúmenes de registros vinculados y los paquetes. Sus registros de medicamentos y síntomas se quedan.';

  @override
  String get cnCancel => 'Cancelar';

  @override
  String get cnDelete => 'Eliminar';

  @override
  String get cnDeleteFailed =>
      'No se pudo eliminar. Revise su conexión e inténtelo de nuevo.';

  @override
  String get cnKindInitialDenial =>
      'Denegación de cobertura de un medicamento (Denial)';

  @override
  String get cnKindInfoRequest => 'Solicitud de más información';

  @override
  String get cnKindReauth => 'Aviso de renovación (Reauthorization)';

  @override
  String get cnKindFinalDenial =>
      'Decisión final de la apelación (Final appeal decision)';

  @override
  String get cnKindEob =>
      'Factura o explicación de beneficios (Explanation of Benefits)';

  @override
  String get cnKindOther => 'Otra carta';

  @override
  String get cnKindUncertain => 'Tipo de carta poco claro';

  @override
  String get cnFieldPatientName => 'Nombre del paciente';

  @override
  String get cnFieldPlanName => 'Plan';

  @override
  String get cnFieldMemberId => 'Número de miembro';

  @override
  String get cnFieldCaseReference => 'Número de caso o de referencia';

  @override
  String get cnFieldMedication => 'Medicamento (como está escrito)';

  @override
  String get cnFieldDose => 'Dosis (como está escrita)';

  @override
  String get cnFieldNoticeDate => 'Fecha de la carta';

  @override
  String get cnFieldContact => 'Contacto';

  @override
  String get cnFieldSubmissionRoute => 'Dónde enviarlo';

  @override
  String get cnFactEdited => 'Editado por usted';

  @override
  String get cnFactChecked => 'Revisado';

  @override
  String get cnFactNotInLetter => 'No está en la carta';

  @override
  String get cnFactNeedsCheck => 'Hay que revisarlo';

  @override
  String get cnFactFromLetter => 'De la carta';

  @override
  String get cnWhoYou => 'Usted';

  @override
  String get cnWhoCareTeam => 'Equipo de atención';

  @override
  String get cnWhoPlan => 'Plan';

  @override
  String get cnWhoUnknown => 'No sé';

  @override
  String get cnReqLinked => 'Vinculado';

  @override
  String get cnReqAskedCareTeam => 'Pedido al equipo de atención';

  @override
  String get cnReqNotAvailable => 'No disponible';

  @override
  String get cnReqNotNeeded => 'No se necesita';

  @override
  String get cnReqNeeded => 'Se necesita';

  @override
  String get cnReqReset => 'Marcar como necesario';

  @override
  String get cnRecMedication => 'Historial de medicamentos';

  @override
  String get cnRecSymptoms => 'Registro de síntomas';

  @override
  String get cnRecLocalContext => 'Contexto local';

  @override
  String get cnRecPrn => 'Inhalador cuando lo necesita';

  @override
  String get cnDemoTitle => 'Ejemplo';

  @override
  String get cnDemoReset => 'Reiniciar ejemplo';

  @override
  String get cnDemoResetDone => 'Ejemplo reiniciado.';

  @override
  String get cnDemoIntro =>
      'Tres cartas inventadas con resultados fijos, para que vea cada paso. No se sube nada.';

  @override
  String get cnUpEmpty => 'Ese archivo está vacío.';

  @override
  String cnUpTooLarge(int mb) {
    return 'Cada archivo debe pesar $mb MB o menos.';
  }

  @override
  String cnUpCaseTooLarge(int mb) {
    return 'Todas las páginas juntas deben pesar $mb MB o menos.';
  }

  @override
  String cnUpTooManyPages(int max) {
    return 'Hasta $max páginas por carta.';
  }

  @override
  String get cnUpUnsupported =>
      'Use JPG, PNG o PDF. Si la foto es HEIC, tome una foto nueva aquí.';

  @override
  String get cnUpBadFile =>
      'No se puede leer este archivo. Pruebe con otra foto o PDF.';

  @override
  String get cnUpEncrypted =>
      'Este PDF tiene contraseña. Guarde una copia sin contraseña o tome fotos.';

  @override
  String get cnCameraUnavailable =>
      'La cámara no está disponible. Puede subir una foto o un PDF.';

  @override
  String get cnPhotosUnavailable =>
      'No se pueden abrir las fotos. Permita el acceso a las fotos en la configuración, o suba un PDF.';

  @override
  String get cnFilesUnavailable =>
      'No se pueden abrir los archivos ahora. Inténtelo de nuevo.';

  @override
  String get cnUploadFailed =>
      'La subida no terminó. Sus páginas siguen aquí. Inténtelo de nuevo.';

  @override
  String get cnCaptureTitle => 'Agregar páginas de la carta';

  @override
  String get cnReplacePagesTitle => 'Reemplazar páginas de la carta';

  @override
  String get cnOpening => 'Abriendo…';

  @override
  String get cnCaptureEmptyTitle => 'Agregue las páginas de su carta';

  @override
  String get cnCaptureTips =>
      'Ponga la hoja plana, con buena luz, y que se vean las cuatro esquinas. Agregue todas las páginas, en orden.';

  @override
  String get cnTakePhoto => 'Tomar foto';

  @override
  String get cnAddPage => 'Agregar página';

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
      'Al subir, estas páginas se envían al servidor de CoverNote, donde un servicio de IA las lee por usted. Puede eliminar el caso cuando quiera.';

  @override
  String get cnStageUploading => 'Subiendo';

  @override
  String get cnUploadAndRead => 'Subir y leer';

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
    return 'Archivo $n · PDF, $_temp0';
  }

  @override
  String cnPreviewPage(int n) {
    return 'Ver página $n';
  }

  @override
  String get cnRotate => 'Girar';

  @override
  String get cnRetake => 'Repetir foto';

  @override
  String get cnRemovePage => 'Quitar';

  @override
  String get cnReorder => 'Arrastre para cambiar el orden';

  @override
  String get cnServiceUnavailableBody =>
      'El lector de cartas no está listo en este momento. Sus páginas están guardadas; inténtelo más tarde.';

  @override
  String get cnNeedNewPagesBody =>
      'Tome fotos más claras o use menos páginas, y luego súbalas de nuevo.';

  @override
  String get cnPagesKept => 'Sus páginas están guardadas. No se cambió nada.';

  @override
  String get cnReplacePages => 'Reemplazar páginas';

  @override
  String get cnTryAgain => 'Intentar de nuevo';

  @override
  String get cnStageReading => 'Leyendo';

  @override
  String get cnStageChecking => 'Revisando';

  @override
  String get cnStageReady => 'Listo';

  @override
  String get cnReadingTitle => 'Leyendo su carta';

  @override
  String get cnReadingBody =>
      'Cuando termine, usted revisa lo que encontramos y lo compara con la carta.';

  @override
  String get cnReadingLeaveOk =>
      'Puede salir de esta pantalla. La lectura continúa y su caso queda guardado.';

  @override
  String get cnStartReading => 'Empezar a leer';

  @override
  String get cnStepLetter => 'Carta';

  @override
  String get cnStepReview => 'Revisión';

  @override
  String get cnStepEvidence => 'Pruebas';

  @override
  String get cnStepPacket => 'Paquete';

  @override
  String cnStepOf(int n, int total, String name) {
    return 'Paso $n de $total: $name';
  }

  @override
  String get cnSaving => 'Guardando…';

  @override
  String get cnSaved => 'Guardado';

  @override
  String get cnNotSavedRetry => 'No se guardó · Reintentar';

  @override
  String get cnViewOriginal => 'Ver páginas originales';

  @override
  String cnLetterPagesRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas leídas',
      one: '1 página leída',
    );
    return '$_temp0';
  }

  @override
  String cnPagesHardToRead(String list) {
    return 'Difícil de leer: página $list. Revise estos datos con cuidado o repita la foto de la página.';
  }

  @override
  String get cnRetakePages => 'Repetir fotos';

  @override
  String get cnHardToRead => 'Difícil de leer';

  @override
  String get cnContinueToReview => 'Continuar a la revisión';

  @override
  String get cnOriginalPages => 'Páginas originales';

  @override
  String get cnNoOriginal => 'No se guardaron las páginas originales.';

  @override
  String get cnCheckDetails => 'Revise los datos';

  @override
  String get cnCheckDetailsHint =>
      'Compare cada valor con su carta. Toque una cita para ver de dónde salió.';

  @override
  String cnItemsLeftToCheck(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Revise $count datos más para continuar',
      one: 'Revise 1 dato más para continuar',
    );
    return '$_temp0';
  }

  @override
  String get cnContinueToEvidence => 'Continuar a las pruebas';

  @override
  String cnSeePage(int n) {
    return 'Ver página $n';
  }

  @override
  String get cnWhatLetterIs => 'Qué es esta carta';

  @override
  String get cnLooksRight => 'Está bien';

  @override
  String get cnChange => 'Cambiar';

  @override
  String get cnCardWhyDenied => 'Por qué se denegó';

  @override
  String get cnCardWhatTheyNeed => 'Qué pidieron';

  @override
  String get cnCardWhatItSays => 'Qué dice la carta';

  @override
  String get cnNoReasonFound => 'No se encontró un motivo en la carta.';

  @override
  String get cnCardNextStep => 'Siguiente paso';

  @override
  String cnNextDenial(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Pida a su equipo de atención que solicite una revisión. La carta menciona $count documentos para enviar.',
      one:
          'Pida a su equipo de atención que solicite una revisión. La carta menciona 1 documento para enviar.',
      zero:
          'Pida a su equipo de atención que solicite una revisión. La carta no menciona documentos específicos.',
    );
    return '$_temp0';
  }

  @override
  String cnNextInfoRequest(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Envíe los $count documentos que pidió el plan antes de la fecha indicada abajo.',
      one:
          'Envíe el documento que pidió el plan antes de la fecha indicada abajo.',
      zero:
          'Envíe la información que pidió el plan antes de la fecha indicada abajo.',
    );
    return '$_temp0';
  }

  @override
  String get cnNextReauth =>
      'Anote cuándo termina la aprobación actual y pida a su equipo de atención que inicie la renovación.';

  @override
  String get cnNextFinal =>
      'Esta es una decisión final. CoverNote no prepara un primer borrador de solicitud de revisión para ella. Pregunte al plan o a su equipo de atención sobre las opciones que menciona la carta.';

  @override
  String get cnNextEob =>
      'Parece una factura o un estado de beneficios, no una denegación. Consúltelo con servicios para miembros del plan.';

  @override
  String get cnNextUncertain =>
      'Primero confirme qué tipo de carta es, arriba.';

  @override
  String cnWhereToSend(String route) {
    return 'Dónde enviarlo: $route';
  }

  @override
  String cnWhoToCall(String contact) {
    return 'Contacto: $contact';
  }

  @override
  String get cnCardDate => 'Fecha para revisar';

  @override
  String cnDateCalculated(String anchor, int days) {
    return 'Calculado: $anchor + $days días calendario';
  }

  @override
  String get cnReceivedDateWord => 'fecha en que la recibió';

  @override
  String get cnNoticeDateWord => 'fecha de la carta';

  @override
  String get cnDateEnteredByYou => 'Escrita por usted';

  @override
  String get cnDateFromLetter => 'Indicada en la carta';

  @override
  String cnReceivedOn(String date) {
    return 'Usted la recibió el $date';
  }

  @override
  String get cnDatePassed =>
      'Esta fecha ya pasó. Llame al plan para preguntar qué puede hacer todavía.';

  @override
  String cnNeedReceivedDate(int days) {
    return 'La carta da $days días calendario desde el día en que usted la recibió. ¿Cuándo le llegó?';
  }

  @override
  String get cnEnterReceivedDate => 'Escribir fecha de recibo';

  @override
  String get cnDateConflict =>
      'La carta da fechas distintas. Pregunte al plan cuál aplica y luego elíjala.';

  @override
  String cnUseThisDate(String date) {
    return 'Usar $date';
  }

  @override
  String get cnDateUnclear =>
      'El texto no es claro o cuenta días hábiles, por eso CoverNote no calcula la fecha. Pida al plan la fecha exacta.';

  @override
  String get cnNoDeadline =>
      'No se encontró en la carta una fecha límite para la revisión.';

  @override
  String cnReplyBy(String date) {
    return 'Responda a la solicitud de información a más tardar el $date (según la carta)';
  }

  @override
  String get cnEnterDatePlanGave => 'Escribir una fecha';

  @override
  String get cnUseLetterDate => 'Usar la fecha de la carta';

  @override
  String get cnLeaveUnknown => 'Dejarla como desconocida por ahora';

  @override
  String get cnDateUnknownChecked => 'Desconocida, anotado';

  @override
  String get cnTypeAsWritten =>
      'Escríbalo exactamente como aparece en la carta.';

  @override
  String get cnCheckThisValue =>
      'Este valor parece raro. Compárelo con la carta.';

  @override
  String get cnDone => 'Listo';

  @override
  String get cnEdit => 'Editar';

  @override
  String get cnAdd => 'Agregar';

  @override
  String get cnNoRecordsToLink =>
      'No hay registros de los últimos 30 días para vincular. Aun así puede marcar quién tiene este documento.';

  @override
  String cnLinkTitle(String label) {
    return 'Vincular un registro a: $label';
  }

  @override
  String get cnLinkNote =>
      'Sus propios registros apoyan la solicitud. No reemplazan las notas de la clínica ni los resultados de pruebas.';

  @override
  String cnMedLine(int taken, int notTaken, int unknown, int scheduled) {
    return '$taken tomadas / $notTaken no tomadas / $unknown sin saber, de $scheduled dosis programadas';
  }

  @override
  String cnPrnLine(int uses, int puffs) {
    return 'Cuando la necesita: $uses usos, $puffs inhalaciones';
  }

  @override
  String get cnNoEntries => 'Sin registros';

  @override
  String cnSymptomLine(int days, int night, int entries, int total) {
    return 'Síntomas en $days días, despertares de noche en $night días ($entries de $total días registrados)';
  }

  @override
  String cnPmLine(int days, int total, int high) {
    return 'Datos de PM2.5 de $days de $total días; $high días por encima de AQI 100';
  }

  @override
  String cnReportsLine(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count informes propios',
      one: '1 informe propio',
    );
    return '$_temp0';
  }

  @override
  String get cnSyntheticData => 'Datos de ejemplo';

  @override
  String get cnLetterAsksFor => 'Qué pide la carta';

  @override
  String get cnNoItemsListed =>
      'La carta no menciona documentos específicos. Puede agregar los suyos.';

  @override
  String get cnAddItemLabel => 'Agregar un documento para dar seguimiento';

  @override
  String cnYourRecords(String from, String to) {
    return 'Sus registros ($from – $to)';
  }

  @override
  String get cnLocalContextNote =>
      'Contexto opcional. No es una medición en su casa ni la causa de sus síntomas.';

  @override
  String get cnContinueToPacket => 'Continuar al paquete';

  @override
  String get cnAddedByYou => 'Agregado por usted';

  @override
  String get cnFromLetter => 'De la carta';

  @override
  String cnWhoHasIt(String who) {
    return 'Quién lo tiene: $who';
  }

  @override
  String cnLinkedTo(String record) {
    return 'Vinculado: $record';
  }

  @override
  String get cnSeeInLetter => 'Ver en la carta';

  @override
  String get cnLinkRecords => 'Vincular mis registros';

  @override
  String get cnOtherStatus => 'Otro estado';

  @override
  String get cnInPacket => 'En el paquete';

  @override
  String get cnRemoveFromPacket => 'Quitar del paquete';

  @override
  String get cnAddToPacket => 'Agregar al paquete';

  @override
  String get cnErrNotSavedYet =>
      'Sus últimos cambios aún no se han guardado. Revise su conexión e inténtelo de nuevo.';

  @override
  String get cnPacketChangedMeanwhile =>
      'Los datos o registros cambiaron mientras se preparaba el paquete. Créelo de nuevo.';

  @override
  String get cnPacketFailed =>
      'No se pudo crear el paquete. Inténtelo de nuevo.';

  @override
  String get cnBeforeSharingTitle => 'Antes de compartir';

  @override
  String get cnBeforeSharingBody =>
      'Este archivo tiene su nombre y datos de salud. Compártalo solo con su equipo de atención o con su plan. Compartir no envía nada por usted.';

  @override
  String get cnShare => 'Compartir';

  @override
  String get cnMethodFax => 'Fax';

  @override
  String get cnMethodMail => 'Correo postal';

  @override
  String get cnMethodPortal => 'Portal en línea';

  @override
  String get cnMethodInPerson => 'En persona';

  @override
  String get cnMethodCareTeam => 'Lo envió el equipo de atención';

  @override
  String get cnMethodOther => 'Otro';

  @override
  String get cnPacketNoDraftFinal =>
      'Para una decisión final, el paquete solo incluye el resumen para el médico. No se hace un borrador de revisión de primer nivel.';

  @override
  String get cnPacketNoDraftEob =>
      'Para una factura o un estado de beneficios, el paquete solo incluye el resumen para el médico.';

  @override
  String get cnPacketNoDraftReauth =>
      'Para un aviso de renovación, el paquete solo incluye el resumen para el médico, para ayudar a su equipo de atención a renovar.';

  @override
  String get cnPacketNoDraftOther =>
      'Si la carta no es una denegación ni una solicitud de información, el paquete solo incluye el resumen para el médico.';

  @override
  String get cnPacketContains => 'Este paquete incluirá';

  @override
  String get cnPartSummary => 'Resumen para el médico (1 página)';

  @override
  String get cnPartDraft =>
      'Borrador de solicitud de revisión (para que lo complete su equipo de atención)';

  @override
  String get cnPartLetterText => 'Anexo: el texto de la carta';

  @override
  String cnPacketEvidenceCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resúmenes de registros agregados',
      one: '1 resumen de registros agregado',
      zero: 'No se agregaron resúmenes de registros',
    );
    return '$_temp0';
  }

  @override
  String get cnIncludeLetterText => 'Agregar el texto de la carta como anexo';

  @override
  String get cnPacketStale =>
      'Los datos o registros cambiaron desde el último paquete. Créelo de nuevo para actualizarlo.';

  @override
  String get cnGenerating => 'Creando…';

  @override
  String get cnGeneratePacket => 'Crear paquete de revisión';

  @override
  String get cnSaveOrPrint => 'Guardar o imprimir';

  @override
  String get cnISentIt => 'Lo envié';

  @override
  String cnSharedOn(String date) {
    return 'Compartido el $date';
  }

  @override
  String cnUserReportedSent(String date, String method) {
    return 'Usted informó que lo envió el $date ($method)';
  }

  @override
  String get cnTabDoctorSummary => 'Resumen para el médico';

  @override
  String get cnTabReviewDraft => 'Borrador de solicitud de revisión';

  @override
  String get cnSentExplain =>
      'Anote cuándo y cómo se envió. CoverNote no lo envía ni da seguimiento a ninguna decisión.';

  @override
  String get cnSave => 'Guardar';

  @override
  String get cnCtxPm25 => 'PM2.5 (AQI)';

  @override
  String get cnCtxNo2 => 'NO₂';

  @override
  String get cnCtxOutdoorHumidity => 'Humedad exterior';

  @override
  String cnObservedOn(String date) {
    return 'Observado el $date';
  }

  @override
  String get cnCtxIntro =>
      'Lecturas del aire de una fuente con nombre y cosas que usted notó, guardadas por separado. Agréguelas a un caso solo si ayudan a explicar sus registros.';

  @override
  String get cnCtxReadings => 'Lecturas del aire';

  @override
  String get cnCtxReadingsNote =>
      'Lecturas de la región para el día en que se observaron. No miden los gases de escape del tráfico en su casa.';

  @override
  String get cnCtxAddReading => 'Agregar una lectura';

  @override
  String get cnCtxReports => 'Lo que usted notó';

  @override
  String get cnCtxReportsNote => 'Sus propios informes. No son mediciones.';

  @override
  String get cnCtxAddReport => 'Agregar lo que notó';

  @override
  String get cnReportExhaust => 'Muchos gases de escape cerca';

  @override
  String get cnReportWater => 'Entrada de agua en la casa';

  @override
  String get cnReportDamp => 'Lugar húmedo o con olor a moho dentro de la casa';

  @override
  String cnOnDate(String date) {
    return 'Fecha: $date';
  }

  @override
  String get cnNoteOptional => 'Nota (opcional)';

  @override
  String get cnCtxWhat => 'Lectura';

  @override
  String get cnCtxHumidityNote =>
      'La humedad exterior es un dato del clima. No indica humedad ni moho dentro de su casa.';

  @override
  String get cnCtxValue => 'Valor';

  @override
  String get cnCtxValueInvalid => 'Escriba un número válido.';

  @override
  String get cnCtxSource => 'Fuente';

  @override
  String get cnCtxSourceHelp =>
      'De dónde salió el número, por ejemplo AirNow o un monitor local';

  @override
  String get cnCtxSourceRequired => 'Agregue la fuente.';

  @override
  String get cnCtxPlace => 'Lugar (código postal o ciudad, opcional)';

  @override
  String get cnRecordsSignInBody =>
      'Inicie sesión para guardar sus registros de medicamentos, síntomas y contexto local.';

  @override
  String get cnRecordsYourRecords => 'Sus registros';

  @override
  String get cnRecMedicationSub => 'Medicinas y dosis que usted toma';

  @override
  String get cnRecDailyLog => 'Registro diario';

  @override
  String get cnRecDailyLogSub => 'Síntomas y uso del inhalador';

  @override
  String get cnRecLocalContextSub => 'Lecturas del aire y lo que usted notó';

  @override
  String get cnHelp => 'Ayuda';

  @override
  String get cnUrgentHelp => 'Ayuda urgente';

  @override
  String get cnUrgentHelpSub =>
      'Pasos para una emergencia respiratoria y cómo llamar al 911';

  @override
  String cnLast30Days(String from, String to) {
    return 'Últimos 30 días ($from – $to)';
  }

  @override
  String get cnNoSchedule => 'No hay un horario fijo';

  @override
  String get cnRecordsUnknownNote =>
      'Los días sin registro quedan como desconocidos. No se cuentan como omitidos.';

  @override
  String get cnDeleteAccountTitle => '¿Eliminar su cuenta?';

  @override
  String get cnDeleteAccountBody =>
      'Esto elimina para siempre su cuenta, casos, cartas subidas, paquetes y registros. No se puede deshacer.';

  @override
  String get cnTypeDelete => 'Escriba DELETE para confirmar';

  @override
  String get cnDeleteAccount => 'Eliminar cuenta';

  @override
  String get cnAccountDeleted => 'Su cuenta fue eliminada.';

  @override
  String get cnDeleteAccountFailed =>
      'No se pudo eliminar la cuenta. Inténtelo más tarde.';

  @override
  String get cnAccountSignedOut => 'No ha iniciado sesión.';

  @override
  String get cnLanguage => 'Idioma';

  @override
  String get cnServiceStatus => 'Servicio de lectura de cartas';

  @override
  String get cnServiceReady => 'Disponible';

  @override
  String get cnServiceUnavailableShort => 'No disponible ahora';

  @override
  String get cnChecking => 'Revisando…';

  @override
  String get cnServiceUnknown => 'Sin revisar';

  @override
  String get cnCheck => 'Revisar';

  @override
  String get cnAbout => 'Acerca de';

  @override
  String get cnAboutBody =>
      'CoverNote le ayuda a leer cartas del seguro sobre medicinas y a preparar papeles para su equipo de atención. No envía nada a su plan, no decide la cobertura y no es consejo médico.';

  @override
  String get cnDangerZone => 'Eliminar cuenta';

  @override
  String get cnErrServiceUnavailable =>
      'El lector de cartas no está disponible ahora.';

  @override
  String get cnErrBusy =>
      'El servicio está ocupado. Espere un minuto e inténtelo de nuevo.';

  @override
  String get cnErrSlow => 'La lectura tardó demasiado. Inténtelo de nuevo.';

  @override
  String get cnErrUnreadable =>
      'No se pudieron leer las páginas. Repita las fotos con mejor luz.';

  @override
  String get cnErrTooManyPages => 'Demasiadas páginas. Suba hasta 10.';

  @override
  String get cnErrTooLarge =>
      'Los archivos son muy grandes. Use menos páginas o más pequeñas.';

  @override
  String get cnErrStale =>
      'Este caso cambió en otro dispositivo. Se muestra la versión más reciente.';

  @override
  String get cnErrCaseGone => 'Este caso ya no existe.';

  @override
  String get cnErrAttempts =>
      'La lectura falló varias veces. Reemplace las páginas o inténtelo más tarde.';

  @override
  String get cnErrDemoUpload =>
      'El ejemplo no puede leer archivos. Inicie sesión para escanear su propia carta.';

  @override
  String cnErrGeneric(String code) {
    return 'Algo salió mal ($code). Inténtelo de nuevo.';
  }

  @override
  String get cnLanguageChoose => 'Elija su idioma';

  @override
  String get cnLanguageNote =>
      'Parte del texto fue traducido por software y puede tener errores. Los nombres de medicinas, dosis, fechas y citas de su carta nunca se traducen.';

  @override
  String get cnLanguageButtonTooltip => 'Cambiar idioma';

  @override
  String get cnPacketEnglishNote =>
      'El paquete está escrito en inglés para que su equipo de atención pueda leerlo.';

  @override
  String get cnReasonMissingInformation =>
      'El plan dice que no recibió toda la información que necesitaba.';

  @override
  String get cnReasonStepTherapy =>
      'El plan quiere que usted pruebe primero otras medicinas (step therapy).';

  @override
  String get cnReasonMedicalNecessity =>
      'El plan dice que no pudo confirmar que esta medicina sea médicamente necesaria.';

  @override
  String get cnReasonFormulary =>
      'El plan dice que esta medicina no está en su lista de medicinas cubiertas (formulary).';

  @override
  String get cnReasonQuantityLimit =>
      'El plan dice que la cantidad pedida es más de lo que cubre.';

  @override
  String get cnReasonEligibility =>
      'El plan dice que esto no está cubierto según sus reglas de cobertura.';

  @override
  String get cnReasonOther =>
      'La carta da otro motivo. Abra la cita de la carta para leerlo.';

  @override
  String get cnReqHintMedHistory => 'Sus medicinas pasadas y actuales';

  @override
  String get cnReqHintVisitNotes => 'Notas de sus visitas al médico';

  @override
  String get cnReqHintTestResults => 'Resultados de pruebas o de laboratorio';

  @override
  String get cnReqHintDoctorStatement => 'Una declaración de su médico';
}
