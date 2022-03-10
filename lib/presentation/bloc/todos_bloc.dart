import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todos_google_storage/domain/entity/todo.dart';
import 'package:todos_google_storage/domain/usecase/get_todos_usecase.dart';
import 'package:todos_google_storage/domain/usecase/update_todo_usecase.dart';

@injectable
class TodosBloc {
  final GetTodosUseCase getTodosUseCase;
  final UpdateTodoUseCase updateTodoUseCase;

  final BehaviorSubject<List<Todo>> _todosSubject = BehaviorSubject<List<Todo>>.seeded([]);
  StreamSubscription? todosSubscription;

  Stream<List<Todo>> get todosStream => _todosSubject.stream;

  TodosBloc({required this.getTodosUseCase, required this.updateTodoUseCase}) {
    loadTodos();
  }

  void loadTodos() async {
    (await getTodosUseCase()).fold((failure) {
      _todosSubject.add([]);
      print(failure.message);
    }, (todosStream) {
      todosSubscription?.cancel();
      todosSubscription = todosStream.listen((todos) {
        _todosSubject.add(todos);
      });
    });
  }

  void onTodoChecked(String id, bool value) async {
    (await updateTodoUseCase(id, value)).fold((failure) {
      print(failure.message);
    }, (result) {});
  }

  void dispose() {
    _todosSubject.close();
  }
}
