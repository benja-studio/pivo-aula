import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_radius.dart';
import '../app_spacing.dart';

/// Premium, architectural pulse skeleton loader.
/// Uses pure tone luminance shifts with NO gradients.
class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final ShapeBorder? customShape;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.customShape,
  });

  const SkeletonLoader.circular({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        borderRadius = const BorderRadius.all(Radius.circular(999)),
        customShape = null;

  const SkeletonLoader.text({
    super.key,
    this.width = double.infinity,
    this.height = 14.0,
    this.borderRadius,
  }) : customShape = null;

  const SkeletonLoader.badge({
    super.key,
    this.width = 64.0,
    this.height = 24.0,
    this.borderRadius,
  }) : customShape = null;

  const SkeletonLoader.card({
    super.key,
    this.width = double.infinity,
    this.height = 100.0,
    this.borderRadius,
  }) : customShape = null;

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? AppColors.darkSurfaceElevated : const Color(0xFFE2E8F0);
    final highlightColor = isDark ? const Color(0xFF262C3A) : const Color(0xFFF1F5F9);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final color = Color.lerp(baseColor, highlightColor, _animation.value)!;
        if (widget.customShape != null) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: ShapeDecoration(
              color: color,
              shape: widget.customShape!,
            ),
          );
        }

        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: widget.borderRadius ?? AppRadius.radiusMd,
          ),
        );
      },
    );
  }
}

/// A ready-to-use skeleton card for exam or task items
class SkeletonExamCard extends StatelessWidget {
  const SkeletonExamCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: ShapeDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        shape: AppRadius.continuousLg(
          side: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              SkeletonLoader.badge(width: 80, height: 22),
              SkeletonLoader.badge(width: 60, height: 22),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const SkeletonLoader.text(width: 180, height: 18),
          const SizedBox(height: AppSpacing.xs),
          const SkeletonLoader.text(width: 120, height: 13),
        ],
      ),
    );
  }
}

/// A list placeholder that renders multiple skeleton cards
class SkeletonListPlaceholder extends StatelessWidget {
  final int count;

  const SkeletonListPlaceholder({super.key, this.count = 3});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (_, __) => const SkeletonExamCard(),
    );
  }
}

/// Ultra-minimalist 3-dot pulsing loader for inline or micro-states
class AppPulseLoader extends StatefulWidget {
  final Color? color;
  final double dotSize;

  const AppPulseLoader({
    super.key,
    this.color,
    this.dotSize = 7.0,
  });

  @override
  State<AppPulseLoader> createState() => _AppPulseLoaderState();
}

class _AppPulseLoaderState extends State<AppPulseLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = widget.color ?? Theme.of(context).colorScheme.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final progress = (_controller.value - (index * 0.2)) % 1.0;
            final scale = 0.6 + (0.4 * (1.0 - (progress - 0.5).abs() * 2));
            final opacity = 0.4 + (0.6 * (1.0 - (progress - 0.5).abs() * 2));

            return Container(
              margin: EdgeInsets.symmetric(horizontal: widget.dotSize * 0.35),
              width: widget.dotSize,
              height: widget.dotSize,
              transform: Matrix4.diagonal3Values(scale, scale, 1.0),
              decoration: BoxDecoration(
                color: effectiveColor.withValues(alpha: opacity.clamp(0.2, 1.0)),
                shape: BoxShape.circle,
              ),
            );
          },
        );
      }),
    );
  }
}
