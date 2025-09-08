import '../repositories/task_repository.dart';
import '../../data/models/task_model.dart';

class GetTasks {
  final TaskRepository _repo;
  GetTasks(this._repo);
  Stream<List<TaskModel>> call() => _repo.watchTasks();
}
