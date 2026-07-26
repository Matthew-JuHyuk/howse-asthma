import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/environment_snapshot.dart';

/// Shared NJ/STATE_ONLY transparency badge (WBS 5.1a / 5.9).
class StateOnlySourceBadge extends StatelessWidget {
  const StateOnlySourceBadge({
    super.key,
    required this.coverage,
    this.compact = false,
  });

  final SourceCoverage? coverage;
  final bool compact;

  /// Convenience for NJDOT freight weight meta on a snapshot.
  factory StateOnlySourceBadge.njdot(EnvironmentSnapshot snap, {bool compact = false}) {
    return StateOnlySourceBadge(
      coverage: snap.sourceCoverage?['njdot'],
      compact: compact,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final c = coverage;
    if (c == null || c.scope != 'NJ_ONLY') {
      return const SizedBox.shrink();
    }

    final applied = c.applied;
    final label = applied ? l10n.stateOnlyNjApplied : l10n.stateOnlyNjNotApplied;
    final detail = applied
        ? l10n.stateOnlyNjAppliedHint
        : (c.reason == 'outside_nj'
            ? l10n.stateOnlyNjOutsideHint
            : l10n.stateOnlyNjNoCountHint);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: compact ? 8 : 12,
      ),
      decoration: BoxDecoration(
        color: AppTheme.neutral100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.neutral200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: applied ? AppTheme.brand600 : AppTheme.neutral500,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: applied ? AppTheme.brand700 : AppTheme.neutral600,
                  ),
                ),
              ),
            ],
          ),
          if (!compact) ...[
            const SizedBox(height: 4),
            Text(
              detail,
              style: const TextStyle(fontSize: 12, color: AppTheme.subtext),
            ),
          ],
        ],
      ),
    );
  }
}
