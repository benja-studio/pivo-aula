import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/student_profile.dart';

abstract class ProfileRepository {
  Stream<StudentProfile?> watchProfile();
  Future<StudentProfile?> getProfile();
  Future<void> saveProfile(StudentProfile profile);
}

class DriftProfileRepository implements ProfileRepository {
  final AppDatabase _db;
  DriftProfileRepository(this._db);

  @override
  Stream<StudentProfile?> watchProfile() => _db.watchProfile();

  @override
  Future<StudentProfile?> getProfile() => _db.getProfile();

  @override
  Future<void> saveProfile(StudentProfile profile) => _db.saveProfile(profile);
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftProfileRepository(db);
});

final profileStreamProvider = StreamProvider<StudentProfile?>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.watchProfile();
});
