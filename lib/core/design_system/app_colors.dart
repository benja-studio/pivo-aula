import 'package:flutter/material.dart';

/// Bespoke, solid architectural color palette for Aula.
/// Strictly non-generic, high-legibility, and ZERO gradients.
class AppColors {
  AppColors._();

  // Primary Default (Intellectual Cobalt / Electric Sapphire)
  static const Color primary = Color(0xFF2F54EB);
  static const Color primaryDark = Color(0xFF597EF7);

  // Accent choices for student customization (Curated solid tones)
  static const List<Color> accentOptions = [
    Color(0xFF2F54EB), // Royal Cobalt
    Color(0xFF4F46E5), // Deep Indigo
    Color(0xFF0D9488), // Slate Teal
    Color(0xFF0284C7), // Steel Sky
    Color(0xFF7C3AED), // Amethyst Violet
    Color(0xFFE11D48), // Deep Rose
    Color(0xFFD97706), // Warm Amber
    Color(0xFF059669), // Forest Emerald
  ];

  // Curated subject colors (Harmonious, crisp, distinct)
  static const List<Color> subjectColors = [
    Color(0xFF2F54EB), // Cobalt
    Color(0xFF4F46E5), // Indigo
    Color(0xFF0284C7), // Sky
    Color(0xFF0D9488), // Teal
    Color(0xFF059669), // Emerald
    Color(0xFFD97706), // Amber
    Color(0xFFDC2626), // Crimson
    Color(0xFF7C3AED), // Violet
    Color(0xFFDB2777), // Berry
    Color(0xFF475569), // Slate
  ];

  // Semantic Status (Solid, authoritative, non-neon)
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF0EA5E9);

  // Semantic Status Toned Surfaces (Light / Dark)
  static const Color successLight = Color(0xFFECFDF5);
  static const Color successDark = Color(0xFF064E3B);
  static const Color warningLight = Color(0xFFFFFBEB);
  static const Color warningDark = Color(0xFF451A03);
  static const Color errorLight = Color(0xFFFEF2F2);
  static const Color errorDark = Color(0xFF450A0A);
  static const Color infoLight = Color(0xFFF0F9FF);
  static const Color infoDark = Color(0xFF082F49);

  // Light Canvas & Surfaces (Crisp slate-porcelain, never muddy)
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightBorderSubtle = Color(0xFFEDF2F7);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextTertiary = Color(0xFF94A3B8);

  // Dark Canvas & Surfaces (Deep obsidian, surgical tone hierarchy)
  static const Color darkBg = Color(0xFF0A0C10);
  static const Color darkSurface = Color(0xFF12151D);
  static const Color darkSurfaceElevated = Color(0xFF1B202B);
  static const Color darkBorder = Color(0xFF242A38);
  static const Color darkBorderSubtle = Color(0xFF1C2230);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextTertiary = Color(0xFF64748B);

  // Context-aware color helpers
  static Color surface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurface
        : lightSurface;
  }

  static Color border(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : lightBorder;
  }

  static Color textPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightTextPrimary;
  }

  static Color textSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondary
        : lightTextSecondary;
  }

  static Color textTertiary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextTertiary
        : lightTextTertiary;
  }
}
