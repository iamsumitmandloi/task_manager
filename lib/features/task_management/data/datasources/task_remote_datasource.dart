import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import '../../domain/entities/task_status.dart';

class TaskRemoteDataSource {
  final FirebaseFirestore _db;
  final fb_auth.FirebaseAuth _auth;

  TaskRemoteDataSource(this._db, this._auth) {
    debugPrint(
      '[TasksDS] Initialized with db=${_db.app.name} user=${_auth.currentUser?.uid}',
    );
  }

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
    debugPrint('[TasksDS] watchTasks() start for uid=$_uid');
    return _tasksCol.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addTask({required String title, String? description}) async {
    debugPrint(
      '[TasksDS] addTask title="$title" descLen=${description?.length ?? 0}',
    );
    await _tasksCol.add({
      'title': title,
      'description': description,
      'status': TaskStatus.pending.asString,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
    debugPrint('[TasksDS] addTask DONE');
  }

  Future<void> updateTask(
    String taskId, {
    required String title,
    String? description,
  }) async {
    debugPrint(
      '[TasksDS] updateTask id=$taskId title="$title" descLen=${description?.length ?? 0}',
    );
    await _tasksCol.doc(taskId).update({
      'title': title,
      'description': description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    debugPrint('[TasksDS] updateTask DONE id=$taskId');
  }

  Future<void> toggleStatus(String taskId, String currentStatus) async {
    final current = TaskStatusX.fromString(currentStatus);
    final newStatus = current == TaskStatus.pending
        ? TaskStatus.completed
        : TaskStatus.pending;
    debugPrint(
      '[TasksDS] toggleStatus id=$taskId ${current.asString} -> ${newStatus.asString}',
    );
    await _tasksCol.doc(taskId).update({
      'status': newStatus.asString,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    debugPrint('[TasksDS] toggleStatus DONE id=$taskId');
  }

  Future<void> deleteTask(String taskId) async {
    debugPrint('[TasksDS] deleteTask id=$taskId');
    await _tasksCol.doc(taskId).delete();
    debugPrint('[TasksDS] deleteTask DONE id=$taskId');
  }
}
