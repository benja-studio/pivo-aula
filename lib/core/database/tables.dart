import 'package:drift/drift.dart';

@DataClassName('StudentProfileRow')
class StudentProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get fullName => text()();
  TextColumn get career => text()();
  TextColumn get university => text()();
  TextColumn get currentYear => text()();
  TextColumn get currentPeriod => text()();
  TextColumn get studentId => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  IntColumn get accentColorValue => integer().withDefault(const Constant(0xFF3B5BFD))();
  TextColumn get gradeScale => text().withDefault(const Constant('1-10'))();
  RealColumn get passingGrade => real().withDefault(const Constant(4.0))();
  BoolColumn get remindersEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get biometricEnabled => boolean().withDefault(const Constant(false))();
  BoolColumn get reduceMotion => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SubjectRow')
class Subjects extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get code => text().nullable()();
  IntColumn get colorValue => integer()();
  IntColumn get iconCode => integer()();
  TextColumn get professor => text().nullable()();
  TextColumn get classroom => text().nullable()();
  IntColumn get credits => integer().nullable()();
  TextColumn get status => text().withDefault(const Constant('enrolled'))();
  TextColumn get period => text()();
  RealColumn get passingGrade => real().withDefault(const Constant(4.0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExamRow')
class Exams extends Table {
  TextColumn get id => text()();
  TextColumn get subjectId => text().references(Subjects, #id)();
  TextColumn get type => text()();
  TextColumn get title => text()();
  DateTimeColumn get examDate => dateTime()();
  IntColumn get durationMinutes => integer().withDefault(const Constant(120))();
  TextColumn get classroom => text().nullable()();
  TextColumn get retakeOfExamId => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  BoolColumn get remindersEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TopicRow')
class Topics extends Table {
  TextColumn get id => text()();
  TextColumn get examId => text().nullable().references(Exams, #id)();
  TextColumn get subjectId => text().references(Subjects, #id)();
  TextColumn get title => text()();
  TextColumn get status => text().withDefault(const Constant('todo'))();
  TextColumn get priority => text().withDefault(const Constant('medium'))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('GradeEntryRow')
class GradeEntries extends Table {
  TextColumn get id => text()();
  TextColumn get examId => text().nullable().references(Exams, #id)();
  TextColumn get subjectId => text().references(Subjects, #id)();
  TextColumn get title => text()();
  RealColumn get value => real()();
  RealColumn get weight => real().withDefault(const Constant(1.0))();
  TextColumn get kind => text().withDefault(const Constant('exam'))();
  BoolColumn get isRetake => boolean().withDefault(const Constant(false))();
  BoolColumn get replacesOriginal => boolean().withDefault(const Constant(true))();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
