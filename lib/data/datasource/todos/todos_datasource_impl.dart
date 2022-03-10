import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/data/datasource/todos/todos_datasource.dart';

@Singleton(as: TodosDataSource)
class TodosDataSourceImpl extends TodosDataSource {
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getTodos(String userId) {
    return FirebaseFirestore.instance.collection("Todos").where("user", isEqualTo: userId).snapshots();
  }

  @override
  Future<void> addTodo(String title, String body, String userId) async {
    await FirebaseFirestore.instance
        .collection("Todos")
        .add({"user": userId, "title": title, "body": body, "done": false});
  }

  @override
  Future<void> updateTodo(String id, bool value) async {
    final document = FirebaseFirestore.instance.collection("Todos").doc(id);
    await document.update({'done': value});
  }
}
