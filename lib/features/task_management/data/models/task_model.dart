import '../../domain/entities/task_status.dart';

class TaskModel {
  final String id;
  final String title;
  final String? description;
  final TaskStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromDoc(String id, Map<String, dynamic> data) {
    return TaskModel(
      id: id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String?,
      status: TaskStatusX.fromString(data['status'] as String?),
      createdAt: (data['createdAt'] is DateTime)
          ? data['createdAt'] as DateTime
          : null,
      updatedAt: (data['updatedAt'] is DateTime)
          ? data['updatedAt'] as DateTime
          : null,
    );
  }

  Map<String, dynamic> toMapForCreate() {
    return {
      'title': title,
      'description': description,
      'status': status.asString,
    };
  }

  Map<String, dynamic> toMapForUpdate() {
    return {
      'title': title,
      'description': description,
      'status': status.asString,
    };
  }
}
