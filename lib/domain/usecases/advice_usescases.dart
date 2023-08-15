import 'package:advicer_app/domain/entity/advice_entity.dart';
import 'package:advicer_app/domain/failure/failures.dart';
import 'package:advicer_app/domain/repository/advice_repository.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCases {
  final AdviceRepository adviceRepo;
  AdviceUseCases({required this.adviceRepo});
  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromApi();
  }
}
