import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/database/app_database.dart';
import 'core/database/database_provider.dart';
import 'core/services/notification_service.dart';
import 'core/services/backup_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize offline local notifications
  await NotificationService.instance.init();

  // Pre-check if profile exists to route directly to home
  final db = AppDatabase();
  final profile = await db.getProfile();
  final hasProfile = profile != null;
  if (hasProfile) {
    await BackupService(db).performAutoBackup();
  }

  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
      ],
      child: AulaApp(hasProfile: hasProfile),
    ),
  );
}
