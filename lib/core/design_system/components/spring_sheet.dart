import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../../utils/spring_helpers.dart';
import '../app_motion.dart';
import '../app_radius.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

/// Draggable, physics-based interruptible bottom sheet.
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
    _animController = AnimationController.unbounded(
      vsync: this,
      value: 0.0,
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.primaryDelta ?? 0;
      if (_dragOffset < 0) {
        // Apply rubberband resistance upwards
        _dragOffset = -rubberband(_dragOffset.abs(), 300);
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0.0;
    final projected = _dragOffset + project(velocity);

    // If projected drag is down > 120px or velocity is high downwards, dismiss
    if (projected > 120 || velocity > 400) {
      Navigator.of(context).pop();
    } else {
      // Settle back to 0 using spring simulation
      final simulation = SpringSimulation(
        AppMotion.sheet,
        _dragOffset,
        0.0,
        velocity,
      );
      _animController.animateWith(simulation).whenComplete(() {
        setState(() {
          _dragOffset = 0.0;
        });
      });
      _animController.addListener(_onControllerTick);
    }
  }

  void _onControllerTick() {
    setState(() {
      _dragOffset = _animController.value;
    });
    if (_animController.isCompleted) {
      _animController.removeListener(_onControllerTick);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final viewInsets = MediaQuery.of(context).viewInsets;

    final bg = isDark ? const Color(0xFF181B20) : Colors.white;

    return Padding(
      padding: EdgeInsets.only(bottom: viewInsets.bottom),
      child: Transform.translate(
        offset: Offset(0, _dragOffset > 0 ? _dragOffset : _dragOffset),
        child: GestureDetector(
          onVerticalDragUpdate: _onVerticalDragUpdate,
          onVerticalDragEnd: _onVerticalDragEnd,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.88,
            ),
            decoration: ShapeDecoration(
              color: bg,
              shape: AppRadius.continuousXl(),
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, -6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSpacing.sm),
                // Handle indicator
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF374151)
                          : const Color(0xFFD1D5DB),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                if (widget.title != null || widget.trailing != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.title != null)
                          Text(
                            widget.title!,
                            style: AppTypography.titleMedium.copyWith(
                              color: isDark ? Colors.white : const Color(0xFF111827),
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        if (widget.trailing != null) widget.trailing!,
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
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
