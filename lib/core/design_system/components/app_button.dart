import 'package:flutter/material.dart';
import '../app_radius.dart';
import '../app_spacing.dart';
import '../app_typography.dart';
import 'pressable_scale.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;
  final double height;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isExpanded = false,
    this.height = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    switch (variant) {
      case AppButtonVariant.primary:
        bg = theme.colorScheme.primary;
        fg = theme.colorScheme.onPrimary;
      case AppButtonVariant.secondary:
        bg = isDark ? const Color(0xFF22262E) : const Color(0xFFF3F4F6);
        fg = isDark ? Colors.white : const Color(0xFF111827);
        border = BorderSide(
          color: isDark ? const Color(0xFF2A2E37) : const Color(0xFFE5E7EB),
        );
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = theme.colorScheme.primary;
      case AppButtonVariant.danger:
        bg = const Color(0xFFEF4444);
        fg = Colors.white;
    }

    if (onPressed == null) {
      bg = bg.withValues(alpha: 0.4);
      fg = fg.withValues(alpha: 0.4);
    }

    Widget content = Row(
      mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ] else if (icon != null) ...[
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          label,
          style: AppTypography.titleSmall.copyWith(
            color: fg,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    return PressableScale(
      onTap: isLoading ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        decoration: ShapeDecoration(
          color: bg,
          shape: AppRadius.continuousMd(side: border),
        ),
        alignment: Alignment.center,
        child: content,
      ),
    );
  }
}
