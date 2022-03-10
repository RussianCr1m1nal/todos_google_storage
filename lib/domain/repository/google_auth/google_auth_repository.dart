import 'package:todos_google_storage/domain/entity/google_user.dart';

abstract class GoogleAuthRepository {
  Future<void> googleLogIn();
  Future<GoogleUser> getUser();
  Future<void> googleLogOut();
}
