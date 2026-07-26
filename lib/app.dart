import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/config/app_config.dart';
import 'core/locale/locale_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/auth_gate.dart';
import 'features/design_preview/patient_mock_shell.dart';
import 'features/home/presentation/home_shell.dart'; // AppLocaleScope
import 'l10n/app_localizations.dart';

class HowseAsthmaApp extends StatefulWidget {
  const HowseAsthmaApp({super.key});

  @override
  State<HowseAsthmaApp> createState() => _HowseAsthmaAppState();
}

class _HowseAsthmaAppState extends State<HowseAsthmaApp> {
  final _localeController = LocaleController();

  @override
  void initState() {
    super.initState();
    _localeController.load();
  }

  @override
  void dispose() {
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLocaleScope(
      controller: _localeController,
      child: ValueListenableBuilder<Locale>(
        valueListenable: _localeController,
        builder: (context, locale, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            locale: locale,
            supportedLocales: supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: AppConfig.designPreview
                ? const PatientMockShell()
                : const AuthGate(),
          );
        },
      ),
    );
  }
}
