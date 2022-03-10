import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_google_storage/di/di.dart';
import 'package:todos_google_storage/presentation/bloc/home_bloc.dart';
import 'package:todos_google_storage/presentation/page/login_page.dart';
import 'package:todos_google_storage/presentation/page/todos_page.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeBloc>(
          create: (_) => getIt<HomeBloc>(),
          dispose: (context, homeBloc) {
            homeBloc.dispose();
          },
        ),
      ],
      child: Consumer<HomeBloc>(
        builder: (context, homeBloc, child) {
          return StreamBuilder<int>(
            stream: homeBloc.pageStream,
            builder: (context, snapshot) {
              return Scaffold(
                body: SafeArea(
                  child: PageView(
                    onPageChanged: homeBloc.onPageChanged,
                    controller: homeBloc.pageController,
                    children: const [
                      TodosPage(),
                      LoginPage(),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.check_box), label: 'Todos'),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                  ],
                  currentIndex: snapshot.data ?? 0,
                  onTap: homeBloc.onNavigationItemTap,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
