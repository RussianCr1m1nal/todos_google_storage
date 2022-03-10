import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/domain/entity/failure.dart';
import 'package:todos_google_storage/domain/entity/todo.dart';
import 'package:todos_google_storage/domain/repository/todos/todos_repository.dart';

@singleton
class GetTodosUseCase {
  final TodosRepository todosRepository;

  GetTodosUseCase({required this.todosRepository});

  Future<Either<Failure, Stream<List<Todo>>>> call() async {
    try {
      return Right(await todosRepository.getTodos());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
