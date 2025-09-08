import '../repositories/task_repository.dart';

class AddTask {
  final TaskRepository _repo;
  AddTask(this._repo);
  Future<void> call(String title, String? description) =>
      _repo.addTask(title: title, description: description);
}
