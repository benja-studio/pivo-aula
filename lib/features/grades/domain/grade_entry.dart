enum GradeKind {
  exam,
  assignment,
  concept,
  extra;

  String get label {
    switch (this) {
      case GradeKind.exam:
        return 'Examen';
      case GradeKind.assignment:
        return 'Trabajo Práctico';
      case GradeKind.concept:
        return 'Concepto';
      case GradeKind.extra:
        return 'Extra';
    }
  }
}

class GradeEntry {
  final String id;
  final String? examId;
  final String subjectId;
  final String title;
  final double value;
  final double weight;
  final GradeKind kind;
  final bool isRetake;
  final bool replacesOriginal;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const GradeEntry({
    required this.id,
    this.examId,
    required this.subjectId,
    required this.title,
    required this.value,
    this.weight = 1.0,
    this.kind = GradeKind.exam,
    this.isRetake = false,
    this.replacesOriginal = true,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;

  GradeEntry copyWith({
    String? id,
    String? examId,
    String? subjectId,
    String? title,
    double? value,
    double? weight,
    GradeKind? kind,
    bool? isRetake,
    bool? replacesOriginal,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return GradeEntry(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      value: value ?? this.value,
      weight: weight ?? this.weight,
      kind: kind ?? this.kind,
      isRetake: isRetake ?? this.isRetake,
      replacesOriginal: replacesOriginal ?? this.replacesOriginal,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'examId': examId,
        'subjectId': subjectId,
        'title': title,
        'value': value,
        'weight': weight,
        'kind': kind.name,
        'isRetake': isRetake,
        'replacesOriginal': replacesOriginal,
        'date': date.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };

  factory GradeEntry.fromJson(Map<String, dynamic> json) => GradeEntry(
        id: json['id'] as String,
        examId: json['examId'] as String?,
        subjectId: json['subjectId'] as String,
        title: json['title'] as String,
        value: (json['value'] as num).toDouble(),
        weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
        kind: GradeKind.values.byName(json['kind'] as String? ?? 'exam'),
        isRetake: json['isRetake'] as bool? ?? false,
        replacesOriginal: json['replacesOriginal'] as bool? ?? true,
        date: DateTime.parse(json['date'] as String),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      );
}
