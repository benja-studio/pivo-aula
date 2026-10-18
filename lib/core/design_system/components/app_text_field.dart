import 'package:flutter/material.dart';
import '../app_radius.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int maxLines;
  final bool autofocus;
  final bool enabled;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.autofocus = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final hasError = errorText != null && errorText!.isNotEmpty;
    final borderColor = hasError
        ? const Color(0xFFEF4444)
        : (isDark ? const Color(0xFF2A2E37) : const Color(0xFFE5E7EB));
    final fillColor = isDark ? const Color(0xFF1E222A) : const Color(0xFFF9FAFB);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.titleSmall.copyWith(
              color: isDark ? const Color(0xFFD1D5DB) : const Color(0xFF374151),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        Container(
          decoration: ShapeDecoration(
            color: fillColor,
            shape: AppRadius.continuousMd(
              side: BorderSide(
                color: borderColor,
                width: hasError ? 1.5 : 1.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            maxLines: maxLines,
            scrollPadding: const EdgeInsets.fromLTRB(0, 24, 0, 120),
            autofocus: autofocus,
            enabled: enabled,
            style: AppTypography.bodyMedium.copyWith(
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              hintText: hint,
              hintStyle: AppTypography.bodyMedium.copyWith(
                color: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: AppSpacing.xxs + 2),
          Text(
            errorText!,
            style: AppTypography.caption.copyWith(
              color: const Color(0xFFEF4444),
            ),
          ),
        ],
      ],
    );
  }
}
