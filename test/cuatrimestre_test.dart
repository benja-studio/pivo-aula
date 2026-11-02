import 'package:flutter_test/flutter_test.dart';
import 'package:pivo_aula/features/subjects/domain/cuatrimestre.dart';
import 'package:pivo_aula/features/subjects/domain/subject.dart';

Subject _subject({
  required String id,
  required String name,
  required String period,
  SubjectStatus status = SubjectStatus.enrolled,
  int? credits,
}) {
  final now = DateTime(2026, 1, 1);
  return Subject(
    id: id,
    name: name,
    colorValue: 0xFF3B5BFD,
    iconCode: 0xe000,
    status: status,
    period: period,
    credits: credits,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  group('Cuatrimestre', () {
    test('agrupa materias por período y las ordena por nombre', () {
      final cuatrimestres = Cuatrimestre.agruparMaterias([
        _subject(
          id: '2',
          name: 'Zoología',
          period: '2do Cuatrimestre',
          status: SubjectStatus.passed,
          credits: 5,
        ),
        _subject(
          id: '1',
          name: 'Álgebra',
          period: '1er Cuatrimestre',
          credits: 6,
        ),
        _subject(
          id: '3',
          name: 'Análisis',
          period: '1er Cuatrimestre',
          status: SubjectStatus.passed,
          credits: 8,
        ),
      ]);

      expect(
        cuatrimestres.map((item) => item.nombre).toList(),
        ['1er Cuatrimestre', '2do Cuatrimestre'],
      );
      // The model uses deterministic Unicode ordering (not locale collation).
      expect(
        cuatrimestres.first.materias.map((item) => item.name).toList(),
        ['Análisis', 'Álgebra'],
      );
      expect(cuatrimestres.first.cantidadMaterias, 2);
      expect(cuatrimestres.first.materiasAprobadas, 1);
      expect(cuatrimestres.first.creditosTotales, 14);
      expect(cuatrimestres.first.creditosAprobados, 8);
    });

    test('agrupa períodos vacíos bajo Sin cuatrimestre', () {
      final result = Cuatrimestre.agruparMaterias([
        _subject(id: '1', name: 'Materia sin período', period: '   '),
      ]);
      expect(result, hasLength(1));
      expect(result.single.nombre, 'Sin cuatrimestre');
    });

    test('devuelve una lista vacía si no hay materias', () {
      expect(Cuatrimestre.agruparMaterias([]), isEmpty);
    });
  });
}
