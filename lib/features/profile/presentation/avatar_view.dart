import 'dart:io';
import 'package:flutter/material.dart';
import '../../../core/design_system/app_radius.dart';
import '../../../core/design_system/app_typography.dart';

class AvatarView extends StatelessWidget {
  final String? photoPath;
  final String name;
  final double size;
  final VoidCallback? onTap;

  const AvatarView({
    super.key,
    this.photoPath,
    required this.name,
    this.size = 56.0,
    this.onTap,
  });

  String _getInitials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return 'A';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initials = _getInitials(name);

    Widget avatar;
    if (photoPath != null && photoPath!.isNotEmpty && File(photoPath!).existsSync()) {
      avatar = ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.4),
        child: Image.file(
          File(photoPath!),
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    } else {
      avatar = Container(
        width: size,
        height: size,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withValues(alpha: 0.75),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: AppRadius.continuousMd(),
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: AppTypography.titleMedium.copyWith(
            color: Colors.white,
            fontSize: size * 0.38,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }
    return avatar;
  }
}
