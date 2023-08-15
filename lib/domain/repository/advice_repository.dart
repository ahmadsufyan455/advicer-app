import 'package:advicer_app/domain/entity/advice_entity.dart';
import 'package:advicer_app/domain/failure/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AdviceRepository {
  Future<Either<Failure, AdviceEntity>> getAdviceFromApi();
}
