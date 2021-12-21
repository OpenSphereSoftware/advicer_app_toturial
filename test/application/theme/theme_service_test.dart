import 'package:advicer/application/theme/theme_service.dart';
import 'package:advicer/domain/usecases/theme_usecases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_service_test.mocks.dart';

@GenerateMocks([ThemeUsecases])
void main() {
  late ThemeService themeService;
  late MockThemeUsecases mockThemeUsecases;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockThemeUsecases = MockThemeUsecases();

    themeService = ThemeServiceImpl(themeUsecases: mockThemeUsecases)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('check if default value for darkmode is -> true', () {
    expect(themeService.isDarkModeOn, true);
  });

  group('toggle theme mode', () {
    final t_mode = true;

    test("should toggle theme mode and notify listeners", () {
      // arrange
      themeService.isDarkModeOn = t_mode;
      when(mockThemeUsecases.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // act
      themeService.toggleTheme();

      // assert
      expect(themeService.isDarkModeOn, !t_mode);
      expect(listenerCallCount, 1);
      verify(mockThemeUsecases.setThemeMode(mode: !t_mode));
    });
  });

  group('change theme mode to specific', () {});

  group('init theme service', () {});
}
