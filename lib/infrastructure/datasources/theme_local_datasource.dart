import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/exceptions.dart';

abstract class ThemeLocalDatasource {
  Future<bool> getCachedThemeMode();

  Future<void> cacheThemeMode({required bool mode});
}

const CACHED_THEME_MODE = 'CACHED_THEME_MODE';

class ThemeLocalDatasourceImpl implements ThemeLocalDatasource {
  final SharedPreferences sharedPreferences;

  ThemeLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<bool> getCachedThemeMode() {
    final modeBool = sharedPreferences.getBool(CACHED_THEME_MODE);
    if (modeBool != null) {
      return Future.value(modeBool);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheThemeMode({required bool mode}) {
    return sharedPreferences.setBool(
      CACHED_THEME_MODE,
      mode,
    );
  }
}
