import 'package:flutter/material.dart';
import '../app_radius.dart';
import '../app_spacing.dart';
import '../app_typography.dart';
import 'pressable_scale.dart';

class AppChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Widget? icon;
  final Color? activeColor;

  const AppChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = activeColor ?? theme.colorScheme.primary;

    final bg = isSelected
        ? primary.withValues(alpha: isDark ? 0.25 : 0.12)
        : (isDark ? const Color(0xFF1E222A) : const Color(0xFFF3F4F6));

    final fg = isSelected
        ? primary
        : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563));

    final border = isSelected
        ? BorderSide(color: primary.withValues(alpha: 0.5), width: 1)
        : BorderSide(
            color: isDark ? const Color(0xFF2A2E37) : const Color(0xFFE5E7EB),
            width: 1,
          );

    final chip = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: ShapeDecoration(
        color: bg,
        shape: AppRadius.continuousSm(side: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: AppTypography.label.copyWith(
              color: fg,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return PressableScale(
        onTap: onTap,
        child: chip,
      );
    }

    return chip;
  }
}
