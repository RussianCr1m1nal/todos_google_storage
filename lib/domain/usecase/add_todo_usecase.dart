import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todos_google_storage/domain/entity/failure.dart';
import 'package:todos_google_storage/domain/repository/todos/todos_repository.dart';

@singleton
class AddTodoUseCase {
  final TodosRepository todosRepository;

  AddTodoUseCase({required this.todosRepository});

  Future<Either<Failure, void>> call(String title, String body) async {
    try {
      return Right(await todosRepository.addTodo(title, body));
    } catch (exception) {
      return Left(Failure(message: exception.toString()));
    }
  }
}
