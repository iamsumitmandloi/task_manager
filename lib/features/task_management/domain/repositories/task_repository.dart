import '../../data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
