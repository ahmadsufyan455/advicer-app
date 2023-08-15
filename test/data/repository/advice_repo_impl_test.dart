import 'dart:io';

import 'package:advicer_app/data/datasource/remote_datasource.dart';
import 'package:advicer_app/data/exception/exception.dart';
import 'package:advicer_app/data/model/advice_model.dart';
import 'package:advicer_app/data/repository/advice_repo_impl.dart';
import 'package:advicer_app/domain/entity/advice_entity.dart';
import 'package:advicer_app/domain/failure/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RemoteDataSourceImpl>()])
void main() {
  group('AdviceRepoImpl', () {
    group('should return AdviceEntity', () {
      test('when RemoteDataSource return AdviceModel', () async {
        final mockRemoteDataSource = MockRemoteDataSourceImpl();
        final adviceRepoUnderTest =
            AdviceRepositoryImpl(remoteDataSource: mockRemoteDataSource);

        when(mockRemoteDataSource.getRandomAdviceFromApi()).thenAnswer(
            (realInvocation) =>
                Future.value(AdviceModel(advice: 'test', id: 1)));

        final result = await adviceRepoUnderTest.getAdviceFromApi();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        verify(mockRemoteDataSource.getRandomAdviceFromApi()).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
    });

    group('should return left with', () {
      test('a ServerFailuer when a ServerException occurs', () async {
        final mockRemoteDataSource = MockRemoteDataSourceImpl();
        final adviceRepoUnderTest =
            AdviceRepositoryImpl(remoteDataSource: mockRemoteDataSource);

        when(mockRemoteDataSource.getRandomAdviceFromApi())
            .thenThrow(ServerException());

        final result = await adviceRepoUnderTest.getAdviceFromApi();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
      });

      test('a GeneralFailure on all other Exception', () async {
        final mockRemoteDataSource = MockRemoteDataSourceImpl();
        final adviceRepoUnderTest =
            AdviceRepositoryImpl(remoteDataSource: mockRemoteDataSource);

        when(mockRemoteDataSource.getRandomAdviceFromApi())
            .thenThrow(const SocketException('test'));

        final result = await adviceRepoUnderTest.getAdviceFromApi();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
      });
    });
  });
}
