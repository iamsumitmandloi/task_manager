import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../domain/entities/task_status.dart';

/// Remote data source for task operations using Cloud Firestore.
class TaskRemoteDataSource {
  final FirebaseFirestore _db;
  final fb_auth.FirebaseAuth _auth;

  TaskRemoteDataSource(this._db, this._auth);

  String get _uid {
    final user = _auth.currentUser;
    if (user == null) {
      throw StateError('Not authenticated');
    }
    return user.uid;
  }

  CollectionReference<Map<String, dynamic>> get _tasksCol =>
      _db.collection('users').doc(_uid).collection('tasks');

  Stream<QuerySnapshot<Map<String, dynamic>>> watchTasks() {
    return _tasksCol.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addTask({required String title, String? description}) async {
    await _tasksCol.add({
      'title': title,
      'description': description,
      'status': TaskStatus.pending.asString,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTask(
    String taskId, {
    required String title,
    String? description,
  }) async {
    await _tasksCol.doc(taskId).update({
      'title': title,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> toggleStatus(String taskId, String currentStatus) async {
    final current = TaskStatusX.fromString(currentStatus);
    final newStatus = current == TaskStatus.pending
        ? TaskStatus.completed
        : TaskStatus.pending;
    await _tasksCol.doc(taskId).update({
      'status': newStatus.asString,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteTask(String taskId) async {
    await _tasksCol.doc(taskId).delete();
  }
}
