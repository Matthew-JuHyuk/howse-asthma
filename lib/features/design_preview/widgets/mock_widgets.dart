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
    // Material ancestor so ListTile ink/splash paint correctly inside the card.
    return Material(
      color: color ?? AppTheme.neutral0,
      elevation: 1,
      shadowColor: AppTheme.neutral900.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppTheme.neutral200),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
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

/// 5-segment intensity bar used on HOME / ENV factor rows.
class MockLevelBar extends StatelessWidget {
  const MockLevelBar({
    super.key,
    required this.filled,
    this.activeColor = AppTheme.brand400,
    this.height = 6,
  });

  final int filled;
  final Color activeColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return Expanded(
          child: Container(
            height: height,
            margin: EdgeInsets.only(right: i == 4 ? 0 : 4),
            decoration: BoxDecoration(
              color: i < filled ? activeColor : AppTheme.neutral200,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        );
      }),
    );
  }
}

class MockFactorRow extends StatelessWidget {
  const MockFactorRow({
    super.key,
    required this.icon,
    required this.title,
    required this.level,
    required this.detail,
    required this.filled,
    this.levelColor = AppTheme.brand600,
    this.barColor = AppTheme.brand400,
    this.iconBg = AppTheme.neutral100,
    this.iconColor = AppTheme.neutral600,
    this.borderColor = AppTheme.neutral200,
    this.tip,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String level;
  final String detail;
  final int filled;
  final Color levelColor;
  final Color barColor;
  final Color iconBg;
  final Color iconColor;
  final Color borderColor;
  final String? tip;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.neutral0,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                        ),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(color: levelColor, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          level,
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: levelColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(detail, style: const TextStyle(fontSize: 12, color: AppTheme.subtext)),
                    const SizedBox(height: 10),
                    MockLevelBar(filled: filled, activeColor: barColor),
                    if (tip != null) ...[
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: levelColor.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tip!,
                          style: TextStyle(fontSize: 12, color: levelColor.withValues(alpha: 0.9)),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MockFilterChipRow extends StatelessWidget {
  const MockFilterChipRow({
    super.key,
    required this.labels,
    this.selectedIndex = 0,
    this.onSelected,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            FilterChip(
              label: Text(labels[i]),
              selected: i == selectedIndex,
              onSelected: onSelected == null ? null : (_) => onSelected!(i),
              selectedColor: AppTheme.brand600,
              checkmarkColor: AppTheme.neutral0,
              labelStyle: TextStyle(
                color: i == selectedIndex ? AppTheme.neutral0 : AppTheme.neutral600,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              backgroundColor: AppTheme.neutral0,
              side: BorderSide(
                color: i == selectedIndex ? AppTheme.brand600 : AppTheme.neutral200,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class MockBrandHeader extends StatelessWidget {
  const MockBrandHeader({
    super.key,
    required this.title,
    required this.screenId,
    this.trailing,
    this.brandColor = AppTheme.brand600,
    this.titleColor = AppTheme.brand700,
  });

  final String title;
  final String screenId;
  final Widget? trailing;
  final Color brandColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: brandColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.air, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: titleColor)),
              Text(screenId, style: const TextStyle(fontSize: 11, color: AppTheme.neutral400)),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
