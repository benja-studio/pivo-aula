import 'package:flutter/material.dart';

/// Tokens globales de Aula. Las pantallas deben consumir estos valores
/// o el ColorScheme activo, nunca definir colores de interfaz por su cuenta.
class AppColors {
  AppColors._();

  // Marca y acentos principales.
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF818CF8);
  static const Color secondary = Color(0xFF0EA5E9);
  static const Color secondaryDark = Color(0xFF38BDF8);

  // Opciones para personalización de materias/perfil.
  static const List<Color> accentOptions = [
    Color(0xFF6366F1),
    Color(0xFF0EA5E9),
    Color(0xFF8B5CF6),
    Color(0xFF0D9488),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFFEC4899),
  ];

  static const List<Color> subjectColors = [
    Color(0xFF6366F1),
    Color(0xFF0EA5E9),
    Color(0xFF8B5CF6),
    Color(0xFF0D9488),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFFEC4899),
    Color(0xFF64748B),
    Color(0xFF14B8A6),
  ];

  // Academic status tokens (light mode).
  static const Color success = Color(0xFF10B981);
  static const Color enrolled = Color(0xFF3B82F6);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color pending = Color(0xFF6B7280);
  static const Color info = secondary;

  // Light canvas, surfaces, borders and text.
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightBorderSubtle = Color(0xFFF1F5F9);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightTextTertiary = Color(0xFF94A3B8);

  // Dark canvas, surfaces, borders and text.
  static const Color darkBg = Color(0xFF090D16);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceElevated = Color(0xFF111827);
  static const Color darkBorder = Color(0xFF1F2937);
  static const Color darkBorderSubtle = Color(0xFF1F2937);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextTertiary = Color(0xFF64748B);

  // Status-tinted badge surfaces.
  static const Color successLight = Color(0xFFECFDF5);
  static const Color successDark = Color(0xFF064E3B);
  static const Color enrolledLight = Color(0xFFEFF6FF);
  static const Color enrolledDark = Color(0xFF172554);
  static const Color warningLight = Color(0xFFFFFBEB);
  static const Color warningDark = Color(0xFF451A03);
  static const Color errorLight = Color(0xFFFEF2F2);
  static const Color errorDark = Color(0xFF450A0A);
  static const Color pendingLight = Color(0xFFF3F4F6);
  static const Color pendingDark = Color(0xFF1F2937);
  static const Color infoLight = Color(0xFFF0F9FF);
  static const Color infoDark = Color(0xFF082F49);

  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkSurface : lightSurface;
  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBorder : lightBorder;
  static Color textPrimary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkTextPrimary : lightTextPrimary;
  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkTextSecondary : lightTextSecondary;
  static Color textTertiary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkTextTertiary : lightTextTertiary;
}
