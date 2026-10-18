// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudentProfilesTable extends StudentProfiles
    with TableInfo<$StudentProfilesTable, StudentProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _careerMeta = const VerificationMeta('career');
  @override
  late final GeneratedColumn<String> career = GeneratedColumn<String>(
      'career', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _universityMeta =
      const VerificationMeta('university');
  @override
  late final GeneratedColumn<String> university = GeneratedColumn<String>(
      'university', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentYearMeta =
      const VerificationMeta('currentYear');
  @override
  late final GeneratedColumn<String> currentYear = GeneratedColumn<String>(
      'current_year', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentPeriodMeta =
      const VerificationMeta('currentPeriod');
  @override
  late final GeneratedColumn<String> currentPeriod = GeneratedColumn<String>(
      'current_period', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
      'student_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
      'theme_mode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('system'));
  static const VerificationMeta _accentColorValueMeta =
      const VerificationMeta('accentColorValue');
  @override
  late final GeneratedColumn<int> accentColorValue = GeneratedColumn<int>(
      'accent_color_value', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0xFF3B5BFD));
  static const VerificationMeta _gradeScaleMeta =
      const VerificationMeta('gradeScale');
  @override
  late final GeneratedColumn<String> gradeScale = GeneratedColumn<String>(
      'grade_scale', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('1-10'));
  static const VerificationMeta _passingGradeMeta =
      const VerificationMeta('passingGrade');
  @override
  late final GeneratedColumn<double> passingGrade = GeneratedColumn<double>(
      'passing_grade', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(4.0));
  static const VerificationMeta _remindersEnabledMeta =
      const VerificationMeta('remindersEnabled');
  @override
  late final GeneratedColumn<bool> remindersEnabled = GeneratedColumn<bool>(
      'reminders_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminders_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _biometricEnabledMeta =
      const VerificationMeta('biometricEnabled');
  @override
  late final GeneratedColumn<bool> biometricEnabled = GeneratedColumn<bool>(
      'biometric_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("biometric_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _reduceMotionMeta =
      const VerificationMeta('reduceMotion');
  @override
  late final GeneratedColumn<bool> reduceMotion = GeneratedColumn<bool>(
      'reduce_motion', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reduce_motion" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fullName,
        career,
        university,
        currentYear,
        currentPeriod,
        studentId,
        email,
        photoPath,
        themeMode,
        accentColorValue,
        gradeScale,
        passingGrade,
        remindersEnabled,
        biometricEnabled,
        reduceMotion,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'student_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<StudentProfileRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('career')) {
      context.handle(_careerMeta,
          career.isAcceptableOrUnknown(data['career']!, _careerMeta));
    } else if (isInserting) {
      context.missing(_careerMeta);
    }
    if (data.containsKey('university')) {
      context.handle(
          _universityMeta,
          university.isAcceptableOrUnknown(
              data['university']!, _universityMeta));
    } else if (isInserting) {
      context.missing(_universityMeta);
    }
    if (data.containsKey('current_year')) {
      context.handle(
          _currentYearMeta,
          currentYear.isAcceptableOrUnknown(
              data['current_year']!, _currentYearMeta));
    } else if (isInserting) {
      context.missing(_currentYearMeta);
    }
    if (data.containsKey('current_period')) {
      context.handle(
          _currentPeriodMeta,
          currentPeriod.isAcceptableOrUnknown(
              data['current_period']!, _currentPeriodMeta));
    } else if (isInserting) {
      context.missing(_currentPeriodMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('theme_mode')) {
      context.handle(_themeModeMeta,
          themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta));
    }
    if (data.containsKey('accent_color_value')) {
      context.handle(
          _accentColorValueMeta,
          accentColorValue.isAcceptableOrUnknown(
              data['accent_color_value']!, _accentColorValueMeta));
    }
    if (data.containsKey('grade_scale')) {
      context.handle(
          _gradeScaleMeta,
          gradeScale.isAcceptableOrUnknown(
              data['grade_scale']!, _gradeScaleMeta));
    }
    if (data.containsKey('passing_grade')) {
      context.handle(
          _passingGradeMeta,
          passingGrade.isAcceptableOrUnknown(
              data['passing_grade']!, _passingGradeMeta));
    }
    if (data.containsKey('reminders_enabled')) {
      context.handle(
          _remindersEnabledMeta,
          remindersEnabled.isAcceptableOrUnknown(
              data['reminders_enabled']!, _remindersEnabledMeta));
    }
    if (data.containsKey('biometric_enabled')) {
      context.handle(
          _biometricEnabledMeta,
          biometricEnabled.isAcceptableOrUnknown(
              data['biometric_enabled']!, _biometricEnabledMeta));
    }
    if (data.containsKey('reduce_motion')) {
      context.handle(
          _reduceMotionMeta,
          reduceMotion.isAcceptableOrUnknown(
              data['reduce_motion']!, _reduceMotionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StudentProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudentProfileRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      career: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}career'])!,
      university: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}university'])!,
      currentYear: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_year'])!,
      currentPeriod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_period'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_id']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      themeMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}theme_mode'])!,
      accentColorValue: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}accent_color_value'])!,
      gradeScale: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade_scale'])!,
      passingGrade: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}passing_grade'])!,
      remindersEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}reminders_enabled'])!,
      biometricEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}biometric_enabled'])!,
      reduceMotion: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}reduce_motion'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $StudentProfilesTable createAlias(String alias) {
    return $StudentProfilesTable(attachedDatabase, alias);
  }
}

