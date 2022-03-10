import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_google_storage/di/di.dart';
import 'package:todos_google_storage/presentation/bloc/add_todo_bloc.dart';

class AddTodoScreen extends StatelessWidget {
  static const String routeName = '/addTodoScreen';

  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AddTodoBloc>(
          create: (_) => getIt<AddTodoBloc>(),
          dispose: (context, addTodoBloc) {
            addTodoBloc.dispose();
          },
        )
      ],
      child: Consumer<AddTodoBloc>(
        builder: ((context, addTodoBloc, child) {
          return StreamBuilder(
            builder: (context, snapshot) {
              return Scaffold(
                appBar: AppBar(),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      TextField(
                        controller: addTodoBloc.titleController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Title',
                        ),
                      ),
                      TextField(
                        controller: addTodoBloc.bodyController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Discription',
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: addTodoBloc.addTodo,
                  child: const Icon(Icons.save),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
