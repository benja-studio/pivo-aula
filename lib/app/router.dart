import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../core/design_system/app_colors.dart';
import '../core/design_system/app_radius.dart';
import '../core/design_system/app_spacing.dart';
import '../core/design_system/app_motion.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/calendar/presentation/calendar_screen.dart';
import '../features/subjects/presentation/subjects_screen.dart';
import '../features/subjects/presentation/subject_detail_screen.dart';
import '../features/exams/presentation/exam_detail_screen.dart';
import '../features/grades/presentation/grades_screen.dart';
import '../features/search/presentation/global_search_screen.dart';
import '../features/settings/presentation/settings_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter({required bool hasProfile}) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: hasProfile ? '/home' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) =>
            _animatedPage(context, state, const OnboardingScreen()),
      ),
      GoRoute(
        path: '/search',
        pageBuilder: (context, state) =>
            _animatedPage(context, state, const GlobalSearchScreen()),
      ),
      GoRoute(
        path: '/subjects/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return _animatedPage(context, state, SubjectDetailScreen(subjectId: id));
        },
      ),
      GoRoute(
        path: '/exams/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return _animatedPage(context, state, ExamDetailScreen(examId: id));
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calendar',
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/subjects',
                builder: (context, state) => const SubjectsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/grades',
                builder: (context, state) => const GradesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

CustomTransitionPage<void> _animatedPage(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration:
        reduceMotion ? Duration.zero : AppMotion.routeDuration,
    reverseTransitionDuration:
        reduceMotion ? Duration.zero : AppMotion.routeReverseDuration,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      final slide = Tween<Offset>(
        begin: const Offset(0, 0.025),
        end: Offset.zero,
      ).animate(curved);

      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: slide,
          child: child,
        ),
      );
    },
  );
}

class _ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _ScaffoldWithNavBar({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBody: false,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          child: Container(
            decoration: ShapeDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                side: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1,
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _NavBarItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    label: 'Inicio',
                    isSelected: navigationShell.currentIndex == 0,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      navigationShell.goBranch(0);
                    },
                  ),
                ),
                Expanded(
                  child: _NavBarItem(
                    icon: Icons.calendar_month_outlined,
                    activeIcon: Icons.calendar_month_rounded,
                    label: 'Agenda',
                    isSelected: navigationShell.currentIndex == 1,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      navigationShell.goBranch(1);
                    },
                  ),
                ),
                Expanded(
                  child: _NavBarItem(
                    icon: Icons.menu_book_outlined,
                    activeIcon: Icons.menu_book_rounded,
                    label: 'Materias',
                    isSelected: navigationShell.currentIndex == 2,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      navigationShell.goBranch(2);
                    },
                  ),
                ),
                Expanded(
                  child: _NavBarItem(
                    icon: Icons.insights_outlined,
                    activeIcon: Icons.insights_rounded,
                    label: 'Notas',
                    isSelected: navigationShell.currentIndex == 3,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      navigationShell.goBranch(3);
                    },
                  ),
                ),
                Expanded(
                  child: _NavBarItem(
                    icon: Icons.tune_outlined,
                    activeIcon: Icons.tune_rounded,
                    label: 'Ajustes',
                    isSelected: navigationShell.currentIndex == 4,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      navigationShell.goBranch(4);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final color = isSelected
        ? primary
        : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary);
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final animationDuration =
        reduceMotion ? Duration.zero : AppMotion.selectionDuration;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 62),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: animationDuration,
                    curve: Curves.easeOutCubic,
                    width: 42,
                    height: 30,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primary.withValues(alpha: isDark ? 0.22 : 0.10)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      border: Border.all(
                        color: isSelected
                            ? primary.withValues(alpha: isDark ? 0.42 : 0.22)
                            : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: reduceMotion
                            ? Duration.zero
                            : AppMotion.iconSwitchDuration,
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder: (child, animation) {
                          final scale = Tween<double>(
                            begin: 0.82,
                            end: 1,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOutCubic,
                          ));
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(scale: scale, child: child),
                          );
                        },
                        child: Icon(
                          key: ValueKey<bool>(isSelected),
                          isSelected ? activeIcon : icon,
                          color: color,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: animationDuration,
                    curve: Curves.easeOutCubic,
                    style: TextStyle(
                      color: color,
                      fontSize: 10.5,
                      height: 1.1,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                      letterSpacing: 0.05,
                    ),
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
