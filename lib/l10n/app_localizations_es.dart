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

  @override
  String get settingsPushMaster => 'Notificaciones push';

  @override
  String get settingsPushMasterHint =>
      'Interruptor general de alertas de Howse Asthma en este dispositivo';

  @override
  String get pushConsentTitle => 'Anticipe los desencadenantes del asma';

  @override
  String get pushConsentBody =>
      'Podemos enviar alertas simples cuando suba el riesgo de aire o inundacion, y mas adelante consejos para ventilar. Puede cambiarlo en Ajustes.';

  @override
  String get pushConsentAllow => 'Permitir notificaciones';

  @override
  String get pushConsentNotNow => 'Ahora no';

  @override
  String homeNearPlace(String place) {
    return 'Cerca de $place';
  }

  @override
  String get homeStaleLocationNotice =>
      'Mostramos su ultima lectura mientras esperamos la ubicacion.';

  @override
  String get homeStaleRefreshNotice =>
      'Mostramos su ultima lectura. Deslice para actualizar cuando haya conexion.';

  @override
  String get homeStaleCacheNotice =>
      'Esta lectura puede estar un poco atrasada. Use con cuidado.';

  @override
  String get homeNowDoThisHeading =>
      'Haga esto ahora para bajar el riesgo de un ataque';

  @override
  String get homeDraftBadge => 'Borrador';

  @override
  String get homeNowDoThisFloodTitle => 'Quedese adentro si puede';

  @override
  String get homeNowDoThisFloodBody =>
      'Las alertas de inundacion suelen indicar humedad. Tenga el inhalador cerca y evite zonas inundadas.';

  @override
  String get homeNowDoThisTrapTitle => 'Reduzca la actividad al aire libre';

  @override
  String get homeNowDoThisTrapBody =>
      'La contaminacion del trafico cerca parece alta. Salga poco si es necesario.';

  @override
  String get homeNowDoThisPollenTitle =>
      'Mantenga las ventanas cerradas por ahora';

  @override
  String get homeNowDoThisPollenBody =>
      'El polen esta alto. Enjuaguese la cara y cambiese tras estar afuera.';

  @override
  String get homeNowDoThisRiskTitle => 'Vaya con calma al aire libre';

  @override
  String get homeNowDoThisRiskBody =>
      'El riesgo general esta elevado. Lleve el inhalador y descanse si le cuesta respirar.';

  @override
  String get homeNowDoThisCalmTitle => 'Momento mas calmo para airear';

  @override
  String get homeNowDoThisCalmBody =>
      'El aire exterior se ve manejable. Una ventilacion corta puede ayudar — mantenga el inhalador cerca.';

  @override
  String get homeAdherenceSection => 'Su semana de inhalador';

  @override
  String get adherenceWeekHint =>
      'Los dias marcados tienen usos registrados (1-Tap).';

  @override
  String get homeMoldAxis => 'Riesgo de moho';

  @override
  String get homeMoldElevatedDraft => 'Senal de humedad alta';

  @override
  String get homeMoldPendingDraft => 'Humedad pendiente';

  @override
  String get homeFloodAsMoldFactor => 'Factor inundacion / humedad';

  @override
  String get homeForecastLink => 'Pronostico corto';

  @override
  String homeForecastHint(String date, String score) {
    return 'Manana $date · puntuacion $score';
  }

  @override
  String homeSensorDistance(
    String km,
    String mi,
    String radiusKm,
    String radiusMi,
  ) {
    return 'Sensor mas cercano $km km ($mi mi) · busqueda ~$radiusKm km ($radiusMi mi)';
  }

  @override
  String homeSensorNearestOnly(String km, String mi) {
    return 'Sensor mas cercano $km km ($mi mi)';
  }

  @override
  String homeSensorRadiusOnly(String km, String mi) {
    return 'Busqueda de sensores ~$km km ($mi mi)';
  }

  @override
  String get weekdayMonShort => 'L';

  @override
  String get weekdayTueShort => 'M';

  @override
  String get weekdayWedShort => 'X';

  @override
  String get weekdayThuShort => 'J';

  @override
  String get weekdayFriShort => 'V';

  @override
  String get weekdaySatShort => 'S';

  @override
  String get weekdaySunShort => 'D';

  @override
  String get logAdherenceCalendarTitle => 'Calendario de cumplimiento';

  @override
  String get homeNowDoThisMoldTitle => 'Reduzca la humedad interior';

  @override
  String get homeNowDoThisMoldBody =>
      'La humedad exterior parece alta. Use ventilador o deshumidificador si puede, y evite sotanos humedos.';

  @override
  String get homeMoldDetail =>
      'Condiciones de humedad cerca (estimacion exterior — no es conteo de esporas)';

  @override
  String get homeMoldTip =>
      'Riesgo alto de moho: mantenga las habitaciones mas secas. Las inundaciones aumentan el riesgo.';

  @override
  String homeMoldRh(String pct) {
    return 'Humedad $pct%';
  }

  @override
  String homeMoldTempF(String temp) {
    return '$temp°F';
  }

  @override
  String homeMoldDewF(String temp) {
    return 'Rocio $temp°F';
  }

  @override
  String homeMoldWetHours(int hours) {
    return '$hours horas humedas (24h)';
  }

  @override
  String get homeMoldProxyDisclaimer => 'Solo estimacion exterior';

  @override
  String get homeVentilationSnack =>
      'El aire exterior se ve mas calmo — una ventilacion corta puede ayudar.';

  @override
  String get settingsAlertPositive => 'Consejos de aire fresco';

  @override
  String get settingsAlertPositiveHint =>
      'Cuando el aire exterior parece mas seguro para abrir un poco (reglas borrador)';

  @override
  String get settingsBgTitle => 'Actualizacion en segundo plano';

  @override
  String get settingsBgBody =>
      'Howse Asthma actualiza el aire cercano mientras usa la app. No pedimos ubicacion Siempre en esta version.';

  @override
  String get settingsBgRefresh => 'Actualizar al usar la app';

  @override
  String get settingsBgRefreshHint =>
      'Actualizar el riesgo al moverse o mantener la app abierta';

  @override
  String get s5AboutApp => 'Acerca de Howse Asthma';

  @override
  String get s5AboutAppBody =>
      'Howse Asthma le ayuda a registrar síntomas y el uso del inhalador, y a preparar un resumen para su equipo médico. No diagnostica ni recomienda tratamientos.';

  @override
  String get s5ActNotice =>
      'Sus respuestas se guardan para compartirlas con su equipo médico. La app no muestra una puntuación porque este cuestionario no está validado con una escala oficial.';

  @override
  String get s5ActSaved => 'Respuestas guardadas.';

  @override
  String get s5ActSubtitle => '5 preguntas sobre las últimas 4 semanas';

  @override
  String get s5ActTitle => 'Cuestionario de control del asma';

  @override
  String get s5AddDetails => 'Agregar detalles';

  @override
  String get s5AddRecord => 'Agregar registro';

  @override
  String get s5AlertArrive => 'Al llegar a un lugar nuevo';

  @override
  String get s5AlertArriveHint =>
      'Cuando el entorno del lugar al que llega está peor. Solo funciona mientras usa la app.';

  @override
  String get s5AlertFreshAirHint =>
      'Cuando la calidad del aire, el polen y las inundaciones parecen tranquilos afuera. Es información general, no consejo médico.';

  @override
  String get s5AlertSavedPlaces => 'Lugares guardados';

  @override
  String get s5AlertSavedPlacesHint =>
      'Cuando el entorno de un lugar guardado empeora.';

  @override
  String get s5AlertWorse => 'Cuando el entorno empeora';

  @override
  String get s5AlertWorseHint =>
      'Cuando la calidad del aire, el polen o las inundaciones cercanas empeoran. La misma alerta no se repite dentro de 1 hora.';

  @override
  String get s5AqiGood => 'Buena';

  @override
  String get s5AqiModerate => 'Moderada';

  @override
  String get s5AqiUsg => 'Dañina para grupos sensibles';

  @override
  String get s5AqiUnhealthy => 'Dañina';

  @override
  String get s5AqiVeryUnhealthy => 'Muy dañina';

  @override
  String get s5AqiHazardous => 'Peligrosa';

  @override
  String s5AqiValue(String category, int aqi) {
    return '$category (AQI $aqi)';
  }

  @override
  String get s5Back => 'Atrás';

  @override
  String get s5BarrierCost => 'Costo de los medicamentos';

  @override
  String get s5BarrierHardToGet => 'Difícil conseguir los medicamentos';

  @override
  String get s5BarrierHardToUnderstand => 'Difícil entender las instrucciones';

  @override
  String get s5BarrierHowToUse => 'Cómo usar los medicamentos';

  @override
  String get s5BarrierNone => 'Ninguna dificultad';

  @override
  String get s5BarrierOtherHint => 'Escriba otra (opcional)';

  @override
  String get s5Cancel => 'Cancelar';

  @override
  String get s5Change => 'Cambiar';

  @override
  String get s5ChoosePlace => 'Elegir zona';

  @override
  String get s5Close => 'Cerrar';

  @override
  String get s5DataSourcesTitle => 'Fuentes de datos';

  @override
  String get s5DataSourcesBody =>
      'Calidad del aire: EPA AirNow de EE. UU., Open-Meteo y sensores PurpleAir cercanos.\nPolen: Google Pollen API (Universal Pollen Index).\nClima y humedad: Open-Meteo.\nAlertas de inundación: Servicio Meteorológico Nacional (NWS). Nivel de ríos: Servicio Geológico de EE. UU. (USGS).\nTráfico (solo Nueva Jersey): Departamento de Transporte de Nueva Jersey (NJDOT).\nLos valores pueden llegar tarde o faltar. Describen el entorno exterior, no su salud.';

  @override
  String get s5Delete => 'Eliminar';

  @override
  String get s5DeleteConfirm => '¿Eliminar este registro?';

  @override
  String get s5DeleteFailed => 'No se pudo eliminar. Inténtelo de nuevo.';

  @override
  String get s5Edit => 'Editar';

  @override
  String get s5EnglishVersion => 'Inglés (para su equipo médico)';

  @override
  String get s5EntryRemoved => 'Registro deshecho.';

  @override
  String get s5EnvAirDetail =>
      'Índice de calidad del aire de la EPA de EE. UU., de estaciones públicas y sensores cercanos. Describe el aire exterior de la zona; no mide solo el humo del tráfico.';

  @override
  String get s5EnvAirQuality => 'Calidad del aire';

  @override
  String get s5EnvAlertsHeading => 'Alertas del entorno';

  @override
  String get s5EnvCardTitle => 'Su entorno hoy';

  @override
  String get s5EnvFlood => 'Alertas de inundación';

  @override
  String get s5EnvFloodDetail =>
      'Avisos públicos del Servicio Meteorológico Nacional (NWS).';

  @override
  String get s5EnvForecast => 'Pronóstico del entorno';

  @override
  String get s5EnvHumidity => 'Humedad';

  @override
  String get s5EnvHumidityDetail =>
      'Dato meteorológico exterior; no mide la humedad interior ni el moho.';

  @override
  String get s5EnvLoadFailed => 'No se pudo cargar la información del entorno.';

  @override
  String get s5EnvNeedPlace => 'Elija una zona para ver su entorno.';

  @override
  String get s5EnvNotAvailable => 'No disponible';

  @override
  String get s5EnvOlderNotice => 'Mostrando la última información verificada.';

  @override
  String get s5EnvPollen => 'Índice de polen';

  @override
  String get s5EnvPollenDetail =>
      'Universal Pollen Index de Google, de 0 (ninguno) a 5 (muy alto). Un número bajo no significa que sea seguro para todos.';

  @override
  String get s5EnvSeeDetails => 'Ver detalles del entorno';

  @override
  String get s5EnvUnavailable =>
      'La información del entorno no está disponible ahora.';

  @override
  String get s5FewRecordsNotice =>
      'Hay pocos registros, así que el resumen puede tener partes vacías.';

  @override
  String get s5FgRefreshTitle => 'Actualizar el entorno mientras usa la app';

  @override
  String get s5FgRefreshHint =>
      'Revisa su entorno mientras la app está abierta. No funciona en segundo plano.';

  @override
  String get s5FieldDate => 'Fecha';

  @override
  String get s5FieldMedication => 'Medicamento';

  @override
  String get s5FieldNote => 'Nota (opcional)';

  @override
  String get s5FieldPuffs => 'Inhalaciones (opcional)';

  @override
  String get s5FieldReason => 'Motivo (opcional)';

  @override
  String get s5FieldTime => 'Hora';

  @override
  String get s5FilterAll => 'Todo';

  @override
  String get s5FilterInhaler => 'Inhalador';

  @override
  String get s5FilterMedCheck => 'Uso de medicamentos';

  @override
  String get s5FilterSymptoms => 'Síntomas';

  @override
  String get s5FloodIssued => 'Aviso de inundación emitido';

  @override
  String get s5FloodNone => 'Sin avisos de inundación';

  @override
  String get s5FloodUnknown => 'Avisos no disponibles';

  @override
  String s5ForecastCheckedAt(String time) {
    return 'Verificado $time';
  }

  @override
  String s5ForecastValidFor(String date) {
    return 'Pronóstico para $date';
  }

  @override
  String get s5FromUrgentHelp => 'Registrado desde Ayuda urgente';

  @override
  String get s5HomeStateEmpty =>
      'Haga su primer registro. Le ayudará a preparar lo que quiere contar en su consulta.';

  @override
  String s5HomeStateQuestions(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Tiene $n preguntas para su médico.',
      one: 'Tiene 1 pregunta para su médico.',
    );
    return '$_temp0';
  }

  @override
  String s5HomeStateRecords(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Días con registros en los últimos 7: $n',
      one: 'Días con registros en los últimos 7: 1',
    );
    return '$_temp0';
  }

  @override
  String get s5HomeSubtitle =>
      'Reúna sus registros para compartirlos en su consulta.';

  @override
  String get s5HomeTitle => 'Registre cómo se siente hoy';

  @override
  String s5HumidityValue(int rh) {
    return 'Humedad exterior $rh%';
  }

  @override
  String get s5IncludeEnvironment => 'Entorno (opcional)';

  @override
  String get s5IncludeEnvironmentHint =>
      'Agrega la calidad del aire, el polen y las alertas de inundación de hoy. No incluye su ubicación exacta.';

  @override
  String get s5InhalerEditTitle => 'Detalles del uso del inhalador';

  @override
  String get s5InhalerEntry => 'Uso del inhalador';

  @override
  String get s5InhalerLogged => 'Uso del inhalador registrado.';

  @override
  String get s5InhalerOneEntryHint =>
      'Cada vez que guarda es 1 registro de uso. No se cuenta como 1 inhalación ni como 1 día.';

  @override
  String s5InhalerUnknownCount(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Medicamento no identificado: $n',
      one: 'Medicamento no identificado: 1',
    );
    return '$_temp0';
  }

  @override
  String get s5InsCost => 'Dificultades de costo';

  @override
  String get s5InsDenial => 'Motivo de rechazo (si se lo dijeron)';

  @override
  String get s5InsMedHistory => 'Medicamentos que ha probado';

  @override
  String get s5InsuranceIntro =>
      'Organiza información para que su equipo médico complete formularios.';

  @override
  String get s5InsuranceLimits =>
      'Todo es opcional. Esta app no envía nada a su seguro ni decide aprobaciones.';

  @override
  String get s5InsuranceTitle => 'Preparación de formularios del seguro';

  @override
  String s5LanguageName(String lang) {
    String _temp0 = intl.Intl.selectLogic(lang, {
      'en': 'inglés',
      'es': 'español',
      'fr': 'francés',
      'ko': 'coreano',
      'ja': 'japonés',
      'zh': 'chino',
      'other': 'otro idioma',
    });
    return '$_temp0';
  }

  @override
  String get s5Last30Days => 'Últimos 30 días';

  @override
  String get s5Last7Days => 'Últimos 7 días';

  @override
  String get s5LogInhaler => 'Registrar inhalador';

  @override
  String get s5LogLegend =>
      'Cada fila es 1 registro guardado. Los días sin registro dicen «Sin registro», que no es lo mismo que cero.';

  @override
  String get s5LogSymptoms => 'Registrar síntomas';

  @override
  String get s5MedAdd => 'Agregar medicamento';

  @override
  String s5MedCheckCounts(int a, int b, int c, int d) {
    return 'Lo usé $a · No lo usé $b · No recuerdo $c · Sin registro $d (días)';
  }

  @override
  String get s5MedCheckIntro =>
      'Usted mismo indica si usó su medicamento. No se basa en datos de farmacia.';

  @override
  String get s5MedCheckQuestion => '¿Usó su medicamento como estaba planeado?';

  @override
  String get s5MedCheckTitle => 'Uso de medicamentos de hoy';

  @override
  String get s5MedChooseHint => 'Elija un medicamento o «No sé el nombre».';

  @override
  String get s5MedDailyCheck => 'Revisión diaria';

  @override
  String get s5MedDailyCheckHint =>
      'Muestra «Uso de medicamentos de hoy» en Inicio. Actívelo solo si su equipo médico le indicó usarlo a diario.';

  @override
  String get s5MedDefault => 'Predeterminado para registro rápido';

  @override
  String get s5MedDefaultHint =>
      'Se usa cuando toca «Registrar inhalador» en Inicio.';

  @override
  String get s5MedEdit => 'Editar medicamento';

  @override
  String get s5MedNameLabel => 'Nombre del medicamento (como en la etiqueta)';

  @override
  String get s5MedNotApplicable => 'Hoy no tenía que usarlo';

  @override
  String s5MedNotApplicableDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'No aplica: $n días',
      one: 'No aplica: 1 día',
    );
    return '$_temp0';
  }

  @override
  String get s5MedNotRecorded => 'Medicamento no registrado';

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
  String get s5MedReasonNoMedicine => 'No tenía el medicamento';

  @override
  String get s5MedReasonQuestion => 'Motivo (opcional)';

  @override
  String get s5MedUnknown => 'No sé el nombre';

  @override
  String get s5MedUnknownShort => 'Medicamento no identificado';

  @override
  String get s5MedUsed => 'Lo usé';

  @override
  String get s5MyLanguage => 'Mi idioma';

  @override
  String get s5MyLogTitle => 'Mis registros';

  @override
  String get s5MyMedsEmpty => 'Todavía no ha guardado medicamentos.';

  @override
  String get s5MyMedsHint =>
      'Use los nombres que usted confirmó para registrar más rápido. No es una recomendación de dosis.';

  @override
  String get s5MyMedsOpen => 'Administrar mis medicamentos';

  @override
  String get s5MyMedsTitle => 'Mis medicamentos';

  @override
  String get s5NavEnvironment => 'Entorno';

  @override
  String get s5NavLog => 'Registros';

  @override
  String get s5NavVisitPrep => 'Consulta';

  @override
  String get s5NoAnswer => 'Prefiero no responder';

  @override
  String get s5NoRecordsYet => 'Todavía no hay registros';

  @override
  String s5NoSymptomDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Días registrados como «sin síntomas»: $n',
      one: 'Días registrados como «sin síntomas»: 1',
    );
    return '$_temp0';
  }

  @override
  String get s5NotRecorded => 'Sin registro';

  @override
  String get s5NotRecordedToday => 'Sin registro hoy';

  @override
  String s5NotTranslatedLine(String language, String text) {
    return '[No traducido · original en $language] $text';
  }

  @override
  String get s5OsNotificationsOff =>
      'Las notificaciones de Howse Asthma están desactivadas en los ajustes del teléfono, así que no aparecerán alertas.';

  @override
  String get s5PdfAboutMedCheck =>
      'El uso de medicamentos es informado por el paciente. No son datos de farmacia ni PDC (proporción de días cubiertos).';

  @override
  String get s5PdfAboutNoScore =>
      'No incluye puntuaciones de cuestionarios ni puntuaciones de riesgo de la app.';

  @override
  String get s5PdfAboutPatientReported =>
      'Todos los registros los ingresó el paciente en la app Howse Asthma y no están verificados.';

  @override
  String get s5PdfAppendix => 'Anexo: notas del paciente';

  @override
  String s5PdfDaysNotRecorded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Días sin registro de síntomas: $n',
      one: 'Días sin registro de síntomas: 1',
    );
    return '$_temp0';
  }

  @override
  String get s5PdfDisclaimer =>
      'Este resumen contiene información informada por el paciente para revisión del equipo médico. No es un diagnóstico ni una decisión de autorización previa.';

  @override
  String get s5PdfEnvNote =>
      'Entorno exterior general cuando se creó el resumen. No incluye la ubicación.';

  @override
  String get s5PdfFailed =>
      'No se pudo crear el PDF. Sus datos se conservaron. Inténtelo de nuevo.';

  @override
  String get s5PdfFontFailed =>
      'No se pudieron preparar las fuentes del PDF. Revise su conexión a internet e inténtelo de nuevo.';

  @override
  String s5PdfGeneratedAt(String time) {
    return 'Creado $time';
  }

  @override
  String s5PdfInhalerByMed(String name, int n) {
    return '$name: $n';
  }

  @override
  String s5PdfInhalerMedNotRecorded(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Medicamento no registrado: $n',
      one: 'Medicamento no registrado: 1',
    );
    return '$_temp0';
  }

  @override
  String s5PdfInhalerUnknown(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'El paciente no sabía el medicamento: $n',
      one: 'El paciente no sabía el medicamento: 1',
    );
    return '$_temp0';
  }

  @override
  String s5PdfInhalerUses(int n, int days) {
    return 'Registros de uso del inhalador: $n (en $days días)';
  }

  @override
  String get s5PdfIsEnglish =>
      'El PDF se crea en inglés. El texto que usted escribió se incluye tal como está.';

  @override
  String get s5PdfMedNamesAsEntered =>
      'Los nombres de medicamentos se muestran como los escribió el paciente.';

  @override
  String get s5PdfNotRecorded => 'Sin registro';

  @override
  String s5PdfNotUsedReason(String label, int n) {
    return 'Motivo por el que no lo usó (informado) — $label: $n';
  }

  @override
  String get s5PdfOutdated =>
      'Sus registros o respuestas cambiaron desde el último PDF. Cree un PDF nuevo para incluir los cambios.';

  @override
  String s5PdfPeriod(String start, String end, int days) {
    return 'Período: $start – $end ($days días)';
  }

  @override
  String s5PdfReasonCount(String label, int n) {
    return 'Motivo — $label: $n';
  }

  @override
  String s5PdfRecordedDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Días con registros del paciente: $n',
      one: 'Días con registros del paciente: 1',
    );
    return '$_temp0';
  }

  @override
  String get s5PdfSectionAboutData => 'Sobre estos datos';

  @override
  String get s5PdfSectionBarriers =>
      'Dificultades para recibir atención (informadas)';

  @override
  String get s5PdfSectionEnvironment => 'Entorno (referencia)';

  @override
  String get s5PdfSectionInhaler => 'Uso del inhalador';

  @override
  String get s5PdfSectionInsurance => 'Notas para formularios (del paciente)';

  @override
  String get s5PdfSectionMedChecks =>
      'Uso de medicamentos informado por el paciente';

  @override
  String get s5PdfSectionQuestions => 'Preguntas del paciente';

  @override
  String get s5PdfSectionSymptoms => 'Síntomas';

  @override
  String s5PdfSymptomCodeDays(String label, int n) {
    return '$label: $n';
  }

  @override
  String s5PdfSymptomDays(int n, int days) {
    return 'Días con síntomas: $n de $days';
  }

  @override
  String s5PdfSymptomOtherDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Días con otros síntomas escritos por el paciente: $n',
      one: 'Días con otros síntomas escritos por el paciente: 1',
    );
    return '$_temp0';
  }

  @override
  String get s5PdfTitle => 'Resumen de asma informado por el paciente';

  @override
  String s5PeriodAndRecordedDays(int days, int n) {
    return '$days días · días con registros: $n';
  }

  @override
  String get s5PhoneHint =>
      'Incluya el código de país, por ejemplo +1 201 555 0123';

  @override
  String get s5PhoneInvalid =>
      'Escriba un nombre y un número con código de país, por ejemplo +1 201 555 0123';

  @override
  String get s5PollenGrass => 'Pasto';

  @override
  String s5PollenMainType(String type) {
    return 'Tipo principal: $type';
  }

  @override
  String get s5PollenTree => 'Árboles';

  @override
  String get s5PollenWeed => 'Malezas';

  @override
  String get s5PrepareVisit => 'Preparar mi consulta';

  @override
  String get s5PreviewEditHint =>
      'Puede cambiar preguntas y notas en la pantalla anterior. Para corregir números, edite el registro original en Mis registros.';

  @override
  String get s5PreviewSummary => 'Ver resumen de la consulta';

  @override
  String get s5PreviewTitle => 'Vista previa del resumen';

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
    return 'Pregunta $n';
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
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n registros de inhalador',
      one: '1 registro de inhalador',
    );
    return '$_temp0';
  }

  @override
  String s5RecentSymptomDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: '$n días con síntomas',
      one: '1 día con síntomas',
    );
    return '$_temp0';
  }

  @override
  String get s5RecentTitle => 'Últimos 7 días';

  @override
  String get s5RecordsLoadFailed =>
      'No se pudieron cargar los registros. Inténtelo de nuevo.';

  @override
  String get s5RecordsManageHint =>
      'Puede editar o eliminar registros en Mis registros. Siempre se pide confirmación antes de eliminar.';

  @override
  String get s5Refresh => 'Actualizar';

  @override
  String get s5Reload => 'Volver a cargar';

  @override
  String get s5Save => 'Guardar';

  @override
  String get s5Saved => 'Registro guardado.';

  @override
  String get s5SavedPlacesHint =>
      'Lugares guardados como casa, escuela o trabajo';

  @override
  String get s5SaveFailed => 'No se pudo guardar. Sus datos se conservaron.';

  @override
  String get s5SavePdf => 'Guardar PDF';

  @override
  String get s5SettingsAlerts => 'Alertas';

  @override
  String get s5SettingsArea => 'Zona';

  @override
  String get s5SettingsHelp => 'Ayuda';

  @override
  String get s5SettingsLanguageNote =>
      'El resumen de la consulta se crea en inglés. Puede compararlo con su idioma antes de compartirlo.';

  @override
  String get s5SettingsSecurityData => 'Seguridad y datos';

  @override
  String get s5Share => 'Compartir';

  @override
  String get s5SourcesAir =>
      'Calidad del aire: EPA AirNow, Open-Meteo, PurpleAir';

  @override
  String get s5SourcesFlood =>
      'Alertas de inundación: Servicio Meteorológico Nacional';

  @override
  String get s5SourcesNjTraffic =>
      'Los datos de tráfico solo se usan en Nueva Jersey.';

  @override
  String get s5SourcesNoRiskScore =>
      'La puntuación interna de la app no es un riesgo de crisis de asma y no se muestra.';

  @override
  String get s5SourcesPollen => 'Polen: Google Pollen API';

  @override
  String get s5SourcesTitle => 'Fuentes y límites';

  @override
  String get s5SourcesWeather => 'Clima y humedad: Open-Meteo';

  @override
  String get s5StatusLatest => 'Actual';

  @override
  String get s5StatusOlder => 'Datos anteriores';

  @override
  String get s5StatusUnavailable => 'No disponible ahora';

  @override
  String get s5SymActivityLimited => 'Limitó mis actividades';

  @override
  String get s5SymCough => 'Tos';

  @override
  String get s5SymNightWaking => 'Me desperté de noche';

  @override
  String get s5SymNone => 'Sin síntomas';

  @override
  String get s5SymOther => 'Escribir otro';

  @override
  String get s5SymOtherHint => 'Descríbalo con sus palabras';

  @override
  String get s5SymShortBreath => 'Dificultad para respirar';

  @override
  String get s5SymWheeze => 'Silbido al respirar';

  @override
  String get s5SymptomEditTitle => 'Editar síntomas';

  @override
  String get s5SymptomEntry => 'Síntomas';

  @override
  String get s5SymptomNoneHint =>
      'Los días que no registra aparecen como «Sin registro», no como «Sin síntomas».';

  @override
  String get s5SymptomQuestion => '¿Qué síntomas tuvo?';

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
          '$n elementos no se pudieron traducir. Aparecen en el PDF en inglés con su texto original y la marca «Not translated». Revíselos.',
      one:
          '1 elemento no se pudo traducir. Aparece en el PDF en inglés con su texto original y la marca «Not translated». Revíselo.',
    );
    return '$_temp0';
  }

  @override
  String s5UpdatedAt(String time) {
    return 'Actualizado $time';
  }

  @override
  String get s5UpiHigh => 'Alto';

  @override
  String get s5UpiLow => 'Bajo';

  @override
  String get s5UpiModerate => 'Moderado';

  @override
  String get s5UpiNone => 'Ninguno';

  @override
  String s5UpiValue(int upi, String category) {
    return '$upi de 5 · $category';
  }

  @override
  String get s5UpiVeryHigh => 'Muy alto';

  @override
  String get s5UpiVeryLow => 'Muy bajo';

  @override
  String get s5UrgentActionPlan =>
      'Si tiene un plan de acción para el asma de su equipo médico, sígalo.';

  @override
  String get s5UrgentCall911Locked => 'Ayuda urgente: llamar al 911';

  @override
  String get s5UrgentHelp => 'Ayuda urgente';

  @override
  String get s5UrgentIntro =>
      'Si le cuesta mucho respirar o no mejora, llame al 911.';

  @override
  String get s5UrgentLogHint =>
      'Opcional: puede registrar que usó su inhalador.';

  @override
  String get s5UrgentNoContact =>
      'Todavía no tiene un contacto de emergencia. Agréguelo en Ajustes → Ayuda.';

  @override
  String s5UsingMedication(String name) {
    return 'Se registrará: $name';
  }

  @override
  String get s5ViewMyLog => 'Ver mis registros';

  @override
  String get s5VisitBarriers =>
      '¿Tuvo dificultades para recibir su tratamiento?';

  @override
  String s5VisitCardDetail(int days, int recorded, int questions) {
    return 'Últimos $days días · días con registros: $recorded · preguntas: $questions';
  }

  @override
  String get s5VisitCardTitle => 'Para su próxima consulta';

  @override
  String get s5VisitInclude => 'Qué incluir';

  @override
  String get s5VisitIntro =>
      'Organice sus síntomas y preguntas para mostrárselos a su equipo médico.';

  @override
  String get s5VisitPeriod => 'Período del resumen';

  @override
  String get s5VisitPrepTitle => 'Preparar la consulta';

  @override
  String get s5VisitQuestions => 'Preguntas para su médico';

  @override
  String get s5VisitQuestionsHint =>
      'Escriba en su idioma. Puede dejarlo en blanco.';
}
