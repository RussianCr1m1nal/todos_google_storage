// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/datasource/google_auth/google_auth_datasource.dart' as _i3;
import '../data/datasource/google_auth/google_auth_datasource_impl.dart' as _i4;
import '../data/datasource/todos/todos_datasource.dart' as _i10;
import '../data/datasource/todos/todos_datasource_impl.dart' as _i11;
import '../domain/repository/google_auth/google_auth_repository.dart' as _i5;
import '../domain/repository/google_auth/google_auth_repository_impl.dart'
    as _i6;
import '../domain/repository/todos/todos_repository.dart' as _i12;
import '../domain/repository/todos/todos_repository_impl.dart' as _i13;
import '../domain/usecase/add_todo_usecase.dart' as _i15;
import '../domain/usecase/watch_todos_usecase.dart' as _i16;
import '../domain/usecase/get_user_usecase.dart' as _i17;
import '../domain/usecase/login_usecase.dart' as _i9;
import '../domain/usecase/logout_usecase.dart' as _i8;
import '../domain/usecase/update_todo_usecase.dart' as _i14;
import '../presentation/bloc/add_todo_bloc.dart' as _i20;
import '../presentation/bloc/home_bloc.dart' as _i7;
import '../presentation/bloc/login_bloc.dart' as _i18;
import '../presentation/bloc/todos_bloc.dart'
    as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.GoogleAuthDataSource>(_i4.GoogleAuthDataSourceImpl());
  gh.singleton<_i5.GoogleAuthRepository>(_i6.GoogleAuthRepositoryImpl(
      googleAuthDataSource: get<_i3.GoogleAuthDataSource>()));
  gh.factory<_i7.HomeBloc>(() => _i7.HomeBloc());
  gh.singleton<_i8.LogOutUseCase>(
      _i8.LogOutUseCase(authRepository: get<_i5.GoogleAuthRepository>()));
  gh.singleton<_i9.LoginUseCase>(
      _i9.LoginUseCase(authRepository: get<_i5.GoogleAuthRepository>()));
  gh.singleton<_i10.TodosDataSource>(_i11.TodosDataSourceImpl());
  gh.singleton<_i12.TodosRepository>(_i13.TodosRepositoryImpl(
      googleAuthDataSource: get<_i3.GoogleAuthDataSource>(),
      todosDataSource: get<_i10.TodosDataSource>()));
  gh.singleton<_i14.UpdateTodoUseCase>(
      _i14.UpdateTodoUseCase(todosRepository: get<_i12.TodosRepository>()));
  gh.singleton<_i15.AddTodoUseCase>(
      _i15.AddTodoUseCase(todosRepository: get<_i12.TodosRepository>()));
  gh.singleton<_i16.WatchTodosUseCase>(
      _i16.WatchTodosUseCase(todosRepository: get<_i12.TodosRepository>()));
  gh.singleton<_i17.GetUserUseCase>(_i17.GetUserUseCase(
      googleAuthRepository: get<_i5.GoogleAuthRepository>()));
  gh.factory<_i18.LoginBloc>(() => _i18.LoginBloc(
      loginUseCase: get<_i9.LoginUseCase>(),
      getUserUseCase: get<_i17.GetUserUseCase>(),
      logOutUseCase: get<_i8.LogOutUseCase>()));
  gh.factory<_i19.TodosBloc>(() => _i19.TodosBloc(
      watchTodosUseCase: get<_i16.WatchTodosUseCase>(),
      updateTodoUseCase: get<_i14.UpdateTodoUseCase>()));
  gh.factory<_i20.AddTodoBloc>(
      () => _i20.AddTodoBloc(addTodoUseCase: get<_i15.AddTodoUseCase>()));
  return get;
}
