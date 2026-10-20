import 'package:flutter/material.dart';
import '../core/design_system/app_colors.dart';
import '../core/design_system/app_radius.dart';
import '../core/design_system/app_spacing.dart';
import '../core/design_system/app_typography.dart';

class AppTheme {
  AppTheme._();

  static const TextTheme _textTheme = TextTheme(
    displayLarge: AppTypography.display,
    headlineLarge: AppTypography.display,
    headlineMedium: AppTypography.titleLarge,
    headlineSmall: AppTypography.titleMedium,
    titleLarge: AppTypography.titleLarge,
    titleMedium: AppTypography.titleMedium,
    titleSmall: AppTypography.titleSmall,
    bodyLarge: AppTypography.bodyLarge,
    bodyMedium: AppTypography.bodyMedium,
    bodySmall: AppTypography.bodySmall,
    labelLarge: AppTypography.button,
    labelMedium: AppTypography.label,
    labelSmall: AppTypography.caption,
  );

  /// One button geometry across Material controls. Color remains semantic and
  /// is provided by the active ColorScheme.
  static ButtonStyle _standardButtonStyle() => ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(0, 48)),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
        tapTargetSize: MaterialTapTargetSize.padded,
        textStyle: const WidgetStatePropertyAll(AppTypography.button),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      );

  static IconButtonThemeData _iconButtonTheme() => IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
          tapTargetSize: MaterialTapTargetSize.padded,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
        ),
      );

  static InputDecorationTheme _inputTheme({
    required bool isDark,
    required Color accentColor,
  }) {
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final fillColor =
        isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurfaceElevated;

    OutlineInputBorder outline(BorderSide side) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: side,
        );

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: outline(BorderSide(color: borderColor)),
      enabledBorder: outline(BorderSide(color: borderColor)),
      focusedBorder: outline(BorderSide(color: accentColor, width: 1.7)),
      errorBorder: outline(const BorderSide(color: AppColors.error)),
      focusedErrorBorder:
          outline(const BorderSide(color: AppColors.error, width: 1.7)),
    );
  }


  static ThemeData light({Color accentColor = AppColors.primary}) {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: accentColor,
      onPrimary: Colors.white,
      primaryContainer: accentColor.withValues(alpha: 0.12),
      onPrimaryContainer: accentColor,
      secondary: const Color(0xFF334155),
      onSecondary: Colors.white,
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.lightBorder,
      outlineVariant: AppColors.lightBorderSubtle,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightBg,
      inputDecorationTheme: _inputTheme(isDark: false, accentColor: accentColor),
      fontFamily: AppTypography.fontFamily,
      fontFamilyFallback: AppTypography.fontFallbacks,
      textTheme: _textTheme,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: _standardButtonStyle()),
      filledButtonTheme: FilledButtonThemeData(style: _standardButtonStyle()),
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: _standardButtonStyle()),
      textButtonTheme: TextButtonThemeData(style: _standardButtonStyle()),
      iconButtonTheme: _iconButtonTheme(),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: AppRadius.continuousLg(
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        shape: AppRadius.continuousXl(),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightSurface,
        shape: AppRadius.continuousLg(),
        elevation: 8,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.lightTextPrimary,
        contentTextStyle: const TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: AppRadius.continuousMd(),
      ),
    );
  }

  static ThemeData dark({Color accentColor = AppColors.primaryDark}) {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: accentColor,
      onPrimary: const Color(0xFF0A0C10),
      primaryContainer: accentColor.withValues(alpha: 0.18),
      onPrimaryContainer: Colors.white,
      secondary: const Color(0xFF94A3B8),
      onSecondary: const Color(0xFF0A0C10),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkBorderSubtle,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBg,
      inputDecorationTheme: _inputTheme(isDark: true, accentColor: accentColor),
      fontFamily: AppTypography.fontFamily,
      fontFamilyFallback: AppTypography.fontFallbacks,
      textTheme: _textTheme,
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: _standardButtonStyle()),
      filledButtonTheme: FilledButtonThemeData(style: _standardButtonStyle()),
      outlinedButtonTheme:
          OutlinedButtonThemeData(style: _standardButtonStyle()),
      textButtonTheme: TextButtonThemeData(style: _standardButtonStyle()),
      iconButtonTheme: _iconButtonTheme(),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: AppRadius.continuousLg(
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        shape: AppRadius.continuousXl(),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkSurfaceElevated,
        shape: AppRadius.continuousLg(),
        elevation: 8,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkSurfaceElevated,
        contentTextStyle: const TextStyle(color: AppColors.darkTextPrimary),
        behavior: SnackBarBehavior.floating,
        shape: AppRadius.continuousMd(),
      ),
    );
  }
}
