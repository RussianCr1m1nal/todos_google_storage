import 'package:todos_google_storage/data/datasource/google_auth/google_auth_datasource.dart';
import 'package:todos_google_storage/domain/entity/google_user.dart';
import 'package:todos_google_storage/domain/repository/google_auth/google_auth_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: GoogleAuthRepository)
class GoogleAuthRepositoryImpl extends GoogleAuthRepository {
  final GoogleAuthDataSource googleAuthDataSource;

  GoogleAuthRepositoryImpl({required this.googleAuthDataSource});

  @override
  Future<void> googleLogIn() async {
    await googleAuthDataSource.googleLogin();
  }

  @override
  Future<GoogleUser> getUser() async {
    final user = await googleAuthDataSource.getUser();

    if (user == null) {
      throw Exception('Unauthenticated');
    }

    return GoogleUser(id: user.id, displayName: user.displayName ?? '');
  }

  @override
  Future<void> googleLogOut() async {
    await googleAuthDataSource.googleLogOut();
  }
}
