import 'package:advicer/application/advice/advice_bloc.dart';
import 'package:advicer/core/failures/failures.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_bloc_test.mocks.dart';

@GenerateMocks([AdvicerUsecases])
void main() {
  late AdviceBloc bloc;
  late MockAdvicerUsecases mockAdvicerUsecases;

  setUp(() {
    mockAdvicerUsecases = MockAdvicerUsecases();
    bloc = AdviceBloc(adviceUsecases: mockAdvicerUsecases);
  });

  test('initialState should be AdviceStateInitial', () {
    // assert
    expect(bloc.state, equals(AdviceStateInitial()));
  });

  group('RequestRandomAdvice', () {
    final tAdvice = AdviceEntity(advice: 'test', id: 1);

    test('should call usecase to get random advice if event is added',
        () async {
      // arange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(tAdvice));

      // act
      bloc.add(AdviceRequested());
      await untilCalled(mockAdvicerUsecases.getAdviceUsecase());

      // assert
      verify(mockAdvicerUsecases.getAdviceUsecase());
    });

    test('should emmit the Loading and then the Loaded state after event add',
        () async {
      // arange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Right(tAdvice));

      // assert later
      final expected = [
        //AdviceStateInitial(), //! achtung   ist initial state
        AdviceStateLoading(),
        AdviceStateLoaded(advice: tAdvice)
      ];
      await expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(AdviceRequested());
    });

     test('should emmit the Loading and then the Error state if Usecase fails',
        () async {
      // arange
      when(mockAdvicerUsecases.getAdviceUsecase())
          .thenAnswer((_) async => Left(ServerFailure()));

      // assert later
      final expected = [
        //AdviceStateInitial(), //! achtung   ist initial state
        AdviceStateLoading(),
        AdviceStateFailure()  //TODO failure messqge im bloc in constante packen
      ];
      await expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(AdviceRequested());
    });

    //  TODO(maxberktold) : selben test nochmal mit general failure und anderer Message.
  });
}
