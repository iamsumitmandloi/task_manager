import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remote;

  TaskRepositoryImpl(this._remote);

  @override
  Stream<List<TaskModel>> watchTasks() {
    return _remote.watchTasks().map((snap) {
      return snap.docs.map((d) => TaskModel.fromDoc(d.id, d.data())).toList();
    });
  }

  @override
  Future<void> addTask({required String title, String? description}) {
    return _remote.addTask(title: title, description: description);
  }

  @override
  Future<void> updateTask(
    String taskId, {
    required String title,
    String? description,
  }) {
    return _remote.updateTask(taskId, title: title, description: description);
  }

  @override
  Future<void> toggleStatus(String taskId, String currentStatus) {
    return _remote.toggleStatus(taskId, currentStatus);
  }

  @override
  Future<void> deleteTask(String taskId) {
    return _remote.deleteTask(taskId);
  }
}
