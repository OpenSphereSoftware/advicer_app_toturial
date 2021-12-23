part of 'advicer_cubit_cubit.dart';

abstract class AdvicerCubitState extends Equatable {
  const AdvicerCubitState();
}

class AdvicerCubitInitial extends AdvicerCubitState {
  @override
  List<Object?> get props => [];
}

class AdvicerCubitLoading extends AdvicerCubitState {
  @override
  List<Object?> get props => [];
}

class AdvicerCubitLoaded extends AdvicerCubitState {
  final AdviceEntity advice;
  @override
  List<Object?> get props => [advice];

  const AdvicerCubitLoaded({required this.advice});
}

class AdvicerCubitFailure extends AdvicerCubitState {
  @override
  List<Object?> get props => [];
}
