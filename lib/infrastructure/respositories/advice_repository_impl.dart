import 'package:dartz/dartz.dart';

import '../../core/exceptions/exceptions.dart';
import '../../core/failures/failures.dart';
import '../../domain/entities/advice_enitity.dart';
import '../../domain/repositories/advice/advice_repository.dart';
import '../datasources/advice_remote_datasource.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final AdviceRemoteDatasource adviceRemoteDatasource;

  AdviceRepositoryImpl({required this.adviceRemoteDatasource});

  @override
  Future<Either<Failure, AdviceEntity>> getRandomAdviceFromAPI() async {
    try {
      final remoteAdvice = await adviceRemoteDatasource.getRandomAdviceFromAPI();
      return Right(remoteAdvice);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
