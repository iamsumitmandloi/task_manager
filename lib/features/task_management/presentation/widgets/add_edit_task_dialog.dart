import 'package:flutter/material.dart';

Future<Map<String, String?>?> showAddEditTaskDialog({
  required BuildContext context,
  String? initialTitle,
  String? initialDescription,
  bool isEdit = false,
}) async {
  final titleCtrl = TextEditingController(text: initialTitle ?? '');
  final descCtrl = TextEditingController(text: initialDescription ?? '');
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(isEdit ? 'Edit Task' : 'Add Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleCtrl,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descCtrl,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(ctx).pop(true),
          child: Text(isEdit ? 'Save' : 'Add'),
        ),
      ],
    ),
  );
  if (result == true) {
    return {
      'title': titleCtrl.text.trim(),
      'description': descCtrl.text.trim().isEmpty ? null : descCtrl.text.trim(),
    };
  }
  return null;
}
