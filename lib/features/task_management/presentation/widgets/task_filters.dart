import 'package:flutter/material.dart';

class TaskFilters extends StatelessWidget {
  final String current;
  final ValueChanged<String> onChanged;
  const TaskFilters({
    super.key,
    required this.current,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Wrap(
        spacing: 8,
        children: [
          ChoiceChip(
            label: const Text('All'),
            selected: current == 'all',
            onSelected: (_) => onChanged('all'),
          ),
          ChoiceChip(
            label: const Text('Pending'),
            selected: current == 'pending',
            onSelected: (_) => onChanged('pending'),
          ),
          ChoiceChip(
            label: const Text('Completed'),
            selected: current == 'completed',
            onSelected: (_) => onChanged('completed'),
          ),
        ],
      ),
    );
  }
}
