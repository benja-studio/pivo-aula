import 'dart:ui';
import 'package:flutter/material.dart';

class BlurSurface extends StatelessWidget {
  final Widget child;
  final double blur;
  final Color? color;
  final Border? border;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const BlurSurface({
    super.key,
    required this.child,
    this.blur = 20.0,
    this.color,
    this.border,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isHighContrast = MediaQuery.of(context).highContrast;

    final defaultBg = isDark
        ? const Color(0xFF181B20).withValues(alpha: isHighContrast ? 1.0 : 0.82)
        : Colors.white.withValues(alpha: isHighContrast ? 1.0 : 0.85);

    final effectiveBlur = isHighContrast ? 0.0 : blur;

    Widget surface = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? defaultBg,
        border: border,
        borderRadius: borderRadius,
      ),
      child: child,
    );

    if (effectiveBlur > 0) {
      surface = RepaintBoundary(
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
            child: surface,
          ),
        ),
      );
    }

    return surface;
  }
}
