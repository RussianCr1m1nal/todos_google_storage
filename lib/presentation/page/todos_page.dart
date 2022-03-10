import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_google_storage/di/di.dart';
import 'package:todos_google_storage/domain/entity/todo.dart';
import 'package:todos_google_storage/presentation/bloc/todos_bloc.dart';
import 'package:todos_google_storage/presentation/screen/add_todo_screen.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TodosBloc>(
          create: (_) => getIt<TodosBloc>(),
          dispose: (context, todosBloc) {
            todosBloc.dispose();
          },
        )
      ],
      child: Consumer<TodosBloc>(
        builder: (context, todosBloc, child) {
          return StreamBuilder<List<Todo>>(
            stream: todosBloc.todosStream,
            builder: (context, snapshot) {
              List<Todo>? todos = snapshot.data;

              if (todos == null || todos.isEmpty) {
                return const Center(child: Text('Empty'));
              }

              return Stack(
                children: [
                  ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(
                          onChanged: (value) {
                            todosBloc.onTodoChecked(todos[index].id, value ?? todos[index].done);
                          },
                          value: todos[index].done,
                        ),
                        title: Text(todos[index].title),
                        subtitle: Text(todos[index].body),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        minimumSize: const Size(50, 50),
                        primary: Theme.of(context).backgroundColor,
                      ),
                      child: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, AddTodoScreen.routeName);
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
