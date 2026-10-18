import 'package:flutter/foundation.dart';

enum AcademicUnitType {
  university('Universidad / institución'),
  faculty('Facultad'),
  institute('Instituto'),
  department('Departamento'),
  school('Escuela'),
  custom('Ingreso manual');

  const AcademicUnitType(this.label);
  final String label;
}

@immutable
class AcademicUnit {
  const AcademicUnit({
    required this.name,
    required this.type,
    this.parent,
    this.location,
    this.aliases = const [],
  });

  final String name;
  final AcademicUnitType type;
  final String? parent;
  final String? location;
  final List<String> aliases;

  bool get isCustom => type == AcademicUnitType.custom;
  String get selectionLabel => parent == null ? name : '$name · $parent';

  String get subtitle {
    if (isCustom) return 'No figura en el catálogo · usar este nombre';
    if (parent != null) {
      if (location == null) return parent!;
      return '$parent · $location';
    }
    if (location == null) return type.label;
    return '${type.label} · $location';
  }

  String get searchableText => normalizeAcademicText(
        '$name ${parent ?? ''} ${location ?? ''} ${aliases.join(' ')}',
      );

  static AcademicUnit custom(String name) => AcademicUnit(
        name: name.trim(),
        type: AcademicUnitType.custom,
      );
}

String normalizeAcademicText(String source) {
  var value = source.toLowerCase().trim();
  const replacements = <String, String>{
    'á': 'a', 'à': 'a', 'ä': 'a', 'â': 'a',
    'é': 'e', 'è': 'e', 'ë': 'e', 'ê': 'e',
    'í': 'i', 'ì': 'i', 'ï': 'i', 'î': 'i',
    'ó': 'o', 'ò': 'o', 'ö': 'o', 'ô': 'o',
    'ú': 'u', 'ù': 'u', 'ü': 'u', 'û': 'u',
    'ñ': 'n',
  };
  for (final entry in replacements.entries) {
    value = value.replaceAll(entry.key, entry.value);
  }
  return value.replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim();
}

