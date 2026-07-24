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
}
