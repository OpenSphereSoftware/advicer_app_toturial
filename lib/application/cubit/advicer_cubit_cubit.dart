import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'advicer_cubit_state.dart';

class AdvicerCubitCubit extends Cubit<AdvicerCubitState> {
  final AdvicerUsecases adviceUsecases;

  AdvicerCubitCubit({required this.adviceUsecases})
      : super(AdvicerCubitInitial());



  Future<void> getAdvice() async {
    emit(AdvicerCubitLoading());

    final adviceOrFailure = await adviceUsecases.getAdviceUsecase();

    emit(adviceOrFailure.fold((failure) => AdvicerCubitFailure(),
        (advice) => AdvicerCubitLoaded(advice: advice)));
  }

  


}
