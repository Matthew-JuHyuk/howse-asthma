import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../mock_nav.dart';
import '../screen_ids.dart';

class MockScreenChrome extends StatelessWidget {
  const MockScreenChrome({
    super.key,
    required this.screenId,
    required this.title,
    required this.child,
    this.showBack = true,
    this.actions,
    this.bottomBar,
    this.backgroundColor,
  });

  final String screenId;
  final String title;
  final Widget child;
  final bool showBack;
  final List<Widget>? actions;
  final Widget? bottomBar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppTheme.defaultBackground,
      appBar: AppBar(
        automaticallyImplyLeading: showBack,
        title: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text(
              screenId,
              style: const TextStyle(fontSize: 11, color: AppTheme.neutral400, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: actions,
      ),
      body: child,
      bottomNavigationBar: bottomBar,
    );
  }
}

class MockSectionCard extends StatelessWidget {
  const MockSectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppTheme.neutral0,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.neutral200),
        boxShadow: [
          BoxShadow(
            color: AppTheme.neutral900.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );
  }
}

class MockChip extends StatelessWidget {
  const MockChip({super.key, required this.label, this.selected = false, this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onTap == null ? null : (_) => onTap!(),
      selectedColor: AppTheme.brand100,
      checkmarkColor: AppTheme.brand700,
    );
  }
}

class MockPrimaryCta extends StatelessWidget {
  const MockPrimaryCta({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.color,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon ?? Icons.touch_app_outlined),
      label: Text(label),
      style: color == null
          ? null
          : FilledButton.styleFrom(backgroundColor: color, foregroundColor: AppTheme.neutral0),
    );
  }
}

class MockNavTile extends StatelessWidget {
  const MockNavTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.target,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final MockScreenId target;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: AppTheme.brand100,
        foregroundColor: AppTheme.brand700,
        child: Icon(icon, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.subtext, fontSize: 13)),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.neutral400),
      onTap: () => MockNav.push(context, target),
    );
  }
}

class MockRiskBanner extends StatelessWidget {
  const MockRiskBanner({
    super.key,
    required this.stateLabel,
    required this.message,
    this.warning = false,
  });

  final String stateLabel;
  final String message;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    final bg = warning ? const Color(0xFFFFF7ED) : AppTheme.brand50;
    final accent = warning ? AppTheme.warning600 : AppTheme.brand700;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warning ? const Color(0xFFFDBA74) : AppTheme.brand200),
      ),
      child: Row(
        children: [
          Icon(warning ? Icons.warning_amber_rounded : Icons.check_circle_outline, color: accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stateLabel, style: TextStyle(color: accent, fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(message, style: const TextStyle(color: AppTheme.neutral700, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MockDraftBanner extends StatelessWidget {
  const MockDraftBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.warning50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppTheme.warning200),
      ),
      child: Row(
        children: [
          const Icon(Icons.science_outlined, size: 18, color: AppTheme.warning700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 12, color: AppTheme.warning800, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