const List<AcademicUnit> _institutions = [
  AcademicUnit(name: 'Universidad de Buenos Aires', type: AcademicUnitType.university, location: 'CABA', aliases: ['UBA']),
  AcademicUnit(name: 'Universidad Nacional de La Plata', type: AcademicUnitType.university, location: 'La Plata, Buenos Aires', aliases: ['UNLP']),
  AcademicUnit(name: 'Universidad Nacional de Córdoba', type: AcademicUnitType.university, location: 'Córdoba', aliases: ['UNC']),
  AcademicUnit(name: 'Universidad Nacional de Rosario', type: AcademicUnitType.university, location: 'Rosario, Santa Fe', aliases: ['UNR']),
  AcademicUnit(name: 'Universidad Nacional de Quilmes', type: AcademicUnitType.university, location: 'Bernal, Buenos Aires', aliases: ['UNQ']),
  AcademicUnit(name: 'Universidad Tecnológica Nacional', type: AcademicUnitType.university, location: 'Nacional · sedes regionales', aliases: ['UTN']),
  AcademicUnit(name: 'Universidad Nacional de Tucumán', type: AcademicUnitType.university, location: 'Tucumán', aliases: ['UNT']),
  AcademicUnit(name: 'Universidad Nacional del Litoral', type: AcademicUnitType.university, location: 'Santa Fe', aliases: ['UNL']),
  AcademicUnit(name: 'Universidad Nacional de Cuyo', type: AcademicUnitType.university, location: 'Mendoza', aliases: ['UNCuyo']),
  AcademicUnit(name: 'Universidad Nacional del Sur', type: AcademicUnitType.university, location: 'Bahía Blanca', aliases: ['UNS']),
  AcademicUnit(name: 'Universidad Nacional del Nordeste', type: AcademicUnitType.university, location: 'Corrientes y Chaco', aliases: ['UNNE']),
  AcademicUnit(name: 'Universidad Nacional de Río Cuarto', type: AcademicUnitType.university, location: 'Río Cuarto, Córdoba', aliases: ['UNRC']),
  AcademicUnit(name: 'Universidad Nacional del Comahue', type: AcademicUnitType.university, location: 'Neuquén y Río Negro', aliases: ['UNCo']),
  AcademicUnit(name: 'Universidad Nacional de Salta', type: AcademicUnitType.university, location: 'Salta', aliases: ['UNSa']),
  AcademicUnit(name: 'Universidad Nacional de Catamarca', type: AcademicUnitType.university, location: 'Catamarca', aliases: ['UNCA']),
  AcademicUnit(name: 'Universidad Nacional de Lomas de Zamora', type: AcademicUnitType.university, location: 'Lomas de Zamora, Buenos Aires', aliases: ['UNLZ']),
  AcademicUnit(name: 'Universidad Nacional de Luján', type: AcademicUnitType.university, location: 'Luján, Buenos Aires', aliases: ['UNLu']),
  AcademicUnit(name: 'Universidad Nacional de La Pampa', type: AcademicUnitType.university, location: 'La Pampa', aliases: ['UNLPam']),
  AcademicUnit(name: 'Universidad Nacional de Misiones', type: AcademicUnitType.university, location: 'Misiones', aliases: ['UNaM']),
  AcademicUnit(name: 'Universidad Nacional de Santiago del Estero', type: AcademicUnitType.university, location: 'Santiago del Estero', aliases: ['UNSE']),
  AcademicUnit(name: 'Universidad Nacional de San Luis', type: AcademicUnitType.university, location: 'San Luis', aliases: ['UNSL']),
  AcademicUnit(name: 'Universidad Nacional de Entre Ríos', type: AcademicUnitType.university, location: 'Entre Ríos', aliases: ['UNER']),
  AcademicUnit(name: 'Universidad Nacional de San Juan', type: AcademicUnitType.university, location: 'San Juan', aliases: ['UNSJ']),
  AcademicUnit(name: 'Universidad Nacional de Jujuy', type: AcademicUnitType.university, location: 'Jujuy', aliases: ['UNJu']),
  AcademicUnit(name: 'Universidad Nacional del Centro de la Provincia de Buenos Aires', type: AcademicUnitType.university, location: 'Tandil y sedes', aliases: ['UNICEN', 'UNCPBA']),
  AcademicUnit(name: 'Universidad Nacional de Mar del Plata', type: AcademicUnitType.university, location: 'Mar del Plata, Buenos Aires', aliases: ['UNMDP']),
  AcademicUnit(name: 'Universidad Nacional de la Patagonia San Juan Bosco', type: AcademicUnitType.university, location: 'Chubut', aliases: ['UNPSJB']),
  AcademicUnit(name: 'Universidad Nacional de la Patagonia Austral', type: AcademicUnitType.university, location: 'Santa Cruz', aliases: ['UNPA']),
  AcademicUnit(name: 'Universidad Nacional de Formosa', type: AcademicUnitType.university, location: 'Formosa', aliases: ['UNaF']),
  AcademicUnit(name: 'Universidad Nacional de General Sarmiento', type: AcademicUnitType.university, location: 'Los Polvorines, Buenos Aires', aliases: ['UNGS']),
  AcademicUnit(name: 'Universidad Nacional de Lanús', type: AcademicUnitType.university, location: 'Lanús, Buenos Aires', aliases: ['UNLa']),
  AcademicUnit(name: 'Universidad Nacional de San Martín', type: AcademicUnitType.university, location: 'San Martín, Buenos Aires', aliases: ['UNSAM']),
  AcademicUnit(name: 'Universidad Nacional de Tres de Febrero', type: AcademicUnitType.university, location: 'Caseros, Buenos Aires', aliases: ['UNTREF']),
  AcademicUnit(name: 'Universidad Nacional del Noroeste de la Provincia de Buenos Aires', type: AcademicUnitType.university, location: 'Junín y Pergamino', aliases: ['UNNOBA']),
  AcademicUnit(name: 'Universidad Nacional Arturo Jauretche', type: AcademicUnitType.university, location: 'Florencio Varela, Buenos Aires', aliases: ['UNAJ']),
  AcademicUnit(name: 'Universidad Nacional de José Clemente Paz', type: AcademicUnitType.university, location: 'José C. Paz, Buenos Aires', aliases: ['UNPAZ']),
  AcademicUnit(name: 'Universidad Nacional de Hurlingham', type: AcademicUnitType.university, location: 'Hurlingham, Buenos Aires', aliases: ['UNAHUR']),
  AcademicUnit(name: 'Universidad Nacional de Moreno', type: AcademicUnitType.university, location: 'Moreno, Buenos Aires', aliases: ['UNM']),
  AcademicUnit(name: 'Universidad Nacional de Río Negro', type: AcademicUnitType.university, location: 'Río Negro', aliases: ['UNRN']),
  AcademicUnit(name: 'Universidad Nacional de La Rioja', type: AcademicUnitType.university, location: 'La Rioja', aliases: ['UNLaR']),
  AcademicUnit(name: 'Universidad Nacional del Chaco Austral', type: AcademicUnitType.university, location: 'Chaco', aliases: ['UNCAus']),
  AcademicUnit(name: 'Universidad Nacional de Chilecito', type: AcademicUnitType.university, location: 'Chilecito, La Rioja', aliases: ['UNdeC']),
  AcademicUnit(name: 'Universidad Nacional de Villa María', type: AcademicUnitType.university, location: 'Villa María, Córdoba', aliases: ['UNVM']),
  AcademicUnit(name: 'Universidad Nacional de Tierra del Fuego, Antártida e Islas del Atlántico Sur', type: AcademicUnitType.university, location: 'Ushuaia y Río Grande', aliases: ['UNTDF']),
  AcademicUnit(name: 'Universidad Nacional de Avellaneda', type: AcademicUnitType.university, location: 'Avellaneda, Buenos Aires', aliases: ['UNDAV']),
  AcademicUnit(name: 'Universidad Nacional del Oeste', type: AcademicUnitType.university, location: 'Merlo, Buenos Aires', aliases: ['UNO']),
  AcademicUnit(name: 'Universidad Nacional de Rafaela', type: AcademicUnitType.university, location: 'Rafaela, Santa Fe', aliases: ['UNRaf']),
  AcademicUnit(name: 'Universidad Nacional de San Antonio de Areco', type: AcademicUnitType.university, location: 'Buenos Aires', aliases: ['UNSAdA']),
  AcademicUnit(name: 'Universidad Nacional de los Comechingones', type: AcademicUnitType.university, location: 'San Luis', aliases: ['UNLC']),
  AcademicUnit(name: 'Universidad Nacional de la Defensa', type: AcademicUnitType.university, location: 'Nacional', aliases: ['UNDEF']),
  AcademicUnit(name: 'Universidad Pedagógica Nacional', type: AcademicUnitType.university, location: 'Buenos Aires', aliases: ['UNIPE']),
  AcademicUnit(name: 'Pontificia Universidad Católica Argentina', type: AcademicUnitType.university, location: 'CABA y sedes', aliases: ['UCA']),
  AcademicUnit(name: 'Universidad Argentina de la Empresa', type: AcademicUnitType.university, location: 'CABA', aliases: ['UADE']),
  AcademicUnit(name: 'Instituto Tecnológico de Buenos Aires', type: AcademicUnitType.institute, location: 'CABA', aliases: ['ITBA']),
  AcademicUnit(name: 'Universidad de Palermo', type: AcademicUnitType.university, location: 'CABA', aliases: ['UP']),
  AcademicUnit(name: 'Universidad Torcuato Di Tella', type: AcademicUnitType.university, location: 'CABA', aliases: ['UTDT', 'Di Tella']),
  AcademicUnit(name: 'Universidad Austral', type: AcademicUnitType.university, location: 'Pilar y CABA', aliases: ['Austral']),
  AcademicUnit(name: 'Universidad del Salvador', type: AcademicUnitType.university, location: 'CABA y Pilar', aliases: ['USAL']),
  AcademicUnit(name: 'Universidad de Belgrano', type: AcademicUnitType.university, location: 'CABA', aliases: ['UB']),
  AcademicUnit(name: 'Universidad Abierta Interamericana', type: AcademicUnitType.university, location: 'CABA y Rosario', aliases: ['UAI']),
  AcademicUnit(name: 'Universidad Católica de Córdoba', type: AcademicUnitType.university, location: 'Córdoba', aliases: ['UCC']),
  AcademicUnit(name: 'Universidad Católica de La Plata', type: AcademicUnitType.university, location: 'La Plata, Buenos Aires', aliases: ['UCALP']),
  AcademicUnit(name: 'Universidad de San Andrés', type: AcademicUnitType.university, location: 'Victoria, Buenos Aires', aliases: ['UdeSA']),
  AcademicUnit(name: 'Universidad Favaloro', type: AcademicUnitType.university, location: 'CABA', aliases: ['Favaloro']),
  AcademicUnit(name: 'Universidad Maimónides', type: AcademicUnitType.university, location: 'CABA', aliases: ['UMAI']),
  AcademicUnit(name: 'Universidad FASTA', type: AcademicUnitType.university, location: 'Mar del Plata, Buenos Aires', aliases: ['FASTA']),
  AcademicUnit(name: 'Universidad de Flores', type: AcademicUnitType.university, location: 'CABA y Buenos Aires', aliases: ['UFLO']),
  AcademicUnit(name: 'Universidad Kennedy', type: AcademicUnitType.university, location: 'CABA y Buenos Aires', aliases: ['UK']),
  AcademicUnit(name: 'Universidad del CEMA', type: AcademicUnitType.university, location: 'CABA', aliases: ['UCEMA']),
  AcademicUnit(name: 'Universidad Siglo 21', type: AcademicUnitType.university, location: 'Córdoba y sedes', aliases: ['Siglo XXI', 'UES21']),
  AcademicUnit(name: 'Universidad Blas Pascal', type: AcademicUnitType.university, location: 'Córdoba', aliases: ['UBP']),
  AcademicUnit(name: 'Universidad de Ciencias Empresariales y Sociales', type: AcademicUnitType.university, location: 'CABA y sedes', aliases: ['UCES']),
  AcademicUnit(name: 'Universidad de Morón', type: AcademicUnitType.university, location: 'Morón, Buenos Aires', aliases: ['UM']),
  AcademicUnit(name: 'Universidad del Aconcagua', type: AcademicUnitType.university, location: 'Mendoza', aliases: ['UDA']),
  AcademicUnit(name: 'Universidad Católica de Salta', type: AcademicUnitType.university, location: 'Salta', aliases: ['UCASAL']),
  AcademicUnit(name: 'Universidad Católica de Santa Fe', type: AcademicUnitType.university, location: 'Santa Fe', aliases: ['UCSF']),
  AcademicUnit(name: 'Universidad Adventista del Plata', type: AcademicUnitType.university, location: 'Entre Ríos', aliases: ['UAP']),
  AcademicUnit(name: 'Universidad de Concepción del Uruguay', type: AcademicUnitType.university, location: 'Entre Ríos', aliases: ['UCU']),
  AcademicUnit(name: 'Instituto Universitario CEMIC', type: AcademicUnitType.institute, location: 'CABA', aliases: ['CEMIC']),
  AcademicUnit(name: 'Instituto Universitario Hospital Italiano de Buenos Aires', type: AcademicUnitType.institute, location: 'CABA', aliases: ['IUHIBA']),
  AcademicUnit(name: 'Instituto Universitario de Ciencias de la Salud Fundación Barceló', type: AcademicUnitType.institute, location: 'CABA y sedes', aliases: ['Barceló']),
  AcademicUnit(name: 'Instituto Universitario de Salud Mental', type: AcademicUnitType.institute, location: 'CABA', aliases: ['IUSAM']),
  AcademicUnit(name: 'Instituto Balseiro', type: AcademicUnitType.institute, parent: 'Universidad Nacional de Cuyo · CNEA', location: 'Bariloche, Río Negro', aliases: ['Balseiro']),
  AcademicUnit(name: 'Instituto de Tecnología Prof. Jorge Sabato', type: AcademicUnitType.institute, parent: 'Universidad Nacional de San Martín · CNEA', location: 'Buenos Aires', aliases: ['Instituto Sabato']),
];

