import 'package:advicer/application/cubit/advicer_cubit_cubit.dart';
import 'package:advicer/core/failures/failures.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'advice_bloc_test.mocks.dart';

main() {
  late AdvicerCubitCubit advicerCubit;
  late MockAdvicerUsecases mockAdvicerUsecases;

  setUp(() {
    mockAdvicerUsecases = MockAdvicerUsecases();
    advicerCubit = AdvicerCubitCubit(adviceUsecases: mockAdvicerUsecases);
  });

  group('Advice Cubit', () {
    final tAdvice = AdviceEntity(advice: 'test', id: 1);
    blocTest('emits nothing when nothing is added & init state',
        build: () => advicerCubit,
        expect: () => [],
        verify: (_) {
          expect(advicerCubit.state, equals(AdvicerCubitInitial()));
        });


    //! expect and verify
    blocTest('emits loading & loaded in order when getAdvice is called ',
        setUp: () {
          when(mockAdvicerUsecases.getAdviceUsecase())
              .thenAnswer((_) async => Right(tAdvice));
        },
        build: () => advicerCubit,
        act: (bloc) => advicerCubit.getAdvice(),
        //!errors: () => [isA<Exception>()]
        expect: () =>
            [AdvicerCubitLoading(), AdvicerCubitLoaded(advice: tAdvice)],
        verify: (_) {
           verify(mockAdvicerUsecases.getAdviceUsecase());
        });
        

    //! seed the test
    blocTest(
      'emits loading & failure in order when getAdvice is called',
      setUp: () {
        when(mockAdvicerUsecases.getAdviceUsecase())
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => advicerCubit,
      act: (bloc) => advicerCubit.getAdvice(),
      //! seed: () => AdvicerCubitLoading(), addd initial state
      expect: () => [AdvicerCubitLoading(), AdvicerCubitFailure()],
    );

    //! skip some zwischenstate
    blocTest(
      'emits failure last when getAdvice is called',
      setUp: () {
        when(mockAdvicerUsecases.getAdviceUsecase())
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => advicerCubit,
      act: (bloc) => advicerCubit.getAdvice(),
      skip: 1,
      expect: () => [AdvicerCubitFailure()],
    );
  });
}
