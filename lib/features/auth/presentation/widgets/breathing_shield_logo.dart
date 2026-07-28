import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

/// Low-cost breathing pulse on a house/shield mark (Sprint 2 Direction C).
class BreathingShieldLogo extends StatefulWidget {
  const BreathingShieldLogo({super.key, this.size = 96});

  final double size;

  @override
  State<BreathingShieldLogo> createState() => _BreathingShieldLogoState();
}

class _BreathingShieldLogoState extends State<BreathingShieldLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _scale = Tween<double>(begin: 0.94, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disable = MediaQuery.of(context).disableAnimations;
    if (disable) {
      _controller.stop();
      _controller.value = 0.5;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppTheme.welcomeAccent.withValues(alpha: 0.35),
              AppTheme.welcomeBackground.withValues(alpha: 0.1),
            ],
          ),
          border: Border.all(
            color: AppTheme.welcomeAccent.withValues(alpha: 0.5),
            width: 2,
          ),
        ),
        child: Icon(
          Icons.home_outlined,
          size: widget.size * 0.45,
          color: AppTheme.welcomeOnBackground,
        ),
      ),
    );
  }
}
