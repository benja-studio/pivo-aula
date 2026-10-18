enum SubjectStatus {
  enrolled,
  regular,
  passed,
  free,
  retaking;

  String get label {
    switch (this) {
      case SubjectStatus.enrolled:
        return 'Cursando';
      case SubjectStatus.regular:
        return 'Regular';
      case SubjectStatus.passed:
        return 'Aprobada';
      case SubjectStatus.free:
        return 'Libre';
      case SubjectStatus.retaking:
        return 'Recursando';
    }
  }
}

class Subject {
  final String id;
  final String name;
  final String? code;
  final int colorValue;
  final int iconCode;
  final String? professor;
  final String? classroom;
  final int? credits;
  final SubjectStatus status;
  final String period;
  final double passingGrade;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Subject({
    required this.id,
    required this.name,
    this.code,
    required this.colorValue,
    required this.iconCode,
    this.professor,
    this.classroom,
    this.credits,
    this.status = SubjectStatus.enrolled,
    required this.period,
    this.passingGrade = 4.0,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;

  Subject copyWith({
    String? id,
    String? name,
    String? code,
    int? colorValue,
    int? iconCode,
    String? professor,
    String? classroom,
    int? credits,
    SubjectStatus? status,
    String? period,
    double? passingGrade,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Subject(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      colorValue: colorValue ?? this.colorValue,
      iconCode: iconCode ?? this.iconCode,
      professor: professor ?? this.professor,
      classroom: classroom ?? this.classroom,
      credits: credits ?? this.credits,
      status: status ?? this.status,
      period: period ?? this.period,
      passingGrade: passingGrade ?? this.passingGrade,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
        'colorValue': colorValue,
        'iconCode': iconCode,
        'professor': professor,
        'classroom': classroom,
        'credits': credits,
        'status': status.name,
        'period': period,
        'passingGrade': passingGrade,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json['id'] as String,
        name: json['name'] as String,
        code: json['code'] as String?,
        colorValue: json['colorValue'] as int? ?? 0xFF4F46E5,
        iconCode: json['iconCode'] as int? ?? 0xe000,
        professor: json['professor'] as String?,
        classroom: json['classroom'] as String?,
        credits: json['credits'] as int?,
        status: SubjectStatus.values.byName(json['status'] as String? ?? 'enrolled'),
        period: json['period'] as String? ?? '1er Cuatrimestre',
        passingGrade: (json['passingGrade'] as num?)?.toDouble() ?? 4.0,
        notes: json['notes'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      );
}
