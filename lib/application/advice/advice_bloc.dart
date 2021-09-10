import 'dart:async';

import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
