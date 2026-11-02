import 'subject.dart';

/// Agrupación académica calculada a partir del período guardado en cada materia.
///
/// No crea una tabla nueva: utiliza [Subject.period], por lo que conserva los
/// datos actuales y no requiere migraciones de la base SQLite.
class Cuatrimestre {
  final String nombre;
  final List<Subject> materias;

  const Cuatrimestre({
    required this.nombre,
    required this.materias,
  });

  int get cantidadMaterias => materias.length;

  int get materiasAprobadas =>
      materias.where((materia) => materia.status == SubjectStatus.passed).length;

  int get creditosTotales =>
      materias.fold(0, (sum, materia) => sum + (materia.credits ?? 0));

  int get creditosAprobados => materias
      .where((materia) => materia.status == SubjectStatus.passed)
      .fold(0, (sum, materia) => sum + (materia.credits ?? 0));

  static int _compareSpanishNames(String a, String b) {
    String normalize(String value) => value
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ñ', 'nz');
    return normalize(a).compareTo(normalize(b));
  }

  /// Agrupa las materias por cuatrimestre y ordena tanto los grupos como
  /// las materias para que la pantalla sea predecible.
  static List<Cuatrimestre> agruparMaterias(Iterable<Subject> materias) {
    final grupos = <String, List<Subject>>{};

    for (final materia in materias) {
      final periodo = materia.period.trim().isEmpty
          ? 'Sin cuatrimestre'
          : materia.period.trim();
      grupos.putIfAbsent(periodo, () => <Subject>[]).add(materia);
    }

    final cuatrimestres = grupos.entries.map((entry) {
      final ordenadas = [...entry.value]
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return Cuatrimestre(
        nombre: entry.key,
        materias: List<Subject>.unmodifiable(ordenadas),
      );
    }).toList()
      ..sort((a, b) => _compareSpanishNames(a.nombre, b.nombre));

    return List<Cuatrimestre>.unmodifiable(cuatrimestres);
  }
}
