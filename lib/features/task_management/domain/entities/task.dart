import 'package:equatable/equatable.dart';


class Task extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String status; 
  final DateTime createdAt;
  final DateTime updatedAt;

  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    status,
    createdAt,
    updatedAt,
  ];
}
