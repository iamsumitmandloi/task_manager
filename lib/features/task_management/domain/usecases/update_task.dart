import '../repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository _repo;
  UpdateTask(this._repo);
  Future<void> call(String id, String title, String? description) =>
      _repo.updateTask(id, title: title, description: description);
}
