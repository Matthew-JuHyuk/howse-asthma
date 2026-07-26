// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Howse Asthma';

  @override
  String get loginTitle => 'Iniciar sesión';

  @override
  String get loginEmailLabel => 'Correo electrónico';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get signUpButton => 'Crear cuenta';

  @override
  String get supabaseNotConfigured =>
      'Supabase aún no está configurado.\nAñade SUPABASE_URL y SUPABASE_ANON_KEY a tu archivo .env.';

  @override
  String get homeGreeting => 'Hola';

  @override
  String get homeAirQualityTitle => 'Calidad del aire cerca de ti';

  @override
  String get homeWeatherTitle => 'Clima cerca de ti';

  @override
  String get asthmaRiskLow => 'Riesgo bajo de asma';

  @override
  String get asthmaRiskModerate => 'Riesgo moderado de asma';

  @override
  String get asthmaRiskHigh => 'Riesgo alto de asma - tome precauciones';

  @override
  String get medicationLogTitle => 'Registro de medicamentos';

  @override
  String get medicationLogAddButton =>
      'Registrar uso de inhalador / medicamento';

  @override
  String get medicationNameLabel => 'Nombre del medicamento';

  @override
  String get medicationDoseLabel => 'Dosis';

  @override
  String get medicationTimeLabel => 'Hora de administración';

  @override
  String get medicationEffectivenessLabel => '¿Ayudó?';

  @override
  String get reportTitle => 'Informe para el seguro';

  @override
  String get reportGenerateButton => 'Generar informe para el médico / seguro';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsLanguageLabel => 'Idioma';

  @override
  String get settingsLocationLabel => 'Ubicación';

  @override
  String get notificationAttackWarningTitle =>
      'Alerta de riesgo de ataque de asma';

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
  String get navHome => 'Inicio';

  @override
  String get signUpTitle => 'Crear cuenta';

  @override
  String get authChooseRole => 'Elige tu rol';

  @override
  String get authRolePatient => 'Paciente';

  @override
  String get authRolePatientHint =>
      'Sigue el riesgo del aire y el uso del inhalador';

  @override
  String get authRoleProvider => 'Profesional';

  @override
  String get authRoleProviderHint =>
      'Vincula pacientes y revisa evidencia clínica';

  @override
  String get authFullNameLabel => 'Nombre completo';

  @override
  String get authNpiLabel => 'Número NPI';

  @override
  String get authNpiHelper => 'Identificador nacional de 10 dígitos';

  @override
  String get authOrContinueWith => 'o continuar con';

  @override
  String get authContinueGoogle => 'Continuar con Google';

  @override
  String get authContinueApple => 'Continuar con Apple';

  @override
  String get authCheckEmailTitle => 'Revisa tu correo';

  @override
  String authCheckEmailBody(String email) {
    return 'Enviamos un enlace de confirmación a $email. Ábrelo y luego inicia sesión.';
  }

  @override
  String get authBackToSignIn => 'Volver a iniciar sesión';

  @override
  String get authCompleteProfileTitle => 'Completa tu perfil';

  @override
  String get authCompleteProfileBody =>
      'Indícanos quién eres para abrir la pantalla correcta.';

  @override
  String get authSaveProfile => 'Guardar perfil';

  @override
  String get authSignOut => 'Cerrar sesión';

  @override
  String get authRetry => 'Reintentar';

  @override
  String get authWorking => 'Procesando…';

  @override
  String get authValidationInvalidEmail => 'Introduce un correo válido';

  @override
  String get authValidationPasswordMin =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get authValidationNameRequired => 'El nombre es obligatorio';

  @override
  String get authValidationInvalidNpi =>
      'Introduce un NPI válido de 10 dígitos';

  @override
  String get authErrorGeneric => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get authErrorInvalidCredentials => 'Correo o contraseña no válidos';

  @override
  String get authErrorEmailTaken => 'Ya existe una cuenta con este correo';

  @override
  String get authErrorEmailNotConfirmed =>
      'Confirma tu correo antes de iniciar sesión';

  @override
  String get authErrorWeakPassword => 'La contraseña es demasiado débil';

  @override
  String get authErrorRateLimited => 'Demasiados intentos. Prueba más tarde.';

  @override
  String get authBiometricTitle => 'Desbloquear Howse Asthma';

  @override
  String get authBiometricHint => 'Usa tu huella o rostro para continuar.';

  @override
  String get authBiometricReason => 'Desbloquear Howse Asthma';

  @override
  String get authBiometricUnlock => 'Desbloquear';

  @override
  String get authBiometricFailed =>
      'Falló el desbloqueo biométrico. Inténtalo de nuevo.';

  @override
  String get authBiometricToggle => 'Desbloqueo biométrico';

  @override
  String get authBiometricToggleHint => 'Pedir biometría al abrir la app';

  @override
  String get authBiometricUnavailable =>
      'La biometría no está disponible en este dispositivo';

  @override
  String get authOnboardingTitle => 'Configuración del paciente';

  @override
  String get authOnboardingBody =>
      'Si tu clínico compartió un código de 6 dígitos, introdúcelo ahora. También puedes hacerlo luego en Ajustes.';

  @override
  String get authOnboardingSkip => 'Omitir por ahora';

  @override
  String get authInviteCodeLabel => 'Código de invitación';

  @override
  String get authInviteCodeHelper => '6 dígitos, caduca en 24 horas';

  @override
  String get authInviteRedeem => 'Canjear';

  @override
  String get authInviteRedeemAndContinue => 'Canjear y continuar';

  @override
  String get authInviteInvalidFormat => 'El código debe tener 6 dígitos';

  @override
  String get authInviteRedeemedPending =>
      'Código canjeado. Esperando confirmación del profesional.';

  @override
  String get authInviteRedeemFailed => 'No se pudo canjear el código';

  @override
  String get authInviteIssueFailed => 'No se pudo emitir el código';

  @override
  String get authConfirmLink => 'Confirmar';

  @override
  String get authRejectLink => 'Rechazar';

  @override
  String get authLinkStatusPending => 'Pendiente de confirmación';

  @override
  String get settingsSystemDefault => 'Predeterminado del sistema';

  @override
  String get settingsLocationTodo =>
      'El permiso de ubicación se solicitará en una actualización posterior';

  @override
  String get providerHomeTab => 'Inicio';

  @override
  String get providerLinkTab => 'Vínculo';

  @override
  String get providerHomeTitle => 'Inicio del profesional';

  @override
  String providerHomeWelcome(String email) {
    return 'Sesión iniciada como $email';
  }

  @override
  String get providerHomePlaceholder =>
      'Los paneles clínicos llegarán más adelante. Empieza vinculando pacientes.';

  @override
  String get providerLinkPatientsCta => 'Vincular pacientes';

  @override
  String get providerLinkTitle => 'Vincular pacientes';

  @override
  String get providerLinkIntro =>
      'Emite un código de 6 dígitos (válido 24 horas). El paciente lo introduce y ambos confirman.';

  @override
  String get providerIssueInviteCta => 'Emitir código';

  @override
  String get providerInviteTtlHint => 'Válido durante 24 horas';

  @override
  String get providerInviteCopied => 'Código copiado';

  @override
  String get providerPendingLinks => 'Vínculos pendientes';

  @override
  String get providerNoPendingLinks => 'No hay vínculos pendientes';

  @override
  String providerPendingPatient(String idPrefix) {
    return 'Paciente $idPrefix…';
  }

  @override
  String get providerRecentInvites => 'Códigos recientes';

  @override
  String get providerNoInvites => 'Aún no hay códigos';

  @override
  String get providerInviteConsumed => 'Usado';

  @override
  String get providerInviteActive => 'Activo';
}
