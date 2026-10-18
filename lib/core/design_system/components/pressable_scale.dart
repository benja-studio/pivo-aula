import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import '../app_motion.dart';

/// Instant touch-down responsive widget mimicking Apple HIG physics.
/// Compresses to [pressedScale] (default ~0.97) immediately on pointer down,
/// cancels with ~12px drag hysteresis, and releases with a spring simulation.
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
  Offset? _pointerDownPosition;
  bool _isPressed = false;
  static const double _hysteresisPx = 12.0;

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

  void _onPointerDown(PointerDownEvent event) {
    if (widget.onTap == null && widget.onLongPress == null) return;
    _pointerDownPosition = event.position;
    _isPressed = true;
    _animateTo(widget.pressedScale);
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (!_isPressed || _pointerDownPosition == null) return;
    final delta = (event.position - _pointerDownPosition!).distance;
    if (delta > _hysteresisPx) {
      _isPressed = false;
      _animateTo(1.0);
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    if (_isPressed) {
      _isPressed = false;
      _animateTo(1.0);
      widget.onTap?.call();
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (_isPressed) {
      _isPressed = false;
      _animateTo(1.0);
    }
  }

  void _animateTo(double target) {
    final disableAnimations = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (disableAnimations) {
      _controller.value = target;
      return;
    }

    final simulation = SpringSimulation(
      AppMotion.defaultUi,
      _controller.value,
      target,
      0.0,
    );
    _controller.animateWith(simulation);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: widget.behavior,
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: GestureDetector(
        onLongPress: widget.onLongPress,
        behavior: widget.behavior,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = _controller.value.clamp(0.85, 1.05);
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
