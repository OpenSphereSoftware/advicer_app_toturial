import 'package:advicer/main.dart';
import 'package:advicer/presentation/advice/advice_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:integration_test/integration_test.dart';

import 'package:advicer/main.dart' as app;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  MockClient client = MockClient();
  when(client.get(any)).thenAnswer((invocation) => Future.value(
      Response('{"slip": { "id": 100, "advice": "Test Advice"}}', 200)));

  testWidgets(
      "started the app and then taps on button to get Advice - wtih success from network"
      "then waits 2s and changes the theme of the ui from dark to light",
      (WidgetTester tester) async {
    final findStartText = find.text(AdvicePage.startText);
    final findErrorMessage = find.byKey(const Key(AdvicePage.errorMessageKey));
    final findButton = find.byKey(const Key("customButton"));
    final findAppbar = find.byType(AppBar);
    final findProgressIndicator = find.byType(CircularProgressIndicator);
    final findsAdvice = find.byKey(const Key(AdvicePage.adviceFieldKey));
    final findsAdviceText = find.textContaining("Test Advice");



    // init
    await app.initializeApp(client: client);
    await tester.pumpWidget(const MyAppRoot());
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});

    // find stat screen
    expect(findStartText, findsOneWidget);
    expect(findErrorMessage, findsNothing);
    expect(findButton, findsOneWidget);
    expect(findAppbar, findsOneWidget);
    expect(findProgressIndicator, findsNothing);
    expect(findsAdvice, findsNothing);

    // tap Button
    await tester.tap(findButton);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});

    // find advice
    expect(findStartText, findsNothing);
    expect(findErrorMessage, findsNothing);
    expect(findButton, findsOneWidget);
    expect(findAppbar, findsOneWidget);
    expect(findProgressIndicator, findsNothing);
    expect(findsAdvice, findsOneWidget);
    expect(findsAdviceText, findsOneWidget);

    // find dark Theme
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Scaffold &&
            widget.backgroundColor == Colors.blueGrey.shade900),
        findsOneWidget);

    // changeTheme
    await tester.tap(find.byType(Switch).first);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});

    // find light Theme
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Scaffold &&
            widget.backgroundColor == Colors.blueGrey.shade50),
        findsOneWidget);
  });
}
