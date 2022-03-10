import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/domain/usecase/add_todo_usecase.dart';

@injectable
class AddTodoBloc {
  final AddTodoUseCase addTodoUseCase;

  AddTodoBloc({required this.addTodoUseCase});

  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void addTodo() async {
    (await addTodoUseCase(titleController.text, bodyController.text)).fold((failure) {
      print(failure.message);
    }, (result) {});
  }

  void dispose() {
    titleController.dispose();
    bodyController.dispose();
  }
}
