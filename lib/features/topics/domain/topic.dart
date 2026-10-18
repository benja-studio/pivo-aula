enum TopicStatus {
  todo,
  studying,
  reviewed,
  mastered;

  String get label {
    switch (this) {
      case TopicStatus.todo:
        return 'Sin empezar';
      case TopicStatus.studying:
        return 'Estudiando';
      case TopicStatus.reviewed:
        return 'Repasado';
      case TopicStatus.mastered:
        return 'Dominado';
    }
  }

  double get progressValue {
    switch (this) {
      case TopicStatus.todo:
        return 0.0;
      case TopicStatus.studying:
        return 0.33;
      case TopicStatus.reviewed:
        return 0.66;
      case TopicStatus.mastered:
        return 1.0;
    }
  }
}

enum TopicPriority {
  low,
  medium,
  high;

  String get label {
    switch (this) {
      case TopicPriority.low:
        return 'Baja';
      case TopicPriority.medium:
        return 'Media';
      case TopicPriority.high:
        return 'Alta';
    }
  }
}

class Topic {
  final String id;
  final String? examId;
  final String subjectId;
  final String title;
  final TopicStatus status;
  final TopicPriority priority;
  final int sortOrder;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Topic({
    required this.id,
    this.examId,
    required this.subjectId,
    required this.title,
    this.status = TopicStatus.todo,
    this.priority = TopicPriority.medium,
    required this.sortOrder,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;

  Topic copyWith({
    String? id,
    String? examId,
    String? subjectId,
    String? title,
    TopicStatus? status,
    TopicPriority? priority,
    int? sortOrder,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Topic(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      subjectId: subjectId ?? this.subjectId,
      title: title ?? this.title,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      sortOrder: sortOrder ?? this.sortOrder,
      notes: notes ?? this.notes,
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
        'status': status.name,
        'priority': priority.name,
        'sortOrder': sortOrder,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json['id'] as String,
        examId: json['examId'] as String?,
        subjectId: json['subjectId'] as String,
        title: json['title'] as String,
        status: TopicStatus.values.byName(json['status'] as String? ?? 'todo'),
        priority: TopicPriority.values.byName(json['priority'] as String? ?? 'medium'),
        sortOrder: json['sortOrder'] as int? ?? 0,
        notes: json['notes'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      );
}
