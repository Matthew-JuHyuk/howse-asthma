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
}
