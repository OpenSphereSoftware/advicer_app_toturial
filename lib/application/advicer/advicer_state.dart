part of 'advicer_bloc.dart';


abstract class AdvicerState extends Equatable {}

class AdviceStateInitial extends AdvicerState {
  @override
  List<Object?> get props => [];
}

class AdviceStateLoading extends AdvicerState {
  @override
  List<Object?> get props => [];
}

class AdviceStateLoaded extends AdvicerState {
  final AdviceEntity advice;
  @override
  List<Object?> get props => [advice];

  AdviceStateLoaded({required this.advice});
}

class AdviceStateFailure extends AdvicerState {
  @override
  List<Object?> get props => [];
}