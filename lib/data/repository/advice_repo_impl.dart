import 'package:advicer_app/data/datasource/remote_datasource.dart';
import 'package:advicer_app/data/exception/exception.dart';
import 'package:advicer_app/domain/entity/advice_entity.dart';
import 'package:advicer_app/domain/failure/failures.dart';
import 'package:advicer_app/domain/repository/advice_repository.dart';
import 'package:dartz/dartz.dart';

class AdviceRepositoryImpl implements AdviceRepository {
  final RemoteDataSource remoteDataSource;
  AdviceRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi() async {
    try {
      final result = await remoteDataSource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (_) {
      return left(GeneralFailure());
    }
  }
}
