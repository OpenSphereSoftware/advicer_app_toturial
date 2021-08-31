import 'package:advicer/core/failures/failures.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:dartz/dartz.dart';

abstract class AdviceRepository {
  Future<Either<Failure, AdviceEntity>> getAdvice();
}


