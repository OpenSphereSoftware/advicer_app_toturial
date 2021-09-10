import 'dart:convert';

import 'package:advicer/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_reader.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late AdviceRemoteDatasourceImplementation
      adviceRemoteDatasourceImplementation;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    adviceRemoteDatasourceImplementation =
        AdviceRemoteDatasourceImplementation(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(fixture('advice.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
     when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("something went wrong", 404));
  }

  // test the get random advice from api function
  group('getRandomAdvice', () {


    test(
      '''should perform a GET request on a URL with advice
       being the endpoint and with application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        adviceRemoteDatasourceImplementation.getRandomAdviceFromAPI();
        // assert
        verify(mockHttpClient.get(
          Uri.parse("https://api.adviceslip.com/advice"),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );
  });
}
