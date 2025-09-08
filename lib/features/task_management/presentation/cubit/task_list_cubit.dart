import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/task_repository.dart';
import '../../data/models/task_model.dart';

class TaskListState {
  final bool loading;
  final List<TaskModel> tasks;
  final String? error;

  const TaskListState({required this.loading, required this.tasks, this.error});

  TaskListState copyWith({
    bool? loading,
    List<TaskModel>? tasks,
    String? error,
  }) {
    return TaskListState(
      loading: loading ?? this.loading,
      tasks: tasks ?? this.tasks,
      error: error,
    );
  }

  const TaskListState.initial()
    : loading = true,
      tasks = const [],
      error = null;
}

class TaskListCubit extends Cubit<TaskListState> {
  final TaskRepository _repo;
  TaskListCubit(this._repo) : super(const TaskListState.initial());

  void subscribe() {
    emit(state.copyWith(loading: true, error: null));
    _repo.watchTasks().listen(
      (data) {
        emit(TaskListState(loading: false, tasks: data, error: null));
      },
      onError: (e) {
        emit(
          TaskListState(loading: false, tasks: const [], error: e.toString()),
        );
      },
    );
  }

  Future<void> addTask(String title, String? description) =>
      _repo.addTask(title: title, description: description);
  Future<void> updateTask(String id, String title, String? description) =>
      _repo.updateTask(id, title: title, description: description);
  Future<void> toggleStatus(String id, String status) =>
      _repo.toggleStatus(id, status);
  Future<void> deleteTask(String id) => _repo.deleteTask(id);
}
