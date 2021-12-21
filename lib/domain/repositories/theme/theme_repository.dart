import 'package:dartz/dartz.dart';

import '../../../core/failures/failures.dart';

abstract class ThemeRepository {
  Future<Either<Failure,bool>> getThemeMode();

  Future<void> setThemeMode({required bool mode});
}
