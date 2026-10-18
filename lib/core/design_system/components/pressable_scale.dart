import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../app_motion.dart';

/// Tactile interaction wrapper with spring feedback.
///
/// Uses the gesture arena instead of raw pointer-up callbacks, so a drag that
/// starts on a card can scroll normally and a long press never also fires a tap.
class PressableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double pressedScale;
  final double pressedOpacity;
  final HitTestBehavior behavior;

  const PressableScale({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.pressedScale = 0.97,
    this.pressedOpacity = 0.94,
    this.behavior = HitTestBehavior.opaque,
  });

  @override
  State<PressableScale> createState() => _PressableScaleState();
}

class _PressableScaleState extends State<PressableScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(
      vsync: this,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(double target) {
    final disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (disableAnimations) {
      _controller.value = target;
      return;
    }

    _controller.animateWith(
      SpringSimulation(
        AppMotion.defaultUi,
        _controller.value,
        target,
        0.0,
      ),
    );
  }

  void _release() => _animateTo(1.0);

  @override
  Widget build(BuildContext context) {
    final canPress = widget.onTap != null || widget.onLongPress != null;

    return GestureDetector(
      behavior: widget.behavior,
      onTapDown: canPress ? (_) => _animateTo(widget.pressedScale) : null,
      onTapUp: canPress ? (_) => _release() : null,
      onTapCancel: canPress ? _release : null,
      onTap: widget.onTap,
      onLongPressStart: widget.onLongPress == null
          ? null
          : (_) => _animateTo(widget.pressedScale),
      onLongPressEnd: widget.onLongPress == null
          ? null
          : (_) {
              _release();
              widget.onLongPress?.call();
            },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = _controller.value.clamp(0.85, 1.05).toDouble();
          final pressRange = 1.0 - widget.pressedScale;
          final pressProgress = pressRange <= 0
              ? 0.0
              : ((1.0 - scale) / pressRange).clamp(0.0, 1.0).toDouble();
          final idleOpacity = 1.0;
          final targetOpacity = widget.pressedOpacity.clamp(0.0, 1.0);
          final opacity = idleOpacity -
              ((idleOpacity - targetOpacity) * pressProgress);

          return Opacity(
            opacity: opacity.clamp(0.0, 1.0).toDouble(),
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.center,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
