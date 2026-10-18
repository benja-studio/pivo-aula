import 'package:flutter_test/flutter_test.dart';
import 'package:pivo_aula/features/profile/domain/student_profile.dart';
import 'package:pivo_aula/features/subjects/domain/subject.dart';
import 'package:pivo_aula/features/exams/domain/exam.dart';
import 'package:pivo_aula/features/topics/domain/topic.dart';
import 'package:pivo_aula/features/grades/domain/grade_entry.dart';

void main() {
  group('Domain Entities Roundtrip Tests', () {
    test('StudentProfile json roundtrip', () {
      final now = DateTime.now();
      final original = StudentProfile(
        id: 'p-1',
        fullName: 'Martina Gómez',
        career: 'Ingeniería en Sistemas',
        university: 'UTN',
        currentYear: '3er año',
        currentPeriod: '1er Cuatrimestre 2026',
        studentId: '98234',
        email: 'martina@ejemplo.com',
        photoPath: null,
        themeMode: 'dark',
        accentColorValue: 0xFF3B5BFD,
        gradeScale: '1-10',
        passingGrade: 4.0,
        remindersEnabled: true,
        biometricEnabled: false,
        reduceMotion: false,
        createdAt: now,
        updatedAt: now,
      );

      final json = original.toJson();
      final restored = StudentProfile.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.fullName, original.fullName);
      expect(restored.career, original.career);
      expect(restored.university, original.university);
      expect(restored.passingGrade, original.passingGrade);
    });

    test('Subject, Exam, Topic and GradeEntry json roundtrip', () {
      final now = DateTime.now();

      final subject = Subject(
        id: 's-1',
        name: 'Algoritmos y Estructuras de Datos',
        code: 'AED-101',
        colorValue: 0xFF4F46E5,
        iconCode: 0xe000,
        professor: 'Ing. Rossi',
        classroom: 'Aula 204',
        credits: 6,
        status: SubjectStatus.enrolled,
        period: '1er Cuatrimestre',
        passingGrade: 4.0,
        notes: 'Promoción con 7',
        createdAt: now,
        updatedAt: now,
      );

      final exam = Exam(
        id: 'e-1',
        subjectId: 's-1',
        type: ExamType.midterm,
        title: 'Primer Parcial Teórico',
        dateTime: now,
        durationMinutes: 120,
        classroom: 'Aula Magna',
        status: ExamStatus.pending,
        remindersEnabled: true,
        createdAt: now,
        updatedAt: now,
      );

      final topic = Topic(
        id: 't-1',
        examId: 'e-1',
        subjectId: 's-1',
        title: 'Árboles Binarios de Búsqueda',
        status: TopicStatus.studying,
        priority: TopicPriority.high,
        sortOrder: 1,
        notes: 'Ver rotaciones AVL',
        createdAt: now,
        updatedAt: now,
      );

      final grade = GradeEntry(
        id: 'g-1',
        examId: 'e-1',
        subjectId: 's-1',
        title: 'Primer Parcial',
        value: 9.5,
        weight: 1.0,
        kind: GradeKind.exam,
        date: now,
        createdAt: now,
        updatedAt: now,
      );

      expect(Subject.fromJson(subject.toJson()).name, subject.name);
      expect(Exam.fromJson(exam.toJson()).title, exam.title);
      expect(Topic.fromJson(topic.toJson()).status, topic.status);
      expect(GradeEntry.fromJson(grade.toJson()).value, grade.value);
    });
  });
}
