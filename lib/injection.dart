import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'application/advice/advice_bloc.dart';
import 'application/theme/theme_service.dart';
import 'domain/repositories/advice/advice_repository.dart';
import 'domain/repositories/theme/theme_repository.dart';
import 'domain/usecases/advicer_usecases.dart';
import 'domain/usecases/theme_usecases.dart';
import 'infrastructure/datasources/advice_remote_datasource.dart';
import 'infrastructure/datasources/theme_local_datasource.dart';
import 'infrastructure/respositories/advice_repository_impl.dart';
import 'infrastructure/respositories/theme/theme_repositroy_implementation.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async {

  //? ##################### advicer ##################### 

  //! state management
  sl..registerFactory(() => AdviceBloc(adviceUsecases: sl()))
  //! Use cases
  ..registerLazySingleton(() => AdvicerUsecases(advicerRepository: sl()))
  //! Repositories
  ..registerLazySingleton<AdviceRepository>(() => AdviceRepositoryImpl(adviceRemoteDatasource: sl()))
  //! data sources
  ..registerLazySingleton<AdviceRemoteDatasource>(() => AdviceRemoteDatasourceImplementation(client: sl()))
  //! External
  ..registerLazySingleton(() => http.Client())

  
  //? ##################### theme #####################

  //! state management
  ..registerLazySingleton<ThemeService>(() => ThemeServiceImpl(themeUsecases: sl()))
  //! usecases
 
  ..registerLazySingleton(() => ThemeUsecases(themeRepository: sl()))
  //! repositories
  ..registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(themeLocalDatasource: sl()) )
  //! datasources
  ..registerLazySingleton<ThemeLocalDatasource>(() => ThemeLocalDatasourceImpl(sharedPreferences: sl()));
  //! external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);




}
