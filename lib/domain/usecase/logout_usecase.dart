import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/domain/entity/failure.dart';
import 'package:todos_google_storage/domain/repository/google_auth/google_auth_repository.dart';

@singleton
class LogOutUseCase {
  final GoogleAuthRepository authRepository;

  LogOutUseCase({required this.authRepository});

  Future<Either<Failure, bool>> call() async {
    try {
      await authRepository.googleLogOut();
      return const Right(true);
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
