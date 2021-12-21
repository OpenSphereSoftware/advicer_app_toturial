import 'dart:convert';

import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tAdviceModel = AdviceModel(advice: 'test', id: 1);

  test(
    'model should be a subclass of advice entity',
    () async {
      // assert
      expect(tAdviceModel, isA<AdviceEntity>());
    },
  );

  group('fromJson factory', () {
    test(
      'should return a valid model when the JSON advice is correct',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('advice_slip.json'));
        // act
        final result = AdviceModel.fromJson(jsonMap);
        // assert
        expect(result, tAdviceModel);
      },
    );
  });
}
