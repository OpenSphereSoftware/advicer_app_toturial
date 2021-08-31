import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:advicer/domain/entities/advice_enitity.dart';
import 'package:advicer/domain/repositories/advice_repository.dart';
import 'package:advicer/infrastructure/respositories/advice_repository_impl.dart';
import 'package:meta/meta.dart';

part 'advice_event.dart';
part 'advice_state.dart';

class AdviceBloc extends Bloc<AdviceEvent, AdviceState> {
  AdviceBloc() : super(AdviceInitial());

  final AdviceRepository adviceRepository = AdviceRepositoryImpl();

  /*Future sleep1() {
    return new Future.delayed(const Duration(seconds: 1), () => "1");
  }*/

  @override
  Stream<AdviceState> mapEventToState(
    AdviceEvent event,
  ) async* {
    if (event is AdviceRequested) {
      yield AdviceLoading();

      try {
        final adviceOrFailure = await adviceRepository.getAdvice();

        yield adviceOrFailure.fold((failure) => AdviceLoading(),
            (advice) => AdviceLoaded(advice: advice));
      } catch (e) {
        print(e);
        yield AdviceFailure();
      }
    }
  }
}
