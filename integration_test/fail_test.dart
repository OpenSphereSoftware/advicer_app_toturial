import 'package:advicer/main.dart';
import 'package:advicer/presentation/advice/advice_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:integration_test/integration_test.dart';
import 'package:advicer/main.dart' as app;
import 'package:mockito/mockito.dart';

import 'app_test.mocks.dart';

main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final MockClient client = MockClient();

  

  testWidgets(
      "started the app and then taps on button to get Advice - with failure from network",
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

    // find start screen
    expect(findStartText, findsOneWidget);
    expect(findErrorMessage, findsNothing);
    expect(findButton, findsOneWidget);
    expect(findAppbar, findsOneWidget);
    expect(findProgressIndicator, findsNothing);
    expect(findsAdvice, findsNothing);

    when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (invocation) => Future.value(
            Response('{"slip": { "id": 404, "advice": "Call Failed"}}', 404)));

    /*when(client.get(any, headers: anyNamed('headers'))).thenAnswer((_) async =>
        Response('{"slip": { "id": 404, "advice": "Call Failed"}}', 404));*/

    // tap Button
    await tester.tap(findButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));  //! we can wait in here
  //!  await Future.delayed(const Duration(seconds: 2), () {});

    // find error message
    expect(findStartText, findsNothing);
    expect(findErrorMessage, findsOneWidget);
    expect(findButton, findsOneWidget);
    expect(findAppbar, findsOneWidget);
    expect(findProgressIndicator, findsNothing);
    expect(findsAdvice, findsNothing);
    expect(findsAdviceText, findsNothing);

    //client.response = GetResponseMode.advice;
    when(client.get(any, headers: anyNamed('headers'))).thenAnswer(
        (invocation) => Future.value(
            Response('{"slip": { "id": 100, "advice": "Test Advice"}}', 200)));

    // tap Button
    await tester.tap(findButton);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2), () {});
  });
}
