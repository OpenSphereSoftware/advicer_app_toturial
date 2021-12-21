import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';
import '../../../domain/repositories/theme/theme_repository.dart';
import '../../datasources/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;

  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    try {
      final themeMode = await themeLocalDatasource.getCachedThemeMode();
      return Right(themeMode);
    } catch (e) {
      return Left(ThemeCacheFailure());
    }
  }

  @override
  Future<void> setThemeMode({required bool mode})  {
    return themeLocalDatasource.cacheThemeMode(mode: mode);
  }
}
