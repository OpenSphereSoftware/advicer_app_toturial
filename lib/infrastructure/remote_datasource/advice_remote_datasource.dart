import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/core/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class AdviceRemoteDatasource {
  /// requests a random advice from free api
  /// throws a [server Exception] for all error codes
  Future<AdviceEntity> getRandomAdvice();
}

class AdviceRemoteDatasourceImplementation implements AdviceRemoteDatasource {
  final http.Client client;

  AdviceRemoteDatasourceImplementation({required this.client});

  @override
  Future<AdviceEntity> getRandomAdvice() async {
    final response = await client.get(
      Uri.parse("https://api.adviceslip.com/advice"),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return AdviceModel.fromJson(responseBody["slip"]);
    } else {
      throw ServerException();
    }
  }
}
