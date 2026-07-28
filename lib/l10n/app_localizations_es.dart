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
  String get asthmaRiskHigh => 'Riesgo alto de asma: toma precauciones';

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
  String get mockContinue => 'Continuar';

  @override
  String get mockSignUpTitle => 'Crear cuenta';

  @override
  String get mockChooseRole => 'Elige tu rol';

  @override
  String get mockRolePatient => 'Paciente';

  @override
  String get mockRolePatientHint =>
      'Sigue el riesgo del aire y el uso del inhalador';

  @override
  String get mockRoleProvider => 'Profesional';

  @override
  String get mockRoleProviderHint => 'No está en esta vista previa de diseño';

  @override
  String get mockProviderNotInPreview =>
      'Las pantallas del profesional no están en esta vista previa de paciente.';

  @override
  String get mockBiometricTitle => 'Desbloquear';

  @override
  String get mockBiometricHint =>
      'Usa biometría para desbloquear Howse Asthma (vista previa de diseño).';

  @override
  String get mockUnlock => 'Desbloquear';

  @override
  String get mockUsePassword => 'Usar contraseña en su lugar';

  @override
  String get mockOnboardingTitle => 'Configuración del paciente';

  @override
  String get mockHomeLocation => 'Casa';

  @override
  String get mockDummyAddress => '123 Main St, Newark, NJ';

  @override
  String get mockEmergencyContact => 'Contacto de emergencia';

  @override
  String get mockDummyContact => 'Alex Guardian · +1 555 0100';

  @override
  String get mockInviteCode => 'Código de invitación del profesional';

  @override
  String get mockFinishOnboarding => 'Ir al inicio';

  @override
  String get mockAllScreens => 'Todas las pantallas';

  @override
  String get mockAllScreensHint =>
      'Abre cualquier Screen ID para revisión de diseño';

  @override
  String get mockStateCalm => 'CALM';

  @override
  String get mockStateWarning => 'WARNING';

  @override
  String get mockHomeCalmMessage =>
      'El aire se ve manejable cerca. Registra el inhalador cuando quieras.';

  @override
  String get mockHomeWarnMessage =>
      'Riesgo elevado cerca. Limita la exposición al exterior y ten el inhalador a mano.';

  @override
  String get mockRiskScore => 'Puntuación de riesgo';

  @override
  String get mockDummyLocation => 'Cerca de Newark, NJ';

  @override
  String get mockEnvDetail => 'Detalle del entorno';

  @override
  String get mockForecast => 'Pronóstico';

  @override
  String get mockForecastHint =>
      'Perspectiva de aire y polen para los próximos días';

  @override
  String get mockAlertPreview => 'Pantalla de alerta';

  @override
  String get mockAlertPreviewHint => 'Vista previa de la alerta de riesgo';

  @override
  String get mockShowWarningHome => 'Vista previa de inicio WARNING';

  @override
  String get mockBackToCalmHome => 'Volver';

  @override
  String get mockPanicCta => 'Modo pánico';

  @override
  String get mockTrapAxis => 'TRAP / hollín';

  @override
  String get mockFloodAxis => 'Inundación súbita';

  @override
  String get mockPollenAxis => 'Polen';

  @override
  String get mockForecastDayHint => 'Perspectiva AQI · TRAP · Polen';

  @override
  String get mockActSurvey => 'Encuesta ACT';

  @override
  String get mockActHint => '5 preguntas con pictogramas (4 semanas)';

  @override
  String get mockPdcCheck => 'Control diario PDC';

  @override
  String get mockPdcHint => 'Adherencia con un toque';

  @override
  String get mockInhalerEvent => 'Inhalador registrado';

  @override
  String get mockActIntro =>
      'Responde según las últimas 4 semanas. Vista previa de diseño: las respuestas no se guardan.';

  @override
  String get mockQuestion => 'Pregunta';

  @override
  String get mockSubmit => 'Enviar';

  @override
  String get mockPdcPrompt => '¿Tomaste hoy tu medicamento de control?';

  @override
  String get mockTakenYes => 'Sí, lo tomé';

  @override
  String get mockTakenNo => 'Hoy no';

  @override
  String get mockEvidenceSummary => 'Tu resumen de evidencia';

  @override
  String get mockEvidenceBody =>
      'Resumen de ejemplo para apoyo PA/LMN. Solo vista previa de diseño.';

  @override
  String get mockInhalerEvents30d => 'Eventos de inhalador (30 d)';

  @override
  String get mockActScore => 'Último ACT';

  @override
  String get mockPdcRate => 'PDC (30 d)';

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
  String get mockRewardTitle => 'Recompensas';

  @override
  String get mockDraftBanner =>
      'BORRADOR — puntos y vales solo en vista previa';

  @override
  String get mockPointsBalance => 'Saldo de puntos';

  @override
  String get mockVoucherTitle => 'Vale de banco de alimentos';

  @override
  String get mockVoucherHint => 'Canjear puntos (lista de espera)';

  @override
  String get mockDonateTitle => 'Donar';

  @override
  String get mockDonateHint => 'Solo donaciones de terceros';

  @override
  String get mockRewardHistory => 'Historial';

  @override
  String get mockRewardHistoryHint => 'Puntos y donaciones';

  @override
  String get mockDummyFoodBank => 'NJ Community Food Bank (demo)';

  @override
  String get mockVoucherCost => '50 puntos · valor de \$10 (borrador)';

  @override
  String get mockJoinWaitlist => 'Unirse a la lista de espera';

  @override
  String get mockDonateTransparency =>
      'Las donaciones pasan por una plataforma sin fines de lucro verificada. Howse Asthma nunca guarda datos de tarjeta.';

  @override
  String get mockDonateCta => 'Abrir donación (externo)';

  @override
  String get mockExternalOnly =>
      'El proveedor de donaciones externo no está conectado en la vista previa.';

  @override
  String get mockSignOutPreview => 'Cerrar sesión (vista previa)';

  @override
  String get mockOpenAuthFlow => 'Abrir flujo de autenticación';

  @override
  String get mockAlertBody =>
      'El riesgo aumentó cerca de tu ubicación. Revisa los detalles del entorno.';

  @override
  String get mockDismiss => 'Descartar';

  @override
  String get mockPanicTitle => '¿Necesitas ayuda ahora?';

  @override
  String get mockPanicStep1Body =>
      'Paso 1 — Quédate con tu inhalador. Continúa para contactos de emergencia.';

  @override
  String get mockPanicStep2Title => 'Pedir ayuda';

  @override
  String get mockPanicStep2Body =>
      'Vista previa de diseño: los botones no hacen una llamada real. En el dispositivo, el paso 2 usa enlaces tel:.';

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
  String get mockTabReward => 'Recompensas';

  @override
  String get mockTabSettings => 'Ajustes';

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
      'Sigue el riesgo de calidad del aire y el uso del inhalador';

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
  String get authNpiHelper =>
      'Identificador nacional de proveedor de 10 dígitos';

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
  String get authBiometricHint => 'Usa biometría para continuar';

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
      'Si tu clínico compartió un código de invitación de 8 caracteres, introdúcelo ahora. También puedes hacerlo luego en Configuración.';

  @override
  String get authOnboardingSkip => 'Omitir por ahora';

  @override
  String get authInviteCodeLabel => 'Código de invitación del profesional';

  @override
  String get authInviteCodeHelper => '8 letras/números, caduca en 24 horas';

  @override
  String get authInviteRedeem => 'Canjear';

  @override
  String get authInviteRedeemAndContinue => 'Canjear y continuar';

  @override
  String get authInviteInvalidFormat =>
      'El código de invitación debe tener 8 letras o números';

  @override
  String get authInviteRedeemedPending =>
      'Invitación canjeada. Esperando confirmación del profesional.';

  @override
  String get authInviteRedeemFailed =>
      'No se pudo canjear el código de invitación';

  @override
  String get authInviteIssueFailed =>
      'No se pudo emitir el código de invitación';

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
      'Los paneles clínicos de pacientes llegarán en una versión posterior. Empieza vinculando pacientes.';

  @override
  String get providerLinkPatientsCta => 'Vincular pacientes';

  @override
  String get providerLinkTitle => 'Vincular pacientes';

  @override
  String get providerLinkIntro =>
      'Emite un código de 8 caracteres (válido 24 horas). El paciente lo introduce y ambos confirman.';

  @override
  String get providerIssueInviteCta => 'Emitir código de invitación';

  @override
  String get providerInviteTtlHint => 'Válido durante 24 horas';

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
      'Tu escudo inteligente contra los desencadenantes';

  @override
  String get splashGetStarted => 'Comenzar';

  @override
  String get splashAlreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get splashSignIn => 'Iniciar sesión';

  @override
  String get authForgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get authNoAccount => '¿No tienes cuenta?';

  @override
  String get authUseBiometricHint => 'Usa Face ID o huella para desbloquear';

  @override
  String get authTouchSensorHint => 'Toca el sensor o mira a la cámara';

  @override
  String get navLog => 'Registro';

  @override
  String get navReport => 'Informe';

  @override
  String get navRewards => 'Recompensas';

  @override
  String get mockChooseLanguage => 'Elegir idioma';

  @override
  String get mockYourLocation => 'Tu ubicación';

  @override
  String get mockUseCurrentLocation => 'Usar ubicación actual';

  @override
  String get mockLocationTrapOnly =>
      'La ubicación se usa solo para datos de calidad del aire TRAP';

  @override
  String get mockLabelYourPlace => 'Etiqueta tu lugar';

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
  String get mockProviderPairing => 'Emparejamiento con profesional';

  @override
  String get mockPairingOptional =>
      'Opcional: puedes agregarlo después en Configuración';

  @override
  String get mockNext => 'Siguiente';

  @override
  String get mockProfessionalProfile => 'Perfil profesional';

  @override
  String get mockStep2Of4 => 'Paso 2 de 4';

  @override
  String get mockTellPractice => 'Cuéntanos sobre tu consultorio médico';

  @override
  String get mockSpecialtyLabel => 'Especialidad';

  @override
  String get mockClinicLabel => 'Nombre del consultorio / clínica';

  @override
  String get mockNpiFormatOnly =>
      'Solo verificación de formato. La verificación NPI ocurre tras el envío.';

  @override
  String get mockCredentialsSecure =>
      'Tus credenciales se cifran y almacenan de forma segura. Nunca compartimos datos del profesional sin consentimiento.';

  @override
  String get oneTapFab => '1-Tap';

  @override
  String get oneTapLoggedSnack => 'Uso de inhalador registrado (stub)';

  @override
  String get oneTapLoggedOk => 'Uso de inhalador registrado';

  @override
  String get oneTapLoggedFailed =>
      'No se pudo registrar el uso del inhalador. Inténtalo de nuevo.';

  @override
  String get homeDailySummary => 'Aquí está tu resumen diario';

  @override
  String get homeWarningBanner =>
      'Riesgo elevado cerca. Limita la exposición al exterior y ten el inhalador a mano.';

  @override
  String get homeEnvFactors => 'Factores ambientales';

  @override
  String get homeViewDetails => 'Ver detalles';

  @override
  String get homeFloodActive => 'Advertencia activa';

  @override
  String get homeFloodNone => 'Ninguna';

  @override
  String get homeLastInhalerNone => 'Aún no hay uso de inhalador registrado';

  @override
  String get homeLastInhalerToday => 'Último uso de inhalador: hoy';

  @override
  String homeLastInhalerDays(int days) {
    return 'Último uso de inhalador: hace $days días';
  }

  @override
  String get locationServiceDisabled =>
      'Activa los servicios de ubicación para ver el riesgo de asma cercano.';

  @override
  String get locationPermissionDenied =>
      'Se necesita permiso de ubicación para la calidad del aire cerca de ti.';

  @override
  String get locationPermissionDeniedForever =>
      'El permiso de ubicación está bloqueado. Abre la configuración para permitirlo.';

  @override
  String get locationUnavailable =>
      'No se pudo obtener tu ubicación. Desliza para actualizar o inténtalo de nuevo.';

  @override
  String get locationOutOfServiceArea =>
      'Howse Asthma actualmente admite ubicaciones en Estados Unidos.';

  @override
  String get locationOpenSettings => 'Abrir configuración';

  @override
  String get locationStatusGranted => 'El acceso a la ubicación está activado';

  @override
  String get njOnlyDataNotice =>
      'Datos solo NJ: la ponderación de AADT de carga pesada aplica solo en Nueva Jersey. TRAP sigue usando sensores de calidad del aire a nivel nacional.';

  @override
  String get homeDegradedNotice =>
      'Algunas fuentes de calidad del aire no están disponibles. El riesgo puede estar incompleto: úsalo con precaución.';

  @override
  String logWeekSummary(int count) {
    return '$count eventos de inhalador en los últimos 7 días';
  }

  @override
  String get logFilterAll => 'Todos';

  @override
  String get logFilterRescue => 'Rescate';

  @override
  String get logFilterPanic => 'Pánico';

  @override
  String get logEmpty =>
      'Aún no hay eventos de inhalador. Usa 1-Tap en Inicio.';

  @override
  String get logEventRescue => 'Uso de inhalador';

  @override
  String get logEventPanic => 'Uso de inhalador en pánico';

  @override
  String get actTitle => 'Control del asma';

  @override
  String get actPast4Weeks => 'En las últimas 4 semanas';

  @override
  String get actQ1 =>
      '¿Cuánto tiempo te impidió el asma hacer tanto como querías en el trabajo, la escuela o en casa?';

  @override
  String get actQ2 => '¿Con qué frecuencia tuviste falta de aire?';

  @override
  String get actQ3 =>
      '¿Con qué frecuencia los síntomas del asma te despertaron por la noche o antes de lo habitual?';

  @override
  String get actQ4 =>
      '¿Con qué frecuencia usaste tu inhalador de rescate o nebulizador?';

  @override
  String get actQ5 => '¿Cómo calificarías el control de tu asma?';

  @override
  String get actOpt1 => 'Todo el tiempo';

  @override
  String get actOpt2 => 'La mayor parte del tiempo';

  @override
  String get actOpt3 => 'Parte del tiempo';

  @override
  String get actOpt4 => 'Poco del tiempo';

  @override
  String get actOpt5 => 'Nunca';

  @override
  String get actQ5Opt1 => 'Sin control en absoluto';

  @override
  String get actQ5Opt2 => 'Mal controlado';

  @override
  String get actQ5Opt3 => 'Algo controlado';

  @override
  String get actQ5Opt4 => 'Bien controlado';

  @override
  String get actQ5Opt5 => 'Completamente controlado';

  @override
  String actSaved(int score) {
    return 'ACT guardado. Puntuación: $score';
  }

  @override
  String get pdcTitle => 'Control diario de medicamento';

  @override
  String get pdcSaved => 'Control diario guardado';

  @override
  String get pdcAlreadyYes =>
      'Ya marcaste hoy como tomado. Puedes actualizarlo.';

  @override
  String get pdcAlreadyNo =>
      'Ya marcaste hoy como no tomado. Puedes actualizarlo.';

  @override
  String pdcStreakHint(int taken, int total, String rate) {
    return 'Últimos 30 días: $taken de $total días tomados ($rate)';
  }

  @override
  String get panicEmergencyBadge => 'EMERGENCIA';

  @override
  String get panicBreatheTitle => 'Respira y usa el inhalador';

  @override
  String get panicTakeInhalerNow => 'Usa el inhalador ahora';

  @override
  String get panicNeedHelp => 'Necesito más ayuda';

  @override
  String get panicNoAutoDial =>
      'Los botones abren el marcador. Las llamadas nunca se hacen automáticamente.';

  @override
  String panicCallNamed(String name) {
    return 'Llamar a $name';
  }

  @override
  String get panicDialFailed =>
      'No se pudo abrir el marcador en este dispositivo.';

  @override
  String get alertTitle => 'Alerta de riesgo';

  @override
  String get alertFcmPendingNote =>
      'Si las notificaciones push están activas en este dispositivo, también recibes una notificación del sistema cuando la app está en segundo plano.';

  @override
  String get reportEvidenceBody =>
      'Resumen del uso del inhalador, ACT y PDC para revisión clínica o del seguro.';

  @override
  String get reportShareTodo =>
      'Compartir / exportar llegará con el flujo PA/LMN del profesional.';

  @override
  String get settingsAlertsTitle => 'Preferencias de alertas';

  @override
  String get settingsAlertRisk => 'Alertas de riesgo';

  @override
  String get settingsAlertRiskHint =>
      'Cuando tu puntuación de riesgo compuesto llega a 3 o más';

  @override
  String get settingsAlertHome => 'Alertas de lugares guardados';

  @override
  String get settingsAlertHomeHint =>
      'Cuando el riesgo sube en lugares que guardaste (casa, escuela, trabajo)';

  @override
  String get settingsAlertLocationEntry => 'Alertas al entrar en una zona';

  @override
  String get settingsAlertLocationEntryHint =>
      'Cuando entras en un área de mayor riesgo mientras la app está abierta';

  @override
  String get settingsSecurityTitle => 'Seguridad';

  @override
  String get emergencyContactRequired =>
      'Introduce un nombre de contacto y un teléfono';

  @override
  String get emergencyContactInvalidPhone =>
      'Introduce un teléfono válido con código de país (E.164), p. ej. +15551234567';

  @override
  String get emergencyContactSaved => 'Contacto de emergencia guardado';

  @override
  String get emergencyContactSave => 'Guardar contacto';

  @override
  String get emergencyContactPhoneHint =>
      'Incluye el código de país (E.164), p. ej. +15551234567';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get envTitle => 'Entorno';

  @override
  String get envThreeAxis => 'Tres ejes de riesgo';

  @override
  String get envTrapDetail =>
      'Indicador de contaminación del aire relacionada con el tráfico (sensores + peso opcional de carga NJ)';

  @override
  String get envTrapTip =>
      'Limita el esfuerzo al aire libre cuando TRAP esté ALTO o CRÍTICO.';

  @override
  String get envFloodDetail =>
      'Advertencias NWS de inundación súbita / caudales cerca de ti';

  @override
  String get envFloodTipClear =>
      'No hay advertencia activa de inundación súbita en esta zona.';

  @override
  String get envPollenDetail => 'Pronóstico de polen de Google';

  @override
  String get envPollenTip =>
      'Mantén las ventanas cerradas y enjuágate tras estar afuera cuando el UPI sea alto.';

  @override
  String envUsgsRate(String rate) {
    return 'Cambio de caudal USGS: $rate ft/h';
  }

  @override
  String envUpdatedAt(String when) {
    return 'Actualizado: $when';
  }

  @override
  String get envSourcesLabel => 'Fuentes de datos';

  @override
  String get envOverallCalm =>
      'Las condiciones se ven manejables. Mantén el inhalador cerca.';

  @override
  String get forecastIntro =>
      'Perspectiva para los próximos periodos con pronósticos de aire y polen.';

  @override
  String get forecastEmpty =>
      'La serie de pronóstico aún no está disponible. Desliza para actualizar.';

  @override
  String get forecastPollenNote =>
      'El polen usa la API Google Pollen (no Open-Meteo). Los mapas de calor no se usan en el MVP.';

  @override
  String forecastDayPollen(int upi, String type) {
    return 'Polen UPI $upi · $type';
  }

  @override
  String forecastDayAqi(int aqi) {
    return 'AQI US máx. $aqi';
  }

  @override
  String get forecastMorning => 'Mañana';

  @override
  String get forecastAfternoon => 'Tarde';

  @override
  String get forecastEvening => 'Noche';

  @override
  String get locationsTitle => 'Mis ubicaciones';

  @override
  String get locationsIntro =>
      'Los lugares guardados se revisan por cambios de riesgo mientras la app está abierta. El push en segundo plano del SO necesita Firebase (próximamente).';

  @override
  String get locationsEmpty =>
      'Aún no hay lugares guardados. Agrega tu ubicación actual.';

  @override
  String get locationsAddTitle => 'Guardar este lugar';

  @override
  String get locationsNameLabel => 'Etiqueta';

  @override
  String get locationsAddCurrent => 'Agregar ubicación actual';

  @override
  String get locationsSaveFailed =>
      'No se pudieron actualizar los lugares guardados. Inténtalo de nuevo.';

  @override
  String get locationsCapReached =>
      'Puedes guardar hasta 10 lugares. Elimina uno para agregar otro.';

  @override
  String get locationsDeleteTitle => '¿Quitar lugar?';

  @override
  String locationsDeleteBody(String name) {
    return '¿Quitar “$name” del monitoreo?';
  }

  @override
  String locationsCoords(String lat, String lon) {
    return '$lat, $lon';
  }

  @override
  String get locationsPrimaryBadge => 'Principal';

  @override
  String get stateOnlyNjApplied => 'Solo NJ: peso AADT de carga aplicado';

  @override
  String get stateOnlyNjNotApplied => 'Solo NJ: peso AADT de carga no aplicado';

  @override
  String get stateOnlyNjAppliedHint =>
      'Los conteos de tráfico NJDOT cercanos aumentaron el peso de TRAP. Los sensores de calidad del aire siguen aplicando a nivel nacional.';

  @override
  String get stateOnlyNjOutsideHint =>
      'Estás fuera de Nueva Jersey. La ponderación AADT de carga es solo NJ; TRAP sigue usando sensores de aire.';

  @override
  String get stateOnlyNjNoCountHint =>
      'No hay conteo de carga NJDOT cercano. TRAP usa sensores de calidad del aire sin el peso de carga NJ.';

  @override
  String get settingsDeveloperSection => 'Desarrollador';

  @override
  String get settingsApiConsole => 'Consola API';

  @override
  String get debugApiConsoleBanner =>
      'DEBUG — no capturar pantalla para compartir en público';

  @override
  String get appTagline => 'Tu escudo inteligente contra los desencadenantes';

  @override
  String get welcomeBenefit1 =>
      'Alertas proactivas de calidad del aire y polen';

  @override
  String get welcomeBenefit2 =>
      'Check-in diario de 3 segundos para tu respiracion';

  @override
  String get welcomeBenefit3 => 'Informes de datos confiables para tu clinico';

  @override
  String get welcomeContinueEmail => 'o continuar con correo';

  @override
  String get welcomeTermsAgree =>
      'Acepto los Terminos y la Politica de privacidad';

  @override
  String get welcomeTermsPending =>
      'Los enlaces legales estaran disponibles cuando se publiquen.';

  @override
  String get welcomeClinicianLink => 'Soy profesional de la salud';

  @override
  String get checkInWelcomeHome => 'Bienvenido a casa!';

  @override
  String get checkInQuestion => 'Como esta tu respiracion ahora?';

  @override
  String get checkInBreathUsual => 'Como de costumbre';

  @override
  String get checkInBreathTight => 'Un poco apretada';

  @override
  String get checkInBreathSymptoms => 'Tengo sintomas';

  @override
  String get checkInAeroPoints => 'Primer check-in listo! +5 AeroPoints';

  @override
  String get shieldLocationTitle => 'Activa tu escudo preventivo';

  @override
  String get shieldLocationBody =>
      'Activa el escudo a tu alrededor: necesitamos la ubicacion para aire y polen cercanos.';

  @override
  String get shieldLocationAllow => 'Permitir ubicacion';

  @override
  String get shieldLocationNotNow => 'Ahora no';
}
