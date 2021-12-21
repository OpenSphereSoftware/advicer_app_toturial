import 'package:dartz/dartz.dart';

import '../../core/failures/failures.dart';
import '../repositories/theme/theme_repository.dart';

class ThemeUsecases {
  final ThemeRepository themeRepository;
  ThemeUsecases({required this.themeRepository});

  Future<Either<Failure, bool>> getThemeMode() {
    return themeRepository.getThemeMode();
  }

  Future<void> setThemeMode({required bool mode}) {
    return themeRepository.setThemeMode(mode: mode);
  }
}
