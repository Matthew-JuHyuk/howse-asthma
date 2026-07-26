import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Shown when signup succeeds but email confirmation is required.
class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.authCheckEmailTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mark_email_read_outlined, size: 56),
                const SizedBox(height: 16),
                Text(
                  l10n.authCheckEmailBody(email),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                  child: Text(l10n.authBackToSignIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
