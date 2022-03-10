import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/domain/entity/failure.dart';
import 'package:todos_google_storage/domain/repository/todos/todos_repository.dart';

@singleton
class UpdateTodoUseCase {
  final TodosRepository todosRepository;

  UpdateTodoUseCase({required this.todosRepository});

  Future<Either<Failure, void>> call(String id, bool value) async {
    try {
      return Right(await todosRepository.updateTodo(id, value));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
