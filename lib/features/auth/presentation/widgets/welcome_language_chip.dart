import 'package:flutter/material.dart';

import '../../../../core/locale/locale_controller.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/home_shell.dart';

/// Top-right language chip for Welcome (Sprint 2 S2-I18N-04).
class WelcomeLanguageChip extends StatelessWidget {
  const WelcomeLanguageChip({super.key});

  Future<void> _openSheet(BuildContext context) async {
    final controller = AppLocaleScope.of(context);
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: supportedLocales.map((locale) {
              final selected =
                  controller.value.languageCode == locale.languageCode;
              return ListTile(
                title: Text(
                  localeDisplayNames[locale.languageCode] ??
                      locale.languageCode,
                ),
                trailing: selected
                    ? const Icon(Icons.check, color: AppTheme.brand600)
                    : null,
                onTap: () async {
                  await controller.setLocale(locale);
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppLocaleScope.of(context);
    return ValueListenableBuilder<Locale>(
      valueListenable: controller,
      builder: (context, locale, _) {
        final code = locale.languageCode.toUpperCase();
        return TextButton(
          onPressed: () => _openSheet(context),
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.welcomeMuted,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          child: Text(
            '🌐 $code',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        );
      },
    );
  }
}
