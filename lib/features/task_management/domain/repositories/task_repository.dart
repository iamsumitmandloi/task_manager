import '../../data/models/task_model.dart';

/// Abstract repository interface for task data operations (CRUD, streaming).
abstract class TaskRepository {
  Stream<List<TaskModel>> watchTasks();
  Future<void> addTask({required String title, String? description});
  Future<void> updateTask(
    String taskId, {
    required String title,
    String? description,
  });
  Future<void> toggleStatus(String taskId, String currentStatus);
  Future<void> deleteTask(String taskId);
}
