part of 'advice_bloc.dart';

@immutable
sealed class AdviceEvent extends Equatable {
  const AdviceEvent();

  @override
  List<Object> get props => [];
}

final class LoadAdvice extends AdviceEvent {}
