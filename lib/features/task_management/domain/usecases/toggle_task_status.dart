import '../repositories/task_repository.dart';

class ToggleTaskStatus {
  final TaskRepository _repo;
  ToggleTaskStatus(this._repo);
  Future<void> call(String id, String currentStatus) =>
      _repo.toggleStatus(id, currentStatus);
}
