import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/design_system/app_colors.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_scroll_physics.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/app_chip.dart';
import '../../../core/design_system/components/app_text_field.dart';
import '../../../core/l10n/app_strings.dart';
import '../../../core/services/backup_service.dart';
import '../../profile/presentation/academic_unit_autocomplete_field.dart';
import '../../profile/presentation/avatar_view.dart';
import '../../profile/presentation/profile_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isRestoringBackup = false;
  List<File> _localBackups = const [];

  // Form Fields
  final _nameController = TextEditingController();
  final _careerController = TextEditingController();
  final _universityController = TextEditingController();
  final _yearController = TextEditingController(text: '1er año');
  final _periodController = TextEditingController(text: '1er Cuatrimestre 2026');
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();

  String? _photoPath;
  String _themeMode = 'system';
  int _accentColorValue = 0xFF3B5BFD;
  String _gradeScale = '1-10';
  double _passingGrade = 4.0;
  bool _remindersEnabled = true;

  // Validation
  String? _nameError;
  String? _careerError;
  String? _universityError;


  @override
  void initState() {
    super.initState();
    _refreshLocalBackups();
  }

  Future<void> _refreshLocalBackups() async {
    try {
      final backups = await BackupService(ref.read(appDatabaseProvider)).listLocalBackups();
      if (mounted) setState(() => _localBackups = backups);
    } catch (_) {
      if (mounted) setState(() => _localBackups = const []);
    }
  }

  String _localBackupDate(File file) {
    final date = file.lastModifiedSync();
    String twoDigits(int value) => value.toString().padLeft(2, '0');
    return '${twoDigits(date.day)}/${twoDigits(date.month)}/${date.year} · ${twoDigits(date.hour)}:${twoDigits(date.minute)}';
  }

  Future<String?> _askBackupPassword() async {
    final controller = TextEditingController();
    final password = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Respaldo protegido'),
        content: AppTextField(
          controller: controller,
          label: 'Contraseña del respaldo',
          hint: 'Ingresá la contraseña usada al exportar',
          obscureText: true,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text),
            child: const Text('Desbloquear'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (password == null) return null;
    if (password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ingresá la contraseña para abrir este respaldo.')),
        );
      }
      return null;
    }
    return password;
  }

  Future<void> _restoreBackupFile() async {
    if (_isRestoringBackup) return;

    File? stagedFile;
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['aula', 'zip'],
        allowMultiple: false,
        withData: true,
      );
      if (result == null || result.files.isEmpty || !mounted) return;

      final selectedFile = result.files.single;
      final selectedPath = selectedFile.path;
      late final String backupPath;

      // Android document providers can return a content URI without a usable
      // filesystem path. Prefer the normal path when available; otherwise
      // stage the bytes in the app's private temporary directory.
      if (selectedPath != null &&
          selectedPath.isNotEmpty &&
          await File(selectedPath).exists()) {
        backupPath = selectedPath;
      } else {
        final bytes = selectedFile.bytes;
        if (bytes == null || bytes.isEmpty) {
          throw Exception(
            'Android no pudo leer el archivo seleccionado. '
            'Probá elegirlo desde la aplicación Archivos o Descargas.',
          );
        }

        final tempDirectory = await getTemporaryDirectory();
        stagedFile = File(
          '${tempDirectory.path}${Platform.pathSeparator}'
          'aula_import_${DateTime.now().microsecondsSinceEpoch}.aula',
        );
        await stagedFile.writeAsBytes(bytes, flush: true);
        backupPath = stagedFile.path;
      }

      if (!mounted) return;
      setState(() => _isRestoringBackup = true);

      final service = BackupService(ref.read(appDatabaseProvider));
      final encrypted = await service.backupRequiresPassword(backupPath);
      final password = encrypted ? await _askBackupPassword() : null;
      if (encrypted && password == null) return;

      await service.restoreBackup(backupPath, password: password);
      await _finishRestoreFlow();
    } catch (error) {
      if (mounted) {
        final message = error.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo restaurar el respaldo: $message')),
        );
      }
    } finally {
      if (stagedFile != null) {
        try {
          if (await stagedFile.exists()) await stagedFile.delete();
        } catch (_) {
          // Temporary-file cleanup must not hide the restore result.
        }
      }
      if (mounted && _isRestoringBackup) {
        setState(() => _isRestoringBackup = false);
      }
    }
  }

  Future<void> _restoreLocalSnapshot() async {
    if (_isRestoringBackup || _localBackups.isEmpty) return;
    final selected = await showDialog<File>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Copias guardadas en este dispositivo'),
        content: SizedBox(
          width: 360,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _localBackups.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final file = _localBackups[index];
                final size = file.lengthSync();
                final sizeLabel = size > 1024 * 1024
                    ? '${(size / (1024 * 1024)).toStringAsFixed(1)} MB'
                    : '${(size / 1024).toStringAsFixed(0)} KB';
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.history_rounded),
                  title: Text(_localBackupDate(file)),
                  subtitle: Text('$sizeLabel · Copia local'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.of(ctx).pop(file),
                );
              },
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancelar')),
        ],
      ),
    );
    if (selected == null || !mounted) return;

    setState(() => _isRestoringBackup = true);
    try {
      await BackupService(ref.read(appDatabaseProvider)).restoreLocalBackup(selected.path);
      await _finishRestoreFlow();
    } catch (error) {
      if (mounted) {
        final message = error.toString().replaceFirst('Exception: ', '');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo recuperar la copia local: $message')),
        );
      }
    } finally {
      if (mounted) setState(() => _isRestoringBackup = false);
    }
  }

  Future<void> _finishRestoreFlow() async {
    final profile = await ref.read(appDatabaseProvider).getProfile();
    if (!mounted) return;
    if (profile != null) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Los datos se recuperaron. Completá el perfil para seguir; tus materias y notas se conservaron.'),
          duration: Duration(seconds: 5),
        ),
      );
      await _refreshLocalBackups();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _careerController.dispose();
    _universityController.dispose();
    _yearController.dispose();
    _periodController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage == 1) {
      // Validate page 1
      bool hasError = false;
      setState(() {
        if (_nameController.text.trim().isEmpty) {
          _nameError = 'Ingresá tu nombre y apellido';
          hasError = true;
        } else {
          _nameError = null;
        }
        if (_careerController.text.trim().isEmpty) {
          _careerError = 'Ingresá tu carrera';
          hasError = true;
        } else {
          _careerError = null;
        }
        if (_universityController.text.trim().isEmpty) {
          _universityError = 'Ingresá tu universidad o facultad';
          hasError = true;
        } else {
          _universityError = null;
        }
      });
      if (hasError) return;
    }

    if (_currentPage < 3) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOutCubic,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final controller = ref.read(profileControllerProvider.notifier);
    final path = await controller.pickAndSaveImage(source);
    if (path != null) {
      setState(() {
        _photoPath = path;
      });
    }
  }

  Future<void> _finishOnboarding() async {
    final controller = ref.read(profileControllerProvider.notifier);
    await controller.saveProfile(
      fullName: _nameController.text,
      career: _careerController.text,
      university: _universityController.text,
      currentYear: _yearController.text,
      currentPeriod: _periodController.text,
      studentId: _studentIdController.text.isEmpty ? null : _studentIdController.text,
      email: _emailController.text.isEmpty ? null : _emailController.text,
      photoPath: _photoPath,
      themeMode: _themeMode,
      accentColorValue: _accentColorValue,
      gradeScale: _gradeScale,
      passingGrade: _passingGrade,
      remindersEnabled: _remindersEnabled,
    );

    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation & Step Indicator
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded),
                      onPressed: _previousPage,
                    )
                  else
                    const SizedBox(width: 48),
                  const Spacer(),
                  // Progress Dots
                  Row(
                    children: List.generate(4, (index) {
                      final isActive = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: isActive ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isActive
                              ? theme.colorScheme.primary
                              : (isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB)),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      );
                    }),
                  ),
                  const Spacer(),
                  if (_currentPage == 2)
                    TextButton(
                      onPressed: _nextPage,
                      child: const Text(AppStrings.skipBtn),
                    )
                  else
                    const SizedBox(width: 48),
                ],
              ),
            ),
            // Page Content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildWelcomePage(theme, isDark),
                  _buildDataPage(theme, isDark),
                  _buildPhotoPage(theme, isDark),
                  _buildPreferencesPage(theme, isDark),
                ],
              ),
            ),
            // Bottom Action
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    label: _currentPage == 3 ? AppStrings.finishBtn : AppStrings.continueBtn,
                    onPressed: _isRestoringBackup ? null : _nextPage,
                    isExpanded: true,
                    height: 52,
                  ),
                  if (_currentPage == 0) ...[
                    const SizedBox(height: AppSpacing.xs),
                    TextButton.icon(
                      onPressed: _isRestoringBackup ? null : _restoreBackupFile,
                      icon: _isRestoringBackup
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.folder_open_rounded, size: 18),
                      label: Text(_isRestoringBackup ? 'Restaurando respaldo…' : 'Ya uso Aula · Restaurar respaldo'),
                    ),
                    if (_localBackups.isNotEmpty)
                      TextButton.icon(
                        onPressed: _isRestoringBackup ? null : _restoreLocalSnapshot,
                        icon: const Icon(Icons.history_rounded, size: 18),
                        label: Text('Recuperar copia local (${_localBackups.length})'),
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomePage(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary, const Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: AppRadius.continuousXl(),
              shadows: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.school_rounded,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            AppStrings.appName,
            style: AppTypography.display.copyWith(
              color: isDark ? Colors.white : const Color(0xFF111827),
              fontSize: 38,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            AppStrings.welcomeTitle,
            textAlign: TextAlign.center,
            style: AppTypography.titleMedium.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            AppStrings.welcomeSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataPage(ThemeData theme, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      physics: appScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.studentDataTitle,
            style: AppTypography.titleLarge.copyWith(
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            AppStrings.studentDataSubtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            controller: _nameController,
            label: AppStrings.fullName,
            hint: AppStrings.fullNameHint,
            errorText: _nameError,
            prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
            onChanged: (val) {
              if (_nameError != null && val.trim().isNotEmpty) {
                setState(() => _nameError = null);
              }
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _careerController,
            label: AppStrings.career,
            hint: AppStrings.careerHint,
            errorText: _careerError,
            prefixIcon: const Icon(Icons.school_outlined, size: 20),
            onChanged: (val) {
              if (_careerError != null && val.trim().isNotEmpty) {
                setState(() => _careerError = null);
              }
            },
          ),
          const SizedBox(height: AppSpacing.md),
          AcademicUnitAutocompleteField(
            controller: _universityController,
            label: AppStrings.university,
            hint: 'Buscá una universidad, facultad o instituto',
            errorText: _universityError,
            onChanged: (value) {
              if (_universityError != null && value.trim().isNotEmpty) {
                setState(() => _universityError = null);
              }
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: _yearController,
                  label: AppStrings.currentYear,
                  hint: AppStrings.currentYearHint,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  controller: _periodController,
                  label: AppStrings.currentPeriod,
                  hint: AppStrings.currentPeriodHint,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _studentIdController,
            label: AppStrings.studentId,
            hint: AppStrings.studentIdHint,
            prefixIcon: const Icon(Icons.badge_outlined, size: 20),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _emailController,
            label: AppStrings.email,
            hint: AppStrings.emailHint,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildPhotoPage(ThemeData theme, bool isDark) {
    final displayName = _nameController.text.isNotEmpty ? _nameController.text : 'Estudiante';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarView(
              photoPath: _photoPath,
              name: displayName,
              size: 110,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              AppStrings.profilePhoto,
              style: AppTypography.titleLarge.copyWith(
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Podés elegir una foto de perfil o usar tus iniciales.',
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  label: AppStrings.choosePhoto,
                  icon: Icons.photo_library_outlined,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => _pickPhoto(ImageSource.gallery),
                ),
                const SizedBox(width: AppSpacing.md),
                AppButton(
                  label: AppStrings.takePhoto,
                  icon: Icons.camera_alt_outlined,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => _pickPhoto(ImageSource.camera),
                ),
              ],
            ),
            if (_photoPath != null) ...[
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => setState(() => _photoPath = null),
                child: Text(
                  AppStrings.removePhoto,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesPage(ThemeData theme, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      physics: appScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.preferencesTitle,
            style: AppTypography.titleLarge.copyWith(
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            AppStrings.preferencesSubtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Theme selection
          Text(AppStrings.theme, style: AppTypography.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              AppChip(
                label: 'Sistema',
                isSelected: _themeMode == 'system',
                icon: const Icon(Icons.brightness_auto, size: 16),
                onTap: () => setState(() => _themeMode = 'system'),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppChip(
                label: 'Claro',
                isSelected: _themeMode == 'light',
                icon: const Icon(Icons.light_mode_outlined, size: 16),
                onTap: () => setState(() => _themeMode = 'light'),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppChip(
                label: 'Oscuro',
                isSelected: _themeMode == 'dark',
                icon: const Icon(Icons.dark_mode_outlined, size: 16),
                onTap: () => setState(() => _themeMode = 'dark'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Accent color
          Text(AppStrings.accentColor, style: AppTypography.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: AppColors.accentOptions.map((c) {
              final isSelected = c.toARGB32() == _accentColorValue;
              return GestureDetector(
                onTap: () => setState(() => _accentColorValue = c.toARGB32()),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: isSelected
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: c.withValues(alpha: 0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 20)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Grade scale
          Text(AppStrings.gradeScale, style: AppTypography.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              AppChip(
                label: '1 a 10',
                isSelected: _gradeScale == '1-10',
                onTap: () => setState(() {
                  _gradeScale = '1-10';
                  _passingGrade = 4.0;
                }),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppChip(
                label: '0 a 100',
                isSelected: _gradeScale == '0-100',
                onTap: () => setState(() {
                  _gradeScale = '0-100';
                  _passingGrade = 60.0;
                }),
              ),
              const SizedBox(width: AppSpacing.sm),
              AppChip(
                label: 'A - F',
                isSelected: _gradeScale == 'A-F',
                onTap: () => setState(() {
                  _gradeScale = 'A-F';
                  _passingGrade = 4.0;
                }),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Passing grade slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.passingGrade, style: AppTypography.titleSmall),
              Text(
                _passingGrade.toStringAsFixed(1),
                style: AppTypography.titleMedium.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          Slider(
            value: _passingGrade,
            min: _gradeScale == '0-100' ? 40 : 1,
            max: _gradeScale == '0-100' ? 80 : 7,
            divisions: _gradeScale == '0-100' ? 8 : 12,
            activeColor: theme.colorScheme.primary,
            onChanged: (val) => setState(() => _passingGrade = val),
          ),
          const SizedBox(height: AppSpacing.md),

          // Reminders toggle
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            value: _remindersEnabled,
            activeThumbColor: theme.colorScheme.primary,
            activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.5),
            title: const Text(AppStrings.enableNotifications, style: AppTypography.titleSmall),
            subtitle: const Text('Recordatorio 1 día antes y la mañana del examen', style: AppTypography.caption),
            onChanged: (val) => setState(() => _remindersEnabled = val),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
