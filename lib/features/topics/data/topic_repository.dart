import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../domain/topic.dart';

abstract class TopicRepository {
  Stream<List<Topic>> watchTopicsForExam(String examId);
  Stream<List<Topic>> watchTopicsForSubject(String subjectId);
  Stream<List<Topic>> watchAllTopics();
  Future<void> upsertTopic(Topic topic);
  Future<void> softDeleteTopic(String id);
}

class DriftTopicRepository implements TopicRepository {
  final AppDatabase _db;
  DriftTopicRepository(this._db);

  @override
  Stream<List<Topic>> watchTopicsForExam(String examId) =>
      _db.watchTopicsForExam(examId);

  @override
  Stream<List<Topic>> watchTopicsForSubject(String subjectId) =>
      _db.watchTopicsForSubject(subjectId);

  @override
  Stream<List<Topic>> watchAllTopics() => _db.watchAllTopics();

  @override
  Future<void> upsertTopic(Topic topic) => _db.upsertTopic(topic);

  @override
  Future<void> softDeleteTopic(String id) => _db.softDeleteTopic(id);
}

final topicRepositoryProvider = Provider<TopicRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return DriftTopicRepository(db);
});

final examTopicsStreamProvider = StreamProvider.family<List<Topic>, String>((ref, examId) {
  final repo = ref.watch(topicRepositoryProvider);
  return repo.watchTopicsForExam(examId);
});

final subjectTopicsStreamProvider = StreamProvider.family<List<Topic>, String>((ref, subjectId) {
  final repo = ref.watch(topicRepositoryProvider);
  return repo.watchTopicsForSubject(subjectId);
});

final allTopicsStreamProvider = StreamProvider<List<Topic>>((ref) {
  final repo = ref.watch(topicRepositoryProvider);
  return repo.watchAllTopics();
});
