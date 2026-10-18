import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../../utils/spring_helpers.dart';
import '../app_motion.dart';
import '../app_radius.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

/// A keyboard-aware, scrollable bottom sheet with a dedicated drag handle.
class SpringSheet extends StatefulWidget {
  final Widget child;
  final String? title;
  final Widget? trailing;

  const SpringSheet({
    super.key,
    required this.child,
    this.title,
    this.trailing,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    Widget? trailing,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      useSafeArea: true,
      builder: (context) => SpringSheet(
        title: title,
        trailing: trailing,
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
    final bg = isDark ? const Color(0xFF181B20) : Colors.white;
    final shape = AppRadius.continuousXl();

    // The modal route already removes the keyboard inset from its constraints.
    // Use those live constraints instead of subtracting viewInsets a second time.
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : mediaQuery.size.height;

        return Transform.translate(
          offset: Offset(0, _dragOffset),
          child: Container(
            constraints: BoxConstraints(maxHeight: availableHeight * 0.96),
            decoration: ShapeDecoration(
              color: bg,
              shape: shape,
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.16),
                  blurRadius: 24,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: ClipPath(
              clipper: ShapeBorderClipper(shape: shape),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: AppSpacing.xs),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragUpdate: _onVerticalDragUpdate,
                    onVerticalDragEnd: _onVerticalDragEnd,
                    child: SizedBox(
                      width: 88,
                      height: 32,
                      child: Center(
                        child: Container(
                          width: 38,
                          height: 4,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF4B5563)
                                : const Color(0xFFD1D5DB),
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.title != null || widget.trailing != null) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        AppSpacing.sm,
                        AppSpacing.lg,
                        AppSpacing.md,
                      ),
                      child: Row(
                        children: [
                          if (widget.title != null)
                            Expanded(
                              child: Text(
                                widget.title!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.titleMedium.copyWith(
                                  color: isDark ? Colors.white : const Color(0xFF111827),
                                ),
                              ),
                            ),
                          if (widget.trailing != null) ...[
                            if (widget.title != null)
                              const SizedBox(width: AppSpacing.sm),
                            widget.trailing!,
                          ],
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: isDark
                          ? const Color(0xFF262A32)
                          : const Color(0xFFF3F4F6),
                    ),
                  ],
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.xl,
                        AppSpacing.xl,
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
