import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/advice_enitity.dart';
import '../../domain/usecases/advicer_usecases.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  final AdvicerUsecases adviceUsecases;

  AdviceBloc({required this.adviceUsecases}) : super(AdviceStateInitial());

  /*Future sleep1() {
    return new Future.delayed(const Duration(seconds: 1), () => "1");
  }*/

  @override
  Stream<AdviceState> mapEventToState(
    AdviceEvent event,
  ) async* {
    if (event is AdviceRequested) {
      yield AdviceStateLoading();

      final adviceOrFailure = await adviceUsecases.getAdviceUsecase();

      yield adviceOrFailure.fold((failure) => AdviceStateFailure(),
          (advice) => AdviceStateLoaded(advice: advice));
    }
  }
}
