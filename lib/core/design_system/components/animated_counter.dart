import 'package:flutter/material.dart';
import '../app_typography.dart';

/// Smooth, fluid numeric counter with tabular figures.
/// Automatically animates value changes with an ease-out curve.
class AnimatedCounter extends StatefulWidget {
  final double value;
  final int precision;
  final String? prefix;
  final String? suffix;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.precision = 0,
    this.prefix,
    this.suffix,
    this.style,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _oldValue;

  @override
  void initState() {
    super.initState();
    _oldValue = 0.0;
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: _oldValue, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _oldValue = _animation.value;
      _controller.duration = widget.duration;
      _animation = Tween<double>(begin: _oldValue, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: widget.curve),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = (widget.style ?? AppTypography.statNumber);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentVal = _animation.value;
        final formattedNumber = widget.precision > 0
            ? currentVal.toStringAsFixed(widget.precision)
            : currentVal.round().toString();

        return Text.rich(
          TextSpan(
            children: [
              if (widget.prefix != null)
                TextSpan(
                  text: widget.prefix,
                  style: effectiveStyle,
                ),
              TextSpan(
                text: formattedNumber,
                style: effectiveStyle,
              ),
              if (widget.suffix != null)
                TextSpan(
                  text: widget.suffix,
                  style: effectiveStyle,
                ),
            ],
          ),
          maxLines: 1,
        );
      },
    );
  }
}
