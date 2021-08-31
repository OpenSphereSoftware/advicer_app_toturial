part of 'advice_bloc.dart';

@immutable
abstract class AdviceState {}

class AdviceInitial extends AdviceState {}

class AdviceLoading extends AdviceState {}

class AdviceLoaded extends AdviceState {
  final AdviceEntity advice;

  AdviceLoaded({required this.advice});
}


class AdviceFailure extends AdviceState {}