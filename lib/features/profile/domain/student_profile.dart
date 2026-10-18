class StudentProfile {
  final String id;
  final String fullName;
  final String career;
  final String university;
  final String currentYear;
  final String currentPeriod;
  final String? studentId;
  final String? email;
  final String? photoPath;
  final String themeMode; // 'system', 'light', 'dark'
  final int accentColorValue;
  final String gradeScale; // '1-10', '0-100', 'A-F'
  final double passingGrade;
  final bool remindersEnabled;
  final bool biometricEnabled;
  final bool reduceMotion;
  final DateTime createdAt;
  final DateTime updatedAt;

  const StudentProfile({
    required this.id,
    required this.fullName,
    required this.career,
    required this.university,
    required this.currentYear,
    required this.currentPeriod,
    this.studentId,
    this.email,
    this.photoPath,
    this.themeMode = 'system',
    this.accentColorValue = 0xFF3B5BFD,
    this.gradeScale = '1-10',
    this.passingGrade = 4.0,
    this.remindersEnabled = true,
    this.biometricEnabled = false,
    this.reduceMotion = false,
    required this.createdAt,
    required this.updatedAt,
  });

  StudentProfile copyWith({
    String? id,
    String? fullName,
    String? career,
    String? university,
    String? currentYear,
    String? currentPeriod,
    String? studentId,
    String? email,
    String? photoPath,
    String? themeMode,
    int? accentColorValue,
    String? gradeScale,
    double? passingGrade,
    bool? remindersEnabled,
    bool? biometricEnabled,
    bool? reduceMotion,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudentProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      career: career ?? this.career,
      university: university ?? this.university,
      currentYear: currentYear ?? this.currentYear,
      currentPeriod: currentPeriod ?? this.currentPeriod,
      studentId: studentId ?? this.studentId,
      email: email ?? this.email,
      photoPath: photoPath ?? this.photoPath,
      themeMode: themeMode ?? this.themeMode,
      accentColorValue: accentColorValue ?? this.accentColorValue,
      gradeScale: gradeScale ?? this.gradeScale,
      passingGrade: passingGrade ?? this.passingGrade,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      reduceMotion: reduceMotion ?? this.reduceMotion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'career': career,
        'university': university,
        'currentYear': currentYear,
        'currentPeriod': currentPeriod,
        'studentId': studentId,
        'email': email,
        'photoPath': photoPath,
        'themeMode': themeMode,
        'accentColorValue': accentColorValue,
        'gradeScale': gradeScale,
        'passingGrade': passingGrade,
        'remindersEnabled': remindersEnabled,
        'biometricEnabled': biometricEnabled,
        'reduceMotion': reduceMotion,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        career: json['career'] as String,
        university: json['university'] as String,
        currentYear: json['currentYear'] as String? ?? '1er año',
        currentPeriod: json['currentPeriod'] as String? ?? '1er Cuatrimestre',
        studentId: json['studentId'] as String?,
        email: json['email'] as String?,
        photoPath: json['photoPath'] as String?,
        themeMode: json['themeMode'] as String? ?? 'system',
        accentColorValue: json['accentColorValue'] as int? ?? 0xFF3B5BFD,
        gradeScale: json['gradeScale'] as String? ?? '1-10',
        passingGrade: (json['passingGrade'] as num?)?.toDouble() ?? 4.0,
        remindersEnabled: json['remindersEnabled'] as bool? ?? true,
        biometricEnabled: json['biometricEnabled'] as bool? ?? false,
        reduceMotion: json['reduceMotion'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      );
}
