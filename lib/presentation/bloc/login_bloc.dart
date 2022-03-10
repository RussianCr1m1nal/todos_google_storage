import 'package:rxdart/rxdart.dart';
import 'package:todos_google_storage/domain/entity/google_user.dart';
import 'package:todos_google_storage/domain/usecase/get_user_usecase.dart';
import 'package:todos_google_storage/domain/usecase/login_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/domain/usecase/logout_usecase.dart';

@injectable
class LoginBloc {
  final LoginUseCase loginUseCase;
  final GetUserUseCase getUserUseCase;
  final LogOutUseCase logOutUseCase;

  final BehaviorSubject<GoogleUser?> _userSubject = BehaviorSubject<GoogleUser?>.seeded(null);
  Stream<GoogleUser?> get userStream => _userSubject.stream;

  LoginBloc({required this.loginUseCase, required this.getUserUseCase, required this.logOutUseCase}) {
    _checkAuth();
  }

  Future<void> onLogin() async {
    (await loginUseCase()).fold((failure) {
      print(failure.message);
    }, (logedIn) {
      _checkAuth();
    });
  }

  Future<void> onLogOut() async {
    (await logOutUseCase()).fold((failure) {
      print(failure.message);
    }, (logedOut) {
      _checkAuth();
    });
  }

  void _checkAuth() async {
    (await getUserUseCase()).fold((failure) {
      _userSubject.add(null);
    }, (googleUser) {
      _userSubject.add(googleUser);
    });
  }

  void dispose() {
    _userSubject.close();
  }
}
