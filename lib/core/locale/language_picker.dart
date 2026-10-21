import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'locale_controller.dart';

/// Opens the language list. Reachable from sign-in, Home and Account, so a
/// person can change language before reading anything else.
Future<void> showLanguagePicker(BuildContext context) {
  final controller = AppLocaleScope.of(context);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) => _LanguageSheet(controller: controller),
  );
}

/// Globe button labelled with the current language in its own script.
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final current = Localizations.localeOf(context);
    return Tooltip(
      message: l.cnLanguageButtonTooltip,
      child: TextButton.icon(
        onPressed: () => showLanguagePicker(context),
        icon: const Icon(Icons.language),
        label: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 120),
          child: Text(
            nativeNameOf(current),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        style: TextButton.styleFrom(minimumSize: const Size(48, 48)),
      ),
    );
  }
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet({required this.controller});

  final LocaleController controller;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return SafeArea(
      child: ValueListenableBuilder<Locale>(
        valueListenable: controller,
        builder: (context, current, _) {
          final selected = appLanguageForLocale(current);
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              Semantics(
                header: true,
                child: Text(
                  l.cnLanguageChoose,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 8),
              for (final language in appLanguages)
                _LanguageTile(
                  language: language,
                  selected: identical(language, selected),
                  onTap: () async {
                    await controller.setLocale(language.locale);
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
              const SizedBox(height: 8),
              Text(
                l.cnLanguageNote,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  final AppLanguage language;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showEnglish = language.englishName != language.nativeName;
    return Semantics(
      button: true,
      selected: selected,
      label: showEnglish
          ? '${language.nativeName}, ${language.englishName}'
          : language.nativeName,
      excludeSemantics: true,
      child: ListTile(
        minVerticalPadding: 12,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        selected: selected,
        title: Text(
          language.nativeName,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: showEnglish ? Text(language.englishName) : null,
        trailing: selected ? const Icon(Icons.check_circle) : null,
        onTap: onTap,
      ),
    );
  }
}
