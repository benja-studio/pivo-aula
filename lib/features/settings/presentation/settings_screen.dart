import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import '../../../core/design_system/app_colors.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/app_typography.dart';
import '../../../core/design_system/components/app_card.dart';
import '../../../core/design_system/components/app_chip.dart';
import '../../../core/design_system/components/app_text_field.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/services/backup_service.dart';
import '../../../core/services/security_service.dart';
import '../../../core/l10n/app_strings.dart';
import '../../subjects/presentation/subject_form_preferences.dart';
import '../../profile/data/profile_repository.dart';
import '../../profile/presentation/avatar_view.dart';
import '../../profile/presentation/edit_profile_sheet.dart';
import '../../profile/presentation/profile_controller.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _lockEnabled = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSecurityStatus();
  }

  Future<void> _loadSecurityStatus() async {
    final lock = await SecurityService.instance.isLockEnabled();
    final bio = await SecurityService.instance.isBiometricEnabled();
    if (mounted) {
      setState(() {
        _lockEnabled = lock;
        _biometricEnabled = bio;
      });
    }
  }

  Future<void> _setupPinDialog() async {
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Configurar PIN'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Ingresá un PIN numérico de 4 dígitos para proteger la app.'),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: controller,
              keyboardType: TextInputType.number,
              obscureText: true,
              autofocus: true,
              hint: '4 dígitos',
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Guardar PIN'),
          ),
        ],
      ),
    );

    if (confirmed == true && controller.text.length == 4) {
      await SecurityService.instance.setPin(controller.text);
      await _loadSecurityStatus();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('PIN configurado con éxito.')),
        );
      }
    }
  }

  Future<void> _exportBackup() async {
    final passwordController = TextEditingController();
    bool usePassword = false;

    final proceed = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Exportar Respaldo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Se generará un archivo .aula con todas tus materias, exámenes, temas y calificaciones.',
              ),
              const SizedBox(height: AppSpacing.md),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Proteger con contraseña (AES-GCM)', style: AppTypography.titleSmall),
                value: usePassword,
                onChanged: (val) => setDialogState(() => usePassword = val ?? false),
              ),
              if (usePassword) ...[
                const SizedBox(height: AppSpacing.xs),
                AppTextField(
                  controller: passwordController,
                  obscureText: true,
                  hint: 'Ingresá una contraseña segura',
                ),
              ],
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Generar Respaldo'),
            ),
          ],
        ),
      ),
    );

    if (proceed == true) {
      try {
        final db = ref.read(appDatabaseProvider);
        final backupService = BackupService(db);
        final path = await backupService.exportBackup(
          password: usePassword ? passwordController.text : null,
        );
        await backupService.shareBackupFile(path);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al exportar: $e')),
          );
        }
      }
    }
  }

  Future<void> _importBackup() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.single.path == null) return;

    final filePath = result.files.single.path!;
    final passwordController = TextEditingController();

    if (!mounted) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restaurar Respaldo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Esta acción reemplazará los datos actuales con los del archivo de respaldo.',
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              controller: passwordController,
              obscureText: true,
              hint: 'Contraseña (si estaba cifrado)',
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Restaurar Datos', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        final db = ref.read(appDatabaseProvider);
        final backupService = BackupService(db);
        await backupService.restoreBackup(filePath, password: passwordController.text);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('¡Datos restaurados con éxito!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al restaurar: $e')),
          );
        }
      }
    }
  }

  Future<void> _clearAllData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Borrar todos los datos?'),
        content: const Text(
          'Esta acción es IRREVERSIBLE. Se eliminarán permanentemente todas tus materias, exámenes, notas y perfil.',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancelar')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sí, borrar todo', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final db = ref.read(appDatabaseProvider);
      await db.clearAllData();
      await SecurityService.instance.clearSecurity();
      if (mounted) {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final profileAsync = ref.watch(profileStreamProvider);
    final profile = profileAsync.value;
    final subjectFormPreferences = ref.watch(subjectFormPreferencesProvider);
    final subjectFormPreferencesController =
        ref.read(subjectFormPreferencesProvider.notifier);

    Widget subjectPreferenceTile({
      required String title,
      required String subtitle,
      required bool value,
      required ValueChanged<bool> onChanged,
    }) {
      return SwitchListTile.adaptive(
        contentPadding: EdgeInsets.zero,
        dense: true,
        title: Text(title, style: AppTypography.titleSmall),
        subtitle: Text(subtitle, style: AppTypography.caption),
        value: value,
        activeThumbColor: theme.colorScheme.primary,
        activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.45),
        onChanged: onChanged,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings, style: AppTypography.titleLarge),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        physics: const BouncingScrollPhysics(),
        children: [
          // Profile Card
          if (profile != null) ...[
            AppCard(
              child: Row(
                children: [
                  AvatarView(
                    photoPath: profile.photoPath,
                    name: profile.fullName,
                    size: 60,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(profile.fullName, style: AppTypography.titleMedium),
                        Text(
                          '${profile.career} · ${profile.university}',
                          style: AppTypography.caption.copyWith(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (profile.studentId != null)
                          Text('Legajo: ${profile.studentId}', style: AppTypography.caption),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () => EditProfileSheet.show(context, profile),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],

          // Visual Appearance Section
          Text('Apariencia', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.theme, style: AppTypography.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    AppChip(
                      label: 'Sistema',
                      isSelected: profile?.themeMode == 'system',
                      onTap: () => ref.read(profileControllerProvider.notifier).updateAppearance(themeMode: 'system'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    AppChip(
                      label: 'Claro',
                      isSelected: profile?.themeMode == 'light',
                      onTap: () => ref.read(profileControllerProvider.notifier).updateAppearance(themeMode: 'light'),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    AppChip(
                      label: 'Oscuro',
                      isSelected: profile?.themeMode == 'dark',
                      onTap: () => ref.read(profileControllerProvider.notifier).updateAppearance(themeMode: 'dark'),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                Text(AppStrings.accentColor, style: AppTypography.titleSmall),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: AppColors.accentOptions.map((c) {
                    final isSelected = c.toARGB32() == profile?.accentColorValue;
                    return GestureDetector(
                      onTap: () => ref
                          .read(profileControllerProvider.notifier)
                          .updateAppearance(accentColorValue: c.toARGB32()),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: c,
                          shape: BoxShape.circle,
                          border: isSelected ? Border.all(color: Colors.white, width: 2.5) : null,
                        ),
                        child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.md),

                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Reducir movimiento', style: AppTypography.titleSmall),
                  subtitle: const Text('Desactiva rebotes de springs y animaciones físicas', style: AppTypography.caption),
                  value: profile?.reduceMotion ?? false,
                  onChanged: (val) => ref
                      .read(profileControllerProvider.notifier)
                      .updateAppearance(reduceMotion: val),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Subject form preferences
          Text('Personalización de materias', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Elegí qué opciones querés mostrar al crear o editar una materia. '
                  'Los datos guardados no se borran al ocultar un campo.',
                  style: AppTypography.caption,
                ),
                const SizedBox(height: AppSpacing.sm),
                subjectPreferenceTile(
                  title: 'Selector de color',
                  subtitle: 'Mostrar los colores disponibles para cada materia',
                  value: subjectFormPreferences.showColorPicker,
                  onChanged: (value) => subjectFormPreferencesController.update(showColorPicker: value),
                ),
                const Divider(height: 1),
                subjectPreferenceTile(
                  title: 'Selector de ícono',
                  subtitle: 'Mostrar los íconos representativos',
                  value: subjectFormPreferences.showIconPicker,
                  onChanged: (value) => subjectFormPreferencesController.update(showIconPicker: value),
                ),
                const Divider(height: 1),
                subjectPreferenceTile(
                  title: 'Código',
                  subtitle: 'Código, abreviatura o identificador de la materia',
                  value: subjectFormPreferences.showCodeField,
                  onChanged: (value) => subjectFormPreferencesController.update(showCodeField: value),
                ),
                const Divider(height: 1),
                subjectPreferenceTile(
                  title: 'Profesor',
                  subtitle: 'Mostrar el campo de docente',
                  value: subjectFormPreferences.showProfessorField,
                  onChanged: (value) => subjectFormPreferencesController.update(showProfessorField: value),
                ),
                const Divider(height: 1),
                subjectPreferenceTile(
                  title: 'Aula o lugar',
                  subtitle: 'Mostrar dónde se cursa',
                  value: subjectFormPreferences.showClassroomField,
                  onChanged: (value) => subjectFormPreferencesController.update(showClassroomField: value),
                ),
                const Divider(height: 1),
                subjectPreferenceTile(
                  title: 'Créditos',
                  subtitle: 'Mostrar la cantidad de créditos',
                  value: subjectFormPreferences.showCreditsField,
                  onChanged: (value) => subjectFormPreferencesController.update(showCreditsField: value),
                ),
                const Divider(height: 1),
                subjectPreferenceTile(
                  title: 'Estado académico',
                  subtitle: 'Cursando, regular, aprobada, libre o recursando',
                  value: subjectFormPreferences.showStatusSelector,
                  onChanged: (value) => subjectFormPreferencesController.update(showStatusSelector: value),
                ),
                const Divider(height: 1),
                subjectPreferenceTile(
                  title: 'Nota mínima para aprobar',
                  subtitle: 'Mostrar el ajuste de la calificación mínima',
                  value: subjectFormPreferences.showPassingGrade,
                  onChanged: (value) => subjectFormPreferencesController.update(showPassingGrade: value),
                ),
                const Divider(height: 1),
                subjectPreferenceTile(
                  title: 'Notas y comentarios',
                  subtitle: 'Mostrar el campo de observaciones de la materia',
                  value: subjectFormPreferences.showNotesField,
                  onChanged: (value) => subjectFormPreferencesController.update(showNotesField: value),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Security Section
          Text('Seguridad y Privacidad', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              children: [
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Bloqueo de aplicación con PIN', style: AppTypography.titleSmall),
                  subtitle: const Text('Solicita PIN al abrir o regresar a la app', style: AppTypography.caption),
                  value: _lockEnabled,
                  onChanged: (val) async {
                    if (val) {
                      await _setupPinDialog();
                    } else {
                      await SecurityService.instance.clearSecurity();
                      await _loadSecurityStatus();
                    }
                  },
                ),
                if (_lockEnabled) ...[
                  Divider(height: 1, color: isDark ? const Color(0xFF262A32) : const Color(0xFFF3F4F6)),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Desbloqueo Biométrico', style: AppTypography.titleSmall),
                    subtitle: const Text('Huella dactilar o reconocimiento facial', style: AppTypography.caption),
                    value: _biometricEnabled,
                    onChanged: (val) async {
                      await SecurityService.instance.setBiometricEnabled(val);
                      await _loadSecurityStatus();
                    },
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Backups & Restore Section
          Text('Respaldos y Restauración', style: AppTypography.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.file_upload_outlined, color: Colors.blue),
                  title: const Text('Exportar respaldo', style: AppTypography.titleSmall),
                  subtitle: const Text('Generá un archivo ZIP cifrado o abierto para compartir o guardar en Drive'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: _exportBackup,
                ),
                Divider(height: 1, color: isDark ? const Color(0xFF262A32) : const Color(0xFFF3F4F6)),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.file_download_outlined, color: Colors.green),
                  title: const Text('Importar / Restaurar respaldo', style: AppTypography.titleSmall),
                  subtitle: const Text('Cargá un archivo .aula previo para recuperar tus datos'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: _importBackup,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          // About & Danger Zone
          Text('Zona Peligrosa', style: AppTypography.titleMedium.copyWith(color: Colors.red)),
          const SizedBox(height: AppSpacing.sm),
          AppCard(
            border: const BorderSide(color: Colors.red, width: 1),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.delete_forever_rounded, color: Colors.red),
              title: const Text('Borrar todos los datos', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              subtitle: const Text('Elimina perfil, materias, exámenes y notas de este dispositivo'),
              onTap: _clearAllData,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // App Info footer
          Center(
            child: Text(
              'Aula v1.0.0 · 100% Offline & Privada',
              style: AppTypography.caption.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
