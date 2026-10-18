import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../data/topic_repository.dart';
import '../domain/topic.dart';

class TopicController extends StateNotifier<AsyncValue<void>> {
  final TopicRepository _repo;

  TopicController(this._repo) : super(const AsyncValue.data(null));

  Future<void> createTopic({
    String? examId,
    required String subjectId,
    required String title,
    TopicStatus status = TopicStatus.todo,
    TopicPriority priority = TopicPriority.medium,
    int sortOrder = 0,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final now = DateTime.now();
      final topic = Topic(
        id: const Uuid().v4(),
        examId: examId,
        subjectId: subjectId,
        title: title.trim(),
        status: status,
        priority: priority,
        sortOrder: sortOrder,
        notes: notes?.trim().isEmpty == true ? null : notes?.trim(),
        createdAt: now,
        updatedAt: now,
      );
      await _repo.upsertTopic(topic);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTopic(Topic topic) async {
    state = const AsyncValue.loading();
    try {
      final updated = topic.copyWith(updatedAt: DateTime.now());
      await _repo.upsertTopic(updated);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleStatus(Topic topic) async {
    final nextStatus = switch (topic.status) {
      TopicStatus.todo => TopicStatus.studying,
      TopicStatus.studying => TopicStatus.reviewed,
      TopicStatus.reviewed => TopicStatus.mastered,
      TopicStatus.mastered => TopicStatus.todo,
    };
    await updateTopic(topic.copyWith(status: nextStatus));
  }

  Future<void> reorderTopics(List<Topic> topics, int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final topic = topics.removeAt(oldIndex);
    topics.insert(newIndex, topic);

    for (int i = 0; i < topics.length; i++) {
      final t = topics[i];
      if (t.sortOrder != i) {
        await _repo.upsertTopic(t.copyWith(sortOrder: i, updatedAt: DateTime.now()));
      }
    }
  }

  Future<void> deleteTopic(String id) async {
    try {
      await _repo.softDeleteTopic(id);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final topicControllerProvider =
    StateNotifierProvider<TopicController, AsyncValue<void>>((ref) {
  final repo = ref.watch(topicRepositoryProvider);
  return TopicController(repo);
});
