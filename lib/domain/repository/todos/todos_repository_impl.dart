import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_google_storage/data/datasource/google_auth/google_auth_datasource.dart';
import 'package:todos_google_storage/data/datasource/todos/todos_datasource.dart';
import 'package:todos_google_storage/domain/entity/todo.dart';
import 'package:todos_google_storage/domain/repository/todos/todos_repository.dart';

@Singleton(as: TodosRepository)
class TodosRepositoryImpl extends TodosRepository {
  final GoogleAuthDataSource googleAuthDataSource;
  final TodosDataSource todosDataSource;

  final BehaviorSubject<List<Todo>> _todosSubject = BehaviorSubject<List<Todo>>.seeded([]);
  StreamSubscription? todosSubscription;

  TodosRepositoryImpl({required this.googleAuthDataSource, required this.todosDataSource});

  @override
  Future<Stream<List<Todo>>> getTodos() async {
    final user = await googleAuthDataSource.getUser();

    todosSubscription?.cancel();
    todosSubscription = todosDataSource
        .getTodos(user == null ? '' : user.id)
        .map((querySnapshot) => querySnapshot.docs
            .map((map) => Todo(title: map['title'], body: map['body'], done: map['done'], id: map.id))
            .toList())
        .listen((todosList) {
      _todosSubject.add(todosList);
    });

    return _todosSubject;
  }

  @override
  Future<void> addTodo(String title, String body) async {
    final user = await googleAuthDataSource.getUser();

    if (user == null) {
      return;
    }

    todosDataSource.addTodo(title, body, user.id);
  }

  void dispose() {
    todosSubscription?.cancel();
    _todosSubject.close();
  }

  @override
  Future<void> updateTodo(String id, bool value) async {
    await todosDataSource.updateTodo(id, value);
  }
}
