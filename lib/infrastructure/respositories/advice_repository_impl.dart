import 'package:advicer/core/exceptions/exceptions.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/core/failures/failures.dart';
import 'package:advicer/domain/repositories/advice_repository.dart';
import 'package:advicer/infrastructure/remote_datasource/advice_remote_datasource.dart';
import 'package:dartz/dartz.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdviceRemoteDatasource adviceRemoteDatasource;

  AdviceRepositoryImpl({required this.adviceRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    try {
      final remoteAdvice = await adviceRemoteDatasource.getRandomAdvice();
      return Right(remoteAdvice);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
