import 'package:flutter/material.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

class AppButton extends StatefulWidget {
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
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  void _setPressed(bool pressed, bool enabled, bool reduceMotion) {
    final next = pressed && enabled && !reduceMotion;
    if (next == _isPressed || !mounted) return;
    setState(() => _isPressed = next);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final reduceMotion =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final enabled = widget.onPressed != null && !widget.isLoading;

    Color bg;
    Color fg;
    BorderSide border = BorderSide.none;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        bg = theme.colorScheme.primary;
        fg = theme.colorScheme.onPrimary;
      case AppButtonVariant.secondary:
        bg = isDark ? const Color(0xFF22262E) : const Color(0xFFF3F4F6);
        fg = isDark ? Colors.white : const Color(0xFF111827);
        border = BorderSide(
          color: isDark ? const Color(0xFF343A46) : const Color(0xFFE5E7EB),
        );
      case AppButtonVariant.ghost:
        bg = Colors.transparent;
        fg = theme.colorScheme.primary;
      case AppButtonVariant.danger:
        bg = const Color(0xFFDC3838);
        fg = Colors.white;
    }

    if (!enabled) {
      bg = bg.withValues(alpha: 0.55);
      fg = fg.withValues(alpha: 0.62);
    }

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: border,
    );

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ] else if (widget.icon != null) ...[
          Icon(widget.icon, size: 18, color: fg),
          const SizedBox(width: AppSpacing.sm),
        ],
        Flexible(
          child: Text(
            widget.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: AppTypography.titleSmall.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );

    final buttonHeight = widget.height < 48 ? 48.0 : widget.height;
    final duration = reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 110);

    return AnimatedScale(
      scale: _isPressed ? 0.985 : 1,
      duration: duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _isPressed ? 0.96 : 1,
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
              onTap: enabled ? widget.onPressed : null,
              onHighlightChanged: (pressed) =>
                  _setPressed(pressed, enabled, reduceMotion),
              splashColor: fg.withValues(alpha: 0.13),
              highlightColor: fg.withValues(alpha: 0.08),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Center(child: content),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
