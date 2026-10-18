enum ExamType {
  midterm,
  retake,
  finalExam,
  assignment,
  quiz,
  oral;

  String get label {
    switch (this) {
      case ExamType.midterm:
        return 'Parcial';
      case ExamType.retake:
        return 'Recuperatorio';
      case ExamType.finalExam:
        return 'Final';
      case ExamType.assignment:
        return 'Trabajo Práctico';
      case ExamType.quiz:
        return 'Quiz';
      case ExamType.oral:
        return 'Oral';
    }
  }
}

enum ExamStatus {
  pending,
  taken,
  passed,
  failed,
  absent;

  String get label {
    switch (this) {
      case ExamStatus.pending:
        return 'Pendiente';
      case ExamStatus.taken:
        return 'Rendido';
      case ExamStatus.passed:
        return 'Aprobado';
      case ExamStatus.failed:
        return 'Desaprobado';
      case ExamStatus.absent:
        return 'Ausente';
    }
  }
}

class Exam {
  final String id;
  final String subjectId;
  final ExamType type;
  final String title;
  final DateTime dateTime;
  final int durationMinutes;
  final String? classroom;
  final String? retakeOfExamId;
  final ExamStatus status;
  final bool remindersEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Exam({
    required this.id,
    required this.subjectId,
    required this.type,
    required this.title,
    required this.dateTime,
    this.durationMinutes = 120,
    this.classroom,
    this.retakeOfExamId,
    this.status = ExamStatus.pending,
    this.remindersEnabled = true,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  bool get isDeleted => deletedAt != null;

  Exam copyWith({
    String? id,
    String? subjectId,
    ExamType? type,
    String? title,
    DateTime? dateTime,
    int? durationMinutes,
    String? classroom,
    String? retakeOfExamId,
    ExamStatus? status,
    bool? remindersEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Exam(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      type: type ?? this.type,
      title: title ?? this.title,
      dateTime: dateTime ?? this.dateTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      classroom: classroom ?? this.classroom,
      retakeOfExamId: retakeOfExamId ?? this.retakeOfExamId,
      status: status ?? this.status,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'subjectId': subjectId,
        'type': type.name,
        'title': title,
        'dateTime': dateTime.toIso8601String(),
        'durationMinutes': durationMinutes,
        'classroom': classroom,
        'retakeOfExamId': retakeOfExamId,
        'status': status.name,
        'remindersEnabled': remindersEnabled,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json['id'] as String,
        subjectId: json['subjectId'] as String,
        type: ExamType.values.byName(json['type'] as String? ?? 'midterm'),
        title: json['title'] as String,
        dateTime: DateTime.parse(json['dateTime'] as String),
        durationMinutes: json['durationMinutes'] as int? ?? 120,
        classroom: json['classroom'] as String?,
        retakeOfExamId: json['retakeOfExamId'] as String?,
        status: ExamStatus.values.byName(json['status'] as String? ?? 'pending'),
        remindersEnabled: json['remindersEnabled'] as bool? ?? true,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
        deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      );
}
