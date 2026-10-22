import 'package:flutter/material.dart';

import '../../../core/locale/language_picker.dart';
import '../../../l10n/app_localizations.dart';

/// App bar used on CoverNote-owned screens. Language is always on the right.
/// OS camera / share / file pickers are not wrapped — those follow the OS.
class CoverNoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CoverNoteAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions = const [],
    this.bottom,
    this.showLanguage = true,
  });

  final Widget title;
  final Widget? leading;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final bool showLanguage;

  @override
  Size get preferredSize => Size.fromHeight(
    kToolbarHeight + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: [
        ...actions,
        if (showLanguage) const LanguageButton(),
      ],
      bottom: bottom,
    );
  }
}

/// Body that respects system insets and the keyboard without extra magic
/// numbers. Do not wrap a second time inside a screen that already uses this.
class CoverNoteBody extends StatelessWidget {
  const CoverNoteBody({
    super.key,
    required this.child,
    this.scrollable = false,
    this.padding,
  });

  final Widget child;
  final bool scrollable;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final pad =
        padding ??
        EdgeInsets.fromLTRB(16, 8, 16, 16 + media.viewInsets.bottom);
    final safe = SafeArea(
      // Bottom nav already consumes the system gesture inset when present.
      bottom: false,
      child: scrollable
          ? SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: pad,
              child: child,
            )
          : Padding(padding: pad, child: child),
    );
    return safe;
  }
}

/// One-tap exit to the case list (does not walk steps).
class CasesListButton extends StatelessWidget {
  const CasesListButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return IconButton(
      tooltip: l.cnCasesList,
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back),
    );
  }
}
