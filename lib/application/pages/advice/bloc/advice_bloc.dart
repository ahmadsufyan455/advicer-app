import 'package:advicer_app/domain/failure/failures.dart';
import 'package:advicer_app/domain/usecases/advice_usescases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'advice_event.dart';
part 'advice_state.dart';

const generalFailureMessage = 'Something gone wrong, please try again';
const serverFailureMessage = 'Opps server error, we will fix it';
const cacheFailureMessage = 'Oppss cache failed, please try again';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  final AdviceUseCases adviceUseCases;
  AdviceBloc({required this.adviceUseCases}) : super(AdviceInitial()) {
    on<LoadAdvice>((event, emit) async {
      emit(AdviceLoading());
      final advice = await adviceUseCases.getAdvice();
      advice.fold(
        (failure) => emit(AdviceError(error: _mapFailureToMessage(failure))),
        (advice) => emit(AdviceLoaded(advice: advice.advice)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}
