# Aula

App personal para estudiantes universitarios. 100% offline, 100% gratuita, sin cuentas ni servidores.

## Requisitos
- Flutter SDK (3.5.0 o superior)
- Dart SDK 3+
- Android SDK (minSdk 24)

## Cómo correr el proyecto

1. Instalar dependencias:
```bash
flutter pub get
```

2. Generar código de Drift y serializadores:
```bash
dart run build_runner build --delete-conflicting-outputs
```

3. Ejecutar en emulador o dispositivo Android:
```bash
flutter run
```

## Compilación para Producción (Release)

Generar APK:
```bash
flutter build apk --release
```

Generar Android App Bundle (AAB):
```bash
flutter build appbundle --release
```

## Ejecución de Pruebas Unitarias
```bash
flutter test
```
