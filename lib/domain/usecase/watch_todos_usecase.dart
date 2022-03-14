import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/domain/entity/failure.dart';
import 'package:todos_google_storage/domain/entity/todo.dart';
import 'package:todos_google_storage/domain/repository/todos/todos_repository.dart';

@singleton
class WatchTodosUseCase {
  final TodosRepository todosRepository;

  WatchTodosUseCase({required this.todosRepository});

  Future<Either<Failure, Stream<List<Todo>>>> call() async {
    try {
      return Right(await todosRepository.watchTodos());
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
