import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/di/di.dart';
import 'package:todos_google_storage/presentation/screen/add_todo_screen.dart';
import 'package:todos_google_storage/presentation/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies(Environment.dev);
  runApp(const TodosApp());
}

class TodosApp extends StatelessWidget {
  const TodosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      routes: {
        HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
        AddTodoScreen.routeName: (BuildContext context) => const AddTodoScreen()
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
