import 'package:todos_google_storage/domain/entity/todo.dart';

abstract class TodosRepository {
  Future<Stream<List<Todo>>> watchTodos();
  Future<void> addTodo(String title, String body);
  Future<void> updateTodo(String id, bool value);
}
