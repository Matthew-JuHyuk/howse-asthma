import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../ui/brand.dart';
import 'case_labels.dart';

/// "Medication · Needs review" plus one next action and a confirmed date.
class CaseCard extends StatelessWidget {
  const CaseCard({
    super.key,
    required this.summary,
    required this.onTap,
    this.onDelete,
    this.today,
  });

  final CaseSummary summary;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final DateTime? today;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final (status, tone) = caseStatus(l, summary.row);
    final d = summary.deadline;
    final now = today ?? DateTime.now();
    return CnCard(
      onTap: onTap,
      padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.description_outlined, color: CnColors.teal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caseTitle(l, summary.row),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: CnColors.ink,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    StatusChip(status, tone: tone),
                    if (summary.row.demo) const DemoBadge(),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  caseNextAction(l, summary),
                  style: const TextStyle(fontSize: 15, color: CnColors.ink),
                ),
                if (d != null &&
                    d.state == DeadlineResolution.date &&
                    d.date != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    d.isPast(now)
                        ? l.cnDatePassedShort(formatDay(context, d.date!))
                        : l.cnDateToCheckShort(formatDay(context, d.date!)),
                    style: TextStyle(
                      fontSize: 14,
                      color: d.isPast(now) ? CnColors.warn : CnColors.muted,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onDelete != null)
            PopupMenuButton<String>(
              tooltip: l.cnMoreActions,
              onSelected: (_) => onDelete!(),
              itemBuilder: (_) => [
                PopupMenuItem(value: 'delete', child: Text(l.cnDeleteCase)),
              ],
            )
          else
            const Padding(
              padding: EdgeInsets.only(top: 2, right: 8),
              child: Icon(Icons.chevron_right, color: CnColors.muted),
            ),
        ],
      ),
    );
  }
}

/// Confirms and deletes a case. Returns true when it was deleted.
Future<bool> confirmDeleteCase(
  BuildContext context,
  Future<void> Function() delete,
) async {
  final l = AppLocalizations.of(context)!;
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(l.cnDeleteCaseTitle),
      content: Text(l.cnDeleteCaseBody),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(l.cnCancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFA11D1D),
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(l.cnDelete),
        ),
      ],
    ),
  );
  if (ok != true || !context.mounted) return false;
  try {
    await delete();
    return true;
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l.cnDeleteFailed)));
    }
    return false;
  }
}
