import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/domain/repositories/advice_repository.dart';
import 'package:meta/meta.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  final AdviceRepository adviceRepository;

  AdviceBloc({required this.adviceRepository}) : super(AdviceStateInitial());

  /*Future sleep1() {
    return new Future.delayed(const Duration(seconds: 1), () => "1");
  }*/

  @override
  Stream<AdviceState> mapEventToState(
    AdviceEvent event,
  ) async* {
    if (event is AdviceRequested) {
      yield AdviceStateLoading();

      try {
        final adviceOrFailure = await adviceRepository.getAdvice();

        yield adviceOrFailure.fold((failure) => AdviceStateLoading(),
            (advice) => AdviceStateLoaded(advice: advice));
      } catch (e) {
        print(e);
        yield AdviceStateFailure();
      }
    }
  }
}
