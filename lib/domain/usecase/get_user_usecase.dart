import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/domain/entity/failure.dart';
import 'package:todos_google_storage/domain/entity/google_user.dart';
import 'package:todos_google_storage/domain/repository/google_auth/google_auth_repository.dart';

@singleton
class GetUserUseCase {
  final GoogleAuthRepository googleAuthRepository;

  GetUserUseCase({required this.googleAuthRepository});

  Future<Either<Failure, GoogleUser>> call() async {
    try {
      return Right(await googleAuthRepository.getUser());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
