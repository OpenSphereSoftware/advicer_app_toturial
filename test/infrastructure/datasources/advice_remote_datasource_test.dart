import 'dart:convert';

import 'package:advicer/core/exceptions/exceptions.dart';
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
    final tAdviceModel =
        AdviceModel.fromJson(json.decode(fixture('advice_slip.json')));

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

    test(
      'should return Advice when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result =
            await adviceRemoteDatasourceImplementation.getRandomAdviceFromAPI();
        // assert
        expect(result, equals(tAdviceModel));
      },
    );

     test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final call = adviceRemoteDatasourceImplementation.getRandomAdviceFromAPI;
        // assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