List<AcademicUnit> _facultiesFor(String university, String acronym, String location, List<String> names) {
  return names.map((name) => AcademicUnit(
    name: name.startsWith('Facultad ') ? name : 'Facultad de $name',
    type: AcademicUnitType.faculty,
    parent: university,
    location: location,
    aliases: [acronym, name],
  )).toList(growable: false);
}

const List<String> _ubaFaculties = [
  'Agronomía', 'Arquitectura, Diseño y Urbanismo', 'Ciencias Económicas',
  'Ciencias Exactas y Naturales', 'Ciencias Sociales', 'Ciencias Veterinarias',
  'Derecho', 'Farmacia y Bioquímica', 'Filosofía y Letras', 'Ingeniería',
  'Medicina', 'Odontología', 'Psicología',
];
const List<String> _unlpFaculties = [
  'Facultad de Arquitectura y Urbanismo', 'Facultad de Artes',
  'Facultad de Ciencias Agrarias y Forestales', 'Facultad de Ciencias Astronómicas y Geofísicas',
  'Facultad de Ciencias Económicas', 'Facultad de Ciencias Exactas',
  'Facultad de Ciencias Jurídicas y Sociales', 'Facultad de Ciencias Médicas',
  'Facultad de Ciencias Naturales y Museo', 'Facultad de Ciencias Veterinarias',
  'Facultad de Humanidades y Ciencias de la Educación', 'Facultad de Ingeniería',
  'Facultad de Informática', 'Facultad de Odontología',
  'Facultad de Periodismo y Comunicación Social', 'Facultad de Psicología',
  'Facultad de Trabajo Social',
];
const List<String> _uncFaculties = [
  'Artes', 'Ciencias Agropecuarias', 'Arquitectura, Urbanismo y Diseño',
  'Derecho', 'Ciencias de la Comunicación', 'Ciencias Sociales',
  'Ciencias Económicas', 'Ciencias Exactas, Físicas y Naturales',
  'Filosofía y Humanidades', 'Lenguas',
  'Matemática, Astronomía, Física y Computación', 'Ciencias Médicas',
  'Odontología', 'Psicología', 'Ciencias Químicas',
];
const List<String> _unrFaculties = [
  'Arquitectura, Planeamiento y Diseño', 'Ciencias Agrarias',
  'Ciencias Bioquímicas y Farmacéuticas', 'Ciencias Económicas y Estadística',
  'Ciencias Exactas, Ingeniería y Agrimensura', 'Ciencias Médicas',
  'Ciencias del Movimiento Humano y del Cuidado',
  'Ciencia Política y Relaciones Internacionales', 'Ciencias Veterinarias',
  'Derecho', 'Humanidades y Artes', 'Odontología', 'Psicología',
];
const List<List<String>> _utnRegionalFaculties = [
  ['Avellaneda', 'FRA', 'Avellaneda, Buenos Aires'],
  ['Bahía Blanca', 'FRBB', 'Bahía Blanca, Buenos Aires'],
  ['Buenos Aires', 'FRBA', 'CABA'],
  ['Chubut', 'FRCh', 'Puerto Madryn, Chubut'],
  ['Concepción del Uruguay', 'FRCU', 'Entre Ríos'],
  ['Concordia', 'FRCon', 'Entre Ríos'],
  ['Córdoba', 'FRC', 'Córdoba'],
  ['Delta', 'FRD', 'Campana, Buenos Aires'],
  ['General Pacheco', 'FRGP', 'Buenos Aires'],
  ['Haedo', 'FRH', 'Buenos Aires'],
  ['La Plata', 'FRLP', 'La Plata, Buenos Aires'],
  ['La Rioja', 'FRLR', 'La Rioja'],
  ['Mar del Plata', 'FRMDP', 'Buenos Aires'],
  ['Mendoza', 'FRM', 'Mendoza'],
  ['Neuquén', 'FRN', 'Neuquén'],
  ['Paraná', 'FRP', 'Entre Ríos'],
  ['Rafaela', 'FRRA', 'Santa Fe'],
  ['Reconquista', 'FRRq', 'Santa Fe'],
  ['Resistencia', 'FRRe', 'Chaco'],
  ['Rosario', 'FRRo', 'Santa Fe'],
  ['San Francisco', 'FRSFco', 'Córdoba'],
  ['San Nicolás', 'FRSN', 'Buenos Aires'],
  ['San Rafael', 'FRSR', 'Mendoza'],
  ['Santa Cruz', 'FRSC', 'Santa Cruz'],
  ['Santa Fe', 'FRSF', 'Santa Fe'],
  ['Tierra del Fuego', 'FRTDF', 'Río Grande, Tierra del Fuego'],
  ['Trenque Lauquen', 'FRTL', 'Buenos Aires'],
  ['Tucumán', 'FRT', 'Tucumán'],
  ['Venado Tuerto', 'FRVT', 'Santa Fe'],
  ['Villa María', 'FRVM', 'Córdoba'],
];

