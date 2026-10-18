import 'package:drift/drift.dart';
import 'connection.dart';
import 'tables.dart';
import '../../features/profile/domain/student_profile.dart';
import '../../features/subjects/domain/subject.dart';
import '../../features/exams/domain/exam.dart';
import '../../features/topics/domain/topic.dart';
import '../../features/grades/domain/grade_entry.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [StudentProfiles, Subjects, Exams, Topics, GradeEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON;');
        },
      );

  Future<bool> checkIntegrity() async {
    final result = await customSelect('PRAGMA integrity_check;').getSingle();
    final val = result.read<String>('integrity_check');
    return val.toLowerCase() == 'ok';
  }

  // --- StudentProfile Queries ---
  Stream<StudentProfile?> watchProfile() {
    return (select(studentProfiles)..limit(1)).watchSingleOrNull().map((row) {
      if (row == null) return null;
      return StudentProfile(
        id: row.id,
        fullName: row.fullName,
        career: row.career,
        university: row.university,
        currentYear: row.currentYear,
        currentPeriod: row.currentPeriod,
        studentId: row.studentId,
        email: row.email,
        photoPath: row.photoPath,
        themeMode: row.themeMode,
        accentColorValue: row.accentColorValue,
        gradeScale: row.gradeScale,
        passingGrade: row.passingGrade,
        remindersEnabled: row.remindersEnabled,
        biometricEnabled: row.biometricEnabled,
        reduceMotion: row.reduceMotion,
        createdAt: row.createdAt,
        updatedAt: row.updatedAt,
      );
    });
  }

  Future<StudentProfile?> getProfile() async {
    final row = await (select(studentProfiles)..limit(1)).getSingleOrNull();
    if (row == null) return null;
    return StudentProfile(
      id: row.id,
      fullName: row.fullName,
      career: row.career,
      university: row.university,
      currentYear: row.currentYear,
      currentPeriod: row.currentPeriod,
      studentId: row.studentId,
      email: row.email,
      photoPath: row.photoPath,
      themeMode: row.themeMode,
      accentColorValue: row.accentColorValue,
      gradeScale: row.gradeScale,
      passingGrade: row.passingGrade,
      remindersEnabled: row.remindersEnabled,
      biometricEnabled: row.biometricEnabled,
      reduceMotion: row.reduceMotion,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  Future<void> saveProfile(StudentProfile profile) async {
    await into(studentProfiles).insertOnConflictUpdate(
      StudentProfilesCompanion(
        id: Value(profile.id),
        fullName: Value(profile.fullName),
        career: Value(profile.career),
        university: Value(profile.university),
        currentYear: Value(profile.currentYear),
        currentPeriod: Value(profile.currentPeriod),
        studentId: Value(profile.studentId),
        email: Value(profile.email),
        photoPath: Value(profile.photoPath),
        themeMode: Value(profile.themeMode),
        accentColorValue: Value(profile.accentColorValue),
        gradeScale: Value(profile.gradeScale),
        passingGrade: Value(profile.passingGrade),
        remindersEnabled: Value(profile.remindersEnabled),
        biometricEnabled: Value(profile.biometricEnabled),
        reduceMotion: Value(profile.reduceMotion),
        createdAt: Value(profile.createdAt),
        updatedAt: Value(profile.updatedAt),
      ),
    );
  }

  // --- Subjects Queries ---
  Stream<List<Subject>> watchSubjects({bool includeDeleted = false}) {
    final query = select(subjects);
    if (!includeDeleted) {
      query.where((tbl) => tbl.deletedAt.isNull());
    }
    query.orderBy([(t) => OrderingTerm.asc(t.name)]);
    return query.watch().map((rows) => rows.map(_mapSubject).toList());
  }

  Future<Subject?> getSubjectById(String id) async {
    final row = await (select(subjects)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _mapSubject(row) : null;
  }

  Future<void> upsertSubject(Subject s) async {
    await into(subjects).insertOnConflictUpdate(
      SubjectsCompanion(
        id: Value(s.id),
        name: Value(s.name),
        code: Value(s.code),
        colorValue: Value(s.colorValue),
        iconCode: Value(s.iconCode),
        professor: Value(s.professor),
        classroom: Value(s.classroom),
        credits: Value(s.credits),
        status: Value(s.status.name),
        period: Value(s.period),
        passingGrade: Value(s.passingGrade),
        notes: Value(s.notes),
        createdAt: Value(s.createdAt),
        updatedAt: Value(s.updatedAt),
        deletedAt: Value(s.deletedAt),
      ),
    );
  }

  Future<void> softDeleteSubject(String id) async {
    await (update(subjects)..where((tbl) => tbl.id.equals(id))).write(
      SubjectsCompanion(deletedAt: Value(DateTime.now())),
    );
  }

  Future<void> restoreSubject(String id) async {
    await (update(subjects)..where((tbl) => tbl.id.equals(id))).write(
      const SubjectsCompanion(deletedAt: Value(null)),
    );
  }

  Subject _mapSubject(SubjectRow row) {
    return Subject(
      id: row.id,
      name: row.name,
      code: row.code,
      colorValue: row.colorValue,
      iconCode: row.iconCode,
      professor: row.professor,
      classroom: row.classroom,
      credits: row.credits,
      status: SubjectStatus.values.byName(row.status),
      period: row.period,
      passingGrade: row.passingGrade,
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
  }

  // --- Exams Queries ---
  Stream<List<Exam>> watchExams({bool includeDeleted = false}) {
    final query = select(exams);
    if (!includeDeleted) {
      query.where((tbl) => tbl.deletedAt.isNull());
    }
    query.orderBy([(t) => OrderingTerm.asc(t.examDate)]);
    return query.watch().map((rows) => rows.map(_mapExam).toList());
  }

  Future<Exam?> getExamById(String id) async {
    final row = await (select(exams)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    return row != null ? _mapExam(row) : null;
  }

  Future<void> upsertExam(Exam e) async {
    await into(exams).insertOnConflictUpdate(
      ExamsCompanion(
        id: Value(e.id),
        subjectId: Value(e.subjectId),
        type: Value(e.type.name),
        title: Value(e.title),
        examDate: Value(e.dateTime),
        durationMinutes: Value(e.durationMinutes),
        classroom: Value(e.classroom),
        retakeOfExamId: Value(e.retakeOfExamId),
        status: Value(e.status.name),
        remindersEnabled: Value(e.remindersEnabled),
        createdAt: Value(e.createdAt),
        updatedAt: Value(e.updatedAt),
        deletedAt: Value(e.deletedAt),
      ),
    );
  }

  Future<void> softDeleteExam(String id) async {
    await (update(exams)..where((tbl) => tbl.id.equals(id))).write(
      ExamsCompanion(deletedAt: Value(DateTime.now())),
    );
  }

  Future<void> restoreExam(String id) async {
    await (update(exams)..where((tbl) => tbl.id.equals(id))).write(
      const ExamsCompanion(deletedAt: Value(null)),
    );
  }

  Exam _mapExam(ExamRow row) {
    return Exam(
      id: row.id,
      subjectId: row.subjectId,
      type: ExamType.values.byName(row.type),
      title: row.title,
      dateTime: row.examDate,
      durationMinutes: row.durationMinutes,
      classroom: row.classroom,
      retakeOfExamId: row.retakeOfExamId,
      status: ExamStatus.values.byName(row.status),
      remindersEnabled: row.remindersEnabled,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
  }

  // --- Topics Queries ---
  Stream<List<Topic>> watchTopicsForExam(String examId) {
    return (select(topics)
          ..where((tbl) => tbl.examId.equals(examId) & tbl.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch()
        .map((rows) => rows.map(_mapTopic).toList());
  }

  Stream<List<Topic>> watchTopicsForSubject(String subjectId) {
    return (select(topics)
          ..where((tbl) => tbl.subjectId.equals(subjectId) & tbl.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch()
        .map((rows) => rows.map(_mapTopic).toList());
  }

  Stream<List<Topic>> watchAllTopics() {
    return (select(topics)
          ..where((tbl) => tbl.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch()
        .map((rows) => rows.map(_mapTopic).toList());
  }

  Future<void> upsertTopic(Topic t) async {
    await into(topics).insertOnConflictUpdate(
      TopicsCompanion(
        id: Value(t.id),
        examId: Value(t.examId),
        subjectId: Value(t.subjectId),
        title: Value(t.title),
        status: Value(t.status.name),
        priority: Value(t.priority.name),
        sortOrder: Value(t.sortOrder),
        notes: Value(t.notes),
        createdAt: Value(t.createdAt),
        updatedAt: Value(t.updatedAt),
        deletedAt: Value(t.deletedAt),
      ),
    );
  }

  Future<void> softDeleteTopic(String id) async {
    await (update(topics)..where((tbl) => tbl.id.equals(id))).write(
      TopicsCompanion(deletedAt: Value(DateTime.now())),
    );
  }

  Topic _mapTopic(TopicRow row) {
    return Topic(
      id: row.id,
      examId: row.examId,
      subjectId: row.subjectId,
      title: row.title,
      status: TopicStatus.values.byName(row.status),
      priority: TopicPriority.values.byName(row.priority),
      sortOrder: row.sortOrder,
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
  }

  // --- GradeEntries Queries ---
  Stream<List<GradeEntry>> watchAllGrades() {
    return (select(gradeEntries)
          ..where((tbl) => tbl.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch()
        .map((rows) => rows.map(_mapGradeEntry).toList());
  }

  Stream<List<GradeEntry>> watchGradesForSubject(String subjectId) {
    return (select(gradeEntries)
          ..where((tbl) => tbl.subjectId.equals(subjectId) & tbl.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch()
        .map((rows) => rows.map(_mapGradeEntry).toList());
  }

  Future<void> upsertGrade(GradeEntry g) async {
    await into(gradeEntries).insertOnConflictUpdate(
      GradeEntriesCompanion(
        id: Value(g.id),
        examId: Value(g.examId),
        subjectId: Value(g.subjectId),
        title: Value(g.title),
        value: Value(g.value),
        weight: Value(g.weight),
        kind: Value(g.kind.name),
        isRetake: Value(g.isRetake),
        replacesOriginal: Value(g.replacesOriginal),
        date: Value(g.date),
        createdAt: Value(g.createdAt),
        updatedAt: Value(g.updatedAt),
        deletedAt: Value(g.deletedAt),
      ),
    );
  }

  Future<void> softDeleteGrade(String id) async {
    await (update(gradeEntries)..where((tbl) => tbl.id.equals(id))).write(
      GradeEntriesCompanion(deletedAt: Value(DateTime.now())),
    );
  }

  Future<void> restoreGrade(String id) async {
    await (update(gradeEntries)..where((tbl) => tbl.id.equals(id))).write(
      const GradeEntriesCompanion(deletedAt: Value(null)),
    );
  }

  GradeEntry _mapGradeEntry(GradeEntryRow row) {
    return GradeEntry(
      id: row.id,
      examId: row.examId,
      subjectId: row.subjectId,
      title: row.title,
      value: row.value,
      weight: row.weight,
      kind: GradeKind.values.byName(row.kind),
      isRetake: row.isRetake,
      replacesOriginal: row.replacesOriginal,
      date: row.date,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      deletedAt: row.deletedAt,
    );
  }

  Future<void> clearAllData() async {
    await transaction(() async {
      await delete(gradeEntries).go();
      await delete(topics).go();
      await delete(exams).go();
      await delete(subjects).go();
      await delete(studentProfiles).go();
    });
  }
}
