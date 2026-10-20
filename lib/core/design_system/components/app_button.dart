import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_colors.dart';
import '../app_radius.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

enum AppButtonVariant {
  primary,
  secondary,
  subtle,
  ghost,
  danger,
}

enum AppButtonSize {
  sm(40.0, 12.0, 16.0),
  md(48.0, 18.0, 18.0),
  lg(56.0, 22.0, 20.0);

  final double height;
  final double horizontalPadding;
  final double iconSize;

  const AppButtonSize(this.height, this.horizontalPadding, this.iconSize);
}

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? trailingIcon;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isExpanded;
  final double? height;
  final bool enableHaptics;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailingIcon,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.isLoading = false,
    this.isExpanded = false,
    this.height,
    this.enableHaptics = true,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  void _setPressed(bool pressed, bool enabled, bool reduceMotion) {
    final next = pressed && enabled && !reduceMotion;
    if (next == _isPressed || !mounted) return;
    setState(() => _isPressed = next);
  }

  void _handleTap() {
    if (widget.enableHaptics) {
      HapticFeedback.lightImpact();
    }
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final enabled = widget.onPressed != null && !widget.isLoading;

    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        bg = theme.colorScheme.primary;
        fg = Colors.white;
        border = BorderSide.none;
      case AppButtonVariant.secondary:
        bg = isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurface;
        fg = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
        border = BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        );
      case AppButtonVariant.subtle:
        bg = theme.colorScheme.primary.withValues(alpha: isDark ? 0.20 : 0.10);
        fg = isDark ? AppColors.primaryDark : AppColors.primary;
        border = BorderSide(
          color: theme.colorScheme.primary.withValues(alpha: isDark ? 0.35 : 0.20),
          width: 1,
        );
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
        border = BorderSide.none;
      case AppButtonVariant.danger:
        bg = AppColors.error;
        fg = Colors.white;
        border = BorderSide.none;
    }

    if (!enabled) {
      bg = bg.withValues(alpha: 0.50);
      fg = fg.withValues(alpha: 0.55);
      if (border != BorderSide.none) {
        border = border.copyWith(color: border.color.withValues(alpha: 0.40));
      }
    }

    final shape = AppRadius.continuousMd(side: border);

    final content = AnimatedSwitcher(
      duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 150),
      child: widget.isLoading
          ? SizedBox(
              key: const ValueKey('loading'),
              width: widget.size.iconSize + 2,
              height: widget.size.iconSize + 2,
              child: CircularProgressIndicator(
                strokeWidth: 2.2,
                strokeCap: StrokeCap.round,
                valueColor: AlwaysStoppedAnimation<Color>(fg),
              ),
            )
          : Row(
              key: const ValueKey('content'),
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: widget.size.iconSize, color: fg),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: (widget.size == AppButtonSize.sm
                            ? AppTypography.label
                            : widget.size == AppButtonSize.lg
                                ? AppTypography.titleSmall
                                : AppTypography.button)
                        .copyWith(
                      color: fg,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (widget.trailingIcon != null) ...[
                  const SizedBox(width: AppSpacing.sm),
                  Icon(widget.trailingIcon, size: widget.size.iconSize, color: fg),
                ],
              ],
            ),
    );

    final buttonHeight = widget.height ?? widget.size.height;
    final duration = reduceMotion ? Duration.zero : const Duration(milliseconds: 100);

    return AnimatedScale(
      scale: _isPressed ? 0.975 : 1.0,
      duration: duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _isPressed ? 0.94 : 1.0,
        duration: duration,
        child: SizedBox(
          height: buttonHeight,
          width: widget.isExpanded ? double.infinity : null,
          child: Material(
            color: bg,
            shape: shape,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              customBorder: shape,
              onTap: enabled ? _handleTap : null,
              onHighlightChanged: (pressed) =>
                  _setPressed(pressed, enabled, reduceMotion),
              splashColor: fg.withValues(alpha: 0.12),
              highlightColor: fg.withValues(alpha: 0.06),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.size.horizontalPadding,
                ),
                child: Center(child: content),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
