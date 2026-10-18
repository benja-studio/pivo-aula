import 'package:flutter/material.dart';

/// The canonical set of subject icons.
///
/// Keep these as compile-time constants so Flutter can tree-shake the Material
/// icon font in release builds. Subjects store the icon code point in the
/// database, so screens should resolve that value through [fromCodePoint]
/// rather than constructing [IconData] dynamically.
abstract final class SubjectIcons {
  static const List<IconData> available = [
    Icons.book_rounded,
    Icons.calculate_rounded,
    Icons.science_rounded,
    Icons.computer_rounded,
    Icons.language_rounded,
    Icons.architecture_rounded,
    Icons.psychology_rounded,
    Icons.draw_rounded,
  ];

  static IconData fromCodePoint(int codePoint) {
    for (final icon in available) {
      if (icon.codePoint == codePoint) {
        return icon;
      }
    }

    // Older or unknown saved icon codes should fall back to a valid icon.
    return Icons.book_rounded;
  }
}
