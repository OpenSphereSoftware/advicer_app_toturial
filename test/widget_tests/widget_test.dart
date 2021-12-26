// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:advicer/application/cubit/advicer_cubit_cubit.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/main.dart';
import 'package:advicer/presentation/advice/advice_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

//@GenerateMocks([AdvicerCubitCubit, ThemeService])
class MockCubitPackageTest extends MockCubit<AdvicerCubitState>
    implements AdvicerCubitCubit {}

void main() {
  // Create a mock instance

  late MockCubitPackageTest mockAdvicerCubit;
  late MockThemeService mockThemeService;

  setUp(() {
    mockAdvicerCubit = MockCubitPackageTest();
    mockThemeService = MockThemeService();
  });

  final tAdvice = AdviceEntity(advice: 'test', id: 1);

// Stub the state stream
/*  whenListen(
    advicerBloc,
    Stream.fromIterable([
      AdvicerCubitInitial(),
      AdvicerCubitLoading(),
      AdvicerCubitLoaded(advice: tAdvice)
    ]),

  );*/

  testWidgets('Check if advicer Page displays Adivice if Bloc State is Loaded(test_advice)', (WidgetTester tester) async {
    final findStartText = find.text(AdvicePage.startText);
    final findErrorMessage = find.byKey(const Key(AdvicePage.errorMessageKey));
    final findButton = find.byKey(const Key("customButton"));
    final findAppbar = find.byType(AppBar);
    final findProgressIndicator = find.byType(CircularProgressIndicator);
    final findsAdvice = find.byKey(const Key(AdvicePage.adviceFieldKey));
    final findsAdviceText = find.textContaining("test");

    when(mockThemeService.isDarkModeOn).thenReturn(true);

    whenListen(
        mockAdvicerCubit,
        Stream.fromIterable(
          [AdvicerCubitLoading(), AdvicerCubitLoaded(advice: tAdvice)],
        ),
        initialState: AdvicerCubitInitial());

    // Build our app and trigger a frame.
    await tester.pumpWidget(InjectProviders(
      themeService: mockThemeService,
      child: AppConfig(
        home: AdvicePage(
          adviceCubit: mockAdvicerCubit,
        ),
      ),
    ));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // find advice
    expect(findStartText, findsNothing);
    expect(findErrorMessage, findsNothing);
    expect(findButton, findsOneWidget);
    expect(findAppbar, findsOneWidget);
    expect(findProgressIndicator, findsNothing);
    expect(findsAdvice, findsOneWidget);
    expect(findsAdviceText, findsOneWidget);
  });
}
