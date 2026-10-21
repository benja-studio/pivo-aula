import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Keeps scrolling native to each platform without giving Android an elastic
/// edge effect. iOS retains its familiar bounce; Android and desktop clamp.
ScrollPhysics appScrollPhysics() {
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return const BouncingScrollPhysics();
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return const ClampingScrollPhysics();
  }
}
