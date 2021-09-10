part of 'advice_bloc.dart';

@immutable
abstract class AdviceState extends Equatable {}

class AdviceStateInitial extends AdviceState {
  @override
  List<Object?> get props => [];
}

class AdviceStateLoading extends AdviceState {
  @override
  List<Object?> get props => [];
}

class AdviceStateLoaded extends AdviceState {
  final AdviceEntity advice;
  @override
  List<Object?> get props => [advice];

  AdviceStateLoaded({required this.advice});
}

class AdviceStateFailure extends AdviceState {
  @override
  List<Object?> get props => [];
}
