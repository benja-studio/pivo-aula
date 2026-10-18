import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/services/security_service.dart';
import '../features/profile/data/profile_repository.dart';
import '../features/security/presentation/lock_screen.dart';
import 'router.dart';
import 'theme.dart';

class AulaApp extends ConsumerStatefulWidget {
  final bool hasProfile;
  const AulaApp({super.key, required this.hasProfile});

  @override
  ConsumerState<AulaApp> createState() => _AulaAppState();
}

class _AulaAppState extends ConsumerState<AulaApp> with WidgetsBindingObserver {
  late final GoRouter _router;
  bool _isLocked = false;
  DateTime? _pausedAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _router = createRouter(hasProfile: widget.hasProfile);
    _checkInitialLock();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _checkInitialLock() async {
    final lockEnabled = await SecurityService.instance.isLockEnabled();
    if (lockEnabled && widget.hasProfile) {
      setState(() => _isLocked = true);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pausedAt = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      if (_pausedAt != null && widget.hasProfile) {
        final diff = DateTime.now().difference(_pausedAt!).inSeconds;
        // Lock after 15 seconds in background
        if (diff > 15) {
          SecurityService.instance.isLockEnabled().then((enabled) {
            if (enabled && mounted) {
              setState(() => _isLocked = true);
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileStreamProvider);
    final profile = profileAsync.value;

    final accentColor = profile != null
        ? Color(profile.accentColorValue)
        : const Color(0xFF3B5BFD);

    final themeMode = switch (profile?.themeMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };

    if (_isLocked) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(accentColor: accentColor),
        darkTheme: AppTheme.dark(accentColor: accentColor),
        themeMode: themeMode,
        home: LockScreen(
          onUnlocked: () => setState(() => _isLocked = false),
        ),
      );
    }

    return MaterialApp.router(
      title: 'Aula',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(accentColor: accentColor),
      darkTheme: AppTheme.dark(accentColor: accentColor),
      themeMode: themeMode,
      routerConfig: _router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'AR'),
        Locale('es', ''),
        Locale('en', ''),
      ],
      locale: const Locale('es', 'AR'),
    );
  }
}
