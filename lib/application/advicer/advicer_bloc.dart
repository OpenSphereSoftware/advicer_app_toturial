import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'advicer_event.dart';
part 'advicer_state.dart';

class AdvicerBloc extends Bloc<AdvicerEvent, AdvicerState> {
  final AdvicerUsecases adviceUsecases;

  AdvicerBloc({required this.adviceUsecases}) : super(AdviceStateInitial()) {

    on<AdviceRequested>((event, emit) async {
      emit(AdviceStateLoading());

      

      final adviceOrFailure = await adviceUsecases.getAdviceUsecase();

      emit(adviceOrFailure.fold((failure) => AdviceStateFailure(),
          (advice) => AdviceStateLoaded(advice: advice)));
    });


    
  }
}
