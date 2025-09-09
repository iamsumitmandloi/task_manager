import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/routes/app_router.dart';
import 'package:task_manager/injection_container.dart';
import '../../domain/entities/task_status.dart';
import '../../presentation/cubit/task_list_cubit.dart';
import '../widgets/task_list_item.dart';
import '../widgets/task_filters.dart';
import '../widgets/add_edit_task_dialog.dart';
import '../widgets/empty_state.dart';

@RoutePage()
class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late final TaskListCubit _cubit;
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    _cubit = sl<TaskListCubit>();
    _cubit.subscribe();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _addTaskDialog() async {
    final result = await showAddEditTaskDialog(context: context);
    if (result != null) {
      final title = result['title'] ?? '';
      final desc = result['description'];
      if (title.length < 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Title must be at least 3 characters')),
        );
        return;
      }
      try {
        await _cubit.addTask(title, desc);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Task created')));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to add task')));
      }
    } else {}
  }

  Future<void> _editTaskDialog(
    String taskId,
    String currentTitle,
    String? currentDesc,
  ) async {
    final result = await showAddEditTaskDialog(
      context: context,
      initialTitle: currentTitle,
      initialDescription: currentDesc,
      isEdit: true,
    );
    if (result != null) {
      final title = result['title'] ?? '';
      final desc = result['description'];
      if (title.length < 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Title must be at least 3 characters')),
        );
        return;
      }
      try {
        await _cubit.updateTask(taskId, title, desc);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Task updated')));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to update task')));
      }
    } else {}
  }

  Future<void> _confirmDelete(String taskId) async {
    final res = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (res == true) {
      try {
        await _cubit.deleteTask(taskId);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Task deleted')));
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to delete task')));
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tasks'),
          actions: [
            IconButton(
              tooltip: 'Sign out',
              onPressed: () async {
                await fb_auth.FirebaseAuth.instance.signOut();
                if (!mounted) return;
                context.replaceRoute(const AuthRoute());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            TaskFilters(
              current: _filter,
              onChanged: (f) {
                setState(() => _filter = f);
              },
            ),
            Expanded(
              child: BlocBuilder<TaskListCubit, TaskListState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.error != null) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  var tasks = state.tasks;
                  if (_filter != 'all') {
                    final target = TaskStatusX.fromString(_filter);
                    tasks = tasks.where((t) => t.status == target).toList();
                  }
                  if (tasks.isEmpty) {
                    return const EmptyState(message: 'No tasks');
                  }
                  return ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final t = tasks[index];
                      return TaskListItem(
                        task: t,
                        onEdit: () =>
                            _editTaskDialog(t.id, t.title, t.description),
                        onDelete: () => _confirmDelete(t.id),
                        onToggle: (_) async {
                          await _cubit.toggleStatus(t.id, t.status.asString);
                          if (mounted) {
                            final toggled = t.status.isCompleted
                                ? 'Pending'
                                : 'Completed';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Marked $toggled')),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTaskDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
