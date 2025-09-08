import 'package:flutter/material.dart';
import 'package:task_manager/features/task_management/domain/entities/task_status.dart';
import '../../data/models/task_model.dart';

class TaskListItem extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggle;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status.isCompleted;
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: (task.description == null || task.description!.isEmpty)
          ? null
          : Text(
              task.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
      leading: Checkbox(
        value: isCompleted,
        onChanged: (v) => onToggle(v ?? false),
      ),
      trailing: Wrap(
        spacing: 4,
        children: [
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: onEdit),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
