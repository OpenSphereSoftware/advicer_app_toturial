import 'package:flutter/material.dart';

import '../../domain/usecases/theme_usecases.dart';

abstract class ThemeService extends ChangeNotifier {
  bool isDarkModeOn = true;
  Future<void> toggleTheme();
  Future<void> setTheme({required bool darkMode});
  Future<void> init();
}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService {
  final ThemeUsecases themeUsecases;

  ThemeServiceImpl({required this.themeUsecases});

  @override
  Future<void> toggleTheme() async {
    isDarkModeOn = !isDarkModeOn;
    await setTheme(darkMode: isDarkModeOn);
  }

  @override
  Future<void> setTheme({required bool darkMode}) async {
    isDarkModeOn = darkMode;
    notifyListeners();
    await themeUsecases.setThemeMode(mode: isDarkModeOn);
  }

  @override
  Future<void> init() async {
    final modeOrFailure = await themeUsecases.getThemeMode();

    await modeOrFailure.fold((failure) => setTheme(darkMode: true),
        (mode) => setTheme(darkMode: mode));
  }

  @override
  bool isDarkModeOn = true;
}
