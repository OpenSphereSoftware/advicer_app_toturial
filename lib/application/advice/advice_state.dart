part of 'advice_bloc.dart';

@immutable
abstract class AdviceState {}

class AdviceStateInitial extends AdviceState {}

class AdviceStateLoading extends AdviceState {}

class AdviceStateLoaded extends AdviceState {
  final AdviceEntity advice;

  AdviceStateLoaded({required this.advice});
}


class AdviceStateFailure extends AdviceState {}