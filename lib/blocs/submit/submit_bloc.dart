import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'submit_event.dart';
part 'submit_state.dart';

enum SubmitStatus {
  processing,
  succeeded,
  failed,
  unknown,
}

class SubmitBloc extends Bloc<SubmitEvent, SubmitState> {

  SubmitBloc () : super(
    const SubmitState.unknown(),
  ) {
    on<SubmitAnswerRequest>(_onSubmitAnswerRequest);
  }

  void _onSubmitAnswerRequest (SubmitAnswerRequest event, Emitter<SubmitState> emit) async {
    emit(const SubmitState.processing(),);
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const SubmitState.succeeded());
    } catch (_) {
      emit(SubmitState.failed(
        error: _.toString(),
      ));
    }
  }
}


