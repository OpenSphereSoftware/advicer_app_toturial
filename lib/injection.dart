import 'package:advicer/application/advice/advice_bloc.dart';
import 'package:advicer/domain/repositories/advice_repository.dart';
import 'package:advicer/infrastructure/remote_datasource/advice_remote_datasource.dart';
import 'package:advicer/infrastructure/respositories/advice_repository_impl.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.I; // sl == service locator

Future<void> init() async {
//! BLoC's
  sl.registerFactory(() => AdviceBloc(adviceRepository: sl()));

//! Use cases

//! Repositories
  sl.registerLazySingleton<AdviceRepository>(
      () => AdviceRepositoryImpl(adviceRemoteDatasource: sl()));

//! data sources
  sl.registerLazySingleton<AdviceRemoteDatasource>(
      () => AdviceRemoteDatasourceImplementation(client: sl()));

//! core

//! External
  sl.registerLazySingleton(() => http.Client());
}
