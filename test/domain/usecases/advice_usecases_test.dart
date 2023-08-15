import 'package:advicer_app/data/repository/advice_repo_impl.dart';
import 'package:advicer_app/domain/entity/advice_entity.dart';
import 'package:advicer_app/domain/failure/failures.dart';
import 'package:advicer_app/domain/usecases/advice_usescases.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepositoryImpl>()])
void main() {
  group('AdviceUseCases', () {
    group('should return AdviceEntity', () {
      test('when AdviceRepoImpl return AdviceModel', () async {
        final mockAdviceRepoImpl = MockAdviceRepositoryImpl();
        final adviceUseCasesUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromApi()).thenAnswer(
            (realInvocation) =>
                Future.value(const Right(AdviceEntity(id: 1, advice: 'test'))));

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            const Right<Failure, AdviceEntity>(
                AdviceEntity(id: 1, advice: 'test')));
        verify(mockAdviceRepoImpl.getAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });

    group('should return left with', () {
      test('a ServerFailure', () async {
        final mockAdviceRepoImpl = MockAdviceRepositoryImpl();
        final adviceUseCasesUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromApi()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
        verify(mockAdviceRepoImpl.getAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });

      test('a GeneralFailure', () async {
        final mockAdviceRepoImpl = MockAdviceRepositoryImpl();
        final adviceUseCasesUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromApi()).thenAnswer(
            (realInvocation) => Future.value(Left(GeneralFailure())));

        final result = await adviceUseCasesUnderTest.getAdvice();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
        verify(mockAdviceRepoImpl.getAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });
  });
}
