import 'package:advicer/core/failures/failures.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';

import 'package:advicer/domain/repositories/advice/advice_repository.dart';
import 'package:dartz/dartz.dart';

class AdvicerUsecases {
  final AdviceRepository advicerRepository;
  AdvicerUsecases({required this.advicerRepository});


  Future<Either<Failure, AdviceEntity>> getAdviceUsecase() async {
    // call function from repository to get advice
    return advicerRepository.getRandomAdviceFromAPI();

    // Buisness logic implementieren z.b. rechnung etc
  }
}
