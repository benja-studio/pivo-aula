import 'package:flutter/physics.dart';
import '../utils/spring_helpers.dart';

class AppMotion {
  AppMotion._();

  /// Default UI spring: critically damped, no bounce.
  static final SpringDescription defaultUi = springFrom(
    dampingRatio: 1.0,
    response: 0.38,
  );

  /// Interactive rotation / shape change spring.
  static final SpringDescription shapeChange = springFrom(
    dampingRatio: 0.8,
    response: 0.4,
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

  /// Fallback durations for reduced motion
  static const Duration fastFade = Duration(milliseconds: 150);
  static const Duration normalFade = Duration(milliseconds: 250);
}
