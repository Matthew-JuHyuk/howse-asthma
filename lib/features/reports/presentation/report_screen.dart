import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// Generates a PDF/CSV summary of medication usage, effectiveness and
/// asthma-risk history for a chosen date range, intended to be shared
/// with a doctor or submitted as insurance step-therapy evidence.
///
/// TODO: query Supabase for medication_logs + attack_risk_logs in the
/// selected range and render a PDF (e.g. via the `pdf` package).
class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.reportTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.description_outlined, size: 48),
              const SizedBox(height: 16),
              Text(l10n.reportTitle, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: Text(l10n.reportGenerateButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
