import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Default (Indigo / Deep Blue)
  static const Color primary = Color(0xFF3B5BFD);
  static const Color primaryDark = Color(0xFF5E7AFF);

  // Accent choices for student customization
  static const List<Color> accentOptions = [
    Color(0xFF3B5BFD), // Deep Indigo
    Color(0xFF2563EB), // Classic Royal Blue
    Color(0xFF7C3AED), // Purple / Violet
    Color(0xFF0D9488), // Teal / Emerald
    Color(0xFFE11D48), // Rose
    Color(0xFFD97706), // Amber
    Color(0xFF0284C7), // Sky Blue
    Color(0xFFEA580C), // Sunset Coral
  ];

  // Curated subject colors
  static const List<Color> subjectColors = [
    Color(0xFF4F46E5), // Indigo
    Color(0xFF0284C7), // Sky
    Color(0xFF059669), // Green
    Color(0xFFD97706), // Orange
    Color(0xFFDC2626), // Red
    Color(0xFF7C3AED), // Violet
    Color(0xFFDB2777), // Pink
    Color(0xFF0891B2), // Cyan
  ];

  // Semantic Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Light Surfaces
  static const Color lightBg = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF3F4F6);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF6B7280);
  static const Color lightTextTertiary = Color(0xFF9CA3AF);

  // Dark Surfaces (elevated by tone, not harsh black)
  static const Color darkBg = Color(0xFF0F1115);
  static const Color darkSurface = Color(0xFF181B20);
  static const Color darkSurfaceElevated = Color(0xFF22262E);
  static const Color darkBorder = Color(0xFF2A2E37);
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);
  static const Color darkTextTertiary = Color(0xFF6B7280);
}
