import 'package:flutter/material.dart';
import '../core/design_system/app_colors.dart';
import '../core/design_system/app_radius.dart';
import '../core/design_system/app_spacing.dart';
import '../core/design_system/app_typography.dart';
import '../core/design_system/academic_status_colors.dart';

/// Sistema de diseño global Material 3 para Aula.
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

  static ButtonStyle _buttonStyle(Color foreground, Color background) => ButtonStyle(
    minimumSize: const WidgetStatePropertyAll(Size(0, 48)),
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 14),
    ),
    tapTargetSize: MaterialTapTargetSize.padded,
    textStyle: const WidgetStatePropertyAll(AppTypography.button),
    foregroundColor: WidgetStatePropertyAll(foreground),
    backgroundColor: WidgetStatePropertyAll(background),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  static IconButtonThemeData _iconButtonTheme() => IconButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(44, 44)),
      tapTargetSize: MaterialTapTargetSize.padded,
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );

  static InputDecorationTheme _inputTheme({required bool isDark}) {
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final fillColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;

    OutlineInputBorder outline(BorderSide side) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: side,
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: outline(BorderSide(color: borderColor)),
      enabledBorder: outline(BorderSide(color: borderColor)),
      focusedBorder: outline(BorderSide(color: isDark ? AppColors.primaryDark : AppColors.primary, width: 1.7)),
      errorBorder: outline(const BorderSide(color: AppColors.error)),
      focusedErrorBorder: outline(const BorderSide(color: AppColors.error, width: 1.7)),
    );
  }

  static ColorScheme _scheme({required bool isDark}) {
    if (isDark) {
      return const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryDark,
        onPrimary: Color(0xFF090D16),
        primaryContainer: Color(0xFF252A55),
        onPrimaryContainer: Color(0xFFE0E7FF),
        secondary: AppColors.secondaryDark,
        onSecondary: Color(0xFF082F49),
        secondaryContainer: Color(0xFF12334A),
        onSecondaryContainer: Color(0xFFE0F2FE),
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        surfaceContainerLowest: Color(0xFF090D16),
        surfaceContainerLow: Color(0xFF111827),
        surfaceContainer: Color(0xFF111827),
        surfaceContainerHigh: Color(0xFF1F2937),
        surfaceContainerHighest: Color(0xFF273244),
        error: Color(0xFFF87171),
        onError: Color(0xFF450A0A),
        outline: AppColors.darkBorder,
        outlineVariant: AppColors.darkBorderSubtle,
      );
    }

    return const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFEEF2FF),
      onPrimaryContainer: Color(0xFF3730A3),
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE0F2FE),
      onSecondaryContainer: Color(0xFF075985),
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Color(0xFFFCFDFE),
      surfaceContainer: Color(0xFFF8FAFC),
      surfaceContainerHigh: Color(0xFFF1F5F9),
      surfaceContainerHighest: Color(0xFFE2E8F0),
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.lightBorder,
      outlineVariant: AppColors.lightBorderSubtle,
    );
  }

  static ThemeData light({Color accentColor = AppColors.primary}) {
    final scheme = _scheme(isDark: false).copyWith(primary: accentColor);
    return _buildTheme(
      scheme: scheme,
      isDark: false,
    );
  }

  static ThemeData dark({Color accentColor = AppColors.primaryDark}) {
    final scheme = _scheme(isDark: true).copyWith(primary: accentColor);
    return _buildTheme(
      scheme: scheme,
      isDark: true,
    );
  }

  static ThemeData _buildTheme({required ColorScheme scheme, required bool isDark}) {
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final surfaceColor = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final subtleShadow = isDark
        ? const <BoxShadow>[]
        : [
            BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.035),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ];

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      canvasColor: surfaceColor,
      fontFamily: AppTypography.fontFamily,
      fontFamilyFallback: AppTypography.fontFallbacks,
      textTheme: _textTheme.apply(
        bodyColor: textColor,
        displayColor: textColor,
      ),
      extensions: <ThemeExtension<dynamic>>[
        isDark ? AcademicStatusColors.dark : AcademicStatusColors.light,
      ],
      inputDecorationTheme: _inputTheme(isDark: isDark),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _buttonStyle(scheme.onPrimary, scheme.primary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: _buttonStyle(scheme.onPrimary, scheme.primary),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _buttonStyle(scheme.primary, Colors.transparent).copyWith(
          side: WidgetStatePropertyAll(BorderSide(color: scheme.outline)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: _buttonStyle(scheme.primary, Colors.transparent),
      ),
      iconButtonTheme: _iconButtonTheme(),
      dividerTheme: DividerThemeData(color: borderColor, thickness: 1, space: 1),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
        foregroundColor: textColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: textColor),
        iconTheme: IconThemeData(color: textColor),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        modalBackgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: borderColor),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: isDark ? 0 : 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightTextPrimary,
        contentTextStyle: TextStyle(color: isDark ? AppColors.darkTextPrimary : Colors.white),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: surfaceColor,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surfaceColor,
        elevation: 0,
        indicatorColor: scheme.primary.withValues(alpha: isDark ? 0.22 : 0.12),
        labelTextStyle: const WidgetStatePropertyAll(AppTypography.label),
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: BorderSide(color: borderColor),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        labelStyle: AppTypography.label.copyWith(color: textColor),
        backgroundColor: surfaceColor,
        selectedColor: scheme.primary.withValues(alpha: 0.12),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.primary,
        textColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
