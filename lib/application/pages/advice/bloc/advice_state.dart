part of 'advice_bloc.dart';

@immutable
sealed class AdviceState extends Equatable {
  const AdviceState();

  @override
  List<Object> get props => [];
}

final class AdviceInitial extends AdviceState {}

final class AdviceLoading extends AdviceState {}

final class AdviceLoaded extends AdviceState {
  final String advice;
  const AdviceLoaded({required this.advice});

  @override
  List<Object> get props => [advice];
}

final class AdviceError extends AdviceState {
  final String error;
  const AdviceError({required this.error});

  @override
  List<Object> get props => [error];
}
