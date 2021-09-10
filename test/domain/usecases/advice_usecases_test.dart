import 'package:advicer/core/failures/failures.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/domain/repositories/advice/advice_repository.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateMocks([AdviceRepository])
void main() {
  late AdvicerUsecases advicerUsecases;
  late MockAdviceRepository mockAdviceRepository;

  setUp(() {
    mockAdviceRepository = MockAdviceRepository();
    advicerUsecases = AdvicerUsecases(advicerRepository: mockAdviceRepository);
  });

  final tAdvice = AdviceEntity(advice: "tesst", id: 1);

  test("should get advice from repository", () async {
    //arrange
    when(mockAdviceRepository.getRandomAdviceFromAPI())
        .thenAnswer((_) async => Right(tAdvice));

    //act
    final result = await advicerUsecases.getAdviceUsecase();

    //assert
    expect(result, Right(tAdvice));
    verify(mockAdviceRepository.getRandomAdviceFromAPI());
    verifyNoMoreInteractions(mockAdviceRepository);
  });

  test("should return same Failure as repository", () async {
    //arrange
    when(mockAdviceRepository.getRandomAdviceFromAPI())
        .thenAnswer((_) async => Left(ServerFailure()));

    //act
    final result = await advicerUsecases.getAdviceUsecase();

    //assert
    expect(result, Left(ServerFailure()));
    verify(mockAdviceRepository.getRandomAdviceFromAPI());
    verifyNoMoreInteractions(mockAdviceRepository);
  });
}
