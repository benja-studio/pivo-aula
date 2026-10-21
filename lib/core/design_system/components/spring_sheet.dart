import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_colors.dart';
import '../app_radius.dart';
import '../app_scroll_physics.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

/// A stable, keyboard-aware modal sheet shared by Aula forms.
///
/// The system bottom-sheet route owns opening/closing and dragging. The content
/// itself does not use a second spring/drag animation, which caused jitter and
/// awkward keyboard interactions on Android.
class SpringSheet extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final bool showCloseButton;

  const SpringSheet({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.trailing,
    this.showCloseButton = false,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    String? subtitle,
    Widget? trailing,
    bool showCloseButton = false,
  }) {
    HapticFeedback.selectionClick();
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.48),
      useSafeArea: true,
      enableDrag: true,
      builder: (sheetContext) => SpringSheet(
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        showCloseButton: showCloseButton,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final background =
        isDark ? AppColors.darkSurfaceElevated : AppColors.lightSurface;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final mutedColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final shape = RoundedRectangleBorder(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppRadius.xl),
      ),
      side: BorderSide(color: borderColor, width: 1),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : mediaQuery.size.height;

        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: availableHeight * 0.94),
          child: Material(
            color: background,
            elevation: 12,
            shape: shape,
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: AppSpacing.xs),
                // A quiet visual handle: the route's native drag behavior is
                // used, avoiding a competing vertical-drag gesture.
                ExcludeSemantics(
                  child: SizedBox(
                    width: 64,
                    height: 22,
                    child: Center(
                      child: Container(
                        width: 34,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF465064)
                              : const Color(0xFFCBD5E1),
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                      ),
                    ),
                  ),
                ),
                if (title != null ||
                    subtitle != null ||
                    trailing != null ||
                    showCloseButton) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.sm,
                      AppSpacing.lg,
                      AppSpacing.md,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (title != null)
                                Text(
                                  title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.titleMedium.copyWith(
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              if (subtitle != null) ...[
                                const SizedBox(height: AppSpacing.xxs),
                                Text(
                                  subtitle!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: mutedColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (trailing != null) ...[
                          const SizedBox(width: AppSpacing.sm),
                          trailing!,
                        ],
                        if (showCloseButton) ...[
                          const SizedBox(width: AppSpacing.xs),
                          IconButton(
                            tooltip: 'Cerrar',
                            visualDensity: VisualDensity.standard,
                            iconSize: 20,
                            style: IconButton.styleFrom(
                              minimumSize: const Size(44, 44),
                              backgroundColor: isDark
                                  ? AppColors.darkSurface
                                  : AppColors.lightSurfaceElevated,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppRadius.md),
                              ),
                            ),
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: borderColor,
                  ),
                ],
                Flexible(
                  fit: FlexFit.loose,
                  child: SingleChildScrollView(
                    physics: appScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.lg,
                      AppSpacing.xl,
                      AppSpacing.xl + mediaQuery.padding.bottom,
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