final List<AcademicUnit> academicUnitCatalog = List.unmodifiable([
  ..._institutions,
  ..._facultiesFor('Universidad de Buenos Aires', 'UBA', 'CABA', _ubaFaculties),
  ..._facultiesFor('Universidad Nacional de La Plata', 'UNLP', 'La Plata, Buenos Aires', _unlpFaculties),
  ..._facultiesFor('Universidad Nacional de Córdoba', 'UNC', 'Córdoba', _uncFaculties),
  ..._facultiesFor('Universidad Nacional de Rosario', 'UNR', 'Rosario, Santa Fe', _unrFaculties),
  const AcademicUnit(name: 'Departamento de Ciencias Sociales', type: AcademicUnitType.department, parent: 'Universidad Nacional de Quilmes', location: 'Bernal, Buenos Aires', aliases: ['UNQ', 'Sociales']),
  const AcademicUnit(name: 'Departamento de Ciencia y Tecnología', type: AcademicUnitType.department, parent: 'Universidad Nacional de Quilmes', location: 'Bernal, Buenos Aires', aliases: ['UNQ']),
  const AcademicUnit(name: 'Departamento de Economía y Administración', type: AcademicUnitType.department, parent: 'Universidad Nacional de Quilmes', location: 'Bernal, Buenos Aires', aliases: ['UNQ']),
  const AcademicUnit(name: 'Escuela Universitaria de Artes', type: AcademicUnitType.school, parent: 'Universidad Nacional de Quilmes', location: 'Bernal, Buenos Aires', aliases: ['UNQ']),
  ..._utnRegionalFaculties.map((row) => AcademicUnit(
    name: 'Facultad Regional ${row[0]}',
    type: AcademicUnitType.faculty,
    parent: 'Universidad Tecnológica Nacional',
    location: row[2],
    aliases: ['UTN', row[1]],
  )),
]);

