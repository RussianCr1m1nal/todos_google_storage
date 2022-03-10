import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TodosDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getTodos(String userId);
  Future<void> addTodo(String title, String body, String userId);
  Future<void> updateTodo(String id, bool value);
}
