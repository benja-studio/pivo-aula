import 'package:flutter_test/flutter_test.dart';
import 'package:pivo_aula/features/profile/domain/academic_unit_catalog.dart';

void main() {
  test('finds faculties by university acronym and subject', () {
    final results = searchAcademicUnits('UBA ingenieria');
    expect(results.any((unit) =>
      unit.name == 'Facultad de Ingeniería' &&
      unit.parent == 'Universidad de Buenos Aires'), isTrue);
  });

  test('search ignores accents', () {
    expect(searchAcademicUnits('Cordoba').any((unit) =>
      unit.name == 'Universidad Nacional de Córdoba'), isTrue);
  });

  test('catalog supports institution aliases and local faculties', () {
    expect(searchAcademicUnits('UTN Avellaneda').any((unit) =>
      unit.name == 'Facultad Regional Avellaneda'), isTrue);
    expect(searchAcademicUnits('Instituto Balseiro').any((unit) =>
      unit.name == 'Instituto Balseiro'), isTrue);
  });
}
