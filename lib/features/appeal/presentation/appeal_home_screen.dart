import 'package:flutter/material.dart';

import '../../../core/config/app_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../data/appeal_demo_store.dart';
import '../domain/appeal_models.dart';
import '../domain/deadline_resolver.dart';
import 'appeal_case_screen.dart';

class AppealHomeScreen extends StatelessWidget {
  const AppealHomeScreen({super.key, required this.onOpenRecords});

  final VoidCallback onOpenRecords;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: AppealDemoStore.instance,
      builder: (context, _) {
        final cases = AppealDemoStore.instance.cases;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
          children: [
            const _SampleBanner(),
            const SizedBox(height: 16),
            Text(
              l10n.v2HomeHeadline,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.neutral900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.v2HomeBody,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 20),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                backgroundColor: AppTheme.brand700,
              ),
              onPressed: () => _addLetter(context),
              child: Text(l10n.v2AddLetter),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
              ),
              onPressed: () => _openSample(context),
              child: Text(l10n.v2TrySample),
            ),
            const SizedBox(height: 8),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: onOpenRecords,
              child: Text(l10n.v2MyRecords),
            ),
            const SizedBox(height: 12),
            if (cases.isEmpty)
              Text(l10n.v2EmptyCases, style: const TextStyle(fontSize: 16))
            else
              for (final item in cases) _CaseCard(item: item),
          ],
        );
      },
    );
  }

  Future<void> _addLetter(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    if (!AppConfig.liveDocumentProcessingEnabled) {
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.v2LiveOffTitle),
          content: Text(l10n.v2LiveOffBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.v2Close),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _openSample(context);
              },
              child: Text(l10n.v2TrySample),
            ),
          ],
        ),
      );
      return;
    }
  }

  void _openSample(BuildContext context) {
    final item = AppealDemoStore.instance.ensureExplicitSample();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => AppealCaseScreen(caseId: item.id)),
    );
  }
}

class _SampleBanner extends StatelessWidget {
  const _SampleBanner();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.brand50,
        border: Border.all(color: AppTheme.brand700),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        l10n.v2SampleBanner,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: AppTheme.brand800,
          height: 1.3,
        ),
      ),
    );
  }
}

class _CaseCard extends StatelessWidget {
  const _CaseCard({required this.item});

  final AppealCase item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final outcome = resolveDeadline(
      item.deadline,
      userConfirmedDate: item.deadlineConfirmedByUser,
    );
    final med = item.medicationRaw.isPresent
        ? item.medicationRaw.rawText!
        : l10n.v2MedNeedsReview;
    final next = item.draftIsCurrent
        ? l10n.v2Share
        : item.preparedMinimumMet
        ? l10n.v2NextDraft
        : l10n.v2NextCheck;
    final created =
        '${item.createdAt.year}-${item.createdAt.month.toString().padLeft(2, '0')}-${item.createdAt.day.toString().padLeft(2, '0')}';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(med),
        subtitle: Text(
          [
            '${l10n.v2Created} $created',
            _status(l10n, item.status),
            next,
            if (outcome.mayShowCountdown && outcome.date != null)
              '${l10n.v2DeadlineLabel} ${_ymd(outcome.date!)}',
          ].join('\n'),
        ),
        isThreeLine: true,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AppealCaseScreen(caseId: item.id),
            ),
          );
        },
      ),
    );
  }
}

String _status(AppLocalizations l10n, CaseStatus status) {
  return switch (status) {
    CaseStatus.draftReady => l10n.v2StatusDraft,
    CaseStatus.readyForDraft => l10n.v2StatusReady,
    _ => l10n.v2StatusReview,
  };
}

String _ymd(DateTime date) {
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '${date.year}-$m-$d';
}
