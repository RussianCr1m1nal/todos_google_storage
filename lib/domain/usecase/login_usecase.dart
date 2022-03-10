import 'package:dartz/dartz.dart';
import 'package:todos_google_storage/domain/entity/failure.dart';
import 'package:todos_google_storage/domain/repository/google_auth/google_auth_repository.dart';
import 'package:injectable/injectable.dart';

@singleton
class LoginUseCase {
  final GoogleAuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Either<Failure, bool>> call() async {
    try {
      await authRepository.googleLogIn();
      return const Right(true);
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
