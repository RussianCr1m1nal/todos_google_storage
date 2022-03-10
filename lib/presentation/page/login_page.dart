import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos_google_storage/di/di.dart';
import 'package:todos_google_storage/domain/entity/google_user.dart';
import 'package:todos_google_storage/presentation/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<LoginBloc>(
            create: (_) => getIt<LoginBloc>(),
            dispose: (context, loginBloc) {
              loginBloc.dispose();
            },
          )
        ],
        child: Consumer<LoginBloc>(
          builder: (context, loginBloc, child) {
            return StreamBuilder<GoogleUser?>(
              stream: loginBloc.userStream,
              builder: (context, snapshot) {
                final GoogleUser? user = snapshot.data;

                if (user == null) {
                  return Center(
                    child: ElevatedButton(child: const Text('Log In'), onPressed: loginBloc.onLogin),
                  );
                }

                return Center(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(user.displayName),
                    ElevatedButton(onPressed: loginBloc.onLogOut, child: const Text('Log Out')),
                  ]),
                );
              },
            );
          },
        ));
  }
}
