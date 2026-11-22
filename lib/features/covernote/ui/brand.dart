import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class CnColors {
  static const navy = Color(0xFF142D4E);
  static const teal = Color(0xFF167D8D);
  static const mint = Color(0xFFD8F2EC);
  static const ink = Color(0xFF0F172A);
  static const muted = Color(0xFF5B6675);
  static const line = Color(0xFFDCE3EA);
  static const warn = Color(0xFF9A5B00);
  static const warnBg = Color(0xFFFFF4E0);
}

/// Mark + "CoverNote" + subtitle.
class BrandLockup extends StatelessWidget {
  const BrandLockup({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final size = compact ? 40.0 : 56.0;
    return Semantics(
      label: '${l.appTitle}. ${l.cnTagline}',
      excludeSemantics: true,
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.28),
              boxShadow: [
                BoxShadow(
                  color: CnColors.navy.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size * 0.24),
              child: Image.asset(
                'assets/branding/covernote_mark.png',
                width: size,
                height: size,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.appTitle,
                  style: TextStyle(
                    fontSize: compact ? 20 : 26,
                    fontWeight: FontWeight.w700,
                    color: CnColors.navy,
                  ),
                ),
                Text(
                  l.cnTagline,
                  style: const TextStyle(fontSize: 14, color: CnColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DemoBadge extends StatelessWidget {
  const DemoBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Semantics(
      label: l.cnDemoBadgeLong,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: CnColors.warnBg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: CnColors.warn.withValues(alpha: 0.35)),
        ),
        child: Text(
          l.cnDemoBadge,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: CnColors.warn,
          ),
        ),
      ),
    );
  }
}

/// Rounded card used for the main home actions and summary cards.
class CnCard extends StatelessWidget {
  const CnCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.color,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final fill = color ?? Colors.white;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: CnColors.navy.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: fill,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: color == null
                ? CnColors.line
                : Colors.white.withValues(alpha: 0.8),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Soft tinted tile behind a single icon.
class CnIconWell extends StatelessWidget {
  const CnIconWell(
    this.icon, {
    super.key,
    this.size = 44,
    this.iconSize = 22,
    this.background = CnColors.mint,
    this.foreground = CnColors.teal,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * 0.34),
      ),
      child: Icon(icon, size: iconSize, color: foreground),
    );
  }
}

/// Short statement on the navy-to-teal wash used at the top of Home.
class CnHeroBanner extends StatelessWidget {
  const CnHeroBanner({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: CnColors.navy.withValues(alpha: 0.18),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF10283F), Color(0xFF1B7C8E)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -28,
                top: -36,
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              Positioned(
                left: -24,
                bottom: -42,
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 28, bottom: 12),
    child: Semantics(
      header: true,
      child: Row(
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: CnColors.teal,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: CnColors.navy,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Small coloured chip for a status like "Needs check" or "Saved".
class StatusChip extends StatelessWidget {
  const StatusChip(
    this.text, {
    super.key,
    this.tone = ChipTone.neutral,
    this.icon,
  });

  final String text;
  final ChipTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      ChipTone.good => (const Color(0xFFE3F5EE), const Color(0xFF136B4B)),
      ChipTone.warn => (CnColors.warnBg, CnColors.warn),
      ChipTone.bad => (const Color(0xFFFDE8E8), const Color(0xFFA11D1D)),
      ChipTone.neutral => (const Color(0xFFEFF3F6), CnColors.muted),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: fg,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum ChipTone { good, warn, bad, neutral }

/// A message with one clear next action. Used for empty, offline and error states.
class ActionMessage extends StatelessWidget {
  const ActionMessage({
    super.key,
    required this.icon,
    required this.title,
    this.body,
    this.actionLabel,
    this.onAction,
    this.secondaryLabel,
    this.onSecondary,
  });

  final IconData icon;
  final String title;
  final String? body;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryLabel;
  final VoidCallback? onSecondary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CnIconWell(icon, size: 64, iconSize: 30),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          if (body != null) ...[
            const SizedBox(height: 8),
            Text(
              body!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: CnColors.muted),
            ),
          ],
          if (actionLabel != null) ...[
            const SizedBox(height: 16),
            FilledButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
          if (secondaryLabel != null)
            TextButton(onPressed: onSecondary, child: Text(secondaryLabel!)),
        ],
      ),
    );
  }
}

/// User-facing text for a store / job error code.
String caseErrorText(AppLocalizations l, String code) {
  switch (code) {
    case 'network':
      return l.cnErrNetwork;
    case 'ai_not_configured':
    case 'ai_auth_failed':
    case 'ai_model_not_found':
      return l.cnErrServiceUnavailable;
    case 'ai_rate_limited':
      return l.cnErrBusy;
    case 'ai_timeout':
    case 'ai_unavailable':
    case 'ai_network_error':
    case 'lease_expired':
      return l.cnErrSlow;
    case 'document_unreadable':
      return l.cnErrUnreadable;
    case 'too_many_pages':
      return l.cnErrTooManyPages;
    case 'document_too_large':
    case 'ai_input_too_large':
      return l.cnErrTooLarge;
    case 'session_expired':
    case 'not_signed_in':
      return l.cnAuthErrSessionExpired;
    case 'stale_facts':
      return l.cnErrStale;
    case 'case_not_found':
      return l.cnErrCaseGone;
    case 'consent_required':
      return l.cnConsentAiBody;
    case 'attempts_exhausted':
      return l.cnErrAttempts;
    case 'demo_no_upload':
      return l.cnErrDemoUpload;
    default:
      return l.cnErrGeneric(code);
  }
}
