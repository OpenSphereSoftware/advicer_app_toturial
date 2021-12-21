import 'package:advicer/core/exceptions/exceptions.dart';
import 'package:advicer/core/failures/failures.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/domain/repositories/advice/advice_repository.dart';
import 'package:advicer/infrastructure/datasources/advice_remote_datasource.dart';
import 'package:advicer/infrastructure/models/advice_model.dart';
import 'package:advicer/infrastructure/respositories/advice_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_repository_impl_test.mocks.dart';


@GenerateMocks([AdviceRemoteDatasource])
void main() {
  late AdviceRepository adviceRepository;
  late MockAdviceRemoteDatasource mockAdviceRemoteDatasource;

  setUp(() {
    mockAdviceRemoteDatasource = MockAdviceRemoteDatasource();
    adviceRepository = AdviceRepositoryImpl(
        adviceRemoteDatasource: mockAdviceRemoteDatasource);
  });

  group('getRandomAdviceFromAPI', () {
    final tAdviceModel = AdviceModel(advice: 'test', id: 1);
    final AdviceEntity tAdvice = tAdviceModel;

    test(
      'should return remote data  when the call to remote data source is successful',
      () async {
        // arrange
        when(mockAdviceRemoteDatasource.getRandomAdviceFromAPI())
            .thenAnswer((_) async => tAdviceModel);
        // act
        final result = await adviceRepository.getRandomAdviceFromAPI();
        // assert
        verify(mockAdviceRemoteDatasource.getRandomAdviceFromAPI()); // verify if was processed
        expect(result, equals(Right(tAdvice))); // verify result
      },
    );


      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockAdviceRemoteDatasource.getRandomAdviceFromAPI())
              .thenThrow(ServerException());
          // act
          final result = await adviceRepository.getRandomAdviceFromAPI();
          // assert
          verify(mockAdviceRemoteDatasource.getRandomAdviceFromAPI());
          //verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
  


  });
}
