import 'package:flutter/physics.dart';
import '../utils/spring_helpers.dart';

class AppMotion {
  AppMotion._();

  /// Responsive press/release spring: quick feedback with a restrained settle.
  static final SpringDescription defaultUi = springFrom(
    dampingRatio: 0.88,
    response: 0.26,
  );

  /// Interactive rotation / shape change spring.
  static final SpringDescription shapeChange = springFrom(
    dampingRatio: 0.82,
    response: 0.34,
  );

  /// Sheets and drawers settlement after drag gesture.
  static final SpringDescription sheet = springFrom(
    dampingRatio: 0.8,
    response: 0.32,
  );

  /// Flick momentum spring.
  static final SpringDescription flickMomentum = springFrom(
    dampingRatio: 0.82,
    response: 0.36,
  );

  /// Page and navigation micro-interactions.
  static const Duration routeDuration = Duration(milliseconds: 280);
  static const Duration routeReverseDuration = Duration(milliseconds: 200);
  static const Duration iconSwitchDuration = Duration(milliseconds: 180);
  static const Duration selectionDuration = Duration(milliseconds: 220);

  /// Fallback durations for reduced motion.
  static const Duration fastFade = Duration(milliseconds: 150);
  static const Duration normalFade = Duration(milliseconds: 250);
}