class StudentProfileRow extends DataClass
    implements Insertable<StudentProfileRow> {
  final String id;
  final String fullName;
  final String career;
  final String university;
  final String currentYear;
  final String currentPeriod;
  final String? studentId;
  final String? email;
  final String? photoPath;
  final String themeMode;
  final int accentColorValue;
  final String gradeScale;
  final double passingGrade;
  final bool remindersEnabled;
  final bool biometricEnabled;
  final bool reduceMotion;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StudentProfileRow(
      {required this.id,
      required this.fullName,
      required this.career,
      required this.university,
      required this.currentYear,
      required this.currentPeriod,
      this.studentId,
      this.email,
      this.photoPath,
      required this.themeMode,
      required this.accentColorValue,
      required this.gradeScale,
      required this.passingGrade,
      required this.remindersEnabled,
      required this.biometricEnabled,
      required this.reduceMotion,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['full_name'] = Variable<String>(fullName);
    map['career'] = Variable<String>(career);
    map['university'] = Variable<String>(university);
    map['current_year'] = Variable<String>(currentYear);
    map['current_period'] = Variable<String>(currentPeriod);
    if (!nullToAbsent || studentId != null) {
      map['student_id'] = Variable<String>(studentId);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    map['accent_color_value'] = Variable<int>(accentColorValue);
    map['grade_scale'] = Variable<String>(gradeScale);
    map['passing_grade'] = Variable<double>(passingGrade);
    map['reminders_enabled'] = Variable<bool>(remindersEnabled);
    map['biometric_enabled'] = Variable<bool>(biometricEnabled);
    map['reduce_motion'] = Variable<bool>(reduceMotion);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudentProfilesCompanion toCompanion(bool nullToAbsent) {
    return StudentProfilesCompanion(
      id: Value(id),
      fullName: Value(fullName),
      career: Value(career),
      university: Value(university),
      currentYear: Value(currentYear),
      currentPeriod: Value(currentPeriod),
      studentId: studentId == null && nullToAbsent
          ? const Value.absent()
          : Value(studentId),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      themeMode: Value(themeMode),
      accentColorValue: Value(accentColorValue),
      gradeScale: Value(gradeScale),
      passingGrade: Value(passingGrade),
      remindersEnabled: Value(remindersEnabled),
      biometricEnabled: Value(biometricEnabled),
      reduceMotion: Value(reduceMotion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudentProfileRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudentProfileRow(
      id: serializer.fromJson<String>(json['id']),
      fullName: serializer.fromJson<String>(json['fullName']),
      career: serializer.fromJson<String>(json['career']),
      university: serializer.fromJson<String>(json['university']),
      currentYear: serializer.fromJson<String>(json['currentYear']),
      currentPeriod: serializer.fromJson<String>(json['currentPeriod']),
      studentId: serializer.fromJson<String?>(json['studentId']),
      email: serializer.fromJson<String?>(json['email']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      accentColorValue: serializer.fromJson<int>(json['accentColorValue']),
      gradeScale: serializer.fromJson<String>(json['gradeScale']),
      passingGrade: serializer.fromJson<double>(json['passingGrade']),
      remindersEnabled: serializer.fromJson<bool>(json['remindersEnabled']),
      biometricEnabled: serializer.fromJson<bool>(json['biometricEnabled']),
      reduceMotion: serializer.fromJson<bool>(json['reduceMotion']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fullName': serializer.toJson<String>(fullName),
      'career': serializer.toJson<String>(career),
      'university': serializer.toJson<String>(university),
      'currentYear': serializer.toJson<String>(currentYear),
      'currentPeriod': serializer.toJson<String>(currentPeriod),
      'studentId': serializer.toJson<String?>(studentId),
      'email': serializer.toJson<String?>(email),
      'photoPath': serializer.toJson<String?>(photoPath),
      'themeMode': serializer.toJson<String>(themeMode),
      'accentColorValue': serializer.toJson<int>(accentColorValue),
      'gradeScale': serializer.toJson<String>(gradeScale),
      'passingGrade': serializer.toJson<double>(passingGrade),
      'remindersEnabled': serializer.toJson<bool>(remindersEnabled),
      'biometricEnabled': serializer.toJson<bool>(biometricEnabled),
      'reduceMotion': serializer.toJson<bool>(reduceMotion),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudentProfileRow copyWith(
          {String? id,
          String? fullName,
          String? career,
          String? university,
          String? currentYear,
          String? currentPeriod,
          Value<String?> studentId = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> photoPath = const Value.absent(),
          String? themeMode,
          int? accentColorValue,
          String? gradeScale,
          double? passingGrade,
          bool? remindersEnabled,
          bool? biometricEnabled,
          bool? reduceMotion,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      StudentProfileRow(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        career: career ?? this.career,
        university: university ?? this.university,
        currentYear: currentYear ?? this.currentYear,
        currentPeriod: currentPeriod ?? this.currentPeriod,
        studentId: studentId.present ? studentId.value : this.studentId,
        email: email.present ? email.value : this.email,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
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
  StudentProfileRow copyWithCompanion(StudentProfilesCompanion data) {
    return StudentProfileRow(
      id: data.id.present ? data.id.value : this.id,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      career: data.career.present ? data.career.value : this.career,
      university:
          data.university.present ? data.university.value : this.university,
      currentYear:
          data.currentYear.present ? data.currentYear.value : this.currentYear,
      currentPeriod: data.currentPeriod.present
          ? data.currentPeriod.value
          : this.currentPeriod,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      email: data.email.present ? data.email.value : this.email,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      accentColorValue: data.accentColorValue.present
          ? data.accentColorValue.value
          : this.accentColorValue,
      gradeScale:
          data.gradeScale.present ? data.gradeScale.value : this.gradeScale,
      passingGrade: data.passingGrade.present
          ? data.passingGrade.value
          : this.passingGrade,
      remindersEnabled: data.remindersEnabled.present
          ? data.remindersEnabled.value
          : this.remindersEnabled,
      biometricEnabled: data.biometricEnabled.present
          ? data.biometricEnabled.value
          : this.biometricEnabled,
      reduceMotion: data.reduceMotion.present
          ? data.reduceMotion.value
          : this.reduceMotion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfileRow(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('career: $career, ')
          ..write('university: $university, ')
          ..write('currentYear: $currentYear, ')
          ..write('currentPeriod: $currentPeriod, ')
          ..write('studentId: $studentId, ')
          ..write('email: $email, ')
          ..write('photoPath: $photoPath, ')
          ..write('themeMode: $themeMode, ')
          ..write('accentColorValue: $accentColorValue, ')
          ..write('gradeScale: $gradeScale, ')
          ..write('passingGrade: $passingGrade, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('reduceMotion: $reduceMotion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      fullName,
      career,
      university,
      currentYear,
      currentPeriod,
      studentId,
      email,
      photoPath,
      themeMode,
      accentColorValue,
      gradeScale,
      passingGrade,
      remindersEnabled,
      biometricEnabled,
      reduceMotion,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudentProfileRow &&
          other.id == this.id &&
          other.fullName == this.fullName &&
          other.career == this.career &&
          other.university == this.university &&
          other.currentYear == this.currentYear &&
          other.currentPeriod == this.currentPeriod &&
          other.studentId == this.studentId &&
          other.email == this.email &&
          other.photoPath == this.photoPath &&
          other.themeMode == this.themeMode &&
          other.accentColorValue == this.accentColorValue &&
          other.gradeScale == this.gradeScale &&
          other.passingGrade == this.passingGrade &&
          other.remindersEnabled == this.remindersEnabled &&
          other.biometricEnabled == this.biometricEnabled &&
          other.reduceMotion == this.reduceMotion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudentProfilesCompanion extends UpdateCompanion<StudentProfileRow> {
  final Value<String> id;
  final Value<String> fullName;
  final Value<String> career;
  final Value<String> university;
  final Value<String> currentYear;
  final Value<String> currentPeriod;
  final Value<String?> studentId;
  final Value<String?> email;
  final Value<String?> photoPath;
  final Value<String> themeMode;
  final Value<int> accentColorValue;
  final Value<String> gradeScale;
  final Value<double> passingGrade;
  final Value<bool> remindersEnabled;
  final Value<bool> biometricEnabled;
  final Value<bool> reduceMotion;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StudentProfilesCompanion({
    this.id = const Value.absent(),
    this.fullName = const Value.absent(),
    this.career = const Value.absent(),
    this.university = const Value.absent(),
    this.currentYear = const Value.absent(),
    this.currentPeriod = const Value.absent(),
    this.studentId = const Value.absent(),
    this.email = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.accentColorValue = const Value.absent(),
    this.gradeScale = const Value.absent(),
    this.passingGrade = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.reduceMotion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentProfilesCompanion.insert({
    required String id,
    required String fullName,
    required String career,
    required String university,
    required String currentYear,
    required String currentPeriod,
    this.studentId = const Value.absent(),
    this.email = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.accentColorValue = const Value.absent(),
    this.gradeScale = const Value.absent(),
    this.passingGrade = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.reduceMotion = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        fullName = Value(fullName),
        career = Value(career),
        university = Value(university),
        currentYear = Value(currentYear),
        currentPeriod = Value(currentPeriod),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<StudentProfileRow> custom({
    Expression<String>? id,
    Expression<String>? fullName,
    Expression<String>? career,
    Expression<String>? university,
    Expression<String>? currentYear,
    Expression<String>? currentPeriod,
    Expression<String>? studentId,
    Expression<String>? email,
    Expression<String>? photoPath,
    Expression<String>? themeMode,
    Expression<int>? accentColorValue,
    Expression<String>? gradeScale,
    Expression<double>? passingGrade,
    Expression<bool>? remindersEnabled,
    Expression<bool>? biometricEnabled,
    Expression<bool>? reduceMotion,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fullName != null) 'full_name': fullName,
      if (career != null) 'career': career,
      if (university != null) 'university': university,
      if (currentYear != null) 'current_year': currentYear,
      if (currentPeriod != null) 'current_period': currentPeriod,
      if (studentId != null) 'student_id': studentId,
      if (email != null) 'email': email,
      if (photoPath != null) 'photo_path': photoPath,
      if (themeMode != null) 'theme_mode': themeMode,
      if (accentColorValue != null) 'accent_color_value': accentColorValue,
      if (gradeScale != null) 'grade_scale': gradeScale,
      if (passingGrade != null) 'passing_grade': passingGrade,
      if (remindersEnabled != null) 'reminders_enabled': remindersEnabled,
      if (biometricEnabled != null) 'biometric_enabled': biometricEnabled,
      if (reduceMotion != null) 'reduce_motion': reduceMotion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? fullName,
      Value<String>? career,
      Value<String>? university,
      Value<String>? currentYear,
      Value<String>? currentPeriod,
      Value<String?>? studentId,
      Value<String?>? email,
      Value<String?>? photoPath,
      Value<String>? themeMode,
      Value<int>? accentColorValue,
      Value<String>? gradeScale,
      Value<double>? passingGrade,
      Value<bool>? remindersEnabled,
      Value<bool>? biometricEnabled,
      Value<bool>? reduceMotion,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return StudentProfilesCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (career.present) {
      map['career'] = Variable<String>(career.value);
    }
    if (university.present) {
      map['university'] = Variable<String>(university.value);
    }
    if (currentYear.present) {
      map['current_year'] = Variable<String>(currentYear.value);
    }
    if (currentPeriod.present) {
      map['current_period'] = Variable<String>(currentPeriod.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (accentColorValue.present) {
      map['accent_color_value'] = Variable<int>(accentColorValue.value);
    }
    if (gradeScale.present) {
      map['grade_scale'] = Variable<String>(gradeScale.value);
    }
    if (passingGrade.present) {
      map['passing_grade'] = Variable<double>(passingGrade.value);
    }
    if (remindersEnabled.present) {
      map['reminders_enabled'] = Variable<bool>(remindersEnabled.value);
    }
    if (biometricEnabled.present) {
      map['biometric_enabled'] = Variable<bool>(biometricEnabled.value);
    }
    if (reduceMotion.present) {
      map['reduce_motion'] = Variable<bool>(reduceMotion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentProfilesCompanion(')
          ..write('id: $id, ')
          ..write('fullName: $fullName, ')
          ..write('career: $career, ')
          ..write('university: $university, ')
          ..write('currentYear: $currentYear, ')
          ..write('currentPeriod: $currentPeriod, ')
          ..write('studentId: $studentId, ')
          ..write('email: $email, ')
          ..write('photoPath: $photoPath, ')
          ..write('themeMode: $themeMode, ')
          ..write('accentColorValue: $accentColorValue, ')
          ..write('gradeScale: $gradeScale, ')
          ..write('passingGrade: $passingGrade, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('reduceMotion: $reduceMotion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects
    with TableInfo<$SubjectsTable, SubjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorValueMeta =
      const VerificationMeta('colorValue');
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
      'color_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _iconCodeMeta =
      const VerificationMeta('iconCode');
  @override
  late final GeneratedColumn<int> iconCode = GeneratedColumn<int>(
      'icon_code', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _professorMeta =
      const VerificationMeta('professor');
  @override
  late final GeneratedColumn<String> professor = GeneratedColumn<String>(
      'professor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _classroomMeta =
      const VerificationMeta('classroom');
  @override
  late final GeneratedColumn<String> classroom = GeneratedColumn<String>(
      'classroom', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creditsMeta =
      const VerificationMeta('credits');
  @override
  late final GeneratedColumn<int> credits = GeneratedColumn<int>(
      'credits', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('enrolled'));
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
      'period', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _passingGradeMeta =
      const VerificationMeta('passingGrade');
  @override
  late final GeneratedColumn<double> passingGrade = GeneratedColumn<double>(
      'passing_grade', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(4.0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        code,
        colorValue,
        iconCode,
        professor,
        classroom,
        credits,
        status,
        period,
        passingGrade,
        notes,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(Insertable<SubjectRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('color_value')) {
      context.handle(
          _colorValueMeta,
          colorValue.isAcceptableOrUnknown(
              data['color_value']!, _colorValueMeta));
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('icon_code')) {
      context.handle(_iconCodeMeta,
          iconCode.isAcceptableOrUnknown(data['icon_code']!, _iconCodeMeta));
    } else if (isInserting) {
      context.missing(_iconCodeMeta);
    }
    if (data.containsKey('professor')) {
      context.handle(_professorMeta,
          professor.isAcceptableOrUnknown(data['professor']!, _professorMeta));
    }
    if (data.containsKey('classroom')) {
      context.handle(_classroomMeta,
          classroom.isAcceptableOrUnknown(data['classroom']!, _classroomMeta));
    }
    if (data.containsKey('credits')) {
      context.handle(_creditsMeta,
          credits.isAcceptableOrUnknown(data['credits']!, _creditsMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('period')) {
      context.handle(_periodMeta,
          period.isAcceptableOrUnknown(data['period']!, _periodMeta));
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('passing_grade')) {
      context.handle(
          _passingGradeMeta,
          passingGrade.isAcceptableOrUnknown(
              data['passing_grade']!, _passingGradeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubjectRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      colorValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color_value'])!,
      iconCode: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon_code'])!,
      professor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}professor']),
      classroom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}classroom']),
      credits: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}credits']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      period: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}period'])!,
      passingGrade: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}passing_grade'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class SubjectRow extends DataClass implements Insertable<SubjectRow> {
  final String id;
  final String name;
  final String? code;
  final int colorValue;
  final int iconCode;
  final String? professor;
  final String? classroom;
  final int? credits;
  final String status;
  final String period;
  final double passingGrade;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const SubjectRow(
      {required this.id,
      required this.name,
      this.code,
      required this.colorValue,
      required this.iconCode,
      this.professor,
      this.classroom,
      this.credits,
      required this.status,
      required this.period,
      required this.passingGrade,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    map['color_value'] = Variable<int>(colorValue);
    map['icon_code'] = Variable<int>(iconCode);
    if (!nullToAbsent || professor != null) {
      map['professor'] = Variable<String>(professor);
    }
    if (!nullToAbsent || classroom != null) {
      map['classroom'] = Variable<String>(classroom);
    }
    if (!nullToAbsent || credits != null) {
      map['credits'] = Variable<int>(credits);
    }
    map['status'] = Variable<String>(status);
    map['period'] = Variable<String>(period);
    map['passing_grade'] = Variable<double>(passingGrade);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      name: Value(name),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      colorValue: Value(colorValue),
      iconCode: Value(iconCode),
      professor: professor == null && nullToAbsent
          ? const Value.absent()
          : Value(professor),
      classroom: classroom == null && nullToAbsent
          ? const Value.absent()
          : Value(classroom),
      credits: credits == null && nullToAbsent
          ? const Value.absent()
          : Value(credits),
      status: Value(status),
      period: Value(period),
      passingGrade: Value(passingGrade),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory SubjectRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubjectRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String?>(json['code']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      iconCode: serializer.fromJson<int>(json['iconCode']),
      professor: serializer.fromJson<String?>(json['professor']),
      classroom: serializer.fromJson<String?>(json['classroom']),
      credits: serializer.fromJson<int?>(json['credits']),
      status: serializer.fromJson<String>(json['status']),
      period: serializer.fromJson<String>(json['period']),
      passingGrade: serializer.fromJson<double>(json['passingGrade']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String?>(code),
      'colorValue': serializer.toJson<int>(colorValue),
      'iconCode': serializer.toJson<int>(iconCode),
      'professor': serializer.toJson<String?>(professor),
      'classroom': serializer.toJson<String?>(classroom),
      'credits': serializer.toJson<int?>(credits),
      'status': serializer.toJson<String>(status),
      'period': serializer.toJson<String>(period),
      'passingGrade': serializer.toJson<double>(passingGrade),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  SubjectRow copyWith(
          {String? id,
          String? name,
          Value<String?> code = const Value.absent(),
          int? colorValue,
          int? iconCode,
          Value<String?> professor = const Value.absent(),
          Value<String?> classroom = const Value.absent(),
          Value<int?> credits = const Value.absent(),
          String? status,
          String? period,
          double? passingGrade,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      SubjectRow(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code.present ? code.value : this.code,
        colorValue: colorValue ?? this.colorValue,
        iconCode: iconCode ?? this.iconCode,
        professor: professor.present ? professor.value : this.professor,
        classroom: classroom.present ? classroom.value : this.classroom,
        credits: credits.present ? credits.value : this.credits,
        status: status ?? this.status,
        period: period ?? this.period,
        passingGrade: passingGrade ?? this.passingGrade,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  SubjectRow copyWithCompanion(SubjectsCompanion data) {
    return SubjectRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      colorValue:
          data.colorValue.present ? data.colorValue.value : this.colorValue,
      iconCode: data.iconCode.present ? data.iconCode.value : this.iconCode,
      professor: data.professor.present ? data.professor.value : this.professor,
      classroom: data.classroom.present ? data.classroom.value : this.classroom,
      credits: data.credits.present ? data.credits.value : this.credits,
      status: data.status.present ? data.status.value : this.status,
      period: data.period.present ? data.period.value : this.period,
      passingGrade: data.passingGrade.present
          ? data.passingGrade.value
          : this.passingGrade,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubjectRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconCode: $iconCode, ')
          ..write('professor: $professor, ')
          ..write('classroom: $classroom, ')
          ..write('credits: $credits, ')
          ..write('status: $status, ')
          ..write('period: $period, ')
          ..write('passingGrade: $passingGrade, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      code,
      colorValue,
      iconCode,
      professor,
      classroom,
      credits,
      status,
      period,
      passingGrade,
      notes,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubjectRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.colorValue == this.colorValue &&
          other.iconCode == this.iconCode &&
          other.professor == this.professor &&
          other.classroom == this.classroom &&
          other.credits == this.credits &&
          other.status == this.status &&
          other.period == this.period &&
          other.passingGrade == this.passingGrade &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class SubjectsCompanion extends UpdateCompanion<SubjectRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> code;
  final Value<int> colorValue;
  final Value<int> iconCode;
  final Value<String?> professor;
  final Value<String?> classroom;
  final Value<int?> credits;
  final Value<String> status;
  final Value<String> period;
  final Value<double> passingGrade;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconCode = const Value.absent(),
    this.professor = const Value.absent(),
    this.classroom = const Value.absent(),
    this.credits = const Value.absent(),
    this.status = const Value.absent(),
    this.period = const Value.absent(),
    this.passingGrade = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubjectsCompanion.insert({
    required String id,
    required String name,
    this.code = const Value.absent(),
    required int colorValue,
    required int iconCode,
    this.professor = const Value.absent(),
    this.classroom = const Value.absent(),
    this.credits = const Value.absent(),
    this.status = const Value.absent(),
    required String period,
    this.passingGrade = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        colorValue = Value(colorValue),
        iconCode = Value(iconCode),
        period = Value(period),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SubjectRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<int>? colorValue,
    Expression<int>? iconCode,
    Expression<String>? professor,
    Expression<String>? classroom,
    Expression<int>? credits,
    Expression<String>? status,
    Expression<String>? period,
    Expression<double>? passingGrade,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (colorValue != null) 'color_value': colorValue,
      if (iconCode != null) 'icon_code': iconCode,
      if (professor != null) 'professor': professor,
      if (classroom != null) 'classroom': classroom,
      if (credits != null) 'credits': credits,
      if (status != null) 'status': status,
      if (period != null) 'period': period,
      if (passingGrade != null) 'passing_grade': passingGrade,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubjectsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? code,
      Value<int>? colorValue,
      Value<int>? iconCode,
      Value<String?>? professor,
      Value<String?>? classroom,
      Value<int?>? credits,
      Value<String>? status,
      Value<String>? period,
      Value<double>? passingGrade,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return SubjectsCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (iconCode.present) {
      map['icon_code'] = Variable<int>(iconCode.value);
    }
    if (professor.present) {
      map['professor'] = Variable<String>(professor.value);
    }
    if (classroom.present) {
      map['classroom'] = Variable<String>(classroom.value);
    }
    if (credits.present) {
      map['credits'] = Variable<int>(credits.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (passingGrade.present) {
      map['passing_grade'] = Variable<double>(passingGrade.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconCode: $iconCode, ')
          ..write('professor: $professor, ')
          ..write('classroom: $classroom, ')
          ..write('credits: $credits, ')
          ..write('status: $status, ')
          ..write('period: $period, ')
          ..write('passingGrade: $passingGrade, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamsTable extends Exams with TableInfo<$ExamsTable, ExamRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subjectIdMeta =
      const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _examDateMeta =
      const VerificationMeta('examDate');
  @override
  late final GeneratedColumn<DateTime> examDate = GeneratedColumn<DateTime>(
      'exam_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(120));
  static const VerificationMeta _classroomMeta =
      const VerificationMeta('classroom');
  @override
  late final GeneratedColumn<String> classroom = GeneratedColumn<String>(
      'classroom', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _retakeOfExamIdMeta =
      const VerificationMeta('retakeOfExamId');
  @override
  late final GeneratedColumn<String> retakeOfExamId = GeneratedColumn<String>(
      'retake_of_exam_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remindersEnabledMeta =
      const VerificationMeta('remindersEnabled');
  @override
  late final GeneratedColumn<bool> remindersEnabled = GeneratedColumn<bool>(
      'reminders_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminders_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        subjectId,
        type,
        title,
        examDate,
        durationMinutes,
        classroom,
        retakeOfExamId,
        status,
        remindersEnabled,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exams';
  @override
  VerificationContext validateIntegrity(Insertable<ExamRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('exam_date')) {
      context.handle(_examDateMeta,
          examDate.isAcceptableOrUnknown(data['exam_date']!, _examDateMeta));
    } else if (isInserting) {
      context.missing(_examDateMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('classroom')) {
      context.handle(_classroomMeta,
          classroom.isAcceptableOrUnknown(data['classroom']!, _classroomMeta));
    }
    if (data.containsKey('retake_of_exam_id')) {
      context.handle(
          _retakeOfExamIdMeta,
          retakeOfExamId.isAcceptableOrUnknown(
              data['retake_of_exam_id']!, _retakeOfExamIdMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('reminders_enabled')) {
      context.handle(
          _remindersEnabledMeta,
          remindersEnabled.isAcceptableOrUnknown(
              data['reminders_enabled']!, _remindersEnabledMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      examDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}exam_date'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      classroom: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}classroom']),
      retakeOfExamId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}retake_of_exam_id']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      remindersEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}reminders_enabled'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $ExamsTable createAlias(String alias) {
    return $ExamsTable(attachedDatabase, alias);
  }
}

class ExamRow extends DataClass implements Insertable<ExamRow> {
  final String id;
  final String subjectId;
  final String type;
  final String title;
  final DateTime examDate;
  final int durationMinutes;
  final String? classroom;
  final String? retakeOfExamId;
  final String status;
  final bool remindersEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const ExamRow(
      {required this.id,
      required this.subjectId,
      required this.type,
      required this.title,
      required this.examDate,
      required this.durationMinutes,
      this.classroom,
      this.retakeOfExamId,
      required this.status,
      required this.remindersEnabled,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subject_id'] = Variable<String>(subjectId);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['exam_date'] = Variable<DateTime>(examDate);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || classroom != null) {
      map['classroom'] = Variable<String>(classroom);
    }
    if (!nullToAbsent || retakeOfExamId != null) {
      map['retake_of_exam_id'] = Variable<String>(retakeOfExamId);
    }
    map['status'] = Variable<String>(status);
    map['reminders_enabled'] = Variable<bool>(remindersEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ExamsCompanion toCompanion(bool nullToAbsent) {
    return ExamsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      type: Value(type),
      title: Value(title),
      examDate: Value(examDate),
      durationMinutes: Value(durationMinutes),
      classroom: classroom == null && nullToAbsent
          ? const Value.absent()
          : Value(classroom),
      retakeOfExamId: retakeOfExamId == null && nullToAbsent
          ? const Value.absent()
          : Value(retakeOfExamId),
      status: Value(status),
      remindersEnabled: Value(remindersEnabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ExamRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamRow(
      id: serializer.fromJson<String>(json['id']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      examDate: serializer.fromJson<DateTime>(json['examDate']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      classroom: serializer.fromJson<String?>(json['classroom']),
      retakeOfExamId: serializer.fromJson<String?>(json['retakeOfExamId']),
      status: serializer.fromJson<String>(json['status']),
      remindersEnabled: serializer.fromJson<bool>(json['remindersEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subjectId': serializer.toJson<String>(subjectId),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'examDate': serializer.toJson<DateTime>(examDate),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'classroom': serializer.toJson<String?>(classroom),
      'retakeOfExamId': serializer.toJson<String?>(retakeOfExamId),
      'status': serializer.toJson<String>(status),
      'remindersEnabled': serializer.toJson<bool>(remindersEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  ExamRow copyWith(
          {String? id,
          String? subjectId,
          String? type,
          String? title,
          DateTime? examDate,
          int? durationMinutes,
          Value<String?> classroom = const Value.absent(),
          Value<String?> retakeOfExamId = const Value.absent(),
          String? status,
          bool? remindersEnabled,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      ExamRow(
        id: id ?? this.id,
        subjectId: subjectId ?? this.subjectId,
        type: type ?? this.type,
        title: title ?? this.title,
        examDate: examDate ?? this.examDate,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        classroom: classroom.present ? classroom.value : this.classroom,
        retakeOfExamId:
            retakeOfExamId.present ? retakeOfExamId.value : this.retakeOfExamId,
        status: status ?? this.status,
        remindersEnabled: remindersEnabled ?? this.remindersEnabled,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  ExamRow copyWithCompanion(ExamsCompanion data) {
    return ExamRow(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      examDate: data.examDate.present ? data.examDate.value : this.examDate,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      classroom: data.classroom.present ? data.classroom.value : this.classroom,
      retakeOfExamId: data.retakeOfExamId.present
          ? data.retakeOfExamId.value
          : this.retakeOfExamId,
      status: data.status.present ? data.status.value : this.status,
      remindersEnabled: data.remindersEnabled.present
          ? data.remindersEnabled.value
          : this.remindersEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamRow(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('examDate: $examDate, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('classroom: $classroom, ')
          ..write('retakeOfExamId: $retakeOfExamId, ')
          ..write('status: $status, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      subjectId,
      type,
      title,
      examDate,
      durationMinutes,
      classroom,
      retakeOfExamId,
      status,
      remindersEnabled,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamRow &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.type == this.type &&
          other.title == this.title &&
          other.examDate == this.examDate &&
          other.durationMinutes == this.durationMinutes &&
          other.classroom == this.classroom &&
          other.retakeOfExamId == this.retakeOfExamId &&
          other.status == this.status &&
          other.remindersEnabled == this.remindersEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class ExamsCompanion extends UpdateCompanion<ExamRow> {
  final Value<String> id;
  final Value<String> subjectId;
  final Value<String> type;
  final Value<String> title;
  final Value<DateTime> examDate;
  final Value<int> durationMinutes;
  final Value<String?> classroom;
  final Value<String?> retakeOfExamId;
  final Value<String> status;
  final Value<bool> remindersEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ExamsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.examDate = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.classroom = const Value.absent(),
    this.retakeOfExamId = const Value.absent(),
    this.status = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamsCompanion.insert({
    required String id,
    required String subjectId,
    required String type,
    required String title,
    required DateTime examDate,
    this.durationMinutes = const Value.absent(),
    this.classroom = const Value.absent(),
    this.retakeOfExamId = const Value.absent(),
    this.status = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        subjectId = Value(subjectId),
        type = Value(type),
        title = Value(title),
        examDate = Value(examDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ExamRow> custom({
    Expression<String>? id,
    Expression<String>? subjectId,
    Expression<String>? type,
    Expression<String>? title,
    Expression<DateTime>? examDate,
    Expression<int>? durationMinutes,
    Expression<String>? classroom,
    Expression<String>? retakeOfExamId,
    Expression<String>? status,
    Expression<bool>? remindersEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (examDate != null) 'exam_date': examDate,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (classroom != null) 'classroom': classroom,
      if (retakeOfExamId != null) 'retake_of_exam_id': retakeOfExamId,
      if (status != null) 'status': status,
      if (remindersEnabled != null) 'reminders_enabled': remindersEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamsCompanion copyWith(
      {Value<String>? id,
      Value<String>? subjectId,
      Value<String>? type,
      Value<String>? title,
      Value<DateTime>? examDate,
      Value<int>? durationMinutes,
      Value<String?>? classroom,
      Value<String?>? retakeOfExamId,
      Value<String>? status,
      Value<bool>? remindersEnabled,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return ExamsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      type: type ?? this.type,
      title: title ?? this.title,
      examDate: examDate ?? this.examDate,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      classroom: classroom ?? this.classroom,
      retakeOfExamId: retakeOfExamId ?? this.retakeOfExamId,
      status: status ?? this.status,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (examDate.present) {
      map['exam_date'] = Variable<DateTime>(examDate.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (classroom.present) {
      map['classroom'] = Variable<String>(classroom.value);
    }
    if (retakeOfExamId.present) {
      map['retake_of_exam_id'] = Variable<String>(retakeOfExamId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (remindersEnabled.present) {
      map['reminders_enabled'] = Variable<bool>(remindersEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('examDate: $examDate, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('classroom: $classroom, ')
          ..write('retakeOfExamId: $retakeOfExamId, ')
          ..write('status: $status, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, TopicRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<String> examId = GeneratedColumn<String>(
      'exam_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exams (id)'));
  static const VerificationMeta _subjectIdMeta =
      const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('todo'));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        examId,
        subjectId,
        title,
        status,
        priority,
        sortOrder,
        notes,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(Insertable<TopicRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TopicRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exam_id']),
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class TopicRow extends DataClass implements Insertable<TopicRow> {
  final String id;
  final String? examId;
  final String subjectId;
  final String title;
  final String status;
  final String priority;
  final int sortOrder;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const TopicRow(
      {required this.id,
      this.examId,
      required this.subjectId,
      required this.title,
      required this.status,
      required this.priority,
      required this.sortOrder,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || examId != null) {
      map['exam_id'] = Variable<String>(examId);
    }
    map['subject_id'] = Variable<String>(subjectId);
    map['title'] = Variable<String>(title);
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      examId:
          examId == null && nullToAbsent ? const Value.absent() : Value(examId),
      subjectId: Value(subjectId),
      title: Value(title),
      status: Value(status),
      priority: Value(priority),
      sortOrder: Value(sortOrder),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TopicRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicRow(
      id: serializer.fromJson<String>(json['id']),
      examId: serializer.fromJson<String?>(json['examId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'examId': serializer.toJson<String?>(examId),
      'subjectId': serializer.toJson<String>(subjectId),
      'title': serializer.toJson<String>(title),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TopicRow copyWith(
          {String? id,
          Value<String?> examId = const Value.absent(),
          String? subjectId,
          String? title,
          String? status,
          String? priority,
          int? sortOrder,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      TopicRow(
        id: id ?? this.id,
        examId: examId.present ? examId.value : this.examId,
        subjectId: subjectId ?? this.subjectId,
        title: title ?? this.title,
        status: status ?? this.status,
        priority: priority ?? this.priority,
        sortOrder: sortOrder ?? this.sortOrder,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  TopicRow copyWithCompanion(TopicsCompanion data) {
    return TopicRow(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicRow(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, examId, subjectId, title, status,
      priority, sortOrder, notes, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicRow &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.sortOrder == this.sortOrder &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TopicsCompanion extends UpdateCompanion<TopicRow> {
  final Value<String> id;
  final Value<String?> examId;
  final Value<String> subjectId;
  final Value<String> title;
  final Value<String> status;
  final Value<String> priority;
  final Value<int> sortOrder;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicsCompanion.insert({
    required String id,
    this.examId = const Value.absent(),
    required String subjectId,
    required String title,
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        subjectId = Value(subjectId),
        title = Value(title),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TopicRow> custom({
    Expression<String>? id,
    Expression<String>? examId,
    Expression<String>? subjectId,
    Expression<String>? title,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<int>? sortOrder,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? examId,
      Value<String>? subjectId,
      Value<String>? title,
      Value<String>? status,
      Value<String>? priority,
      Value<int>? sortOrder,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return TopicsCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<String>(examId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GradeEntriesTable extends GradeEntries
    with TableInfo<$GradeEntriesTable, GradeEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradeEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<String> examId = GeneratedColumn<String>(
      'exam_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exams (id)'));
  static const VerificationMeta _subjectIdMeta =
      const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('exam'));
  static const VerificationMeta _isRetakeMeta =
      const VerificationMeta('isRetake');
  @override
  late final GeneratedColumn<bool> isRetake = GeneratedColumn<bool>(
      'is_retake', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_retake" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _replacesOriginalMeta =
      const VerificationMeta('replacesOriginal');
  @override
  late final GeneratedColumn<bool> replacesOriginal = GeneratedColumn<bool>(
      'replaces_original', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("replaces_original" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        examId,
        subjectId,
        title,
        value,
        weight,
        kind,
        isRetake,
        replacesOriginal,
        date,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grade_entries';
  @override
  VerificationContext validateIntegrity(Insertable<GradeEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    }
    if (data.containsKey('is_retake')) {
      context.handle(_isRetakeMeta,
          isRetake.isAcceptableOrUnknown(data['is_retake']!, _isRetakeMeta));
    }
    if (data.containsKey('replaces_original')) {
      context.handle(
          _replacesOriginalMeta,
          replacesOriginal.isAcceptableOrUnknown(
              data['replaces_original']!, _replacesOriginalMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GradeEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradeEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exam_id']),
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      isRetake: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_retake'])!,
      replacesOriginal: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}replaces_original'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $GradeEntriesTable createAlias(String alias) {
    return $GradeEntriesTable(attachedDatabase, alias);
  }
}

class GradeEntryRow extends DataClass implements Insertable<GradeEntryRow> {
  final String id;
  final String? examId;
  final String subjectId;
  final String title;
  final double value;
  final double weight;
  final String kind;
  final bool isRetake;
  final bool replacesOriginal;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const GradeEntryRow(
      {required this.id,
      this.examId,
      required this.subjectId,
      required this.title,
      required this.value,
      required this.weight,
      required this.kind,
      required this.isRetake,
      required this.replacesOriginal,
      required this.date,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || examId != null) {
      map['exam_id'] = Variable<String>(examId);
    }
    map['subject_id'] = Variable<String>(subjectId);
    map['title'] = Variable<String>(title);
    map['value'] = Variable<double>(value);
    map['weight'] = Variable<double>(weight);
    map['kind'] = Variable<String>(kind);
    map['is_retake'] = Variable<bool>(isRetake);
    map['replaces_original'] = Variable<bool>(replacesOriginal);
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  GradeEntriesCompanion toCompanion(bool nullToAbsent) {
    return GradeEntriesCompanion(
      id: Value(id),
      examId:
          examId == null && nullToAbsent ? const Value.absent() : Value(examId),
      subjectId: Value(subjectId),
      title: Value(title),
      value: Value(value),
      weight: Value(weight),
      kind: Value(kind),
      isRetake: Value(isRetake),
      replacesOriginal: Value(replacesOriginal),
      date: Value(date),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory GradeEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradeEntryRow(
      id: serializer.fromJson<String>(json['id']),
      examId: serializer.fromJson<String?>(json['examId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      title: serializer.fromJson<String>(json['title']),
      value: serializer.fromJson<double>(json['value']),
      weight: serializer.fromJson<double>(json['weight']),
      kind: serializer.fromJson<String>(json['kind']),
      isRetake: serializer.fromJson<bool>(json['isRetake']),
      replacesOriginal: serializer.fromJson<bool>(json['replacesOriginal']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'examId': serializer.toJson<String?>(examId),
      'subjectId': serializer.toJson<String>(subjectId),
      'title': serializer.toJson<String>(title),
      'value': serializer.toJson<double>(value),
      'weight': serializer.toJson<double>(weight),
      'kind': serializer.toJson<String>(kind),
      'isRetake': serializer.toJson<bool>(isRetake),
      'replacesOriginal': serializer.toJson<bool>(replacesOriginal),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  GradeEntryRow copyWith(
          {String? id,
          Value<String?> examId = const Value.absent(),
          String? subjectId,
          String? title,
          double? value,
          double? weight,
          String? kind,
          bool? isRetake,
          bool? replacesOriginal,
          DateTime? date,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      GradeEntryRow(
        id: id ?? this.id,
        examId: examId.present ? examId.value : this.examId,
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
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  GradeEntryRow copyWithCompanion(GradeEntriesCompanion data) {
    return GradeEntryRow(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      title: data.title.present ? data.title.value : this.title,
      value: data.value.present ? data.value.value : this.value,
      weight: data.weight.present ? data.weight.value : this.weight,
      kind: data.kind.present ? data.kind.value : this.kind,
      isRetake: data.isRetake.present ? data.isRetake.value : this.isRetake,
      replacesOriginal: data.replacesOriginal.present
          ? data.replacesOriginal.value
          : this.replacesOriginal,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradeEntryRow(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('weight: $weight, ')
          ..write('kind: $kind, ')
          ..write('isRetake: $isRetake, ')
          ..write('replacesOriginal: $replacesOriginal, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, examId, subjectId, title, value, weight,
      kind, isRetake, replacesOriginal, date, createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradeEntryRow &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.subjectId == this.subjectId &&
          other.title == this.title &&
          other.value == this.value &&
          other.weight == this.weight &&
          other.kind == this.kind &&
          other.isRetake == this.isRetake &&
          other.replacesOriginal == this.replacesOriginal &&
          other.date == this.date &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class GradeEntriesCompanion extends UpdateCompanion<GradeEntryRow> {
  final Value<String> id;
  final Value<String?> examId;
  final Value<String> subjectId;
  final Value<String> title;
  final Value<double> value;
  final Value<double> weight;
  final Value<String> kind;
  final Value<bool> isRetake;
  final Value<bool> replacesOriginal;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const GradeEntriesCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.title = const Value.absent(),
    this.value = const Value.absent(),
    this.weight = const Value.absent(),
    this.kind = const Value.absent(),
    this.isRetake = const Value.absent(),
    this.replacesOriginal = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GradeEntriesCompanion.insert({
    required String id,
    this.examId = const Value.absent(),
    required String subjectId,
    required String title,
    required double value,
    this.weight = const Value.absent(),
    this.kind = const Value.absent(),
    this.isRetake = const Value.absent(),
    this.replacesOriginal = const Value.absent(),
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        subjectId = Value(subjectId),
        title = Value(title),
        value = Value(value),
        date = Value(date),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<GradeEntryRow> custom({
    Expression<String>? id,
    Expression<String>? examId,
    Expression<String>? subjectId,
    Expression<String>? title,
    Expression<double>? value,
    Expression<double>? weight,
    Expression<String>? kind,
    Expression<bool>? isRetake,
    Expression<bool>? replacesOriginal,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (subjectId != null) 'subject_id': subjectId,
      if (title != null) 'title': title,
      if (value != null) 'value': value,
      if (weight != null) 'weight': weight,
      if (kind != null) 'kind': kind,
      if (isRetake != null) 'is_retake': isRetake,
      if (replacesOriginal != null) 'replaces_original': replacesOriginal,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GradeEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String?>? examId,
      Value<String>? subjectId,
      Value<String>? title,
      Value<double>? value,
      Value<double>? weight,
      Value<String>? kind,
      Value<bool>? isRetake,
      Value<bool>? replacesOriginal,
      Value<DateTime>? date,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return GradeEntriesCompanion(
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
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<String>(examId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (isRetake.present) {
      map['is_retake'] = Variable<bool>(isRetake.value);
    }
    if (replacesOriginal.present) {
      map['replaces_original'] = Variable<bool>(replacesOriginal.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradeEntriesCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('subjectId: $subjectId, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('weight: $weight, ')
          ..write('kind: $kind, ')
          ..write('isRetake: $isRetake, ')
          ..write('replacesOriginal: $replacesOriginal, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudentProfilesTable studentProfiles =
      $StudentProfilesTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $ExamsTable exams = $ExamsTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $GradeEntriesTable gradeEntries = $GradeEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [studentProfiles, subjects, exams, topics, gradeEntries];
}

typedef $$StudentProfilesTableCreateCompanionBuilder = StudentProfilesCompanion
    Function({
  required String id,
  required String fullName,
  required String career,
  required String university,
  required String currentYear,
  required String currentPeriod,
  Value<String?> studentId,
  Value<String?> email,
  Value<String?> photoPath,
  Value<String> themeMode,
  Value<int> accentColorValue,
  Value<String> gradeScale,
  Value<double> passingGrade,
  Value<bool> remindersEnabled,
  Value<bool> biometricEnabled,
  Value<bool> reduceMotion,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$StudentProfilesTableUpdateCompanionBuilder = StudentProfilesCompanion
    Function({
  Value<String> id,
  Value<String> fullName,
  Value<String> career,
  Value<String> university,
  Value<String> currentYear,
  Value<String> currentPeriod,
  Value<String?> studentId,
  Value<String?> email,
  Value<String?> photoPath,
  Value<String> themeMode,
  Value<int> accentColorValue,
  Value<String> gradeScale,
  Value<double> passingGrade,
  Value<bool> remindersEnabled,
  Value<bool> biometricEnabled,
  Value<bool> reduceMotion,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$StudentProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get career => $composableBuilder(
      column: $table.career, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get university => $composableBuilder(
      column: $table.university, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentYear => $composableBuilder(
      column: $table.currentYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentPeriod => $composableBuilder(
      column: $table.currentPeriod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get studentId => $composableBuilder(
      column: $table.studentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get accentColorValue => $composableBuilder(
      column: $table.accentColorValue,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gradeScale => $composableBuilder(
      column: $table.gradeScale, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get passingGrade => $composableBuilder(
      column: $table.passingGrade, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get reduceMotion => $composableBuilder(
      column: $table.reduceMotion, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$StudentProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get career => $composableBuilder(
      column: $table.career, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get university => $composableBuilder(
      column: $table.university, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentYear => $composableBuilder(
      column: $table.currentYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentPeriod => $composableBuilder(
      column: $table.currentPeriod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get studentId => $composableBuilder(
      column: $table.studentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get accentColorValue => $composableBuilder(
      column: $table.accentColorValue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gradeScale => $composableBuilder(
      column: $table.gradeScale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get passingGrade => $composableBuilder(
      column: $table.passingGrade,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get reduceMotion => $composableBuilder(
      column: $table.reduceMotion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$StudentProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentProfilesTable> {
  $$StudentProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get career =>
      $composableBuilder(column: $table.career, builder: (column) => column);

  GeneratedColumn<String> get university => $composableBuilder(
      column: $table.university, builder: (column) => column);

  GeneratedColumn<String> get currentYear => $composableBuilder(
      column: $table.currentYear, builder: (column) => column);

  GeneratedColumn<String> get currentPeriod => $composableBuilder(
      column: $table.currentPeriod, builder: (column) => column);

  GeneratedColumn<String> get studentId =>
      $composableBuilder(column: $table.studentId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<int> get accentColorValue => $composableBuilder(
      column: $table.accentColorValue, builder: (column) => column);

  GeneratedColumn<String> get gradeScale => $composableBuilder(
      column: $table.gradeScale, builder: (column) => column);

  GeneratedColumn<double> get passingGrade => $composableBuilder(
      column: $table.passingGrade, builder: (column) => column);

  GeneratedColumn<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled, builder: (column) => column);

  GeneratedColumn<bool> get biometricEnabled => $composableBuilder(
      column: $table.biometricEnabled, builder: (column) => column);

  GeneratedColumn<bool> get reduceMotion => $composableBuilder(
      column: $table.reduceMotion, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StudentProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentProfilesTable,
    StudentProfileRow,
    $$StudentProfilesTableFilterComposer,
    $$StudentProfilesTableOrderingComposer,
    $$StudentProfilesTableAnnotationComposer,
    $$StudentProfilesTableCreateCompanionBuilder,
    $$StudentProfilesTableUpdateCompanionBuilder,
    (
      StudentProfileRow,
      BaseReferences<_$AppDatabase, $StudentProfilesTable, StudentProfileRow>
    ),
    StudentProfileRow,
    PrefetchHooks Function()> {
  $$StudentProfilesTableTableManager(
      _$AppDatabase db, $StudentProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String> career = const Value.absent(),
            Value<String> university = const Value.absent(),
            Value<String> currentYear = const Value.absent(),
            Value<String> currentPeriod = const Value.absent(),
            Value<String?> studentId = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<int> accentColorValue = const Value.absent(),
            Value<String> gradeScale = const Value.absent(),
            Value<double> passingGrade = const Value.absent(),
            Value<bool> remindersEnabled = const Value.absent(),
            Value<bool> biometricEnabled = const Value.absent(),
            Value<bool> reduceMotion = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StudentProfilesCompanion(
            id: id,
            fullName: fullName,
            career: career,
            university: university,
            currentYear: currentYear,
            currentPeriod: currentPeriod,
            studentId: studentId,
            email: email,
            photoPath: photoPath,
            themeMode: themeMode,
            accentColorValue: accentColorValue,
            gradeScale: gradeScale,
            passingGrade: passingGrade,
            remindersEnabled: remindersEnabled,
            biometricEnabled: biometricEnabled,
            reduceMotion: reduceMotion,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String fullName,
            required String career,
            required String university,
            required String currentYear,
            required String currentPeriod,
            Value<String?> studentId = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<String> themeMode = const Value.absent(),
            Value<int> accentColorValue = const Value.absent(),
            Value<String> gradeScale = const Value.absent(),
            Value<double> passingGrade = const Value.absent(),
            Value<bool> remindersEnabled = const Value.absent(),
            Value<bool> biometricEnabled = const Value.absent(),
            Value<bool> reduceMotion = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              StudentProfilesCompanion.insert(
            id: id,
            fullName: fullName,
            career: career,
            university: university,
            currentYear: currentYear,
            currentPeriod: currentPeriod,
            studentId: studentId,
            email: email,
            photoPath: photoPath,
            themeMode: themeMode,
            accentColorValue: accentColorValue,
            gradeScale: gradeScale,
            passingGrade: passingGrade,
            remindersEnabled: remindersEnabled,
            biometricEnabled: biometricEnabled,
            reduceMotion: reduceMotion,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StudentProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentProfilesTable,
    StudentProfileRow,
    $$StudentProfilesTableFilterComposer,
    $$StudentProfilesTableOrderingComposer,
    $$StudentProfilesTableAnnotationComposer,
    $$StudentProfilesTableCreateCompanionBuilder,
    $$StudentProfilesTableUpdateCompanionBuilder,
    (
      StudentProfileRow,
      BaseReferences<_$AppDatabase, $StudentProfilesTable, StudentProfileRow>
    ),
    StudentProfileRow,
    PrefetchHooks Function()>;
typedef $$SubjectsTableCreateCompanionBuilder = SubjectsCompanion Function({
  required String id,
  required String name,
  Value<String?> code,
  required int colorValue,
  required int iconCode,
  Value<String?> professor,
  Value<String?> classroom,
  Value<int?> credits,
  Value<String> status,
  required String period,
  Value<double> passingGrade,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$SubjectsTableUpdateCompanionBuilder = SubjectsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> code,
  Value<int> colorValue,
  Value<int> iconCode,
  Value<String?> professor,
  Value<String?> classroom,
  Value<int?> credits,
  Value<String> status,
  Value<String> period,
  Value<double> passingGrade,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, SubjectRow> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExamsTable, List<ExamRow>> _examsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.exams,
          aliasName: $_aliasNameGenerator(db.subjects.id, db.exams.subjectId));

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TopicsTable, List<TopicRow>> _topicsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.topics,
          aliasName: $_aliasNameGenerator(db.subjects.id, db.topics.subjectId));

  $$TopicsTableProcessedTableManager get topicsRefs {
    final manager = $$TopicsTableTableManager($_db, $_db.topics)
        .filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_topicsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GradeEntriesTable, List<GradeEntryRow>>
      _gradeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.gradeEntries,
          aliasName:
              $_aliasNameGenerator(db.subjects.id, db.gradeEntries.subjectId));

  $$GradeEntriesTableProcessedTableManager get gradeEntriesRefs {
    final manager = $$GradeEntriesTableTableManager($_db, $_db.gradeEntries)
        .filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gradeEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get iconCode => $composableBuilder(
      column: $table.iconCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get professor => $composableBuilder(
      column: $table.professor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get classroom => $composableBuilder(
      column: $table.classroom, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get credits => $composableBuilder(
      column: $table.credits, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get period => $composableBuilder(
      column: $table.period, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get passingGrade => $composableBuilder(
      column: $table.passingGrade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> examsRefs(
      Expression<bool> Function($$ExamsTableFilterComposer f) f) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> topicsRefs(
      Expression<bool> Function($$TopicsTableFilterComposer f) f) {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.topics,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TopicsTableFilterComposer(
              $db: $db,
              $table: $db.topics,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> gradeEntriesRefs(
      Expression<bool> Function($$GradeEntriesTableFilterComposer f) f) {
    final $$GradeEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gradeEntries,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GradeEntriesTableFilterComposer(
              $db: $db,
              $table: $db.gradeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get iconCode => $composableBuilder(
      column: $table.iconCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get professor => $composableBuilder(
      column: $table.professor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get classroom => $composableBuilder(
      column: $table.classroom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get credits => $composableBuilder(
      column: $table.credits, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get period => $composableBuilder(
      column: $table.period, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get passingGrade => $composableBuilder(
      column: $table.passingGrade,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get colorValue => $composableBuilder(
      column: $table.colorValue, builder: (column) => column);

  GeneratedColumn<int> get iconCode =>
      $composableBuilder(column: $table.iconCode, builder: (column) => column);

  GeneratedColumn<String> get professor =>
      $composableBuilder(column: $table.professor, builder: (column) => column);

  GeneratedColumn<String> get classroom =>
      $composableBuilder(column: $table.classroom, builder: (column) => column);

  GeneratedColumn<int> get credits =>
      $composableBuilder(column: $table.credits, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<double> get passingGrade => $composableBuilder(
      column: $table.passingGrade, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> examsRefs<T extends Object>(
      Expression<T> Function($$ExamsTableAnnotationComposer a) f) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> topicsRefs<T extends Object>(
      Expression<T> Function($$TopicsTableAnnotationComposer a) f) {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.topics,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TopicsTableAnnotationComposer(
              $db: $db,
              $table: $db.topics,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> gradeEntriesRefs<T extends Object>(
      Expression<T> Function($$GradeEntriesTableAnnotationComposer a) f) {
    final $$GradeEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gradeEntries,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GradeEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.gradeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SubjectsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SubjectsTable,
    SubjectRow,
    $$SubjectsTableFilterComposer,
    $$SubjectsTableOrderingComposer,
    $$SubjectsTableAnnotationComposer,
    $$SubjectsTableCreateCompanionBuilder,
    $$SubjectsTableUpdateCompanionBuilder,
    (SubjectRow, $$SubjectsTableReferences),
    SubjectRow,
    PrefetchHooks Function(
        {bool examsRefs, bool topicsRefs, bool gradeEntriesRefs})> {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<int> colorValue = const Value.absent(),
            Value<int> iconCode = const Value.absent(),
            Value<String?> professor = const Value.absent(),
            Value<String?> classroom = const Value.absent(),
            Value<int?> credits = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> period = const Value.absent(),
            Value<double> passingGrade = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SubjectsCompanion(
            id: id,
            name: name,
            code: code,
            colorValue: colorValue,
            iconCode: iconCode,
            professor: professor,
            classroom: classroom,
            credits: credits,
            status: status,
            period: period,
            passingGrade: passingGrade,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> code = const Value.absent(),
            required int colorValue,
            required int iconCode,
            Value<String?> professor = const Value.absent(),
            Value<String?> classroom = const Value.absent(),
            Value<int?> credits = const Value.absent(),
            Value<String> status = const Value.absent(),
            required String period,
            Value<double> passingGrade = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SubjectsCompanion.insert(
            id: id,
            name: name,
            code: code,
            colorValue: colorValue,
            iconCode: iconCode,
            professor: professor,
            classroom: classroom,
            credits: credits,
            status: status,
            period: period,
            passingGrade: passingGrade,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$SubjectsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {examsRefs = false,
              topicsRefs = false,
              gradeEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (examsRefs) db.exams,
                if (topicsRefs) db.topics,
                if (gradeEntriesRefs) db.gradeEntries
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (examsRefs)
                    await $_getPrefetchedData<SubjectRow, $SubjectsTable,
                            ExamRow>(
                        currentTable: table,
                        referencedTable:
                            $$SubjectsTableReferences._examsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SubjectsTableReferences(db, table, p0).examsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.subjectId == item.id),
                        typedResults: items),
                  if (topicsRefs)
                    await $_getPrefetchedData<SubjectRow, $SubjectsTable,
                            TopicRow>(
                        currentTable: table,
                        referencedTable:
                            $$SubjectsTableReferences._topicsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SubjectsTableReferences(db, table, p0).topicsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.subjectId == item.id),
                        typedResults: items),
                  if (gradeEntriesRefs)
                    await $_getPrefetchedData<SubjectRow, $SubjectsTable,
                            GradeEntryRow>(
                        currentTable: table,
                        referencedTable: $$SubjectsTableReferences
                            ._gradeEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SubjectsTableReferences(db, table, p0)
                                .gradeEntriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.subjectId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SubjectsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SubjectsTable,
    SubjectRow,
    $$SubjectsTableFilterComposer,
    $$SubjectsTableOrderingComposer,
    $$SubjectsTableAnnotationComposer,
    $$SubjectsTableCreateCompanionBuilder,
    $$SubjectsTableUpdateCompanionBuilder,
    (SubjectRow, $$SubjectsTableReferences),
    SubjectRow,
    PrefetchHooks Function(
        {bool examsRefs, bool topicsRefs, bool gradeEntriesRefs})>;
typedef $$ExamsTableCreateCompanionBuilder = ExamsCompanion Function({
  required String id,
  required String subjectId,
  required String type,
  required String title,
  required DateTime examDate,
  Value<int> durationMinutes,
  Value<String?> classroom,
  Value<String?> retakeOfExamId,
  Value<String> status,
  Value<bool> remindersEnabled,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$ExamsTableUpdateCompanionBuilder = ExamsCompanion Function({
  Value<String> id,
  Value<String> subjectId,
  Value<String> type,
  Value<String> title,
  Value<DateTime> examDate,
  Value<int> durationMinutes,
  Value<String?> classroom,
  Value<String?> retakeOfExamId,
  Value<String> status,
  Value<bool> remindersEnabled,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$ExamsTableReferences
    extends BaseReferences<_$AppDatabase, $ExamsTable, ExamRow> {
  $$ExamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) => db.subjects
      .createAlias($_aliasNameGenerator(db.exams.subjectId, db.subjects.id));

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TopicsTable, List<TopicRow>> _topicsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.topics,
          aliasName: $_aliasNameGenerator(db.exams.id, db.topics.examId));

  $$TopicsTableProcessedTableManager get topicsRefs {
    final manager = $$TopicsTableTableManager($_db, $_db.topics)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_topicsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GradeEntriesTable, List<GradeEntryRow>>
      _gradeEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.gradeEntries,
          aliasName: $_aliasNameGenerator(db.exams.id, db.gradeEntries.examId));

  $$GradeEntriesTableProcessedTableManager get gradeEntriesRefs {
    final manager = $$GradeEntriesTableTableManager($_db, $_db.gradeEntries)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gradeEntriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExamsTableFilterComposer extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get classroom => $composableBuilder(
      column: $table.classroom, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get retakeOfExamId => $composableBuilder(
      column: $table.retakeOfExamId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableFilterComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> topicsRefs(
      Expression<bool> Function($$TopicsTableFilterComposer f) f) {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.topics,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TopicsTableFilterComposer(
              $db: $db,
              $table: $db.topics,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> gradeEntriesRefs(
      Expression<bool> Function($$GradeEntriesTableFilterComposer f) f) {
    final $$GradeEntriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gradeEntries,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GradeEntriesTableFilterComposer(
              $db: $db,
              $table: $db.gradeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get classroom => $composableBuilder(
      column: $table.classroom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get retakeOfExamId => $composableBuilder(
      column: $table.retakeOfExamId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableOrderingComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get examDate =>
      $composableBuilder(column: $table.examDate, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<String> get classroom =>
      $composableBuilder(column: $table.classroom, builder: (column) => column);

  GeneratedColumn<String> get retakeOfExamId => $composableBuilder(
      column: $table.retakeOfExamId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get remindersEnabled => $composableBuilder(
      column: $table.remindersEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> topicsRefs<T extends Object>(
      Expression<T> Function($$TopicsTableAnnotationComposer a) f) {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.topics,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TopicsTableAnnotationComposer(
              $db: $db,
              $table: $db.topics,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> gradeEntriesRefs<T extends Object>(
      Expression<T> Function($$GradeEntriesTableAnnotationComposer a) f) {
    final $$GradeEntriesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.gradeEntries,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GradeEntriesTableAnnotationComposer(
              $db: $db,
              $table: $db.gradeEntries,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExamsTable,
    ExamRow,
    $$ExamsTableFilterComposer,
    $$ExamsTableOrderingComposer,
    $$ExamsTableAnnotationComposer,
    $$ExamsTableCreateCompanionBuilder,
    $$ExamsTableUpdateCompanionBuilder,
    (ExamRow, $$ExamsTableReferences),
    ExamRow,
    PrefetchHooks Function(
        {bool subjectId, bool topicsRefs, bool gradeEntriesRefs})> {
  $$ExamsTableTableManager(_$AppDatabase db, $ExamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> subjectId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> examDate = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<String?> classroom = const Value.absent(),
            Value<String?> retakeOfExamId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> remindersEnabled = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamsCompanion(
            id: id,
            subjectId: subjectId,
            type: type,
            title: title,
            examDate: examDate,
            durationMinutes: durationMinutes,
            classroom: classroom,
            retakeOfExamId: retakeOfExamId,
            status: status,
            remindersEnabled: remindersEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String subjectId,
            required String type,
            required String title,
            required DateTime examDate,
            Value<int> durationMinutes = const Value.absent(),
            Value<String?> classroom = const Value.absent(),
            Value<String?> retakeOfExamId = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> remindersEnabled = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamsCompanion.insert(
            id: id,
            subjectId: subjectId,
            type: type,
            title: title,
            examDate: examDate,
            durationMinutes: durationMinutes,
            classroom: classroom,
            retakeOfExamId: retakeOfExamId,
            status: status,
            remindersEnabled: remindersEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ExamsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {subjectId = false,
              topicsRefs = false,
              gradeEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (topicsRefs) db.topics,
                if (gradeEntriesRefs) db.gradeEntries
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (subjectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.subjectId,
                    referencedTable: $$ExamsTableReferences._subjectIdTable(db),
                    referencedColumn:
                        $$ExamsTableReferences._subjectIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (topicsRefs)
                    await $_getPrefetchedData<ExamRow, $ExamsTable, TopicRow>(
                        currentTable: table,
                        referencedTable:
                            $$ExamsTableReferences._topicsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamsTableReferences(db, table, p0).topicsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items),
                  if (gradeEntriesRefs)
                    await $_getPrefetchedData<ExamRow, $ExamsTable,
                            GradeEntryRow>(
                        currentTable: table,
                        referencedTable:
                            $$ExamsTableReferences._gradeEntriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamsTableReferences(db, table, p0)
                                .gradeEntriesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExamsTable,
    ExamRow,
    $$ExamsTableFilterComposer,
    $$ExamsTableOrderingComposer,
    $$ExamsTableAnnotationComposer,
    $$ExamsTableCreateCompanionBuilder,
    $$ExamsTableUpdateCompanionBuilder,
    (ExamRow, $$ExamsTableReferences),
    ExamRow,
    PrefetchHooks Function(
        {bool subjectId, bool topicsRefs, bool gradeEntriesRefs})>;
typedef $$TopicsTableCreateCompanionBuilder = TopicsCompanion Function({
  required String id,
  Value<String?> examId,
  required String subjectId,
  required String title,
  Value<String> status,
  Value<String> priority,
  Value<int> sortOrder,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$TopicsTableUpdateCompanionBuilder = TopicsCompanion Function({
  Value<String> id,
  Value<String?> examId,
  Value<String> subjectId,
  Value<String> title,
  Value<String> status,
  Value<String> priority,
  Value<int> sortOrder,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$TopicsTableReferences
    extends BaseReferences<_$AppDatabase, $TopicsTable, TopicRow> {
  $$TopicsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamsTable _examIdTable(_$AppDatabase db) =>
      db.exams.createAlias($_aliasNameGenerator(db.topics.examId, db.exams.id));

  $$ExamsTableProcessedTableManager? get examId {
    final $_column = $_itemColumn<String>('exam_id');
    if ($_column == null) return null;
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) => db.subjects
      .createAlias($_aliasNameGenerator(db.topics.subjectId, db.subjects.id));

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TopicsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$ExamsTableFilterComposer get examId {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableFilterComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$ExamsTableOrderingComposer get examId {
    final $$ExamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableOrderingComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableOrderingComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ExamsTableAnnotationComposer get examId {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TopicsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TopicsTable,
    TopicRow,
    $$TopicsTableFilterComposer,
    $$TopicsTableOrderingComposer,
    $$TopicsTableAnnotationComposer,
    $$TopicsTableCreateCompanionBuilder,
    $$TopicsTableUpdateCompanionBuilder,
    (TopicRow, $$TopicsTableReferences),
    TopicRow,
    PrefetchHooks Function({bool examId, bool subjectId})> {
  $$TopicsTableTableManager(_$AppDatabase db, $TopicsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> examId = const Value.absent(),
            Value<String> subjectId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TopicsCompanion(
            id: id,
            examId: examId,
            subjectId: subjectId,
            title: title,
            status: status,
            priority: priority,
            sortOrder: sortOrder,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> examId = const Value.absent(),
            required String subjectId,
            required String title,
            Value<String> status = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TopicsCompanion.insert(
            id: id,
            examId: examId,
            subjectId: subjectId,
            title: title,
            status: status,
            priority: priority,
            sortOrder: sortOrder,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TopicsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({examId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable: $$TopicsTableReferences._examIdTable(db),
                    referencedColumn:
                        $$TopicsTableReferences._examIdTable(db).id,
                  ) as T;
                }
                if (subjectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.subjectId,
                    referencedTable:
                        $$TopicsTableReferences._subjectIdTable(db),
                    referencedColumn:
                        $$TopicsTableReferences._subjectIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TopicsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TopicsTable,
    TopicRow,
    $$TopicsTableFilterComposer,
    $$TopicsTableOrderingComposer,
    $$TopicsTableAnnotationComposer,
    $$TopicsTableCreateCompanionBuilder,
    $$TopicsTableUpdateCompanionBuilder,
    (TopicRow, $$TopicsTableReferences),
    TopicRow,
    PrefetchHooks Function({bool examId, bool subjectId})>;
typedef $$GradeEntriesTableCreateCompanionBuilder = GradeEntriesCompanion
    Function({
  required String id,
  Value<String?> examId,
  required String subjectId,
  required String title,
  required double value,
  Value<double> weight,
  Value<String> kind,
  Value<bool> isRetake,
  Value<bool> replacesOriginal,
  required DateTime date,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$GradeEntriesTableUpdateCompanionBuilder = GradeEntriesCompanion
    Function({
  Value<String> id,
  Value<String?> examId,
  Value<String> subjectId,
  Value<String> title,
  Value<double> value,
  Value<double> weight,
  Value<String> kind,
  Value<bool> isRetake,
  Value<bool> replacesOriginal,
  Value<DateTime> date,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$GradeEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $GradeEntriesTable, GradeEntryRow> {
  $$GradeEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamsTable _examIdTable(_$AppDatabase db) => db.exams
      .createAlias($_aliasNameGenerator(db.gradeEntries.examId, db.exams.id));

  $$ExamsTableProcessedTableManager? get examId {
    final $_column = $_itemColumn<String>('exam_id');
    if ($_column == null) return null;
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias(
          $_aliasNameGenerator(db.gradeEntries.subjectId, db.subjects.id));

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GradeEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $GradeEntriesTable> {
  $$GradeEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRetake => $composableBuilder(
      column: $table.isRetake, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get replacesOriginal => $composableBuilder(
      column: $table.replacesOriginal,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$ExamsTableFilterComposer get examId {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableFilterComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GradeEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GradeEntriesTable> {
  $$GradeEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kind => $composableBuilder(
      column: $table.kind, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRetake => $composableBuilder(
      column: $table.isRetake, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get replacesOriginal => $composableBuilder(
      column: $table.replacesOriginal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$ExamsTableOrderingComposer get examId {
    final $$ExamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableOrderingComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableOrderingComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GradeEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GradeEntriesTable> {
  $$GradeEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get isRetake =>
      $composableBuilder(column: $table.isRetake, builder: (column) => column);

  GeneratedColumn<bool> get replacesOriginal => $composableBuilder(
      column: $table.replacesOriginal, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$ExamsTableAnnotationComposer get examId {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GradeEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GradeEntriesTable,
    GradeEntryRow,
    $$GradeEntriesTableFilterComposer,
    $$GradeEntriesTableOrderingComposer,
    $$GradeEntriesTableAnnotationComposer,
    $$GradeEntriesTableCreateCompanionBuilder,
    $$GradeEntriesTableUpdateCompanionBuilder,
    (GradeEntryRow, $$GradeEntriesTableReferences),
    GradeEntryRow,
    PrefetchHooks Function({bool examId, bool subjectId})> {
  $$GradeEntriesTableTableManager(_$AppDatabase db, $GradeEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradeEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GradeEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GradeEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> examId = const Value.absent(),
            Value<String> subjectId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<bool> isRetake = const Value.absent(),
            Value<bool> replacesOriginal = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GradeEntriesCompanion(
            id: id,
            examId: examId,
            subjectId: subjectId,
            title: title,
            value: value,
            weight: weight,
            kind: kind,
            isRetake: isRetake,
            replacesOriginal: replacesOriginal,
            date: date,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> examId = const Value.absent(),
            required String subjectId,
            required String title,
            required double value,
            Value<double> weight = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<bool> isRetake = const Value.absent(),
            Value<bool> replacesOriginal = const Value.absent(),
            required DateTime date,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GradeEntriesCompanion.insert(
            id: id,
            examId: examId,
            subjectId: subjectId,
            title: title,
            value: value,
            weight: weight,
            kind: kind,
            isRetake: isRetake,
            replacesOriginal: replacesOriginal,
            date: date,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GradeEntriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({examId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable:
                        $$GradeEntriesTableReferences._examIdTable(db),
                    referencedColumn:
                        $$GradeEntriesTableReferences._examIdTable(db).id,
                  ) as T;
                }
                if (subjectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.subjectId,
                    referencedTable:
                        $$GradeEntriesTableReferences._subjectIdTable(db),
                    referencedColumn:
                        $$GradeEntriesTableReferences._subjectIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GradeEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GradeEntriesTable,
    GradeEntryRow,
    $$GradeEntriesTableFilterComposer,
    $$GradeEntriesTableOrderingComposer,
    $$GradeEntriesTableAnnotationComposer,
    $$GradeEntriesTableCreateCompanionBuilder,
    $$GradeEntriesTableUpdateCompanionBuilder,
    (GradeEntryRow, $$GradeEntriesTableReferences),
    GradeEntryRow,
    PrefetchHooks Function({bool examId, bool subjectId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudentProfilesTableTableManager get studentProfiles =>
      $$StudentProfilesTableTableManager(_db, _db.studentProfiles);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$ExamsTableTableManager get exams =>
      $$ExamsTableTableManager(_db, _db.exams);
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db, _db.topics);
  $$GradeEntriesTableTableManager get gradeEntries =>
      $$GradeEntriesTableTableManager(_db, _db.gradeEntries);
}
