import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import '../../utils/spring_helpers.dart';
import '../app_colors.dart';
import '../app_motion.dart';
import '../app_radius.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

/// A keyboard-aware, spring-physics bottom sheet with refined header and tactile affordances.
class SpringSheet extends StatefulWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final bool showCloseButton;

  const SpringSheet({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.showCloseButton = false,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? subtitle,
    Widget? trailing,
    bool showCloseButton = false,
  }) {
    HapticFeedback.lightImpact();
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      useSafeArea: true,
      builder: (context) => SpringSheet(
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        showCloseButton: showCloseButton,
        child: child,
      ),
    );
  }

  @override
  State<SpringSheet> createState() => _SpringSheetState();
}

class _SpringSheetState extends State<SpringSheet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  double _dragOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController.unbounded(vsync: this, value: 0.0);
  }

  @override
  void dispose() {
    _animController.removeListener(_onControllerTick);
    _animController.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta ?? 0;
      if (_dragOffset < 0) {
        _dragOffset = -rubberband(_dragOffset.abs(), 300);
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0.0;
    final projected = _dragOffset + project(velocity);

    if (projected > 120 || velocity > 400) {
      Navigator.of(context).pop();
      return;
    }

    final simulation = SpringSimulation(AppMotion.sheet, _dragOffset, 0.0, velocity);
    _animController
      ..stop()
      ..value = _dragOffset
      ..removeListener(_onControllerTick)
      ..addListener(_onControllerTick);

    _animController.animateWith(simulation).whenComplete(() {
      _animController.removeListener(_onControllerTick);
      if (!mounted) return;
      setState(() => _dragOffset = 0.0);
    });
  }

  void _onControllerTick() {
    if (!mounted) return;
    setState(() => _dragOffset = _animController.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final bg = isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final shape = AppRadius.continuousXl(side: BorderSide(color: border, width: 1));

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : mediaQuery.size.height;

        return Transform.translate(
          offset: Offset(0, _dragOffset),
          child: Container(
            constraints: BoxConstraints(maxHeight: availableHeight * 0.94),
            decoration: ShapeDecoration(
              color: bg,
              shape: shape,
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.12),
                  blurRadius: 28,
                  offset: const Offset(0, -8),
                ),
              ],
            ),
            child: ClipPath(
              clipper: ShapeBorderClipper(shape: shape),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppSpacing.xs + 2),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                    onVerticalDragEnd: _onVerticalDragEnd,
                    child: SizedBox(
                      width: 96,
                      height: 28,
                      child: Center(
                        child: Container(
                          width: 42,
                          height: 4.5,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF3E4554)
                                : const Color(0xFFCBD5E1),
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.title != null ||
                      widget.subtitle != null ||
                      widget.trailing != null ||
                      widget.showCloseButton) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        AppSpacing.xs,
                        AppSpacing.lg,
                        AppSpacing.md,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (widget.title != null)
                                  Text(
                                    widget.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.titleMedium.copyWith(
                                      color: isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.lightTextPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                if (widget.subtitle != null) ...[
                                  const SizedBox(height: 2),
                                  Text(
                                    widget.subtitle!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.caption.copyWith(
                                      color: isDark
                                          ? AppColors.darkTextSecondary
                                          : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (widget.trailing != null) ...[
                            const SizedBox(width: AppSpacing.sm),
                            widget.trailing!,
                          ],
                          if (widget.showCloseButton) ...[
                            const SizedBox(width: AppSpacing.xs),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              iconSize: 20,
                              style: IconButton.styleFrom(
                                backgroundColor: isDark
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurfaceElevated,
                                shape: const CircleBorder(),
                              ),
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    ),
                  ],
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        AppSpacing.lg,
                        AppSpacing.xl,
                        AppSpacing.lg + mediaQuery.padding.bottom,
                      ),
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
