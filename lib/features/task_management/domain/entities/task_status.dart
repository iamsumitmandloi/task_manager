enum TaskStatus { pending, completed }

extension TaskStatusX on TaskStatus {
  String get asString => this == TaskStatus.completed ? 'completed' : 'pending';
  bool get isCompleted => this == TaskStatus.completed;
  static TaskStatus fromString(String? value) {
    if (value == 'completed') return TaskStatus.completed;
    return TaskStatus.pending;
  }
}