List<AcademicUnit> searchAcademicUnits(String query, {int limit = 10}) {
  final normalizedQuery = normalizeAcademicText(query);
  if (normalizedQuery.isEmpty || limit < 1) return const [];
  final tokens = normalizedQuery.split(' ');
  final scored = <({AcademicUnit unit, int score})>[];

  for (final unit in academicUnitCatalog) {
    final searchable = unit.searchableText;
    if (!tokens.every(searchable.contains)) continue;
    final name = normalizeAcademicText(unit.name);
    final selection = normalizeAcademicText(unit.selectionLabel);
    var score = 60;
    if (name == normalizedQuery) {
      score = 0;
    } else if (selection == normalizedQuery) {
      score = 1;
    } else if (name.startsWith(normalizedQuery)) {
      score = 10;
    } else if (selection.startsWith(normalizedQuery)) {
      score = 20;
    } else if (unit.parent != null && normalizeAcademicText(unit.parent!).startsWith(normalizedQuery)) {
      score = 25;
    } else if (unit.type == AcademicUnitType.university) {
      score = 30;
    }
    scored.add((unit: unit, score: score));
  }

  scored.sort((a, b) {
    final score = a.score.compareTo(b.score);
    return score != 0 ? score : a.unit.name.compareTo(b.unit.name);
  });
  return scored.take(limit).map((entry) => entry.unit).toList(growable: false);
}
