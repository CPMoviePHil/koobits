part of 'submit_bloc.dart';

abstract class SubmitEvent extends Equatable {
  const SubmitEvent();
  @override
  List<Object> get props => [];
}

class SubmitAnswerRequest extends SubmitEvent {

  const SubmitAnswerRequest({
    required this.id,
    required this.answer,
  });

  final String id;
  final String answer;
}
