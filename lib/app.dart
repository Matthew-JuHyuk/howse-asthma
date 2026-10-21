import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/config/app_config.dart';
import 'core/locale/locale_controller.dart';
import 'core/session/session_controller.dart';
import 'core/theme/app_theme.dart';
import 'features/covernote/covernote_root.dart';
import 'features/covernote/data/case_store.dart';
import 'features/covernote/data/demo_case_store.dart';
import 'features/covernote/data/supabase_case_store.dart';
import 'features/design_preview/patient_mock_shell.dart';
import 'l10n/app_localizations.dart';

class CoverNoteApp extends StatefulWidget {
  const CoverNoteApp({super.key, this.session, this.live, this.demo});

  /// Injected in tests; the app creates its own otherwise.
  final SessionController? session;
  final CaseStore? live;
  final DemoCaseStore? demo;

  @override
  State<CoverNoteApp> createState() => _CoverNoteAppState();
}

class _CoverNoteAppState extends State<CoverNoteApp> {
  final _localeController = LocaleController();
  late final SessionController _session =
      widget.session ?? (SessionController()..start());
  late final CaseStore _live = widget.live ?? SupabaseCaseStore();
  late final DemoCaseStore _demo = widget.demo ?? DemoCaseStore();

  @override
  void initState() {
    super.initState();
    _localeController.load();
  }

  @override
  void dispose() {
    if (widget.session == null) _session.dispose();
    _localeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLocaleScope(
      controller: _localeController,
      child: SessionScope(
        controller: _session,
        child: CoverNoteServices(
          live: _live,
          demo: _demo,
          child: ValueListenableBuilder<Locale>(
            valueListenable: _localeController,
            builder: (context, locale, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) =>
                    AppLocalizations.of(context)!.appTitle,
                theme: AppTheme.light,
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
                    : const CoverNoteRoot(),
              );
            },
          ),
        ),
      ),
    );
  }
}
