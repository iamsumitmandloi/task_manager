import '../repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository _repo;
  DeleteTask(this._repo);
  Future<void> call(String id) => _repo.deleteTask(id);
}
