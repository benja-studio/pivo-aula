import 'dart:math' as math;
import 'package:flutter/physics.dart';

/// Helper to convert Apple-style spring parameters (dampingRatio ζ, response r in seconds)
/// into Flutter's [SpringDescription].
SpringDescription springFrom({
  double dampingRatio = 1.0,
  double response = 0.4,
}) {
  final omega = 2 * math.pi / response;
  return SpringDescription(
    mass: 1.0,
    stiffness: omega * omega, // (2π / r)²
    damping: 4 * math.pi * dampingRatio / response, // 2ζω
  );
}

/// Momentum projection based on Apple's exponential model (NOT v²/2a).
double project(
  double velocityPxPerSec, {
  double decelerationRate = 0.998,
}) {
  return (velocityPxPerSec / 1000) * decelerationRate / (1 - decelerationRate);
}

/// Progressive rubber-banding resistance when dragged outside bounds.
double rubberband(
  double overshoot,
  double dimension, {
  double c = 0.55,
}) {
  if (dimension == 0) return 0;
  return (overshoot * dimension * c) / (dimension + c * overshoot.abs());
}
