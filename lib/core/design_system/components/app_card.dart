import 'package:flutter/material.dart';
import '../app_radius.dart';
import '../app_spacing.dart';
import 'pressable_scale.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry padding;
  final Color? color;
  final BorderSide? border;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultBg = isDark ? const Color(0xFF181B20) : Colors.white;
    final defaultBorder = isDark
        ? const BorderSide(color: Color(0xFF262A32), width: 1)
        : const BorderSide(color: Color(0xFFEEF0F3), width: 1);

    final cardContent = Container(
      padding: padding,
      decoration: ShapeDecoration(
        color: color ?? defaultBg,
        shape: AppRadius.continuousLg(side: border ?? defaultBorder),
        shadows: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      return PressableScale(
        onTap: onTap,
        onLongPress: onLongPress,
        child: cardContent,
      );
    }

    return cardContent;
  }
}
