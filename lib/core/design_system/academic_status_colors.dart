import 'package:flutter/material.dart';

/// Colores semánticos para badges e indicadores académicos.
@immutable
class AcademicStatusColors extends ThemeExtension<AcademicStatusColors> {
  const AcademicStatusColors({
    required this.approved,
    required this.inProgress,
    required this.regular,
    required this.failed,
    required this.pending,
    required this.approvedContainer,
    required this.inProgressContainer,
    required this.regularContainer,
    required this.failedContainer,
    required this.pendingContainer,
  });

  final Color approved;
  final Color inProgress;
  final Color regular;
  final Color failed;
  final Color pending;

  final Color approvedContainer;
  final Color inProgressContainer;
  final Color regularContainer;
  final Color failedContainer;
  final Color pendingContainer;

  static const light = AcademicStatusColors(
    approved: Color(0xFF10B981),
    inProgress: Color(0xFF3B82F6),
    regular: Color(0xFFF59E0B),
    failed: Color(0xFFEF4444),
    pending: Color(0xFF6B7280),
    approvedContainer: Color(0xFFECFDF5),
    inProgressContainer: Color(0xFFEFF6FF),
    regularContainer: Color(0xFFFFFBEB),
    failedContainer: Color(0xFFFEF2F2),
    pendingContainer: Color(0xFFF3F4F6),
  );

  static const dark = AcademicStatusColors(
    approved: Color(0xFF34D399),
    inProgress: Color(0xFF60A5FA),
    regular: Color(0xFFFBBF24),
    failed: Color(0xFFF87171),
    pending: Color(0xFF6B7280),
    approvedContainer: Color(0xFF064E3B),
    inProgressContainer: Color(0xFF172554),
    regularContainer: Color(0xFF451A03),
    failedContainer: Color(0xFF450A0A),
    pendingContainer: Color(0xFF1F2937),
  );

  @override
  AcademicStatusColors copyWith({
    Color? approved,
    Color? inProgress,
    Color? regular,
    Color? failed,
    Color? pending,
    Color? approvedContainer,
    Color? inProgressContainer,
    Color? regularContainer,
    Color? failedContainer,
    Color? pendingContainer,
  }) => AcademicStatusColors(
    approved: approved ?? this.approved,
    inProgress: inProgress ?? this.inProgress,
    regular: regular ?? this.regular,
    failed: failed ?? this.failed,
    pending: pending ?? this.pending,
    approvedContainer: approvedContainer ?? this.approvedContainer,
    inProgressContainer: inProgressContainer ?? this.inProgressContainer,
    regularContainer: regularContainer ?? this.regularContainer,
    failedContainer: failedContainer ?? this.failedContainer,
    pendingContainer: pendingContainer ?? this.pendingContainer,
  );

  @override
  AcademicStatusColors lerp(ThemeExtension<AcademicStatusColors>? other, double t) {
    if (other is! AcademicStatusColors) return this;
    return AcademicStatusColors(
      approved: Color.lerp(approved, other.approved, t)!,
      inProgress: Color.lerp(inProgress, other.inProgress, t)!,
      regular: Color.lerp(regular, other.regular, t)!,
      failed: Color.lerp(failed, other.failed, t)!,
      pending: Color.lerp(pending, other.pending, t)!,
      approvedContainer: Color.lerp(approvedContainer, other.approvedContainer, t)!,
      inProgressContainer: Color.lerp(inProgressContainer, other.inProgressContainer, t)!,
      regularContainer: Color.lerp(regularContainer, other.regularContainer, t)!,
      failedContainer: Color.lerp(failedContainer, other.failedContainer, t)!,
      pendingContainer: Color.lerp(pendingContainer, other.pendingContainer, t)!,
    );
  }
}
