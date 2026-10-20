import 'package:flutter/material.dart';

/// Shared corner geometry for Aula.
///
/// Direct radii keep cards and controls consistent. Multiplying the base
/// values made buttons and navigation indicators excessively pill-shaped.
class AppRadius {
  AppRadius._();

  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 28;
  static const double full = 9999;

  static BorderRadius radiusXs = BorderRadius.circular(xs);
  static BorderRadius radiusSm = BorderRadius.circular(sm);
  static BorderRadius radiusMd = BorderRadius.circular(md);
  static BorderRadius radiusLg = BorderRadius.circular(lg);
  static BorderRadius radiusXl = BorderRadius.circular(xl);
  static BorderRadius radiusFull = BorderRadius.circular(full);

  /// Continuous (squircle-style) corners using the same radius scale.
  static ContinuousRectangleBorder continuousSm({
    BorderSide side = BorderSide.none,
  }) =>
      ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(sm),
        side: side,
      );

  static ContinuousRectangleBorder continuousMd({
    BorderSide side = BorderSide.none,
  }) =>
      ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(md),
        side: side,
      );

  static ContinuousRectangleBorder continuousLg({
    BorderSide side = BorderSide.none,
  }) =>
      ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(lg),
        side: side,
      );

  static ContinuousRectangleBorder continuousXl({
    BorderSide side = BorderSide.none,
  }) =>
      ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(xl),
        side: side,
      );
}
