import 'package:advicer_app/application/pages/advice/bloc/advice_bloc.dart';
import 'package:advicer_app/domain/entity/advice_entity.dart';
import 'package:advicer_app/domain/failure/failures.dart';
import 'package:advicer_app/domain/usecases/advice_usescases.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceUseCases>()])
void main() {
  group('AdviceBloc', () {
    group('should emits', () {
      final mockAdviceUseCase = MockAdviceUseCases();
      blocTest<AdviceBloc, AdviceState>(
        'nothing when no even is added',
        build: () => AdviceBloc(adviceUseCases: mockAdviceUseCase),
        expect: () => <AdviceState>[],
      );

      blocTest(
        'should emits [loading, loaded]',
        setUp: () => when(mockAdviceUseCase.getAdvice()).thenAnswer(
          (invocation) => Future.value(
            const Right<Failure, AdviceEntity>(
              AdviceEntity(advice: 'advice', id: 1),
            ),
          ),
        ),
        build: () => AdviceBloc(adviceUseCases: mockAdviceUseCase),
        act: (bloc) => bloc.add(LoadAdvice()),
        expect: () => <AdviceState>[
          AdviceLoading(),
          const AdviceLoaded(advice: 'advice'),
        ],
      );
    });
  });
}
