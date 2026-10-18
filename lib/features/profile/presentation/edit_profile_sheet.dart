import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/design_system/app_spacing.dart';
import '../../../core/design_system/components/app_button.dart';
import '../../../core/design_system/components/app_text_field.dart';
import '../../../core/design_system/components/spring_sheet.dart';
import '../../../core/l10n/app_strings.dart';
import '../domain/student_profile.dart';
import 'avatar_view.dart';
import 'profile_controller.dart';

class EditProfileSheet extends ConsumerStatefulWidget {
  final StudentProfile profile;
  const EditProfileSheet({super.key, required this.profile});

  static Future<void> show(BuildContext context, StudentProfile profile) {
    return SpringSheet.show(
      context: context,
      title: 'Editar Perfil',
      child: EditProfileSheet(profile: profile),
    );
  }

  @override
  ConsumerState<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<EditProfileSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _careerController;
  late final TextEditingController _universityController;
  late final TextEditingController _yearController;
  late final TextEditingController _periodController;
  late final TextEditingController _studentIdController;
  late final TextEditingController _emailController;
  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.fullName);
    _careerController = TextEditingController(text: widget.profile.career);
    _universityController = TextEditingController(text: widget.profile.university);
    _yearController = TextEditingController(text: widget.profile.currentYear);
    _periodController = TextEditingController(text: widget.profile.currentPeriod);
    _studentIdController = TextEditingController(text: widget.profile.studentId ?? '');
    _emailController = TextEditingController(text: widget.profile.email ?? '');
    _photoPath = widget.profile.photoPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _careerController.dispose();
    _universityController.dispose();
    _yearController.dispose();
    _periodController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    final controller = ref.read(profileControllerProvider.notifier);
    final path = await controller.pickAndSaveImage(source);
    if (path != null) {
      setState(() => _photoPath = path);
    }
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty) return;

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
      themeMode: widget.profile.themeMode,
      accentColorValue: widget.profile.accentColorValue,
      gradeScale: widget.profile.gradeScale,
      passingGrade: widget.profile.passingGrade,
      remindersEnabled: widget.profile.remindersEnabled,
      biometricEnabled: widget.profile.biometricEnabled,
      reduceMotion: widget.profile.reduceMotion,
    );

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Column(
            children: [
              AvatarView(
                photoPath: _photoPath,
                name: _nameController.text.isEmpty ? 'A' : _nameController.text,
                size: 80,
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () => _pickPhoto(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined, size: 16),
                    label: const Text('Galería'),
                  ),
                  TextButton.icon(
                    onPressed: () => _pickPhoto(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt_outlined, size: 16),
                    label: const Text('Cámara'),
                  ),
                  if (_photoPath != null)
                    TextButton(
                      onPressed: () => setState(() => _photoPath = null),
                      child: const Text('Quitar', style: TextStyle(color: Colors.red)),
                    ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _nameController,
          label: AppStrings.fullName,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _careerController,
          label: AppStrings.career,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _universityController,
          label: AppStrings.university,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                controller: _yearController,
                label: AppStrings.currentYear,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                controller: _periodController,
                label: AppStrings.currentPeriod,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _studentIdController,
          label: AppStrings.studentId,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          controller: _emailController,
          label: AppStrings.email,
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: AppStrings.save,
          onPressed: _save,
          isExpanded: true,
          height: 48,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }
}
